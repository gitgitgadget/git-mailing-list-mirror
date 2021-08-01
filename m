Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52292C4320A
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 08:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A3C610A0
	for <git@archiver.kernel.org>; Sun,  1 Aug 2021 08:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhHAI45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Aug 2021 04:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhHAI45 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Aug 2021 04:56:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D13C06175F
        for <git@vger.kernel.org>; Sun,  1 Aug 2021 01:56:48 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id yk17so18035224ejb.11
        for <git@vger.kernel.org>; Sun, 01 Aug 2021 01:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFVh2OIjJh31bxRv7wbUH/8d2s8g80RGpFC/W9b5YmU=;
        b=vHP4epLoQ2cr9s/MizrHx7vESj9Xicul8f8PVJBoZVYCDFX9QPp6esqJuKLnRvCCpu
         craxHdMitfGFWviuAiR3VEfWjuXvcgCbZX6XgR3g3yhy4h1fcB8NHpCyjO95ob6pNPT+
         kQx/uiXW0JY+EKVh02q/m2rnFxYaK34U0284w0ke9eEwbKtpyjrydMRqwNHapFlMhO0l
         M3nqhRwFRoRB55mvkf1rAftYcNnswqfNSJbNZtXitVrS69vSINDyVQ5P6s9G4x7+1b5l
         JBTEUw+WywVBVEElhqXshj/ycwW928ug2d6mwsLhLsWoa+FyK+zNyarGebzG3g5N3FWi
         PuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFVh2OIjJh31bxRv7wbUH/8d2s8g80RGpFC/W9b5YmU=;
        b=ca92xMuse8s8pEs9WLAxkBI2JDHAVtIrUtrESvnIALa69/EEBSEePU0OgO1Fb+qq6y
         lm9XoPkrHs3EgncZ9MWcXIIXI3ePMZMea10r4GUNKFFdI8quyBpiMCrz2A+TlfHGYOYn
         udSNKjcC4wYtAt6fLY4KwbxNXm6wY+Kus8cepMmJAiVGmcGii0zaTAcLDNtVk8dP0GTg
         kZoUXTTV8KSHoFTYPwdmi1qIY9YZl7QcdcBp273RvpfBaodThNhfb7JJsvhERcdU2TLK
         +i+XgbkMdYaHIWCJs/ii4FPUrU+3ZxvySyEkxxCeC23yEmbA4693g+y/+fFVY4zmhE6h
         tAZg==
X-Gm-Message-State: AOAM530Or9nZV1WJmS4UAStIbDVSokwB/+s28gON+1GNHak1PgXpLKse
        tyd6ZJMgyl0ZXjlWymfPRFirbdSX2K6I86BJqaw=
X-Google-Smtp-Source: ABdhPJzw4pSdHFdVJBhftKtSu1nX6IkrE/t+lRbPlroEr82E7fgS+3t2WYNKblHMGFQPkyvbq5Ytwmo9npsYu5jVPts=
X-Received: by 2002:a17:906:4115:: with SMTP id j21mr1790068ejk.206.1627808207458;
 Sun, 01 Aug 2021 01:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAJcwCMPU9EhRkqeei_LnYyTJRZUQgHCvomrBbW0Qn+Jp1yhQfQ@mail.gmail.com>
 <CAJcwCMPHFNHi5i=xRg=GAJL5HiUfKu_KUPwYwELofLLtOAK1bg@mail.gmail.com> <xmqqmtqij63t.fsf@gitster.g>
In-Reply-To: <xmqqmtqij63t.fsf@gitster.g>
From:   Andy Zhang <zhgdrx@gmail.com>
Date:   Sun, 1 Aug 2021 16:59:27 +0800
Message-ID: <CAJcwCMPaX4qTBfxG6UwswFXCAkGE1meX8GOFNQueKXmfHPMJ2Q@mail.gmail.com>
Subject: Re: why "git rebase" searching the duplicate patches in <upstream
 branch> rather than in <new base branch>?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 6:23 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Andy Zhang <zhgdrx@gmail.com> writes:
>
> > why "git rebase" searching the duplicate patches in <upstream
> > branch> rather than in <new base branch>?
> >
> > hi, all:
> >
> >  I am reading the help of "git rebase", it says:
> >     "If the upstream branch already contains a change you have made
> > (e.g., because you mailed a patch which was applied upstream), then
> > that commit will be skipped. "
> >
> >  But, because we are applying commits to <new base branch> rather than
> > to <upstream branch>, I really don't understand why we are searching
> > the duplicate patches in <upstream branch> rather than in <new base
> > branch>?
>
> It is either a design bug or a documentation bug, or both ;-)
>
It should NOT be a documentation bug, because, in my experiment, I
observe that, "git"'s behavior is exactly the same as documentation.
So, it should be "work as design".

> I do think it makes sense to skip commits from the branch we are
> rebasing that have equivalent commits in the upstream, as it is
> expected that upstream might have already applied/cherry-picked some
> of the changes you are rebasing, and you do not want to use the same
> change twice.
>
> When we are transplanting a series of commits from an old base to
> totally unrelated base using the --onto option, e.g. when replaying
> the contents of 'topic' relative to 'next' down to 'master' in your
> topology, however,
>
> > Old tree is:
> >
> > o---o---o---o---o  master
> >     \
> >      o---o---o---o---o  next
> >                       \
> >                        o---o---o  topic
>
> it is not necessarily obvious where to stop digging back at.  In the
> above picture where 'master' and 'next' have ancestry relationship,
> we could try to see if the three commits on 'topic' branch being
> replayed match any of the commits in next..master range, but when
> using the --onto option, there does not have to be any relationship
> between the <upstream> and <new base> (they do not have to share a
> root commit).  So from that point of view, it probably makes sense
> to default to --no-reapply-cherry-picks when --onto is used, while
> defaulting --reapply-cherry-picks when --onto is not used.
>
>
