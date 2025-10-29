Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCFD311C20
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768446; cv=none; b=e6ACMiAuglCpA6zFLvG1DKFAuVjNpL46kdAzSfXgR/3TtUm2ZI7d8DGYkqHBfhQ7lyEzk5i/AZMd463lx2rzizIyhbIUYRKoXLRk09JmHBxLP5hKCfKk4u24gyWlUTggMFfX9H10xAAOGqgtc/YFL5TlEL+1lVln4uQCnJjZDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768446; c=relaxed/simple;
	bh=7UpNyMnc3qNG8tJAC6X3M1IAXbWbzYdLliS7rWdkoGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hYChwVjO25Okdm25u85hITTTtVagewsonDdIqZqjbaWKXhRc6w7+G9jQN3HPMKSBAIP+rqdncY/HogBxvW+INqCw9SmIDOxh2DmbqdqHAMKoFEtv3BDxsihD7xSCdxySL6nFzochigebx7hAbUQ4vgRETllkLhBo3+NKB05daRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QwzAjIBx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i0/3hPR+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QwzAjIBx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i0/3hPR+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A8167A0062;
	Wed, 29 Oct 2025 16:07:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 29 Oct 2025 16:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761768443; x=1761854843; bh=/EcjXMa73A
	2V1q8bgp/jb1jkDYf1U3hSvumYpQnzYEw=; b=QwzAjIBxAElD6kO27z3TtoJCim
	kQXoX7cJ8LRUKAh0xiNDIzdAtwSvgy+eYMad6Tv5QafbcgrAkKk6NWocAtGnIN0+
	ZTa+HQjdedFt4o+bWi+skrOVIMmubqdII6EHmm5u3GUWUHFrdVe88NkUgmIa8LIs
	mpk6T8QUajreXxtLh4FAVIYSB+HGwQx8ZgbvpOxvPIau2MGHObiFFpQivQxCsfuK
	DRI3vFfLxWEBoDRxQmauMMeuvbGZkif+kx2b3GvDyhWQB0qBQeSzDTNWcd1jnCsd
	C6iduHrf660a9hXoNxQOcOUtHOJS3YTsM0Rqw9Tl6JQcJb72NeA7oELqJMnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761768443; x=1761854843; bh=/EcjXMa73A2V1q8bgp/jb1jkDYf1U3hSvum
	YpQnzYEw=; b=i0/3hPR+h1P5xe8ZrLeNt+sH3fXRmE+nRwYSPBypqJH1xF7wwO1
	XMeplSt+OYbbGq4CLlESP1KSeJfPX8RZArNKUNgDgDXks2qh7ss19ishKyfgcFKY
	JPWlPquRx9bELV17Bf8K6tzd22OZrkbWlPQZvYnuPg/OT1uQuxl86TX2OIXXsQOQ
	RBa/kjNBAATkTEj8hcff2UFhKdg2OBxO7sVigzkRdpmol/wC9IQt86MfwLse9jMZ
	vD1mQm9G/XAWOnS64CT1MjnYkZdS60fODkh1tEM01BdMxukHlbOsoA5bjiUr5YqO
	Qem9T8WcGm6BposQkihJvR79zr2g6lTch3g==
X-ME-Sender: <xms:-3MCaVmSot9VAyOvhsSTTUL-vXj_GGOCf4ZGXErnMkxMLCAy8ADyEQ>
    <xme:-3MCaXss7XpEnr886cQJF0B0aprZCVd2yQTvGf0p_yugZ-B9IGsgQfApgvmUE_TWX
    W5AwdwjD9Q7PY_AJQyN0pbvpRKxPayKBt_KmcJwkYN6-3Brcl0>
X-ME-Received: <xmr:-3MCaT8FabsUlrukJBQTQGRlmBeDGXRAJB_jCtL3UHRsW2A2-aLWYv_qoT4FsPtwccKG1pJSDRZTJOvdo94B3butahinX39iTwQL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieegieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgfetudfgtdekiedvveelheeuueetudeljedtgffgfedukedviefhfeejvedv
    leevnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidr
    tghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-3MCaRMAIySVLTGBPl8IiPskTQyF8oAQ5-Afrp4XxlgwRIJAqu-8TA>
    <xmx:-3MCaRHXkZXyT2S4rVeSqqeP2_91MFD9zDBPFzMmkroDC_NctSauqw>
    <xmx:-3MCafQx-rt43DoBf4UHKhBlcLgHK2e7QtIAASr85IEQ1N2l9ADvsg>
    <xmx:-3MCaevEkc1gvxEyXQ1MHinvTmH59M9aI444gkNXSayNCW78Tyfgww>
    <xmx:-3MCac8miI-flBOmJeG1SPkEuzH4TdiI16buKWg7xNC7RWQWrN5sZFhU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 16:07:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 00/14] SHA-1/SHA-256 interoperability, part 2
In-Reply-To: <20251027004404.2152927-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 27 Oct 2025 00:43:50 +0000")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
Date: Wed, 29 Oct 2025 13:07:21 -0700
Message-ID: <xmqqecql8oau.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This is the second part of the SHA-1/SHA-256 interoperability work.  It
> introduces our first major use of Rust code to implement a loose object
> format as well as preparatory work to make that happen, including
> changing types to more Rust-friendly ones.  Since Rust will be required
> for the interoperability work, we require that in the testsuite.

So, "make WITH_RUST=YesPlease" on 'seen' seems to barf like so (line
wrapping added by me):

    ...
    AR libgit.a
    CARGO target/release/libgitcore.a
error: the `cargo::` syntax for build script output instructions was added \
	in Rust 1.77.0, but the minimum supported Rust version of `gitcore \
	v0.1.0 (/home/jch/w/git.build)` is 1.49.0.
Switch to the old `cargo:rustc-link-search=.` syntax (note the single colon).
See https://doc.rust-lang.org/cargo/reference/build-scripts.html#outputs-of\
	-the-build-script for more information about build script outputs.
gmake: *** [Makefile:2964: target/release/libgitcore.a] Error 101

We either need to downdate the syntax or do the following, but IIRC,
1.77 is a bit too new for the Debian oldstable?

 Cargo.toml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/Cargo.toml w/Cargo.toml
index 2f51bf5d5f..7772321dd7 100644
--- c/Cargo.toml
+++ w/Cargo.toml
@@ -2,7 +2,7 @@
 name = "gitcore"
 version = "0.1.0"
 edition = "2018"
-rust-version = "1.49.0"
+rust-version = "1.77.0"
 
 [lib]
 crate-type = ["staticlib"]
