Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D02F2DFA2F
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770842806; cv=none; b=SRRfd2QRG7c014XXB3cE2gZg8al7sDr03oyJU46JsWomVk12PWiJ6sERZiqQtEdg7+e7GBivJRelIgNweVE//VXrnpKjmljo4fJZO2gvDYa9IjjmsE21WvML3Bt2Dh1xxKoJ2pq4y/7j9dk4vjVx+cx6smsC0aMR8Vy1z9Jco6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770842806; c=relaxed/simple;
	bh=GGvfPjzqocAol1LBxPNIrSlRepptCxY6fXS/ipb3gQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YjL5jqrjQA4/4J84ULWWE1E9TdHDVyLILJAIYWaCc0/goyamOzbok+pVMgj6oopKml/IcsvaNR2NCb54w/LGPyNm7+53d6y+fb/myJIv7zGXd5KE2wXI1/ug9BIYSUgBLUl5MZy53m8+StQj0KwO78PWYznvUNO1PYs73UXIH1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RFOWzHBK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fygh7ygD; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RFOWzHBK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fygh7ygD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 250101D00127;
	Wed, 11 Feb 2026 15:46:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 11 Feb 2026 15:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770842803; x=1770929203; bh=pfmVND5AnO
	cBvspKlOganfeRypi7Ll8Y4LxDZ9CeA9U=; b=RFOWzHBKidlI/5MRUAZJANtq7U
	ngKXDO9+JxCk+Bk4IH18o7CnjgMEKF+zqj9pkyzIm/vXLNAJpuPjLi1eG37NoJ4M
	HYY8Mmhb1w3lvwZqdv74o4ou0JFLxTLrF6YFDde4BEYkmvK7E8XrWEdz1m35Cia5
	nv9Y7U8SOrFhch1g0/5CPmvMJB32g82gyApINouuHGl223J7z2eVIZfEiq0BC2zc
	tTU0yub4FXY8gEze716STWdFOea1fIh09W05XALqD7L6hXvOymsRjsPOQzSGMCwy
	u7yRK//a5Gb2kPM8bEVeQSc5c272f57KvggTwc7jb9Iew76LmMK/5s16m5gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770842803; x=1770929203; bh=pfmVND5AnOcBvspKlOganfeRypi7Ll8Y4Lx
	DZ9CeA9U=; b=Fygh7ygDDDJ3P8pPoPL7WSKl8QDK+tFZClNqrCf5IEqZW7nrYDn
	438FMoRGSVjZjud6tfJnO7UZqEnfd5vnlKdp+8rKOJi4xo9yIaOTvqLq1jnH9QIB
	2ghHl+KrTdcO4TBUGsiwn2w4eJ7yZoDTnRA/maIzqgsvQ7JjFEeDOc/R9J5iBGqX
	Ih8Islzajr6v1Bh1IZPr8Hw/fYeggOYp7afuQfUi656RPvwFpnXI23RT6DOru5fx
	WdEJf1IO8w5/fBwx1vhD1Je2ALUV9h/DneDTGqVabRYfdVGOx8CApdskHN0/0vfb
	xgLjZ9blmAjaBGOB/QrblSjFSeFEdgtaWDg==
X-ME-Sender: <xms:s-qMaTQGJSE65TZpNEtbl3IGZ1qfRlbvEsrV0LmeXsuE4svs0Q4yvQ>
    <xme:s-qMabwcdZMXjLqCZdGpnB-MtfZkxv_MPJ4aEXC1VvGj2lquuktVBp8skyA1jnw3b
    LpIVbMQZCr1JNPM56WZcdJu_5CXxozI7Dubskmr8_huTjPAdAUv>
X-ME-Received: <xmr:s-qMad0x6PPJgYwNVf54eGgdJSnOev20KV-V1HmENYTZwSTqiDT0BV-MOz376DBaEJK3dNXMMxa2rWRk5qRKjSU5xiTrttRRAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepjeehhffffffgtdegffejkefgfefgveejgfeuleeujeeukedvheetgfelhfek
    gefhnecuffhomhgrihhnpehrvghrohhllhdrphhsnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhr
    tghpthhtoheprggsrhgrhhgrmhgruggvkhhunhhlvgehtdesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:s-qMaR7Xhe3nWEWayKnirrCopmCYT36skRic57DGaYoXBzG7QazIlg>
    <xmx:s-qMaYXBKmJvGTnuwhdeExQejfRvDeuAyeNuMXJOSyPvaymE9JY4jg>
    <xmx:s-qMaYAxREFYXz_RYaNRX2kRg1A_s8_HQIiBowrRcMPDZUUqhhpifQ>
    <xmx:s-qMaf4mbTg4qewKCSK0ZVrCV8N1DMhl_VOhPhqu5U6eaBYEJCjlOw>
    <xmx:s-qMaVVuDDqnZROvzgrQpd1dDj3wR2RDqEHXbSTB_Fx-yeQL0954xpax>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 15:46:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2026, #04)
In-Reply-To: <xmqq5x84xms1.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	10 Feb 2026 14:21:34 -0800")
References: <xmqq5x84xms1.fsf@gitster.g>
Date: Wed, 11 Feb 2026 12:46:42 -0800
Message-ID: <xmqqo6lvrost.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

Sorry, but I need to fix a few obvious "oops, that's embarrassing"
mistakes.

> * aa/add-p-no-auto-advance (2026-02-06) 3 commits
>  - add-patch: Allow proper 'git apply' when using the --rework-with-file flag
>  - add-patch: Allow interfile navigation when selecting hunks
>  - interactive -p: add new `--rework-with-file` flag to interactive machinery
>
>  "git add -p" learned a new mode that allows the user to revisit a
>  file that was already dealt with.
>
>  Expecting a gitk update.
>  source: <cover.1770390576.git.abrahamadekunle50@gmail.com>

No, this is not about "gitk" at all.  It is expecting a hopefully
small and final reroll.

> * ps/meson-gitk-git-gui (2026-02-04) 1 commit
>  - meson: wire up gitk and git-gui
>
>  Plumb gitk/git-gui build and install procedure in meson based
>  builds.
>
>  Expecting a reroll.
>  source: <20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>

This is the one that waits updated "gitk".

Thanks.
