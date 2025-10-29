Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3D319ABD8
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756232; cv=none; b=n2tlUL7hB9ZpZZTHjVvZ4sPAqyUnRoA1JdSjlK8lNWtu8DO1BLH7goYNm1dcLxgvhyY+7PSEapvj5DS1O41Gw2XW5t5rZ8KEMPOBxYxTq8VsgdVsoL4DGQiegGv0y2yOcqn95xsNOZbpkV6KOGaxg30AwGiBOXsgwv10t9EChHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756232; c=relaxed/simple;
	bh=vMUX4A0Bzhn43Y1Yp2xZSWdOxDy6JYWQ3Ovu3dFRoyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jnZMz3oxBfBuEiBtkGGsx3s5yGKz8cpIvpjxz6TCyX6ApXZFQ0iVUNn849XFidyK0xZDm8TUl+kBSzhfYk8DL+p3E+B7NWjjnbS51MfDyvaRIzBEK0PyFRGdIULQ3aExAmm57EAbTSXZYfVv2KjBC0/p0cQvlJKgzAgJEBFCY/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PoizRlye; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UVCSTiNH; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PoizRlye";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UVCSTiNH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 86D6DEC0B8D;
	Wed, 29 Oct 2025 12:43:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 29 Oct 2025 12:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761756229; x=1761842629; bh=ZJOI4pXwuY
	OAkHyeKvLdFX8xZOUPj0l0HoVHbJi8W9I=; b=PoizRlyectkKE92xRkhMTU9Omj
	X7cnn2p5hvzpKpWqWosX9gC/z2F+LdUBn1GoWGWyVeXXM0R18JXrGeNeVj7+0hrF
	uCpArKK2hgqJ+SJDbJ0xwoErWM118eie9VnRLrTRzl0T1fZqQoRvB1t+nzVSoSAP
	Y8B5LHfPYTeKzR5VReukHxTnNJal8s7woEXRNZH3uCUUKgsSqyHJrrRcmr3ep3wH
	BFjxPAVgTDi4HX8XwTWed7P2SuY+en4BWmG8tRJQKxlgJeupOC4VbYxbCiomQauQ
	ecpotmBm81j0sHGYZAc8goj7CEOXWcP1tfhwepZQKGNOkhtKB80FwKMbnpUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761756229; x=1761842629; bh=ZJOI4pXwuYOAkHyeKvLdFX8xZOUPj0l0HoV
	HbJi8W9I=; b=UVCSTiNHCiQVCPIOimhUNBP7baiyjF0zEaUicP5OP4S780FfIXG
	8BbU2zOofNnQ8L/k+BA8qhY4fiU6QVNrM+ZWHwinh0ObWQvVmuNJfaCtXnR8sgks
	oWyMzNNNLct8wr7ruzJevq4NtxtX/ox23RqUcpMhmZTkYHXsB+UEg0vcZUUlA3MF
	xAAEt5g41xR8MpNuYSFJPJ9H/0htOclsgEIITxQD98JhnlJHsQOldmI5SeG0NTXN
	7J9wlkiLkS5zQ1WLdyFQG3l0FkkDB+uiaBaezlQY7MT7HL9rYAWyCAmuN63FlQcZ
	SAb7U+vnY9IAXmdAWsSSSpmfxvKoDCscIjg==
X-ME-Sender: <xms:RUQCaRG0Ps1UxxOa3MIIS5pCGhZuC-FhOmGgbkdr9sbVRxnIXYiwPw>
    <xme:RUQCadPXUpJR47MDJ0JCk7BlBpGpSmg11Gaezdmeq-rzzGvT7beFMtwLP7nFgTXnP
    OxPqfNTCp5KA4NgyTUEWatjMlqZGsCVfZ_vDEMCEpoyNGIVhG158B4>
X-ME-Received: <xmr:RUQCabcJxE7MMfbccmkTG6IN5compHcDlGpwLuRWCvh35jricJcEKCoLSdp8W2QV1ePGDwPPdT6V-cJx6pr55_yHm4WmOVWPs_m->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieegvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:RUQCaSu3h9ahGaBQ1EJC9fP1XA9xuVqQzqxBnmu1L5JjFJ8Ob6qmwA>
    <xmx:RUQCaUlcE6EXI-cWiR0PYDwLz8FdwlXkKzrTlyM3f55LENm9KJLbSA>
    <xmx:RUQCacw6cF-xa-ESqTD7cKkD6JlmhAkSjOiFyue96FkNNrYxU26YbQ>
    <xmx:RUQCaeOY5ekQLqqnKJzEMGIqEr-6yMxETm7EfmVgbA86xjPVN_umnQ>
    <xmx:RUQCaSdD6zl4VC2canM5goNasY8rEILKhUw4lhmRLXl12m8qpV-zZvNQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 12:43:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 10/14] rust: add a build.rs script for tests
In-Reply-To: <20251027004404.2152927-11-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 27 Oct 2025 00:44:00 +0000")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<20251027004404.2152927-11-sandals@crustytoothpaste.net>
Date: Wed, 29 Oct 2025 09:43:47 -0700
Message-ID: <xmqqms59acak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Cargo uses the build.rs script to determine how to compile and link a
> binary.  The only binary we're generating, however, is for our tests,
> but in a future commit, we're going to link against libgit.a for some
> functionality and we'll need to make sure the test binaries are
> complete.

OK.

> -$(RUST_LIB): Cargo.toml $(RUST_SOURCES)
> +$(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(XDIFF_LIB) $(LIB_FILE) $(REFTABLE_LIB)
>  	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
> ...
> +fn main() {
> +    println!("cargo::rustc-link-search=.");
> +    println!("cargo::rustc-link-search=reftable");
> +    println!("cargo::rustc-link-search=xdiff");
> +    println!("cargo::rustc-link-lib=git");
> +    println!("cargo::rustc-link-lib=reftable");
> +    println!("cargo::rustc-link-lib=z");
> +    println!("cargo::rustc-link-lib=xdiff");
> +}

Hmm, I recall Ezekiel earlier arguing to roll reftable and xdiff
libraries into libgit.a as it is a lot more cumbersome to have to
link with multiple libraries (sorry, I may be misremembering and do
not have reference handy), but if the above is all it takes to link
with these, perhaps it is not such a huge deal?

I am a bit confused.

XDIFF_LIB and REFTABLE_LIB are gone from Makefile on 'master'
already.  Perhaps we should revert earlier series from him?  

Thanks.
