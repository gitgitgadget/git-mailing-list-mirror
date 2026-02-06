Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF113358A9
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395410; cv=none; b=o/mKuroMbZd2z8kWgQ/vpet9x5OJQka1U0sZ6x9KQVvvnjQ9zb50WEYAj5p5+U1HJScdoj7VH7nvMrN7SifHVdoSdC/ydnSqtnEuSODsGsHPN14C28YuzNRDNlGTde1jJdJSZWXgQExJg5kQlN62Y9mUDtm7JaDJXcf48NOi11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395410; c=relaxed/simple;
	bh=CMw9B63b481fvXxQtppWZTD/q2Vsde3/vEFfPCnXeic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLUb/nmuvsoK3+BNwTiCD56MbGLDNd/i+dM/OARtHdoz67y8NV3E0GwBfaRkBR6FY3LvO1aDD80lmwydfBqTq9xIqnM1NcYuvMimJaz33GRXsAIOidyFkf7v1PQm9yeGXJs6j+S9Y0rEahNCOQc2/TDST278JmlfnEIGNeGq620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QPiFWo4W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kvYIPfo3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QPiFWo4W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kvYIPfo3"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 97D937A01BD;
	Fri,  6 Feb 2026 11:30:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 06 Feb 2026 11:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770395409; x=1770481809; bh=T3hBFDwIzq
	yQlo9sPEL/cU6llRKy90O0LxW9mWhZTFI=; b=QPiFWo4Wkek3JA7hUKvVO3mR56
	2W1IWq0gVjHg9e6N8HCdbkbbTxUR5IVl7USJBqj0KwSnzablkW5/hRSfv8JfiHtD
	p/6tGOvpwa24jvUYn/miYOLhjueTPfiVqVgSpBS34OfMEI1Qxim72qjo8CXR/Xx7
	b+ESxvArTr7Ekpno4QM4MsxNhRvb1LwHVHqbkpsYbEkWP+i7o3k2iP2Eof8cGq7H
	U4NGthyMdMHwEZzpay2TfnTONbHMcCUQ+01HRSPAtMCnMN0LJaYjXlTL6LqFMLVX
	DWbDHTtP7FQ/nSzyhZe28nmukK2I+EIsQywY6iRItiXNGkKXEtifNvp/B+Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770395409; x=1770481809; bh=T3hBFDwIzqyQlo9sPEL/cU6llRKy90O0LxW
	9mWhZTFI=; b=kvYIPfo3pzLU3E3n/kOdAFKZNQoPSmZN6VOn+t/ilZxI7x4fCh5
	Tc8sdI76lo+e/ttseFUQEA66+XPhb+gdYh8V0dreeFFgsJjNpuU5NrxVtdsDIWYZ
	8Z3+4eRkpmCSQpGZ5BOswEo8qeUQc+pRRBh8dDRFBm54uZ3Q1zL/WsJrZeVNroku
	ISikQ97Ua24M9CjYjJBkKzoIaruTZ8jaP08qs9hv57gKBaz7x8N4wCPTTCjY7n8E
	UmhJ0Ph7/IizexoSVu0c2WyhkHCnJwQj8ybGK4Ud6nJUI57PArohfbsOK7TOR4d0
	GpHDPI9G2S+84WU4Q3GxrnQ5j5bBYiLhBVA==
X-ME-Sender: <xms:EBeGabKCzk2A2T5rHwOsepABCe4yrZb3zlQvtqBJ_biGdO0qF-fVGw>
    <xme:EBeGaVIxBVtMy7u87Tlei1tb-650toO3g28o3Jx9jeAlKV3sdspd1NmOZrKTdVadS
    9srlE9_fNj6qQqWLpLYiSc2OSD75tMdqH2ONDc-DxUd3cJpdzl11A>
X-ME-Received: <xmr:EBeGaRWiZjMYKGrOH7pUoZJQNwVLx5SUhorChFLQf6A28GehhpOn4TFIsOeqlgGbFlJ1BNWPQx0KAIKimEZTxhzRPaHpxpeCkdOq-i0pIuY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeegtdduveevfeelvdelvefhuedtgeeuffelvd
    dufffhgfdugfdvvedtjeetfedvkeenucffohhmrghinhepshgvrhhivghsrdhttgdpughi
    shgtrghruggvugdrphhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EBeGafgpiOEP3lU8DO9cJf5wLSyjMuAOVgaMHfr4gpXNXglidQZcyQ>
    <xmx:EBeGaU8sFQefWG2O8LIpWOzw_UpsrvP33omB-simTU8BPNmzMeAFFA>
    <xmx:EBeGaRDDPgLh_mmsna_Mp17molBOKTbT22ou6SCjleNh7HwX3WCQ0A>
    <xmx:EBeGaZIgTuYwylgR7cDG4dNvnwv_8-At9i-nJ_uuh8lDMKRNl8czlA>
    <xmx:EReGaejRZHA0oMU2ZZJsw8yhxefIfh-S31F-pMerhoBv7vK3HwEYkEWs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 11:30:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fc85c2f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 16:30:05 +0000 (UTC)
Date: Fri, 6 Feb 2026 17:30:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2026, #02)
Message-ID: <aYYXClcfoHT0TZcX@pks.im>
References: <xmqqbji2k6yg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbji2k6yg.fsf@gitster.g>

On Thu, Feb 05, 2026 at 05:15:51PM -0800, Junio C Hamano wrote:
> * jc/ci-test-contrib-too (2026-02-05) 2 commits
>  - ci: avoid ubuntu:rolling in most jobs for now
>  - test: optionally test contrib in CI
> 
>  Test contrib/ things in CI to catch breakages before they enter the
>  "next" branch.
> 
>  Will merge to 'next'?
>  source: <xmqqjywuyhu9.fsf@gitster.g>

I think this is a good first step to fix breakage. We can still iterate
on top of it.

> * jt/odb-transaction-per-source (2026-02-02) 4 commits
>  - odb: transparently handle common transaction behavior
>  - odb: prepare `struct odb_transaction` to become generic
>  - object-file: rename transaction functions
>  - odb: store ODB source in `struct odb_transaction`
> 
>  Transaction to create objects (or not) is currently tied to the
>  repository, but in the future a repository can have multiple object
>  sources, which may have different transaction mechanisms.  Make the
>  odb transaction API per object source.
> 
>  Comments?
>  source: <20260203001002.2500198-1-jltobler@gmail.com>

This series looks ready to me. There's two comments about the downcast
that should use `container_of()` and changes to the tmp_objdir subsystem
tto work with `struct odb_source` instead of with the complete repo. But
we agreed to handle both of these in follow-up patch series.

> * tc/last-modified-not-a-tree (2026-01-30) 4 commits
>  - last-modified: verify revision argument is a commit-ish
>  - last-modified: remove double error message
>  - last-modified: fix memory leak when more than one commit is given
>  - last-modified: rewrite error message when more than one commit given
> 
>  Giving "git last-modified" a tree (not a commit-ish) died an
>  uncontrolled death, which has been corrected.
> 
>  Will merge to 'next'?
>  source: <20260130-toon-last-modified-tree-v6-0-db827e5df985@iotcl.com>

This version looks good to me.

> * ps/commit-list-functions-renamed (2026-01-15) 3 commits
>  - commit: rename `free_commit_list()` to conform to coding guidelines
>  - commit: rename `reverse_commit_list()` to conform to coding guidelines
>  - commit: rename `copy_commit_list()` to conform to coding guidelines
> 
>  Rename three functions around the commit_list data structure.
> 
>  Will merge to 'next'?
>  source: <20260115-pks-commit-list-coding-guidelines-v1-0-c58868dbf412@pks.im>

I guess this one depends on the outcome of the discussion we had about
renaming stuff. I think it's worth the churn, and don't expect to do
another reroll. Otherwise I guess the series can be discarded.

> * ps/odb-for-each-object (2026-01-26) 16 commits
>  - odb: drop unused `for_each_{loose,packed}_object()` functions
>  - reachable: convert to use `odb_for_each_object()`
>  - builtin/pack-objects: use `packfile_store_for_each_object()`
>  - odb: introduce mtime fields for object info requests
>  - treewide: drop uses of `for_each_{loose,packed}_object()`
>  - treewide: enumerate promisor objects via `odb_for_each_object()`
>  - builtin/fsck: refactor to use `odb_for_each_object()`
>  - odb: introduce `odb_for_each_object()`
>  - packfile: introduce function to iterate through objects
>  - packfile: extract function to iterate through objects of a store
>  - object-file: introduce function to iterate through objects
>  - object-file: extract function to read object info from path
>  - odb: fix flags parameter to be unsigned
>  - odb: rename `FOR_EACH_OBJECT_*` flags
>  - Merge branch 'ps/packfile-store-in-odb-source' into ps/odb-for-each-object
>  - Merge branch 'ps/read-object-info-improvements' into ps/odb-for-each-object
> 
>  Revamp object enumeration API around odb.
> 
>  Will merge to 'next'?
>  cf. <aXk2FjTUMMThs5Kp@nand.local>
>  source: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>

There's been some discussions around the mtime handling, but I think
I've addressed the concerns both with documentation in v4 and with the
plans I've layed out in <aXcrftLpfcG4S5AX@pks.im> and subsequent
messages.

> * pc/lockfile-pid (2026-01-22) 1 commit
>  - lockfile: add PID file for debugging stale locks
> 
>  Allow recording process ID of the process that holds the lock next
>  to a lockfile for diagnosis.
> 
>  Will mrge to 'next'?
>  source: <pull.2011.v6.git.1769109815197.gitgitgadget@gmail.com>

From the ref side of things I'm fine with this series now, and I
couldn't come up with any other scenarios where the PID file would cause
problems. So I think this is in a good enough state now.

> * lo/repo-info-keys (2026-01-23) 2 commits
>  - repo: add new flag --keys to git-repo-info
>  - repo: rename "keyvalue" to "lines"
> 
>  "git repo info" learns "--keys" action to list known keys.
> 
>  Comments?
>  source: <20260123164900.35092-1-lucasseikioshiro@gmail.com>

I expect another reroll of this series with the comments I posted.

Thanks!

Patrick
