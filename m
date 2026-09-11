Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169A35201F
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789106482; cv=none; b=XCQ5k+KkmsCY/nIQXZQHxIXKiiM8WxDBV9dta94VMrjuSD3HbqKGwlBa6CFx9RBQPuqxWCwh0CBBbttiU9WoQ19I2ZA/5QwV+BTB9pB9S9+8evlkCCbYv7/h9pE6g9wxGA9XP1+PAdmD3uYjpKsj2K6vJAAZVP9MoRl07ojJpLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789106482; c=relaxed/simple;
	bh=WntMTGtiS9uDIFPz7eDHgYr/BGcRc756hYMaPj4PSN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a14X9zr6BeFCutjyr46lKczY13ozTV8LmBlKzW70acKVZC1CuDqna8RYFKVg8TtREz1hGsNbQalhsXZ424InpX2MUcgH6bn6KGsvSwmiJwI9yHNh9WJRCerQDWNOUFgqa/+orCbE9spfEqrRbBpm1jAQOhuf70rsbyiuOMrQfz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TZY1iLiE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JhDsUPzE; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TZY1iLiE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JhDsUPzE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C2B1F1D000D6;
	Fri, 11 Sep 2026 02:01:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 11 Sep 2026 02:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789106480; x=1789192880; bh=ppEOlbTDxj
	vaCgK/bxrghIgeQfBoeCH54u3XZUbIR+Q=; b=TZY1iLiETaqJ8EgWyUiQAGt1ZZ
	HrCGKAviWDv4fTGSJahIhFR1zUZt865RrrPvZyTCdauguN8C8PbcvnzGcW3QlrCy
	XyNNM1ecUciM53GG7RmFFSB65XG533pUma+OdYW4jPK95I7DlZXq1GdhthYYtzBB
	/XViaBzoHoDbYRWG3XcxkbCEInrMSfGaTbEEeMvRnBZ8qqF6mncUrbAcMSlUFIGV
	O7McK97Yk9JwRIyCjvtJkYOSUWg+2Caur3sLok5pV3XBaZVnHJyzL8Wf5zYpgTuY
	/+W2MCO62cnjqtByWCoEi5WrFh5HN/Ac1NuSPeqEZ33iX6n2L8/XJr2GBAMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789106480; x=1789192880; bh=ppEOlbTDxjvaCgK/bxrghIgeQfBoeCH54u3
	XZUbIR+Q=; b=JhDsUPzEGsuI2pOFmtERHJODtSjHH0LhAL+iQLw5P8uJIjzd1hH
	BqnY3YZd0YYzp8YmYFXwCy6qNjTEYSFnLXMcByXShlHuA1bNLgDtBtvIILVM6/3E
	ctCguO41GHVT2Kv379lgOQzx8bs/cls7lPV0dPoE0HPpQ3esmff3b5j/k6GMFGkJ
	nLMU0PP6tXx/V0ygZxJBYpE6ssv6PeG4Vgi4DVAF3IbDOifs5zseaPVlGZm49f4o
	U/Gb2+m4ytUldvzFQM/zFLv5fXKTDRG7RD8JTO6+4F09xnYk9FX2b/n7aQu3kVen
	eU9IiLhNFjOSW6QiYrM3b2BIfGhmM6tyjpQ==
X-ME-Sender: <xms:MJmjarBa1dkPa1FST3GMjtdV5DZG4Enl8Vrbsxm17_REJLrg9R01OA>
    <xme:MJmjanhcJYL-lSt8h9OHjGvWVqWdCHA-h5lhK1DF2ZaYhDbsCGDQTkDyjep2LyHzM
    UwAc_m25o4eAIykcgi4-9hKkL4fHr7-xLr_TBBBZ6KjPgK0cir2Zzkx>
X-ME-Received: <xmr:MJmjakMl5X36EagXtOlojDmU92ri1TX3j750PJaA_EgcDUnmzH9C--g6O3po2Ebz-u9pow>
X-ME-Proxy-Cause: dmFkZTG4KHlHzqSOAmPT2crfcf0adXvgGdxf4PHoCZfhbpJyv1GzdfiSiCCrpxD9JLj6PR
    hExeRTCxiNi671mos4I1/I16Mr6jyIJ3gjIje4QFPxd9s5hva1Y0FbhnTpib5tLaivsjyw
    /PHUtie8kySSIVTiP8VI5zdlLMJCrP7GjeuwePxSxx8OleT77SLyHjOr/spYNX+HrTaxC5
    w64WpIQTspPVWG1/CxGVFKIC0UVeC2mi9uS9Lx1FOYWHtk/aoTW2LRHhZ0RNhgVmZrSKHq
    8Xc9THx73aiZl8D5I3O0gQrX4O2kwHa5CcGD4AHUhbWWq7g0dqStOXrxkZXv+TfJdhFciR
    iM7jM+iA2k5VR1UAboU1Mq6C3YRyqFhMWjpYTEEw91R4C8bf3x8iNgbMSB7cMaLpgDzJk7
    ztqtweVU6vIRzHoEKxXiyn0XMWSHxCgVe3KaTDGaLvP/VbhTo59sjTIEM/1p/g9h23yQcX
    zQOfe9Jty8s+OHvx8vsAnsgUYLk7pYdq6migDp3QLUSCMe+mYmlR4YfLc5mkcbn7KCQNa1
    pOLOcP8mzRu7yhOY9O5fBIZH0Jl4fWcmh6uxqU10oG7WUCWabwTOIMj3P1wEGBCXo2d/9v
    RdRh6kX8588H9//gg5IZfl3uMgoLCYTIfNrLPMTup3X9tU9lDzVog3oHSpUw
X-ME-Proxy: <xmx:MJmjao5YqRWiTIbOEYvWQuaO1T1U9eUDKHWTmFdkggYMWME6X4CGLQ>
    <xmx:MJmjai3GWA_Q4y_IuIqOMptpG9SSS3lIv3ZLOoc1jSEH_wo_uMEDww>
    <xmx:MJmjapa67J_53V7qTjjGWgRWMOkXE1ZCACEir0zxiQvBlTyxdapgiQ>
    <xmx:MJmjaqDoSrnN3PCRHhkZw_UE8aM6KnnL127C798lthhB6DzQIfqfJg>
    <xmx:MJmjauaA3eqkPif_R_3Cs2ciDadtdatTBB_G7YBDjLAW5w2co7aYeuEt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 02:01:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9b744ca9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 06:01:18 +0000 (UTC)
Date: Fri, 11 Sep 2026 08:01:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2026, #04)
Message-ID: <aqOZLBeMLY6NdW2a@pks.im>
References: <xmqqa4ppf1l5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa4ppf1l5.fsf@gitster.g>

On Thu, Sep 10, 2026 at 10:39:02AM -0700, Junio C Hamano wrote:
> * bc/maintenance-doc-markup-fix-for-asciidoc (2026-09-09) 1 commit
>  - doc: fix conjoined maintenance strategies in git-config(1)
> 
>  Mark-up fix for 'git maintenance' documentation pages.
> 
>  Will merge to 'next'?
>  cf. <aqJntwrjC4ImuSyW@pks.im>
>  source: <20260910-maintenance-doc-bullet-fix-v2-1-3ed1c75e24b2@brighamcampbell.com>

Yup, this version looks good to me.

> * ps/libgit-in-subdir (2026-07-12) 2 commits
>  . Move libgit.a sources into separate "lib/" directory
>  . t/helper: prepare "test-example-tap.c" for introduction of "lib/"
>  . Merge branch 'ps/odb-source-packed' into ps/libgit-in-subdir
> 
>  The source files for 'libgit.a' have been moved into a new 'lib/'
>  directory to clean up the top-level directory and clearly separate
>  library code.  This topic has been ejected for now, as it causes too
>  many evil merges with other topics.
> 
>  Waiting for response for too long, stalled.
>  cf. <xmqqqzkx9t95.fsf@gitster.g>
>  cf. <al6yCTDjBRn2HGq0@com-79390>
>  cf. <xmqqqzk2t7sm.fsf@gitster.g>
>  cf. <xmqq7blo4g7g.fsf@gitster.g>
>  source: <20260713-pks-libgit-in-subdir-v4-0-696240876eb1@pks.im>

I didn't really have the feeling that I was gaining consensus on this
series. Maybe I'll be able to build consensus at the Contributor's
Summit, but until then we can probably just discard this series.

> * ps/odb-stop-registering-in-memory-sources (2026-09-02) 13 commits
>  - odb: remove the ability to link sources ad-hoc
>  - t/helper: stop registering alternates in "ref-store" command
>  - t/helper: adapt read-midx to not link ad-hoc source anymore
>  - builtin/multi-pack-index: refuse unknown sources with "--object-dir="
>  - odb/packed: fix memory leaks when freeing source
>  - tmp-objdir: drop unused function to register alternate
>  - odb: remove infrastructure to register submodule sources
>  - builtin/grep: stop registering submodule ODB as source
>  - submodule-config: stop registering submodule sources
>  - submodule-config: stop using `the_hash_algo`
>  - submodule-config: remove uses of `the_repository`
>  - cache-tree: remove dependency on `the_repository`
>  - cache-tree: drop `the_repository` in `cache_tree_fully_valid()`
>  - Merge branch 'ty/repository-fetch-if-missing' into ps/ps/odb-stop-registering-in-memory-sources
> 
>  The mechanism to register in-memory alternate object sources has
>  been removed, as submodule object databases are now accessed
>  natively via their own repository structures.  This simplifies
>  object database management and prepares the codebase for migrating
>  alternate tracking into the files backend.
> 
>  Expecting a (hopefully small and final) reroll?
>  cf. <aqD0F795VKJ6jUFd@pks.im>
>  source: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>

I didn't plan to as it was only changing a single word in a commit
message, but fair enough. Sent out v3 now.

Patrick
