Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9854925D20C
	for <git@vger.kernel.org>; Fri,  2 May 2025 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746205071; cv=none; b=MQuIBdBBYkL6d0fIKFPxDyFu3kV1GsDgGk0PjioKmvt4ry2bqILBa+RHqU2kf8dEjCmdg2nuyA1Er84SJTmV3k9Ny4x0xUZi96CEBZVNS0R/ow5uQGXpvWLtCKEoh9RwjP6oYV4mGlRLBn71LDWWwiALAs8Zx1yqzqh4X8fZk5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746205071; c=relaxed/simple;
	bh=KJ6MgcIb7ML/mDN4Davo3mAy+QT93IkjmC4Q9bh03EM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X1qOMqlVUXSbKT1dsO880Vrv1ZSzUNPRwzPpw7jPUN6c6FT2mnBrJsAqKlVoq2/Ej6QD25yVdMO/HG9+3L7Ia3qQkD6W1NyLd3l5xEEfEHgJTnBnMtGIyx1MWzEA1IHmBYAqE3shH/fefZBcJVU8IeGamvNHV1kyVEshNPXY+xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LL7XlY9z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hwCuh40W; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LL7XlY9z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hwCuh40W"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7D78A25401BC;
	Fri,  2 May 2025 12:57:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 02 May 2025 12:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746205068; x=1746291468; bh=p0ttkX5SBJ
	89nEDkS0xsS4dd03JYPnCxOl1gn001RIk=; b=LL7XlY9zE2no3+pIEqJ1N+SqBI
	nsT55XVe2e8uhsYPwEng633dHSRM3pgc/cVQ7dtPk68nW7Jezf8TohLYSHxqafvZ
	8jLHvUHGSNlfLRbVNyLE7LObCt+NrgZTIel1N5oDruQQP5MtVIKv70JC7+ykqwIv
	crl9dNmkkutlbNKfKlsH2b+Jo8QQ9Dc+9VOGKfuUjyRMXmI7glR8dAMrI8Zc5D/K
	gP5NGkqMD9PxvcUEIZdXGtpmpnbT4iN1JRBEOLx+9HLBwAl5fmx0gvGO2BR8Bg3z
	/5UbpkApToVbG3jvPXZJ3tfYzglZ3oUXncCu55cm7+m6JdFueBuSKeVPRL1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746205068; x=1746291468; bh=p0ttkX5SBJ89nEDkS0xsS4dd03JYPnCxOl1
	gn001RIk=; b=hwCuh40WWzsP6YDoBT1urXHlsheIjVluM5c1FMNn5eaBkkMns9X
	xvvDN0z2a9lATPSDOt/WzL1FtDC6ciBMndpi75SmZd8FN/lcJWu1HOxcRg9eSqhk
	wZU5ND/WFMnUHPdk8WZaTAI25ocv6f77k2QcZ/GnQhter82xQcvqCqfwjYSkddEl
	n3hb7FEdDXq6qkWdQTw6K5O8cLlbZBAJ11NYj2N8P+zgvsADIErD6KpbS6frW6mc
	XKJdl/nccpCLuZ0DI0L0EVw9p+4TvSJ41VPNCNiIMIRxUX0l+YXifTxt3nWWBgQt
	3huYyNleuO30LlJkjaUqN/z/A0++qU7JZgg==
X-ME-Sender: <xms:i_kUaGUsNGEV1wB9C1PqOizUSwL2BGNg6uZb06wqRQosNXJn5lYNTg>
    <xme:i_kUaCnBKw7_suwNMEVh-MY-0XU37806R_6MqC9pvoHp-QexqpB6LG9ke0hibh4SA
    4mpk8cWTar7jhosBQ>
X-ME-Received: <xmr:i_kUaKZsWO9lK41_BpYd9KcI-B5WmpUmXljn4B1_8kOOhA7z-9vaoys1r0048tFRD2QlhLttrAftPTXJXb272FWXNuJFJrFBG5km>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgvohhnmhhitg
    hhrghlrghkieesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:i_kUaNXSLrwXQPFRp6XQKA9J_Op4Fq-IMaM7FlztD6MSHBIsy0-Zyg>
    <xmx:i_kUaAnn-n-fT6g9jPJWh0BBE_UdAwrpGjPwYcL_k1SeUFNSkflMkQ>
    <xmx:i_kUaCcRmTS03Hq7Jc0pxreK-Cv2aX0D_t-nvuTPiFfaxtA_sT8Pxg>
    <xmx:i_kUaCHpJv_hnIUVLfC8kfLMCPbuh28OW4oGhKiMmFZCkgoDrDd_dQ>
    <xmx:jPkUaBOKx9oRq5iHf65LMfJHgVFuiYVeGylUvvEFjCAP1QCK6AEF64Bu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 12:57:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Leon Michalak <leonmichalak6@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,
  phillip.wood@dunelm.org.uk
Subject: Re: Discussion for interactive --patch commands to get --unified
 support
In-Reply-To: <CAP9jKjG+khoUmRpVJ8om-bs_qjB=VFCj3p3h0VSaBHVnqPLNVg@mail.gmail.com>
	(Leon Michalak's message of "Fri, 2 May 2025 17:14:22 +0100")
References: <CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com>
	<bf7f6606-e719-4c3d-b7ab-ef7351f66f37@gmail.com>
	<CAP9jKjG+khoUmRpVJ8om-bs_qjB=VFCj3p3h0VSaBHVnqPLNVg@mail.gmail.com>
Date: Fri, 02 May 2025 09:57:45 -0700
Message-ID: <xmqqfrhnuf06.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Leon Michalak <leonmichalak6@gmail.com> writes:

> Inheriting the diff.context setting is what scratches my itch the most, although
> also being able to set the context in the command list of `add -i`
> sounds interesting too. Personally, I don't think I would use the
> command line overrides too much myself as most of the time (like with
> diff) I'd like to set the option and forget it but it does have a
> certain consistency to it.

Sounds good.

> Slightly off-topic to the discussion, but does anyone have advice on
> how to deal with providing a sentinel value for something like
> context?

Seeing in diff.c

    static int diff_context_default = 3;
    static int diff_interhunk_context_default;

that they are of signed type, and negative context would not make
sense (would it???), wouldn't -1 be a good "they haven't touched
this from the command line or configuration" value?
