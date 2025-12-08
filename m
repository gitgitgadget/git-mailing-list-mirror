Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CAC269D18
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218397; cv=none; b=SsRLktEVhjM0ffYbVGYiiVc7yPCMVXOyMSPH9X6Zms9JLZ/ThYxrFGsiF7G4Ig4GvjbJooPmdq1W2sXn2PI0yK8aJs2uxvWQLJBq6nbCBbeJkzCkv25jx64cjVukiX7Nb+gH30/tDj1NM514KXtr6f/6Pn2AuXZWgee/KTwc6go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218397; c=relaxed/simple;
	bh=qrsREevb2xyZaeH56+HtP9owl6TLaIFa2QBUgGLv9K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXD1c/XrP1WDAIkgFlXnDGt1d0q2Md8ZGUhpOcdDwI0PAdVf734cOuxWX8d3WOHKnYuTSbgQYEcBY5Nx0oGQlnPhrTedMcg8ll8hbhMPRmJBS885Yf+50z5MKRNY0LiSyhK5eELIeEZBxtDyTJbDoNHQEmd6pSmFn6SQ7vJULwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sFLQ8CA+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=soisV5Gb; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sFLQ8CA+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="soisV5Gb"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5C546EC056D;
	Mon,  8 Dec 2025 13:26:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 08 Dec 2025 13:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765218394; x=1765304794; bh=zrTfR8oD69
	4K4wphITzHgsPa+kq86cUmpirL8JyvjWI=; b=sFLQ8CA+VMhutRZRpaYRddYAui
	qrbC691LXH4a54jbNlgb4XsC+XaMYbAMBuvrOIVgPfAJQd0e16MEwvLalVRocmI4
	iMLiC/7pie7tM+IUgjQCy2MdeNnkXWcoQijmwJ/h9wGWf+NoUiCcthVZWnD8gamo
	AxddnMcYeNWx8cKxK8UqLOEmOuxOSqY0VGc2vZE4ccmLGcgI0qzgw7KXUISypQhY
	wCF77fthrOuvuqoAk9WPBp9MqtnM3n6t5pt7jidDs7+duP4nyigkI8TYjEpK93x9
	dMnbMpMSgrt/dMZRdQM1aPTOUXK+SOR+ZeDNq5Pscr5Tjb75thsjHPOwNd0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765218394; x=1765304794; bh=zrTfR8oD694K4wphITzHgsPa+kq86cUmpir
	L8JyvjWI=; b=soisV5Gb8GpAyZz5RogQ/yfdBcxfEX+LrPW9utNQykZhLo4ZGY5
	wRGOpoWas8IEkLdlzl4kwL+i4tZIVNyQ3laNXqIZByJMcLQAgokpaTTOc6dXN8pA
	vSl/LBck3e9t6MoWq5tgr4Gksb9a9xa+GmlFVo/ymnh0JCh+jQcr9+NIQMg7DwRG
	mUYgn0EoPZ5PkJVm+MAa2s1XI0UaGI+U1gyEmCSgxRldyoGY+1FuweSill7dVkQw
	xK75abx/ax1D3cOV4D9QIG8S4fkA6c4nkMATuBmvzBE0jCQ2xfgsn89nnZ59/95O
	suFmmnsMph2Sv37IQ1Amk6LQlBCPdT190Yg==
X-ME-Sender: <xms:Whg3acmlnrlOUIKKMeWdHHQd7nGdbtK9PZw8s9Ao_Y9tWt4pO_yoHg>
    <xme:Whg3aSsT-M_gVy7e3I59wXO0mf1HHx5BGnif-tHDnbf8O3v1evMs43CYiYagVK5-Q
    p2BN-61BtsxlF4XncyALxwt6ZEhvWtRZvEdTf5D7hdIwWkZeMWisg>
X-ME-Received: <xmr:Whg3aS9ejwYzNZ1sVQaMBuxmCljwD1i5StZWXszq_7TwEfNa8FoP-kya251Vyikz6N9yPY5ZOCsQX3RMSOOzRci4F6BibIceZYIIuGM2LWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:Whg3aUN-nrRubMpZtJBgPkkPOO7y-fsJ2doeCBbCHjX7_KoPbxp8Gw>
    <xmx:Whg3aYGxxQGMCasK5AW_c0gYZ0GdsNM3V4I8ghpkTJtDTWBMl5SOBA>
    <xmx:Whg3aaTTjuPbUrYSFKUoe73GodaMW2nh7jCWuTwYD1BLoHv08r-nSw>
    <xmx:Whg3adu8Xt-oEHlSZtQ2Ju_qTWJ-tscgRmw5dMYSsnNqQtFYX5mFkg>
    <xmx:Whg3aQvKsBcaOfw6BhxLjLvRBVM8rgo6UVohZNDyVqYzG4dRCIZyMPqo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 13:26:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eb12aeae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Dec 2025 18:26:32 +0000 (UTC)
Date: Mon, 8 Dec 2025 19:26:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/17] midx-write.c: don't use `pack_perm` when assigning
 `bitmap_pos`
Message-ID: <aTcYU_yVYyXL9TXv@pks.im>
References: <cover.1765053054.git.me@ttaylorr.com>
 <1fc359d9a98cdd61f6986fa1d9a1190f57dacb9b.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fc359d9a98cdd61f6986fa1d9a1190f57dacb9b.1765053054.git.me@ttaylorr.com>

On Sat, Dec 06, 2025 at 03:31:19PM -0500, Taylor Blau wrote:
> In midx_pack_order(), we compute for each bitampped pack the first bit

s/bitampped/bitmapped/

> to correspond to an object in that pack, along with how many bits were
> assigned to object(s) in that pack.
> 
> Initially, each bitmap_nr value is set to zero, and each bitmap_pos

I assume `bitmap_nr` is the number of bits, whereas `bitmap_pos` is the
position of the first bit?

> value is set to the sentinel BITMAP_POS_UNKNOWN. This is done to ensure
> that there are no packs who have an unknown bit position but a somehow
> non-zero number of objects (cf. `write_midx_bitmapped_packs()` in
> midx-write.c).
> 
> Once the pack order is fully determined, midx_pack_order() sets the
> bitmap_pos field for any bitmapped packs to zero if they are still
> listed as BITMAP_POS_UNKNOWN.

If so, it feels somewhat weird that we'd set the `bitmap_pos` to zero.
But I guess it doesn't matter anyway, as I assume that the `bitmap_nr`
would be zero anyway?

Anyway, reading on.

> However, we enumerate the bitmapped packs in order of `ctx->pack_perm`.

Which is the "permutation between pack-int-ids from the previous
multi-pack-index to the new one we are writing"'. So it's basically
tracking which new packs correspond to the old packs.

> This is fine for existing cases, since the only time the
> `ctx->pack_perm` array holds a value outside of the addressable range of
> `ctx->info` is when there are expired packs, which only occurs via 'git
> multi-pack-index expire', which does not support writing MIDX bitmaps.
> As a result, the range of ctx->pack_perm covers all values in [0,
> `ctx->nr`), so enumerating in this order isn't an issue.
> 
> A future change necessary for compaction will complicate this further by
> introducing a wrapper around the `ctx->pack_perm` array, which turns the
> given `pack_int_id` into one that is relative to the lower end of the
> compaction range. As a result, indexing into `ctx->pack_perm` through
> this helper, say, with "0" will produce a crash when the lower end of
> the compaction range has >0 pack(s) in its base layer, since the
> subtraction will wrap around the 32-bit unsigned range, resulting in an
> uninitialized read.
> 
> But the process is completely unnecessary in the first place: we are
> enumerating all values of `ctx->info`, and there is no reason to process
> them in a different order than they appear in memory. Index `ctx->info`
> directly to reflect that.

Fair. We do initialize the permutations like this:

	ALLOC_ARRAY(ctx.pack_perm, ctx.nr);
	for (size_t i = 0; i < ctx.nr; i++) {
		if (ctx.info[i].expired) {
			dropped_packs++;
			ctx.pack_perm[ctx.info[i].orig_pack_int_id] = PACK_EXPIRED;
		} else {
			ctx.pack_perm[ctx.info[i].orig_pack_int_id] = i - dropped_packs;
		}
	}

So obviously, the permutation will only ever be different in case we've
got at least one dropped pack, and that only happens when we expire any
packs. So the explanation matches.

Of course it may be a bit more fragile now if we ever added a caller
of this function that _does_ expire data. But we don't have any, so that
enters the territory of overthinking things.

> diff --git a/midx-write.c b/midx-write.c
> index 73d24fabbc6..c30f6a70d37 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -637,7 +637,7 @@ static uint32_t *midx_pack_order(struct write_midx_context *ctx)
>  		pack_order[i] = data[i].nr;
>  	}
>  	for (i = 0; i < ctx->nr; i++) {
> -		struct pack_info *pack = &ctx->info[ctx->pack_perm[i]];
> +		struct pack_info *pack = &ctx->info[i];
>  		if (pack->bitmap_pos == BITMAP_POS_UNKNOWN)
>  			pack->bitmap_pos = 0;
>  	}

The change looks simple enough.

Patrick
