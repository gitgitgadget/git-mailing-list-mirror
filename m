Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFBFC433EF
	for <git@archiver.kernel.org>; Sun, 17 Apr 2022 17:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiDQRZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Apr 2022 13:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiDQRZp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Apr 2022 13:25:45 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBA21CFC1
        for <git@vger.kernel.org>; Sun, 17 Apr 2022 10:23:07 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id z139so5491706vsz.0
        for <git@vger.kernel.org>; Sun, 17 Apr 2022 10:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+xQrHyz2IlKJDA7QMU9/ALFwUITIeACQq9UtTd56nz4=;
        b=WSRC6moK142I40bpitXhzxzt/js8QP9VYhZ3Of7tKN1I/ZpS4fGbWjo/DwhQBZUZ0A
         iVxQLaer3fjznWxoq8Ex/UoscouwPB7uNqx7gaU/3er3fulCUJ2VlZMR4UP7w7nonMin
         nzFWuHGMfuDfX2hkxKAEyGe42eTJXHf1d318GWKll/WKYSAHZup3tNMuoS+99z1Ajxzv
         GX69Pi7U9DpLxluoGGi2iEitrcI9/Q4W/kbXsJU4RMvFch2iBuGR1JcQt/4ic3+1akTF
         pVt+MAhTYKm/v0XMgVZgLowci3PXsXcx9Ei1VuWb2JON+xbsFp+7LR9m3iRSeJyXEPQ6
         0WgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+xQrHyz2IlKJDA7QMU9/ALFwUITIeACQq9UtTd56nz4=;
        b=JzCS/A0cR+Ptcsj/REGERLP+lyuNHAo6t7SJyJDyDYOYzVMQEGE3ZPZ32p11l2+D7P
         aI9LQtpvALVSBElxxfxbTjE8rwVbcAGUxSAeLXVveY1BzYVVwBwu93SkWtFZbBftkkVc
         uiv0q3/SD8Vt3oavNwbNYS2I60cAYbJ6WPwAgeDgspbZ+594tQL0dWfvfp4OmGFxshtd
         BVPKSXRBhOGAggbFs4tblhwW9bLj5YZxhTdSgyYXHZKHQDSn7omg1glpj1Ptzs4YzVwY
         3jk1EiL7HWdPhlN20xhD4s4WfbE/pperrghKyGStNNToj5Kcbnmi+1eI3CVrkVAcZvwI
         ujSQ==
X-Gm-Message-State: AOAM530Tk5+8Z2f5xciCb+v8GJKOg630BAiTMyfp0nLLVbT6BArX515O
        nRLahhv3oSX8iL0Uq0tYRdv7pskfyY+KRE8WZy8=
X-Google-Smtp-Source: ABdhPJw0g6A0nmszFFxAetUChoXdC/6v/kiYRAgOtCdT/ocV1wb8rdJy3fsQHr4Rgx5FH0s1IvAlY29IjubwNHe84O4=
X-Received: by 2002:a67:2f44:0:b0:32a:27a3:7319 with SMTP id
 v65-20020a672f44000000b0032a27a37319mr1853753vsv.49.1650216186007; Sun, 17
 Apr 2022 10:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220413164336.101390-1-eantoranz@gmail.com> <xmqq4k2wap8g.fsf@gitster.g>
 <CAOc6etYvOhqQn3icWj3Ny1m+J_60h7aiqW-gvm=dQyDLgG=6NA@mail.gmail.com>
 <xmqqbkx2ccj4.fsf@gitster.g> <CAOc6etYwMtfytbw6iRfnJnsexJhe7UydVu0OFUbWP0byS9i=MQ@mail.gmail.com>
 <CABPp-BE=H-OcvGNJKm2zTvV3jEcUV0L=6W76ctpwOewZg56FKg@mail.gmail.com> <CAOc6etb7fmO2FAv09+wHsDBwnLsBi+B-CwRarm2tfYS-aUWcfg@mail.gmail.com>
In-Reply-To: <CAOc6etb7fmO2FAv09+wHsDBwnLsBi+B-CwRarm2tfYS-aUWcfg@mail.gmail.com>
From:   Martin von Zweigbergk <martinvonz@gmail.com>
Date:   Sun, 17 Apr 2022 10:22:54 -0700
Message-ID: <CANiSa6g7ShxTXNEyJEyb==qCYNAMrNf30VkDPaydvOo0Bm+Onw@mail.gmail.com>
Subject: Re: [RFC] introducing git replay
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 17, 2022 at 5:30 AM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>
> On Sun, Apr 17, 2022 at 7:05 AM Elijah Newren <newren@gmail.com> wrote:
> >
> >
> > Replaying merges is something I've put a little thought into, so allow
> > me to provide some pointers that may help.  Merges need special
> > handling for replaying, and in my opinion, doing either just a new
> > merge of the new trees (what rebase --rebase-merges does), or just
> > reusing existing trees (what you proposed to start this thread) are
> > both suboptimal, though the former is likely to just be annoying and
> > require potentially unnecessary user refixing, whereas the latter can
> > silently discard changes or reintroduce discarded changes and could be
> > dangerous.  More details on both of these...
> >
> > An important part about merges is they may have resolved conflicts --
> > both textual (the standard conflict markers people have to resolve)
> > and semantic (e.g. one person changes the API of some function, and
> > the other branch being merged adds a caller of that function, so the
> > merge has to modify the new caller to use the new API).  We do not
> > just want to do a new merge and re-use the commit message (as rebase
> > --rebase-merges does), for two reasons: (1) the user either has to
> > re-resolve the textual conflict resolutions by hand, or use rerere
> > which requires a working tree (and we'd like replays to proceed
> > without a working tree where possible), and (2) it tosses semantic
> > merge conflict resolutions entirely.  We also do not just want to use
> > existing trees as-is (as you started with in your patch), for three
> > reasons: (1) when we move to a new base the new merge needs to include
> > the changes from the newer base, (2) the topic might have additional
> > changes added (or removed) during the "rebase" which need to be
> > reflected in the merge as well, and (3) the merge may have had
> > additional changes stuffed directly into it to solve semantic
> > conflicts which we want "ported" to the new merge commit.    So, for
> > handling merges, we should avoid both of these overly simplistic
> > mechanisms, and do something that tries to handle forward-porting
> > these conflict resolutions.  I have outlined steps to do so at
> > https://lore.kernel.org/git/CABPp-BHp+d62dCyAaJfh1cZ8xVpGyb97mZryd02aCOX=Qn=Ltw@mail.gmail.com/
> >
>
> Hey, Elijah! Thanks for taking the time and the feedback.
>
> Forget about me introducing replay as a separate command as a "real"
> proposal. My intent (and which I saw most simple to be able to show
> it) was to present the idea of an optimization (if you will) to the
> rebase mechanism under certain rather narrow conditions:
>
> git rebase --onto A B C
>
> if A^{tree} == B^{tree} that means that we could create an equivalent
> commit for the segment B..C on top of A without much hassle by reusing
> the same trees from that segment (no need to calculate new trees...and
> no need to move along the working tree as we are creating those
> commits).
>
> My impression from reading your feedback is that you have a much
> broader scope in terms of what you want to achieve.So, for the time
> being, I will work on trying to get the optimization in rebase and see
> how far I am able to move it forward.... and you are able to keep
> replay as a separate command if that is your will for the
> not-so-distant future. :-)

My (Git-compatible) VCS [1] is very relevant to this thread. It always
treats the contents of a merge commit as the diff compared to the
re-merge (auto-merged) parents. That applies to diffs (like
--remerge-diff) and rebases (what Elijah suggested in that link above)
. An important part of the solution I went with is to store
information about conflicts in the commits. Note that it's a more
high-level representation of the conflicts - not conflict *markers* -
that's stored in the commits [2]. Adding a new kind of object type is
obviously a huge step to take for Git, but perhaps you can consider it
as long as these objects are not exchanged. Also, as you have probably
noticed with your `git replay` command, this kind of rebasing without
touching the working copy or trees can get pretty fast. I didn't see
any performance numbers in your original message, but you are probably
able to rebase >1k commits per second in the git.git repo [3].

[1] https://github.com/martinvonz/jj
[2] https://github.com/martinvonz/jj/blob/main/docs/technical/conflicts.md
[3] https://github.com/martinvonz/jj/discussions/49
