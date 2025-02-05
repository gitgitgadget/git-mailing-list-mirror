Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489F6207E0E
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777562; cv=none; b=WaOfhrstan5lpwwahXz1XPsR4HNCE1PQypnH/LMKsCuolvsC9K7ICW1tkZLmctHOw1FdhPly22qCY95Nl/3nkSAxLhCH+U2hBXRUi3VMWM7eWbRWYJKCxsxgqzh+sCv3pY+TSZ4tqXgdZaQlekoIoE8+EZL/4y7Rz0AdCGuO4Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777562; c=relaxed/simple;
	bh=PlVNJsOt6XJqZsYPYwsxioV+vVlfONzgRNfwiWb7GPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JUng43chZhSyZITeqLfk1B+Ynr23iPJYcpE0n5rxhSXuNl9gqOnFPAKje4T2h+p2FVx0L5t0KfZGC+8lL3pG4pJbS4Wju3rCfgzEPyGGH5z2wNysB1CGycoZ/3AMaaulRBk2gX/whT0wnk6NuSSYkz581EGsfyRp5Kac8wh69Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=enA9azTy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hs55LZ6o; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="enA9azTy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hs55LZ6o"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 44A672540123;
	Wed,  5 Feb 2025 12:45:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 05 Feb 2025 12:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738777559; x=1738863959; bh=/NYLmaXCBb
	vNtIgW69GkEGAM7tWo6SZk1HZsxuIwJ38=; b=enA9azTyDB7ik1kKYUYtcMy4MU
	Mg6A4c270V0wZdKrm6jFOb+zzFscQ/hSAxWZuzog2pO44nhl3QQ0Ig3OXfbcanY0
	08IrVV47HZzaTQ8w68lsyKuLlrYx0Teg4yrZ5a/m/55M5BPiJz2szC55tsYqiwQX
	3rODd2+yVRp0101GRE3iAIqoElBUfA4AU8zVaJ01+nuspl7DggaLFonrfb4Yb2qP
	gqEwwIjeuKc0E+sKQt+3bxe9CHLViIuPxWRBdVeL8L8ZnuKyZ9Waxx3UOx1Kf/oY
	gkKFJYr+iDFpXJYBY10uERzwEoH9bssoSQ1/IkoyJPG1nlI3Xtw/f2VY8tyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738777559; x=1738863959; bh=/NYLmaXCBbvNtIgW69GkEGAM7tWo6SZk1HZ
	sxuIwJ38=; b=hs55LZ6oa+gp2bm/3ZN0BBodo3mDcvBfzD1eHjyO5m6XblZMDAB
	oOZ7rlYqhh7EoleGx7Znw73Oyt/j3HYKgZyKRuKof8EFv5ub8grEWtGO1SrzQAfK
	+u0UHyKRIk2T/09278fQ6ScBXBC1aVJg0ioNtqiieVD7Lsb/knGxmdQTb2tvGAHG
	kUxH+8WnqISuJoO9N1AXy8eEF1iFUdlVxDbDMiYcA/TJ2S1vDWGNxKcFhl1tzeaP
	3KLg/o0LAvfXFxOk/rQYyZcev3gj6c/Mfgj+Of4vnYzaPeRDBXVozED+CKSL6lA7
	NnUt/61CIUypQ/nOwEeBwYsXgOnpp4UzY1A==
X-ME-Sender: <xms:1qOjZ3yerY6E3qnsQon4MqqIV1hOejOct8hv170I_d4kopmH4Y8aOg>
    <xme:1qOjZ_T-laaeWdQn4URjuLPeKcM0eH5HPAYSTd239FOa-u_7-Jb8o-X-HYfVeuCab
    Z9dZZ_tOmXrWQd2yA>
X-ME-Received: <xmr:1qOjZxUePUmeTGrCFUzHr1xPWEz2XAtUU2Cv3rzt_8Pksbcb0rSwNj5d_dpAqFFT5wjSQkom4DLwt4qfIZNa_njluXqa1kezLVW7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhgvfiesvg
    hmrghilhgtrghrthgvrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1qOjZxgZTE5hcGGij_YR1wBKF1mg0-X2rC5fT2YliOtIbAhsHU3ZsA>
    <xmx:1qOjZ5ADVuMpD9ms8axGpFjarIUe8SOsEmm7pDcE7L5U15_Y-3pilA>
    <xmx:1qOjZ6KAebyv0OnsoVSntDRj6eJuMY1InDP3xWAHov_FNTQed5ZBNA>
    <xmx:1qOjZ4DiQu26EMvbgPlIfhS8KDQPlTic6nNo1aBv6HJbf77PLrPBog>
    <xmx:16OjZ09BvrEOM7NTm-TcpbyguN2uJ4D3WkJesMv6Hf23_AFPFo8NhOiO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 12:45:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Andrew Carter <andrew@emailcarter.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] docs: indicate http.sslCertType and sslKeyType
In-Reply-To: <8f9a3a2b-dfa2-4ff4-9f97-e65404315396@emailcarter.com> (Andrew
	Carter's message of "Tue, 4 Feb 2025 23:46:21 -0600")
References: <pull.1854.git.1737591366672.gitgitgadget@gmail.com>
	<dd5d9b93-1585-4165-8f5d-d9737725071e@emailcarter.com>
	<xmqqa5b8aqn1.fsf@gitster.g>
	<8f9a3a2b-dfa2-4ff4-9f97-e65404315396@emailcarter.com>
Date: Wed, 05 Feb 2025 09:45:57 -0800
Message-ID: <xmqqy0yknv3e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Carter <andrew@emailcarter.com> writes:

> On 1/30/25 4:22 PM, Junio C Hamano wrote:
>
>> I thought that the initial iteration I received from you on Jan 23rd
>> was just fine.  Did you change some settings with your MUA?  The patch
>> is heavily whitespace damaged, with full of &nbsp;.
> ...
> Sorry for the inconvenience, and thanks for your patience.
>
> The original message was composed by GitGitGadget. I pasted the v2
> patch into Thunderbird initially, which clearly failed.
>
> I sent a new v2 patch using git send-email, and at a glance it looks
> unbroken.
>
> If further changes are needed I can get an updated patch to you with a
> faster turnaround now.

Thanks for your patience, too.

E-mailed patch workflow is easy for automation, once set-up
correctly, but there is certain entry cost.

Queued.  Let's mark it for 'next'.

