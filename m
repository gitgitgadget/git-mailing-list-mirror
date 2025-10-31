Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D592EE5FD
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761892942; cv=none; b=X4FDAr1x1YNRZF4gyxweNhyz0ihq/l6rVpNONBiENnujX2/ps7eHFG8BuwK6UMPHxVXU2qJV/dCJfFk6iKSo74/8u0CaAI7nIMYTsFlQGjvlu1dLnIkl3I7jvfEnWsVRKeUGWUxjg5U052BlhvwslE1mJe+11NzvLUV5LR53ZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761892942; c=relaxed/simple;
	bh=umtH1l/bEBNsvi20au4tOfcjLX6ei/y3MaGEWxZcjyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E29lMpR0wF7HNDbFQ2+2ApqVW3qJPrhDPn+Ctksx0gEtG6jNqtHtNYoDZsEfXTemVfjfTbS4C9GUs+ahCpsIYQ6o3aBwMjkY2DKoVkQFRb20L2lO8zoy9q1hewHJ8jj/3X2hTGZOSqpUFZcA+xdinuCoKYN1lCCSb5ryNpoqxw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mpj4V0pz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tw9giE0+; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mpj4V0pz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tw9giE0+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 367AB14000D7;
	Fri, 31 Oct 2025 02:42:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 31 Oct 2025 02:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761892939; x=1761979339; bh=srGzzNxfjY
	+IBDD2xfOgJE2sh2xLRFf7DCw1flubBA0=; b=Mpj4V0pzzL0HXpUELqAPMrZr2/
	zgNxIWTkxJCeS04/fy+DOiuUsEWMHF69/bxVcwXXFzuOUHMELXDZyi9gDtIJEL+i
	jvGsyKbPr0/849IRW6gbwnBM2ukslxKY1wyWZ06ilFQY0vD4LCEyouK7m+0jwsYm
	GPRpsZ3esov1ZfQOmn3EfvAS4MqhndbJf7gGYAC+H4nsKkvOs/XOP+AivCy8VvLw
	/nxUpfInJi8p7OxGwmOTrZgm7TrtfokBsjzfJNhl1Gelanej/Hu9yDI8LMKjz3+S
	IruRxjZ1rKQAxDm/eHspOo9ecoVsb3UDWjdMTzoqjorzzIqYNLrt14FlHp5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761892939; x=1761979339; bh=srGzzNxfjY+IBDD2xfOgJE2sh2xLRFf7DCw
	1flubBA0=; b=Tw9giE0+TKfzArhOKpC2egttMgTtYcWvxeS76Axo9BPtnuO4iRX
	eHqDYZz8phjyjOwryqAOB0Id5yDMSSSGkuyiPEh/a4UpWFL0s70kFN1JEv3COjEj
	rXRQt1k38odcBJHz1CZ6TpiHbzntlCF2zUAiw4A0MW/1AmqCocK4I1dEJpEvHR1d
	2Yyc9sMLqDGfn8gDiwwoE1l0H5JY7xKHbjr1O/aFUsDFxf/t9BQoF+GJvJyLjTPm
	eEZ9VqNOPKKndF+Whr82O6n7Dkfu6cjD3l8TBIEmJtWaEQ3Ue68of2TKHkHAPKv0
	v16tdhaMP9g4lL3UTvwgMLD1nHZ9IggH3AQ==
X-ME-Sender: <xms:S1oEaQro7ZZL1qzs3emYIRZcqKcJNce0mASRiusFbuhfWxfUzLxeIw>
    <xme:S1oEacpnkG_NAWRCBRTdWOjqmSTvpWA9aCarfIJ2mlYyqFnhr0M3vJ6JlYIQb_UmL
    9eIjH8CxCUodmv8GPF2jG6giDG_r4jsM7vPTq_VERzg5wgqyCNaq1M>
X-ME-Received: <xmr:S1oEaS2jPEzkhiwczxMgZyNPAFK4AoN4BTjBiuNSGcfSqWgtndRKshCteAxANcDFgo5afMYxer1CZojosiDZ9vAqUM466A3-oYjJkLgoI5kNgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:S1oEaTAxwotk01B53_wr9bCCjlZ25K98hh9b2Y9rg0mDq6uX7QrzGg>
    <xmx:S1oEaSeP5tvkYKaRSJzZ5zkbyXxY2CALO38cahTr4X_sEEw6mQbRmg>
    <xmx:S1oEaQjpUy31kY3ZGFiHQX4T6vXz5209avI0Zoc3Or4-ASI4qyZmCQ>
    <xmx:S1oEaSobDE9G3aSvCKESWRjy3jgK-0gUX6j-XxlEh83N4utNSc50cQ>
    <xmx:S1oEaUDDmf_JPjVSOvrb9Sexep8zYocVa0NQbEEOclisndG7vdK3Czk_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:42:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 85c53395 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:42:17 +0000 (UTC)
Date: Fri, 31 Oct 2025 07:42:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #12; Thu, 30)
Message-ID: <aQRaRuBtt_r7SamL@pks.im>
References: <xmqqpla43wcp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpla43wcp.fsf@gitster.g>

On Thu, Oct 30, 2025 at 02:36:54PM -0700, Junio C Hamano wrote:
> * cc/fast-import-export-i18n-cleanup (2025-10-30) 5 commits
>  - gpg-interface: mark a string for translation
>  - fast-import: mark strings for translation
>  - fast-export: mark strings for translation
>  - gpg-interface: use left shift to define GPG_VERIFY_*
>  - gpg-interface: simplify ssh fingerprint parsing
> 
>  Messages from fast-import/export are now marked for i18n.
> 
>  Will merge to 'next'?
>  source: <20251030123332.3337684-1-christian.couder@gmail.com>

I just read through that series. All of the changes look like obvious
improvements to me.

> * ps/packed-git-in-object-store (2025-10-30) 9 commits
>  - packfile: track packs via the MRU list exclusively
>  - packfile: always add packfiles to MRU when adding a pack
>  - packfile: move list of packs into the packfile store
>  - builtin/pack-objects: simplify logic to find kept or nonlocal objects
>  - packfile: fix approximation of object counts
>  - http: refactor subsystem to use `packfile_list`s
>  - packfile: move the MRU list into the packfile store
>  - packfile: use a `strmap` to store packs by name
>  - Merge branch 'ps/remove-packfile-store-get-packs' into ps/packed-git-in-object-store
> 
>  The list of packfiles used in a running Git process is moved from
>  the object-database layer down to object-store layer.

Correction: the list of packfiles is still essentially on the object
database layer. The change here is that it's not contained in `struct
packed_git` anymore, but instead it's moved into the packfile store.
So packfiles become a standalone entity, and the packfile store is
completely responsible for managing the list of packfiles.

>  Will merge to 'next'?
>  source: <20251030-pks-packfiles-store-drop-list-v2-0-84654f080cc0@pks.im>

I think the series is already in a good shape after the last round of
reviews, but let's give reviewers a few more days to reply to the second
version.

> * lo/repo-info-all (2025-10-26) 2 commits
>  - repo: add --all to git-repo-info
>  - repo: factor out field printing to dedicated function
> 
>  "git repo info" learned "--all" option.
> 
>  Will merge to 'next'?
>  source: <20251026225409.46647-1-lucasseikioshiro@gmail.com>

I think there's still a couple of comments from Eric on v3 of this
series that probably need addressing?

> * ps/ref-peeled-tags (2025-10-23) 16 commits
>  - ref-filter: parse objects on demand
>  - ref-filter: detect broken tags when dereferencing them
>  - refs: don't store peeled object IDs for invalid tags
>  - object: add flag to `peel_object()` to verify object type
>  - refs: drop infrastructure to peel via iterators
>  - refs: drop `current_ref_iter` hack
>  - builtin/show-ref: convert to use `reference_get_peeled_oid()`
>  - ref-filter: propagate peeled object ID
>  - upload-pack: convert to use `reference_get_peeled_oid()`
>  - refs: expose peeled object ID via the iterator
>  - refs: refactor reference status flags
>  - refs: fully reset `struct ref_iterator::ref` on iteration
>  - refs: introduce `.ref` field for the base iterator
>  - refs: introduce wrapper struct for `each_ref_fn`
>  - Merge branch 'jt/repo-structure' into ps/ref-peeled-tags
>  - Merge branch 'tb/incremental-midx-part-3.1' into ps/ref-peeled-tags
>  (this branch is used by kn/refs-optim-cleanup; uses jt/repo-structure.)
> 
>  Some ref backend storage can hold not just the object name of an
>  annotated tag, but the object name of the object the tag points at.
>  The code to handle this information has been streamlined.
> 
>  Will merge to 'next' after base topics are merged.
>  source: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>

Both dependencies have landed, so this should be ready to be merged now.

> * je/doc-data-model (2025-10-27) 1 commit
>  - doc: add an explanation of Git's data model
> 
>  Add a new manual that describes the data model.
> 
>  Comments?
>  source: <pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>

Will have another look at v5 of this series. I think it's nearing a
state where it's good enough to be merged down.

Thanks!

Patrick
