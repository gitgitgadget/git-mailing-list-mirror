Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AAF29D280
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765359626; cv=none; b=SJc0wBOa4Z04KOUW1bKCcQRKIgUGyOqrQOpb7QiynTBYDeKfxX9baMjYe4VeVNuthnW5hMJJIuTxskAiY+pBFutZBur13J8RNY6lCxwWDzokN0xFmThgCOCP81WOJ2tcMSxCkGz3atBfjEpWdaRgUzkss+SDnn4uP4eTH5kAB9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765359626; c=relaxed/simple;
	bh=e/n683Zmh3vB4C1hl+8gsJWPhbF09VUAo/KFaa5kMuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5Tghd04VVk/i0o6F7gT5L3lsC8BRyE9tFUNDm3PokdNdL1eBgRUQZyuQcoMhLsnD/j3GzNIhbj9UOqLg29o1RhD52UwOxxLg4sRuXjB1dX2NZ6765qvL0fbEM2tVs0p0aLiCiEpO7cxjllnXQ6hmBZE8ASmFr9UYoSzOVVQqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jTW1l/fW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QUcQYo5X; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jTW1l/fW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QUcQYo5X"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 10B8C1D00054;
	Wed, 10 Dec 2025 04:40:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 10 Dec 2025 04:40:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765359621; x=1765446021; bh=kUYfzi0aEX
	8JoQWqdMi+zRxCg9w7aEMZ+fa463iglEE=; b=jTW1l/fWgHPP8wzZNsot9swZJn
	HB1Rmk1na0J1Exj/j3Mb1JFQd0Uioo6ETmX47DBB22hn0xbmZekOarBbb6yNKli3
	hlk0E6P5G7zmetzV2KHIl+iMy+m1HjXAsy2j/Zsp/afgl5Ufq/X+/Sl0Z+L0punk
	Qq7kA9JYUy2/1ptNx57zbBv24xQPTyQjQi26PcNqptFhi+t96oO9Da6kv/XkZJEc
	xxPdq8kdVXRKKjoXNYsUzNDmkA1lSM7KPv5gEPQ0O4WFQfpa32Z6kuuJzioaO5Od
	PmDblbTutE+zrbhzhg+z/PNUpFlKhnKvzXQ6Fg+cHMPhAmomMM4Mgh99fPSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765359621; x=1765446021; bh=kUYfzi0aEX8JoQWqdMi+zRxCg9w7aEMZ+fa
	463iglEE=; b=QUcQYo5XzNDL5yFZFqPGEuAIF+H7+GZKzz4epv+TiU2VGGlVcGt
	kvm2IIaFwW8RDZ8pZbkmLHQADLDaF1gzBOPPst/o3pBsGxqvNYeOCQSh6OJ7rH+c
	cPNLqYUVVVSeXMKcBlm96f8RK0OdG+b7aLSYW1pO61SBF6zTSq2StALwxWJTYqn/
	EsoOejWFLu+XxwEo6FcO99ApEvwFPzut08tLVJvgUwr65yWHjBX474fzdrHoC2rg
	WoETMtRnaqKqRFTzvlk17SoNFk99gvGZFrvSW8VtdgJz053cSivvoNQvaqIinQk5
	8CIZHJKkHakRlzGTeR9S36iLA8ShgSs4Chw==
X-ME-Sender: <xms:BUA5aQUiasi8nznyX4uXnGLojRlNM2SGbqgFRy6LztpJdW9iy-Z2HQ>
    <xme:BUA5acDxLhSzX19Xd_aasXpd_muJf92zb66soHnGjjbDXiAZYsgIK63Q_ID_jtB4I
    fZCjMjUqIKzGg0lKHG2borbJqlpyALO7vEEkCN8Vnsr3ZVGexZL2BY>
X-ME-Received: <xmr:BUA5aRx3rVaiBO7qHeStwUqkIv9WheX0nRmuGr274CGibHQLswfUDpXLdGCJFH_dwQsDIkz_s5G2lWXMUKdPHqZGcXE9oZKfdlSP6_269l7L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BUA5aZBieb8xWZCKnI4_Dxz5em9Fc7SAErK7AurGnjHTAWO-cKlZ5g>
    <xmx:BUA5aebSXbzhgWqWxxsD8MnVNPv0V5ZF4Jj6sTq_ImkWLGMTxb81vA>
    <xmx:BUA5aRjxBmonYqG9dqtWAGmUniCdQpjJaSHenEiUAkXtSENGb0L_vQ>
    <xmx:BUA5aQ5Bg-GxqkcbCBCA-JQDzWmE5ifdmLhKArYA-L-bATZaHEoKgg>
    <xmx:BUA5aQfmR0_WwYWOYPvQYO4ROp2ejpT0Bhc87Fre2zK1hnb2uvdppCwf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 04:40:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3e264952 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Dec 2025 09:40:19 +0000 (UTC)
Date: Wed, 10 Dec 2025 10:40:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] midx: fix `BUG()` when getting preferred pack
 without a reverse index
Message-ID: <aTk_-pvNA31ScZyu@pks.im>
References: <20251208-pks-skip-noop-rewrite-v1-0-430d52dba9f0@pks.im>
 <20251208-pks-skip-noop-rewrite-v1-1-430d52dba9f0@pks.im>
 <aTi9M/F0sZzK/usA@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTi9M/F0sZzK/usA@nand.local>

On Tue, Dec 09, 2025 at 07:22:11PM -0500, Taylor Blau wrote:
> On Mon, Dec 08, 2025 at 07:27:14PM +0100, Patrick Steinhardt wrote:
> > The function `midx_preferred_pack()` returns the preferred pack for a
> > given multi-pack index. To compute the preferred pack we:
> >
> >   1. Look up the position of the first object indexed by the multi-pack
> >      index.
> >
> >   2. Convert this position from pseudo-pack order into MIDX order.
> >
> >   3. We then look up pack that corresponds to this MIDX index.
> 
> I think the implementation of midx_preferred_pack() works a little bit
> differently than is described here. I often get confused when working in
> this area juggling between the various object/pack orderings in my head.

Hm, I feel like I am missing something.

> midx_preferred_pack() cares about converting from the first position in
> pseudo-pack order back into MIDX object order. To do that, we convert
> the pseudo-pack position into a MIDX one, and then lookup the pack that
> represents that object.

Isn't that what I say in (2) and (3)? Or is this about (1) being
inaccurate? Would this sequence be more accurate:

  1. Take the first position indexed by the MIDX in pseudo-pack order.

  2. Convert this pseudo-pack position into the MIDX position.

  3. We then look up the pack that corresponds to this MIDX position.

In any case, I agree with you that juggling these different positions is
quite something :)

> > [...] But we only check for negative
> > return values there, even though the function returns a positive error
> > code in case the reverse index does not exist.
> 
> Ah. It looks like that was changed in 5a6072f631d (fsck: validate .rev
> file header, 2023-04-17), but it looks like the caller here did not
> learn about that change. It may be worth mentioning that commit in your
> patch message.

The caller was introduced at a later point though, via b1e3333068 (midx:
implement `midx_preferred_pack()`, 2023-12-14). So there wasn't really
any overlap here where both topics were cooking at the same point in
time, at least not upstream. And the commit that changed the return
value of `load_midx_revindex()` did update all callsites.

> While reviewing, I wanted to make sure that there weren't any other
> callers of load_midx_revindex() that were also missing this check. The
> return value of that function is propagated through the two expected
> functions:
> 
>     $ git grep -p load_revindex_from_disk
>     pack-revindex.c=struct revindex_header {
>     pack-revindex.c:static int load_revindex_from_disk(const struct git_hash_algo *algo,
>     pack-revindex.c=int load_pack_revindex_from_disk(struct packed_git *p)
>     pack-revindex.c:        ret = load_revindex_from_disk(p->repo->hash_algo,
>     pack-revindex.c=int load_midx_revindex(struct multi_pack_index *m)
>     pack-revindex.c:        ret = load_revindex_from_disk(m->source->odb->repo->hash_algo,
> 
> , and checking through the callers of those two functions, all are
> prepared to handle a >0 return value.

Yup, thanks for double checking.

Patrick
