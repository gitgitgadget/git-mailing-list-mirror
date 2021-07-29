Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43792C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 21:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB1560F4A
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 21:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhG2VFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 17:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhG2VFh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 17:05:37 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EA1C0613C1
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 14:05:32 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id o185so10138192oih.13
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xtCnrGl734cHYK65+1RZUtpyJhdSVx5xUd86n9+65Tc=;
        b=rWz+5izgZGJIggNBeT99bePb5jEHuwspqUnj2vdgZPVWee581R8mDaZa+aBuu9sBOJ
         w80UGjhLL6TejW/NR+Hp4uoDqiV6o+vhYikCzSp3fv2BVjh4PZA93H+8FjMC8+R+wC1v
         tXCGVKqCdxglbjbO2vpzIoTG7HHS2b4TtZEzlnrU104d8+PBhHknA/kEN/1VOqWofF+3
         zJJECJLZIYfa9sl7KWz0+ZQ9bMZALo+fanoPY/bkLsL1rqy6bh5TYcCZAUtahnaziuYy
         8ovXLNKQeAomNvCMxBmYubGEZqShLoUi2GRQzg1/SWkA9iNnsHbmEpwyTh7tmrkqEAkf
         J3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xtCnrGl734cHYK65+1RZUtpyJhdSVx5xUd86n9+65Tc=;
        b=HiapNEU0Oe/fgLeNbUXUQ/ApTQDxxB+LczPViV5RQ+yKc6WAqxiL6o/hg1Sg+C7TGN
         b9xKokfzGRV40jeSO9ih0EPg9UJjxO2bJYK9YcRIEjuD/ZmZXEsTR0J6m9TQzymcsfIW
         J3Jnkvzwfci1rMNi4BjJUVdCdwyznd+o49sPGz9ljr8RLaPKqV4ZIQfIxjJAFMfD5A1a
         x+5sUKbuNNg0WAaFp5InUvXNIkSdhMbLOivhoxNKrumG7CGDYaL3LH7i4uulRzlLUmzf
         2L+UiN1NLf9h1wln1uZm110gPKn7q2cBbpRgMBRw/9ulMoZk3jEKzISA0TEM3Cvg5658
         6CjQ==
X-Gm-Message-State: AOAM533pYJBgh7PCE/LoJSPj4Npm1dsM/CKRz1g0/4hFd8fXEMllnC12
        qa5rkNGjrqezBBLiv1cna6gJadDYLi+SyxNgBD0=
X-Google-Smtp-Source: ABdhPJyHmuNQlOeGix0FdHNTNJ3XSHWigPoZl93Op5J4lptvDECB+09A533UPwp8ROjMvQwRvcB+jAhVlw9n2YACpgk=
X-Received: by 2002:aca:d644:: with SMTP id n65mr4440439oig.31.1627592732279;
 Thu, 29 Jul 2021 14:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
 <pull.990.v2.git.1627531121.gitgitgadget@gmail.com> <YQLVPN9n5E1Yvi/q@coredump.intra.peff.net>
 <YQLV/MTQ+MkxUBSn@coredump.intra.peff.net> <xmqq1r7g6gyg.fsf@gitster.g> <xmqq4kcc4zjv.fsf@gitster.g>
In-Reply-To: <xmqq4kcc4zjv.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 29 Jul 2021 15:05:21 -0600
Message-ID: <CABPp-BFRqPVR42c4oESnWEHHPDky+cW4Re8Pptu1yQxXttQF-g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Final optimization batch (#15): use memory pools
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 2:48 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Jeff King <peff@peff.net> writes:
> >
> >> On Thu, Jul 29, 2021 at 12:20:13PM -0400, Jeff King wrote:
> >>
> >>> I assume your tests are just done using the regular glibc allocator. I
> >>> also wondered how plugging in a better allocator might fare. Here are
> >>> timings I did of your mega-renames case with three binaries: one built
> >>> with USE_MEMORY_POOL set to 0, one with it set to 1, and one with it set
> >>> to 0 but adding "-ltcmalloc" to EXTLIBS via config.mak.
> >>
> >> Oh, btw, I wasn't able to apply your series from the list on top of
> >> en/ort-perf-batch-14 (there are some problems in patch 4, and "am -3"
> >> says my clone of git.git is missing some of the pre-image sha1s). I
> >> fetched ort-perf-batch-15 from https://github.com/newren/git and timed
> >> that, which I imagine is the same. But you may need to tweak the patches
> >> so that Junio can pick them up.
> >
> > Thanks, but the batch #15 has been in 'seen' since 23rd ;-)
>
> Oh, that is the previous round.  I haven't had the chance to pick up
> this new round.

Oh, interesting.  At some point I had noticed that Junio based
en/ort-perf-batch-14 on top of a version of master that did not
include en/ort-perf-batch-12.  While that was fine from a correctness
point of view, it made my claims of speedups a bit weird and difficult
for others to reproduce as they'd need to merge some other series
first.  It looks like the base for en/ort-perf-batch-14 at some point
advanced to include a version of master that included
en/ort-perf-batch-12.

Anyway, I'm happy to re-roll this series and base it on
en/ort-perf-batch-14.  Peff has a few suggested improvements for me to
include in that re-roll.
