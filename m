Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A703D8129
	for <git@vger.kernel.org>; Mon,  4 May 2026 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904326; cv=none; b=mMAXIEGGViA/pEGo6uUmYM6+W10SWMOG9Wn+yrJHC0/E6Xw5i7otebxTyKUDyj3BVJlE+ygdPvR7tDcAMqX9yYBm2dS6ms5Op+mBaq7i+j55PKROB0fsfKk66GAzRJ/HkpTjhDDes+4Af4TfntEUnNVQyEWve00B+OuWNrTe3RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904326; c=relaxed/simple;
	bh=87JhpZm8ZGGR+N5oa0t46jgxqNmrqSkDgwJSgFNSqH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XD8vdM3Wiom4VmNqi5WqcovmLSSIkICD7SUSqVy9w/7KQKH7+50n8PBXnhILcruvkjCH4eaQ2FuKcfUDqiK5GLCn06JosysZSAIW8RbkmuMk+UET4Mik/qCdJ9DT3UgkLcSkkk5EDDLTTZPtdKu3MEzufYYH42ncJxGmyPRGFDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IhYn8ybs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M2rcMp02; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IhYn8ybs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M2rcMp02"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DE2BB7A0074;
	Mon,  4 May 2026 10:18:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 04 May 2026 10:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1777904323; x=1777990723; bh=3Xe0g1s/6D
	a1bEZOqulUHbqCXcTVN7wUxrTTJcqr/iM=; b=IhYn8ybsYmUDmCzNGGzU0hlth4
	IqIzs1q5HlWN2/5tgx2hcJy+tpjCb/JHKa8DrA+wA0bAO3L7m/9Mvr7nDFHqSFX1
	wmpbUIoaOx8Gd6fhLfVPHx6ybgSSjEFhvE3SwMzjfccVEbFUf/TWgRZ+gnoClXJm
	xtv+UaEIa1oZauWUM/G2r2goVewBqQsL5UKO7krWNgJPMSiopLyrApHQeMLwfi64
	btOZFLI8JCPGHNVDITbKCY+DzwuyLjQ4o+9qIltPfWm97iLAxwHfSBwmm6UjYLS1
	7NX8QAqAbpgzYOtWCHbATBZgNt5/U2/8sAw4KAFSs/zUvlu6afekrSyVB87w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777904323; x=1777990723; bh=3Xe0g1s/6Da1bEZOqulUHbqCXcTVN7wUxrT
	TJcqr/iM=; b=M2rcMp02dVgTynNmBR0rXPFB/ZP3ND1s8yfZRSIAKWSRq5s/F5B
	ueRMSCfLnPYu44fTxgywV6khDvnQT5++IgjTZDYOa9p6dh5AmEw6O1y7WL6XFl5f
	4PUbOgryYksY8lF2JuG2W/xL/28bz5cRGhhjVMbjsFbGiwJMw2pN0yADPaQ1E4DR
	Z0zO9Pq33peJxZkEiumaIGKGG+sVlc68PvJOPc35e5Cszt2nF9JDqub2sEpdDHJQ
	sG7ss5SJxtyaNWi3Gq2V0LBCNqY1ghXt1UcKgFbSPw6dQ2mlb5p5rCaYTK7DY555
	c4KPQy4ZFDGA5RT5jLdRHgnu5Xi3vq5ItiQ==
X-ME-Sender: <xms:w6r4aa1XXObmWLAVN7j1iLRthqqH3Vrb64D_t6RMScmHETZdKMl1oQ>
    <xme:w6r4aTFiJr7iRLUOoSpJ-BbB82QwPB_PEMwNJezf6RoVpXar49kyo7jI4faycLUuc
    xhgxJh-N8XUxANeq4KmxhVWOrQ8hhzjrbCc7nOCHnVYWUVDvmQ2Sw>
X-ME-Received: <xmr:w6r4aQjLBKoxTGzTA85O0lu_-aQ5pVgE2YZ8_7iXwOfmmsuB6rk8_YnQC1awyWJo6u2dinQKSXO2GWaD3Jv2GKnGqPSieJkFjLvGUsiYl6c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelledtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiud
    elueelgfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:w6r4aW_rrfV-btmwnofD-wBJ2uY6QM4lkRZzwc-mYQKt_DJKPvVtjQ>
    <xmx:w6r4afp1rRKl4vZLYDwIv7ha1BUYYxZGo04bB9orbjsQh0T8-Fu6vw>
    <xmx:w6r4ad_C6fdoPjETcqGOcngUZ0oEpR2qqfK7ZuCE8-PyDU3yMpaZeg>
    <xmx:w6r4abUFxXbFIMQm6kFiOiK7DLJXeeS4Hi8ozazuUCqF8XDzDu_7qg>
    <xmx:w6r4aWPA356uiLBpXv7-FjtsfsjnID020lrHT3HM2fArp3qubRpkPwBT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 10:18:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cda2948b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 May 2026 14:18:41 +0000 (UTC)
Date: Mon, 4 May 2026 16:18:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2026, #01)
Message-ID: <afiqvgxwbAOxMsti@pks.im>
References: <xmqqmryhtar8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmryhtar8.fsf@gitster.g>

On Sun, May 03, 2026 at 12:47:23PM +0900, Junio C Hamano wrote:
> * kn/refs-generic-helpers (2026-04-27) 9 commits
>  - refs: use peeled tag values in reference backends
>  - refs: add peeled object ID to the `ref_update` struct
>  - refs: move object parsing to the generic layer
>  - update-ref: handle rejections while adding updates
>  - update-ref: move `print_rejected_refs()` up
>  - refs: return `ref_transaction_error` from `ref_transaction_update()`
>  - refs: extract out reflog config to generic layer
>  - refs: introduce `ref_store_init_options`
>  - refs: remove unused typedef 'ref_transaction_commit_fn'
> 
>  Refactor service routines in the ref subsystem backends.
> 
>  Will merge to 'next'?
>  source: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>

I think [1] is something that may still want to be addressed.

> * js/maintenance-fix-deadlock-on-win10 (2026-04-28) 2 commits
>  - maintenance(geometric): do release the `.idx` files before repacking
>  - mingw: optionally use legacy (non-POSIX) delete semantics
> 
>  To help Windows 10 installations, avoid removing files whose
>  contents are still mmap()'ed.
> 
>  Will merge to 'next'?
>  source: <pull.2103.git.1777380768.gitgitgadget@gmail.com>

I've had a minor nit [2], but other than that this looks good to me.

> * sg/t6112-unwanted-tilde-expansion-fix (2026-04-21) 1 commit
>  - t6112: avoid tilde expansion
> 
>  Test fix.
> 
>  Will merge to 'next'?
>  source: <20260421192132.51172-1-szeder.dev@gmail.com>

This fix looks sensible to me.

> * ps/odb-in-memory (2026-04-10) 18 commits
>  - t/unit-tests: add tests for the in-memory object source
>  - odb: generic in-memory source
>  - odb/source-inmemory: stub out remaining functions
>  - odb/source-inmemory: implement `freshen_object()` callback
>  - odb/source-inmemory: implement `count_objects()` callback
>  - odb/source-inmemory: implement `find_abbrev_len()` callback
>  - odb/source-inmemory: implement `for_each_object()` callback
>  - odb/source-inmemory: convert to use oidtree
>  - oidtree: add ability to store data
>  - cbtree: allow using arbitrary wrapper structures for nodes
>  - odb/source-inmemory: implement `write_object_stream()` callback
>  - odb/source-inmemory: implement `write_object()` callback
>  - odb/source-inmemory: implement `read_object_stream()` callback
>  - odb/source-inmemory: implement `read_object_info()` callback
>  - odb: fix unnecessary call to `find_cached_object()`
>  - odb/source-inmemory: implement `free()` callback
>  - odb: introduce "in-memory" source
>  - Merge branch 'jt/odb-transaction-write' into ps/odb-in-memory
>  (this branch uses jt/odb-transaction-write.)
> 
>  Add a new odb "in-memory" source that is meant to only hold
>  tentative objects (like the virtual blob object that represents the
>  working tree file used by "git blame").
> 
>  Will merge to 'next'?
>  source: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>

This series should be ready, yes.

> * jt/odb-transaction-write (2026-04-02) 7 commits
>  - odb/transaction: make `write_object_stream()` pluggable
>  - object-file: generalize packfile writes to use odb_write_stream
>  - object-file: avoid fd seekback by checking object size upfront
>  - object-file: remove flags from transaction packfile writes
>  - odb: update `struct odb_write_stream` read() callback
>  - odb/transaction: use pluggable `begin_transaction()`
>  - odb: split `struct odb_transaction` into separate header
>  (this branch is used by ps/odb-in-memory.)
> 
>  ODB transaction interface is being reworked to explicitly handle
>  object writes.
> 
>  Will merge to 'next'?
>  source: <20260402213220.2651523-1-jltobler@gmail.com>

The latest version looks good to me.

Thanks!

Patrick

[1]: <87v7dagdjk.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
[2]: <afipTWyj2zVYYqMz@pks.im>
