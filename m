Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87294C77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 09:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjDLJ47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 05:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDLJ45 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 05:56:57 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09B2728A
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 02:56:53 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i20so14740325ybg.10
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 02:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681293412; x=1683885412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRWKy4ea2/o0Lhl8h2lRKkYgfshp2v+l2+IQs8qLJYU=;
        b=poxubYJvRhwPyNNCwS+H3M6s80yMTRw6AyPf70Yw8P41bgDDl2PLb/pRiaDyzoiQUl
         bXzNEmwnhdh4FBuVqXE8d7a29/Fe4thE6q4avG0eZULO0tnux2ckqbXMYOFsaLaoQf+3
         aTW1EvQa2ocNVelRtJdUU+0He7q4iqhxZRfUdq5JTPZg8Ap23S+7pPYzNPY9tGzjCy11
         nbHxWbE/a4NHILwym96X8BTf8R6vNEREmOQLG/qxDedk60+sRnlKRLrziS2gotrO9PaY
         tcVzKaBX/C5RaJreUxxQCbcfori3TaBOLyc02YEL9l4lDRzkrMv4f+G7P+QYL4KISaE4
         A/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681293412; x=1683885412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRWKy4ea2/o0Lhl8h2lRKkYgfshp2v+l2+IQs8qLJYU=;
        b=gBMVo9oEFNFGnrdiPCKuOeMhzo2ekmU72qexenxf0WpzTvJ4KE7YLpwydBFMW4x0v3
         mT3d7LB7O0h+LK10t4aKa2zrP/vm/fFi2/IK9T/rway1ABzoc8OsV68NvLbOFCQWS1Xs
         PA94VIM4EJMJIiM7R3au6ZDjmc1QBy2phanPXGa+frsIWGOav+IcnD4Sz8PF066/4S3Q
         GulIRtN4w+6SKVyLSlOuQOjOnt2dGw7JbcZ0RyfGSkl5MGu4sA3wMOP1lgbx4iwc1QvT
         zrs7o5gm34UpJyQ6r3LBM0h5XsWOlec2OjPJyjgOxY4zvxzT+OfEeQ52IpMLhzfAe5ye
         hLgQ==
X-Gm-Message-State: AAQBX9fij0l4buJRWpo78hM8tISoIEkS2tJ9lnMjhwr0guuq1FCE53cn
        t2h/euYACpa6CAfaV5N3ZSBNB0BUv6ZVo4GCcs4qqFXvnCaoTsr5
X-Google-Smtp-Source: AKy350Z24PKo1DXlhcBZG5tK7bAiK9vehPYOkxWkW2mQIXynBW6Nnbf6fqRASVhbHoQlWHlwrEKYxTSN5CijDuUkbP4=
X-Received: by 2002:a25:ca05:0:b0:b8e:efd8:f2c with SMTP id
 a5-20020a25ca05000000b00b8eefd80f2cmr1603481ybg.1.1681293412609; Wed, 12 Apr
 2023 02:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g> <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
 <ZDIUvK/bF7BFqX5q@nand.local> <CAOLTT8RbU6G67BtE9fSv4gEn10dtR7cT-jf+dcEfhvNhvcwETQ@mail.gmail.com>
 <20230410201414.GC104097@coredump.intra.peff.net> <CAOLTT8T9pJFr94acvUo-8EYriST1gOAkXaDZBxHk54o=Zm5=Sg@mail.gmail.com>
 <20230412074309.GB1695531@coredump.intra.peff.net>
In-Reply-To: <20230412074309.GB1695531@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 12 Apr 2023 17:57:02 +0800
Message-ID: <CAOLTT8Rw796zxMYxg5+nx8+YoQVnfy=nPXH8Aq0j0Cw+GLT1rA@mail.gmail.com>
Subject: Re: [Question] Can git cat-file have a type filtering option?
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2023=E5=B9=B44=E6=9C=8812=E6=97=A5=E5=91=
=A8=E4=B8=89 15:43=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Apr 11, 2023 at 10:09:33PM +0800, ZheNing Hu wrote:
>
> > > So reducing the size of the actual --batch printing may make the
> > > relative cost of using multiple processes much higher (I didn't apply
> > > your --type-filter patches to test myself).
> > >
> >
> > You are right. Adding the --unordered option can avoid the
> > time-consuming sorting process from affecting the test results.
>
> Just to be clear: it's not the cost of sorting, but rather that
> accessing the object contents in a sub-optimal order is much worse (and
> that sub-optimal order happens to be "sorted by sha1", since that is
> effectively random with respect to the contents).
>

Okay, thanks for correcting me. Reading the packfile in SHA1 order is
actually a type of random read, and it should cause additional overhead.

> > time git cat-file --unordered --batch-all-objects \
> > --batch-check=3D"%(objectname) %(objecttype)" | \
> > awk '{ if ($2 =3D=3D "blob") print $1 }' | git cat-file --batch > /dev/=
null
> >
> > 4.17s user 0.23s system 109% cpu 4.025 total
> >
> > time git cat-file --unordered --batch-all-objects --batch
> > --type-filter=3Dblob >/dev/null
> >
> > 3.84s user 0.17s system 97% cpu 4.099 total
> >
> > It looks like the difference is not significant either.
>
> OK, good, that means we can probably not worry about it. :)
>
> > > In general, I do think having a processing pipeline like this is OK, =
as
> > > it's pretty flexible. But especially for smaller queries (even ones t=
hat
> > > don't ask for the whole object contents), the per-object lookup costs
> > > can start to dominate (especially in a repository that hasn't been
> > > recently packed). Right now, even your "--batch --type-filter" exampl=
e
> > > is probably making at least two lookups per object, because we don't
> > > have a way to open a "handle" to an object to check its type, and the=
n
> > > extract the contents conditionally. And of course with multiple
> > > processes, we're naturally doing a separate lookup in each one.
> > >
> >
> > Yes, the type of the object is encapsulated in the header of the loose
> > object file or the object entry header of the pack file. We have to rea=
d
> > it to get the object type. This may be a lingering question I have had:
> > why does git put the type/size in the file data instead of storing it a=
s some
> > kind of metadata elsewhere?
>
> It's not just metadata; it's actually part of what we hash to get the
> object id (though of course it doesn't _have_ to be stored in a linear
> buffer, as the pack storage shows).

I'm still puzzled why git calculated the object id based on {type, size, da=
ta}
 together instead of just {data}?

> But for loose objects, where would
> such metadata be? And accessing it isn't too expensive; we only zlib
> inflate the first few bytes (the main cost is in the syscalls to find
> and open the file).
>

I may not have a lot of experience with this here. It looks like I should
go ahead and do some performance testing to compare the cost of searching
and opening loose objects v.s reading and inflating loose objects.

> For packed object, it effectively is metadata, just stuck at the front
> of the object contents, rather than in a separate table. That lets us
> use the same .idx file for finding that metadata as we do for the
> contents themselves (at the slight cost that if you're _just_ accessing
> metadata, the results are sparser within the file, which has worse
> behavior for cold-cache disks).
>

Agree. But what if there is a metadata table in the .idx file?
We can even know the type and size of the object without accessing
the packfile.

> But when I say that lookup costs dominate, what I mean is that we'd
> spend a lot of our time binary searching within the pack .idx file, or
> falling back to syscalls to look for loose objects.
>

Alright, binary search in .idx may indeed be more time-consuming than
reading type and size from the packfile.

> > > So a nice thing about being able to do the filtering in one process i=
s
> > > that we could _eventually_ do it all with one object lookup. But I'd
> > > probably wait on adding something like --type-filter until we have an
> > > internal single-lookup API, and then we could time it to see how much
> > > speedup we can get.
> >
> > I am highly skeptical of this "internal single-lookup API". Do we reall=
y
> > need an extra metadata table to record all objects?
> > Something like: metadata: {oid: type, size}?
>
> No, I don't mean changing the storage at all. I mean that rather than
> doing this:
>
>   /* get type, size, etc, for --batch format */
>   type =3D oid_object_info(&oid, &size);
>
>   /* now get the contents for --batch to write them itself; but note
>    * that this searches for the entry again within all packs, etc */
>   contents =3D read_object_file(oid, &type, &size);
>
> as the cat-file code now does (because the first call is in
> batch_object_write(), and the latter in print_object_or_die()), they
> could be a single call that does the lookup once.
>
> We could actually do that today, since the object contents are
> eventually fed from oid_object_info_extended(), and we know ahead of
> time that we want both the metadata and the contents. But that wouldn't
> work if we filtered by type, etc.
>

So what you mentioned earlier about single read refers to combining
the two read operations of getting type size and getting content into one,
when we know exactly that we need to retrieve the content.(in order to redu=
ce
the overhead of the binary search once).

> I'm not sure how much of a speedup it would yield in practice, though.
> If you're printing the object contents, then the extra lookup is
> probably not that expensive by comparison.
>

I feel like this solution may not be feasible. After we get the type and si=
ze
for the first time, we go through different output processes for different =
types
of objects: use `stream_blob()` for blobs, and `read_object_file()` with
`batch_write()` for other objects. If we obtain the content of a blob in on=
e
single read operation, then the performance optimization provided by
`stream_blob()` would be invalidated.

> -Peff
