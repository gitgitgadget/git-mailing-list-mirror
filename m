Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A374C55178
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 11:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE20E2192A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 11:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ1DASib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462669AbgJWLAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 07:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460750AbgJWLAE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 07:00:04 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFC2C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 04:00:04 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id p15so1271608ioh.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 04:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pW0RsnAs8yqGSyobuewS6ufhTx5ItJJx7LEsUDN60YU=;
        b=TZ1DASibrjGjT73XzFKJ2A33SCPg/iOR3yUXyveSIw4QcC4z3v4EAom8ZDFBBXKaeA
         r53fneAgqw5a5oRf29NgoYd0Vq8xUZKcRl1WZBn6ZjXDIgRVkGs5EYm5dBSiUfpVAsWg
         1kxJN/nLb9NlPQaHUKeuosGfyNkCAI9Apl+BH3/QMwmCf7syHWiXXmmI0BrD/knN9HPY
         rK+lsTXnSh0GEMQy7hfsf7MkFbxP2GZ+51tgHFQ6OQifMfv1RDbIr7eneGOAs5YFNoVf
         zKIWWzWZJ2e6Bm4G/MZTrEvrn0aGzgpqu3OQmpzD7VgDaaRG8CWZfze/HkQpnWgn9rwr
         1LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pW0RsnAs8yqGSyobuewS6ufhTx5ItJJx7LEsUDN60YU=;
        b=ETV+EvSE9MHoSQe0iasfD5EGRHJyUszOqSITm8HhBwSqBbEOmL2X3yjs8otwL+zC2k
         K0hi/LCnxomu/gitzdLHfiP9mnLG54XTtIa9ZwFwA+cYRDVUmVE4FI7/IqFCkIB8mfZ1
         TK9SS+e7D5lvxiP3ZM2MMfMHhDfMse93NNmJ592+vbkU462nPTbK4mqv+nTW7EnJ59IQ
         KuhP6MA9Gkx/lB3EXsO/KlSoI6iVTok4cXG4QedYxQ//usUbCh1XRr6vqndaZiW6tTRB
         j7BwGmoMdv9nWLNbWErrC38HfWzpCR/SXXsKZ1ML4hoyfCjhx9HXIujH0rlm3kC5K6Lc
         dK4g==
X-Gm-Message-State: AOAM5331cVVHKB1HtLWMBMthWpFkftAbyKTBc+Kok7ZxWFOP4EgqdSrr
        T4yoR4DXjr7RzJ6WaoJ2JF0/sDywpU2G+ZTGMy8=
X-Google-Smtp-Source: ABdhPJzBgHeUtl6TSA9yG0Mb0h4hGJ5dPpI0cvhfBKJaKDg+5MqBRcjIggT0RQ8ZMDBaJLDKSZJ+R7vFLQMQ11wLvlI=
X-Received: by 2002:a5d:815a:: with SMTP id f26mr1131385ioo.111.1603450803411;
 Fri, 23 Oct 2020 04:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.765.git.1603271344522.gitgitgadget@gmail.com>
 <2f71d0c4-a5de-c22b-9cbe-a9efcb3cd21d@gmail.com> <20201021162044.GB111581@nand.local>
 <xmqqr1pr73ve.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2010221047550.56@tvgsbejvaqbjf.bet>
 <cfe33eef-974d-8ff9-ebb4-d1153abd497c@gmail.com> <xmqq7drinqxv.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7drinqxv.fsf@gitster.c.googlers.com>
From:   Sangeeta NB <sangunb09@gmail.com>
Date:   Fri, 23 Oct 2020 16:29:52 +0530
Message-ID: <CAHjREB7+3QtPw6X33GEB8SiDjSfvNhb15+_rpy=McmqBdcMebQ@mail.gmail.com>
Subject: Re: [PATCH][OUTREACHY] bisect: allow `git bisect` to run from subdirectory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, phillip.wood@dunelm.org.uk,
        Sangeeta via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone,

Sorry for participating in the discussions so late. I thought I need
to have enough knowledge first before participating.

>
> If a step in the rebase sequence makes a directory disappear (or
> turns a directory into a file), and the command given by -x is in
> the directory (it is immaterial if it is given as relative or full
> pathname from the command line), hopefully the step of the rebase
> sequence that would lose the directory would error out, in order to
> prevent an untracked but not ignored file from getting clobbered.
>
> Even before speculating such an "advanced" mode of operation, do we
> know that rebasing a history that makes a directory disappear and
> reappear work?
>

Yes, I agree. We need to make some changes in `git rebase` to make it
work from the subdirectory, but that doesn't mean that we should
completely restrict it from running in the subdirectory, and the same
follows for `git bisect`.

What I think that we should allow `git bisect` from any subdirectory.
We can add some warnings in case if there's some error while bisecting
from a subdirectory in the same way by which we handle the errors in
`git rebase` and let the user decide whether he still wants to
continue bisecting from that subdirectory or abort it and run it from
the top-level directory.
