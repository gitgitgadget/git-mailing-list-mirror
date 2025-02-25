Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E8C254869
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740466110; cv=none; b=C+BvQi36OYhvE7CYCv4uDl5eKQRoi56TN24qxuxjB2OkNvcYG3epsMhhEjrcrLeHGNBKBLolcfQnNQsFT0BilH7Xd+N5hCnV9s8c9i6RlZtfYbpo0gqZV1g4C8e5vcpg+xzXjCVWl7OdGIdTlqkojIRNqfXPfi9F0K4SrOkDFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740466110; c=relaxed/simple;
	bh=bgAGrSFlEmIcX3Icrl8/KaakYcKHzIU9+iNG3LDvnns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8HhIJ5bC1V2VN8laQCk8IqsIpxMZmvV9RFCQ3dlpfHX+11Ae+4UDvgCLUhHRh27StxI4cLldpcqT2v1+O69ZBCDMNZm2dqsZOacERcgkDCpDoP7CpKUonMftTNqv11+tk9pmtljaGHCDn9h7Q9+Sq/yUU8vOx9qLFe177+jW5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dPmYcmyF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AvlTRGq0; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dPmYcmyF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AvlTRGq0"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9949C2540135;
	Tue, 25 Feb 2025 01:48:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 25 Feb 2025 01:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740466107; x=1740552507; bh=uc9wb8ibwC
	Aex+LT6TksYuPJ/ldcvnGmpTWtMuJbVwA=; b=dPmYcmyFrUE2vTsNFMpsRF3+7P
	ENIvIA7dbvzN8TRCrLaWcmK4EXpZQMDe3Afj+pX9IDmaREpEXk5jBmmkLBce3Yn/
	suoVvpSCyS6F0no6ZFJk27hx4qlgpX0hmVy9/hd31na0AECzx3cTUlB8owDtXAE0
	j8d+C/iSNpfMvASc7nKFLkikruTUU65pCnGkM8ZEIT+UZggs3HfWsBeNGMmBXCZK
	dL8g0GKpPs6iZ2kULVT3NBm1CI4ywu6suNpq5aRNJhghwf0Kz0pDKwAII5zAQt/n
	fbvdxPeLJoN7tWCuZ7dQFEDeoaODbkLUJ/EDbkQA4adnJNnemQ9A1p1L5ZFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740466107; x=1740552507; bh=uc9wb8ibwCAex+LT6TksYuPJ/ldcvnGmpTW
	tMuJbVwA=; b=AvlTRGq032NYUfnq40AlQTrxxKxIDGpwca+tR07bvQKrMiXDQ/0
	37QW0bCtfsJKGhCMwHf1oR3nwJ4eIHHg8CNRL0kjf1BLzfyx0PdYf93SRp7YhTSy
	Z9qHSZhjF2TnE01kFHN36pDjUHrd/OqP1NdC1TrETUCFpT4DNH3+TQigpnxdTK8b
	KO2JomUYkHAnksNCh76sMpvghh6kp4G6rDmhrhlNJFRX4o9UFSx2NXjTcWa7xeyR
	fJyMO2dI7F98TVbOhdYBNpWgTIO5PHeLRnFvN82QHxvtD0WAIxa4Gk3T3Od8R5fI
	i+sUOrY5RCx4nOqoxcf5KMUTMmffNg8kR2A==
X-ME-Sender: <xms:u2e9Z5OvvBNsmM3xcm7OX97wV_nK4W6Ds56uasi8_XeURqn-j1T4Dg>
    <xme:u2e9Z7_vjopq-KcUZH2AdRVBLl4s8mMqzBLPnES95fxp3Uv5bp5UErd-nQDg3Qt2k
    I6HQ1MSwXPvK95rZQ>
X-ME-Received: <xmr:u2e9Z4QGtgfWnVE-0cJ_ylBWWMhJh_QFB3Y6DPp8j88gzQ84P3KpSkmXFYjj2wTMlRsT3Q_cD16R2KBzeXgJZ5TYBiQHJZf2z3OcYjqeBaGsxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepjedtfedthf
    eftdejheeileelheelfedtteeuteegudeifeegffekueeujefhkeeinecuffhomhgrihhn
    pehsohhmvghthhhinhhgrdhpshdpshgvrhhivghsrdhpfienucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:u2e9Z1vK7pA9MFewYJ6ELaHGnI-Pt9BD9Brn2NRH_qhA5FN5FcGcWQ>
    <xmx:u2e9ZxevofGEMC9sBGeUFkUBNlNxPQQbL7C9jvuVGZRNTyFemL_YpA>
    <xmx:u2e9Zx3TQAHkLjocHQoUajBG0Bq_snzjcYEr31l0w7S2nz7R6txDxA>
    <xmx:u2e9Z9-Cn_3h90f9WonQA88UYK-S1dWCLxDEguWyDI30-izQ8wNYiw>
    <xmx:u2e9ZyrotOWiVHhr5G-yiytJomDuSxvDEotVmLFoJf5SKeWHwBvnYnV_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 01:48:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 801cdaef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 06:48:24 +0000 (UTC)
Date: Tue, 25 Feb 2025 07:48:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2025, #07; Mon, 24)
Message-ID: <Z71ns00inrW0rZN8@pks.im>
References: <xmqq1pvm4u6c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pvm4u6c.fsf@gitster.g>

On Mon, Feb 24, 2025 at 06:47:23PM -0800, Junio C Hamano wrote:
> * ps/meson-contrib-bits (2025-02-20) 10 commits
>  - ci: exercise credential helpers
>  - ci: fix propagating UTF-8 test locale in musl-based Meson job
>  - meson: wire up static analysis via Coccinelle
>  - meson: wire up git-contacts(1)
>  - meson: wire up credential helpers
>  - contrib/credential: fix compilation of "osxkeychain" helper
>  - contrib/credential: fix compiling "libsecret" helper
>  - contrib/credential: fix compilation of wincred helper with MSVC
>  - contrib/credential: fix "netrc" tests with out-of-tree builds
>  - GIT-BUILD-OPTIONS: propagate project's source directory
> 
>  Update meson-based build procedure to cover contrib/ and other
>  places as well.
> 
>  Expecting a reroll.
>  source: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>

v2 of this patch series hasn't yet received any comments that require a
reroll, unless I've missed something.

> * ps/path-sans-the-repository (2025-02-24) 17 commits
>  - fixup! rerere: let `rerere_path()` write paths into a caller-provided buffer
>  - path: adjust last remaining users of `the_repository`
>  - environment: move access to "core.sharedRepository" into repo settings
>  - environment: move access to "core.hooksPath" into repo settings
>  - repo-settings: introduce function to clear struct
>  - path: drop `git_path()` in favor of `repo_git_path()`
>  - rerere: let `rerere_path()` write paths into a caller-provided buffer
>  - path: drop `git_common_path()` in favor of `repo_common_path()`
>  - worktree: return allocated string from `get_worktree_git_dir()`
>  - path: drop `git_path_buf()` in favor of `repo_git_path_replace()`
>  - path: drop `git_pathdup()` in favor of `repo_git_path()`
>  - path: drop unused `strbuf_git_path()` function
>  - path: refactor `repo_submodule_path()` family of functions
>  - submodule: refactor `submodule_to_gitdir()` to accept a repo
>  - path: refactor `repo_worktree_path()` family of functions
>  - path: refactor `repo_git_path()` family of functions
>  - path: refactor `repo_common_path()` family of functions
> 
>  The path.[ch] API takes an explicit repository parameter passed
>  throughout the callchain, instead of relying on the_repository
>  singleton instance.
> 
>  Will merge to 'next'?
>  source: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>

The fixup commit looks good to me, so I'll refrain from sending a v3
only to roll the fix into the series.

> * pw/rebase-i-ff-empty-commit (2025-02-11) 1 commit
>  - rebase -i: reword empty commit after fast-forward
> 
>  "git rebase -i" failed to allow rewording an empty commit that has
>  been fast-forwarded.
> 
>  Will merge to 'next'?
>  source: <pull.1860.v2.git.1739289549299.gitgitgadget@gmail.com>

I had a quick read of this patch and didn't have anything to say on it,
so I think it should be ready for next.

> * sj/ref-consistency-checks-more (2025-02-13) 8 commits
>  - builtin/fsck: add `git refs verify` child process
>  - packed-backend: check whether the "packed-refs" is sorted
>  - packed-backend: add "packed-refs" entry consistency check
>  - packed-backend: check whether the refname contains NUL characters
>  - packed-backend: add "packed-refs" header consistency check
>  - packed-backend: check whether the "packed-refs" is regular file
>  - builtin/refs: get worktrees without reading head information
>  - t0602: use subshell to ensure working directory unchanged
> 
>  "git fsck" becomes more careful when checking the refs.
> 
>  Comments?
>  source: <Z67LkxAFIAeaYr0U@ArchLinux>

I'll make sure to give this series another read today.

Patrick
