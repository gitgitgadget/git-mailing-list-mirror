Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A8A1F4714
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513377; cv=none; b=I5AtOQRtT42y8L3D74zmynKzppot83Fkq671r2BWNPHu5EU0j8rxIWBL8IpcvvSFs/gRkKUBBvdo8gPJubdkclp+DbLOQKGSKdMczIXZPZ0wQHYH2T7Pr3KmWETbTTYoJt+7lxB0UTShlowIV43KFUfAHKoWrngRFrkQeK0xMLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513377; c=relaxed/simple;
	bh=Hb26PVDzLjeOdTexem1nT1ZlYqMnp1OGbKd9pEYKZtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CB/ARzpmTs+A3N8ynSjdrAjVCSZWNdktc82C28Z51hkz5PsasMlZ/ftyXw8t9UG/IhekZ3LGLhMWBeNZrXhYsz1hQ33hLiA4v3oaJmU5TJpAdRdGDJli7yZBZfIL+O3HMS7BME5+xuqLMY8xspjzG7yMkNr8rg0B3/zy6XdxnAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yqeL3+gz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QY5aNFvj; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yqeL3+gz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QY5aNFvj"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B87D1380092;
	Mon, 21 Oct 2024 08:22:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 21 Oct 2024 08:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729513374; x=1729599774; bh=Ze+kdQBQUR
	nJmrV4GqDICF9O9R4cdcNcKf6gLFazJ18=; b=yqeL3+gzH6qphTUKpUfkFxJnUn
	AkH9baTpqnGKYOxmLwd9D1n6aud7B5AOdeHwwlBMIraPrYhPXHusGk0xCbz/wfqw
	I8pCUL7EqnpVGnZyEBAJXZb6mrLqDeh12H8S5xKNMoa2M0nlf86QesPb3Iukudub
	xvwKXKtDdcE+0ttmoYavrvjaePe/4uK9W4mvRw7oWCsNJTFgFE6z1aq59yao1KGW
	uF6SxB0jKF+D4dA5smfxOYUAgjr8ZCB2wI7QNfsnSYaSoSQeDJs3X3I87/qDjE2Z
	pAJ/j+kDGaAUCokydL3zEUxVR+v7fX4mIuiR10MwnhJ/8EuEAPpaRxVogoZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729513374; x=1729599774; bh=Ze+kdQBQURnJmrV4GqDICF9O9R4c
	dcNcKf6gLFazJ18=; b=QY5aNFvjhsr0UbwHjZCsiA1TPiqs4lfvHlZXggvuIqWs
	bkuIXv5cb7V0KJQDsONXpAgEgTz4VEKrIs4HiO318bGt2YrAvZ/AhAMib82Am5wY
	XAOdL5rrGNpNYkPAHLAx3KFTdR+02RK+Kh+VY2cUN5WMMu0YaDIXfftpz6BHX+Vc
	zmwwLUYkt3lSg0bj+okLDFGR+npa76ae07MFGR7wjHQ+xGyxkxFSkJd9ZtlSAb0F
	6dBZ6QgUPOHz3hALvf+YQRiHAFsfP7/Jw1FCsCow/bESQfqlpJuaqDQa4DazC1x1
	fFj+EMRygS11bBwQBWMMaOzeE11ogSF7utSqFTRoWA==
X-ME-Sender: <xms:nkcWZ3msFUTZvS1HKGuJW3Xtdn_yIrI7n3DZZHn53ft0eqPmYRFBLw>
    <xme:nkcWZ61Bsau06tzkSNj6x48C5D3BfJFi5Lpn0ke_CNyU6w8LJHa3r-l0jNOP0H7UJ
    ScmF0sZCiyWUySl2A>
X-ME-Received: <xmr:nkcWZ9q8VuS0BZNP4l8u2wDjVBHjCYcK1N7XVvbUPxlCPgyK61V59t8IfNWg4x1Mp2bdSuSsDXWLmptIPlsXePjCnQMhKr6GCM0w8TgbnMWd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejffffveehte
    dukeegjedtuefhjeeghedtffetgfegfeeljeefhffgueehjefhvdenucffohhmrghinhep
    phhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nkcWZ_mwdZBZni2O1dxshN8Qc4hFgk7WK5iWVnb8Oqb93HLlrLXaqg>
    <xmx:nkcWZ13U646q_WD1fjjyxQPspvRA5wfoMZtenH0RS21kqlf-vFDBDA>
    <xmx:nkcWZ-uV16cUhssFonCmVULiQGvpEnNwJJ8-hsrqbL6QmJDOdKx7ag>
    <xmx:nkcWZ5WIvZgGoFTSCkgRWewdxNsgUUpy77PgD-YUNlGnSW1I252Lhw>
    <xmx:nkcWZzAwiBbGM5OIHlWGO3RAsFmGvi_bNxrz3rQ5XcuLJNFxNnKWKWbo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 08:22:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d551040c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 12:21:25 +0000 (UTC)
Date: Mon, 21 Oct 2024 14:22:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2024, #09; Fri, 18)
Message-ID: <ZxZHmIJXLBvzoe3D@pks.im>
References: <ZxLI06smvMuf/cT2@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxLI06smvMuf/cT2@nand.local>

On Fri, Oct 18, 2024 at 04:45:07PM -0400, Taylor Blau wrote:
> * ps/ref-filter-sort (2024-10-17) 1 commit
>  - ref-filter: format iteratively with lexicographic refname sorting
> 
>  Teaches the ref-filter machinery to recognize and avoid cases where
>  sorting would be redundant.
> 
>  Will merge to 'next'?
>  source: <e0daa6a2eac97c2b18a53399b7c124fc8d3d238d.1729141657.git.ps@pks.im>

I think v3 should be ready to go.

[snip]
> * ps/cmake-clar (2024-10-15) 3 commits
>  - cmake: set up proper dependencies for generated clar headers
>  - cmake: fix compilation of clar-based unit tests
>  - Makefile: extract script to generate clar declarations
> 
>  Buildfix for unit tests when using CMake.
> 
>  source: <cover.1728985514.git.ps@pks.im>

This one can be dropped, as I've merged it into ps/upgrade-clar in v2
now.

> * ps/platform-compat-fixes (2024-10-16) 10 commits
>  - http: fix build error on FreeBSD
>  - builtin/credential-cache: fix missing parameter for stub function
>  - t7300: work around platform-specific behaviour with long paths on MinGW
>  - t5500, t5601: skip tests which exercise paths with '[::1]' on Cygwin
>  - t3404: work around platform-specific behaviour on macOS 10.15
>  - t1401: make invocation of tar(1) work with Win32-provided one
>  - t/lib-gpg: fix setup of GNUPGHOME in MinGW
>  - t/lib-gitweb: test against the build version of gitweb
>  - t/test-lib: wire up NO_ICONV prerequisite
>  - t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
> 
>  Various platform compatibility fixes split out of the larger effort
>  to use Meson as the primary build tool.
> 
>  Will merge to 'next'?
>  source: <cover.1729060405.git.ps@pks.im>
> 
> * ps/reftable-strbuf (2024-10-17) 10 commits
>  - reftable: handle trivial `reftable_buf` errors
>  - reftable/stack: adapt `stack_filename()` to handle allocation failures
>  - reftable/record: adapt `reftable_record_key()` to handle allocation failures
>  - reftable/stack: adapt `format_name()` to handle allocation failures
>  - t/unit-tests: check for `reftable_buf` allocation errors
>  - reftable/blocksource: adapt interface name
>  - reftable: convert from `strbuf` to `reftable_buf`
>  - reftable/basics: provide new `reftable_buf` interface
>  - reftable: stop using `strbuf_addf()`
>  - reftable: stop using `strbuf_addbuf()`
> 
>  Implements a new reftable-specific strbuf replacement to reduce
>  reftable's dependency on Git-specific data structures.
> 
>  Will merge to 'next'?
>  source: <cover.1729140565.git.ps@pks.im>

These two are ready to go from my point of view, as well.

Patrick
