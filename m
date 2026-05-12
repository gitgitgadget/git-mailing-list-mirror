Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A993D9033
	for <git@vger.kernel.org>; Tue, 12 May 2026 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778565097; cv=none; b=ADhd497OnlivHYRP3JuzStRyTc17J946/S6KPruUBEoAs5kdkZ12jw5CZ8ZXbMNL4LKIw5Ls5rNzX8gjbMli89kG1owzlIqjbEsauPwnKK+myrEza4xPzwcNAyGmDVNouMbRtk86BZPK8HsQcZaKe0nXWHBsFEm7/FOpwnDjELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778565097; c=relaxed/simple;
	bh=0LRrAOEGbs7cocHukTgVc/zUsTWayqALUQRa2IdyjKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=krNDmKEkq6JeT6leLyAWAe6FNTHQxRJ8hF88+3nliPxoVM5qGqhhSGK/rvllKb8SfPjaLSIg5c+suY4z63me73WUd1elvAQ/nRt8Y+VE7n7fdFYZ3lJLikBPcUUhnW2eBz0aPtpQNiKEnmWrHnWu/CYT2nUUnaF5+WQPjAH5E9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wSH3a5pL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g5DrcfAa; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wSH3a5pL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g5DrcfAa"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id C17981D000B5;
	Tue, 12 May 2026 01:51:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 12 May 2026 01:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778565078;
	 x=1778651478; bh=Vh8gl5X8dvAGddwhmQ8B1otO9f5tx4yTXEXNftqySGA=; b=
	wSH3a5pL242CktiMsOHVxqK9bYHFKct6LJ949DztmDfej0abgnfcakGIjl/gskjd
	nwTq9RpwAK9nPHy4m4XhgqKZZlkrz0oKJlKF+IVHSvFSZioEZruJMedAykE1nUK8
	+GPtska2KlVCssQWnM4htd5SDzwhwAC8nHSsEInt05EhPjkjUXgEa+y8nkrwN5er
	OgArZQXvWLYEhI0y7PdyDRxb3YHPaJIdGuuBenoq1r0lToDmd9JV6/M+KtbUnRBK
	53f9cPMQUbsvNV38zQIr8R2T0t7KDCVf3/SU++NVd6QCLvfFtT82fXEad6cghjq4
	ZeVzv1NKfFQ6r27t7VUJtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778565078; x=
	1778651478; bh=Vh8gl5X8dvAGddwhmQ8B1otO9f5tx4yTXEXNftqySGA=; b=g
	5DrcfAaKq+qco4DJlhnj/3DUr4tHX4fC9D3zWR/taXqMmrlHCSRP0kAyveV6AFZu
	sAKMvNjPmmGz/nT0rYQIeGk4vrs2tfDJTvrMNtITGySjztOkwJk+f2A+cvIa27YS
	6xpsn9F/8cxGArEG+MHhKFdv76SoACfuc/vMaeZq+755f0cMwt3ZKf+6fM2/I9DL
	9960csWGAcyJIQh4Ts9BX5niHJwVBNG4LFvAGIOFby3g5a0EHp5fSyOwg55V0h/s
	sZRO+yuRO/zHUd8yUjokR3NIZzfEVfZmI2jjPbmO0dyGYmaXUxfro8UNCWJpf1cI
	VlglU7DllY0pp9Q/WcDTw==
X-ME-Sender: <xms:1r8CaspOORyPO2OIAI6kMSO3XjAJF_bDtFnoqiI0kxz3UADwLrYa3g>
    <xme:1r8Car93VTOMtxTXLJE_X7qWVoo7lzzamTYGF_NvAmNRWV8eCapDivIlVmLlgn-CU
    b7SGwodYQfOsgXkEq0qVIj8vRf_jdL7CuKLh8nRP1c5Xqqp3g>
X-ME-Received: <xmr:1r8CaodlgxFvxgFuOBlBLMhE6CvLPj7s7P_ysfjPeHOjNNmuve3-MzwfdcJgXg0KDFWQjgnsd6dtyLZjGpJa0ZSrXwTVe8AJ9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddutddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehssggruhgvrhhsfhgvlhgusehgrdhutghlrgdrvgguuhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1r8CalKjzbv-55jwlCgKx_17kC6GRI1c8lozjCSJyR1nISf8z_AGSQ>
    <xmx:1r8Caois6nCPxoriCpoMsU3Hc5RSSn-nnFSmlLRJ2ZfFKmF8ty1FHQ>
    <xmx:1r8CajSqG-f370JlFX6ezEPkwX5a_jLXQt2_qhCyPMd7TmdeSF-6Pw>
    <xmx:1r8CaiUM5ixIVMJtL1hgBzndg1WSH6KhHgzWfJGnVd1aJUd-nPa0Eg>
    <xmx:1r8Caj89NIWTu9jSKZex8qnBjiNugpSX0jo-_V9ADaSLYH-GW8nJqRJ_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 01:51:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Scott Bauersfeld via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Jeff King
 <peff@peff.net>,  Scott Bauersfeld <sbauersfeld@g.ucla.edu>
Subject: Re: [PATCH v4] index-pack, unpack-objects: increase input buffer
 from 4 KiB to 128 KiB
In-Reply-To: <pull.2282.v4.git.git.1777387660841.gitgitgadget@gmail.com>
	(Scott Bauersfeld via GitGitGadget's message of "Tue, 28 Apr 2026
	14:47:40 +0000")
References: <pull.2282.v3.git.git.1777317998098.gitgitgadget@gmail.com>
	<pull.2282.v4.git.git.1777387660841.gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 14:51:16 +0900
Message-ID: <xmqqy0hpnpkb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Scott Bauersfeld via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Scott Bauersfeld <sbauersfeld@g.ucla.edu>
>
> index-pack and unpack-objects both read pack data from stdin through
> a 4 KiB static buffer. In index-pack, each fill() flushes consumed
> bytes to the pack file via write_or_die(), capping every write(2)
> at 4 KiB. unpack-objects uses the same buffer pattern for reads.
>
> On FUSE-backed filesystems every write(2) is a synchronous round
> trip through the FUSE protocol (userspace -> kernel -> userspace ->
> back), so the 4 KiB buffer turns a clone into many unnecessary tiny
> writes with noticeable latency overhead.
>
> Increase the buffer from 4 KiB to 128 KiB. Introduce a shared
> DEFAULT_IO_BUFFER_SIZE constant in git-compat-util.h (next to
> MAX_IO_SIZE) and use it in index-pack, unpack-objects, and the
> hashfile layer in csum-file (which already used 128 KiB but
> hardcoded the value).
>
> Pack file writes to a FUSE filesystem with writeback caching
> disabled during HTTPS clones of git/git (~293 MB pack):
>
>   74,958 -> 4,687 (94% fewer)
>
> Wall-clock time of git clone over HTTPS onto a FUSE passthrough
> filesystem with writeback caching disabled, 3 runs per variant:
>
>   vscode (~1.26 GB pack): 84.5s -> 75.7s avg (10% faster)
>   git/git (~306 MB pack):  22.6s -> 20.0s avg (11% faster)
>
> Signed-off-by: Scott Bauersfeld <sbauersfeld@g.ucla.edu>
> ---
>...
>     
>     Changes since v3
>     ================
>     
>      * Replaced strace-based syscall measurements with FUSE daemon write
>        logging. The earlier strace numbers (72,465 → 24,943, 65% reduction)
>        were distorted: strace -f ptrace intercepts every syscall in all
>        traced processes and added enough overhead to distort the
>        measurements. The FUSE daemon logging captures write sizes without
>        perturbing the traced processes, showing the true reduction is 94%
>        (74,958 → 4,687).
>      * Note: Why 4,687 writes instead of ~2k writes as would be expected
>        with a 128 KiB buffer size? It appears that fill() is calling xread()
>        on a pipe and the linux default buffer size for pipes is 64KiB. I
>        also tested using fcntl(F_SETPIPE_SZ) to increase the pipe's buffer
>        size to 128KiB, which does indeed reduce total pack file writes to
>        ~2.4K.

It seems that everybody was happy with v3 already, so let's merge it
down to 'next'.

Thanks.
