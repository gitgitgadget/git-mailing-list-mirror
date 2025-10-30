Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F096834D93B
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817846; cv=none; b=ZJHrqM5mi9XHGo9ZkWf+tgpbgT2B85g4HwVy9KDcg8n8XGgpi3jVrks6NCkOR8F5EXozjfxpio03KM47eFfXXemITFBJqh5j3xFxmUC+NLQOWrf5F7iVvncIBNSUY8UNeuAO0TFlGkaoiAnjdkFhr4ze0sSZeB7hHj3aIQUC2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817846; c=relaxed/simple;
	bh=of6Xv678uNH39/09aDF7KNeBM1OpuV6RuahfJ9h3cn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjbOf5iVFU86Ja6LuR86sljGqnC62E1Qq3rN38ZH+AzTItC0XSyPiNGq4AayVssE1k2K/B+5ObndedkufLK3GDTYQNe+0fvav8YVWeTQgDqf/Qhn0W8ULNiI9GYMu2dZ1nxwsD5FsWPrTIXt9th01kRF8zxInHZEPOWFhG1NoQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fKRt/LBI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=quUOhly+; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fKRt/LBI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="quUOhly+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 15A1C140015A;
	Thu, 30 Oct 2025 05:50:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 30 Oct 2025 05:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761817843;
	 x=1761904243; bh=nE2ixwjontfKrQyrUtEhIoV8nVWprYL1rZo+VCQ3ylY=; b=
	fKRt/LBIWUh+iaNtbcPUdNFcO6VxQAG+hXlKRt0ZOb1luVVoJpB4bDXV1zKkx0Bk
	Obzd4CKIgtqiLnkcDUEJFbo5WIlPK0hfGmFBK3gYd9LnpLf57rkKiwPN+VZg2k22
	qVE5DqDa37u/RvZ/EtpypntHeQEJKtlABwjI9nY6xDRIrOsnugyWTDCWXxTI6KRp
	5GyxnT+NV5Pq0XZ6/vVnUbSCcl7OpESPKCrNtPgxDw7Gj6PkcJd8WblTYXRKE55w
	lZCSccBZRwtjfmL9KlDA99agSdKxeHeuEHkBfQ6519BcLtcyHTUCFEDJRj2JPYQi
	iLTne0KPSWnN1AaT7CyMcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761817843; x=
	1761904243; bh=nE2ixwjontfKrQyrUtEhIoV8nVWprYL1rZo+VCQ3ylY=; b=q
	uUOhly+4yk/0UbEOGytwCqQjl0SD9atQo+yk9glDkCpgg+ZoZJ7J44nYHO36b9hG
	wl99qzGJQP0ToBO1BRNwLNXbMgWUPj1WumKmexW5bGQbl4X35ozqSoNRfdar9OaQ
	9thDFmFfkgaQYGluIGbIwAzojE5GdbGNcg6KxEhPtCZGL3e6cdMrZ1CWZnY2wTKD
	FkylfgMYdvz3W7tA3Dwuw7hBfLo5WH3JPaDMwpAhioWjLMiBNXOIlFEca4v9Xo/n
	QP7lKQzSLQzpjVmlGIdHe/L/DHBHUV35Zwz7ySduViIlE1uUuQ/ZrZb5jwVsFlmH
	7GY7J6+OD9PrAptKbcnCg==
X-ME-Sender: <xms:8TQDabbZDA233YxlbCJvEuosuaSiP8R3HKIqZDyusgdIyhKNmavIjQ>
    <xme:8TQDaRb3CAWVJYsohzv25RTyONUwF1pd_iteKlp2RK4Y3SHWG7oBFlfGpxcfB6cK3
    8KfvpGkWaQnBfu8m_p4ubRpN7BroUmuh9hScsMItCM29kQBh_Av>
X-ME-Received: <xmr:8TQDaS8GAX010rgPiP2WQrufreEFPAanS2ZDkdHpvOs4cdXp6OjWvVEcquLTkkUPrOfexfRFDK_KDiuWZMYwCvJbM9CxAjwPM6xHPH7eWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeifedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetheffvddtleettdetueeukedugeettedutdegueeukeetheefueevvdeitddtveen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshht
    vgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:8TQDaQjqcXNhwbObVWRXuI78qEs0RS6Fc51Q1a4RklKOoyEwoPraJg>
    <xmx:8TQDaScLZdxI2OJ_HupizcwdIAMWf7LULIRuNf4WvgV5qr_rG3Xa3w>
    <xmx:8TQDaXoXlQcFluwFs23ROQbBN5mI4aRXsA5PQ3AnKsuWkeWkAKazzw>
    <xmx:8TQDaXCu9SUnv4IlczrXLs8nJS80pgtZb3oTFZ6vAYTR9ARe3dZL5Q>
    <xmx:8zQDaTD-FaQunqS8ymbC4TfJE-NQA8ygOMZ-_5zlCXXGCwscUxnLS8D8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 05:50:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b9ba8b40 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 09:50:39 +0000 (UTC)
Date: Thu, 30 Oct 2025 10:50:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren <ezekielnewren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: generate bindings via cbindgen
Message-ID: <aQM07BQrGJocPKea@pks.im>
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
 <20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im>
 <CAH=ZcbADTLvTioBf+LYQej1G0biZM8s3-iJG+BZjnpxj+8NjsA@mail.gmail.com>
 <aPsepOtUf92fqDL-@pks.im>
 <CAH=ZcbBWuS6QVQT4LsxSP-X4GupZwr+NwzXNH2+qZGoufUWDrQ@mail.gmail.com>
 <aP_gy-Rj8MI7zAWd@fruit.crustytoothpaste.net>
 <xmqq8qgvfyq0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8qgvfyq0.fsf@gitster.g>

On Mon, Oct 27, 2025 at 09:15:51PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > On 2025-10-27 at 20:35:59, Ezekiel Newren wrote:
> >> On Fri, Oct 24, 2025 at 12:37 AM Patrick Steinhardt <ps@pks.im> wrote:
> >> > > cbindgen is a Rust crate and it should be specified in the Cargo.toml
> >> > > under [build-dependencies] block.
> >> >
> >> > What is the benefit for us? The generated code is not a dependency of
> >> > the Rust code, and neither do we use it via "build.rs". And if we use
> >> > cbindgen via "Cargo.toml" we'd be forced to build it first, which slows
> >> > down our CI jobs.
> >> >
> >> > Please let me know in case I miss any reasons to have it in our build
> >> > dependencies instead.
> >> 
> >> You're targeting a very old version of Rust (1.49). I'm not even sure
> >> that cbindgen will work with a version that old, but if it does then
> >> we should use it in build.rs to make sure we're not using any features
> >> of cbindgen that aren't available until later versions.
> > ...
> > For instance, I'm using Debian unstable with a system cbindgen 0.27.0.
> > This requires Rust 1.70 or newer. If I use rustup to test my code on
> > Rust 1.49, then the code won't compile for me.
> 
> Have we even agreed on which Rust version we would aim for?  With
> BreakingChanges.adoc We have agreed to make some version of Rust
> mandatory by the time we hit Git 3.0 but IIRC, there isn't anything
> written down except for an old message from you
> 
>   https://lore.kernel.org/git/ZZ9K1CVBKdij4tG0@tapette.crustytoothpaste.net/
> 
> that expressed your preference to support the version of Rust in the
> latest Debian stable plus the version in Debian's oldstable until
> the latest stable has been out for a year, which nobody responded
> to, so we cannot quite say that is the consensus of the community,
> yet.

For now that Rust version is 1.49, and that's enforced by our CI. The
reason for this specific version is that it's the target version for the
gcc-rs folks, so it may help currently-unsupported platforms to get
support earlier.

But I made clear in past patch series that if we have strong reasons to
use a more recent version of Rust, then we should update. I mostly
wanted us to do this intentionally than picking any random Rust version
and saying that "this is it now".

Patrick
