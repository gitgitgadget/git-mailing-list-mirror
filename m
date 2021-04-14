Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1363C433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 18:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2FA961168
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 18:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351924AbhDNSFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 14:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbhDNSFj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 14:05:39 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5839AC061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 11:05:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z13so17648761lfd.9
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 11:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cwBx46Q86XgvG2SXB+oMf1yHaKFXna37RSyXCrhpR34=;
        b=p02Y4PG5IW8fhadSzBS23cwggKsKMaIHxkP6k40cJ4OSM4nktwurTTmsfi4bZHBYvE
         tIdmWp8oA9npF8F4H5RDMrzamL7CbSNs9vy8W38tLXBG4MCD0UEENOjSPoSkLAFHO1Zb
         apLqyXynUeJ7x+btyKl8xiXo4VGD/0w+hzx3sOdxVZ7APu7HNJi/4ZCFfHffwAPhrXON
         xIPBvLkHgwP29sqxpBPYJ1U1zij5YNQgobiS1om9XaLdOFI9yipJr+kc8CA0Ed3ya8ml
         833YABO0AZB/jnXshM+LY8OxN0ZRlV4nyyH9uEgvrLte/rK0ojBWT00/0Rzp5d+Rm01v
         yrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cwBx46Q86XgvG2SXB+oMf1yHaKFXna37RSyXCrhpR34=;
        b=N9lyAFodVQ64YuV98xORmbCiDGEheQH0DvVM8Yewat6EM8wDboeY56mXRYdBMmdK7U
         0IsupcQgvrxXu1Ytiq2HD7Gm3dYsk47r1vg5vS7K+huKQOJRIBzYL8p3R+MN6150s6gG
         kYweqOumiZXDxx+eDV1nUaX5fns0xxUcNwOnOapKKt/pBWQMPKDZcFWyOJS+bpJ7L/gK
         1qGBnwRwmMvsjC+Sm+s0fyNYo6nLL2CkddZa6mOYGY2Fm3Vw4uHV9K1rfsO5tAZoDsIW
         OcSFe3lw43+Cr1i4AOkRAHWs2JuzBQGNkxAFmrrae258jWPqESLE5pM9kXWZYQkv4K19
         h98Q==
X-Gm-Message-State: AOAM532xEsdpokICBsZGOEQH/WCvwBvQP/o4wWgWopZVOJwKYVjaW07V
        qDIQ3aaruz6Nf/WufXFV3Tz+4S0QJ0/2f1YbJwTmpYzPCeNh5Q==
X-Google-Smtp-Source: ABdhPJxXTERN89CByuoc5dkBxg5f5Wk9YSQJSmcBGVSslMVllcSb+i8HJGhjXxoN61NVCRGsaKM7eURFPPBJ8A6kfGA=
X-Received: by 2002:a05:6512:3094:: with SMTP id z20mr15891437lfd.354.1618423510982;
 Wed, 14 Apr 2021 11:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615588108.git.matheus.bernardino@usp.br>
 <cover.1617914011.git.matheus.bernardino@usp.br> <CABPp-BGFfqOLg4tt85f-F-TJEXTDQFfAvRuui6VCctcd0FB5sQ@mail.gmail.com>
In-Reply-To: <CABPp-BGFfqOLg4tt85f-F-TJEXTDQFfAvRuui6VCctcd0FB5sQ@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 14 Apr 2021 15:04:59 -0300
Message-ID: <CAHd-oW5e29Q8=4M-bxUT7mmWi1VyjQ1rCy+zWcw0_WETwB87_A@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] add/rm: honor sparse checkout and warn on sparse paths
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 14, 2021 at 1:36 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Apr 8, 2021 at 1:41 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > Make `rm` honor sparse checkouts, and make both `rm` and `add` warn
> > when asked to update sparse entries.
> >
> > There are two changes since v3:
> >
> > - `test_i18ncmp` and `test_i18ngrep` were replaced by `test_cmp` and
> >   `grep`
> >
> > - The flag added in patch 5 now makes refresh_index() completely ignore
> >   skip_worktree entries, instead of just suppressing their matches on
> >   the seen[] array. The previous implementation was not necessarily
> >   wrong but, as Junio pointed out, it was rather odd to keep matching
> >   the entries if we no longer want to use the matches.
> >
> >   As "side effects", the new version of the flag also makes
> >   refresh_index() refrain from both:
> >
> >   (1) checking and warning if skip_worktree entries matching the given
> >   pathspec are unmerged.
> >
> >   (2) marking skip_worktree entries matching the given pathspec with
> >   CE_UPTODATE.
> >
> >   The change (1) is actually interesting because `git add` doesn't
> >   update skip_worktree entries, and thus, it doesn't make much sense to
> >   warn if they are unmerged. Besides, we will already warn if the user
> >   requests to update such entries, anyway. And finally, unmerged
> >   entries should not have the skip_worktree bit set in the first place.
> >   (`git merge` should clean this bit when writing the new index, and
> >   neither `git sparse-checkout` nor `git update-index` allow to set the
> >   bit on an unmerged entry.)
> >
> >   Change (2) is perhaps not very beneficial, but it is also not harmful.
> >   The only practical difference we get by not setting the CE_UPTODATE
> >   flag in the skip_worktree entries is that, when writing a new index at
> >   the end of `git add --refresh`, do_write_index() will start checking
> >   if these entries are racy clean. Note that it already does that for
> >   all the skip_worktree entries that do not match the user-given
> >   pathspecs. And, in fact, this behavior distinction based on the
> >   pathspec only happens with `--refresh`. Plain `git add` and other
> >   options don't mark any skip_worktree entry with CE_UPTODATE
> >   (regardless of the pathspecs) and thus, all these entries are checked
> >   when writing the index. So `git add --refresh` will only do what the
> >   other options already do.
>
> Sorry for the delay.  These two changes sound good to me, and the
> range-diff looks reasonable.
>
> >   (Additionally, as I mentioned in [1], there might actually be at least
> >   one advantage in checking if the skip_worktree entries are racy clean.
> >   But this is a very specific case, and it's probably a topic for a
> >   another thread :)
> >
> > [1]: https://lore.kernel.org/git/CAHd-oW4kRLjV9Sq3CFt-V1Ot9pYFzJggU1zPp3Hcuw=qWfq7Mg@mail.gmail.com/
>
> This I'm a bit surprised by.  I thought the outcome there was that you
> didn't want to mark skip_worktree entries as CE_UPTODATE in order to
> force them to be stat'd in the future when someone clears the
> skip_worktree bit.

Hmm, not exactly. This situation is a bit tricky and I probably got
lost when trying to communicate my thoughts about it.

In short, the outcome of not marking skip_worktree entries as
CE_UPTODATE (which is an in-memory-only flag) is that, when writing
the updated index at the end of `git status --refresh` , we now
properly detect and mark skip_worktree entries whose associated files
are present in the working tree and are modified in relation to the
respective blobs. (This whole process is skipped for CE_UPTODATE
entries.)

This doesn't have any effect while the skip_worktree bit is set. But
it makes it possible for a later `git status` to properly show the
files as modified when the skip_worktree bit gets unset. If we don't
do this, the later `git status` will wrongly think these entries are
clean.

This is because of the way git detects racily clean entries.
Paraphrasing `Documentation/technical/racy-git.txt`, we take two
actions to diagnose these entries:

1) When we want to know if an entry is up-to-date: if the entry's
timestamp is equal to, or newer than, the index timestamp, we not only
compare the cached stat info with the filesystem stat info but we also
compare the actual contents.

2) When writing a new index: if the index contains racily clean
entries, their `st_size` is truncated to zero.

Item 2) is important because, otherwise, the subsequent operations
wouldn't be able to detect the racily clean entries using 1) as the
index timestamp would have been updated.

And that's what happens with skip_worktree entries on `git status
--refresh`. We mark them as CE_UPTODATE even if the file exists in the
working tree, so we don't check if the cached entry is racily clean,
and thus we don't truncate `st_size` to 0, hiding the racily clean
entry.

With all that said, I think this whole situation must be quite rare
and not very important in practice...
