Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA2EC4CEC0
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 17:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C3420736
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 17:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vgf1G+F9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbgCKRQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:16:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37227 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbgCKRQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 13:16:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id b3so2832982otp.4
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 10:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+PpGku5YRI3F34qr431hh0dxZJoUl8418y3q5G0Bpo=;
        b=Vgf1G+F94pMHzBhc9L/nko7jYxz/e4dsSOirdUk0eqYN5D05UeS7bhVd0kL0KNAjYO
         yk4OUyRMOHNPkUAMceQbRVSC3x7sx6DxgR/RsLK2vKmr8NvTeKqwLSCEQ0sPaKsdFBkF
         lpIUnhk0AVc2slnc64AqRUt+SaUpSl7eymQQcT0J1mmvOKVpRaKFWE/deMXZQjk2xL2v
         AHm4yaPXRkfJKAKycgeycgcV55xp54S2vXz3cee9v0ELHM7w40oZZ94doac1FkCofwbO
         osYbO6Hl6lFiM0VsbDR1IH96LfOPV/kBx/88xBI6zMD8nyFr5oIGIsGy9n/cqdvCX19Z
         2uzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+PpGku5YRI3F34qr431hh0dxZJoUl8418y3q5G0Bpo=;
        b=H9x5w2m/JwdE3+GmppBTQPzJ3pmEZZq1/joAs9Dxu1xLc/psgjjtnYxiQzcBBQWR+7
         WIFix+mxPiDiqYlIr1M+srrAe4SXOzeDuI+TslUlsPUcHjbBu1CWpAUrW1sWfrcPjbzz
         imTeIOHVsxcs9eAgpYtGT2HCLlCEcYn7QCHtDJaHLcCwjtWczo+verMhzXuUNjVrsws+
         3UFLlbFtp5WUrWIG1SmmARMlKNtxvhkUb/sQjFq2CZR78qYe7p+/ehpAn6/CGQzgDvCf
         HFZ54UhYwoSMYlNfkzgbhAXstZmAujtHsJMQcvWj5OwSWaBtV5KzvNrpoiE932AVjwxz
         x5LA==
X-Gm-Message-State: ANhLgQ04bGgjHDTZ51oHgelYvIbYehYxwkRHPBfBRvQ3Y/1HhcKjak0F
        grnMo8iUR+9jpH3I6+P0h9nhpgm6WDfbxF/ziM8=
X-Google-Smtp-Source: ADFU+vuSRsF2pXHxgg28IfWJBbr1qo/eLxDZ5gSt2yCA7VgMTYmoD/nqcVIAZ+vhhpZqEkMlSy9RCKWQfU6/yz8AkWY=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr3207963otl.162.1583946985705;
 Wed, 11 Mar 2020 10:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.722.git.git.1583903621.gitgitgadget@gmail.com>
 <pull.722.v2.git.git.1583940623.gitgitgadget@gmail.com> <84b89d7843527d7b1f3e00f122dc1e82f1ced381.1583940623.git.gitgitgadget@gmail.com>
 <20200311163454.GC27893@coredump.intra.peff.net>
In-Reply-To: <20200311163454.GC27893@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Mar 2020 10:16:22 -0700
Message-ID: <CABPp-BFtspDhSherYyhH-Aw=oPLzCiGfbMUiLPB0n1rnzV3k0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sequencer: clear state upon dropping a
 become-empty commit
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 11, 2020 at 9:34 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Mar 11, 2020 at 03:30:22PM +0000, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > In commit e98c4269c8 ("rebase (interactive-backend): fix handling of
> > commits that become empty", 2020-02-15), the merge backend was changed
> > to drop commits that did not start empty but became so after being
> > applied (because their changes were a subset of what was already
> > upstream).  This new code path did not need to go through the process of
> > creating a commit, since we were dropping the commit instead.
> > Unfortunately, this also means we bypassed the clearing of the
> > CHERRY_PICK_HEAD and MERGE_MSG files, which if there were no further
> > commits to cherry-pick would mean that the rebase would end but assume
> > there was still an operation in progress.  Ensure that we clear such
> > state files when we decide to drop the commit.
>
> Thanks, I can confirm this fixes my case (which is not surprising, as it
> is the same as your new test). The patch looks good. Two minor comments
> below, but I doubt there is anything to act on.
>
> > diff --git a/sequencer.c b/sequencer.c
> > index 7477b15422a..e528225e787 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -1957,6 +1957,8 @@ static int do_pick_commit(struct repository *r,
> >               flags |= ALLOW_EMPTY;
> >       } else if (allow == 2) {
> >               drop_commit = 1;
> > +             unlink(git_path_cherry_pick_head(r));
> > +             unlink(git_path_merge_msg(r));
> >               fprintf(stderr,
> >                       _("dropping %s %s -- patch contents already upstream\n"),
> >                       oid_to_hex(&commit->object.oid), msg.subject);
>
> It feels like the set of paths to be cleaned up would probably exist
> elsewhere in a helper function for cleaning up real cherry-picks. But
> I'll defer to your expertise there, as I don't know the sequencer code
> very well.

Yeah, I was looking for something like that but instead found the
unlink() directives for cleaning up various state files scattered
throughout the code.  I think sequencer.c is in need of some cleaning
up; the slow transition from "do what shell does, now work both with
an external shell and some pieces built in, now move slightly more
towards being built-in" seems to have left a lot of artifacts around
and made it a bit unwieldy.

As another anecdote along these lines, I really wanted to do my demo
of an in-memory rebase with the existing builtin/rebase.c and
sequencer.c but it was too much effort even for just a demo to rip out
the unwanted parts, so I did my in-memory rebase demo in a completely
different file (https://github.com/newren/git/blob/git-merge-2020-demo/builtin/fast-rebase.c)

I'm not sure deferring to my expertise with sequencer.c makes sense,
since you have about twice as many commits to sequencer.c as me.  But
I was deferring to Phillip and he commented on my v1 and seemed happy
(other than my missing handling of MERGE_MSG).

> > +test_expect_success 'rebase --merge does not leave state laying around' '
> > +     git checkout -B testing localmods~2 &&
> > +     git rebase --merge upstream &&
> > +
> > +     test_path_is_missing .git/CHERRY_PICK_HEAD &&
> > +     test_path_is_missing .git/MERGE_MSG
> > +'
>
> This could check the output of git-status to avoid poking around in the
> .git directory itself. But I doubt that the exact filenames are going to
> change, and parsing the output of status is its own problem (I don't
> think we give this "state" info in a machine-readable way).

Yeah, it's not clear to me what's best either.  When I was testing my
changes locally I was checking status output.  However, after creating
the fix and deciding to add a regression test, I switched to checking
for the existence of those files basically for the reasons you
mention, despite knowing I'm only testing for certain state files
rather than testing that git in general doesn't think it's still in
the middle of some operation.
