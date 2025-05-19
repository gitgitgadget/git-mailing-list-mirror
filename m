Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A7288C0E
	for <git@vger.kernel.org>; Mon, 19 May 2025 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677352; cv=none; b=r7dOhUG239mpKPhw4nyEGureJ4hBdQyE9hrhqNwCs3cV+uYbf/+Nc6wAsoIkrZEHGT8SUowCu71/5j66uuEh/A0LAAIuJVGY9tv1rMT3+nr7jtMJcP5JUIhFZA1c9XO4zfuDF+LgNU2s4b7Si64O8AX/oSlt9XzrTPU9rnnebqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677352; c=relaxed/simple;
	bh=I8rXN+Wg/f1glpuEAZQ+55xhOE1N3Ud1o4nDhrOVQPU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jWPr2Awwv+cqC6bZxibo9STwnn9svPdtdFzPOC0/6hmPQDOQl3y5sWhtTUrSmITMtjSRLE+lLwDwy1snxALmOQNBf6X2kPkb27ksZ7wEvbIV0K/OFtKwdVKsGerDafK3vJUQagFQd8TBzsVYg6qc8AfPAgd/Cn/m2H9r4NKUWsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KPDiFJr/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aSlH7S+o; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KPDiFJr/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aSlH7S+o"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 15EF02540160;
	Mon, 19 May 2025 13:55:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 19 May 2025 13:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747677348; x=1747763748; bh=dpseTuzesd
	woVpaaTen+mwnRw3yy0MEnauO2xA2mkDI=; b=KPDiFJr/q2rbBvaaoF6nmB4b81
	ud6lZVgkGin7/3pw0IRrHbOuCeeqBENad3pZTQHYZ8Ie4JQQoEPFJMtewACVFN9D
	t7JROmRfPppw+ltfVjwk00SymBao+h3l2YEUXc+Ex64kNsDmcpB1OyHyjqCNFlzK
	uYRxMd/y9LFWLCXltqiTARZEptTEjX9Evhooso0qBxmcT2LM+pSEPMnxJ4fTftPm
	C/oEtnLD4tF/g62ny+zYVdTiN83sNS8AxbkwTzruLYHmTmh9V5tU5U1Yne7GqZsF
	2wGCWWu0ce7wnsq9u5pJTEol1ZtnFWFtvx3VOqgl4sQg89tXtghvPZ2Yyw4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747677348; x=1747763748; bh=dpseTuzesdwoVpaaTen+mwnRw3yy0MEnauO
	2xA2mkDI=; b=aSlH7S+oUZQrFs82c/VpKWO+vqQzVTdQQKmgL87xYnUZveety87
	kSEsRLtILaT9LD4J9Fp2QY50X0QP9B6HJtmR4yTDpcX8M3xUQoePQbdYk7AQixXR
	yUMzcovNVrGUPI5A8chLMmwzEWKavekshVlcsDuOVa+5mZxcgYXBTm70JZ8+jgTc
	msHtlQrYSkdKOv0X1XoHuNdZAvtHlbgoRuUGSAIo8hOmArv/CRRDL74L2MNZOv71
	rPonpRRIcahM92FoK88UryDA0dtIq8gqxptev008G4Jk2u6to3CTgNartK2C/E3l
	9l5Emddxn+KMnnCrFKGFIvrhnlTqeXSWQsA==
X-ME-Sender: <xms:pHAraM1BViouwkd7cTvcoswxRnNlC201s_I57SEG-fXUJM_ePeIDDw>
    <xme:pHAraHFOyjxRNt4uteeDx8jMyBC_G42gTBiSUp3obBvW7D-S-CehoSWX8MhkuAdv6
    LCC1b87wSre8uwSxA>
X-ME-Received: <xmr:pHAraE5EKeqm_Q4ltx4OeSBcM1Six5yIp0piP9TrzEC6ORh4z0Np7xTrqxmCZWt4_6IfOrRYJAc6r691KxXJn9rYVO3To5UkdIjOusE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddvtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvg
    gvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrshgrmhhufhhfih
    hnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:pHAraF2Vu6cPEn6KuxfNnUBsFceaIntx1x0dixWtqP54VIQLmuz5lw>
    <xmx:pHAraPHqD4fJkpdBjNHK_tmh_q9kAyXVL-tlNgJs0mGHK805vV2nxg>
    <xmx:pHAraO8q7uOcry7iBRK8cIBZMUIEK7d1190cM2iSa1hET8I-eZQzOw>
    <xmx:pHAraEmT7E_PfT1WUWHwbZD8lx-A2ULvv9w9da9Dum3NXGMiFAfOrw>
    <xmx:pHAraLZTKGw34pljbQz-OkqJlmt4mmoC3B6wW2uLOXrv30utjBD-_snK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 13:55:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  nasamuffin@google.com
Subject: Re: [PATCH v4 2/3] docs: clarify cmd_psuh signature and explain
 UNUSED macro
In-Reply-To: <20250518074317.73367-3-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sun, 18 May 2025 13:13:16 +0530")
References: <20250518074317.73367-1-jayatheerthkulkarni2005@gmail.com>
	<20250518074317.73367-3-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 19 May 2025 10:55:47 -0700
Message-ID: <xmqq4ixgo57g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index ef190d8748..da15d43d1f 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -142,15 +142,31 @@ command in `builtin/psuh.c`. Create that file, and within it, write the entry
> ...
>  ----
> -int cmd_psuh(int argc, const char **argv, const char *prefix)
> +int cmd_psuh(int argc UNUSED, const char **argv UNUSED, 

I removed the new trailing whitespace on this line while queuing, so
no need to resend only to fix this.

Thanks.
