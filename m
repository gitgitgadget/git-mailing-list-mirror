Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A741322522
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596974; cv=none; b=NFQ5x4+mJwepBnXqX2znBMA6KpBpJGlxQKr5Lydyfgdv4QGRAxaSEONPzaXnz7yWhFKnLK/jCFOXDmpNFsO2q5mERFzc0BZkAVTHpXqwaTyOshLrCWDB88dEzYIyx08Gi5btdLGf/bjqTgSufDHiv4v7bLmZGAjvSvg384NbZmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596974; c=relaxed/simple;
	bh=ppYiznO5F6uBmUBqYh25SvGgTnL9+5Q/wjcdkX5qfLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLO0tBH5oKHoSowLGvTAuGhxQXm9UjwkH2FeiRqeYd8XWIaDwi37FPtb5dKOob4AeW1PBSD0FU9gyuO1iytWiZNibpRvmtEI9gPSEHg/VLGq92FovCQKf01V0DaqCh9xsTkth5db1fuf/+r+uLpW/qyLmFdmCa5YH2PtGM0FWLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zo14mbgG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=klEFZ3Rg; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zo14mbgG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="klEFZ3Rg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 88226EC01EC;
	Fri, 27 Mar 2026 03:36:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 27 Mar 2026 03:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774596965; x=1774683365; bh=fN3ZVmFmxj
	Md7lC3Y8TQ47HT25Y9qzA4XNRAuJhP7p4=; b=Zo14mbgGURV4ZCQ1uCIIH0BAGS
	mSQ9HuQQVLahOAOZvpv3DTObBWNAtsIrTMj07FVZl0BOvAnodo9G77JH7yzshV62
	x1BuyK1NtSe8sveluSXGlys4o4qh0tAHQow+mV87HmSuiirvYclf82+6H+ecsjsW
	OO9PfZe+gtv99N8ogR3Pz45gfQbeElt9yZPujryKmWhGLA7unDoJA7O4+7ITQLMZ
	VL/zNPe4zrTTLAGn/X0Nvsn5BUevNNlL9CJ0oTxdRuwmpDsYTXXKMU4b7FeLQRme
	7DKkr/9PXrReFpnBhqLcE1JilpJlcSKA1KSyxO68Zy8FbwGzfPmdaXiHilkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774596965; x=1774683365; bh=fN3ZVmFmxjMd7lC3Y8TQ47HT25Y9qzA4XNR
	AuJhP7p4=; b=klEFZ3RgISf8u/d41F2s2/wGL2GFT7R0a0KkG7dXeEN5XXG2xGi
	JnSHS2B06N52uMRXgTxkAeYVAVhGt98zwA6BXXZ//ZzP0zOTjRssfxOn3no3vKLX
	3Psp5715ljdFPNnFLKRK+UoYA4gyvJeLWnA50FLo1KbFHQslPTdvByeueVjUhRFo
	fHBphzcDva1VaDgnDjN57A3ma0RHdD/d00wvkhRUJsfACsZ2KiqODUyi8wYVusnL
	s23URinytgDTwfgrWF0gAtoEaScx8nWh86HDPSzR+BIdWxu6/UBfSwUX+xVSP1/4
	TMzFJxfo2JZ4hCUnPnOAhmmXKxk2Jb0T0Sw==
X-ME-Sender: <xms:ZTPGaSnywn29Uc6RdPImEjgdd7TEJ6168USAn9bLafRLIRvh7MTw6w>
    <xme:ZTPGaf2Q8VWegiubeQ3QrQ9jlD8J8mIg3qs09OCc48QAYz1-pLU82mfc4XcDPWPkm
    Ou8MI7Wha4v684fAZaZRuy5tp_GGxts-6203C_oZT0_BLdv_oSKyw>
X-ME-Received: <xmr:ZTPGaeT_ouNa_IYEYfMTrLwryuDl5Ft8_ro8ErrgLj3YWnwizgkkg-arKdN6DVxRmQTMWjuAGJ1Ip1iWLV0Izo_JvQNFjBBSaCtXswVACA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdortd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeelleegudehuedufeetuefgtdefgfffhfdtue
    eufefggffgffdtfeegudfhffefgfenucffohhmrghinhepughofihnrdhpshdpvgigphgv
    tghtrghtihhonhhsrdgrrhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ZTPGaRsVWCQ57_TJ_hkyd3xpYTZ8m1VgDn_qdBVYExYTWHWY1x0iXw>
    <xmx:ZTPGaTa8IWXwPy73MYyL9xPg6g125p-UcPEdWXgkOClnoDwhwThVBA>
    <xmx:ZTPGaWuS1VHYqWJHcCXtVk4fDO-9xdIsvQnQXrpMYXG9rCF2pHxaJw>
    <xmx:ZTPGaVEstFlnFLfl1zpG_clb9wciy1Pa7TGA19xryirD3NxWXEoQWA>
    <xmx:ZTPGad9IccozFJ0-AHWgCNjC2GrPsWn6QDjj_dsHtcvtwTTf16Om0-Qr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 03:36:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id abfd166d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Mar 2026 07:36:03 +0000 (UTC)
Date: Fri, 27 Mar 2026 08:35:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #11)
Message-ID: <acYzVsWrDxzzQFGy@pks.im>
References: <xmqq4im2npv2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4im2npv2.fsf@gitster.g>

On Thu, Mar 26, 2026 at 04:16:33PM -0700, Junio C Hamano wrote:
> * ds/backfill-revs (2026-03-26) 6 commits
>  - t5620: test backfill's unknown argument handling
>  - path-walk: support wildcard pathspecs for blob filtering
>  - backfill: work with prefix pathspecs
>  - backfill: accept revision arguments
>  - t5620: prepare branched repo for revision tests
>  - revision: include object-name.h
> 
>  `git backfill` learned to accept revision and pathspec arguments.
> 
>  Will merge to 'next'?
>  source: <pull.2070.v3.git.1774538094.gitgitgadget@gmail.com>

I don't have anything else to add to this series, so I'm fine with it
being merged down.

> * ps/commit-graph-overflow-fix (2026-03-23) 1 commit
>  - commit-graph: fix writing generations with dates exceeding 34 bits
> 
>  Fix a regression in writing the commit-graph where commits with dates
>  exceeding 34 bits (beyond year 2514) could cause an underflow and
>  crash Git during the generation data overflow chunk writing.
> 
>  Waiting for review response.
>  cf. <xmqq1ph92pzs.fsf@gitster.g>
>  source: <20260324-pks-commit-graph-overflow-v2-1-843568cf8780@pks.im>

Hm, I think this status is probably stale, as I've sent out that
response already and don't plan to change anything for now. So from my
perspective the patch is ready for next, but please let me know in case
you have different expectations.

> * ar/config-hook-cleanups (2026-03-25) 13 commits
>  - hook: reject unknown hook names in git-hook(1)
>  - hook: show disabled hooks in "git hook list"
>  - hook: show config scope in git hook list
>  - hook: introduce hook_config_cache_entry for per-hook data
>  - t1800: add test to verify hook execution ordering
>  - hook: make consistent use of friendly-name in docs
>  - hook: replace hook_list_clear() -> string_list_clear_func()
>  - hook: detect & emit two more bugs
>  - hook: rename cb_data_free/alloc -> hook_data_free/alloc
>  - hook: fix minor style issues
>  - builtin/receive-pack: properly init receive_hook strbuf
>  - hook: move unsorted_string_list_remove() to string-list.[ch]
>  - Merge branch 'ar/config-hooks' into ar/config-hook-cleanups
>  (this branch is used by ar/parallel-hooks.)
> 
>  Code clean-up around the recent "hooks defined in config" topic.
> 
>  Will merge to 'next'?
>  source: <20260325195503.1139418-1-adrian.ratiu@collabora.com>

I'll have a look at v3 of this series series today.

> * ar/parallel-hooks (2026-03-26) 13 commits
>  - hook: allow hook.jobs=-1 to use all available CPU cores
>  - hook: add hook.<event>.enabled switch
>  - hook: move is_known_hook() to hook.c for wider use
>  - hook: warn when hook.<friendly-name>.jobs is set
>  - hook: add per-event jobs config
>  - hook: add -j/--jobs option to git hook run
>  - hook: mark non-parallelizable hooks
>  - hook: allow pre-push parallel execution
>  - hook: allow parallel hook execution
>  - hook: parse the hook.jobs config
>  - config: add a repo_config_get_uint() helper
>  - repository: fix repo_init() memleak due to missing _clear()
>  - Merge branch 'ar/config-hook-cleanups' into ar/parallel-hooks
>  (this branch uses ar/config-hook-cleanups.)
> 
>  Needs review.
>  source: <20260326101819.1307742-1-adrian.ratiu@collabora.com>

Likewise, will try to find the time to do this today.

Thanks!

Patrick
