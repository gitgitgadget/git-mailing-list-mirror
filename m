Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6E525E447
	for <git@vger.kernel.org>; Tue, 20 May 2025 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747723518; cv=none; b=U2gYIiMWMOHu7Xgq3LwlE+DEchjcSDYys9O9MUQINz2snY4rlVPDB2EqBkMo85FZuoPjcjQjdA/h2LxCrghZEnWaW4ZeKKXu+SUa0W1r0OZSGm1ewksz2RTTzEW+8tk4JFL6lUWXG/8w1tqPsackvZEq6hZyN8K6j72KOFR1hE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747723518; c=relaxed/simple;
	bh=7qpoTgvH0qT0nnrL2bmPzl2N1QFqych5ufONasES9Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPdX3ExdlLKYM/fW/ksjTkz1231wN2G0Pjt9lfhZ8GEzbvuEyRmxPSNp1DJ8MU4dCc/Kic0xn0V66UZLzNiHDfcVMXJykcEdkObR/VJ6ZoXEm54P8H3f/DVMa55/0zjdSEBKwcJMA3VjwwL2JCLvGFl1jH9EAY722FZsew4XfgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ahprix13; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PjLVa1lm; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ahprix13";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PjLVa1lm"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0483B114013B;
	Tue, 20 May 2025 02:45:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 20 May 2025 02:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747723513; x=1747809913; bh=ZP7fck0FIJ
	c3woGJQsf5p0bRh3LN3zYgQ7dVxof+tuM=; b=Ahprix13Exaw8nMaIrMKBr/V+w
	DiH+avZdy8ou+QfTmJEb5zqPwMwZFMY9ixwSJBHY5JDJQ2PRHQf/rWGR/jlPiHbI
	kxzAnoH+eKlQas641cHCBlFRd4sKI+KoOaSmsdbi3timrkPtmmg9EGiQbp4lh4w3
	tm9CZQu9NNx2/0g3jwQeephfW5YUrU2DvjhVbJFOyyC3J0+6tfXy7FiEXHfLCtX8
	W+dSCUHbvfiHFPSVJKAzchUB9Oncg/WnrRngYKrUm6fOZlNMaRHTS4Hg12FXGrWk
	jXLHZ1uyi6AV1h6AfAGDFI+plO270CsGfoh+j0cAiFrfie98qGazx+mU5lyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747723513; x=1747809913; bh=ZP7fck0FIJc3woGJQsf5p0bRh3LN3zYgQ7d
	Vxof+tuM=; b=PjLVa1lm4IlCLcw58o2yM3EbJ+oJ4LInAAbuexQfIjnBlppIPNt
	BqV6nL/IZjyyH/t6Fh72DlscdecIt/L3SfLenD4eJTq7uqZii1wJpWHE08MlLefL
	eiQiTukGHjxxsEjiUXhgM2U+LJw617hGG97psJdbjO741SsLFomCQnMGs1ZdOaAF
	gmN6jR+epORy4vV09CWsD5FoK5FUotY3LH543fvaVbDEkWCph469Uk6qASI0y6CO
	l5FZd/ZU2XzP+2R67C4Lvvna2+Ss3AGACYNF39i380Q9mcaHBr4Ibg34PQL+aao0
	QpZ7+rSsdxelOK/pgjYPmJcqljZJCudVSyA==
X-ME-Sender: <xms:-SQsaCLzx6DUHyNBjRzi30PvCGBmBNHUQ5N3mn_W42GCZ8Onrqdk-Q>
    <xme:-SQsaKIt4QAZzXOCAhGWmfS2k58_QeLdhv4TSz_dFXRIyCG1a2-anICDv2oKZwQFa
    gc9WimiLvTW58YILg>
X-ME-Received: <xmr:-SQsaCtSmDNHb01Ma72HnoZD17OssRSEcl-FSNBVNVIbp_t6hmN6BZdsi7RrxRMI2Fr2wRvh9c3Yo4bRDasmyVOrSZGr1cRlB0G9EATOOjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdefheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:-SQsaHYKNSBdk5wHCPf4Qw9AKDXTfxubJKef2XvP659X47nyx151Tg>
    <xmx:-SQsaJY8B5MZ3QU0-5RPPtDh3PLi5wdGg4BqiFNERaF_feybmhK_3Q>
    <xmx:-SQsaDAssonS6--QsmQdNtzU-X-Ik2P7aRZPjZ_QM2rxdrAU7kJUaw>
    <xmx:-SQsaPaBbYMl8Nw_8J5bYRD2jrPa9iFCkcU7dri-lWJHvrM8c636Eg>
    <xmx:-SQsaKn2NPyd1D0gqtttYOCdMrKNdSIfcvWSl_o9y6-hTaZQDlTld4Gv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 02:45:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b54560b4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 20 May 2025 06:45:10 +0000 (UTC)
Date: Tue, 20 May 2025 08:45:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] packfile: avoid access(3p) calls for missing packs
Message-ID: <aCwk8vnK-QCtp9Bo@pks.im>
References: <20250516-pks-pack-avoid-stats-on-missing-v1-1-e2ef4d8798a3@pks.im>
 <xmqq7c2gv1zx.fsf@gitster.g>
 <20250519065221.GC102701@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519065221.GC102701@coredump.intra.peff.net>

On Mon, May 19, 2025 at 02:52:21AM -0400, Jeff King wrote:
> On Fri, May 16, 2025 at 11:34:10AM -0700, Junio C Hamano wrote:
> 
> > > The reason why we do this is likely because we reuse `p->pack_name` to
> > > derive the other files' names, as well, so that we only have to allocate
> > > this buffer once. As such, we have to compute the packfile name last so
> > > that it doesn't get overwritten by the other names.
> > 
> > I vaguely recall that the order of checks between .idx and .pack
> > were deliberately chosen, as we do not want to add and attempt to
> > use .pack file before its associated .idx file is ready since
> > without the latter the former is unusable at runtime.  
> 
> It is definitely intentional and important that we discover packs by
> their .idx file first. The writing side uses the creation of the .idx
> file (via atomic rename) as the final step in making a pack accessible.
> Before that, a reader could see a .pack without its various accessory
> files (and so not realize it has a .keep file, for example).

Yup. But that order doesn't change anyway in this patch. What changes is
only the order for auxiliary and non-mandatory ".keep", ".promisor" and
".mtimes" files.

> >     Side note: It may have been more important back when the name of
> >     the packfile was a hash of names of the objects in the pack,
> >     which meant that when you repack a quiescent and fully repacked
> >     repository twice with different parameters, you could have ended
> >     up with a packfile whose name is the same but the contents as a
> >     bytestream (hence the object offset) are different, making a
> >     stale .idx not pointing into the correct position in the new
> >     .pack file.  These days the name of the packfile is based on the
> >     contents of the pack as a bytestream, so we no longer suffer
> >     in such a scenario.
> 
> I don't think reading the .idx file first was sufficient to protect us
> there, since the .pack could be replaced racily after the reader opened
> the .idx. I don't recall if we were subject to that race back then (and
> it just didn't come up enough to worry about), or if repack would throw
> away an identically-named file. Anyway, as you note, it's no longer an
> issue.
> 
> But I think that is mostly orthogonal to how the auxiliary files are
> handled. I think Patrick's guess is correct that the order we have is
> simply because it was most convenient to end up with ".pack" in the
> name.

Taking a step back though: do we always ensure the order in which we
those auxiliary files are created and deleted? If we know that those are
always:

  - Moved into place before their ".idx" file.

  - Deleted after deleting their ".pack" file.

Then reordering may cause us to race indeed so that we see the packfile,
but miss the auxiliary data structures. `unlink_pack_path()` does seem
to ensure the latter property, as both ".idx" and ".pack" are deleted
first. I'm not quite sure about the former, but it seems like we also do
this.

So I think that the proposed patch is wrong. There should definitely be
a comment in that function though to say that this order is intentional
and not merely an optimization.

[snip]
> > > while the issue was entirely self-made because the multi-pack index
> > > should have been regenerated, we can still reduce the number of syscalls
> > > by 75% in the case of nonexistent packfiles by reordering these calls.
> > 
> > That sounds more like a band-aid, if we still do the remaining 25%
> > that we somehow know would be unnecessary.
> 
> Yeah, that was my gut reaction, too. add_packed_git() is not
> optimized[1] at all. But it shouldn't have to be, because it's meant to
> be called once per process. Even with the re-ordering, we'd still make a
> bunch of pointless stat() calls for the .pack file we know is not there.

It certainly is, as mentioned in the cover letter. It was a supposedly
cheap win as I didn't want to introduce a negative lookup cache for an
edge case like this. But the patch below looks simple enough -- I feared
it would be a lot more involved.

> The code in prepare_midx_pack() converts a numeric pack id (referenced
> inside the midx) into a "struct packed_git" pointer, caching the results
> in multi_pack_index->packs. That field holds NULL for "we have not
> looked it up yet" or a valid pointer to a packed_git. It probably needs
> to hold a third state: "we tried and failed".
> 
> Something like this (large untested) patch:
> 
> diff --git a/midx.c b/midx.c
> index 3d0015f782..354b1f886c 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -405,7 +405,7 @@ void close_midx(struct multi_pack_index *m)
>  	munmap((unsigned char *)m->data, m->data_len);
>  
>  	for (i = 0; i < m->num_packs; i++) {
> -		if (m->packs[i])
> +		if (m->packs[i] && m->packs[i] != (void *)(intptr_t)-1)
>  			m->packs[i]->multi_pack_index = 0;
>  	}
>  	FREE_AND_NULL(m->packs);
> @@ -458,6 +458,8 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
>  
>  	pack_int_id = midx_for_pack(&m, pack_int_id);
>  
> +	if (m->packs[pack_int_id] == (void *)(intptr_t)-1)
> +		return 1;
>  	if (m->packs[pack_int_id])
>  		return 0;
>  
> @@ -482,8 +484,10 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
>  	strbuf_release(&pack_name);
>  	strbuf_release(&key);
>  
> -	if (!p)
> +	if (!p) {
> +		m->packs[pack_int_id] = (void *)(intptr_t)-1;
>  		return 1;
> +	}
>  
>  	p->multi_pack_index = 1;
>  	m->packs[pack_int_id] = p;
> 
> -Peff
> 
> [1] There probably are optimization opportunities in add_packed_git(). I
>     don't think re-ordering will help much in the common case that we
>     actually do have the pack. But really, most callers do not care
>     about these auxiliary files at all! We could simply skip them during
>     the initial setup and lazy-load them via accessor functions.
> 
>     I _think_ that should be OK with respect to races. For a newly added
>     pack, we know they will always be in place before the matching .idx
>     file (per the logic I outlined above). For a pack that goes away, we
>     might racily fail to see its auxiliary file. But that is mostly true
>     now (we might see its .idx, and then the .promisor file is deleted
>     before we call access()). It does increase the size of that window,
>     though (and in particular lets it happen even if the pack has
>     actually been opened).

I'm not sure it would be okay, as mentioned above. The current ordering
ensures that we always see auxiliary data structures in case the ".pack"
file exists. If we started to cache then that wouldn't be the case
anymore.

>     I'm not sure how much that would matter in practice. OTOH, I'm not
>     sure that saving a few access() calls would be all that meaningful,
>     unless you have a zillion packs. And if you have a zillion packs,
>     you're likely to get much bigger speedups in other areas by
>     repacking them anyway. So it hasn't really been an area I've
>     pursued before.

It probably doesn't in the general case at all.

Patrick
