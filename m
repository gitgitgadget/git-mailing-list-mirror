Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B385242F6E3
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222662; cv=none; b=Lw3n9hz5LsCLT48t3tIYU5ZoXE23hQEjhqm+gR8yNDYYcD25a/nEVRk6WHibEFOyD3vG5E3UIuDCSghjHpRdpNoFDuWI01+ORG41XYCDk4Ny6VLJZFNg2t9RgfxZkQLMAftn4nve+1nsQfdh6gfnrwZt78W46GiS6kHtoxEs88k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222662; c=relaxed/simple;
	bh=NbPRS96q+PndVAT/lqMZqvp8SQZA+VHkMXQt/zVATC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CIBqLr+/JvqPzr/rSVy9tHJuB/qpZlKjpTPadUqtQcT9K4KoHLQwZRf9kR+7sJv2/MyNkaNp6WNTkECN0in3blWLTB/OWI0ulvL83qrHglrGh5ANiFU8ymcmkp8tZauc20lNUoNYzpZZx1zLIQNw2xUi9fk9zv/DVcJBaVtj4Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MtKp8kh4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RQxf935r; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MtKp8kh4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RQxf935r"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C21711400096;
	Thu, 16 Jul 2026 13:24:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jul 2026 13:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784222659; x=1784309059; bh=urkOrOrIPK
	KybJn7vFe8BkIAtwfk0J5MjZIhmJ3rBVU=; b=MtKp8kh42nPPAtHozwjh3UiGjI
	Peexu1vcxLELZBVm7Q3LOS5BmjEJ4DVK/ZzvngY7chW0ZzXsCCwqfS4/AgM9KuXp
	QXCop9P8m/MPmGDxeR6s0trW5cNAKr7iE+N0s9ZxyQ3kg2jAZ1Ymu/pD3f5i0eWQ
	WUFEqL6uEnmldhwUIb9Y5HMU94M01UJsk8uf5FZBtyTmkZfJR3wnsqLllzRrREzo
	y4lcaWj8n1bN/Q43Sy0BpMap9ACTho+Ir3cco1ZsuywkSC89Y3zQVVZu/Q4kvzBo
	hpJdRrAQWMWtg4HDxXaIA/rvSUWLibPSAiAK+xzfRIsKxQVqx5/ECDFyO8Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784222659; x=1784309059; bh=urkOrOrIPKKybJn7vFe8BkIAtwfk0J5MjZI
	hmJ3rBVU=; b=RQxf935rG2NmCT6KlncWknvXwywGXScbpaCEvT5Bwx+b9Zxq+0x
	Eu8e9CZT52RZPFxZIGSiqRyUs6a4LcRuF0GvvJeVJK7HEydFJEpPjfdlcOiZT9fs
	75wuQoWOTscp4BED+fCwen/LqqYw22ThppRhG4/dfNwVbfahqf4LbPd4dDuYjzBo
	0ntMlFDhxETMkm37dynQ7clsupw1azoGluTvr2P7TR22Cre0N3KYJKjmLWvHJSSW
	AA9SafRpo5ZPVnRWDYoulzqC6/WWbv7vLUHG8cgzuqhkiPXkqk2i6wWiV+A1FUDl
	rAsWeapqvXCbYHIKXpZ57iCr98ZDjGzjLkg==
X-ME-Sender: <xms:wxNZag-2vtIKqVWaZH4skmofsT9RU2bcmj6X868dV471Lq1UsU5Hvg>
    <xme:wxNZavnkxQX-VgKDs34w_2BwnBAsr-fWalWOkAnLK53ELfIzuyT38HCTSdS8i-BaG
    Jam2FabEsDQ6I9dhs8fGD0Ty4ApZh8qHDORYecD0SAM1Wj-LwoO>
X-ME-Received: <xmr:wxNZauXGmOe8FQ77G3EVJza-kfR1YyvtVu7KzjgU4c1Tx75CutEwwYZK-3BUixOJ-rbrF4sZ8GZ3DU4wia3yd_SIw9P9-E0Nx97Kzbo>
X-ME-Proxy-Cause: dmFkZTEcr4CJX/iYJ/acWNFes9MECY8R2bMlo6r3AnPxEuqlPhI3JsFJj++yWmt1lCrsd+
    8hQ2hr1wmugfJbtDqyZ76cvBCwM5/yl1ZXrP+mkWloipOvDjhzZMlTaXGFTPMWXHwH/ote
    D5eTZntSTqmR19HOOSojpRseozIOqdFpWgPRSCvbXAdCL4Ndd9i2vPQQ1gPbw6yLQ/yDqA
    E7m7ykNXSUQ7zdOZN6mBAm8uAMtFncJ2BhO7D/hpbIOSwgCxGFVKp1wSpxfRmwjGf6EZJE
    xxFlExzOX73RxnZ3fhF9uNnBvC/RNZbiof6+SJN5iprMJ9UDueRBwz6QDxdZvjOUwAYxDu
    ZPM6Eu/n3seoX26T0WCgSAoeTcF1xdQc7lAW0yc6iPRRcEHNTIHtcyr0IwuqrP9OPI4MFM
    qCkB3OmcGCZpwphgchS8Hx4Roymtyg2W2NSWCtXGfq6Ihn/VKJiRbxQCpTAANnulyWKqxx
    xzCDn8lsyS/PjG5HIKZxL3vi7ALRIWMo8fCphDwzCa9Ce5GI2vJ+/lpzTC6ezD5aSZhFgO
    uYuEhnPRFrMBVtI4fBcyIp/Jw+00oBQuEEHpXda5og4N/6vCPEp6G450J1lqhFqoZYo2L6
    7IGhae03t0eby3xWdRlaJsZzGDYYkxISWPG9iVTUC2SSy2l1FWvXUxXYK1rg
X-ME-Proxy: <xmx:wxNZasGXe1VGOeUIeKdSw6NZXQMPhDu_4Lcv0ln4sKGsfmVwwTXWVQ>
    <xmx:wxNZaifA-OjD__sweDWCuBaj2DluAnoljHSLeguxMSXYkj33hFBV2w>
    <xmx:wxNZalI0fagOQMMa2coUyLwadMx9yh5ADKgEQ5Q844IPCFr-x3GQZg>
    <xmx:wxNZavE6Iuh2UixzNX6_ONKNqlGzr3Ix7PMd850F03MGG4zrzOMomw>
    <xmx:wxNZajXVuxMA8rQmhTsV2ryLz-VuV9AEwjxN5uqG6tbUOd9ySBeCUQcA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 13:24:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  Harald Nordgren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] rebase: mention --abort alongside --continue
In-Reply-To: <4d150f21-46ea-4bf7-b516-c1763c152b34@gmail.com> (Phillip Wood's
	message of "Thu, 16 Jul 2026 10:37:22 +0100")
References: <pull.2330.git.git.1781551170529.gitgitgadget@gmail.com>
	<89d72342-5aa1-4dcf-951b-d0c791f91738@gmail.com>
	<xmqqpl1q2xw5.fsf@gitster.g>
	<bd7dc183-6597-4fd0-ae64-682d46480cd4@gmail.com>
	<xmqqo6h9z7e6.fsf@gitster.g>
	<CAHwyqnV8je6gCTExr=CFCdYskN1dVaEDVSKDLUo5A4Ukv=qhiA@mail.gmail.com>
	<xmqqa4srnwfa.fsf@gitster.g>
	<CAHwyqnVy=4oHBTmtDJ6jX38Kh1aLYYXHR-_12DdiiUxpXZ5kNg@mail.gmail.com>
	<4d150f21-46ea-4bf7-b516-c1763c152b34@gmail.com>
Date: Thu, 16 Jul 2026 10:24:18 -0700
Message-ID: <xmqqmrvqhmpp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> To me aborting a rebase because an exec command failed is almost never a 
> sensible route forward and we should not be encouraging users to abort 
> after a failed test - surely the sensible thing to do in that case is 
> fix the problem with "git commit --amend" and continue the rebase.

My conclusion, from my own experience with "git rebase", is the
same.

I wonder if the workflow that benefits from this "if exec fails,
give up and forget the whole thing" behavior is actually quite
different from what we consider the "normal" use of the command?
Perhaps the user is not interested in "rebasing" the history at
all, but is instead running a check on each and every commit.
That is, a more expensive version of:

        for commit in $(git rev-list bottom..top)
        do
                git reset --hard "$commit" &&
                do the exec command || break
        done

that just happens to be shorter to type?
