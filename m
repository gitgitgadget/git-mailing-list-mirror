Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00ECC761A6
	for <git@archiver.kernel.org>; Sun,  9 Apr 2023 06:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjDIGr1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Apr 2023 02:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIGr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2023 02:47:26 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CB14498
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 23:47:25 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54c0c86a436so169652227b3.6
        for <git@vger.kernel.org>; Sat, 08 Apr 2023 23:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681022844; x=1683614844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2nCchON89UaXFSISm+3PUwbULehPRdotQX5JOp3UJU=;
        b=BeEJd8CBCV0aBn10394765pJyjWN6rim3EosL3lKucWkmV7Vh/pLNCcT/wy/ckQLU4
         B31ZNZod94hlmLcMWa6GH1DkB3yeK7dZ+d28Z3EnnQV7RREeGAZEyN+jVBxgV1mFQloh
         DncM3jbXXryyh4BwVMWwLzuZ27aW10GtZ+2b50cUFZ6IDRMNKMoKvzY1/LoksIv68W7K
         sEQfN987EF4/cSpotkwzYEw5aqPUVqDYYLm0auXNLLdrxeRxu9TVc6WztpjwSMJyph70
         /oiGgVyjgpHG48tcflXuZsXax9Y4E1f48Sxt1Pw1kgvmK3LCIV6i5h5L2fUwnHSmAW73
         d1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681022844; x=1683614844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2nCchON89UaXFSISm+3PUwbULehPRdotQX5JOp3UJU=;
        b=Ku/+2EssMzdZZEFdfJRbsLjTQqBN+iIfrDw92P/1YVBLj8OsQMGkJ1VQ3rU7fy2t1+
         R5o/ZO5K5FJe648athBMn67Vx+E/nLGif1PRZ5K6SqND4mzEPdd7Wpgj11rkR7BT1AA+
         kOU5DyDLUC7/KO58blLc75IGhyp99+ki8NuWYr79ZQSKXvqi8JbQuiTAXrJ2WEoaYih9
         bwUpaiGE+vHW/p8CEKE1VIatWEsTVD7SKaxs9f6G9gkevduiroucAMxY0xjphcaBExfn
         NR4bayQdRW8KMCyClXxuSgTtgn28tnau9O27HoMDKJLD3GGtrg8cRjeXI4ykCJvwi3Xr
         +LPg==
X-Gm-Message-State: AAQBX9djP4soCDh2J5nApiDl10V9n1n3ZHQvGOA1rTysC79Srjq/9naK
        MZaH9u6oaSNfy6oaSrS7CZXTNzY25nrlK6xjLNSJMVEXIDiTqXCC
X-Google-Smtp-Source: AKy350ZzMFpjD3GB2XOh+JfbMPL4sFVuoXePUF6QqdhLeUAZU7GkovaW+HF4HgdwwYpy2edV9mEEykfrEIAI+lXENq0=
X-Received: by 2002:a81:ac15:0:b0:546:63a:6e23 with SMTP id
 k21-20020a81ac15000000b00546063a6e23mr4099336ywh.0.1681022844272; Sat, 08 Apr
 2023 23:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g> <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
 <ZDIUvK/bF7BFqX5q@nand.local>
In-Reply-To: <ZDIUvK/bF7BFqX5q@nand.local>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 9 Apr 2023 14:47:30 +0800
Message-ID: <CAOLTT8RbU6G67BtE9fSv4gEn10dtR7cT-jf+dcEfhvNhvcwETQ@mail.gmail.com>
Subject: Re: [Question] Can git cat-file have a type filtering option?
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=889=E6=97=A5=E5=
=91=A8=E6=97=A5 09:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Apr 08, 2023 at 02:27:53PM +0800, ZheNing Hu wrote:
> > Okay, you're right. It's not "ungraceful" to have each task do its own =
thing.
> > I should clarify that for a command like `git cat-file --batch-all-obje=
cts`,
> > which traverses all objects, it would be better to have a filter. It mi=
ght be
> > more performant than using `git rev-list --filter | git cat-file --batc=
h`?
>
> Perhaps slightly so, since there is naturally going to be some
> duplicated effort spawning processes, loading any shared libraries,
> initializing the repository and reading its configuration, etc.
>
> But I'd wager that these are all a negligible cost when compared to the
> time we'll have to spend reading, inflating, and printing out all of the
> objects in your repository.
>

"What you said makes sense. I implemented the --type-filter option for
git cat-file and compared the performance of outputting all blobs in the
git repository with and without using the type-filter. I found that the
difference was not significant.

time git  cat-file --batch-all-objects --batch-check=3D"%(objectname)
%(objecttype)" |
awk '{ if ($2 =3D=3D "blob") print $1 }' | git cat-file --batch > /dev/null
17.10s user 0.27s system 102% cpu 16.987 total

time git cat-file --batch-all-objects --batch --type-filter=3Dblob >/dev/nu=
ll
16.74s user 0.19s system 95% cpu 17.655 total

At first, I thought the processes that provide all blob oids by using
git rev-list or git cat-file --batch-all-objects --batch-check might waste
cpu, io, memory resources because they need to read a large number
of objects, and then they are read again by git cat-file --batch.
However, it seems that this is not actually the bottleneck in performance.

> Hopefully any task(s) where that cost *wouldn't* be negligible relative
> to the rest of the job would be small enough that they could fit into a
> single process.
>
> > I don't think so. While `git rev-list` traverses objects and performs
> > filtering within a revision, `git cat-file --batch-all-objects` travers=
es
> > all loose and packed objects. It might be difficult to perfectly
> > extract the filtering from `git rev-list` and apply it to `git cat-file=
`.
>
> `rev-list`'s `--all` option does exactly the former: it looks at all
> loose and packed objects instead of doing a traditional object walk.
>
> Thanks,
> Taylor
