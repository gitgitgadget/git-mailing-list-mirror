Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963521A2390
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745825614; cv=none; b=i/J87sE4gdm+Wxmsvs3KqlTWS11AIJv3uYabPgECXv6hBCAY87zYAJzqv03++Grjnb9pqYU3OJz8+sej7yRxVcNZJmIyShmvQlgdQMxlCKuXBhCSyqYJd4AUoEaiIR+qbm31PEG3Ms0JJRhm6e8QzWoYSeaQ5lw9uXo2OScg5bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745825614; c=relaxed/simple;
	bh=JStIzKmNRhCAK14lAeBu7DwNTqHm39nBd+C2KzURP40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1+7Z/GJxmfl86zPGK9tm0BNwS1RJ7Ac7hiAEVMnC3Zbeib32p+k6YkOlkOUs5oZDDyuIlOqurscrbvDl1JtAvmlI5broPqzwp4lbhroHsErD7jMZzOd95SJWffSKAlJe2Qdpwj5BFy2TNux6Gmf4RKxTdkPCymRFlIejmzuoUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hkDsxtna; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l25WbFDh; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hkDsxtna";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l25WbFDh"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 93CC513801C2;
	Mon, 28 Apr 2025 03:33:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 28 Apr 2025 03:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745825611; x=1745912011; bh=7s8R7yQvEG
	0P/QHxiwW4AKY1EwfQgjd3D5cejSyPCX8=; b=hkDsxtnaXDoBF7jN2QGePes/z1
	CwnCHussWy5V3+iE5PqVvLVewzmd4NWzS94EM2G878L+n7BWxiqR/UH5jgHtwW+f
	pfBVIs0eo26naZo1s3j0OyBJC9jZSc25lak5V8dyt4IMQ6WhaQ2AjFGfUbwDnM0e
	XCDvr5mn16/rGFH/obOHJCfYzds9aScYa5QhFoyN3kH9ldSOtr1tWlZewaDhYUXF
	4bV/aIT+vktbqTltFgYKhT/oHBgLv+qoy2wJuJMTNf1dw1RzQkUVUPOU5SYSwDf2
	Dp+lS0TBJfIycGrnZ+mSD7eoGhay6qhZq67djd+pYkhCtOnAFVT9GwhbXoWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745825611; x=1745912011; bh=7s8R7yQvEG0P/QHxiwW4AKY1EwfQgjd3D5c
	ejSyPCX8=; b=l25WbFDhodbYS3aKF7YkKdk4cN7Fd3CDpbpM9Ym6AkniofffGK+
	0Hkyu4h3eV/ZgmFA0DhOjfuFrqzRtKW2VZlq0ZJInrqXocTzAfhR995TtxCpSmVq
	WLO+Q5566SYrwa3yBpSFsLlphxCE3L7rPy8Tw7T9XH2hfvu7ZuZS/qBe8GD9VJ75
	L2/rus88J2HmsjXL3NcjvCIWgPZhV7idYnAmeIzx5u62XAphYZu9M1dSxzVEtr0H
	CpxVL3SOEUi1rS01xXC4rgpx8UIM1fd+lxWAEaKnyFqAuXZt57bbBhtSYjoknOem
	EDgjY6B9uQl3b2jkhCuukI02zo3CwAoTOxw==
X-ME-Sender: <xms:Sy8PaK3TYo7Pc6mx2KU16I6joANc3oR0iQQ84Sycda91mxAQA9FeGg>
    <xme:Sy8PaNGqs9uBcWMVZKIWbwzk8KbC1ShboHz1dKkz8kaClcXQnJl1vo83suRtT7z4T
    HjJ3NLP2JbKKAWfDg>
X-ME-Received: <xmr:Sy8PaC7ZA6VIxX_ZYCyG5s0Or_tpyIYubICcQewzjoLHpl8H_QtJxG6B4vKLHdZOSKP3LbazskRI5SiTROdPeoUw-xgdJ6bbKUUAu0jNVT10>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedtfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedtiedvhf
    eghfdtgefhgfehhfduudegfeejffeuleeugfetheekkefhkeeijefgueenucffohhmrghi
    nheprhgvrhholhhlrdgvshdprhgvrhholhhlrdhpshdprhgvrgguhidrkhhnnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:Sy8PaL04Dhe8SYVSAUESb3CoocPVTY4NgULS6SUp9E2wry18LQ6qJg>
    <xmx:Sy8PaNG6hwjcR0SqRTC9p9HQRjxmiUa6FFQrHTS2Iq1hFiag41klzw>
    <xmx:Sy8PaE_tNIslyQXrFiIDiAJMz_GQ188bkGPrvMUr8_WEdXkKw1p-FQ>
    <xmx:Sy8PaCmWL4ypxDxY9DZEA-APo4DF_wXXmmmH-eQdbTeQpONVZCDUGw>
    <xmx:Sy8PaG1IdH0dCnPSP9TeKCdxPV97wo7vftgu4SziRjpSUzSis94UTjr7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 03:33:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e389f86b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Apr 2025 07:33:29 +0000 (UTC)
Date: Mon, 28 Apr 2025 09:33:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2025, #07; Thu, 24)
Message-ID: <aA8vSPKdznjzBf6W@pks.im>
References: <xmqqbjskwkbm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjskwkbm.fsf@gitster.g>

On Fri, Apr 25, 2025 at 04:29:33AM -0700, Junio C Hamano wrote:
> * dd/meson-perl-custom-path (2025-04-24) 1 commit
>  - meson: allow customize perl installation path
> 
>  Meson-based build framework update.
> 
>  Comments?
>  source: <80a2a6ce7c6b05323cf931cdc20d4decb6270002.1745507677.git.congdanhqx@gmail.com>

I had two pedantic comments regarding formatting and wording, but other
than that this patch looks good to me. I expect a minor reroll.

> * es/meson-cleanup (2025-04-24) 6 commits
>  - meson: only check for missing networking syms on non-Windows; add compat impls
>  - meson: fix typo in function check that prevented checking for hstrerror
>  - meson: add a couple missing networking dependencies
>  - meson: do a full usage-based compile check for sysinfo
>  - meson: check for getpagesize before using it
>  - meson: simplify and parameterize various standard function checks
> 
>  Code clean-up for meson-based build infrastructure.
> 
>  Ready?
>  source: <20250425002017.246985-1-eschwartz@gentoo.org>

Yeah, I'm happy with the rerolled version.

> * js/windows-arm64 (2025-04-23) 6 commits
>  - max_tree_depth: lower it for clangarm64 on Windows
>  - mingw(arm64): do move the `/etc/git*` location
>  - msvc: do handle builds on Windows/ARM64
>  - mingw: do not use nedmalloc on Windows/ARM64
>  - config.mak.uname: add support for clangarm64
>  - bswap.h: add support for built-in bswap functions
> 
>  Update to arm64 Windows port.
> 
>  Will merge to 'next'?
>  source: <pull.1904.v2.git.1745395308.gitgitgadget@gmail.com>

The only comments I had on v1 have been addressed by Dscho, so this
looks good to me.

> * sj/string-list-typefix (2025-04-22) 5 commits
>  - u-string-list: move "remove duplicates" test to "u-string-list.c"
>  - u-string-list: move "filter string" test to "u-string-list.c"
>  - u-string-list: move "test_split_in_place" to "u-string-list.c"
>  - u-string-list: move "test_split" into "u-string-list.c"
>  - string-list: fix sign compare warnings
> 
>  Code and test clean-up around string-list API.
> 
>  Comments?
>  source: <aAetW0dan8S3Fljq@ArchLinux>

I have reviewed this series and expect another reroll.

> * ps/meson-build-perf-bench (2025-04-22) 5 commits
>  - meson: wire up benchmarking options
>  - meson: wire up benchmarks
>  - t/perf: fix benchmarks with out-of-tree builds
>  - t/perf: use configured PERL_PATH
>  - t/perf: fix benchmarks with alternate repo formats
> 
>  The build procedure based on Meson learned to drive the
>  benchmarking tests.
> 
>  Comments?
>  source: <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>

I have another minor clarification for our Meson usage queued locally.
Let me just flush out this revision and then this should hopefully be
ready.

> * kn/meson-hdr-check (2025-04-23) 7 commits
>  - makefile/meson: add 'check-headers' as alias for 'hdr-check'
>  - meson: add support for 'hdr-check'
>  - meson: rename 'third_party_sources' to 'third_party_excludes'
>  - meson: move headers definition from 'contrib/coccinelle'
>  - coccinelle: meson: rename variables to be more specific
>  - ci/github: install git before checking out the repository
>  - Merge branch 'es/meson-build-skip-coccinelle' into kn/meson-hdr-check
> 
>  Add an equivalent to "make hdr-check" target to meson based builds.
> 
>  Will merge to 'next'?
>  source: <20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>

I'm happy with this version.

Patrick
