Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984B4C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A25E610A0
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 16:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbhHaQRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 12:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239862AbhHaQRP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 12:17:15 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0C5C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 09:16:20 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so23474404otg.11
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 09:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fCeVoK83p43gbO9ZCJHrhLJvsM7MtDZzZk4VRX8k1E=;
        b=HB0uSqP6rc9xWWoxdYpnvoZN2eUmaXZQ6rGeFDb5z2hdu6n5owU5s61ESTr8Gm0V+Y
         Z77xGm+eBMm4EM8AcgOo5Q0MPcrNXyJDlcHAbJl5LHEQ1mor0w9mRtEaJmlLQJaQcv73
         YM9FKdtmiEzSZdEs2fW+ZxqkoDs0AAtYfLG9BXEtG5/e6DkcV/F4yjlFxtXPfQgRGkj+
         qOI09hbpnjpygY8vOi8PEBWuv+ilVizZfVF3tnI6ETtJGhXfIQvtFHGu5UH5QZltjTUy
         IjhtENxr9bDs0iwbx2H+ZBeF5NGEMD/PA5gLjufXqezjf+n3RMOlTdCfvMPLLOVDXPaB
         joPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fCeVoK83p43gbO9ZCJHrhLJvsM7MtDZzZk4VRX8k1E=;
        b=i47/daH+qXghDFmctWB3CaVRZjVc39zSRcV6nFaAhcEmzlfK+jcZQC/DEaPzFScgez
         C/TvG//5NyLNlPnl8F+nMiMqqrUDzaJ/NqjVU8rtgz7vtftkdkEwYUi9+YItCNhr9TPH
         obTpMc54rN3nMs6w2lRWmuI+uMOwfhSVHqazU/NJiZtNBhp1YwlpX4PE+gFH8z3kWF0Z
         vJbMDVNlWED+GMkRoaB0ljgOfnOyqMtpYdrewkZ7Y5+eTSYdu/mm3zVR4nv9l4d3u5A2
         dMh7y6ZxDo8EqpTfT9EQlrmgEtheOIDyMNU/9tiiExUaTIQ45jaRWHo3lxdZhmrVrwxo
         JkpQ==
X-Gm-Message-State: AOAM5321JKerJC+DtVmbzPGs9PYReGveqt4lYOE9VfGFJIavtUw/a2ns
        HmQctFnTGRWhifybKksYPR6+lSfkGQrFmZIdPG0=
X-Google-Smtp-Source: ABdhPJxwDZP9HQwA6g0EWMKMBNC9WlspY/QhfA/7tIGQ8K4lSAaQn46Dqqo2n33adL6/yHsvHEJebF12iahsTBlHAN4=
X-Received: by 2002:a9d:7cc3:: with SMTP id r3mr25010099otn.345.1630426578988;
 Tue, 31 Aug 2021 09:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com> <665c48f7-b597-154f-6ac7-8d0471f14869@gmail.com>
In-Reply-To: <665c48f7-b597-154f-6ac7-8d0471f14869@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 31 Aug 2021 09:16:07 -0700
Message-ID: <CABPp-BGYoa9yfSEv5-XNbUqTrpgKjdNaYsPNSujNuEBfT88=FQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add a new --remerge-diff capability to show & log
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 4:05 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 31/08/21 09.26, Elijah Newren via GitGitGadget wrote:
> > Here are some patches to add a --remerge-diff capability to show & log,
> > which works by comparing merge commits to an automatic remerge (note that
> > the automatic remerge tree can contain files with conflict markers).
> >
> > Here are some example commits you can try this out on (with git show
> > --remerge-diff $COMMIT):
> >
> >   * git.git conflicted merge: 07601b5b36
> >   * git.git non-conflicted change: bf04590ecd
> >   * linux.git conflicted merge: eab3540562fb
> >   * linux.git non-conflicted change: 223cea6a4f05
> >
> <snip>...
> > In regards to the performance point above, the timing for running the
> > following command:
> >
> > time git log --min-parents=2 --max-parents=2 $DIFF_FLAG | wc -l
> >
> >
> > in linux.git (with v5.4 checked out, since my copy of linux is very out of
> > date) is as follows:
> >
> > DIFF_FLAG=--cc:            71m 31.536s
> > DIFF_FLAG=--remerge-diff:  31m  3.170s
> >
> >
> > Note that there are 62476 merges in this history. Also, output size is:
> >
> > DIFF_FLAG=--cc:            2169111 lines
> > DIFF_FLAG=--remerge-diff:  2458020 lines
> >
>
> Which repo did you mean by linux.git? Kernel developers often work
> against Linus' mainline tree [1], while end-users (including myself)
> prefer stable tree (which is mainline + stable release branches and
> tags) [2].
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git

$ git remote -v
origin git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
(fetch)
origin git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
(push)
$ git log -1 origin/master
commit 11a48a5a18c63fd7621bb050228cebf13566e4d8 (tag: v5.6-rc2,
origin/master, origin/HEAD, master)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Feb 16 13:16:59 2020 -0800

    Linux 5.6-rc2
$ git log -1 HEAD
commit 219d54332a09e8d8741c1e1982f5eae56099de85 (HEAD, tag: v5.4)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Nov 24 16:32:01 2019 -0800

    Linux 5.4
