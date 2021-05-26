Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C778C47089
	for <git@archiver.kernel.org>; Wed, 26 May 2021 14:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6770561028
	for <git@archiver.kernel.org>; Wed, 26 May 2021 14:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbhEZObu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 10:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbhEZObs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 10:31:48 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C824C06175F
        for <git@vger.kernel.org>; Wed, 26 May 2021 07:30:15 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso1152310otl.13
        for <git@vger.kernel.org>; Wed, 26 May 2021 07:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J+noK7YLwPpcgTmUEsynP0vJCCetZ1ndIJrv1Wz3syU=;
        b=BNZGCIFxL12q4kr+fU5p8EBL25SJZL5VVdr03tA2Db1ybab/A2/uiqX5GIFank+/UC
         SYs2q4mu5xQ9VFvGxRSpBBFbfYyrYqB4kdk9Gy20psNV5NymeMuznnUbA7TKdYe/2g6N
         rHl85l7hhIoO50qP67MxCT2bzwUoEeTCl6GtfRHUOjJI3f12prvK/3eOG9fUJ8dE+Nhe
         OH8iNhfIEOZINdHwVZOlGcE6w46r5d+qVKuby8tj3DR3RYC4g/MmNHHhYr10BXcnwNGA
         hi5vAOtCFGGSR7CYLs/Eiks1UIuwZe4Imv5HWGSbp98jda7tmD+cpnuIZXCife0OqT1R
         7mJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J+noK7YLwPpcgTmUEsynP0vJCCetZ1ndIJrv1Wz3syU=;
        b=jd5dav0nUEC3xq+gva02hq8Kk6UllAlR3NyEn0k8bDty5eDLvCAAO9m8NFg81gsrwz
         bou/Mx5nIPd+CT3zo3xXIJssLSrdNah/q/TzBL5Gy7b16RBjpBcHGp4WOh05gYFkyd0A
         e3IFjS6sRqtNLH9fcjqQcIIttNpOYyAqWVlme3rBTfSeVRbvcgh9qu81zr++qiHptH2d
         Waqy/Br1yKlPwtEug04T4TmcO7WMiJGZ+wqk4hsImS3GaIQZH7MWjkU5WIbHe7wqfgm8
         5duB5/xpjLH4XZSwtaBoCEVEWLlQaP2Nwa2xu3buNts/Xx1UbYAgfLyIGGodPXGY7PHs
         c/Ng==
X-Gm-Message-State: AOAM532z1Z5D5NMlhaokRAPAgSSTOcm2WH3XPvW3P25Vu8Nao4BGAPVs
        Z0sUZKG55w7dMHQZULnaGRBd9OOY5S47dQn080R5lOJZ3xA=
X-Google-Smtp-Source: ABdhPJwAPYVLfO99CGAnGswiTxehcsT3yvEF5ypFA7kKBQ89q6zeNKhhTh0GT10baOedQuEVUxi6tA6fiR7SqXgBJx8=
X-Received: by 2002:a9d:67c5:: with SMTP id c5mr2533256otn.162.1622039414925;
 Wed, 26 May 2021 07:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <79e26cee-daed-d52b-76d7-692f5cb2e20a@gmail.com>
In-Reply-To: <79e26cee-daed-d52b-76d7-692f5cb2e20a@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 26 May 2021 07:30:04 -0700
Message-ID: <CABPp-BHq+=Q6EDNOHJGoUvJsezn=hbQORT=0NRghREf=cnwCYQ@mail.gmail.com>
Subject: Re: git status when merging non-conflicted 3-way merge says "All
 conflicts fixed"
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 25, 2021 at 1:22 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Hi,
>
> Supposed that we have following commit graph:
>
> ----A----B----C----D <- master
>                \
>                 ----E <- e
>
> When we merge e branch by `git merge e`, obviously we will do 3-way
> merge. Assumed that the merge doesn't conflict, Git will fire up
> editor to edit `COMMIT_EDITMSG` for us to enter merge commit
> message. Then we abort the commit by either delete all the lines
> there, or comment all of them.
>
> But when we check status by `git status`, Git says:
>
> > On branch master
> > All conflicts fixed but you are still merging.
> >   (use "git commit" to conclude merge)
>
> That message above is misleading, because we know that our merge
> doesn't conflict (3-way merge applied successfully without conflict).
> However, it makes sense only when we have resolved all conflicts
> on the conflicted merge.

Once upon a time, that message would have always been right.  Then a
--no-commit option was introduced to git merge, and editing of commit
messages for merges was also added.  As you note, both of those can
yield cases where the message is misleading/surprising.

> So for non-conflicted merge, we can say instead:
>
> > On branch <branch>
> > You are still merging, and the merge applied without any conflicts.
> >   (use "git commit" to conclude merge)

At the time this message is printed, there is no way for us to know
whether there had been conflicts.  We'd have to record that
information somewhere (probably the index, though introducing another
index format just for this seems like a really high lift for such a
small thing, and may conflict with other efforts to extend the index
format, such as the sparse-index work), OR re-do the merge when the
user runs status just to find out whether there had been conflicts
(which seems like overkill, and would require you to know which merge
backend had been used and with which flags so you could re-check with
the same one; further, three of the merge backends -- recursive,
resolve, and octopus -- all update the working tree and index and thus
could not be used for a case like this).

Seems like opening a really big can of worms.
