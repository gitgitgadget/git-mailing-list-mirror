Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF52E2116F4
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744093369; cv=none; b=oXbDbUm6MLdN8eqHdfTT3HW3JXphtMMwmJvIIP3CHbCT3uW6zHbiB0qFNmOZ4gnUDABpsaJKAMp6T1uKIno5pZz6kRKbTRdoaMngZ+nhJjas/0kqbx3z7ZdTjVYAvP/qcvlT0xU1vt2/SN5yDS6k+52+MK8jiC5WwrWa4Uq64QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744093369; c=relaxed/simple;
	bh=lzz5vAXwcwd+uORPImIcBJ3dmo4SrPnhNL6G4OnbtKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RudTkgwVq2M4+DFDbxu9Cw5mFlfYLjD0Dmq/cYf/e7te45nUzEICjtk1+l5LTSje6VtRP2TibezDruj1xpEyag9crDbxU4220y3UOilcJs7bMOTUUJ0fsRw3QT7ACX/A2rSOGNh4CzHoacLQwV6rCGdFB798hI1wxErrVz3nZjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n7MusWki; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T0ggWnu5; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n7MusWki";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T0ggWnu5"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D7C411400E8;
	Tue,  8 Apr 2025 02:22:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 08 Apr 2025 02:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744093367; x=1744179767; bh=DMhw17aRkY
	17UpNhd51+Lf/FNjHd1IWU8qWiWUe8EaU=; b=n7MusWkiXVn+SJvEarjuOV75fD
	CH8E3Ua0gN74gH2Ov4iUv4ODvg4Kxdsa85E93OEJoK0DdmC2NQPqQK6FvYz8cYhQ
	mfMyL5EIWfux8gBtx72SwwnfA+6eMDGuQdK8+W6bd8+mayl/VH5rMLquwBrjq07R
	cxZmbB859uObiLjB2rxpkdjY32CIjLROjwgCt3MXQcJd9gz6H1FJjJInWJElwM9J
	kjFCevtAgfDXYiDl97KxG5hco2EF2aFqW6Y91+rgtJ7zARkbH/sL9iqXSjFKwcR0
	bVfVG/Nw2pz9XDGjrJ0axQlhJdVhFublLRLX0jVRh8ZjFlMtrFO+w7IqFQ2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744093367; x=1744179767; bh=DMhw17aRkY17UpNhd51+Lf/FNjHd1IWU8qW
	iWUe8EaU=; b=T0ggWnu5V4JaY30ILTHdVSnc7jNGizkgol136vYA4Tc+IKOUWOd
	LA+DCUZFs/0xPSeQVylFYyWNqiCfbAfQ8+QyLC+CH26cji1JX7hMj9B7bNOq4UJM
	cvG/hFYc6RukPg5mfNVoNTY4unBu5k5VcwJWZzInjfcdSzbLwGIk9rhuFVmwW40+
	bSar5SLiHNiw8YHeGg9euHz7yDdWS9OAagQrn0GCXUkCJZk23zjtcwdUQfpPLx3S
	iCPZjACJKs5rZ2C3W2A+KkEYFsYVzLOezE66BDXUmIZZAEU82QqpC+SAhr22spir
	vFcOAgWdod37IxeHhteA1NnU2zjsr2s2UYA==
X-ME-Sender: <xms:tsD0Z7-VaL7UiFT6WWSmky0OeieVhxbXch3HhHd9SbQFM2k2JPJlNg>
    <xme:tsD0Z3t4G_8R0vvnsv6g0niN5stgT6V8bgC-KDaErPCDKav94HhGWtnGwBLo5sAby
    2hPW6UgC_bczx2jFQ>
X-ME-Received: <xmr:tsD0Z5Amtf_nt0W1nWNrEKQHIffHbOrode7FPaM1mt9pBRQVRCLIqOM0MRZMm1T6GbB25y1RiVDNUP9waS_9aC_xxEDHiAosyUL7NgR4gJtmTprXVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedvkeehke
    elledtteeiieelveetgeelvedvieelfeekieeufeejhfevjeffgfehjeenucffohhmrghi
    nhepohgsjhgvtghtihhonhgrsghlvgdrshhknecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tsD0Z3c3alJCO4b1Iq711WDQ2VIMyemoWkJMNncNQ0nDuPfjnvkoYg>
    <xmx:tsD0ZwNMBhUDQQMwfo5V1_uSKKY9AmXRc0Y0uQ4bZPLHC-Ayr5vr6A>
    <xmx:tsD0Z5mro8n-Bz1dO6C3wWEx-4pG6izC91zmdtpcRvYfYoaMwIZn4Q>
    <xmx:tsD0Z6sXhThPmGohOupCX22JSVhU7Zys6OG_e1TYl2gcQXbRrqUM7A>
    <xmx:t8D0Z397LgKz7hnJoH--naIAuRaEN4qjBF1-jjWqa6u9DLPg8uPi6pH7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 02:22:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0a4849f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Apr 2025 06:22:45 +0000 (UTC)
Date: Tue, 8 Apr 2025 08:22:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2025, #01; Mon, 7)
Message-ID: <Z_TAtJ9LEeHo2AQN@pks.im>
References: <xmqqtt6znch3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtt6znch3.fsf@gitster.g>

On Mon, Apr 07, 2025 at 04:49:28PM +0000, Junio C Hamano wrote:
> * pb/perf-test-fixes (2025-03-28) 2 commits
>  - p9210: fix 'scalar clone' when running from a detached HEAD
>  - p7821: fix test_perf invocation for prereqs
> 
>  "make perf" fixes.
> 
>  Will merge to 'next'?
>  cf. <Z-pD1puYT87YKAd4@pks.im>
>  source: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>

I had one question around empty prereqs introduced by the patch that
wasn't yet answered. Based on my testing empty prereqs do work just fine
though and evaluate to true, so the patch series looks fine to me.

> * ps/misc-build-fixes (2025-04-01) 5 commits
>  - ci: use Visual Studio for win+meson job on GitHub Workflows
>  - meson: distinguish build and target host binaries
>  - meson: respect 'tests' build option in contrib
>  - gitweb: fix generation of "gitweb.js"
>  - meson: fix handling of '-Dcurl=auto'
> 
>  Random build fixes.
> 
>  Will merge to 'next'?
>  cf. <CAOLa=ZQ8bTn-prAs2ycLdLLjVaLQL4GtLw_gFsvAcx_6j=MBjA@mail.gmail.com>
>  source: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>

I think this one should be ready to be merged.

> * ab/pathspec-sign-compare-workaround (2025-04-01) 1 commit
>  - pathspec: fix sign comparison warnings
> 
>  Some warnings from "-Wsign-compare" for pathspec.c have been
>  squelched.
>  
>  Will merge to 'next'?
>  source: <127c3010-4b23-436e-a07d-e6031e746113@gmail.com>

I had another read just now, the patch looks good to me.

> * jt/rev-list-z (2025-03-21) 5 commits
>  - rev-list: support NUL-delimited --missing option
>  - rev-list: support NUL-delimited --boundary option
>  - rev-list: support delimiting objects with NUL bytes
>  - rev-list: refactor early option parsing
>  - rev-list: inline `show_object_with_name()` in `show_object()`
> 
>  "git rev-list" learns machine-parsable output format that delimits
>  each field with NUL.
> 
>  Will merge to 'next'?
>  source: <20250319183410.1225428-1-jltobler@gmail.com>

Same here, I did scan through the series again and didn't notice
anything objectionable.

> * sk/clar-trailer-urlmatch-norm-test (2025-03-04) 2 commits
>  - t/unit-tests: convert urlmatch-normalization test to clar
>  - t/unit-tests: convert trailer test to use clar
> 
>  A few traditional unit tests have been rewritten to use the clar
>  framework.
> 
>  Will merge to 'next'?
>  cf. <xmqqzfi0pthr.fsf@gitster.g>
>  source: <20250304113323.10564-1-kuforiji98@gmail.com>

Yup. I didn't review this on-list, but already reviewed it internally
before Seyi sent it to the mailing list.

Patrick
