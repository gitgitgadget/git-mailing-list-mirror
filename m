Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F5FC388F7
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 20:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2618A2072C
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 20:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/gN0/rr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgJaUbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 16:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbgJaUbd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 16:31:33 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABF4C0617A6
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 13:31:33 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id m26so8885422otk.11
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 13:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eo8Crgk4re8G8+0Lvv2O1RIYg0uq5ATbJIrgaHoLCDs=;
        b=i/gN0/rragdyFTfUrNq6imCjueADQIG4SkwYRKarIT2j+ldiNft36plxSeK/Zer4oo
         3cI+4G9rhWvmgyjzok3WZh237tt40jbz1FVUpO/HbL2P/ZUB2LgXUXQuT+trGSaCuZan
         X8aR1IuIEN/Ls5F7R4S1VpGmSlCpAtrN6TjS+CRg4q/hMr7AeAfmqEV0pddWTYnOkuR2
         htZxu00nk04Ct9cL59pZjmnrle17mLbVTQRd9p0yetymb1z9QIZRJsBQFB280BlP9hr2
         hYbXhXwxpSj6/CL9xsqw6+KV6UFkRB0n0RZXrqUXdfZ5YOW9sDe6d7lStDcF8Ok40sky
         dyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eo8Crgk4re8G8+0Lvv2O1RIYg0uq5ATbJIrgaHoLCDs=;
        b=CTmqh8tjmGP49Tu8uvMCwvthOjt7dKsq76fUTt3G1O+3sADceCNvYjIjwcyzHSXwME
         3tPtKy3UcoYaHwktZE6kb+EpCCmfm8yn//s6JvXzTGQJlJLItOV7d/3x8x5u+XmJtq9T
         zXgZzmjlCsBI67m9c4gVRcnfUcBOpzAEKo3vlQXhiegYRq9jYcmndBk6FX2+hnZ4boG5
         Lpa01sUoJnWODD3CPpGW2RxKhfn79jCYmVAO83vsiRtkuHzVYyGf7MhHufUoiF8AsBaU
         pT6gcbitROVFRfPqEBVUs2ChoyA+SYa5t72jnucVUr88JcgSYnlYv7MxeOxL+hsmG6ZR
         TD8w==
X-Gm-Message-State: AOAM533dO2m4JbcPJYSgIaEiJKDd5BuH6w0SR0M+ZCJ0DbNEBmShcoGk
        Bw1m2glE96BdtcC8t80lCWpnYyhZMJ6q6vNEi8LChDx+20fDYA==
X-Google-Smtp-Source: ABdhPJzNFZkcQ6KObOdGlsczOtJrFrflpSZP9R/3ZDiIiNK+teiRRoVXKE2s/4W/oV0iPkPUJ5M6z4z1n0AH9ALZ/7E=
X-Received: by 2002:a9d:8d7:: with SMTP id 81mr2168012otf.345.1604176292082;
 Sat, 31 Oct 2020 13:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHjREB6Hh+urW3j2c9p45ZudSdDv0rUP28Lb4e4TZasqTzRmDA@mail.gmail.com>
 <CABPp-BF3MEAkJmmLv_0fWBJV_2AMqh_8P7Dqk62c2_Uz9Pa3Lw@mail.gmail.com> <6dfa865d-cb32-47fa-b9b4-fe3901a0cf63@gmail.com>
In-Reply-To: <6dfa865d-cb32-47fa-b9b4-fe3901a0cf63@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 31 Oct 2020 13:31:21 -0700
Message-ID: <CABPp-BE7+9_AiYCP+m7TOY85d4FWHG4rORk16Z6bsnAWxVPwCg@mail.gmail.com>
Subject: Re: [Outreachy][Proposal] Accelerate rename detection and the range-diff
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Sangeeta NB <sangunb09@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Oct 30, 2020 at 2:02 AM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> Hi Elijah,
>
> On 26/10/20 10:22 pm, Elijah Newren wrote:
> >
> > On Mon, Oct 26, 2020 at 1:44 AM Sangeeta NB <sangunb09@gmail.com> wrote:
> >>
> >> I would love to participate in outreachy this year with Git in the
> >> project "Accelerate rename detection and the range-diff command in
> >> Git". I have contributed to the microproject "Unify the meaning of
> >> dirty between diff and describe"[1] which is still under review, but
> >> through the process, I have got myself familiar with the mailing list
> >> and patch review system. I am also contributing to another issue[2]
> >> which is still under discussion[3] about `git bisect` and `git
> >> rebase`.
> >>
> >> [1] https://lore.kernel.org/git/pull.751.git.1602781723670.gitgitgadget@gmail.com
> >> [2] https://github.com/gitgitgadget/git/issues/486
> >> [3] https://lore.kernel.org/git/pull.765.git.1603271344522.gitgitgadget@gmail.com/
> >>
> >> Coming to the project, I have read more about it[4] and have created
> >> the initial version for the timeline. I would really love to have
> >> comments on it.
> >>
> >> [4] https://github.com/gitgitgadget/git/issues/519
> >
> > I might be the bearer of some bad or concerning news.  This email is
> > directed more to the mentors and others on the git mailing list, but
> > obviously may affect you as well:
> >
> > I apologize for not stating my concerns more forcefully earlier, but I
> > didn't have as many details at the time or have an idea how fast
> > merge-ort could be upstreamed.  Anyway, I'm still concerned that this
> > might not be a good project for Outreachy due to two factors: unclear
> > benefit, and conflicts:
> >
> > 1) I've got merges down to the point where even if there is a massive
> > rename of 26000 files (e.g. renaming "drivers/" to "pilots/" in the
> > linux kernel), rename detection is NOT the long tent pole in a merge.
> > So although this project is interesting, it's not clear that this
> > project will help us much.  It might be better to get my changes
> > merged down and see if there's enough need for additional
> > optimizations first.
> >
> > 2) Ignoring what I've already submitted, the remaining diffstat for
> > merge-ort is about 5500 lines....
> >    2a) If I break that ~5500 lines into patches with 50 lines each,
> > that's 111 patches.  If I assume I can send 10-20 patches per week
> > without overwhelming folks, that's 6-11 weeks, pulling us somewhere
> > into mid-December or mid-January.  10-20 patches per week might be
> > over-optimistic on reviewer fatigue, which would push it out even
> > further.
> >    2b) Work is going to soon rotate me onto other non-git projects,
> > meaning even if the mailing list can review my changes aggressively,
> > there's a chance I might not be able to keep up on feeding them to the
> > list.
> >    2c) diffcore-rename.c is only ~700 lines right now.  My 5500 lines
> > of changes includes over 1000 new lines for diffcore-rename.c and
> > about 150 line removals for it.  These changes are spread all over the
> > file; only four small functions remain untouched.  In fact, I even
> > made big changes to struct diff_rename_dst too, so any new uses of it
> > would almost certainly have textual conflicts.
> >    2d) My diffcore-rename.c changes probably do not make logical sense
> > to submit first.  They should come after some groundwork is laid for
> > merge-ort.
> >
> > Even though at a high level this project is complementary to the
> > optimizations I made in my 'merge-ort' work, I fear there will be LOTS
> > of intermediate conflicts as we both make changes to the same areas
> > during the same time and make a mess of things.
> >
>
> Thanks for the detailed concerns. Some thoughts:
>
> - Given that a major portion of the project would be to evaluate
>    various algorithms and identifying the most suitable one, I believe
>    implementation conflict shouldn't be a problem as it's expected to
>    start only by late-January. Also, as Christian pointed out elsewhere
>    it might be a good learning experience.

"late-January" _might_ be okay, but I'm worried that relying on
optimistic timelines is a bad idea.  However, if the primary purpose
is a good learning experience, or if the primary purpose is to
evaluate different algorithms (i.e. we're not relying on the timelines
to avoid conflict, it's just a bonus if they don't), then sure, no
problem there.

> - I do have a concern about one thing, though. For evaluating the
>    algorithm in the context of Git, we might need to do some experimental
>    implementations to get some metrics which would serve as the data that
>    we could use to identify the optimal algorithm. I'm  wondering whether
>    your planned changes might affect that. In the sense that, is there a
>    chance for the evaluation to become obsolete as a consequence of those
>    changes? If yes, what could we do to overcome that? Any thoughts on
>    this would be helpful.

That is certainly a possibility, yes.  One way to address that concern
is for me to freeze some branch (likely some version that I deploy
internally at $DAYJOB for testing), and for you to build on that.  If
all the new merge backend code gets reviewed and upstreamed fast
enough, and the areas you depend on don't change too drastically based
on reviewer comments, then building on merge-ort creates no
impediments for the Outreachy project to get upstreamed at the normal
time.  I can understand, though, if that plan seems worrisome due to
worries about how fast the new backend will be upstreamed or how much
it needs to change in the process; that is, after all, why I raised my
concerns in the first place.
