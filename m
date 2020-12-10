Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711A6C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A4923C40
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgLJA2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 19:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbgLJA2k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 19:28:40 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432EAC0613D6
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 16:27:59 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a6so3099351wmc.2
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 16:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Dk+axUwC8ZQVMJfKmTCA4pA0EV29XtDCzIoPdliGG0=;
        b=S/jn3Km9Z2aYQ8LjKgZTR6QvEkPoYsEj/U7ku8j6RopFhVg1h2OjXaPBS+JddxSq96
         1xY0bQ/EtLIB+pMmrm9/2mtG72eCtBCFTPVbIdREWO6hGLXItJaP/1oa71NpsEmzjMHT
         u8cPcLu9Iq2NJ5z9o5qmxzTGef+zP1EMKBYxVwgOVDa2fOM6RVyI1UuxuNaCiNK/1dvv
         cuQC2BOgY7anaVKTmvfTFiXj3rhk66+SDgopEXZVy3iVMEb8BOi/Bsx3Ji8QSzsKHiOv
         VvDl0ShRS20J/iX0ANoJhrGa/o4qQ5ODW9GEgQNhpmBqJSb+QlEkVtGSUprUXYamG+cU
         f2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Dk+axUwC8ZQVMJfKmTCA4pA0EV29XtDCzIoPdliGG0=;
        b=RotwEMgjOJwGPZnCUj4O0VcImTbkKyQ7f7iWM73+VDewoTqjxaGKknYYC8RK9yRl5/
         B08X2265xf79YJk6WAXzW2wZkwa3WlNMOcJU/1odrL+jg7IMNdLYCEkmI5ZylnblJMMK
         bBOaMRIEPXWKPFydoFKW6qSBXsbHciD8yuOnMuJEfHMDzmYwHrlnmPxJio6WfMRXvkIy
         k3ALPGvCWhN2RziBNgtIL4+cGyyS1XuYXm6feuXDgPfVc+TGhYVwdlJjqTmu1PX4hkyV
         dXoywaJRUdyMEzo2C5o4sxrItVarcpfwK6G7qB/95HvitRvx9blIBiH4mnOaPk58MkSP
         i4bg==
X-Gm-Message-State: AOAM53123Z2Ju4PJlhFQoECqFEpOWnG5nIvVBjVM2cKooWLA8oJYwK9r
        0oFXcsdFgbB6Ouxv5nRDJQDnoEiQpHtHKOjM8Bo6RW6YaGpkYg==
X-Google-Smtp-Source: ABdhPJxo2YgUfq4XOx99diRrumeiFFJkaxigKu992EoQvp6rnyH/c9kh+H/nZ+xwmXm8/Tm1t2CKyZ/iqyb5k4ePs8A=
X-Received: by 2002:a7b:c843:: with SMTP id c3mr5301510wml.100.1607560078024;
 Wed, 09 Dec 2020 16:27:58 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2012091502000.25979@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2012091502000.25979@tvgsbejvaqbjf.bet>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 9 Dec 2020 18:27:46 -0600
Message-ID: <CAMP44s1dRKPtVr9Oazg_JR2WWMhNC_2rx7G4k3qME5FM4L4xTA@mail.gmail.com>
Subject: Re: fc/pull-merge-rebase, was Re: What's cooking in git.git (Dec
 2020, #01; Tue, 8)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 9:12 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> On Tue, 8 Dec 2020, Junio C Hamano wrote:
>
> > * fc/pull-merge-rebase (2020-12-08) 19 commits
> >  - future: pull: enable ff-only mode by default
> >  - pull: advice of future changes
> >  - pull: add pull.mode=ff-only
> >  - pull: add pull.mode
> >  - pull: trivial memory fix
> >  - test: pull-options: revert unnecessary changes
> >  - test: merge-pull-config: trivial cleanup
> >  - pull: move configurations fetches
> >  - rebase: add REBASE_DEFAULT
> >  - pull: show warning with --ff
> >  - pull: introduce --merge option
> >  - pull: trivial whitespace style fix
> >  - pull: display default warning only when non-ff
> >  - pull: move default warning
> >  - pull: trivial cleanup
> >  - pull: cleanup autostash check
> >  - pull: refactor fast-forward check
> >  - pull: improve default warning
> >  - doc: pull: explain what is a fast-forward
> >
> >  When a user does not tell "git pull" to use rebase or merge, the
> >  command gives a loud message telling a user to choose between
> >  rebase or merge but creates a merge anyway, forcing users who would
> >  want to rebase to redo the operation.  Fix this by (1) tightening
> >  the condition to give the message---there is no reason to stop or
> >  force the user to choose between rebase or merge if the history
> >  fast-forwards, and (2) failing the operation when the history does
> >  not fast-forward, instead of making a merge, in such a case.
>
> Despite what the commit message of the tip commit says, it is not "time to
> flip the switch and make ff-only the default" because it breaks our very
> own test suite left and right. See for yourself:

The commit is prefixed with "future:" it's not meant to be applied
today, but months after the previous patch, perhaps even in Git 3.0.

> Given that not even our very own test suite is well-suited to this change,
> I rather doubt that this is a safe thing to do.
>
> In the _least_, the patch series should put in the effort to show just how
> much work it is to adjust the test suite to let it pass again. This would
> also give an indication how much work we impose on our users by that
> ff-only change in behavior.

The commit is already there:

https://gitlab.com/felipec/git/-/commit/29a28ad763d3231eb1e22867dcfa56e53c5b2be6

But I did not want to overwhelm the mailing list with a mundane change
that does nothing to move forward the conversation.

Hopefully you are not implying I haven't put enough effort (since
static objects--like a patch series--can't put effort).

Cheers.

Cheers.

-- 
Felipe Contreras
