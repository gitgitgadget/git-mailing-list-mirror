Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A41922F9
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736966177; cv=none; b=hVkb1DrrA6oJ4nNqKeNb8XdnNAy8kedy3cxqI5UEc78Qkm2SIXByVB/ow5juzdbKVQpTXLeFTngpK0hKr30eTC6TAiIK2TJF+IuWyP4eHwLefVzlwecZ+EwzlvB2+tv+66C45Nc03rXMRrd0GI+xFNZJNyLcuFw/wxxaNSifsDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736966177; c=relaxed/simple;
	bh=6Hw3oagPtI1efy98MAnzhz+n12wOdK9lGWBVGYRHjLo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=X4fLATb7RYNvlCsmbtd4JDBiMQI3BjQCKRtNNrqR25zPTIe4Z9I17pVbo139oy8zb4Xcg6hHSyFNtnQPoT1psaSJLkSauwhDapZ3m9sznNB2eRKXFaTVBwgOV+yyye2Gm4psOBw6xF0ZIgclL/4NzwKR4CB9ZrFV3Cxh/Ww5ffE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SWdwZjZx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TfwZeLLA; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SWdwZjZx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TfwZeLLA"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 85BD325400A4;
	Wed, 15 Jan 2025 13:36:14 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 15 Jan 2025 13:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736966174;
	 x=1737052574; bh=v9UcJtnlJjV32r6WgOXRwDlahxHVxuNzQxhaqv6UsrU=; b=
	SWdwZjZxYH5uL2DjdmHW0y23GsafGk5f9Y8bzLdfnmKuE/QE/kLrKEblp7dY8Ojq
	ITPwTO+KsidpgkXOIZBFkG8knTZqSuPyALcYIh1F6uzgEf+14WsXmYkbkAIO4tUY
	NEhi6e+LAC17lIYE9Voxdx5ryx/TSRHezq0BfQEhkW95COuP0l9UzJUxKv9waW+2
	tkxZtvRuRxpNT2bYhuCFq2O3LcqAkvdXNle+o6Bf8/dgErgJUhezMzTPbbwr0+iS
	j7AxhP0SaqknrCP4qXZiClR7C2lw1VNKPlv5SKlfptq38S05fJmp3mn9a2XThEZ2
	f2C0b0/npleZqiwm6/cNZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736966174; x=
	1737052574; bh=v9UcJtnlJjV32r6WgOXRwDlahxHVxuNzQxhaqv6UsrU=; b=T
	fwZeLLAiN+JaGmUB1DAW2I1Lm0Wowpnif3fk3Ks/MFGXv+8bnL5eHIjtgs8nUx9k
	YkxCKQ8MRF6O7nA+lCUWBQ58qgeALN/hCb3NQnuU/U+gNC7ICmmh7qhRI2DWqpk2
	BR2gncJJnj9zP8s0Ad+shcTnHEa4BqP1nC7+pK5I72QuZ/lY4XtRHtSkitzuD4YS
	fkYTn1ewChdxylrMre+0NUxhn224uhomry7Nt7vt6WucliBx080knX35cVttyZlL
	S9KbBbme2Z5IA5o1cZb0I1QS8oMEh4+YDz6yjojLwLELEkPqg+R8s4q6w07peKU1
	QlbtMU4cTsqZ2tgvLUv2w==
X-ME-Sender: <xms:HgCIZ1P2pj2Z0dvJt8ihBh1pfGKqzdHmXOI2b-Ctg54CGA-fRK2lH5g>
    <xme:HgCIZ3-P35dqbthCRXCnuj_kXDPLoTWuEicCJZdEBCd3_9Oj8cqDZSZOPeuJJ2QWA
    a2fKOqyQxtYwBXV5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhepgedtjeeiteeghfeutdeutddtiefgvdegteektdeutddugfekleeugfelte
    ffjeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmtggvphhl
    segtvghplhdrvghupdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhonhgrshdrkhho
    nhhrrggusehunhhiqdhmuhgvnhhsthgvrhdruggvpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HgCIZ0SLkOdL5tsyMJ9L0y3_lrSi1Erb1ChkaEcojIHBpDLk4_8C1A>
    <xmx:HgCIZxvQPRWVofw1SXBZcNrx4TPXqd4U3NMWCBTpUgdZ2kZdi6uDOg>
    <xmx:HgCIZ9ehcRMwAxwrgmVuZxweg17YNuJgwqGoYHTS3dtyGr4OYnsnkg>
    <xmx:HgCIZ92u44PT8iE4G-FEjZIi6_VM1sMxCFG6VYgsUUQzPD36DGItUA>
    <xmx:HgCIZ05XtPJ61HUjUayJGUQ4sfuJ6wRw5uatsvD09wtjGno1iT9WjRot>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 257E8780069; Wed, 15 Jan 2025 13:36:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Jan 2025 19:33:46 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
Cc: =?UTF-8?Q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>,
 "Jonas Konrad" <jonas.konrad@uni-muenster.de>, git@vger.kernel.org
Message-Id: <a543c92d-215a-4cc1-a7a3-bcb34c62f33d@app.fastmail.com>
In-Reply-To: <xmqqikqgx74o.fsf@gitster.g>
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
 <D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu> <xmqqed1414gt.fsf@gitster.g>
 <c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
 <20250115171423.GB57018@coredump.intra.peff.net> <xmqqmsfsx8oo.fsf@gitster.g>
 <xmqqikqgx74o.fsf@gitster.g>
Subject: Re: Git branch outputs usage message on stderr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jan 15, 2025, at 19:29, Junio C Hamano wrote:
> From: Junio C Hamano <gitster@pobox.com>
> Date: Wed, 15 Jan 2025 09:56:23 -0800
> Subject: [PATCH] parse-options: add show_usage_help()
>
> Many commands call usage_with_options() when they are asked to give
> the help message, but it incorrectly sends the help text to the
> standard error stream.  When the user asked for it with "git cmd -h",
> the help message is the primary output from the command, hence we
> should send it to the standard output stream.
>
> Introduce a helper function that captures the common pattern
>
> 	if (argc == 2 && !strcmp(argv[1], "-h"))
> 		usage_with_options(usage, options);
>
> and replaces it with
>
> 	show_usage_help(argc, argv, usage, options);
>
> to help correct code paths (there are 40 or so of them).
>
> Suggested-by: Jeff King <peff@peff.net>

+Reported-by: Jonas Konrad <jonas.konrad@uni-muenster.de>

> Signed-off-by: Junio C Hamano <gitster@pobox.com>

-- 
Kristoffer Haugsbakk
