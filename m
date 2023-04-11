Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E35DC77B73
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 14:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjDKOJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 10:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjDKOJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 10:09:26 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB7F10E
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 07:09:25 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id f188so40032171ybb.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681222164; x=1683814164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCPPM785+Ww4zmbGOHKWEh2jH7v7lfQcIOAWXXBvh3U=;
        b=mi22UbHRiU8hrEHdeCcXB9cMjvN86a+bUOBpGJGwJvIhyr3wEVCe2dnKKuqLUpvPmk
         azkXLo1lmBEZuNXG1UriSZ3bpy/aqcn+UgudVGCZpahYhAtFMlkQsD7y4qgPxmFY6os0
         miHUlBVNNOTIA+yxNhO74/5ilb8cOeJhzG4ecjPahLzK/7zDRTulZgVpiXcYmK+rLo3g
         euShwm0Rg3niUvZQmETVoer5QuvCenQHJFHUG1yMUibs37o09EFNaMy0S5l6UJ0Yj28d
         pp6aV+0wnifAAJQw+69GXdiiofbodlQ0FT0cixN4Js889OGXEV380b0vAoAT/ggr1nQN
         oaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681222164; x=1683814164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCPPM785+Ww4zmbGOHKWEh2jH7v7lfQcIOAWXXBvh3U=;
        b=lQSTA0TPyRF8Ho/jdzPaV1CIzNryoN/mh9vVH0YJM0Xy5YcGPHLksMn0gclIgBnGdA
         4Zymq/EM/i/ckRRR0s0WYog5Sqz+FZv8Q4WYfJMkQOik6DF87v7dlGSvcspyyW02/8tT
         +8jO8G5fHTfF7UsuhYzJifE2/MBL6hS4kxfyjhmXeagKL4HTnHSPbPail/n02I2B5ZZf
         RSl8q/TZJb5aGpX2eJep/B+yv+qT9TqcL3gcqdXKL9XmZELUrmv0WCmE5IVFk/vNmbYF
         3bdW/zx87r/o1AbgbKlhUqTFmAD3itLm1LV5iw1OUJY7PRMumq5Otg0G1X10ME8G71FU
         3VsA==
X-Gm-Message-State: AAQBX9eTy6aKl8wGZB5gvKVYnmUluc2XTJXnucnDDAeLLXnENIToRfgF
        LBSp23VBFn+D0faZ9P4CvXdx7ZVb+cEEQ3m+Ue8=
X-Google-Smtp-Source: AKy350ax1H2Wo1PTHllD57Sn/rNtTfhN3W0HejSUBhbA5p4EnVX8xOjQMdi9hEZ19I30Lik76B9436Q0/cizsfVYmGs=
X-Received: by 2002:a25:be11:0:b0:b7d:4c96:de0 with SMTP id
 h17-20020a25be11000000b00b7d4c960de0mr5097413ybk.5.1681222164532; Tue, 11 Apr
 2023 07:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g> <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
 <ZDIUvK/bF7BFqX5q@nand.local> <CAOLTT8RbU6G67BtE9fSv4gEn10dtR7cT-jf+dcEfhvNhvcwETQ@mail.gmail.com>
 <20230410201414.GC104097@coredump.intra.peff.net>
In-Reply-To: <20230410201414.GC104097@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 11 Apr 2023 22:09:33 +0800
Message-ID: <CAOLTT8T9pJFr94acvUo-8EYriST1gOAkXaDZBxHk54o=Zm5=Sg@mail.gmail.com>
Subject: Re: [Question] Can git cat-file have a type filtering option?
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2023=E5=B9=B44=E6=9C=8811=E6=97=A5=E5=91=
=A8=E4=BA=8C 04:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Apr 09, 2023 at 02:47:30PM +0800, ZheNing Hu wrote:
>
> > > Perhaps slightly so, since there is naturally going to be some
> > > duplicated effort spawning processes, loading any shared libraries,
> > > initializing the repository and reading its configuration, etc.
> > >
> > > But I'd wager that these are all a negligible cost when compared to t=
he
> > > time we'll have to spend reading, inflating, and printing out all of =
the
> > > objects in your repository.
> >
> > "What you said makes sense. I implemented the --type-filter option for
> > git cat-file and compared the performance of outputting all blobs in th=
e
> > git repository with and without using the type-filter. I found that the
> > difference was not significant.
> >
> > time git  cat-file --batch-all-objects --batch-check=3D"%(objectname)
> > %(objecttype)" |
> > awk '{ if ($2 =3D=3D "blob") print $1 }' | git cat-file --batch > /dev/=
null
> > 17.10s user 0.27s system 102% cpu 16.987 total
> >
> > time git cat-file --batch-all-objects --batch --type-filter=3Dblob >/de=
v/null
> > 16.74s user 0.19s system 95% cpu 17.655 total
> >
> > At first, I thought the processes that provide all blob oids by using
> > git rev-list or git cat-file --batch-all-objects --batch-check might wa=
ste
> > cpu, io, memory resources because they need to read a large number
> > of objects, and then they are read again by git cat-file --batch.
> > However, it seems that this is not actually the bottleneck in performan=
ce.
>
> Yeah, I think most of your time there is spent on the --batch command
> itself, which is just putting through a lot of bytes. You might also try
> with "--unordered". The default ordering for --batch-all-objects is in
> sha1 order, which has pretty bad locality characteristics for delta
> caching. Using --unordered goes in pack-order, which should be optimal.
>
> E.g., in git.git, running:
>
>   time \
>     git cat-file --batch-all-objects --batch-check=3D'%(objecttype) %(obj=
ectname)' |
>     perl -lne 'print $1 if /^blob (.*)/' |
>     git cat-file --batch >/dev/null
>
> takes:
>
>   real  0m29.961s
>   user  0m29.128s
>   sys   0m1.461s
>
> Adding "--unordered" to the initial cat-file gives:
>
>   real  0m1.970s
>   user  0m2.170s
>   sys   0m0.126s
>
> So reducing the size of the actual --batch printing may make the
> relative cost of using multiple processes much higher (I didn't apply
> your --type-filter patches to test myself).
>

You are right. Adding the --unordered option can avoid the
time-consuming sorting process from affecting the test results.

time git cat-file --unordered --batch-all-objects \
--batch-check=3D"%(objectname) %(objecttype)" | \
awk '{ if ($2 =3D=3D "blob") print $1 }' | git cat-file --batch > /dev/null

4.17s user 0.23s system 109% cpu 4.025 total

time git cat-file --unordered --batch-all-objects --batch
--type-filter=3Dblob >/dev/null

3.84s user 0.17s system 97% cpu 4.099 total

It looks like the difference is not significant either.

After all, the truly time-consuming process is reading
the entire data of the blob, whereas git cat-file --batch-check
only reads the first few bytes of the object in comparison.

> In general, I do think having a processing pipeline like this is OK, as
> it's pretty flexible. But especially for smaller queries (even ones that
> don't ask for the whole object contents), the per-object lookup costs
> can start to dominate (especially in a repository that hasn't been
> recently packed). Right now, even your "--batch --type-filter" example
> is probably making at least two lookups per object, because we don't
> have a way to open a "handle" to an object to check its type, and then
> extract the contents conditionally. And of course with multiple
> processes, we're naturally doing a separate lookup in each one.
>

Yes, the type of the object is encapsulated in the header of the loose
object file or the object entry header of the pack file. We have to read
it to get the object type. This may be a lingering question I have had:
why does git put the type/size in the file data instead of storing it as so=
me
kind of metadata elsewhere?

> So a nice thing about being able to do the filtering in one process is
> that we could _eventually_ do it all with one object lookup. But I'd
> probably wait on adding something like --type-filter until we have an
> internal single-lookup API, and then we could time it to see how much
> speedup we can get.
>

I am highly skeptical of this "internal single-lookup API". Do we really
need an extra metadata table to record all objects?
Something like: metadata: {oid: type, size}?

> -Peff

ZheNing Hu
