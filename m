Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E760615B971
	for <git@vger.kernel.org>; Sat, 17 May 2025 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747507188; cv=none; b=Szq5Mox/iOJbq8gO1ZGKmNATfRDLlvSAFT+U1R3o2krUwbTizowknZXiB+s4rMIhFYoKVfP3kLNHSOUs90DCAoK74FUAnu7AlKpH72gpl3jOfgyCVGyeaNogUmYkp6qgzitO19douUFvV+EnqGiD6b1SMx8/Ot7HQJR55zUdCjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747507188; c=relaxed/simple;
	bh=QhOeXpp16ndUNy109FPlWMoX64xDb+/WIKygeOCZs3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kzRA9pRxfKWxV+Kcq+IdIJ7NUVhx1nKB6BTkmeXntQ93HZHzRB2lTKemP/HHYu4ySdsJfaBsU72+f/Dxvypo3W6+CSDd3HbO4wCAoSvPaARUO+JHslsVktz9Xr6bSXCm0IQNoy7znu164xef0XRZx1bQPvIWIR2D6cNAjUv8XFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jzT6MfSB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wSXwll8M; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jzT6MfSB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wSXwll8M"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D1D0A25400D2;
	Sat, 17 May 2025 14:39:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sat, 17 May 2025 14:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747507184; x=1747593584; bh=T2WFazALe/
	fcy1My9qpw6gX2TzlbvC5QG12TXLv94SI=; b=jzT6MfSBmOXFeWlY6RLK5PQVCr
	4SLX2dnkC3CsF3zblQ341KciVW3JaA8B4WRYfmEolG7CnWG7uVDCbRNBs9x/6iUg
	GvZvMIFIAnkGltocDWMFxYc2Rz8GcCWJVg6vS0HQ2Mw/ZFsWifdt8ggakljjS6rT
	5hDkLTt/YC5M2a/gqPr/YLSrehPYP66RG4G6mAY1k7bnsVJKrZWQjzMp0JNT+692
	H+CJSNcbfX53ReLyqwwYFpfYHL3YcBPOOnzZbCGeVDAf6UvDlJOYKelzeTXpS0lZ
	rMqfDeA6yLiAEA5CUjBjvJVPAw9tvcIfVU/Y8fMoPh4cqJ8nwAcVzkwRnP4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747507184; x=1747593584; bh=T2WFazALe/fcy1My9qpw6gX2TzlbvC5QG12
	TXLv94SI=; b=wSXwll8MVlztlB1vKbNKKDC4Mz+rSdRga1tl8aws9FtciNnT/zl
	7+yFq2NGUMUVktdbF/PALaNXRM4QZ0j75MNouFqb1L2CPfGsDpbBojnXwCI/ypXY
	oviXoKoNaU8zuijn7bi8WW1EjUGYaUuskFIB+7YHc4oH+Ye14qf7MZEZvtjd1oi8
	4anzrcNemggtqXo2F/gRhqnhzxVAuriz/hVtEtjQUujECYkAi6dVVmtgABB+vamz
	SsnsP0IMo2C2gBlIWQb3OiSrxW7WSzHUoM3Z48lbDmdIlRVraz0BGcgDjqDMarX8
	5KUZaCqRkb+TTbFCsfsVt7tWK3xWVHWr9Uw==
X-ME-Sender: <xms:8NcoaE7MOqhlSAk0H8FBtbUDQcU7dNP1uTGbfkYmAT0FQhyMaW8yag>
    <xme:8NcoaF4tdbj39UCoIcWRLdWbtIg2bvKVKyRcrW3ZwnXNKo0img1yhOlqVX8LpsBBW
    SpyG61R5lqXKVmaIA>
X-ME-Received: <xmr:8NcoaDcdrx40VPoYV-IZbmVDMZMD4r6xw1ydys2f0P7cnSWrhEPsUA9Db8B9OubzXkOHxBY6Lt4qW5rYG9Fg0AXo9aVe-RsdEKqnFB0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudeifeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvg
    gvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehn
    rghsrghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:8NcoaJJGZko_c06ULMTJR-do8ZVbD9QbozAuTzoWnyicb9PoVWVz4g>
    <xmx:8NcoaIL8zncvumVkrJNtaThyhBVb1QV5SZ31v3zonb2EGB1gXdxeGQ>
    <xmx:8NcoaKzrvP6UchDiE_iWlq9HzOSJySEcvEUBosR1zAlAC1hdz0mW7g>
    <xmx:8NcoaMJxWg87Xi5PhVd2iAMsoW7PROzHtRtSPetOScvfrXnwQzX2Qg>
    <xmx:8NcoaJdAZDHaVJu757H-15wPOnYK2OOUlBjXvwzd3eUXmO8ZIa_g691D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 May 2025 14:39:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: nasamuffin@google.com,  git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] docs: clarify cmd_psuh signature and explain
 UNUSED macro
In-Reply-To: <xmqq34d3s6ed.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	17 May 2025 06:39:38 -0700")
References: <aCeAIqwvEVOdrsMg@google.com>
	<20250516185516.52311-1-jayatheerthkulkarni2005@gmail.com>
	<20250516185516.52311-2-jayatheerthkulkarni2005@gmail.com>
	<xmqq34d3s6ed.fsf@gitster.g>
Date: Sat, 17 May 2025 11:39:42 -0700
Message-ID: <xmqqa57bqdxt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
>> The documentation previously omitted the UNUSED macro,
>> which often led to confusion for new contributors
>> when they encountered compiler warnings related to unused parameters.
>
> The above is not quite easy to reason about.  It is more like we
> wrote this document, and then later tightened the default compiler
> warnings for developer builds.  So "omitted" may technically be
> correct, but it was more like "did not use it, because there was no
> need".
>
>     The sample program, as written, would not build for at least two
>     reasons:

"not" -> "no longer" to hint that the change in the environment,
not a bug in the document, is the reason of breakage.

>     - Since this document was first written, the calling convention
>       to subcommand implementation has changed, and now cmd_psuh()
>       needs to accept the third parameter, repository.

"third" -> "fourth"; I cannot count X-<.

