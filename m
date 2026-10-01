Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555831A3160
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 03:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790824706; cv=none; b=dHcuo8ZYvallP58MeHErLAnt3v7xFscbWM8UD+wHgI4UATmnwMXG4qbPsWR4+wH5ycibTV2WiUM7kaJ3MigvMI4n/Y6b+z49C4GgDCJlB3CcWJPsQHuNYDhEb/ctqVSHlIdQxIUTwpkA9HQI2bGtyKiktibJzRiPvWCW9hh+jpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790824706; c=relaxed/simple;
	bh=jpgqO6HluS5N99PRZdtufehgqmLSxRJJiUtU75b7xkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUHESG29JhUWQ6muuf8UTZre+Ddpa2Y0soFyso5SambIQOgHv0RZFef5vdi8S0/VBN8xsc41wBwYo09VzEMX4Ki8CGRUvYAHL79hX2fg8i+W4lutBgOSP/H6IMNdeyDKcrffFkYEAB9tuoQuBOe/AEVjA348H2bHjtU5GXz/1KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=T7k77HwG; arc=none smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="T7k77HwG"
Received: by mail-oo2-f36.google.com with SMTP id 006d021491bc7-6dd0088ec00so420351eaf.2
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 20:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790824704; x=1791429504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DJsQhkmWBiTHCrA03YOqUgDv2G9NIATzPd0kL5VbJMw=;
        b=T7k77HwG7+EisoCaYngL0anCTyyZZ0NCWvAh+0FUJEZvPRFWft9e2xh0KInW5asEXy
         o2ZjcN6cV3iwml1k7jG2l6NPPAVJd4hnQO7vQQ5BYUkKM7prtPa0I0lGmJ7nprlAjntI
         Z6ot3J6dOVbetd13sLmonRu/KZahh1veDvNdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790824704; x=1791429504;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DJsQhkmWBiTHCrA03YOqUgDv2G9NIATzPd0kL5VbJMw=;
        b=0b0Pr5XeKUNAQhV8ymCX2N5e7Sf8KQ2Pvl/7mjU21LP8VIgS0XOypie4UKG7oryZf7
         Bm72Z6XMTN/INZWpMUxL+fEAK+na9Z+Wgaci6SkAtOefqAz91CrLMH95lCZhUakW+ppJ
         nOVJhXA2KD4b+BTVGZfeiifY8BTuId8IUieMEb2E1WgqbpHZoqboAmjnW+JaNST/cf75
         CIYlfmOCdHUcY7T7M2+Te1v2OcENpxSGFOEW+CpI6ZJPuQ8PgwMgrXWMGYAHrh5Zfhox
         k9HnZWHlCo5xC5DmtVX7TQHxh8sap2NG6ymsjEPHztL9zZldIYRp3B0jIQK0yEWZGHAe
         QCyA==
X-Gm-Message-State: AFuF++kwUIWA93bhsEPcbNP7ixt4Tn3KqD2dej95URpYVqV2nBZ4txcF
	6h0uebJllZ+O7KpIRiWCFb5Wss3Q6EdBPBFw//15xB61wxP0GOQhZtd9tfggI5yFEBs=
X-Gm-Gg: AYBFou08XVwZ4Y7ixsESjJxTsUHcjGOZfPwHbcOLR5qVyqbZPcqp9c/1fjPnw6fHT7x
	fcACW1WEEm5kzKBnP21Ka/tcU70JHhlF4HTPDt4jKg1X359VLISTe4obXgUwWjY2pZuimnmi/G+
	lGwbhbB22Y/ee1bFO2Z8vvrnIvNBZ48EeIBLxkw4ENb91wT2ZViHqsIhCliiwIaKhnhgrRSCFTO
	3GcxJO4puJvTBeqNKIzMYW2KuIKthMtqW7h3e4SQ9+Cswd7hPIadw33A7pYqWTTr96l21rq1Pyq
	eN0xFnq88ywRAQ5UIsLdF7kzk0uNOtNBuFyZ4g7Mwz6E1IhknXT9pbR/Gx2DUkUMp1O3vmiU4iu
	UTn7KLTQbbt3KLv73IUKtq38oq6XGxs9eFqHVU1W5TqJBzxrMaGry+FhOWeXOfqL1vbYw30Zu/1
	v5OWVggLAEQ2gHYB7J0Kw7TubLPvC520XHYhNLrp1ZIfsXIRekhVtu58VXt5O6PrDJf9KRqZzNF
	8obxa1iONSSQ3d0UCZl4VjiSj4p2vbquDXlNULB/bazEtVOt04DG1zFWQmkPpV0OX75hffuQKBR
	SJGt/D2D3Pkgbw==
X-Received: by 2002:a05:6820:188a:b0:6da:9dae:a22 with SMTP id 006d021491bc7-6dcf6022e84mr3492554eaf.62.1790824704073;
        Wed, 30 Sep 2026 20:18:24 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212b3410c3sm1847340a34.23.2026.09.30.20.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 20:18:23 -0700 (PDT)
Date: Wed, 30 Sep 2026 22:18:21 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH 2/4] pack-objects: ensure tree/tag closure with
 '--stdin-packs=follow'
Message-ID: <ar3Q_by48uOxBDB0@com-79390>
References: <cover.1790731662.git.me@ttaylorr.com>
 <6348667e2e3fe63aeb139888e877dd8447570253.1790731662.git.me@ttaylorr.com>
 <20260930203108.GA747209@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930203108.GA747209@coredump.intra.peff.net>

On Wed, Sep 30, 2026 at 04:31:08PM -0400, Jeff King wrote:
> On Tue, Sep 29, 2026 at 08:28:49PM -0500, Taylor Blau wrote:
>
> > In cd846bacc7d (pack-objects: introduce '--stdin-packs=follow',
> > 2025-06-23), this behavior changed such that whenever excluded-open
> > ('!') packs are present, the walk stops at objects in excluded-closed
> > ('^') packs. Geometric repacks use '^' for retained packs already in the
> > MIDX, relying on the indexed object set being closed under reachability.
> >
> > However, the walk introduced in cd846bacc7d starts only from commit
> > objects. A geometric repack can therefore produce a MIDX that does not
> > maintain reachability closure for lone trees (that are not reachable
> > from any commit otherwise in the closure).
> >
> > A later walk with '!' packs can stop at that tree in a retained '^'
> > pack even if a new commit reaches it. If the cruft pack remains
> > excluded, and the bitmap selection picks one or more commits which reach
> > that tree, the MIDX cannot generate a bitmap for that commit.
>
> OK. It took me a minute to grok this, and what I got hung up on is "a
> later walk". I thought you meant a later walk within the same process,
> but you mean "a subsequent repack / midx generation".
>
> So we fail to walk in an earlier repack, but we might not fail there
> because no bitmapped commit happens to require that closure. But we've
> set up a timebomb for that later repack, because our pack which is
> _supposed_ to be closed (and thus gets marked with "^") is broken.
>
> So this fixes the initial generation of that timebomb. It doesn't help
> us deal with existing bombs, but presumably the solution there is a full
> repack (and we would not want to deal with existing bombs, because the
> point of "^" is that we can trust it and avoid lots of extra traversal).
>
> Not really asking for a change to the commit message, but just
> documenting my understanding (which hopefully matches yours ;) ).

Yup, exactly. Hopefully s/walk/repack/ clarifies things for the
following round, but in the meantime your understanding matches my own.

When this feature was originally introduced, the idea was "anything
packed must also pack its reachability closure, less any objects in
excluded packs". That was true for commit objects, but not so for trees
and annotated tags, which is what this patch corrects.

> > @@ -3846,6 +3847,9 @@ static int add_object_entry_from_pack(const struct object_id *oid,
> >  		 * list after checking `want_object_in_pack()` below.
> >  		 */
> >  		add_pending_oid(ctx->revs, NULL, oid, 0);
> > +	} else if (ctx->mode == STDIN_PACKS_MODE_FOLLOW &&
> > +		   (type == OBJ_TREE || type == OBJ_TAG)) {
> > +		oid_array_append(&ctx->extra_roots, oid);
> >  	}
>
> And this is the interesting part. What about blobs? I guess we don't
> care about them because they are either there or not. There is no need
> to walk them independently because they can't reference anything.

Exactly.

> If I understand this subtree claim, you are worried about the
> (single-traversal) case that we manually queue tree A, and then later
> visit commit C, which eventually has A as a sub-tree. So we queue A
> again _after_ its original, but that second visit (that we skip) would
> have had more interesting information (like path context).
>
> But I don't think a second walk clears you of that possibility. You are
> queuing tags, too, which might in turn point to commits. So you might
> get the same commit traversal within that second walk.

Yeah, that's what I was worried about when I wrote this patch, but
that's a good point. Really there is no "absolute" correct path for a
given tree or tree entry, since it depends on your perspective.

> I think you could fix it by putting tags into the first walk. But it
> will always exist to some degree (you could have a tag that points to a
> tree and queue that tree, but also a commit that points to it).
>
> It's not clear to me how big a problem this is in practice. We know that
> the "path" of a tree or blob in a traversal is subject to context. There
> might be multiple commits that point to it at different levels. I guess
> it might be more common if we are adding random trees from a pack
> without context.

;-).

> So I dunno. I'd probably be OK proceeding with this as-is, because I
> fear that dual-queue thing I mentioned above might turn into a rabbit
> hole that would derail the much more important fix.

I tightened up the comment a bit, but I agree that rethinking the
traversal machinery is best left for another day.

Thanks,
Taylor
