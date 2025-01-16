Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7341F2391
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737033177; cv=none; b=banVWyVvKyzvXbqC85Xa2k1gMlee5VwTTLwR94BuGwEM6ifLKYJyCZvWZR8ZZRCbc8zVbH7klzVc9VCj3S4IMbNcIOnKl5JDfrUKvgu0eMSWcWR2TtReDXngiLT2LNeRiPHlJP3eb9VtaV6j8DZFT3IuI1y2GhP7jd1JHUUfOCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737033177; c=relaxed/simple;
	bh=fRKaSlGjSrpD5qB3gIL9BecOT4vuVLNvXnTiPPy6gfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptose4X90PXk0CpOUuat/mtHZl2wRd3KaOuZuWkI5Zd0QgBwnNxqjg9TSbe2v3M7GNYoV02CQvbgWVuvdM9csxIYJwDNHrO1QLAriNejplQBIEMzfE6yW1vepVzebV1UWbTuR48jCzqNwobLVIMDaspBSEuQHZb8ZoV6P2dMTUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fgLMP/uN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e4AZLcvw; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fgLMP/uN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e4AZLcvw"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id A6C8F11400FF;
	Thu, 16 Jan 2025 08:12:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 16 Jan 2025 08:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737033173; x=1737119573; bh=fRKaSlGjSr
	pD5qB3gIL9BecOT4vuVLNvXnTiPPy6gfA=; b=fgLMP/uNEPBsCNCsAwHvlSvHnm
	/mBb+3ckDLmkT+EDDXkgmg4f+CEQOh7VfHhV/IqvY++VBcn5FgdPgaGp3HqFyDPB
	i6cZHzdJwIKpiVpCWbeNNz5i8zprqYirWAcxG18ihBRb3DKnIMYsVRrO93/+Kwnd
	JVHkPBiLwr1E68CjQ03SfwWS0XZVmUkLATHlCvLQNl2LOLC7A8s/0RN2cSouVK1s
	kMtNGMoK6q1UAH8vt4NlRv+46Wn59Ht8UKIvJHwKyW6VT9jWocFXPUP7V5j6HHo7
	+R1TOT39TwiMxxp6cof9Fo4QeIbko/AbwwbwndM4FV9Z+0MLNkEQW8e7JOcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737033173; x=1737119573; bh=fRKaSlGjSrpD5qB3gIL9BecOT4vuVLNvXnT
	iPPy6gfA=; b=e4AZLcvw77FxjBAajW6coUK1bWe1ohQMVFVY0M3ZK+T5hQjdJv4
	xB4mDfwIiJdPZdzsFmrHUTlRT59Wu0LwS37E6akbdInlhQfp7ofK7UHhU7v47tMB
	tGQBgB15Z6z0Wwoeq40JVW26/IPpv8Ee4N/kqoSV/fUVUvETxkRQd/Mk/3RIzvn/
	FePbdmWMQ94Uo2Ilqcl6nqZB2oaVujxLJKZIICkd3nnbjpexnCRiCyDVKQjIFEDs
	/WG0/Y9RBR42L6dsF2Grpswal5IfZmqCUigybgYmHCDrKkZY7FsQvUf7ECZESEjj
	oZ7EpdY9PSJn3z/opTCL31SnWaAcxEFq8jw==
X-ME-Sender: <xms:1QWJZxWdBUsdJlJRgjpJ6WaHcGjXWXYRVT3L2kTtWWiS4wgjhJbcgA>
    <xme:1QWJZxnc1knVNR8PReN8f-tt4ZUWcs6nBc_Yj3VK12ODwpH53TwDAjijmoUgEBdF3
    t4erYtB1Xo0LX5-vg>
X-ME-Received: <xmr:1QWJZ9aEpgZXmrHCFCadKWznCEWJ1TNVWZpUi1jJDzcRcN8J7225NY3z0AdFkEfK5Vew045ixLzffAOCEKc3DY2-uyr9rK8x7RZRTNnvHsJUgjoEAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:1QWJZ0U_ar5kP5Rs9vcSS-3jAAJFY_6w8BBMLaSq4ymFRvnf6v2W8w>
    <xmx:1QWJZ7my9O23tcxp1G9HrK5wZYgVztYpGHyOQxYMC8-a4A1f4zP83Q>
    <xmx:1QWJZxfrNNuV-YX5FAecAYzvxwqeBQ4NJPQkojQBFzpzX4PLf-O5tQ>
    <xmx:1QWJZ1FUkP4p968RxAUYQZleWTuBHVeHa5KJI5SAGO7ZksOkGYax2A>
    <xmx:1QWJZ5j80Eg84rDBMUSKCrWvd47XZJkOj4iwBrv1_UOnQAJCQcgAbUwK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 08:12:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d2ed11a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 13:12:49 +0000 (UTC)
Date: Thu, 16 Jan 2025 14:12:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] t/unit-tests: handle dashes in test suite filenames
Message-ID: <Z4kFwynV3sQ5Plm8@pks.im>
References: <20250116104911.77405-1-kuforiji98@gmail.com>
 <20250116104911.77405-2-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116104911.77405-2-kuforiji98@gmail.com>

On Thu, Jan 16, 2025 at 11:49:08AM +0100, Seyi Kuforiji wrote:
> Adapt script to translate dashes (`-`) in test suite filenames to
> underscores (`_`) to ensure proper extraction of test function names.
> `generate-clar-decls.sh` does not pick up dashes in filenames such as
> `u-mem-pool.c`, which prevents the scripts from being run. This will be
> used by subsequent commits which follows the same construct.

Nit: it would be nice to provide a bit more context. What might not be
immediately be obvious is that the script extracts function signatures
that match a specific pattern derived from the unit test file's name,
so pointing that out would likely help.

Also note that "u-mem-pool.c" is not a script, so saying that these are
getting run as scripts is misleading. I'd rather say something like
"which prevents the unit tests declared in those suites from being
executed".

The change itself looks good to me!

Patrick
