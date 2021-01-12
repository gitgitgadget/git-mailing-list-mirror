Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEB8C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C09E22CAD
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392750AbhALQcd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 11:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392676AbhALQcd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 11:32:33 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CE3C061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:31:52 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id e15so1908492qte.9
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a+xP+vdn1foEzCuQy/7DNWJwYyto77FaAwIxyNwWx8c=;
        b=ef5jmPKqSrwHpVA/qgfpHkkwuNhCUdrudtP3VWNydchkxpXjN1F5pkQk+FjTFSiA8L
         Ovv5WKPs/n4NJd+DDq+JK1IIL7GI3s1sA3H3rjiR0UVXMqJlYsfWrAdoiSNtbxWKRLEK
         Ed4+ZyYwgG60gCSU9iLP7H99/sVVAMwUV87UELAV61a0/NiXKNqQdnZDEvVejNHA3BEW
         tB2+PTJjCXJvLbw+/U3C2Kx1tNJxnN97YN4d9uGRifJ5kDx+OVNnkxYb5MYaVhdDjt8D
         co/JuUG0o+zTWFruGw19Kx1JzkSf6zFcqPoH3s7QjHTUb92Ri5pBr/dYl3s1AdVOw/v8
         iWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a+xP+vdn1foEzCuQy/7DNWJwYyto77FaAwIxyNwWx8c=;
        b=f07dzjnAWF90UUE43Qx7kuj6NO/iMjsiIkaaQjjiVZj0WZZuOp64XOZ5/5EyMbY3WL
         b6vG/XmZ7FhuSXLLU99Wha0cepVYGDHUTMeX7XgeRrpORhSHvcYjbp9YQkC6xiEjle/x
         6otROX3stsa0DU9GFE4Bk/niSrHNE9jsShJPHjki4i5XHJX4+gHj51Xa8cODoGds6kbV
         Hud9SvW1rZG5TXAtjelhL2zTtA6c6vh66pO0zn04ohIUZ26FqEcpp3T9JZKIXyP41qCO
         uuIUdRcnyGRCKBp73XVtOg94GIRgl6PNGOFIk98AWnoMtMsyOeAOkOLMhLxeA29BNd7F
         ZdLg==
X-Gm-Message-State: AOAM5326NCo4pOc7/1Q2pdyyJUHfRDKCoo5lapvX2m0A/s2SlQD+M/0U
        /CeT1YxmRjBpAIMuYR5tqvlenw==
X-Google-Smtp-Source: ABdhPJzL4GYbaSx5fYj0rr94+5jOKbej/DzVde5B0WxqiSfo0D1rj33IMVYHEi8gEi6Uzcv+Q097ww==
X-Received: by 2002:ac8:7a65:: with SMTP id w5mr5388516qtt.9.1610469111236;
        Tue, 12 Jan 2021 08:31:51 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:42e2:d139:3745:d47])
        by smtp.gmail.com with ESMTPSA id x47sm1318148qtb.86.2021.01.12.08.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 08:31:50 -0800 (PST)
Date:   Tue, 12 Jan 2021 11:31:40 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH 02/20] write_reuse_object(): convert to new revindex API
Message-ID: <X/3O7D18gRLfSNJ8@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <00668523e1cd860f6de08dd7c5a2a54edc08b7b6.1610129796.git.me@ttaylorr.com>
 <X/1iM0p5d8Zj8ucS@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/1iM0p5d8Zj8ucS@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 03:47:47AM -0500, Jeff King wrote:
> > @@ -436,10 +436,13 @@ static off_t write_reuse_object(struct hashfile *f, struct object_entry *entry,
> >  					      type, entry_size);
> >
> >  	offset = entry->in_pack_offset;
> > -	revidx = find_pack_revindex(p, offset);
> > -	datalen = revidx[1].offset - offset;
> > +	if (offset_to_pack_pos(p, offset, &pos) < 0)
> > +		die(_("write_reuse_object: could not locate %s"),
> > +		    oid_to_hex(&entry->idx.oid));
>
> If we believe the offset is bogus, should we print that in the error
> message, too? Something like:
>
>   die("could not locate %s, expected at offset %"PRIuMAX" in pack %s",
>       oid_to_hex(&entry->idx.oid), (uintmax_t)offset, p->pack_name);

Good idea, thanks.

> > +	datalen = pack_pos_to_offset(p, pos + 1) - offset;
>
> This "pos + 1" means we may be looking one past the end of the array.
> That's OK (at least for now), because our revindex always puts in an
> extra dummy value exactly for computing these kinds of byte-distances.
> That might be worth documenting in the API header.

Yeah, I made sure to document that when I was touching up the last
patch. FWIW, that's a behavior that we're going to carry over even when
the reverse index is stored on-disk (not by writing four extra bytes
into the .rev file, but by handling queries for pos == p->num_objects
separately.)

> -Peff

Thanks,
Taylor
