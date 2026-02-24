Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9860F1624C0
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 05:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771910760; cv=none; b=tgHnQndfnKoKfVLKtpgiYtaV4Qs3GQM8Auc79+h9/CdIV0X/UZfY8+FAEUX1qQkyNDC9MEgaeb0Vac5PWxHwkgdpdhPaq3LbwmIVwIV3VNdK9JsoYp8drxLSaV7/JNoPAjnfK7Gzs0fORQCabcCQ7CL/sb6GteovaraeI8xH2FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771910760; c=relaxed/simple;
	bh=DaoZxxxb+BrB0UueU2JBBNW4jDikCWJh2Wpi0TlfHN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9lJ/lmwi3cRqhLwAkxT3DgvSEu8bug6EFPrKPazUWKpkzGxlQcBk/I91Hi/pGVdSJATInNej9Vu+miDbT0SKb6nQmTC99yaSO/LtVaQO+eDfznx+we7syXlwiESM/MQMGMZUj5KbQRvl/dQQTMdkZfDxi1aZqXVUfbXa/Qfg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Qf+/A86D; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Qf+/A86D"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-79802e2c989so45822147b3.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 21:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771910757; x=1772515557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dKnx5YZyPRSqj53ONfZobFVNLKmvjdRc0lOyf9j/iY4=;
        b=Qf+/A86DCkrrw+93JJwimG2EoVyq9nPz1RXOjo8dgFxkHZMyB9Z9/PtxpP+e8KRl6y
         TZSgY2f1uXH1e/ILtJyqVCyMMnyzZ64wXQfvlzNneNKl1W/iacM1J2dEZG5V2KQOIdWe
         27QRzsOSJVtapzMhS/IKqPkxLjKyIl6zSGuibkqUNvUggl9eiZ+5lLZShr1nzfcPvCGQ
         bqctOcmyTmXsszEimRwnk+snPEQ2L3pa7Xrw7nkhMzzFZknl1AFBpVzO5YNMSdDefCq8
         7+ph/4ifKZCLbviYFhfkiaDnfL2VmZVIWEd69vb7TDrZq+opCeIUP2b7c2bgcKOlGRUd
         jDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771910757; x=1772515557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKnx5YZyPRSqj53ONfZobFVNLKmvjdRc0lOyf9j/iY4=;
        b=FoMuaGgZAU0m0ektFYzcxeDE6jEzg3Hj/O0jbnJ/Ju2Y3X4HDh/oJ01h11HITaIBrR
         mgVsCnPIv/n2RGLSSpQNCuguQsabTSoGu0DaxFnKAODtKDnfg1kh2PnsRPaGPPnExvWg
         6rRa7JlNcmT1MSIn5Pv7xqcxZh6qsqzGheNwYCytT9BYeNa15ymNPbqK4+fkRxKTWU4Y
         LPRAgsRBoRhqkzhuSjIbCcBuZ4u+z4YCUGZwsOY9pUv+RSWpRzdnokma0T98Sb0rdWJh
         fic1nrpzi1bJ5t/E5wQLTWxrFv2mAdwTCzrXLXd7foE0bMDaOAuvFhwLYRBXue2unlB7
         GSCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6nbCv3KKJZ5S9KEyeR/2d8BPfmP+inBrw3nQ+0g26FmaXnGIsg2SytE8JA3W8vdWowr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI6eKyoCdZ1i6jFas7C2XT/WgR6JWy1ow3oFQBfxezbNCVcidu
	YlZ3ZlE7TVayklhW7gjVe/ud6CaJI7aUNnYO57mWj3xRlm7nTcdFU2pMX8NlFQK51Qa6NAOQIOO
	4ztOefdszzuY9
X-Gm-Gg: ATEYQzwJ9UZHF/DQ5qG8jX0MF+z64aYKgHzU5gXLAfkoaRUM0FWSsmFFPYuYN+F7DrW
	FTueHyuJCf/MIO4UZs6iSylv73O2k6XVHRsWyLDQR4h13VssmYQkmggPGwVOqkaU6w37licbziE
	Ifd9cBPsQRL54Ylm8Y1BEyCtGzCrK4AtUsizXm/8EP0DtfxSMkF8Iyt5qehKJz029YbwLy5LK8c
	15xI46wsuvscThbcjO+RzCR8ToFBzqTLOJrTd68cjJ18z+1MDR9Z1SVR7aAiX1J4AK6YtSDFPQl
	ZyDQqLI39EP/IqjfNAZOqs7ZhTNupgOJ8JuhMPqbP6pZxSORqiXhELiN3sMfC7z54yVa9V8g8+W
	YbpV9aCsND/Sy/FopqUglOD0wlpkujXm3+IyshofyN3D390dkgYZG0LXpXtuYsntOw7zCQWJGkm
	+xFGvcGUQTA4u0opaVUcKK5LOSviWwp593mUA2tC0XOkzf0iVVvMKFzEiwdcIOtCycb82iqSCHR
	OEowmLT6Si+wKpuU0ONlxYgi19BzA==
X-Received: by 2002:a05:690c:dc9:b0:793:db81:f1dd with SMTP id 00721157ae682-79828ef10edmr99365037b3.4.1771910757504;
        Mon, 23 Feb 2026 21:25:57 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dbd9fa2sm40438577b3.18.2026.02.23.21.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 21:25:57 -0800 (PST)
Date: Tue, 24 Feb 2026 00:25:55 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 00/18] midx: incremental MIDX/bitmap layer compaction
Message-ID: <aZ02Y170p/yEjohh@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
 <xmqqbjhjvysm.fsf@gitster.g>
 <20260223140847.GB271392@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260223140847.GB271392@coredump.intra.peff.net>

On Mon, Feb 23, 2026 at 09:08:47AM -0500, Jeff King wrote:
> On Fri, Feb 20, 2026 at 02:24:25PM -0800, Junio C Hamano wrote:
>
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > [Note to the maintainer: this is based on 'master' with my
> > > 'tb/midx-write-corrupt-checksum-fix' merged in and should produce zero
> > > conflicts when applied on top.]
> > >
> > > This is a reroll of my series to implement MIDX layer compaction
> > > adjusted in response to reviewer feedback.
> >
> > Haven't seen a lot happen since the end of last month or so.
> > Anything left to do here?
>
> Sorry, I promised Taylor I would review it and I have been dragging my
> feet.
>
> I just read through the whole series, and didn't find anything that
> hadn't already been brought up. The scariest / most complicated bits
> are:
>
>   1. Dropping the sort-order requirement for midx pack lists in patch
>      10. But I think the approach with the version bump is the maximally
>      conservative one, and I feel good about that. IIRC we discussed
>      previously the possibility of using new chunks to give the
>      alternate ordering, but I think this keeps the complexity in the
>      code to a minimum.

Thanks, I think the "midx.version" approach is the one that I'm most
comfortable with too.

FWIW, I think that it's impossible to supplement the existing version
with an additional chunk to indicate the new ordering while maintaining
compatibility with out-of-tree MIDX readers. If others have thoughts on
how to do this, I'd be very curious to discuss it more, but I think what
we have in this series is likely the best we can do without breaking,
e.g., libgit2.

>   2. The actual compaction bits in the final two patches. I didn't see
>      anything wrong here, but this is exactly the kind of spot where I
>      think review fails, because you don't realize the corner case that
>      you missed (speaking from experience with midx and bitmap code).

Indeed.

>      But the nice thing here is that it should be quite unlikely to
>      cause a regression if you're not using compaction. As this is
>      mostly a building block for "part 3" that starts doing compaction
>      as part of a broader repacking strategy, I think it is OK to
>      consider it somewhat-experimental, build the next layer, and then
>      eventually let it see more exercise in a production environment.
>
>      That's how we've traditionally found those corner cases, and I
>      think trying to spend more time staring at it in review is not
>      likely to produce more insights.

As you note, compaction on its own is not all that interesting, since
users are unlikely to be managing their MIDX layers manually. Compaction
really is the final building block for the new repacking strategy, at
which point this code becomes a lot more accessible and therefore easy
to test and experiment with.

I'm going to deploy this slowly to GitHub's infrastructure in the coming
weeks[^1] and opting personal repositories into the new code to flush
out any bug(s).

As I find and fix those, I'll of course share the results here.

> There were a couple minor issues brought up in review, like out-dated
> comments and the u32_add interface. So I think we might need a v3 with a
> few touch-ups, but that's it.

Thanks. I have the following range-diff prepared locally, but after a
day of traveling I am too tired to confidently declare it free of any
typos/thinkos ;-).

--- 8< ---
 1:  2e549ea6443 =  1:  275960bf36f midx: mark `get_midx_checksum()` arguments as const
 2:  7255adafe70 =  2:  6b769517656 midx: rename `get_midx_checksum()` to `midx_get_checksum_hash()`
 3:  25b628fda97 =  3:  64a56ee1506 midx: introduce `midx_get_checksum_hex()`
 4:  2aedd72db8c =  4:  f6d3ecbb283 builtin/multi-pack-index.c: make '--progress' a common option
 5:  a00598a36a3 =  5:  7d9f5766cda git-multi-pack-index(1): remove non-existent incompatibility
 6:  92e6d868a45 =  6:  8ba8529fe32 git-multi-pack-index(1): align SYNOPSIS with 'git multi-pack-index -h'
 7:  ff599c11f68 =  7:  cd2b9f6f94f t/t5319-multi-pack-index.sh: fix copy-and-paste error in t5319.39
 8:  315a0ea2985 =  8:  983cff2f1b7 midx-write.c: don't use `pack_perm` when assigning `bitmap_pos`
 9:  af174e22e1e =  9:  5f03fda72ef midx-write.c: introduce `struct write_midx_opts`
10:  72bcd4ed6c7 ! 10:  9b02544b9ae midx: do not require packs to be sorted in lexicographic order
    @@ Documentation/gitformat-pack.adoc: HEADER:

      	1-byte version number:
     -	    Git only writes or recognizes version 1.
    -+	    Git only writes version 2, but recognizes versions 1 and 2.
    ++	    Git writes the version specified by the "midx.version"
    ++	    configuration option, which defaults to 2. It recognizes
    ++	    both versions 1 and 2.

      	1-byte Object Id Version
      	    We infer the length of object IDs (OIDs) from this value:
11:  c0c1769464b <  -:  ----------- git-compat-util.h: introduce `u32_add()`
12:  c11214a51f0 = 11:  06536b2081a midx-write.c: introduce `midx_pack_perm()` helper
13:  b9244a04297 = 12:  ee92de1795e midx-write.c: extract `fill_pack_from_midx()`
14:  c6f8d323477 = 13:  217cd5799a5 midx-write.c: enumerate `pack_int_id` values directly
15:  e71aa575463 = 14:  1193e9b3c49 midx-write.c: factor fanout layering from `compute_sorted_entries()`
16:  dbbcb494563 = 15:  73f2151609b t/helper/test-read-midx.c: plug memory leak when selecting layer
17:  13336e864f4 ! 16:  7344ce8e533 midx: implement MIDX compaction
    @@ Commit message
            `pack_int_id`'s (as opposed to the index at which each pack appears
            in `ctx.info`).

    +       Note that we cannot reuse `midx_fanout_add_midx_fanout()` directly
    +       here, as it unconditionally recurs through the `->base_midx`. Factor
    +       out a `_1()` variant that operates on a single layer, reimplement
    +       the existing function in terms of it, and use the new variant from
    +       `midx_fanout_add_compact()`.
    +
    +       Since we are sorting the list of objects ourselves, the order we add
    +       them in does not matter.
    +
          - When writing out the new 'multi-pack-index-chain' file, discard any
            layers in the compaction range, replacing them with the newly written
            layer, instead of keeping them and placing the new layer at the end
    @@ midx-write.c: struct write_midx_context {
      	return ctx->pack_perm[orig_pack_int_id];
      }

    +@@ midx-write.c: static void midx_fanout_sort(struct midx_fanout *fanout)
    + 	QSORT(fanout->entries, fanout->nr, midx_oid_compare);
    + }
    +
    +-static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
    +-					struct multi_pack_index *m,
    +-					uint32_t cur_fanout,
    +-					uint32_t preferred_pack)
    ++static void midx_fanout_add_midx_fanout_1(struct midx_fanout *fanout,
    ++					  struct multi_pack_index *m,
    ++					  uint32_t cur_fanout,
    ++					  uint32_t preferred_pack)
    + {
    + 	uint32_t start = m->num_objects_in_base, end;
    + 	uint32_t cur_object;
    +
    +-	if (m->base_midx)
    +-		midx_fanout_add_midx_fanout(fanout, m->base_midx, cur_fanout,
    +-					    preferred_pack);
    +-
    + 	if (cur_fanout)
    + 		start += ntohl(m->chunk_oid_fanout[cur_fanout - 1]);
    + 	end = m->num_objects_in_base + ntohl(m->chunk_oid_fanout[cur_fanout]);
    +@@ midx-write.c: static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
    + 	}
    + }
    +
    ++static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
    ++					struct multi_pack_index *m,
    ++					uint32_t cur_fanout,
    ++					uint32_t preferred_pack)
    ++{
    ++	if (m->base_midx)
    ++		midx_fanout_add_midx_fanout(fanout, m->base_midx, cur_fanout,
    ++					    preferred_pack);
    ++	midx_fanout_add_midx_fanout_1(fanout, m, cur_fanout, preferred_pack);
    ++}
    ++
    + static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout,
    + 					struct pack_info *info,
    + 					uint32_t cur_pack,
     @@ midx-write.c: static void midx_fanout_add(struct midx_fanout *fanout,
      					    cur_fanout);
      }
    @@ midx-write.c: static void midx_fanout_add(struct midx_fanout *fanout,
     +	ASSERT(ctx->compact);
     +
     +	while (m && m != ctx->compact_from->base_midx) {
    -+		midx_fanout_add_midx_fanout(fanout, m, cur_fanout,
    -+					    NO_PREFERRED_PACK);
    ++		midx_fanout_add_midx_fanout_1(fanout, m, cur_fanout,
    ++					      NO_PREFERRED_PACK);
     +		m = m->base_midx;
     +	}
     +}
    @@ midx-write.c: static int fill_packs_from_midx(struct write_midx_context *ctx)
     +
     +	ASSERT(from && to);
     +
    -+	nr = u32_add(to->num_packs, to->num_packs_in_base);
    ++	if (unsigned_add_overflows(to->num_packs, to->num_packs_in_base))
    ++		die(_("too many packs, unable to compact"));
    ++
    ++	nr = to->num_packs + to->num_packs_in_base;
     +	if (nr < from->num_packs_in_base)
     +		BUG("unexpected number of packs in base during compaction: "
     +		    "%"PRIu32" < %"PRIu32, nr, from->num_packs_in_base);
18:  b599f1ad4b0 = 17:  b9c1b3992c5 midx: enable reachability bitmaps during MIDX compaction
--- >8 ---

Thanks,
Taylor

[^1]: Worth noting that I am at an offsite for work this week, and then
  taking a planned vacation for the following two, so I may be a little
  less available than usual.
