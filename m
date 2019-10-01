Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 553601F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 18:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfJASzM (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 14:55:12 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:39616 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJASzM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 14:55:12 -0400
Received: by mail-vk1-f195.google.com with SMTP id u4so3746088vkl.6
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I3bSpfPv3iUOH+ijx8ACGC8rDeRE1gGPoaRjSG4cKs4=;
        b=qPKE+0B+gc+1bNCX76vsJ5cQKhz5F6aY1X9kiKuNlLXxvmH1HPeqJIHmpJFtmB53P5
         CF/GGNSoVYHdoDxT2edJkW4tRqzP3cQsjIHRrLARkPaffr3gPDmFKvZGVBP1E+E39zD9
         lJAwtvGDR70vMjy94MRXmrLWkbpQZO7hba1Ag4JO1CCPwRf710OXitpgBhXReOIIxkwq
         QqJ4hiAQLy7TZZ2rLut2RbScqUnMvh27Z0OjQm+03rNGvZN0U75DIaFnDlCevLQcs8vg
         yPXHGhTxQPmQhlQQJe97MzIx0QKGahJQG/jUbySzDE3nkrp+05uJb4tsk2jr3ton590p
         WtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I3bSpfPv3iUOH+ijx8ACGC8rDeRE1gGPoaRjSG4cKs4=;
        b=OQ+4LMkviSBbRuFBKevYVlZhD+c6kX3G0ZpRn/wozXToI+iZBYXLAXIosnlESZLcpV
         gsGMl5iYi5A5huvlEON8TZd9BxHB5NMtzKV5/5Ak87cvhBiXZ+mwmYOmixnkBOdkJR4L
         UJEXDSuCsGEEW8S2CpRPMeXqD1p9PvUtK+aTsgb94fgJR0pgT/zwf5s4sceC0brPd1JO
         1Ew/HMF5gv7BfKAfCP5byZ3LnLNi3l+IzvUF+c9AaFT3m+YaxV70J/7JhPNMn1Uv58rb
         day0f7ewGAaF5gFiKRXR+YC3H7SkwK/6+atS+TPgZ63E8CI3tdVtCvsl+bAgm6ZCNPCV
         xvfg==
X-Gm-Message-State: APjAAAWrSz7w9DdOcYRFWJRDAk8YEC+Otf1jWNMTxncVnJC0Uafv7Fa9
        Zwja4zJRbSaDV1grj0MhUMyZKGm2DhzmxKcVduLHbT6E
X-Google-Smtp-Source: APXvYqySWp4WUACCYlO6jSjnq7+hpYvU4qsmibs+ZcUuBtwrA03RWHYK2zpdJVbEIr0PB1NEzmbGKcfK7hLzBR7PUl0=
X-Received: by 2002:a1f:e242:: with SMTP id z63mr8425339vkg.37.1569956111280;
 Tue, 01 Oct 2019 11:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190930191106.16128-1-newren@gmail.com> <20191001183005.16977-1-newren@gmail.com>
 <20191001184049.GA30113@generichostname>
In-Reply-To: <20191001184049.GA30113@generichostname>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 1 Oct 2019 11:54:59 -0700
Message-ID: <CABPp-BEmtnXT9+=+P4-D-0yKM075zstnaovL1P22vfn5FNdfMA@mail.gmail.com>
Subject: Re: [PATCH v2] dir: special case check for the possibility that
 pathspec is NULL
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 1, 2019 at 11:41 AM Denton Liu <liu.denton@gmail.com> wrote:
>
> Hi Elijah,
>
> On Tue, Oct 01, 2019 at 11:30:05AM -0700, Elijah Newren wrote:
>
> [...]
>
> > diff --git a/dir.c b/dir.c
> > index 7ff79170fc..bd39b86be4 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -1962,8 +1962,9 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
> >                       ((state == path_untracked) &&
> >                        (get_dtype(cdir.de, istate, path.buf, path.len) == DT_DIR) &&
> >                        ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
> > -                       do_match_pathspec(istate, pathspec, path.buf, path.len,
> > -                                         baselen, NULL, DO_MATCH_LEADING_PATHSPEC) == MATCHED_RECURSIVELY_LEADING_PATHSPEC))) {
> > +                       (pathspec &&
> > +                        do_match_pathspec(istate, pathspec, path.buf, path.len,
> > +                                          baselen, NULL, DO_MATCH_LEADING_PATHSPEC) == MATCHED_RECURSIVELY_LEADING_PATHSPEC)))) {
> >                       struct untracked_cache_dir *ud;
> >                       ud = lookup_untracked(dir->untracked, untracked,
> >                                             path.buf + baselen,
> > @@ -1975,7 +1976,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
> >                       if (subdir_state > dir_state)
> >                               dir_state = subdir_state;
> >
> > -                     if (!match_pathspec(istate, pathspec, path.buf, path.len,
> > +                     if (pathspec &&
> > +                         !match_pathspec(istate, pathspec, path.buf, path.len,
> >                                           0 /* prefix */, NULL,
> >                                           0 /* do NOT special case dirs */))
> >                               state = path_none;
> > diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> > index 192c94eccd..a840919967 100755
> > --- a/t/t0050-filesystem.sh
> > +++ b/t/t0050-filesystem.sh
> > @@ -131,4 +131,25 @@ $test_unicode 'merge (silent unicode normalization)' '
> >       git merge topic
> >  '
> >
> > +test_expect_success CASE_INSENSITIVE_FS 'checkout with no pathspec and a case insensitive fs' '
> > +     git init repo &&
> > +     (
> > +             cd repo &&
> > +
> > +             >Gitweb &&
> > +             git add Gitweb &&
> > +             git commit -m "add Gitweb" &&
> > +
> > +             git checkout --orphan todo &&
> > +             git reset --hard &&
> > +             mkdir -p gitweb/subdir &&
> > +             >gitweb/subdir/file &&
> > +             # it is not strictly necessary to add and commit the
>
> Probably not worth a reroll but we're missing "gitweb directory" at the
> end of the comment. Other than that, it looks good to me.

Yuck, I accidentally only removed half the comment when I intended to
remove it all?  Whoops.  I think it's worth a reroll; it's just a
single patch.  I'll send it out.
