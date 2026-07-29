Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87ED3B38AB
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352693; cv=none; b=sw45gDQupakkU7B3kJx9lb2yPredD6RfQSKWpMv/zd8sPsjbg14hD6y/Ipgaq5EPiKqtWz39uTZt6iYkFoF/ZmLiCCiOBlUmi3L7Gf78lKbw580mxqFmj7TRtuC4lYehStFmBMSRbepHjOyJxlIJQw+dP878wfAcwk04wPdjvkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352693; c=relaxed/simple;
	bh=9QyNiwQ/fo7j5iV5hzCXpPQv/tPWPDVdBJmVe5AYpBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGuDlSHFm/vbJGDc0PxE4fD+Wc3qCYJ84bgiL167JFiM+zVicr5boxERBkEKwCVjXYeSAJ50GAJyRysK/JH0Lgxco7t2YbwTe5gPFO/+JGxfvTcKbsTHJ3c3HKU0mwaR1GW9uXSEYx9uKIibw8XOmcPRSIkCpCB/rg3cOx61hyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=XiQmkKC6; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="XiQmkKC6"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81e83f1f15aso521217b3.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 12:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785352688; x=1785957488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9m+bphWpHF6cee6cg5z9RMQvUlzGiZpsASR2qRhGttg=;
        b=XiQmkKC6CgnJPmiv2YpSxg0hPpDz4/+sOQXeuYpMELZ/kBRzfRuE58nDNg79njr0vC
         WUDSIkP7zwzrS1p21ixbGTaaBKe5dJmsA1QF7nEqOxb4phdOWdz5BGf/psqr53jvnh7S
         Dcunn/qh1JbOygDvpUE/UfyeduShqpg1WkjEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785352688; x=1785957488;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9m+bphWpHF6cee6cg5z9RMQvUlzGiZpsASR2qRhGttg=;
        b=NIC27N4KqxpIFs3xsY52Iy4gOSBE7JPuZ+HGSKBR787mZSkTHbr0xqqNf36KmMx+ac
         nhzWe/NCjDyHxgyw57eazveWMxP/acW45W3Wfkdi5N6xl0YRHg9STu3r+F32kGL3nFXA
         eHHOzGrmH9RfkoFw+HaB+RqdZ4YVLwwGd1QKgyuWm/gkwINDvM/G1wQY2MHp7wEQfvB3
         OOxRYNcei7pI2/diI94BY9nNz0tPng+RV1ux+ZdM1s8bOH3BPwP/8lEFH8ekCbyeZ9FC
         l24FG3A11xhfHeG9X+qKp0Pl8bHMNGRCQHp0xrP+N0/BOSJhwvQvpNoWN4isP2dhWfzN
         ZpLw==
X-Forwarded-Encrypted: i=1; AHgh+RqEIs7vhbR/7ATpG9rUFSiUWCIED682QltC43W6Q+OR+mRmsuOGI4VuTXetPoFjb+DKRoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YypAC5ll9cOoqOMCpDkOXum/66FTx3J7wjS4guOiH73b7P44SeD
	f3bHuLe7/TTwPmzV72fJximJuBaUK3DPm5HwkDqL40mUZ5WswevsYfGCqUPGsuq0GY2bLhZtis1
	bJ4EHbvE=
X-Gm-Gg: AR+sD13PhPV6ZZv1Bw/NuvRm5wKqIzNUzm11vapTKuvehNWn9hjJv6Ea55ilexB88JW
	FCBBg/4yUIkWnM0UZT2xG70+/qtaVOyhe3G5jxsevSnHvdwW010ymYmnaiOfPnvr36FTJI+88Ql
	f6L+H7MJoTNidtgGai6fW37lXRsFbZVk4NUSW5+q/22UqKNN49OcHdYds8KYnBXhGizf1Pchyyo
	Tzq7FucVkGcEMAaHkJt5/5/GbrtU+3Qxp0mMLxWEVmQM1YeXp0U93nTDuFxis98fzTl1Ao8wvLN
	adzQpXGhA1STXKZIwWR/8c7SE6Ko6aUQQsT7tJHJwWHosgr6wlk1EdJ526bvoaPlEZoJ0yxGbJh
	qvnfHkS6n/N/g5pfkXHM2RYd+EUSjjidV/PNvFcJfqKWIqkzVUAk2wkxtfxjEV4bJcrgvQqRjc+
	6uFJLDpxMGNYGvfRuElHPuJ2mXmJYxalfuNjwnEl/Kf95NUGbVgW9JQTYUbQQc9/4Nmm8XiqGSy
	qaufVNW8XCF2lgSeHYsuE+mvmjNbP+fo3QwCj1+OSC+Ag==
X-Received: by 2002:a05:690c:6d82:b0:81e:429f:24ba with SMTP id 00721157ae682-81fa7acbf45mr20942117b3.36.1785352688118;
        Wed, 29 Jul 2026 12:18:08 -0700 (PDT)
Received: from com-79390 ([20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa292939esm23113287b3.25.2026.07.29.12.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:18:07 -0700 (PDT)
Date: Wed, 29 Jul 2026 14:18:04 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: friel@openai.com, git@vger.kernel.org, peff@peff.net, stolee@gmail.com,
	me@ttaylorr.com, ps@pks.im, jonathantanmy@fastmail.com
Subject: Re: [RFC PATCH] index-pack: optionally allow duplicate objects
Message-ID: <ampR7FkErK3CQPyC@com-79390>
References: <20260728042550.91133-2-friel@openai.com>
 <xmqqik5ybmi9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqik5ybmi9.fsf@gitster.g>

On Tue, Jul 28, 2026 at 06:41:34PM -0700, Junio C Hamano wrote:
> friel@openai.com writes:
>
> > Signed-off-by: Friel <friel@openai.com>
> > ---
> > Applies on top of tb/pack-with-duplicates.
>
> I am really reluctant to take us in this direction.  The last time I
> had a deep discussion on this was with Shawn Pearce (so those who
> knew him can tell how long ago that was), and the essence of his
> suggestion was that allowing malformed or invalid packfiles is a
> slippery slope.  They complicate everything, from delta cycle
> detection to ensuring that repository data stays healthy.

I share the concern, but I am not sure to what extent historical
discussions should decide our stance on whether or not we want to
provide support for packs containing duplicate objects.

A lot of this discussion pre-dates my involvement with the project, but
the closest thread I could find on the topic with Shawn was from back in
[1]. AFAICT the main concern at the time was that binary searching the
pack would not handle duplicates well.

Your comment here around delta cycle detection is something that came up
in the series I wrote (upon which this patch is based) trying to harden
Git's handling of packs containing duplicate objects. The main thing I
found when writing that series that Git did *not* already handle well
was navigating cycles during delta resolution, in particular with
REF_DELTAs. One of the patches in that series teaches Git how to handle
this case in a way that (a) doesn't adversely impact the performance of
delta resolution in packs that do *not* contain duplicates, and (b) is
not especially complex.

My sense is that many of the things the project was concerned with at
the time have since been hardened, and that Git is more well-equipped to
deal with duplicate object-containing packs than we may give it credit
for.

A couple of thoughts on why I think this direction is useful:

 - I think that Peff makes a good point in [2], which effectively boils
   down to, "OK, maybe these packs are buggy, but if they contain the
   sole copy of an object we care about, we must be able to read them."
   As I understand it, that is effectively why we disambiguate between
   "index-pack" and "index-pack --strict".

   I think a version of this patch that carves out duplicates as OK even
   in "--strict" mode results in better behavior for packs that contain
   duplicate objects (whereas before we had to drop all of the
   additional checks that "--strict" requires in order to index such a
   pack).

 - There are genuinely useful scenarios by which a sender may wish to
   consolidate two or more packs together by appending (as opposed to
   repacking) them, in a way that is extremely cheap to do.

   Friel may have a better example here, but a useful mental model for
   me has been: if an upload-pack implementation knows that it can serve
   a request by sending the objects from some known subset of all packs,
   it may make sense to simply combine those packs by appending them
   rather than generating a new pack with the union of their objects.

   That trade-off is useful IMHO for serving fetches and clones for very
   large and fast-moving repositories where repacking may not always be
   able to keep up.

I am not proposing that we make packs containing duplicate objects the
norm. But mine and Friel's approach here is to first demonstrate (via
'tb/pack-with-duplicates') that Git has good handling for packs
containing duplicate objects, and subsequently (via this patch) to make
it possible to index such packs.

If we can find useful ways to combine the ideas above with Git's in-tree
implementation of upload-pack, one could imagine that Git itself may
eventually send packs containing duplicate copies of some object(s)
behind a capability. In other words, for clients that know how to
process such a pack, the server may wish to ask the client to do just
that in the name of saving some CPU cycles necessary to generate a pack
that doesn't have any duplicate objects.

> Changes that help us detect such a broken pack as early as possible
> and prevent it from entering your repository are very much welcome.
> Changes that accept such a broken pack as if nothing were wrong, not
> so much.

I agree that the RFC as written makes the exception look broader than it
should.

A reroll should make `--allow-duplicate-objects` carve out only the
duplicate-OID part of `--strict`, rather than make the two options
incompatible. `index-pack` should still recompute every object ID,
resolve every delta, perform the usual object and link checks, and check
connectivity when requested. Only `WRITE_IDX_STRICT`'s requirement that
each OID have one physical entry would be relaxed. The default should,
IMHO, remain that we reject such packs.

But I would note that having packs containing duplicate objects is not a
new repository state for Git. Non-strict `index-pack` accepts duplicate
entries today, and shallow and filtered clones can store the same pack.
My series in 'tb/pack-with-duplicates' attempts to fix the known-broken
assumptions in reverse indexes, delta resolution, MIDX verification, and
bitmap reuse because those packs can already exist.

If duplicate entries are to be forbidden entirely in order for a pack to
be considered valid, then I think we should reject them in every
`index-pack` mode, including the shallow and filtered clone paths, and
diagnose existing packs in `fsck`. Otherwise, a default-off opt-in for a
known producer is a cleaner way IMHO to express that duplicate objects
are OK, rather than relying on whether or not we performed a
shallow/partial clone (and thus did not invoke index-pack with
"--strict").

I think that narrower version is worth pursuing.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/CAJo=hJs3mM7=LcOop-WD=bipA=Wx-7MDh6ObQwFUE38tjurvcw@mail.gmail.com/
[2]: https://lore.kernel.org/git/20140830131649.GA26833@peff.net/
