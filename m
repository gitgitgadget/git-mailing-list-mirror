Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F23081AA
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403640; cv=none; b=B1Fe0wEtWsgigmt5KpgRLG5A3xgd0a8BUbVF882xDjcupnnVlb8fNM2bHNpJ5zXWyc4p44+NU956HVmYuoXyjlaVCYnX7w4914wnre1p3FwLz1JcHvEvkvn9RHPls+Pe+4/JxrtNFGiZekwTSDDXPSdQgumvylhzCO9Jc82NhKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403640; c=relaxed/simple;
	bh=E2H8g2dbme7x6DI54SuryoDDM9ISgoxKM+IWKsJ7fys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs9i2yEdzzpedlJozwZPR47XkheJ84ote0Bp79rwj8oh0waM6p0nR5MaeqXpnSoaYwiDjNiDrhEtsAc2itqzcT4Ux2Ke5RurMp13DjsyP8oE7ZevtzQ1zA4wReyEkgvneBSchWdE3F32SkoorCQR9EjGUfvfAsV9QrfZy0o3/fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fEkYw6Ui; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lZwfz/JJ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fEkYw6Ui";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lZwfz/JJ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2986B1400140;
	Tue,  9 Sep 2025 03:40:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 09 Sep 2025 03:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757403638; x=1757490038; bh=BWoeCMu5ov
	/zW1kXjTCnKoTgg8DmvU/YYWYWo9Tdh2k=; b=fEkYw6Ui9HyAxXc6sSTDSYmT0V
	TB5fv88SXtISdwOIl9iw5fESzxBhW6nJx/S6wNHnLrcsugQubuWmwFacE63NFudL
	RUOEiY6mkrd+RRMjDHbFMCdWcBvo7BVKAUAEa+vRf9D4mUPS40S92a7aqsi8pDAS
	8o151rQQitTsheO+mxHWN3feB6ULWJQ3ruYj0P1jKpp9ocaX+nDFnmxHefRMyUm+
	DQgRLC+lhLKhwr/2nS/FxyOgW34XcfQEVnQimMDW959D0F+Akt3fO2xhIgvlQftf
	VZOZIPhBmn7SCGzOFVG6GQmPsSgb0aQrYXLLueaA+Uew39xeHkf/8AZpj3zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757403638; x=1757490038; bh=BWoeCMu5ov/zW1kXjTCnKoTgg8DmvU/YYWY
	Wo9Tdh2k=; b=lZwfz/JJ7QI0g6RScJSbl45n6m7JPSE1CTGKtcpNXxRVqQWCVMz
	Qp0LqllnHxG14FVuy8q25EcgkQ1ZYxGCzGeBwTXGn/FRLC59dDRVg3tYv4Th5nRK
	kit993JHXOZIVb492aEBoB/7uL18zhWQJ65czietGveScjnTRSPZQBlG/5f+rIFW
	UjpMEbop/9vMwEhGbpzK/11L4MCFkVmnH764UXkVTiGDZ51RljsNNK/JoC5q7SIx
	QF7w09BFQ/j0bZSZApT+PQFywFCKREe3dvoDNh59tsO3ngxkasb2hxSEz/UunNRx
	yTnmtNPgeYKAC/bvs64XJFg2IEkWj2O6BsA==
X-ME-Sender: <xms:9dm_aIXJ7GpztvUKw5RsmH8EIPnVtonkVxaPiq0nHoYYzeoNJkvOhg>
    <xme:9dm_aMQN9ulxR9i5cTgDSq78DWXjMHkY_Q9ZXXnkl2iEcivifxemIZQUYD_7P5D-z
    rBUdw8lBy1XEn6a-A>
X-ME-Received: <xmr:9dm_aIB6Srkg0SRFVzWnd1XBqSXzx_Cv3zVb1M2hteC2ifGQko1xmqP_G-xFArex-ox61IYGMD5UyvzVadTvI4AtBJhWQO2cckfyIPA5fPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsmhifihhllh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprggurhhirghnrdhrrghtihhu
    segtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepjhhrnhhivgguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:9dm_aDJsE7SWsgWp0e9aD6bnrKAsV6SLA_u8yxBQ3gE2VFlohTNAyQ>
    <xmx:9dm_aDDQdjCRdGKvgBXbVejhjyjhWLuStEOZjqVKTD5aIq9S9oWZmw>
    <xmx:9dm_aIvfrL3DnKHhDd-2m4O8E3l8mk-OMXnuftZ4YVW54xPzCG4LrA>
    <xmx:9dm_aBR7x24wgDYM1dUJCOrMi9Ry7NVF5St3YXAJi4W0UVF6SwKKTw>
    <xmx:9tm_aJwyPMS07JBEYeZMj8WRAMctxzkRfkQxx5FvrYG3XRAetINuppne>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 03:40:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e3b4926f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 07:40:35 +0000 (UTC)
Date: Tue, 9 Sep 2025 09:40:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 03/10] submodule: add gitdir path config override
Message-ID: <aL_Z8DusXdyIr4Ru@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-4-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908140117.262205-4-adrian.ratiu@collabora.com>

On Mon, Sep 08, 2025 at 05:01:10PM +0300, Adrian Ratiu wrote:
> This adds an ability to override gitdir paths via config files
> (not .gitmodules), such that any encoding scheme can be changed
> and JGit & co don't need to exactly match the default encoding.
> 
> A new test and a helper are added. The helper will be used by
> further tests exercising gitdir paths & encodings.

Aha, so you already do what I'm lamenting about in the preceding commit.
It still raises the question around how to handle this whole migration
now, as alternative implementations don't yet know about this specific
config key. Doing all of this in a single patch series will most likely
result in breakage.

In theory, we should probably first introduce the configuration, then
wait a couple releases for alternative implementations to catch up, and
then switch over. But we still cannot be sure that implementations know
to handle this key alright.

A heavy-handed solution to this would be to introduce a repository
extension. This would ensure that any well-behaved Git client will
refuse to open the repository if it doesn't know about that specific
extension. With the remaining ones we can be sure that they know to
handle the "submodule.*.gitdir" configuration.

As mentioned, extensions are rather heavy-handed. Furthermore, this
whole infra is only really needed under very specific circumstances. So
maybe it could be a viable approach to make this extension opt-in:

  - We provide a new configuration "init.useSubmoduleGitdirExtension"
    that tells git-init(1) and git-clone(1) to use the new extension for
    newly initialized repositories.

  - We detect the situation where a submodule cannot be cloned due to a
    path conflict. If detected, we print a user-facing hint that tells
    them to enable the extension.

Once the user enabled the extension we'll know to use new, encoded
submodule paths from thereon and thus re-initializing the conflicting
submodule should work now.

With all of this I wonder whether we even need a new ".git/submodules"
directory. Couldn't we just continue to create submodules in the old
path and for example create a random suffix as required?

In any case, please stop me if I'm going overboard with my backwards
compatibility concerns :)

Patrick
