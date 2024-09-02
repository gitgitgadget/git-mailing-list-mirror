Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F89A19E967
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284488; cv=none; b=fhmFRZXicmkPmFtLsd9oKXRBaVvhsbZd8Cum+basdpBhzFMyAmVvYrs/jWRNmtEMwwkUUKANWN0k3pH3MgqrMbVCs+fbNlyx1cVjx69z77Qa9ByMJtV8YyMOQA/lJWoyMGO9r5dh4gtTYal9TAWFGvvTrmCcCYEzTZuhgzQWuVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284488; c=relaxed/simple;
	bh=0Aztfna6y3WcZg/DP4SKFkR+j2KAM73jG4wa0r9g3RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgOzIccX6TqOrmbLEuy/bMccbCLAEAK+GOds6rxZPHvBsuHcoA9lFZ9cAVSlY0Ev1doLtTAhTA/sZd1Ts0C9TIate2XKlX6TMbhFfBxio2y7cajHWWxAptT3O24aw5MrfzZahQHp/8E5u7KKNJ933QztCIHLoaVqnJdghjP9nJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VtM2w2FS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NcnASHEj; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VtM2w2FS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NcnASHEj"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 38532114014B;
	Mon,  2 Sep 2024 09:41:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 02 Sep 2024 09:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725284485; x=1725370885; bh=MQ5SdmLrG2
	KMnWRKYZ3RMWhjy5tT/BsA3+yaSOcoT1g=; b=VtM2w2FShcPTDiJZeuyO/PnOvL
	lIii/VP48DGU54g0Rs69P3mcUQ8JTdpdElyqT5gbbtSqmCVIkbAK5XaJ/PFEdftM
	BQl2zy+cRyGP4RU6SEEBTfvzDupYGcZfneAHWJotmqYixWItQM9AApqUL9JwWwvx
	uI81eO3nSy7QrezuvQeCdYempUQYu0KkR/SMYcFbYCzz+8UrY5QgP4Tu9smSWO6y
	uGPv2ZqaImaBYYCpBo5s1OwVbrFIUzBjLtX5QFATaEfxuPOGwTyNDHOQPy5BSJN0
	xK0hhLn1Ix6Y/QDznmzKYXQqu11PjCjOMv2gj209lbp7Oklmoja4VD4Rcdzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725284485; x=1725370885; bh=MQ5SdmLrG2KMnWRKYZ3RMWhjy5tT
	/BsA3+yaSOcoT1g=; b=NcnASHEj/AFCZAIyqzBADR4tDQ5wmFbpcHe6jRlVobDw
	GA9Gq780omP3pCMTsBvHldzN4VklMyLAEkqvgF8xZeU8Qyg8WwqYX4mAkKS3y4a6
	xFVUZFlVxNqMY/9Y5HdvsyyjsxVNrPg2WWs4u1EhlkQkrlwOV7u2lghOhCOOWtaf
	43eHexowi1/ZmicpYKSFF7La3US3cVPPpeBxDyIMJtJluUX6un/8dHq/ugSKgsmS
	BjLuxTvH6lQgR6v9m9MckrgsXqu1PI1UAceGv2DeQ+hXBNFzfTPv8JojRo6Yuva+
	zUOkkJaj1XZYHJFyWUYHewu5XK7mS96IeonN5p/o1Q==
X-ME-Sender: <xms:hcDVZowLXFHUtP5KJ99DywC_CGEt9RrgYOeoqz6r1aUNStV6FYLzhg>
    <xme:hcDVZsTOlquMigPQQVXWFDr_2nfxZFJBXM0tT4gxFNV1GFOC7jpQgA8g8AX_yf6io
    6ID7tZZSXsDWBUoNw>
X-ME-Received: <xmr:hcDVZqV5ChlenKOGlNa1jLd_xXcewMICfJoVxRjOklbftYAWbP400hhXttTXGcyNBz3wMWrD9x2kHYrdklnKcxW2DVA_O6YiBltuEbRYcAsgEkI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdp
    rhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:hcDVZmh1v5EDqwOwOiwYndq-GKhM5ZFXzg8o_P9yYiZHuTDqWApDmg>
    <xmx:hcDVZqAxJLqup7qmL2jQS_RQWQwMHGSRpL42dTSH2Y9hyHqnwjLefg>
    <xmx:hcDVZnJ9Zcax0WPEuU7U-oSHDxHJ_Fk2kaImnc8wobpe-pQsMjWiZA>
    <xmx:hcDVZhBnoJvspbQ7RJZrmwhkUhTzx7KDW6HmLsaK2U0Vagksma3mMA>
    <xmx:hcDVZs1rU8ejvu6BtZfNoENHfND-_IlbpV48iDPrhvFOIEEg0YKQughr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Sep 2024 09:41:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0a1aa932 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 13:41:17 +0000 (UTC)
Date: Mon, 2 Sep 2024 15:41:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] sha1: do not redefine `platform_SHA_CTX` and friends
Message-ID: <ZtXAgFfhaoTxF1tC@tanuki>
References: <cover.1725206584.git.me@ttaylorr.com>
 <e7cd23bf4cd232fa2ce610284199996383fb3323.1725206584.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7cd23bf4cd232fa2ce610284199996383fb3323.1725206584.git.me@ttaylorr.com>

On Sun, Sep 01, 2024 at 12:03:21PM -0400, Taylor Blau wrote:
> Our in-tree SHA-1 wrappers all define platform_SHA_CTX and related
> macros to point at the opaque "context" type, init, update, and similar
> functions for each specific implementation.
> 
> In hash.h, we use these platform_ variables to set up the function
> pointers for, e.g., the_hash_algo->init_fn(), etc.
> 
> But while these header files have a header-specific macro that prevents
> them declaring their structs / functions multiple times, they
> unconditionally define the platform variables, making it impossible to
> load multiple SHA-1 implementations at once.
> 
> As a prerequisite for loading a separate SHA-1 implementation for
> non-cryptographic uses, only define the platform_ variables if they have
> not already been defined.

So we now pick the first hash we find as platform hash, whereas
previously we would have always picked the last one? Hum, okay. A bit
curious, but let's read on.

Patrick
