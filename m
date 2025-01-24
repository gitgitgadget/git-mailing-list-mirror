Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388645588E
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 06:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737698833; cv=none; b=I+q00VV1bhRJgWGFIgaHf7MVBtk/LSEQl7DYGTC8CCCqNQdEWOQ8rhhSkjNHKCBV1KiZsgd9bNI2XTdlJKOIshlQKYJsRIaDVxbBWD5okroGGrhKmeBNAG/AOjMPmCL1d+OVT92lg12uZAVCElndCD54hpnaLE5svGtTTyDjIGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737698833; c=relaxed/simple;
	bh=6WT/uS8qMjWqDXqPmWskvJsUUzC4VXjADqq4lk8V6A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WED7PXafCX3435Sn/7q/oXE4gc6wRAwhxcv3ahXRvscknIwJ4QD/sBzz6FiIcNbzgK9sOFT90haU/AK8ac/j2sd6I6fBHZ9PTg42h4pZ1BI8vkFur4ro3BcJcjF0HC7SygdGqsWf4Sgg1A9ZPkI4K3kWVsqpyvz2DKt9kVLOJ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y1Rj8U3a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WGo5CRRp; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y1Rj8U3a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WGo5CRRp"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 2C548114017F;
	Fri, 24 Jan 2025 01:07:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 24 Jan 2025 01:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737698830; x=1737785230; bh=wwdKByC6yo
	jF2MubKs1RMfcIM4HbVI5jqXPy0p3lkeI=; b=Y1Rj8U3atg26BKB6XKcGqx1BLq
	pmSoau/Moxll25UltqeUwtAw3+Nvh6QoNA7F3q41u/hZqSJ3mGGgYukPv07JFwVj
	fFCosN8Cng5PsOBkFYWG3IZ+A0ekDP2l5ggHXfJojCVtQYjk/Cwf3Mr8M+XY1awV
	OpL1DlF/xmTwc8QWr45bd3FFcogKFltGvsXwqaS9kiM90kGmguoBCQI0qX4J1r2j
	MEcENhhXf/jkyP3f2Wny+ElGMmdRB7DSHVR3AA/AumJ60mrVi+v3yX6SLYgXwMvS
	GPP9Beo2wDhiLRfKriRJmzUH/xciHj5l/9yFWlP128olqx+di5zwCtC6tzBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737698830; x=1737785230; bh=wwdKByC6yojF2MubKs1RMfcIM4HbVI5jqXP
	y0p3lkeI=; b=WGo5CRRp7m1KurjxT6rvYj/5RqV8HPQTSMEt0ciYOpXxUZ3IPIB
	aEKL6Z9Nwxa86zE67ouQv6np3tFrTSTF4f+eDsgp8X2P0F7zvCQn2PXRiE4VIPM+
	QPqnUlO3MPnEx0ZzLDqxrhPARESKVwjPy74MbqOkBbtjvM3Y4jSqduvDg+AiMo+i
	2d69pN8ktkcg999BhEL01Zsbkumm3AsgJ1r+G6P7TZX6mR+TJ5dNc0ah9e+qZgAE
	ZBVGHioDfZvDDld6D4GJbNqIsAW49oYeNr3B3gPOgq8atiUAyfRiwk9oZxP6ScjX
	EEOF0D5OhZ35+LALGRZyfdvHzqbvV6ei+lw==
X-ME-Sender: <xms:DS6TZ_tzELVFCaV69CuJhfgw3984OdVj6X7uRmtQvQh9Fo6iIVWcLQ>
    <xme:DS6TZwcAj70LVgZzrxSNjSxPdSk3A049vuRXqfwysEiDBhC8UCgP8UJa6LVGE5uo1
    nOG7gFGIKT15_H2ow>
X-ME-Received: <xmr:DS6TZyylvT9HhG4BgWf7HDJ8fHOI4deSgUPrvjt_GhCTPmfKaQTRoeUWEqkbzO8e25qYLnd7A5ae4E3-XbCzaIfkh5wXyAxZFLROn9gyh6V2vQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgfeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnheptefftdeige
    evjeekffdtueegleffgeegkeejudfhffeuhffhteejgfevheegffdvnecuffhomhgrihhn
    pehpvghrshhpvggtthhivhgvrdgsfhdpphgvrhhsphgvtghtihhvvgdrphhspdhrvghvih
    gvfigvrhhsrdhskhdprhgvrgguhidrphhsnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvd
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DS6TZ-NHmDeZbpfLENLrbW82iXKvdm2hoaUZoSmkJdX63M2T7VFlmA>
    <xmx:DS6TZ_9R9Ne3aw7OBb0S4LCrhb1WW_TTm3un87vR7s9-eDkEEq2fzg>
    <xmx:DS6TZ-WfrK7NLOFt4MMMXthGVlg5Jg7QYNv0ZJjRkWw-GjuVfuXHdQ>
    <xmx:DS6TZwdk4ebCbj9hEfOPMGUfjzKvCbfkHIjEOtxweNm2bZfTGpvxFQ>
    <xmx:Di6TZxIAEo26eyJeK_BveEE8c9_8AJ6LtuOI_ahKgjc2uw-YMJOuQj6v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 01:07:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8dad833c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 Jan 2025 06:07:06 +0000 (UTC)
Date: Fri, 24 Jan 2025 07:07:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
Message-ID: <Z5MuCd_GbbLK_puS@pks.im>
References: <xmqqbjvyv510.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjvyv510.fsf@gitster.g>

On Wed, Jan 22, 2025 at 02:48:43PM -0800, Junio C Hamano wrote:
> * kn/pack-write-with-reduced-globals (2025-01-21) 5 commits
>  - pack-write: pass hash_algo to internal functions
>  - pack-write: pass hash_algo to `write_rev_file()`
>  - pack-write: pass hash_algo to `write_idx_file()`
>  - pack-write: pass repository to `index_pack_lockfile()`
>  - pack-write: pass hash_algo to `fixup_pack_header_footer()`
> 
>  Code clean-up.
> 
>  Well merge to 'next'?
>  source: <20250119-kn-the-repo-cleanup-v3-0-a495fce08d71@gmail.com>

This one is ready from my perspective.

> * bf/fetch-set-head-fix (2025-01-13) 1 commit
>  - fetch set_head: fix non-mirror remotes in bare repositories
> 
>  Fetching into a bare repository incorrectly assumed it always used
>  a mirror layout when deciding to update remote-tracking HEAD, which
>  has been corrected.
> 
>  Needs review.
>  source: <20250112165125.130400-1-bence@ferdinandy.com>

I've left a review.

> * ps/build-meson-fixes (2025-01-22) 12 commits
>  - ci: wire up Visual Studio build with Meson
>  - ci: raise error when Meson generates warnings
>  - meson: fix compilation with Visual Studio
>  - meson: make the CSPRNG backend configurable
>  - meson: wire up fuzzers
>  - meson: wire up generation of distribution archive
>  - meson: wire up development environments
>  - meson: fix dependencies for generated headers
>  - meson: populate project version via GIT-VERSION-GEN
>  - GIT-VERSION-GEN: allow running without input and output files
>  - GIT-VERSION-GEN: simplify computing the dirty marker
>  - Merge branch 'ps/meson-weak-sha1-build' into ps/build-meson-fixes
>  (this branch is used by ps/zlib-ng.)
> 
>  More build fixes and enhancements on meson based build procedure.
> 
>  Will merge to 'next'?
>  source: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>

Ready from my perspective.

> * ps/ci-misc-updates (2025-01-10) 10 commits
>  - ci: remove stale code for Azure Pipelines
>  - ci: use latest Ubuntu release
>  - ci: stop special-casing for Ubuntu 16.04
>  - gitlab-ci: add linux32 job testing against i386
>  - gitlab-ci: remove the "linux-old" job
>  - github: simplify computation of the job's distro
>  - github: convert all Linux jobs to be containerized
>  - github: adapt containerized jobs to be rootless
>  - t7422: fix flaky test caused by buffered stdout
>  - t0060: fix EBUSY in MinGW when setting up runtime prefix
> 
>  CI updates (containerization, dropping stale ones, etc.).
>  source: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>

This series was approved by Peff, but other than that it didn't get much
feedback indeed. I'll rope in some additional reviewers.

> * sk/strlen-returns-size_t (2024-12-26) 1 commit
>  - date.c: Fix type missmatch warings from msvc
> 
>  Code clean-up.
> 
>  The remainder needs to be reviewed.
>  source: <20241223110407.3308-3-soekkle@freenet.de>

This one seems stale to me, as there's been a v2 with [1]. It was sent
in a separate thread though, so that probably explains why. In any case,
the series got reviews already and needs a reroll.

[1]: <20250106190855.3098-1-soekkle@freenet.de>

> * jc/show-index-h-update (2024-12-20) 1 commit
>  - show-index: the short help should say the command reads from its input
> 
>  Doc and short-help text for "show-index" has been clarified to
>  stress that the command reads its data from the standard input.
> 
>  Comments?
>  source: <xmqqfrmidyhk.fsf@gitster.g>

This series looks good to me.

> * ps/3.0-remote-deprecation (2025-01-22) 7 commits
>  - SQUASH???
>  - remote: announce removal of "branches/" and "remotes/"
>  - builtin/pack-redundant: remove subcommand with breaking changes
>  - ci: repurpose "linux-gcc" job for deprecations
>  - ci: merge linux-gcc-default into linux-gcc
>  - Makefile: wire up build option for deprecated features
>  - Merge branch 'ps/build' into ps/3.0-remote-deprecation
> 
>  Following the procedure we established to introduce breaking
>  changes for Git 3.0, allow an early opt-in for removing support of
>  $GIT_DIR/branches/ and $GIT_DIR/remotes/ directories to configure
>  remotes.
> 
>  Will merge to 'next'?
>  source: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>

The squash-commit on top of the series looks good to me, so I think this
should be ready.

> * ps/send-pack-unhide-error-in-atomic-push (2024-11-14) 2 commits
>  - transport: don't ignore git-receive-pack(1) exit code on atomic push
>  - t5504: modernize test by moving heredocs into test bodies
> 
>  "git push --atomic --porcelain" used to ignore failures from the
>  other side, losing the error status from the child process, which
>  has been corrected.
> 
>  Needs to see if competing parallel topic needs to replace this one.
>  source: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>

I think v3 sent by Jiang Xin looks like a reasonable alternative to my
fix, but it needs some fixups. I'll maybe wait one more week for them to
reroll the series, and if that doesn't happen I might adopt their
patches and do the fixups by myself.

Patrick
