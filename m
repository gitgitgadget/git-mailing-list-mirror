Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5786EEB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 07:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjGEHTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 03:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGEHTL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 03:19:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A64197
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 00:19:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so77547665e9.3
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 00:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688541546; x=1691133546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2LTbhDqU0wTTR7W3KEpz3iL4ZtL3tnlCVP4mDwc7xg=;
        b=cY6EaYWkZ4abffu05Q9X4oUjDgLnM975nUYJyDP1xkFbs+ZzYjF2rF0KcEPRa2JzG+
         Oqrm+ORTLLRCCGxIahNORdfN5cX2Tf3OPmw8hlyTQ/oEXOKWmo54lNArxwClwXAvpLkz
         jQkxR3crh3j0DyZDAkTvMJL+tR3fg1TY40uAvSADw293N6LRW7NAgIsuwPbVcAx+pOak
         fXYsOqf3Vkk+PII11W9/yC5uP+SEabpqY2fC+xvtR7Q7a1jbSkMxXaxNXHBIkP0UO/M6
         HMI14ejt3eVerfPeNv5YHf16YC3iOjyD56pOOSLQ3V0K50HncCYFxEgumtgMR3QYQJ2T
         /rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688541546; x=1691133546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2LTbhDqU0wTTR7W3KEpz3iL4ZtL3tnlCVP4mDwc7xg=;
        b=Gi9dKv/HCOYI7bqbiDqOBcUAJtOt4D7OSqre+T3ZNaXz4+unF/HO6U1PeEJD45ObgO
         OqnIBf9o/krUjH+kzM6rDN8VHZZth9W6hwK0Rj1iCCYAFdFdy8aob7MU5Qy9QNWzAa6q
         nyE8UOkqxB44mjCDRzZ4tKmddUhEdHDVhN7Ba2dMaCaGVt3rjo4XxHiTda+4PFASw438
         CTNHD11Egh6+HfXE9cGafeLUv52VRhLdX+twS03T6Deknlap2CtWWhf6cBBswPClLRwx
         cqYbfcsUWmNSeRgCi+1xPzhyamJ9rqVFc+VpGsqTBZuC+WEBi1fU68Ym9/6MCTalZ8Qy
         JHYA==
X-Gm-Message-State: AC+VfDwNgA+LTrFwh5KritH2ptu/zY3wPH03dzeObKfYwOxCkTNoQVSo
        vHcQlR1a+a4ZxZFKGwo/4eMA3U7b5xPPHl55Rhw=
X-Google-Smtp-Source: ACHHUZ5pT4u4FgQqxDPuli3jMTkdJDKNfkB1tosZ35o4hNF8d3GDBJgL3ad2ZUHzIFvJtR9tGDyhcOuM6Gh8R8b2BI8=
X-Received: by 2002:a05:600c:364f:b0:3f7:4961:52ad with SMTP id
 y15-20020a05600c364f00b003f7496152admr14577235wmq.3.1688541546347; Wed, 05
 Jul 2023 00:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-7-christian.couder@gmail.com> <ZJLcS78DDOjn6MzP@nand.local>
In-Reply-To: <ZJLcS78DDOjn6MzP@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 5 Jul 2023 09:18:54 +0200
Message-ID: <CAP8UFD1oOiH71NfzgNhE_aCMHT8U8mCNADoAfpghxgXzEN30iw@mail.gmail.com>
Subject: Re: [PATCH 6/9] repack: add `--filter=<filter-spec>` option
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 1:17=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Wed, Jun 14, 2023 at 09:25:38PM +0200, Christian Couder wrote:
> > ---
> >  Documentation/git-repack.txt |  5 +++
> >  builtin/repack.c             | 75 ++++++++++++++++++++++++++++++++++--
> >  t/t7700-repack.sh            | 16 ++++++++
> >  3 files changed, 93 insertions(+), 3 deletions(-)
>
> Having read through the implementation in the repack builtin, I am
> almost certain that my suggestion earlier in the thread to implement
> this in terms of 'git pack-objects --filter' and 'git pack-objects
> --stdin-packs' would work.

Yeah, it works, thanks. That's what is used in the version 2 I just sent.

> > diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.tx=
t
> > index 4017157949..aa29c7e648 100644
> > --- a/Documentation/git-repack.txt
> > +++ b/Documentation/git-repack.txt
> > @@ -143,6 +143,11 @@ depth is 4095.
> >       a larger and slower repository; see the discussion in
> >       `pack.packSizeLimit`.
> >
> > +--filter=3D<filter-spec>::
> > +     Remove objects matching the filter specification from the
> > +     resulting packfile and put them into a separate packfile. See
> > +     linkgit:git-rev-list[1] for valid `<filter-spec>` forms.
> > +
>
> This documentation leaves me with a handful of questions about how it
> interacts with other options.

I have improved this doc in version 2. It now says:

--filter=3D<filter-spec>::
       Remove objects matching the filter specification from the
       resulting packfile and put them into a separate packfile. Note
       that objects used in the working directory are not filtered
       out. So for the split to fully work, it's best to perform it
       in a bare repo and to use the `-a` and `-d` options along with
       this option.  See linkgit:git-rev-list[1] for valid
       `<filter-spec>` forms.

For comparison the doc about --cruft is:

--cruft::
       Same as `-a`, unless `-d` is used. Then any unreachable objects
       are packed into a separate cruft pack. Unreachable objects can
       be pruned using the normal expiry rules with the next `git gc`
       invocation (see linkgit:git-gc[1]). Incompatible with `-k`.

> Here are some:
>
>   - What happens when you pass it with "-d"? Does it delete objects that
>     didn't match the filter? Leave them alone?

With or without "-d", no object is deleted, objects are just put into
2 different packfiles depending on whether or not they match the
filter.

> If the latter, should
>     this combination be declared invalid instead of silently ignoring
>     the user's request to delete redundant packs?

"-d" is indeed about removing redundant packs. If you want to split
the objects into different packs according to a filter, then you
probably don't want to keep packs that contain both kinds of objects
that you want to separate into different packs, so the doc now
recommends using "-d" (along with "-a") when using "--filter". That's
also what the tests are using.

I am not sure it's worth erroring out when "-d", or "-a", is not used.
Perhaps there are some use cases where it's interesting to keep old
packs, or, in case of not using "-a", to split only loose objects into
separate packs, but not objects from existing packs.

>   - What happens with --max-pack-size? Does the filtered pack get split
>     into multiple packs (as I think we would expect from such a
>     combination)?

Yes, in version 2 I have added a test (in the commit introducing
--filter-to) that checks that objects that are filtered out and that
are larger than --max-pack-size get split into their own packs.

>   - What about with `--cruft`? Does it split the cruft pack into two
>     based on whether or not the unreachable object(s) matched or didn't
>     match the filter?

I am not sure as I don't know well how cruft works. I would need to
check the code and/or test it.

>   - What happens when passed with "--geometric"? I don't think there is
>     a sensible interpretation (at least, I can't think of what it would
>     mean to do "--filter=3D<spec> --geometric=3D<factor>" off the top of =
my
>     head).

Not sure either, as I also don't know well how --geometric works.

>   - What about with "--write-bitmap-index"? Do we write one bitmap
>     index? Two? If the latter, do we combine the packs into a MIDX
>     before writing the bitmap? Should we?

In the tests, repack --filter is used with "-c
repack.writebitmaps=3Dfalse" as otherwise the bitmap writing code tends
to complain that a pack is not complete or something like that. I
think it would make sense to have options that would make the bitmap
writing code write a regular bitmap index if all the objects are in a
single pack, but a MIDX if they are in multiple packs. I don't know
what --cruft or --max-pack-size are doing about this, but I think such
a feature could be useful in case those options are used.

In the meantime I would be Ok with disallowing using both
--write-bitmap-index and --filter. The issue is that writing a bitmap
index is the default behavior, even without --write-bitmap-index, so
it might be a bit more complex, but I plan to do something about it in
version 3.

> I think it may be worth spelling out answers to some of these questions
> in the documentation, and codifying those answers in the form of tests.

In version 2, the doc has been improved and now it seems comparable to
the --cruft doc. About the tests, I added one in version 2 related to
--max-pack-size, and I am open to adding a few others, but I don't
think it's a good idea to add a lot of them. It just doesn't scale
when commands have more than a few options.

The new code is reusing existing features (like --stdin-packs) that
are already used by other code (like --cruft code). It is not adding
new intricate mechanisms, nor a lot of new code. It is not changing
code used by other features except for a few clean refactorings. This
should give a good indication that it will work well with other
features.

> This makes me wonder whether or not this option should belong in repack
> at all, or whether there should be some new special-purpose builtin that
> is designed to split existing pack(s) based on whether or not they meet
> some filter criteria.

--cruft is also splitting existing packs based on some criteria. So if
we go this way, perhaps --cruft code should be moved first to this new
special purpose builtin?
