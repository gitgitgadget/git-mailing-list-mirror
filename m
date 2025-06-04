Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9A42A87
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749045365; cv=none; b=l8xUZX/L+OnjsEqpnKjbBxRW1XQYTTUvjoiYxzgGjdj/tSMBNrHKuQnOR9+nm+KKA6JK3fPWg7JJItT3NZHy5hDdRWykKYsQoawlRINOzDhonyPlm/F/8liWoEOkjC8yD/1Ke6soRLb0tIsf6wjnqNJzygPFyqJNgM27rbAZkNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749045365; c=relaxed/simple;
	bh=VtnwpGpLLpuFonGM+l11ip/Ahy77JdbKaTaUvkB3H48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4pw5xUbqKqL9MFqMU9wEvjjfAXinS8kiNKK7rwVCRsuKMYVwaWbGMRarbjA3ycqZwc2p20tWuc0UE/tmR1HWpM828NQRwg2+KDCjH/XmjJJzvznPAV6WDehPmG37FQBRrcSUqpzdaJZd1dxzv9fa9OZa2l7J8q+1EQZKZloHdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c8ZjIVlJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XgTiifrO; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c8ZjIVlJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XgTiifrO"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 92AAC13804C7;
	Wed,  4 Jun 2025 09:56:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 04 Jun 2025 09:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1749045361; x=1749131761; bh=0b1pFYjVzg
	+llTX7mRjKvUMy81hC9ZaLHhi5TleqeIw=; b=c8ZjIVlJIgvyyDhj2LjmQJZEWb
	JDamaimJwbhMFFer1xZeWZLIjxw7/HKybp+k+JefGoDad52bhkcz2Lx2m1/HU3dw
	yCj6GlLS2OflQeRZiJGaDJj37b627SoQ80lNbxdRxzug7yLPCDN/xX8P92e/pZKS
	/YcODVV8gZaJz6tLGkFQOSm55fgNQZBXFYQUIJoz8EzQyUBvfOqHCg7duTykGu0Z
	qrkOYUZin+8jV79vGCh3K+ITz4IaW5dzrIZnwtxVuOKHfvAVv9xlxmThgzZBix6S
	RbY6LYJT+lqcGunR4s7+g6+kYB12f6yhD0YKCFl9LHvum2KN9JowopLBrPjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749045361; x=1749131761; bh=0b1pFYjVzg+llTX7mRjKvUMy81hC9ZaLHhi
	5TleqeIw=; b=XgTiifrOG4dOhYjI4GQiSuxblQ3R73LlO/iN4MrBiPGND6NYZLV
	ey3eGVRuN5FoomHqPtx4/9RqySqkca7uyRDleM8e0K18XUqxGZ3LGPhblZPNlKW/
	VyM7DWy2GPB/Lp0Ii4WGuChhEGebIkaWC52flg7g0Fl6wC0dxVwDzONrZpkIegpj
	sLdCnQAAog7VRZ2gBKHPHQcDKPk+sJ1LUbvcUEoNwvtGuELr24l3Oj5XHb5drmQz
	DP1x5J/2OV0lmfvNfH63cI4TaOshjmPjD4R/Kvs205RpYJnOGzdi+N/NCjCV3Ey7
	kM6dV/nAr/qIHZ8Eh98W0o23SlIErrxCFSQ==
X-ME-Sender: <xms:cVBAaCWS0c-2bbWWLnt0qjjqVVXt2A22lEsB0-hB5DktXCUKlvxg3A>
    <xme:cVBAaOmTmt1Htw8Vo5ti2UFsZ4Q06fTny6Bykz9ym6bm4F85KEqQjwrATpzqMACrM
    ae0oexWe90nQs1TXg>
X-ME-Received: <xmr:cVBAaGao4JuvcKP_RUqSySYkPKs6AFQXqovdQnW_f8dFhlSftC9p8I85ZWpBHnndponuWPBXhCfIEDSEtwCKd61NzDdMhAJmPMDl8svNC0bB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cVBAaJXD3iz-Pt9r9PXXMtREljAPDN-ZiaPmPIZekj_3-hXvJpvCaw>
    <xmx:cVBAaMnoMP6tg724ofWvz_jK34KQQ_HNBa_2R6vrGEaK31APUBmJfQ>
    <xmx:cVBAaOdPKpTydMakjyH-iGZ2jIBviqehGQCvtrL4XhiZ0cn_XFcCpA>
    <xmx:cVBAaOEgX4epwLsukJ7pldsIDjGQ84T2KLmLFLJVVU2hIVGVydUp8A>
    <xmx:cVBAaE-4TtAPe9QvLQWtlk_C2BwSg6fEgnO8iPIVHPOuqg-BoBDjvBS8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 09:56:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7c636d25 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 4 Jun 2025 13:55:58 +0000 (UTC)
Date: Wed, 4 Jun 2025 15:55:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 02/17] object-store: rename `object_directory` to
 `odb_source`
Message-ID: <aEBQbWre85PSrWqt@pks.im>
References: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
 <20250602-pks-object-store-wo-the-repository-v4-2-e986804a7c62@pks.im>
 <875xhb3ahw.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xhb3ahw.fsf@iotcl.com>

On Wed, Jun 04, 2025 at 03:24:43PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The `object_directory` structure is used as an access point for a single
> > object directory like ".git/objects". While the structure isn't yet
> > fully self-contained, the intent is for it to eventually contain all
> > information required to access objects in one specific location.
> >
> > While the name "object directory" is a good fit for now, this will
> > change over time as we continue with the agenda to make pluggable object
> > databases a thing. Eventually, objects may not be accessed via any kind
> > of directory at all anymore, but they could instead be backed by any
> > kind of durable storage mechanism. While it seems quite far-fetched for
> > now, it is thinkable that eventually this might even be some form of a
> > database, for example.
> >
> > As such, the current name of this structure will become worse over time
> > as we evolve into the direction of pluggable ODBs. Immediate next steps
> > will start to carve out proper self-contained object directories, which
> > requires us to pass in these object directories as parameters. Based on
> > our modern naming schema this means that those functions should then be
> > named after their subsystem, which means that we would start to bake the
> > current name into the codebase more and more.
> >
> > Let's preempt this by renaming the structure. There have been a couple
> > alternatives that were discussed:
> >
> >   - `odb_backend` was discarded because it led to the association that
> >     one object database has a single backend, but the model is that one
> >     alternate has one backend. Furthermore, "backend" is more about the
> >     actual backing implementation and less about the high-level concept.
> >
> >   - `odb_alternate` was discarded because it is a bit of a stretch to
> >     also call the main object directory an "alternate".
> >
> > Instead, pick `odb_source` as the new name. It makes it sufficiently
> > clear that there can be multiple sources and does not cause confusion
> > when mixed with the already-existing "alternate" terminology.
> >
> > In the future, this change allows us to easily introduce for example a
> > `odb_files_source` and other format-specific implementations.
> 
> Sorry for being pedantic (but I guess this series is all about naming
> anyway, so better get it right), but wouldn't this be
> `odb_files_backend`?

Maybe, maybe not. In any case, we can still decide that at a later point
in time -- it's only part of the commit message, so this part is not set
in stone and can be discussed once we introduce such backends.

Patrick
