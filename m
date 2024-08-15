Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A77B7DA87
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720924; cv=none; b=COS5pdlLDjr6Mujv2C4wvlY0kx0ZwnS2hg8NbRcTFp/pqQkUVQiu1hDaRX//VDAP5hB6oSPCach2bqbXOUML452mn/k8wpMyjbYbwQuRqb8aYqxlUhdO22n9nM4ci5sjeQy3gZcsWUXAB4k7uz14rjNTwe80Oo/XwU/mvGgj4RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720924; c=relaxed/simple;
	bh=75LwO540jeazq2z84u6lySo1DK7kjY/k4Ep2xLWTfNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPhDJ/cOReDLsRKkRdukeyeOvR/85KI8hjRS+VrRTD7LQBMZZAf4QlGWWrO5kb9zyaO8sa7oQRRlmM0C60bg8yh9bqRGzdN4XgoXc5wuQm+ND7xJgRcU4lGI0oLMSrPk/LXXJROXL2McU7zMHEsfERp0S+YMPa+aW8gO3dDdFpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ah4kCPDO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p58/ofun; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ah4kCPDO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p58/ofun"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2FFE91151C92;
	Thu, 15 Aug 2024 04:44:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 15 Aug 2024 04:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723711469; x=1723797869; bh=SjlMMaf8er
	7Otd0TjX/DaP9kYBofu1UQEgVLGQnhcho=; b=Ah4kCPDO4IyC1QT0etle3NcXrW
	Iiq/ALlod5ifprlu4Sfmhsl0eL6bYCkqtY3P8Os6gp2w7MPVoiyi7wC0qCCj37yN
	OQvtfiWiTxOW87EXZXiKdYPTcz2dxhrMvQWkDbUSNCNDU8pIXchfSvgMZ8GkUc/6
	uX/V6C6kEEJJpOCe+KGLSn07mjqoWhWdBVLLK2ve1HYInXZv0owT+2opekzbx+mv
	sZH1B3qxWr691pWMFTOnLAoEteXCHuzPBdRxwn3DN7Ja4haOh2dZjG6yn32NPxN+
	zfvnNIB7i9F3wB32ieMffVo+uYUmk0Yl3dfvTRcARFY0BPFDmhWxSIQWd4fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723711469; x=1723797869; bh=SjlMMaf8er7Otd0TjX/DaP9kYBof
	u1UQEgVLGQnhcho=; b=p58/ofunZFVhkvBggU1nnjnwBjpd7k+KCWTir0uCupcD
	b352q46reGlS56WCxza1lzH16T8mNrcoMmQXRVR2LLesyyFX3VZxGIG75WQR/wZ7
	EzBcnMwNiTgq1ca7IRvgT+vEXTlHecsKwTrYG+EKrQkgHZNCH8WAkxD1l9k8Uwfd
	8mIg8blkbjRxEan2Vm4C4IC4ieuL+J7l+Le4LiUvRLRCIZLBLZ5ezlG4cLMr5but
	JJKuCqORYjnvh15e3hvFuRs8/ErUO2L4KtrhYTKjW23YEnPljBq6nn+B8RGXP4SG
	K3tyFSJOiu2lilH7MgnHQEaG/jXusjX6oQ9IzgbSCA==
X-ME-Sender: <xms:7b-9ZjC10MS58I6aWWoPejdLf6bf3a-YJt9SxMPSFusQ8OZXXmrU2w>
    <xme:7b-9Zphh3D9we1lh3e6Y6_jVD8V03pcmYoKjoUYi989zSaWs85SLKQtr2_ynMzPLa
    SoMbcm_Kwq3iFVPsA>
X-ME-Received: <xmr:7b-9Zul1BPBiaHM1OdirsUOz17Zbqhn8Wv4hpNg6t8PYSBTtPOYV8lWEf93xgRTh6lQNFCNgwd6C9NoCMkau706zf_OUQVgRuQPhhVMBNjamlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpefhudegteejff
    eileegfedvieeggfevkeegudeiffdvkeekgfejueeltdfhheegieenucffohhmrghinhep
    ghhithhhuhgsrdgtohhmpdhpkhhsrdhimhdplhhoohhkrdhpshdpvhhivgifrdhpshenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7b-9Zlz2hDkoA6ftMR78kdb3astvdpk2stRakJ48n-mQgLAuu3KXrg>
    <xmx:7b-9ZoRRBxTYSO3nMceuSajYbTBidqVwGAqq8udy4qyO-bcbW6Wgjw>
    <xmx:7b-9Zobp8DiQ6N--hWSczOkTldUzVORWqq4rP-06wyh_A_XhBBWN9Q>
    <xmx:7b-9ZpRjh54l9yXVqaPpum9p6w-eTz0yvQLtvBK3etQnfzhcR-7NDA>
    <xmx:7b-9ZjeLcaFM5LzRwjz33lPjHdHFlsWOuIeZPDnKpJcPpVEciIZ1YtVc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 04:44:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8e7cb8df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 08:44:06 +0000 (UTC)
Date: Thu, 15 Aug 2024 10:44:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2024, #05; Wed, 14)
Message-ID: <Zr2_4sNu56_frqlr@tanuki>
References: <xmqqcymawjav.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcymawjav.fsf@gitster.g>

On Wed, Aug 14, 2024 at 08:34:32PM -0700, Junio C Hamano wrote:
> * ps/clar-unit-test (2024-08-13) 8 commits
>  . t/unit-tests: convert ctype tests to use clar
>  . t/unit-tests: convert strvec tests to use clar
>  . Makefile: wire up the clar unit testing framework
>  . t/clar: fix compatibility with NonStop
>  . t/clar: fix another whitespace error
>  . t/clar: fix whitespace errors
>  . t: import the clar unit testing framework
>  . t: do not pass GIT_TEST_OPTS to unit tests with prove
> 
>  Import clar unit tests framework libgit2 folks invented for our
>  use.
> 
>  On hold.
>  cf. https://github.com/git/git/actions/runs/10377935505/job/28733214241
>  Seems to break "make sparse" among other things.
>  source: <cover.1723095269.git.ps@pks.im>

Oh, I didn't notice it still breaks `make sparse`. Will have a look.

> * ps/leakfixes-part-4 (2024-08-14) 23 commits
>  - builtin/diff: free symmetric diff members
>  - diff: free state populated via options
>  - builtin/log: fix leak when showing converted blob contents
>  - userdiff: fix leaking memory for configured diff drivers
>  - builtin/format-patch: fix various trivial memory leaks
>  - diff: fix leak when parsing invalid ignore regex option
>  - unpack-trees: clear index when not propagating it
>  - sequencer: release todo list on error paths
>  - merge-ort: unconditionally release attributes index
>  - builtin/fast-export: plug leaking tag names
>  - builtin/fast-export: fix leaking diff options
>  - builtin/fast-import: plug trivial memory leaks
>  - builtin/notes: fix leaking `struct notes_tree` when merging notes
>  - builtin/rebase: fix leaking `commit.gpgsign` value
>  - config: fix leaking comment character config
>  - submodule-config: fix leaking name entry when traversing submodules
>  - read-cache: fix leaking hashfile when writing index fails
>  - bulk-checkin: fix leaking state TODO
>  - object-name: fix leaking symlink paths in object context
>  - object-file: fix memory leak when reading corrupted headers
>  - git: fix leaking system paths
>  - remote: plug memory leak when aliasing URLs
>  - Merge branch 'ps/leakfixes-part-3' into ps/leakfixes-part-4
> 
>  More leak fixes.
> 
>  Will merge to 'next'?
>  source: <cover.1723614263.git.ps@pks.im>

This one is ready to be merged from my point of view.

> * ps/config-wo-the-repository (2024-08-13) 21 commits
>  - config: hide functions using `the_repository` by default
>  - global: prepare for hiding away repo-less config functions
>  - config: don't depend on `the_repository` with branch conditions
>  - config: don't have setters depend on `the_repository`
>  - config: pass repo to functions that rename or copy sections
>  - config: pass repo to `git_die_config()`
>  - config: pass repo to `git_config_get_expiry_in_days()`
>  - config: pass repo to `git_config_get_expiry()`
>  - config: pass repo to `git_config_get_max_percent_split_change()`
>  - config: pass repo to `git_config_get_split_index()`
>  - config: pass repo to `git_config_get_index_threads()`
>  - config: expose `repo_config_clear()`
>  - config: introduce missing setters that take repo as parameter
>  - path: hide functions using `the_repository` by default
>  - path: stop relying on `the_repository` in `worktree_git_path()`
>  - path: stop relying on `the_repository` when reporting garbage
>  - hooks: remove implicit dependency on `the_repository`
>  - editor: do not rely on `the_repository` for interactive edits
>  - path: expose `do_git_common_path()` as `repo_common_pathv()`
>  - path: expose `do_git_path()` as `repo_git_pathv()`
>  - Merge branch 'ps/refs-wo-the-repository' into ps/config-wo-the-repository
> 
>  Use of API functions that implicitly depend on the_repository
>  object in the config subsystem has been rewritten to pass a
>  repository object through the callchain.
> 
>  Will merge to 'next'?
>  source: <cover.1723540226.git.ps@pks.im>

This one, as well.

Patrick
