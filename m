Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131F7375F9C
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220052; cv=none; b=OmteDY/sNv6Klu4c4/p2ZdEq4ghGwVv/XIFoSXCzE1lMvRbRmxNplVYiZcFgBnmErvRq4lwU2niP8QmkaV8Idoar49iC3lOuIA7NDTFia53vtzt5QaW75PGrjG3gFmIdqs1p7V8CXbpxQdvvmcMy0MeusfIN5gZbmHHJTcOK7Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220052; c=relaxed/simple;
	bh=WCtu3nJQY4odd/D6LWGaL18qy4THAbKWgGpvCkaLpe4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GJm6NBblvYKDFUtv7VbY/J8M1Nwp834mIGoWX0/AFVOFdt1lCuyZ6aOpDqA9HPEUtWtZI1kQf1lItURziiRhrWFEId7QBUvb+6xbWcIGvCQ7LQCPbPSnCVZhGa/pYu6P7edNfzZ+nDTNu654z2rH86F1sSLRfv90EAMUXq+ltU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PQoqk7nL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ae/hnWSG; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PQoqk7nL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ae/hnWSG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CABA814000E1;
	Thu, 16 Jul 2026 12:40:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jul 2026 12:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784220036; x=1784306436; bh=WCtu3nJQY4
	odd/D6LWGaL18qy4THAbKWgGpvCkaLpe4=; b=PQoqk7nLhOqa/56DDn4EmHuxjU
	s40O7UCUOI9oxEwfIDSADRn3OZbj7736TImccxU70DV6PmOlHqxxCVn+7V5T82Oy
	Vko9Urarv9N5I0i3owsLofBYyGuA2i/JGO5Ulfbh17svBwSaoSyM4BkU9MjSnskE
	6ueUnClbP1dTCrydouG8acl8Uh9Bv2TLIda0mm5kd4exmpcdB5MfAhL24kzCQ8xe
	6XvWq6SFcIcDKgWONjDIS4UAJxSiBtfyjgb3H60FkHCUINFSGTbI//cbVj4FQFxZ
	Wj+rR/gdEOvPixX2NkNh3FFmL5lSl7+7qQCRF/GDtBaXPEqYBINh5/0kEV8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784220036; x=1784306436; bh=WCtu3nJQY4odd/D6LWGaL18qy4THAbKWgGp
	vCkaLpe4=; b=ae/hnWSGPHse1KmmaJGPHKcD9LgA2Yu/rZheqpKr5Kg+m3kdW/I
	r+iQva1iBioHcM32hImPsPlZHTqEhdysfOs/Md7TfpRDeWg8Pbjxw885hOCvfjoY
	ukzU+HYtbBntgXaoHrG+csxPmTj+qeBl/xg16VrkV3Y6m6WqZAOaDlihJxEunrq/
	ppjE/bA6OPaaYIR2Z/s91CTqyUwvnBIT4IJeGG/MiLPPMuR44mTP8HEz6cPADTeh
	g24S5HI3GwWC08fLw5nJ0SPQ2gsYDLkrfFlh7Vgjc/r9XGbCkieXAEDSvaJahVNd
	WDvTdusRIlyIhfLFZw8L9Uyx30VizSh+ofg==
X-ME-Sender: <xms:hAlZaiaH6lbc9YMLQlcJ-QnM7JwucL43Y7CDeelgtCc3DnLETiAj_w>
    <xme:hAlZasSVfF1VoOICqrK-h76omwGgBsfLtEgGYFutqy2HQkB_06Dfhgkl3P14hMsX_
    3ZmQv1O1gUre8EgCtMw98HuhhZPgWosWBwG31ibrN5P0a5-13UGJg>
X-ME-Received: <xmr:hAlZalRvXGi9V8DDcwuMUCbd2b1D0LDAG9pIXEJ35hbsQUfWHcU8PxWMw0AJNGuU44d-aodPmyeZwHNc1fYYpkMIkvigcQLpqvs3k44>
X-ME-Proxy-Cause: dmFkZTEFBW306D5pDD/T0ujvZ2ZZaNLiNM+6pRybnJ9wzXBOmfAdcBvCl8/n+SrtjCAKX9
    NEYjR7nVi8Rv4bLRU3Y5AhAAUOQ5h9kWPjJx6F0spyECZ32ruPjr7KiW1eh3MnnytULcw3
    NL3g+ziekZ2YZaupcxf61bsi+9JgUQDvXuCdCypRYy56MCM22YaBruZwHKrSKz9cBdSKYV
    ShLnxUxZJ/YOOe2jTMJalUUsN6OnX2jp0PwGy4moKweTYWvmTGEkJDyBn/qyKBSsLpKNQM
    bCJRrHkzSTb/b9tnggg5bu0uFYY8yLyo/Dvee7HjfFtjwAu9rNkes01tM6DZvWqL6Zl0Su
    dr3YALZyyNeGpstglG3QMln9qKrrSji7A+P+mCKGAMQDGS2Wd5AVUzfr9j8EdMh3vFbmFB
    nbCL95MxuWIxLQM0OgWWd6vJP3L8RGiCbr/LDPcWGcgbQpb504oKRKB7wvvcLW+/7HNVTE
    Fj+uM0N1+YxGe+2EmjchHVnerimmZg1gSwWJkDNp/QL++6JFWpkNLJkebZMhI05CUXLkCc
    TM98Tw6dXA66eAl8qJckKKe6ozifOIsWzbyHWV9hiIn5K0fL3BgzuRm6f+3XRs0cgwQdGd
    r9lxE5T1v+z9BULoseYTkoS+wk/no9Z2AJJyXIZc491us2VlPlWb8cUQjQxg
X-ME-Proxy: <xmx:hAlZagQJcnodBh67PtNVe-QkuIl6jA84QEnrkRk1maTUXOp5NdeT_A>
    <xmx:hAlZaq4rbZNkXdeZAaL4glpb77VwGpCO3FKJSkKEY2EUXdyykSpbkg>
    <xmx:hAlZas1GHge7YJsympwK9gkglbCSQMLg3KN84uwhK2xABCiO4e4N_A>
    <xmx:hAlZalCbtZzdQLl3rNksuv6RRFeHweHi1LjUfcoUI_kmow47TJiBqA>
    <xmx:hAlZamppq-R0ZMVSGpJ9WVo5_A-FzG76XH0WAdy4KYVJrtL611uAe0l6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 12:40:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v5 0/9] [RFC] diff: add diff.<driver>.process for
 external hunk providers
In-Reply-To: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com> (Michael
	Montalbo via GitGitGadget's message of "Wed, 15 Jul 2026 21:01:53
	+0000")
References: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
	<pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
Date: Thu, 16 Jul 2026 09:40:35 -0700
Message-ID: <xmqq8q7aj3b0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> A "Which features consult the diff process" section in gitattributes(5) lays
> out, per feature, why each does or does not consult the process (patch
> output, blame, summary formats, and the -L line-range view do; pickaxe -G,
> patch-id, merge, range-diff, --check, and --raw do not, with reasons).
> Combined diffs (--cc) remain on the builtin algorithm and are noted as
> future work.
>
> Changes since v4:

This round does not play well with the mm/line-log-limited-ops
topic, unfortunately, it seems.
