Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDFC146000
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810310; cv=none; b=lvxfOdW1Pw6vbWZSSTu1melBUlz6jrOwsq5A0w9mkLyC2/51zLkeawgy9vP5Xrh8SsDy5TuzOwiyaSk9/niSEB7vSSO34AtClxwQ3mxtrvjz/0ZW2koQ4ERsZCVHsyKl0yeZXXk5PFCTxyp5KtN4ZK476xkWqNxrg2kh5zS+TGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810310; c=relaxed/simple;
	bh=a3aGWD9rku5rBDwYCQcAPOPMDVDj5I2NtaJ6e9OtYF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBLZb7//TwIX378DfaZQjgVDvxdSnFWJOjv+XU6zx2yk5fI3xPZ6c5iftjEV3voKfqrUfpCYc2dSrrFkJ8UDkLutZD41wjMFoIPD4Rh8WtDercp/eSm1+iBH3Pz8DCm8bBigPeapMc8HH8vVNQH0asDx2BVdEUyG371k7gr0Z08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lvzuWtsr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LEACoWmJ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lvzuWtsr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LEACoWmJ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9C4E71140137;
	Thu, 28 Nov 2024 11:11:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 28 Nov 2024 11:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732810304; x=1732896704; bh=2Ay3wrHwOF
	+Qz2Ik2aAZI/0VqPRhqxw8pxXcwU1nh58=; b=lvzuWtsrah1elEw/POkV7niUxs
	c7d36QR4TT9JAW9t+zPSz0GS7xTMLVuQedrQSHLdGZxzwGzFEW/T4zD1UUeI2niu
	rM17cTP8juCsUqq2XRR/uOrc+Rtppn06iHi2BibhHxFEBe0kRAD30Ib7nLuj8up9
	6Kusc3+rXxmV/mMoJftLJiZtwFQubnF7SOP314oGfvKYgn4279xkJMA+4/NU42CW
	RrQU9NJQ02J84pswAWr2jknSpwCCdJeiTYtas/OSuOSG1yilaQJMM+qsLaR+iGbm
	Vtk+0Z/yEHagHMC83ClPzi6SWbVn0Go3pVbDPxsqrCLoTYsWX8K9a9c7Ke5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732810304; x=1732896704; bh=2Ay3wrHwOF+Qz2Ik2aAZI/0VqPRhqxw8pxX
	cwU1nh58=; b=LEACoWmJuhhfc35ySmDtoe7VXn0xIFfexpErFyMDWx7swPHwAxZ
	GueCcJANTrf4UcigYVUlM3uMFSHhb0WOtaPMPrKWP1vbdN3lZUmj7eubF6M36xyu
	h2tX7ziA3GFZoNhHwBghiTwGzsYgG0J+WbJ4PnxCzomMotASa5GbMrvo/3rzaHi4
	JrlqdBVq0dBVRXg3UJ/MXzRLAEhozJ8IhdRzLKhsIFlL0OM0XheE+q9DXXTk8/lQ
	Wi25Gr+FZ90AxgGdfaGPZLKKXNx29eBE3UVAO4buoPs/p9FBGbdaE6Ju3BnUhWaV
	wLD50Efac6y09jKoO6tZc65z8tQVY2Nb9MA==
X-ME-Sender: <xms:QJZIZwlH3YRGuKlvg3rhdu1nRepiR58uQUeTlPT_ZyspRNc_GPnjJw>
    <xme:QJZIZ_1wS_K4kyWswTlExzU6-scmO9ZtxcDfUrWOEpPZpnQuGQtqRQhqVHnTWkEMT
    1-6_vt8LolaH6GXvQ>
X-ME-Received: <xmr:QJZIZ-rBPnjPwdRX5HkwriB-5iChzvtg8yj7cf-e4MQe6J-pDJZGGor2ZxwhuTClQE54GQ0vEcXQT_XDVI8ut7tVZIkqJT5KLjiZ67lWoiLcew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepjeelhfelffdvte
    efiedtkeeuteffgeetgefhieeihfehveejvdfgleehtdehveejnecuffhomhgrihhnpeht
    ohhgvghthhgvrhdrphhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QJZIZ8k4jInC191DO6d_TBiTd0Jxp1JXUtRjBc7Wh_5aEvUpiN1eDA>
    <xmx:QJZIZ-2HSG9pmcPFFZhUCfPWGq9sDWGGPZ-AD5a2pLrMAjP9vQp_dg>
    <xmx:QJZIZztqY-FJWanRlb2UbX5V3m9tcvLDGp6nKNaFgQNyqMXRj18N-g>
    <xmx:QJZIZ6XOxtP1omWl-IJatO5Q9bV1Uj1o0LlwSfSjsuu10Rea0TawQg>
    <xmx:QJZIZ8DF0flHYYidXkwdJy3SS5NXcg8BZPvDbIWw5C3qryvok-P4KC4i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:11:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id adcecbae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:10:32 +0000 (UTC)
Date: Thu, 28 Nov 2024 17:11:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2024, #10; Thu, 28)
Message-ID: <Z0iWMKttvtpK6f6m@pks.im>
References: <xmqq8qt3q5t1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qt3q5t1.fsf@gitster.g>

> * ps/reftable-iterator-reuse (2024-11-26) 11 commits
>  - refs/reftable: reuse iterators when reading refs
>  - reftable/merged: drain priority queue on reseek
>  - reftable/stack: add mechanism to notify callers on reload
>  - refs/reftable: refactor reflog expiry to use reftable backend
>  - refs/reftable: refactor reading symbolic refs to use reftable backend
>  - refs/reftable: read references via `struct reftable_backend`
>  - refs/reftable: figure out hash via `reftable_stack`
>  - reftable/stack: add accessor for the hash ID
>  - refs/reftable: handle reloading stacks in the reftable backend
>  - refs/reftable: encapsulate reftable stack
>  - Merge branch 'ps/reftable-detach' into ps/reftable-iterator-reuse
>  (this branch uses ps/reftable-detach.)
> 
>  Optimize reading random references out of the reftable backend by
>  allowing reuse of iterator objects.
> 
>  Will merge to 'next'?
>  source: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>

I think this series should be ready, but...

> * ps/reftable-detach (2024-11-19) 8 commits
>  - reftable/system: provide thin wrapper for lockfile subsystem
>  - reftable/stack: drop only use of `get_locked_file_path()`
>  - reftable/system: provide thin wrapper for tempfile subsystem
>  - reftable/stack: stop using `fsync_component()` directly
>  - reftable/system: stop depending on "hash.h"
>  - reftable: explicitly handle hash format IDs
>  - reftable/system: move "dir.h" to its only user
>  - Merge branch 'ps/reftable-strbuf' into ps/reftable-detach
>  (this branch is used by ps/reftable-iterator-reuse.)
> 
>  Isolates the reftable subsystem from the rest of Git's codebase by
>  using fewer pieces of Git's infrastructure.
> 
>  Needs review.
>  source: <cover.1731943954.git.ps@pks.im>

... it depends on this series here. From my point of view it is ready,
as well, and has gotten a favorable review by Karthik. So I wouldn't
mind if we merged both series to `next` together.

> * ps/build (2024-11-26) 24 commits
>  - meson: fix conflicts with in-flight topics
>  - Introduce support for the Meson build system
>  - Documentation: add comparison of build systems
>  - t: allow overriding build dir
>  - t: better support for out-of-tree builds
>  - Documentation: extract script to generate a list of mergetools
>  - Documentation: teach "cmd-list.perl" about out-of-tree builds
>  - Documentation: allow sourcing generated includes from separate dir
>  - Makefile: simplify building of templates
>  - Makefile: allow "bin-wrappers/" directory to exist
>  - Makefile: refactor generators to be PWD-independent
>  - Makefile: extract script to generate gitweb.js
>  - Makefile: extract script to generate gitweb.cgi
>  - Makefile: extract script to massage Shell scripts
>  - Makefile: use "generate-perl.sh" to massage Perl library
>  - Makefile: extract script to massage Perl scripts
>  - Makefile: consistently use PERL_PATH
>  - Makefile: generate doc versions via GIT-VERSION-GEN
>  - Makefile: generate "git.rc" via GIT-VERSION-GEN
>  - Makefile: propagate Git version via generated header
>  - Makefile: refactor GIT-VERSION-GEN to be reusable
>  - Makefile: consistently use @PLACEHOLDER@ to substitute
>  - Makefile: use common template for GIT-BUILD-OPTIONS
>  - Merge branch 'ps/clar-build-improvement' into ps/build
> 
>  Build procedure update plus introduction of Mason based builds
> 
>  Will merge to 'next'?
>  source: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>

I've got two small fixes pending, but other than I think the series is
in a good enough shape for a first iteration. There's of coure a couple
of follow-up steps that I plan to do, like wiring up CI, but I think
it's fine to do these in a separate series.

I'll send this version out in a bit. If you decide to merge, please
note that the tip of the branch is only for compatibility with "seen"
and should not be merged to "next".

Patrick
