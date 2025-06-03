Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC6A1B85C5
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748994702; cv=none; b=Q8ZIveuNBTbMTTolPDkoooR1bZTlNsuZZ1+NxwLBTFYg5AuZIyegtzwiumteue+TJK6DjDtn6Joio2wv0uIPY55gNWdKmS0VkCVw1h13lNPCHhmLPyB5mDWY5IXJhsXmLeQBmSrFjHcNMwyEAqmc1laxaGDus6JOx1hskrwPqSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748994702; c=relaxed/simple;
	bh=lsytpROr6bNZYes/uCX1yuESr0pGJz2iOQbOoeDcZUo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OTTyT3101dqyE+BpKJsHTSIim9RuLdxU6rMUkLGlVLwwu/olaIZB9wa4r+sn8FKBWkmnT7J7b0bQXl6UYf9TB9CdEFtcS390MttGQ18UZYHBZ4Fa7iYGihFBzOBHLdAdwZFeuR1etmQ+4tSFIH0BoTz3mQCu2b4KRyhHiPN5zOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ELB1rTCE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jIUhkR7j; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ELB1rTCE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jIUhkR7j"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 156891140106;
	Tue,  3 Jun 2025 19:51:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 03 Jun 2025 19:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748994700; x=1749081100; bh=HRKQMQwtpN
	xB25/IT4NgPc2X5D5IAJBEc6qhmsBUDk8=; b=ELB1rTCEQeNHWDY86E9JXriwsl
	yCMajskiOULkiGGhkTkDIT2mwMXoGbETCRfhEpe73Sxs2OE1Chxkx4tX8tDFuUkE
	FpLPRzbCzyv8PM+SGtoHgGsoReIKqzCV3Tsu4v25dZwg/HnynimusukqSUTE0h2O
	FQ4mqKAsL7dnfa39RfSMO2m1T3EOBuAQREFJ7quL+cVrAlAoiSr32ynENMKxq240
	8mrOpMD2fVFhvr1FKLSecQrN1FYOvXIJbMf52nmluBiKBggWTthwkuVtYq8kcnGG
	H588aKaAzmhM5PLuX+zmHgXT3lPSdHzXJQA6b3c9Z4dLy8IHnoZs/o2LOl3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748994700; x=1749081100; bh=HRKQMQwtpNxB25/IT4NgPc2X5D5IAJBEc6q
	hmsBUDk8=; b=jIUhkR7jitfYxJXgAaNKsUeUj+N0JUOe+3Zbr6p+87aWQATE2Ms
	rr2cKqlo194sc3WHqkTGM77VMtTmRtpbRi2Bm25dOIxh8dz+qB7eSkbYMv8p1qLd
	b3Ls5lqkJkWttRKB+Q2Fqg0ZbLl/P/2tOJUfMuYV5SS2JZivxfDz9iGsz06BIHmF
	RCfXkhrLoQspsSiskYPiTTkRigUOA0ME9+D6iFkRzZXefBHGH1xwBiirCugAZe8+
	MTQC5rSMouHhrckJam/++jzOrURzLhDa8pIlmcvj0NKDr/74R3qKA4UIXPoWGyxp
	slRUWbkrNiWdQt5ZE84hkd0f+hAkvT3XmfQ==
X-ME-Sender: <xms:i4o_aLral0HSbisw_8MkwTj7NDVR_vjpbGKgrfdDlGp_ec5XQzU9-Q>
    <xme:i4o_aFpZmZOWu-q8EboyKtM-w2FoH1PXEuMLTtXAETkZkPJuZ0jqWbXv2jQ9IWm7Q
    FRcty2Ecux7OqiewA>
X-ME-Received: <xmr:i4o_aIM_6gBP1o_vJ-hiQs8Qjbd14oaHZdAFbvvf0f5DBiLBLbUIStsGL2zZspkPhEyodaEReAc4Cfv1FNpkjsj0gaV6u787iIqK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhhsehglhgrnhguih
    humhdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:i4o_aO4odERlXP5I07dpB7RCH2_vhYrxvUaVgpqrmysB-EfQWG8S8g>
    <xmx:i4o_aK4F592Qd2r9Nnb_82e4oZ6EJZiiMmrNjG1WAs-fWBOpEo7MNw>
    <xmx:i4o_aGhbxquCcaYp2HoZqGaH-dbJBNwd8-y9CaSWhuIdUhCgCqb_6Q>
    <xmx:i4o_aM7sEUAi5kgquyUeAZK8tMOPbr1F8Xxi9xAgBb2ZeJ2U3pqTlQ>
    <xmx:jIo_aLS-8OTUPqn1Y6Ll6TYNI931PRlNXRlL9OJd2rEWTbW5SFsG9VPS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 19:51:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] Fix comma warnings with clang on Windows
In-Reply-To: <20250603230646.2322671-3-mh@glandium.org> (Mike Hommey's message
	of "Wed, 4 Jun 2025 08:06:45 +0900")
References: <20250603230646.2322671-1-mh@glandium.org>
	<20250603230646.2322671-3-mh@glandium.org>
Date: Tue, 03 Jun 2025 16:51:38 -0700
Message-ID: <xmqqplfkfkol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mike Hommey <mh@glandium.org> writes:

> Subject: Re: [PATCH 3/4] Fix comma warnings with clang on Windows

Common to all four patches, as "Fix" does not quite tell the story,
please choose more appropriate verb.  For example, judging from how
this was rewritten ...

> -	if ((oflags & ~O_CREAT) != (O_WRONLY | O_APPEND))
> -		return errno = ENOSYS, -1;
> +	if ((oflags & ~O_CREAT) != (O_WRONLY | O_APPEND)) {
> +		errno = ENOSYS;
> +		return -1;
> +	}

... the warning is a false positive (i.e. the code does what the
author intended it to do), so this is more like "squelching" the
warning.

I obviously like the style after this patch.  I just thought that
the proposed log message, especially its title, were not clear
enough to tell which ones are real fixes and which ones are
workarounds.

Thanks.
