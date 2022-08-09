Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC26C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 12:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiHIMEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 08:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236564AbiHIMEE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 08:04:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52729248D7
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 05:04:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id k26so21820768ejx.5
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 05:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zCrGxyBzBEUg9wWg0SnFa9WovpJA3yA1gacT/lDmHQ8=;
        b=RHpMUqCrCjMmjJ+Osl3hIaniUTzVknsSU2XMC9iD6QiXKZ3gwYiKGJ9aWyiQlyTcKk
         O1rIJSNg74Oj6hfFFSaiOsoB3szF1HjrWqnUuaeA/kE6AEco7dGPReiA1FJeePffAstS
         iid3+WTCAi8I+EYBv09DVZwvx2SReuG/yGor4pQkjioP4Bb1OgniKu2LkYqTL2Z7x68T
         0eubkQYcL1KnseNyhWUBJUKUTWigrxYrkeINjHQdRGU5n/EiPc3NniCexstDruB6W7wR
         l+AE1o237gsXbuAF3rEIcx3/klIcE+2z2ooejGIUwp18iu2EB1qfnB65srmzjBmtTIj/
         ccNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zCrGxyBzBEUg9wWg0SnFa9WovpJA3yA1gacT/lDmHQ8=;
        b=J1y0tf7sZC7jSOvY3lEZhV6F9T0pRi6SmjGfMeNNNpRZiYjkI+X4Ew0mCduvR1GECX
         JvB+qv0yMttMSEb02D5j7Cfy+FPdnRR7hOY8Egk3Fu016YvSzR6jg9Lg8Ma2uctJc5uA
         bT4pIjdYpnIm7wkx7wySOFeZdx65qqKviPa6NjnF05aJAFREzRc2DC9AaUMmxo3CUSps
         x2sVvwdOYcQ66lmGWw776D5eD2K0CUHsTvsr+uUG2j8By/6hppk/vllpp7WOzDfLHeuT
         i8WGZVQHnGHZHfVkjFtzM7+ORnXrU59QFBCVy/xidXqS9mu1zYfCdcX+vZpXtjC7uOJq
         JPbA==
X-Gm-Message-State: ACgBeo13yq9opruExFFu3Yv4ASgCOb5hzXv9tBJYnyCSawDA+4wBG4jn
        68it+9OzufGPLeJg37nm3HWkSHpLjpjT1z61N9s=
X-Google-Smtp-Source: AA6agR5VqKMqsiDNwjIKkPwd3FRziBiNPnMcuWVcUG9VEY7IqgwV54BUPQFLV7yLxkPZb0fb2U3kBw4wXEgIIeSVQxo=
X-Received: by 2002:a17:906:dc92:b0:731:5a2f:6542 with SMTP id
 cs18-20020a170906dc9200b007315a2f6542mr7194170ejc.441.1660046641793; Tue, 09
 Aug 2022 05:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <59b465e5a7817c145172f25e73ad807c7ba67e84.1658342304.git.gitgitgadget@gmail.com>
 <p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr> <CAPOJW5xBUaAJtOvrefwbXv_WDTLa=6PTL5kEoOpRQfqqFAx3oA@mail.gmail.com>
 <6s4n3600-q5p7-92sr-4206-non3s8rr3n46@tzk.qr> <CAPOJW5yUi471cfAXuXaM4BCzVsfZ15J1Era4NuEpxEnmY6md9Q@mail.gmail.com>
 <p69r38sn-1ppn-q66q-9089-59394pq78772@tzk.qr> <CAPOJW5zYndyqwyN8xOcRQnwebqXciY-25hNL3fU=V5ac8fCpNA@mail.gmail.com>
 <s714sq49-o13q-5417-0o21-6397s3646q9o@tzk.qr>
In-Reply-To: <s714sq49-o13q-5417-0o21-6397s3646q9o@tzk.qr>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Tue, 9 Aug 2022 17:33:50 +0530
Message-ID: <CAPOJW5yNQvO3quG91jjC9pT-+NNhJta+H_E2R9-1wUzR+rPXnw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn pack.writeBitmapLookupTable
 and add tests
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 9, 2022 at 2:33 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Abhradeep,
>
> On Mon, 8 Aug 2022, Abhradeep Chakraborty wrote:
>
> > On Mon, Aug 8, 2022 at 6:36 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > On Tue, 2 Aug 2022, Abhradeep Chakraborty wrote:
> > >
> > > > On Tue, Aug 2, 2022 at 9:05 PM Johannes Schindelin
> > > > <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > > Since you are very familiar with the details of bitmaps now, I would
> > > > > like to encourage you to work on some kind of validator/inspector,
> > > > > e.g. something along the lines of a `test-tool midx-bitmap dump` (and
> > > > > later `... verify`) that would help future you (and future me)
> > > > > investigate similar breakages. Ideally, that tool will not only parse
> > > > > the `.bitmap` file but immediately print out everything in a
> > > > > human-readable form.
> > >
> > > Have you made progress on this? I am interested mostly because I am trying
> > > very hard to maintain passing CI runs of Git for Windows' `shears/seen`
> > > branch (which essentially tries to rebase all of Git for Windows' patches
> > > on top of `seen`), and this failure is consistently causing said CI runs
> > > to fail for a while already.
> >
> > Hey Dscho, I am trying hard to solve the issue but unfortunately I
> > haven't found the key yet.
>
> The tool I proposed could potentially help, in particular with
> distributing the burden of the investigation on more shoulders than just
> yours.

Yeah, it should. I thought that I would do that after fixing the bug.
Now I think I was wrong.

> > I investigated the bitmap code-base and used debug lines but didn't
> > find a way to fix it.
>
> Have you investigated whether the `.bitmap` file was produced for the
> latest set of pack files? It should be relatively quick to investigate
> that, and if it turns out not to be the case, the fix should be quick,
> too.

Frankly speaking, I doubt that the generated multi-pack-index file is
faulty. The first reason is the `.bitmap` filename. As you said before
(and as I noticed here), `.bitmap` filenames in failing case and in
passing case are different. As far as I know the hash value in the
filename depends on the content of its respective midx file. So, if
the midx contents were the same in both cases, `.bitmap` filename
should not differ.

I compared both the multi-pack-index files (i.e. passing case and
failing case) using `cmp ./trash\
directory.t5326-multi-pack-bitmaps/.git/objects/pack/multi-pack-index
../tmp/trash\ directory.t5326-multi-pack-bitmaps/.git/objects/pack/multi-pack-index`
and found that these both defers -

    differ: char 3124, line 10

I also checked whether the `packing_data->in_pack_by_idx` contained
all the packs. For this I wrote a debug error message in
`prepare_in_pack_by_idx()[1]` function and found that `packing_data`
is using the latest packs.

 I noticed in the 'setup partial bitmaps' test case that if we comment
out the line `git repack &&` , it runs successfully.

    test_expect_success 'setup partial bitmaps' '
        test_commit packed &&
        # git repack &&
        test_commit loose &&
        git multi-pack-index write --bitmap 2>err &&
        ...
    '
