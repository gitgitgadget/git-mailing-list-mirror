Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F8C32C8B
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781450563; cv=none; b=swHGAlvqdJ7MXdq3vZ6RMsOvFOUe4uZNl/4ZvD1bFt97GzDryCxUl5GuVIXPc1mxeajyE9kjmE5PTBj2AB6Tm3OFzkiTquH1gvgCtHdfl3r/B2lsKsMyA3lSKzjKoExXSzIqA31YD/z/zEW7KMuYbJXWyN8xqGd7UtlFVGNDkTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781450563; c=relaxed/simple;
	bh=El7WCeQhKoWuw8jTltJIrraPoURyBfqp5aOQhTf7Cl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FYy1SrS0pZppBKccDiaa7pVGeOWjcPTIkl3+/CpFc1yQb40SIOXV8liqSF83+StRtBYGz+iW39/4GQLGgcb9MDVvsBF3YGL4yrWn2vhJVfJ+j6dJJhaxyfygqM0S7IUg+Q6cTa9swEt/5sIUhziI/qzzRGE7oPWT/m3ahTIsRlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FCx+Pref; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X9TgD06a; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FCx+Pref";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X9TgD06a"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0122BEC0087;
	Sun, 14 Jun 2026 11:22:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 14 Jun 2026 11:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781450560; x=1781536960; bh=1Sqa8kqHZ8
	fBkYXhJRWrjP4zF6CBUrFc01ArrIlkRmw=; b=FCx+Pref0Rht5WVfjcP5xaeh0g
	DcF4gC5tlfIscK/PghMHUi8upw+70OAwxuBRYlR2+jyAcc0R2Hm4CJ9+IQZSNoD+
	22qBmbmy90MKqc10SHD/NYn9ohtND9EdSm4+Mwnx0q0SKUdKMV8Ub06p1nOofCUt
	GwadZQxkX0hvLJN1VsFYxXJ3GeraAdiAqg9BZTXEB0L6djn++PpqA3BO15HEhE/d
	7X/8LUsTr1v+/eVd1TACUHpIjkingOPmpTeroWZcdPjBQKcYXx504AWEnSUks1Pm
	Zph/3+x2upDpa5dloIJOGMY9wm8W/xCAldFIOOQYY/Lljnxuig3bUdybKjtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781450560; x=1781536960; bh=1Sqa8kqHZ8fBkYXhJRWrjP4zF6CBUrFc01A
	rrIlkRmw=; b=X9TgD06agWEb5HkeZUb9eFz8Oo3hd+NRpwYi7dYn/mTwJKW07Pr
	9vZY5rF285ArYoc3w2uuzB8M8jNPaxlwobg50p9delNtL8+tzqCHxtHjVMatLWOd
	6zx+L+e2BLLmkV/QNAoY5NLNZJtEEd/CRC+aACeOw7fLrUwdCeBZMxscXw5zd3t8
	BS0/tBUvl89FMVbrPBtoGevCdOVZpVmRyDNV56F2/YmRO8/sVb/xhLr0OfN1l1zs
	lsRPqEtzVXYA4h5EvmsJ+QsStx3f0Tk8SFVIr2EK7CMray26QHH97iDrUS01PDM8
	nhwFyCkTXJkZG98NG8WSU8JHTjPDBiiEnyw==
X-ME-Sender: <xms:QMcuag_DsJs_5K-0VdDO4WCxXR5VtXC7lizIPBS5T3M3zifXbzIApw>
    <xme:QMcuasbIx-Tv1ia_XZ41Ssts9h-aOVz9S1GjSMmuaHzafbgeCuJuKzTrc92buCDdy
    Gc5x3SB0mpQ1sVV5ocECy5pua60pJA09BCee9jBS65Z6tFcZTvP>
X-ME-Received: <xmr:QMcuav26vfo6QZq9gbSeSFtcW8neDVd7v-LqeImPH2ROKQAgSxDoOx2Dg1CIcjg-EPoug_u96IhgWSS_R_9CcyRefXh_WBSMdpVZ>
X-ME-Proxy-Cause: dmFkZTFSutKa68Pju9Nwg1C6FLOgk0d9pctINx+6RbTs/q2/z7ptuTPpqalyZ1X1EYvvAI
    teFVxxY9GLmBIZMK/5sk3jmiBSFyv5I9HxpWBUXd8Qpsamn+Zau67K6WorY9WhhMF2vLsS
    aW9aEuWO4LoRh9+wzuDjpJOyMTBNiyzahMma7CpTZvgGYE+K1kCL07Mmh9JahT9eCl2feP
    heCBwcs2fSBX2Bj5TN0Ais/+8/A69BVGqLGZeUukq+o9dzcM2a5foRLnmqjBdXCkUjVHrb
    wAlF0tcXjpZSWhvO8HmlgPslsQ9YvLmVDb+vZwth/PfC3krJ7Df68JOh4zM+Yr5ywBW+tB
    YerqFdMvCDO5JT5X5RoEXWusUgDkQWkyZFe6MbNTkPpZku6hBgoCSkKxKhJ2Mb1mvjFUwG
    WhJ3JIDBFoLlaeGNSRnJNlHwCSPL7bR0QrW2qJG/pxaPGGMTNWq+17WIpn2fnzTvjuYikr
    nsVvqw3b6RG8UxqRGkLDcLutNqSzswj8GN3w/u2WKnAxmJn81ML63iJwKszSfnFrgJ6tCC
    fAPyLBVB6Sk4B3O7lVcQezeqRKJoxM9htNh2KkgIP0MtB6XDyYBtosir2MzlKhbW0x9+wK
    XFc9ZUP5OZhnUP6BMPaaLhCvm8uTx0y6Eu+987EIKNJ/ENJ8Ksg+gyZmZPAQ
X-ME-Proxy: <xmx:QMcuanZb8ePdF8cw1DAr58gEnaq9oR0V3L5e_6wlmeqHdVlDqcSKnw>
    <xmx:QMcuanLELfFDpk4UGVQ1NX1isbHCTNG9ZhJYrNlZHB8Xhh9WIvErGA>
    <xmx:QMcuamEvQ1O8lZjACEnMcJIT760CUIZS8W1wJrHG5-wIdCNpyHMzXg>
    <xmx:QMcuauvIoKmemPqnDRHKfgIo2SoHLtDS_2ghCDeH5242w0lfQc8epg>
    <xmx:QMcuahirfI8qDj79sjdYsORt0dIocOXTDtNKFyEf9q6PmHwBi63iy_B2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Jun 2026 11:22:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <christian.couder@gmail.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 5/5] cache-tree: fix verify_cache() to catch
 non-adjacent D/F conflicts
In-Reply-To: <cf50f1aabcf84aa755808318756c233305cc008d.1781419047.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Sun, 14 Jun 2026
	06:37:26 +0000")
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
	<pull.2096.v2.git.1781419047.gitgitgadget@gmail.com>
	<cf50f1aabcf84aa755808318756c233305cc008d.1781419047.git.gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 08:22:38 -0700
Message-ID: <xmqq5x3ldu4h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/cache-tree.c b/cache-tree.c
> index 7881b42aa2..4d2669b312 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -161,6 +161,54 @@ void cache_tree_invalidate_path(struct index_state *istate, const char *path)
>  		istate->cache_changed |= CACHE_TREE_CHANGED;
>  }
>  
> +/*
> + * Check whether this_ce and the next entry in the index form a D/F
> + * conflict ("path" vs "path/file").  Returns the conflicting "path/..."
> + * name when one is found, or NULL otherwise.
> + *
> + * The cache is sorted, so "path/file" sorts after "path" and the
> + * conflict is usually visible as adjacent entries.  But other entries
> + * can sort between them -- e.g. "path-internal" sits between "path"
> + * and "path/file" because '-' (0x2D) precedes '/' (0x2F) -- so when
> + * the immediately following entry shares our prefix but starts with a
> + * character that sorts before '/', binary search for "path/" instead.
> + */
> +static const char *find_df_conflict(struct index_state *istate,
> +				    const struct cache_entry *this_ce,
> +				    const struct cache_entry *next_ce)
> +{
> +	const char *this_name = this_ce->name;
> +	const char *next_name = next_ce->name;
> +	int this_len = ce_namelen(this_ce);
> +	const struct cache_entry *other;
> +	struct strbuf probe = STRBUF_INIT;
> +	int pos;

> +	if (this_len >= ce_namelen(next_ce) ||
> +	    next_name[this_len] > '/' ||
> +	    strncmp(this_name, next_name, this_len))
> +		return NULL;

First we reject an abvious "cannot conflict" case. If the current
one is not strictly shorter than the next one, it cannot be an
overlapping with one of the leading directories in the next one and
the next one cannot be "hiding" an overlapping one in the "docs,
docs-i, docs/r" relationship described in the log message (where
next=="docs-i' hides the fact that this=="docs" conflicts with
"docs/r").  Of course, the current one cannot be such a confliciting
entry, if an earlier part of the next name does not entirely match
the current name.  In addition, if the byte after the matching
leading part in the next name is larger than '/', any entry that
comes later than the next name cannot have '/' at that byte position.

Makes sense.

> +	if (next_name[this_len] == '/')
> +		return next_name;

And if we see '/' there, we definitely have conflict right there.

So these trivial cases after us, we need to see if an entry that
comes after next has a name whose leading part is identical to this
name, plus '/'.  How would we compute it?

> +	strbuf_add(&probe, this_name, this_len);
> +	strbuf_addch(&probe, '/');
> +	pos = index_name_pos_sparse(istate, probe.buf, probe.len);
> +	strbuf_release(&probe);

We see where the first of such a name (i.e. this name followed by '/')
may appear.  Normal cache entries in the index would never have a
trailing slash in their names, so I expect that this would either
find an directory that is sparsed out and returns a non-negative
index into the .cache[] array, or a negative index that indicates
where a name like this + '/' + anything would appear.

> +
> +	if (pos < 0)
> +		pos = -pos - 1;

So in order to check both cases, we do the usual index flipping.  We
do not need to to treat "it exists---that's sparse dir" case and "it
is expanded and we are trying to find the first entry in that index"
case differently below, which simplifies things a bit.

> +	if (pos >= (int)istate->cache_nr)
> +		return NULL;

OK, such an entry whose name is this followed by '/' does not exist
so we are safe.

> +	other = istate->cache[pos];
> +	if (ce_namelen(other) > this_len &&
> +	    other->name[this_len] == '/' &&
> +	    !strncmp(this_name, other->name, this_len))
> +		return other->name;
> +	return NULL;

This looks very similar to the inverse of the earlier one but
slightly different.  It might be easier to spot where it differs, if
we flipped the polarity, like so, perhaps?

	other = istate->cache[pos];
	if (this_len >= ce_namelen(other) ||
	    other->name[this_len] != '/' ||
	    strncmp(this_name, other->name, this_len))
		return NULL;

	return other->name;

Or perhaps not.  I do not care very strongly, but I only spotted the
subtle difference while attempting to flip the polarity in my head,
so it might help ther readers the same way.  I dunno.

Thanks, looking very good.

