Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357AA3D348C
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226381; cv=none; b=mfYfQ3s/Kk4Nlz7mhCod5Gs5z6jHBi9kkOAy86Iq4yvWw13+pnTIEWo72ItKSvWei24wbWjuLAyo9e0zTMZydeyRdxmHanOlzxHKobeOmOx6PZh5hWakdeATK3lnbUPK8x8XeCeHqSkzSxSLDPXiyzkg/dKkdgwZdPHVgQKpgbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226381; c=relaxed/simple;
	bh=l0EHPW1GYnMRvdHP3noDIjWk0KxH9innoKQxmQ6nyQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzpAiHxhuXhR0NBIreNeb4izRc5RiWVw7yueXCDJpM2Nr2sSNSpOYBwtqZL4nvSXzuQ6d1yTrURtjbhtwtKbNogkdLacxmxqlGR6FJ6EGFwo3A905sbc1gfMjv6E2fGFi1YUgujcVj8mpHP0rRUwBTflQTiDnu9gQLyKywSW5jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PHLUcde2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X36QlHXG; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PHLUcde2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X36QlHXG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E7C91D000A7;
	Wed, 11 Mar 2026 06:52:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 11 Mar 2026 06:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773226378;
	 x=1773312778; bh=RGs49xQZHpHvQyglMFa008Na2h8XFH9S7AzgCO9B0Bw=; b=
	PHLUcde28Z+/VxiuH2L3q6ocbyoQNI5rjp1ZmM/j/Bsdm4ghF6SMex1Ik07rW7ld
	vGQRNvdIrJgQcr0j0n7wTjGUoJ5hTbKnpPFnDnoW1GWCAzJd+K6yTTWRakQy+0n6
	dtBEotRvnlar6/gWf1UkJGGnqyrmAg8RwLic+GbauHt3vOYXvLx8xXEC+vYsa9tA
	NUD2gHA85BZsNy6I5e6OOy1iB7d5nn1AG8FuwfRnJkp7dT7V1W1GrrQjbcsGU8Fb
	B22noVmpoNr9xgUmHEDWDSigb7JwMwN9KjfyQlK0Iq8D8NOY1XC3AhgXMOQpEOwr
	rvFm+C4lbBJFLHLVELuC2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773226378; x=
	1773312778; bh=RGs49xQZHpHvQyglMFa008Na2h8XFH9S7AzgCO9B0Bw=; b=X
	36QlHXGYgZezEcHZErJW8F73ta4EQbyzUQqztKTmrBgtlU3fyNB2FJwdSKBao0ng
	IuliN4sswiaSut/66vRXfrrERktGMHk9oE04qa5dSerA4g2mEOCg/lRbTwJWzTYg
	4LCDIqWz7gPhEgbjzjcLUuYq3edZ1brJJvH8bSjnPvHYrZxdcz/ck+ZR6mYfOGJ+
	m4UeVMmyvyoXRxzbmXx48LMOFhh7SHFJGW16qEBfzUb/TQ8dMlRUQh9At/7m6GNq
	QUj4IaZXxS+L54jZ5gljqo3eOhBNZGf1n72gOyB5lYT3o+hpkmKlY86vD4ApfZo8
	8IGrgPlVbS4yDN8XjVgww==
X-ME-Sender: <xms:iUmxabuiMMybYmpWixAqw3o-eJX7-AMmfKxzlD2rCV1EbrrAaH1Y4g>
    <xme:iUmxaTUyeuy5-x4s6EV7eGl7dT8XJ_RfpZg5R9QPdrdtfyYVFI_K68_06b_JwDYbx
    bLCJHgQksGXTBT4RSpN1LFLCq12MBJCl7zZ_aag4dKVg7_3tG99bZ8>
X-ME-Received: <xmr:iUmxaXGREVs9_niTlgyhzu52wxuE4SlJAVWswBQFMgeQK5KE_f8bZ5BVrw17p5ciMLj1FcpYx37PzhMJt6eEuj2n0c4zualeDU6KbBrVWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrnhigih
    hnrdhhgiessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehgihhthhhusgesphgr
    uhhlihhsrghgvggvkhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuug
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:iUmxaV2d8yZMfhDr557Kqk5zCm_7LvyPJsE9yFNDo5L561tXMO5Mlw>
    <xmx:iUmxaZNL7WHTcuRUhSDcXlNwvNLOwgqZYGzS4Qd97y6qMtmWyC95tA>
    <xmx:iUmxaU6Zbw1WEJR6XAYfwsO4IOGf9pjDkWKBbUtntmgZX3yB34DOpA>
    <xmx:iUmxaT2iYUqpHtG2CKkjCZFCJDU5YaDzTcV4BksVccfm7EwtuXQZ2w>
    <xmx:ikmxaSth22J6UhBmpxIazKbIdKpjGZWDfSdowglB_dZmg2Qgij3pAKvN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 06:52:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d6d37bb0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 10:52:54 +0000 (UTC)
Date: Wed, 11 Mar 2026 11:52:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Han Xin <hanxin.hx@bytedance.com>,
	Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v2] promisor-remote: prevent lazy-fetch recursion in
 child fetch
Message-ID: <abFJhFhHLhS4qdrM@pks.im>
References: <pull.2224.git.git.1772643468305.gitgitgadget@gmail.com>
 <pull.2224.v2.git.git.1772648846009.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.2224.v2.git.git.1772648846009.gitgitgadget@gmail.com>

On Wed, Mar 04, 2026 at 06:27:25PM +0000, Paul Tarjan via GitGitGadget wrote:
> From: Paul Tarjan <github@paulisageek.com>
> 
> fetch_objects() spawns a child `git fetch` to lazily fill in missing
> objects. That child's index-pack, when it receives a thin pack
> containing a REF_DELTA against a still-missing base, explicitly
> calls promisor_remote_get_direct() — which is fetch_objects() again.
> If the base is truly unavailable (e.g. because many refs in the
> local store point at objects that have been garbage-collected on the
> server), each recursive lazy-fetch can trigger another, leading to
> unbounded recursion with runaway disk and process consumption.

Is this a theoretical concern or a practical one? I would expect that
backfill fetches never cause the server side to send a pack with
REF_DELTA objects to nonexistent objects. And if they did they are
broken.

> The GIT_NO_LAZY_FETCH guard (introduced by e6d5479e7a (git: add
> --no-lazy-fetch option, 2021-08-31)) already exists at the top of
> fetch_objects(); the missing piece is propagating it into the child
> fetch's environment. Add that propagation so the child's
> index-pack, if it encounters a REF_DELTA against a missing base,
> hits the guard and fails fast instead of recursing.
> 
> Depth-1 lazy fetch (the whole point of fetch_objects()) is
> unaffected: only the child and its descendants see the variable.
> With negotiationAlgorithm=noop the client advertises no "have"
> lines, so a well-behaved server sends requested objects
> un-deltified or deltified only against objects in the same pack;
> the child's index-pack should never need a depth-2 fetch. If it
> does, the server response was broken or the local store is already
> corrupt, and further fetching would not help.

Exactly, this here matches my understanding. The backfill fetches don't
perform negotiation, so we shouldn't ever see a thin pack in the first
place. What I don't yet understand is your comment about the depth-2
fetch -- when would we ever do that?

> This is the same bug shape that 3a1ea94a49 (commit-graph.c: no lazy
> fetch in lookup_commit_in_graph(), 2022-07-01) addressed at a
> different entry point.

I dunno, I think it's quite different overall. In the mentioned commit
we protect against a stale commit-graph, which is something that is
quite plausible to happen on the client side. But here we protect us
against a remote side that sends a packfile that violates specs, as far
as I understand.

> Add a test that verifies the child fetch environment contains
> GIT_NO_LAZY_FETCH=1 via a reference-transaction hook.

Hm. Can we craft a test that shows us the resulting failure in practice?
Testing for the environment variable feels like a bad proxy to me, as
I'd rather want to learn how Git would fail now.

> Signed-off-by: Paul Tarjan <github@paulisageek.com>
> ---
>     promisor-remote: prevent recursive lazy-fetch during index-pack
>     
>     Propagate GIT_NO_LAZY_FETCH=1 into the child fetch spawned by
>     fetch_objects() so that index-pack cannot recurse back into lazy-fetch
>     when resolving REF_DELTA bases.
>     
>     We hit this in production: 276 GB of promisor packs written in 90
>     minutes against a 100 GB monorepo with ~61K stale prefetch refs pointing
>     at GC'd commits.

Okay, so this seems to be an issue that can be hit in the wild. But I
have to wonder whether this really is a bug on the client-side, or
whether this is a bug that actually sits on your server. So ultimately:
why does the server send REF_DELTA objects in the first place? Is it
using git-upload-pack(1), or is it using a different implementation of
Git to serve data?

Note that I'm not arguing that we shouldn't have protection on the
client, too. But I'd first like to understand whether there is a bug
lurking somewhere that causes us to send invalid packfiles.

Patrick
