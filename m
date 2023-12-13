Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="UntDk3fL"
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15199EB
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 10:28:47 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-425e63955f6so12541171cf.3
        for <git@vger.kernel.org>; Wed, 13 Dec 2023 10:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702492126; x=1703096926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6A3lfTXf6MuVVCaHwEg0QBF927JGv9s+TNHqmcu24k=;
        b=UntDk3fLqkAVhdhWVN9b/iV1F2wiLy8NH2NdOsy456FL43U8723gVVACRdK4LmF1y6
         97zDz5Zg+xmpaP4pDWsmOCL/7Qm9GhXwuqRMn52Jn/BYlrVkQt4ObcCgkcuVYIWEQAha
         vO8ypucona4sXqJnb3KCpBQskP4+wNbhIN7sKgZqPjis8wByWeIm0DRkc/znyqXgVeDF
         HRTW5nxk5mXoyxs48aQEJ0GLlWoxD9MzkiBNq5y1A1C2ZnV9fvJrRIXPi0UJjKcn0GlA
         IS+7wZpJRwJPLpjWpx2w2/bKXIKomwNFb1oA096p633wDwX4VbLfUi0o+beYPvt84AWT
         iuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492126; x=1703096926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6A3lfTXf6MuVVCaHwEg0QBF927JGv9s+TNHqmcu24k=;
        b=ZTVgnjSrNkQZzYB5NdQ9fYstx7xqD8LPSSBL2LWPQsR3vC5d8dJqdifu36YzSc2+d7
         0UOchhnOni/580FAOa8Fmxz8ap7W4gEOCUAahW6eyOFu9tEOOH+xG5pGWrr49IReKfZL
         KrBR2MFXOxYRHLjjTagNhfc0k+359q7jy5ul4POupEDqIvesnDSkPqIPS7Ns5EZIkUrz
         NpUtW9jknQEuMqHit3cxKjLjqDzlE/R/I4lwGuAOBpfUGKT3CwHLxAzmsAz1Cf/ICp5E
         YeLnqTaBcqxZO2NXl6WX6ebC2n9Ge146iDeHY6AbWj8qWEaphT9vopWE0/fuW68Ny1so
         3iWA==
X-Gm-Message-State: AOJu0YyibAxWJFycZLwr1QPPtygLDOseTuMJxblXSRJtbaxAAOHTaCOc
	8dnPA9A5TZnF/nCDlVJodjlzEn13kJERT+/1ZwM=
X-Google-Smtp-Source: AGHT+IFY4Ixd3RMvaMafUzlUe6A35WEn/5K5VJDhv7OlgZzQZmdSAlH2EyHW79zy3vxxcTXKX3rR6Q==
X-Received: by 2002:ad4:4e14:0:b0:67a:a721:caef with SMTP id dl20-20020ad44e14000000b0067aa721caefmr9536831qvb.80.1702492126048;
        Wed, 13 Dec 2023 10:28:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cx7-20020a056214188700b0067eee467929sm1314300qvb.19.2023.12.13.10.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:28:45 -0800 (PST)
Date: Wed, 13 Dec 2023 13:28:44 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 05/24] midx: implement `DISP` chunk
Message-ID: <ZXn33HVBFqidAThn@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <c52d7e7b27a9add4f58b8334db4fe4498af1c90f.1701198172.git.me@ttaylorr.com>
 <xmqqjzpv4ecg.fsf@gitster.g>
 <ZW95WSErCXvkfrAG@nand.local>
 <xmqqlea4nofm.fsf@gitster.g>
 <ZXPRL5yCTQKr0k7e@nand.local>
 <20231212080332.GC1117953@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231212080332.GC1117953@coredump.intra.peff.net>

Hi Peff,

On Tue, Dec 12, 2023 at 03:03:32AM -0500, Jeff King wrote:
> [...]

Well this took me longer to respond to than I thought it would ;-).

> So it kind of seems to me that this would "just work" if
> try_partial_reuse() did something like for the midx case:
>
>   - convert offset of base object into an object id hash using the pack
>     revindex (similar to offset_to_pack_pos)
>
>   - look up the object id in the midx to get a pack/offset combo
>
>   - use the midx revindex to convert that into a bit position
>
>   - check if that bit is marked for verbatim reuse
>
> The assumption there is that in the second step, the midx has resolved
> duplicates by putting all of pack A before pack B, and so on, as above.
> It also assumes that we are trying verbatim reuse in the same order
> (though a different order would not produce wrong results, it would only
> result in less verbatim reuse).

After much thinking, I agree with your conclusion here. Which is great
news indeed, since it allows us to implement multi-pack reuse without
requiring that the candidate packs be disjoint with respect to their
objects.

Even though we have some protections in place for ensuring these packs'
disjointed-ness, I agree with Junio upthread that this is likely the
most fragile part of this series. That is, even though we check in
midx.c::get_sorted_entries() that the marked packs are disjoint, if we
miss something, the results would be rather bad. At best it would result
in sending a corrupt packfile to the client, and at worst it could
result in permanent data corruption if repacking a repository with
multi-pack reuse enabled.

> If we assume that any cross-pack deltas are a problem, we could always
> just skip them for verbatim reuse. That is, once we look up the object
> id in the midx, we can see if it's in the same pack we're currently
> processing. If not, we could punt and let the non-verbatim code paths
> handle it as usual.

Let me think aloud for a second, since it took me quite a lot of
thinking to fully wrap my head around this. Suppose we have two packs,
P1 and P2 where P1 has object A delta'd against B, and P2 has its own
copy of object B. If the MIDX chose the copy of B from P2, but also
decided to send P1 (which it chose from A), then if P1 is stored as an
OFS delta, we would be sending a corrupt packfile to the client.

I think there are a few things that we could reasonably do here:

  - Reject cross-pack deltas entirely (as you suggest). This is the
    easiest implementation choice in this already-complex series, and it
    doesn't paint us into a corner in the sense that we could relax
    these requirements in the future.

  - Turn any cross-pack deltas (which are stored as OFS_DELTAs) into
    REF_DELTAs. We already do this today when reusing an OFS_DELTA
    without `--delta-base-offset` enabled, so it's not a huge stretch to
    do the same for cross-pack deltas even when `--delta-base-offset` is
    enabled.

    This would work, but would obviously result in larger-than-necessary
    packs, as we in theory *could* represent these cross-pack deltas by
    patching an existing OFS_DELTA. But it's not clear how much that
    would matter in practice. I suspect it would have a lot to do with
    how you pack your repository in the first place.

  - Finally, we could patch OFS_DELTAs across packs in a similar fashion
    as we do today for OFS_DELTAs within a single pack on either side of
    a gap. This would result in the smallest packs of the three options
    here, but implementing this would be more involved.

    At minimum, you'd have to keep the reusable chunks list for all
    reused packs, not just the one we're currently processing. And you'd
    have to ensure that any bases which are a part of cross-pack deltas
    appear before the delta. I think this is possible to do, but would
    require assembling the reusable chunks list potentially in a
    different order than they appear in the source packs.

> And of course there's a bunch of hard work teaching all of those
> functions about midx's and multiple packs in the first place, but you
> already had to do all that in the latter part of your series, and it
> would still be applicable.

Yep, all of that is still a requirement here, and lives on in the
revised version of this series.

The naive implementation where we call try_partial_reuse() on every
object which is a candidate for reuse and check for cross-pack deltas
would work, but have poor performance. The reason is that we would be
doing a significant amount of cache-inefficient work to determine
whether or not the base for some delta/base-pair resides in the same
pack:

  - If you see a delta in some pack while processing a MIDX bitmap for
    reuse, you first have to figure out the location of its base in that
    same pack. (Note: this may or may not be the copy of the base object
    chosen by the MIDX).

  - To figure out whether or not the MIDX chose that copy, you would
    naively have to do something like:

      - Convert the base object's offset into a packfile position using
        the pack revindex.

      - Convert the base object's packfile position into an index
        position, which would then be used to obtain its OID.

      - Then binary search through the MIDX for that OID found in the
        previous step, filling out the MIDX entry for that object.

      - Toss out the cross-pack delta/base pair if the MIDX entry in the
        previous step indicates that the MIDX chose a copy of the base
        from a different pack than the one we're currently processing
        (i.e. where the delta resides).

That's rather inefficient. But, we can do better. Instead of going back
and forth through both the pack and MIDX's reverse index, we can simply
binary search in the MIDX's reverse index for the (pack_id, offset) pair
corresponding to the base.

If we find a match, then we know that the MIDX chose its copy of the
base object from the same pack, and we can reuse the delta/base-pair. If
we don't, then we know that the MIDX chose its copy of the base object
from a different pack, and we have to throw out the delta/base-pair.

This is a bit more involved than the naive implementation, but it's (a)
efficient, and (b) most of the code for it already exists in the form of
midx_to_pack_pos(), which implements a binary search over the MIDX
bitmap's pseudo-pack order.

With some light refactoring, we can repurpose this code to perform a
binary search for a given (pack, offset) pair instead of starting with a
MIDX lex position and converting it into the (pack, offset) pair. So
that works, and is what I've done in the revised version of this series.

There is one other snag, which is that we can no longer blindly reuse
whole-words from the reuse bitmap if we have non-disjoint packs. That
is, we can't do something like:

    while (pos < result->word_alloc && result->words[pos] == (eword_t)~0)
        pos++;

when processing anything but the first pack.

The reason is that we know the first pack has all duplicate object ties
broken in its favor, but we don't have the same guarantee for subsequent
packs. So we have to be more careful about which bits we reuse from
those subsequent packs, since we may inadvertently pick up a cross-pack
delta/base pair without inspecting it more closely.

As I mentioned, you can still perform this optimization over the first
pack, and I think that will be sufficient for most repositories. It's
not clear to me exactly how much this optimization is helping us in
contrast to all of the other work that pack-objects is doing, but that
is probably something worth measuring.

Thanks for the terrific suggestion. I'll clean up the results of trying
to implement it, and share it with the list soon (ideally before the end
of this week, after which I'm on vacation until the new year).

Thanks,
Taylor
