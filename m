Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28E23B7B71
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787212482; cv=none; b=sRXm/lx1Hgf3x8cUsPpqUd6/UPLysBSx7SCFRmzjWWFBFW40R7gz1maVikGTs1N6C6bKuV0sPfVy4pB2Y303uXY8+A3SxKi0y97G+Aujt+MBldahuJQitXvgPp5l2BKxQze2TJtEmG2+B9tOZPGgXo6H5fVWFxka82A13TWQ168=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787212482; c=relaxed/simple;
	bh=FVDNlJrkrfg9QWgk8TXNltzjRGd5RkOVyRA27Z7XZac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rot+8tEMmPLQV1MrO4oNcw8w8IGGT0tV6BrvLfqokQHtQZ547HbqMph6AmFLhSU0ZhUhTB2yMSpf4FQVfDpXVD6xDJhRNkwBXIYEqVYEPou9uI8ysHUgCrahgkNbpGr1xuqUqY+SlNFCruDCAl8aGSUQ0BJhQl8WFZMNtt0P9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hm+KCbeK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PEnX04xe; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hm+KCbeK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PEnX04xe"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED10514000D4;
	Thu, 20 Aug 2026 03:54:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 20 Aug 2026 03:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787212479; x=1787298879; bh=N0zgG5TOcA
	Rfw18iMgODeyx/lZKrdoq8UYCSOYbuoDA=; b=hm+KCbeKx32d2+qPeAWRUHKibT
	+MnuwNezen1jeB+wy9AIvTEO/DwGvjwFW9L+a3+RhTXGlqea5C/poVlfQUZ1UOOw
	wbKdovwVOwmQCQHVeZaGtJRcu+uvWDDo/N/yxqPNozjKKX3tIFcIzZds0m2nQ432
	HvzYMq8UEfD3TWRz9l8cRIViCwu1SMYHdYxJIjnCvpuWRQ/EW4bNGMnWFZuDmWow
	gVucn+vIuaDPN6UbGGqJ24304fC92sShdr9iBnPZhv9/hG4VfOjvJO02S1XiRz6o
	uLOVwvf6kDHXKxank4AF1VjAsXJMMnmAuGobn43vvXPQn6LwuCHT7NeMrTlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787212479; x=1787298879; bh=N0zgG5TOcARfw18iMgODeyx/lZKrdoq8UYC
	SOYbuoDA=; b=PEnX04xe5T16d8j1R04L0LON1Z2fLyMjzQkvJ/AIAzoRQkIxUVP
	55XtF1ltrJWVW2PgE60xYUYpsbyhyGfBLYKLf4EcC165c7s4Z9vbYqdEBCnKshhe
	j/LXFsMRnumhuRx6+Lc7AYJG6BEuDV4GMgMqpzeOE03mpHrOWAT0efWz5Xvg7Lod
	sb6aCL1AC6W0F6+It0TC2xfDBmIwYhIdHBwOtacKYanNzzrthqf5+Zq8Qtyf9pRW
	LyaeX1ZyQLdlQer3JnJTSr/YUWOC4daJmVwPUkO8n1JiTFC1Fnqi8dYvpXtu5qsB
	i/4nsIHsuSLGDBqV8AyQfj4eld6BYeq0D4A==
X-ME-Sender: <xms:v7KGalAFoctKZMsUTIKHI0WSZ9s8bd-ZDRrCVbLLAYDc3tUl9EyO_g>
    <xme:v7KGaq8a51XymMMzBQxR8TSrPGGLY-O_4jgkURnXd2R1qdGB7rirZs67X5he2C42o
    b6K1ruLFafjB-Z1VStRcmFsPDFVzC3W5ZCjHz06unKRzAqGaxx9dug>
X-ME-Received: <xmr:v7KGat-eMcVGvxe4KSkSEylCNIAiuR8GPix8nD2SdI_vtmzbxa9K3Ni7FB9pjkRKuM8DCd38p3pnA3MmFscCXNk1bZO4iZD8G2EuIJp1oA>
X-ME-Proxy-Cause: dmFkZTEq8OrU6lcOz4LWDmYcwOY4F4gSn2z0o9r9qZtiyKJiLit3WFarLCjXx/6BmL0Yur
    TFdO4M6CQ5SXX91HF/8U+ccNWgLUsS6Sgd7xQjLFh4GhY31c2HJNMxRyUtWBtx7RZXAIH5
    bmYNy6SL8iuOCI4TStNZURCxPhXKXgyLwq5X6Hx0fUo0llj+ikbXz2fT+DTlmB7CEio2om
    SpxKD0+buGffL1ipu/gxMY5w0YL2RSQB3GFBQoguukYOqvSnWzqqGPI+QdoAZpvZR07zAa
    v1txG095bVgNtf59i8YGVAUNbyP+1oZbnIL2XtmNL62ogvUX9IU/uJcqY9+Ig90Ke3Pykl
    R4z/SyEZCm+gTlCXfnvMcGXQIRVrlPE13eOETOwEkZlKrS5tMRkvGQTz5zrgxhwCjO7GMq
    rC9gJhxuS/YLRNYjVY4z4eTfvDt0CvlxeUAN0ch+NaxT27IJf4cBFUZ6URyxi52HUVQ5EJ
    TJYv0F6NBVYvjc9x70ZPT5j33S11zVKAk9zChloDcz/MaIUNcF28yFi/qN+CawbRWjJMEm
    bKFUq/LY4L7jvMMV0Xtj+a6YrQRRonAqcz4IPOo3SJtaTWLY2PEar0rLWMubUL7smOLE5C
    P0C3PPPDtsYlb4h2qRgaIXnuGZ+/i53vFKF72PLsK/40Kjt7YsnykjAjxhpg
X-ME-Proxy: <xmx:v7KGapeCO0tPp4B1F_EohykT95Kh93NyiDpzt_dlWVK1vubHCHBVDw>
    <xmx:v7KGauG_Pz8UoRoNmGojUuoSPWfBByimFOko7HkQdeNyUZl8bOegag>
    <xmx:v7KGavdZhkAxvY7KRv4DyXgGwj4H5-UY0p9meUmD9qyHGawBJ0gg4g>
    <xmx:v7KGagFCj73IhbLn8Srk6O8D0QhGHWr6Lu2Cm0kY7Z_gfkknOv-vzg>
    <xmx:v7KGaubFjPmZ7ckAr3Qc54M_tlzavn1Qh7U-LttxlfMPdoYph4DZ9bOP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 03:54:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57139364 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 07:54:36 +0000 (UTC)
Date: Thu, 20 Aug 2026 09:54:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] packfile: recover when a multi-pack-index names a
 removed pack
Message-ID: <aoayppoxHAkcFTBN@pks.im>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>

On Tue, Aug 18, 2026 at 10:34:06PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> When a geometric repack runs concurrently with other git processes, it
> can write a new pack and multi-pack-index and then delete older packs
> that the new one subsumes.  One or more of those older packs may have
> been indexed by the previous multi-pack-index.  A process that already
> had the previous multi-pack-index open keeps using it, and that stale
> index still records the removed pack(s) as owning some objects.
> 
> Because a multi-pack-index attributes each object to exactly one pack,
> an object that exists in multiple covered packs is served only through
> its recorded owner.  If that owner is the pack a concurrent repack just
> removed, find_pack_entry() cannot serve the object: fill_midx_entry()
> routes the lookup to the missing pack (prepare_midx_pack() fails), and
> the regular pack fallback deliberately skips every multi-pack-index
> covered pack.  The object is reported missing even though a perfectly
> good copy survives in another covered pack -- for example a large "base"
> pack that geometric repacking intentionally kept.

Okay. Rephrasing in my own words: the object in question exists in two
packs covered by the MIDX. We rewrite one of those two packs, and the
MIDX used to reference the object via the pack we're about to rewrite.
Consequently, the MIDX is stale now and it cannot be used to find the
object anymore because its pack has disappeared. And as we know to skip
searching packfiles for the object that are already covered by the MIDX
we won't be able to find it via the second packfile, either.

> The false negative is not limited to one caller.  Any reader
> (cat-file, rev-list, pack-objects, ...) can spuriously fail with
> "unable to read object", and callers that only ask whether an object
> exists get a wrong answer too, since the OBJECT_INFO_QUICK path never
> retries.  Writers that merge in-core, such as "git replay", are hit
> hardest: merge-ort treats the unreadable tree as a premature abort, sets
> result.clean < 0, and returns without a result tree.

Hm. Isn't there a slight variant of the race though for any caller that
does not use OBJECT_INFO_QUICK?

Namely, the packfile containing our object disappears and is being
written to a new packfile, and that file is the only one containing it.
Without OBJECT_INFO_QUICK we would be fine: we notice the object could
not be found, and then we perform a second read that makes the "packed"
backend reload its packfiles. It would find the new packfile, and
because it's not covered by its MIDX it would use it to surface the
object. But without OBJECT_INFO_QUICK that's not the case, as we would
skip reloading packfiles altogether, and hence we would not be able to
find that object at all.

As far as I can see though, we don't seem to pass OBJECT_INFO_QUICK in
any of the mentioned readers. I could very well be missing something
here, but I would have thought that those readers are fine in this
scenario?

> diff --git a/odb/source-packed.c b/odb/source-packed.c
> index 0890704e76..de96215069 100644
> --- a/odb/source-packed.c
> +++ b/odb/source-packed.c
> @@ -31,6 +31,35 @@ static int find_pack_entry(struct odb_source_packed *store,
>  		}
>  	}
>  
> +	/*
> +	 * Recovery for a concurrent-repack race: a MIDX can name an owning
> +	 * pack for an object that a simultaneous repack has since deleted,
> +	 * even though the object still exists in another pack the same MIDX
> +	 * covers (e.g. a kept base pack that geometric repack did not rewrite).
> +	 * If the object is present in a MIDX yet none of the paths above could
> +	 * serve it, its recorded owning pack has become unavailable.  The
> +	 * regular fallback above deliberately skips MIDX-covered packs, so
> +	 * scan this MIDX's packs directly to find the surviving copy.  The
> +	 * bsearch gate keeps genuine misses (objects absent from the MIDX) on
> +	 * the fast path.
> +	 */
> +	if (store->midx) {
> +		struct multi_pack_index *m = store->midx;
> +		uint32_t midx_pos, i;
> +
> +		if (bsearch_midx(oid, m, &midx_pos)) {

Okay. I was initially worried that we now unconditionally search through
all packfiles a second time, as that could have an impact on
performance. But we really only do this in case we have a MIDX and we
know that the MIDX _should_ have contained the object, but didn't yield
it.

> +			for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
> +				struct packed_git *p;
> +
> +				if (prepare_midx_pack(m, i))
> +					continue;
> +				p = nth_midxed_pack(m, i);
> +				if (p && packfile_fill_entry(p, oid, e))
> +					return 1;
> +			}

And here we now loop through all packs covered by the MIDX and manually
try to look up the object in those. Makes sense.

> +		}
> +	}

I was wondering whether a preferable fix would be to eagerly load
any packfile referenced by the MIDX when loading the MIDX itself. And if
that fails, we'd ignore the MIDX altogether. This would guarantee that
the MIDX remains valid, and we wouldn't have to worry about any
disappearing packfiles.

The downside is of course that we now eagerly open packfiles, and we
didn't have to do that before. So I think your fix is preferable, as we
can rather easily detect the case where the MIDX should've yielded the
object but didn't, and consequently the additional search only triggers
in very specific edge cases.

Overall I think this patch looks good to me. The one thing that I'm a
bit puzzled about is the above discussion around OBJECT_INFO_QUICK. I
feel like I'm missing something there.

Thanks!

Patrick
