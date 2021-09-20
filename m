Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70C1C433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 16:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEC2F60F58
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 16:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242956AbhITQOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 12:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242662AbhITQOD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 12:14:03 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084DFC0613E6
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 09:12:17 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id y201so10684049oie.3
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 09:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SIcUAgG3eV8Hhy92PrcGt4cxihTlTObR+mne7YNjK3Q=;
        b=goO7JnrCDD0HyukfzzUssqbed5EkZMBNFIsj3RR+5d3jiUB/alebzzCgKoStujz3IP
         wrX/2w/D6JJBM7kvVheI5zpzuAdasyaYRYgOrkb8QhplFCgt3sGa1qPKSJn5JV1Fzx9/
         bThSptJoS2aA0Sq0GFcnbwNdrPQ48lFq/pRmz6+hpeFjxSOOIC4le+TWDWCxJlvfoT6s
         MY9jKOBTde9kiooMIyUNS99AMcVpsWYArE7iH/wwZQz6Zc7Io40cWrcPArFyo9+UMjaa
         OvewJVbhqewJVuYG5grrraXWwkXjXzb0ZiaC3wlpQgRrtfCosPysO7NJsdS1yXzHoQOY
         hchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SIcUAgG3eV8Hhy92PrcGt4cxihTlTObR+mne7YNjK3Q=;
        b=Z9baIqzXD514t8GZqfDTrvfccKTLRdWZv8gTFqtjGUuKZkwF5PiA3dNmWZvfkAvqFd
         +hQ3GWfidc/17rWJuhSY198wpAL2bPzvUlkLgY9qOrBW5qOsmVeNlnTLUmJSzstL9pQk
         fZnSHYiNGN9/WBbnYkbQf1y/lCM/uYOWk84veYyDqavTjjsFT4lsIfYpEK+2/KW7TNWB
         AMiJr0hweqv+VMHURqoFRQq6goUAg27mJ+pzWofvr8Fu4Xr18/LRUY2Q9Ci1Kw7F1GD1
         Xr2T7EtGXWTWTDkXDd3KOmcAnDzF3RX4s9c9M2/nBP0iawouOR3NQ9PU+JAXnlWQ66TZ
         OA4Q==
X-Gm-Message-State: AOAM530cyzzOZOcWhIB0mZzVHhSE0Gk+QSeV5NbMJy5YRujlYKXz0z2y
        YFNlfkrQDkQuK0WOAqclVlgvJ86Z3L4crgaX+FkAxL4UsIc=
X-Google-Smtp-Source: ABdhPJx4lJ30kmruDKE6tHfdBXr5xbqe5EKj19ZLhQS3zY2feOwQ/VbB3rnoyCf2kTi/FgykojsdCHW7+OrcQ1d4ftw=
X-Received: by 2002:a05:6808:1113:: with SMTP id e19mr1908104oih.31.1632154336266;
 Mon, 20 Sep 2021 09:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
 <01bf850bb0f0796564e9363d7faeb792a594f684.1632006924.git.gitgitgadget@gmail.com>
 <87sfy0brk5.fsf@evledraar.gmail.com>
In-Reply-To: <87sfy0brk5.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Sep 2021 09:12:04 -0700
Message-ID: <CABPp-BEk5zQNwzUdFR=iG6d-d5u8pUEgLuiF7+hs7HT7p5BCqQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] unpack-trees: avoid nuking untracked dir in way of
 locally deleted file
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Fedor Biryukov <fedor.birjukov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 19, 2021 at 6:52 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sat, Sep 18 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  t/t2500-untracked-overwriting.sh | 2 +-
> >  unpack-trees.c                   | 4 ++++
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overw=
riting.sh
> > index 017946a494f..d4d9dc928aa 100755
> > --- a/t/t2500-untracked-overwriting.sh
> > +++ b/t/t2500-untracked-overwriting.sh
> > @@ -218,7 +218,7 @@ test_expect_success 'git am --abort and untracked d=
ir vs. unmerged file' '
> >       )
> >  '
> >
> > -test_expect_failure 'git am --skip and untracked dir vs deleted file' =
'
> > +test_expect_success 'git am --skip and untracked dir vs deleted file' =
'
> >       test_setup_sequencing am_skip_and_untracked &&
> >       (
> >               cd sequencing_am_skip_and_untracked &&
> > diff --git a/unpack-trees.c b/unpack-trees.c
> > index 3b3d1c0ff40..858595a13f1 100644
> > --- a/unpack-trees.c
> > +++ b/unpack-trees.c
> > @@ -2395,7 +2395,11 @@ static int deleted_entry(const struct cache_entr=
y *ce,
> >               if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED,=
 o))
> >                       return -1;
> >               return 0;
> > +     } else {
> > +             if (verify_absent_if_directory(ce, ERROR_WOULD_LOSE_UNTRA=
CKED_REMOVED, o))
> > +                     return -1;
> >       }
>
> Maybe just "else if" ?

Yeah, that makes sense.

> [...]

That's kind of misleading.  ;-)  You trimmed out a single line here,
and in particular one that only contained a trailing curly brace.
Thus, your "trimming" here actually made things longer.

>
> > +
>
> Stray whitespace change

No, the whitespace addition was after making the if-block above it
more complex with the extra else block.  That if-block is now
approximately 2/3 of the length of the function, and is the part that
is relevant to the comment above it.  Since the code that follows the
if-block is separate from the comment above and the if-block became
more complex, it felt natural to add a bit of spacing.  So, it wasn't
stray, but intentional and related to the changes above.
