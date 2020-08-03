Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1633DC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 15:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B5920781
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 15:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irOfqEZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgHCPgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgHCPgk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 11:36:40 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805A9C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 08:36:40 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id l10so719408oon.4
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 08:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6dS8YK/O7wjUZEUP6XSp8hErSewfQJA3i9vGHZVo7g=;
        b=irOfqEZM6/d+wLO45HVgz12M+ZcjRMQES/VCNgtZPv05tUsWewRWWKfC5cpYdXYqTF
         DxIGxnXoXzG5u8oD1xiie4DSPvYarjA+Vj7FvMQwlkVysyohcynEABJSYeaVGnh6B3Vy
         GCMvxLTqOiVqIKbdTj2CRLLh4aKdb+tCoe3OkCQNx+0j1IHPVGrZaSctCkwrrz6zTyp9
         O9Qds/ppTtDjN9Q1383QDktULiKnEvIlrcTPOVx/gdeDmI/m5sLbTl9wGfa7R/noR/gZ
         dlH3YYbKaYjFuTchTfg4DlOVngcXY2U1fnT+R7quohrQ//0AYUOqggIv9CmV5oY6LaAH
         rCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6dS8YK/O7wjUZEUP6XSp8hErSewfQJA3i9vGHZVo7g=;
        b=LiKjN0eyXi+tzI0wDgyBRBYt6+xwHdIC+Ytf1hyU0tvkGZfxJIPism6ct4DV8VUeC4
         +HG/Ab7k8f8Ebv3d8f69eYeNPS4zCIK55zr6dH6Gqi58DYA5Wi3ewOx6UbhSSd1v+K2+
         HGZGA+l/gTgYj24WJLkVlNNbxn1/qudw8t5wsoaVJ8NOD8CQi3yVftGyq4hWPtLPVi+8
         hivliF+cFYAkfPjDWTP9hYkeG8ZZ/gTm6+TlPtAG90pcghmayC5N7neGqqXYb5vPFvrb
         VZKkPqj7/N3h3dhn7Uf6HJoZN9SxDRm1k6rMqA43E0nzqwTKcGyzaNytujEBOuLcJ+NH
         48Wg==
X-Gm-Message-State: AOAM531DkShHg6QIeGm7rzMOb3uIuXyD42CDH63/nCOjekywvcMoB2rP
        ZP4JRwsesd36oQgm07Dty13yfvAodit2GYs+pPM=
X-Google-Smtp-Source: ABdhPJwNo/AjuGOInpsla0+/hNArGBDSJov1U/LQmAWi/vept2qfPOtoQaCLwPeijLjrHbDwUZCqcglAgkaHznYGagg=
X-Received: by 2002:a4a:98ed:: with SMTP id b42mr9970005ooj.32.1596468999670;
 Mon, 03 Aug 2020 08:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
 <83a50f7e0bbfd19cffc5cffb9f17484e86443d0a.1596349986.git.gitgitgadget@gmail.com>
 <xmqq4kpkstwk.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4kpkstwk.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 3 Aug 2020 08:36:28 -0700
Message-ID: <CABPp-BHNebxZK1-tXx0HMmPDuRoj=_XWG=pVJ2HCvTkttvA4oQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] t6038: fix test with obviously incorrect expectations
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 2, 2020 at 12:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > t6038.11, 'cherry-pick patch from after text=auto' was set up so that on
> > a branch with no .gitattributes file, you cherry-picked a patch from a
> > branch that had a .gitattributes file (containing '* text=auto').
> > Further, the two branches had a file which differed only in line
> > endings.  In this situation, correct behavior is not well defined:
> > should the .gitattributes file affect the merge or not?
>
> I'd say that it is probably more intuitive to expect whatever
> attributes set on the currently checked out and receiving the
> cherry-picked change would take effect, but I do agree with you that
> this is not well defined.

Turns out this question is kind of important since merge-ort does not
naturally get to take advantage of the existing infrastructure for
attribute handling; I have to implement some stuff to trick it into
using it, and the stuff I implement makes it glaringly obvious what
choice is being made.  Your answer here doesn't really help me since
it's not even applicable in some cases.  Anyway, I'll list a bunch of
questions I'm facing with it, but if you want you can skip to the next
quoted block of text and ignore this topic until I post the relevant
patches for merge-ort, if you want.

My questions about attribute handling in merges and which version(s)
of .gitattributes should be used for three-way content merges:

What if you don't have any version checked out, and are doing a merge
in a bare-repo or are just redoing a merge (on some other branch)
without touching the working directory or index just so you can view
that other merge?  In that case, your answer doesn't even apply and I
need to implement something else.

Also, what if you were doing a merge in a dirty working tree, where
your .gitattributes was locally modified?  Should the local
.gitattributes file override the .gitattributes file recorded in
history for how those versions are merged (which seems somewhat
suggested by your answer)?  Even if it makes the merge not
reproducible by others?

Are we okay with merging one way resulting in no conflicts while
merges the other way (with the order of parents reversed) yielding
conflicts due to use of different .gitattributes files?  Also, there
can be differences in what the user sees in a single merge while
resolving, due to 'git checkout -m $CONFLICTED_PATH'.  This happens in
a few cases...explored in the next two paragraphs:

What if the first parent had a .gitattributes file and the merge base
did too (with same contents), but the second parent didn't?  Do we use
the .gitattributes from before the merge, despite the fact that the
merge is going to delete the .gitattributes?  If there are any
conflicts and the users messes up a single file and needs to redo it,
then a 'git checkout -m $CONFLICTED_PATH' later might give them a
different result.

Assuming there is no .gitattributes file in the first parent and none
locally before merging, but the second parent did have a
.gitattributes file, if we only pay attention to the .gitattributes
file from the local working directory or the first parent, then we
again run into a case where the merge may produce a different result
than a subsequent 'git checkout -m $CONFLICTED_PATH'.

What if the .gitattributes file itself needed to be merged?  If it
merges cleanly, should we use that clean merged version of
.gitattributes to define the settings for all three-way content merges
in the remainder of the merge?  If it doesn't merge cleanly...should
we just pick the one from the first parent?  From the second?  Throw a
merge conflict stating that .gitattributes can't be merged and thus we
don't know how to do content merging on any other conflicted path?
(And what if the .gitattributes file only cleanly merges depending on
if it's merged with one of the two .gitattributes settings from one of
its parents?)

> I think "changing attributes in the
> middle may produce unexpected/undefined results---validate it when
> you cross such a boundary" is a prudent advice we should give to the
> users.

Makes sense; especially given all the cases above.

> Would it make more sense not to test ill defined behaviour at all
> instead, I wonder?

I'd be happy to toss the test and punt this conversation until I post
the relevant patches for merge-ort, but we might not be kicking the
can all that far down the road...
