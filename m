Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4102AC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19815610F8
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 00:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241617AbhIHAmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 20:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhIHAmV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 20:42:21 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28E5C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 17:41:14 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id c79so833195oib.11
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 17:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MM2wnH4vGTDB5b+htSp6t+SDuox/PkYRTnKT9DHQXlQ=;
        b=Yr+RbuT6wPrjLcA6P+eHw2Cm47UXUK4CKAZR+NApGyo2FJhBaloPeiink4o5wJrp5c
         R0rtZax/odgLrWj2PsczBIqV+JFsNuK+B68Ngt8/lNwpKzlaTaLI0ZwtKBDwrd9O1hPF
         XkgDwnKUwJ+NAuhMfakzyIrIzKEido4XC0VE3eaFRtLRREjX10zQJJq9Vgrfo/TEWJ27
         0q0jdF/t/JzxmDqIyASLZsaoOzcDq0QMCFXREsn1XImSOYVGL1W+Zf8pr5G4kXazpx68
         kquCjZXMeCLAcrma/YaPnD6kekWpsYg7pBTMPMvHumZQE9sMYutW+lmabiz5/c93USF9
         3B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MM2wnH4vGTDB5b+htSp6t+SDuox/PkYRTnKT9DHQXlQ=;
        b=QSUTRCeNbGqo1L8gMHOHhZcQm4IvuVcfze70N/BqLzP78CEWMWJBszQqp95tbFuvmI
         gdQjei/96r0efOyaVaXktTwmnbILmRO1C2sRaNLotEVIkMFSgTye1r3aqOLsnMHSE0+1
         iapMTkTehyST4ABibI0ewXAke+g1nUleXJEBxL1+zwauu3trI1Gdar6AXDeTsqAxwwBd
         OC+3gapy1aeF15Rc2JX9qwtUWT2UpMaN2UBDe6ds/m4WB/rcY0DKVfQRgy+clZnraUj8
         l4yAeAHmMy0DbWJeuktKDqckaEJZpPTax40G4upLqNA0bgBN4xaBv/SRmhkSXSROhPD4
         xGKQ==
X-Gm-Message-State: AOAM533Wf5/HjwavZMlRZ3N+EnjgALXNk5bxK2IvRRdkafzoR0+j14cj
        j4qud1Hv6xPyGEj1lpcdEIHyNtNa0iCIBNyMkv0=
X-Google-Smtp-Source: ABdhPJwWbQ/PaYVmcZ6uToWsHAfBMsDDG0WQKxvn9xp4fHmEWc2P76tN+6QJywc01HnMcXRmxLwGrKS68yoNrigE2t8=
X-Received: by 2002:a05:6808:1787:: with SMTP id bg7mr642581oib.39.1631061674105;
 Tue, 07 Sep 2021 17:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAG2t84Uaw-Kdp+EXU8CY1QYfykFQj-hGLJnTSH8MYO8Vi_yqgA@mail.gmail.com>
 <C357A648-8B13-45C3-9388-C0C7F7D40DAE@gmail.com> <dbe7d88d-4174-e080-03df-e35d0ac6004f@gmail.com>
 <YTNA6Qo6Yj5o9NmQ@coredump.intra.peff.net> <CAG2t84Xe2XwdwdAK42bRrwAeNaB3-A+WhgSsJGOoW9-rG1S9Xg@mail.gmail.com>
 <YTNH2vMPuEW4SBMo@coredump.intra.peff.net> <CABPp-BFyR19ch71W10oJDFuRX1OHzQ3si971pMn6dPtHKxJDXQ@mail.gmail.com>
 <xmqqr1e2ejs9.fsf@gitster.g>
In-Reply-To: <xmqqr1e2ejs9.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Sep 2021 17:41:02 -0700
Message-ID: <CABPp-BEvSFWN+sGA_0SSqH3sYKtHWs5YpOJSoCGQ_=e6rpfpyg@mail.gmail.com>
Subject: Re: Aborting 'rebase main feat' removes unversioned files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 5, 2021 at 3:31 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > unpack_trees.  In fact, it traces back to (and before)
> >     fcc387db9b ("read-tree -m -u: do not overwrite or remove untracked
> > working tree files.", 2006-05-17)
> > which has additional commentary over at
> > https://lore.kernel.org/git/7v8xp1jc9h.fsf_-_@assigned-by-dhcp.cox.net/=
.
> > It appears that before this time, git happily nuked untracked files
> > and considered them expendable, in basically all cases.  However, this
> > patch continued considering them as expendable whenever opts->reset
> > was true.
>
> Thanks for digging.  Yes, the 'reset' bit was treated as the license
> to kill untracked working tree files and directories that get in the
> way in order to carry out the unpack_trees operation.
>
> > So, then...should we preserve untracked (and non-ignored) files in all
> > these cases?  This rebase case seems clear, but others might be less
> > clear....
>
> In short, the guiding principle ought to be that "checkout --force"
> and anything that is given "force" as a stronger override should be
> allowed to do whatever minimally necessary to match the end result
> in the working tree to what the command wants to show in the absense
> of these untracked paths.  And without being forced, untracked and
> unignored paths are precious and should cause commands to fail, if
> they need to be touched for the commands to complete what they are
> asked to do [*].
>
> "reset --hard HEAD" is an oddball.
>
> Na=C3=AFvely, because it is often used as the way to tell Git to "no
> matter what, match the working tree to HEAD", even though it does
> not have an explicit "--force" on the command line, it feels that it
> also should be allowed to do whatever necessary to the working tree
> files.  And historically, that is what we wanted to implement.  If
> we suddenly made it "safer", I am sure a lot of existing things will
> break.
>
> But unfortunately, "--hard" means a bit more than that in the
> context of "reset", in that we want to reset in a way that is
> different from "--mixed" (reset the index only without touching the
> working tree) and "--soft" (do not touch the index or the working
> tree), more specifically, with "--hard", we want to reset both the
> index and the working tree to match the given committish (often
> "HEAD").  From that point of view, "reset --hard" that tries to
> preserve untracked and unignored paths, and "reset --force --hard"
> that does whatever necessary to untracked and unignored paths to
> match the working tree files, when they reset the index and the
> working tree to the named committish, may have made sense.  If we
> were designing the feature without any existing users, it is no
> brainer to imagine that our design would: (1) call the three 'reset'
> modes as "both", "index-only" and "neither", instead of "hard",
> "mixed" and "soft", and (2) require "--force" to touch untracked and
> unignored paths.
>
> And I think that may be a reasonable longer-term goal, but since we
> have existing users and scripts, we cannot go there overnight without
> devising a migration path.

Sounds reasonable.  I'm presuming that `read-tree --reset` is also an
oddball, but as plumbing it's better to keep its behavior as-is, i.e.
let it nuke untracked files/directories too.  Let me know if you would
prefer otherwise.

I have a bunch of relatively small patches
(https://github.com/git/git/pull/1085, if you want a preview), which
fix most of the problems I found.  I'm going to split it up into five
patch series, the first three of which are independent and shorter
than the remaining two.
