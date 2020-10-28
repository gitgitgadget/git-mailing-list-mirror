Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25953C4363A
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E4A20754
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bakanov-su.20150623.gappssmtp.com header.i=@bakanov-su.20150623.gappssmtp.com header.b="HuF3JSfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbgJ1Wut (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389621AbgJ1Wup (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:50:45 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CD6C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:50:42 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id z2so1119029ilh.11
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bakanov-su.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nNAo2LheIhe7rPdszxcvM+Q9k5fWw8EL5LMpQXpVyc8=;
        b=HuF3JSfnIJdIWIRLRiveel6mMs2LIwqRRzUMe/NTR0tLTKj8QEVkmvLGN9YKS0jDVD
         KxTWx0/1+4k4uhzVcP0g69v48z0tKVTjIUv6IxLB4Oqu1KXuVq9DQZjTkiKpq9Qnt66+
         PBLj58/22SFCATCXUKu7azWA3h1lnYcX5wiaflulOBePixQHZFf7NrYiQCzp31gNRdZs
         OT9SqofR6hyVkqoiFSPxJ8hc392wbD9jBoK2o1Xy80F+qF0RifrY9cfc1xBhkHmyScqx
         P6Z2+M9O2pl5Q70IkkMPm2MM4OeUSMo6u2lY5t/OqJ/KiwAvhMfdCO7xC7NUspuByNh3
         kuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNAo2LheIhe7rPdszxcvM+Q9k5fWw8EL5LMpQXpVyc8=;
        b=aLyOEbGmPGDRuNm5rorHRYZS3ETx++fO1vd/BiU7Zf+mUT8B1QNb26Hvpvk0A7UR+1
         x+qNOZDpD6lqn4+zMK6+wVG9qILQmtqOINnAcWbgwwtwC8vPRnsJ3jUOs2JZmytCLgZK
         G7cQFp2LIByDC/SotHMZkB0UZUX+RmOHh5eLZ94JSZy/Nm1VZOSI6MQ08IxVjQGhxHEW
         viXQrNkbOI0lQeZMjdYFuoJiqFwbWMEjSsxYM5jUs0TQeYLTQJMklQr7E83mxN6l+NLf
         AunFiUyAghwGkhM3FU9rph/IK10Bz/WYaOA4TBlZIqEqroE2aUKF/38++OgPsRKFQ2bH
         IdnA==
X-Gm-Message-State: AOAM533cHmrp4yut/Z4tsWWsG9dDqZPdN1V1cX35BsEfGpv9DNe1irU9
        ogXZr3ZdkpuLFLyPeynJlEEpv3Fc95cA3W4qv2hMnY6AljW1rTtbrDY=
X-Google-Smtp-Source: ABdhPJwoq1aqA4Xz3TPOW9qaiZ11a+Ve5j2XLYsFf5FmX6+PP1d3fp26VPgXxkKcBvrBvVy5J/p04AsKAksD8tF2W7U=
X-Received: by 2002:a92:540e:: with SMTP id i14mr6175453ilb.108.1603893421195;
 Wed, 28 Oct 2020 06:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAAdniQ5pRHKUU77XVmZkZ_gUgfYYFpo9=Xt2T6EgzJ3hoT0YMg@mail.gmail.com>
 <87eelifqii.fsf@yadavpratyush.com>
In-Reply-To: <87eelifqii.fsf@yadavpratyush.com>
From:   Filipp Bakanov <filipp@bakanov.su>
Date:   Wed, 28 Oct 2020 16:56:50 +0300
Message-ID: <CAAdniQ7TGuv0uFjwPOYfzo7zS0v-tEJ9kSWwB86Hjg0XstOE7A@mail.gmail.com>
Subject: Re: Proposal: "unadd" command / alias.
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for mentioning git restore.

Answering to your question, my brain filtered all the output of git
status except "modified: ..."
There are multiple reasons:
 - command named restore. I don't know what it will restore. Maybe it
will restore a clean version? Maybe it will remove all my changes? I
don't want to risk.
 - I don't know what means "unstage". I didn't run "git stage" to add
my files, why should I run git restore --staged to undo git add? If
command would be named "git unadd" and description would be "undo git
add", it would be more obvious than git restore --staged or git reset.
 I asked my friends, no one remembered how to undo git add. One said:
 " - May be it's git reset but I'm not sure, need to check before
apply". And he agreed that "git unadd" would be a more obvious.

On Wed, 28 Oct 2020 at 16:07, Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> On Tue, Oct 27 2020, Filipp Bakanov wrote:
>
> > Hi! I suggest to add "unadd" command, that will undo a git add command.
> >
> > git unadd path/to/file
> >
> > It will be an alias to:
> >
> > git reset HEAD -- path/to/file
> >
> > The motivation is that I always forget syntax and have to google each
> > time I want to undo accidentally added files. Unadd is just much
> > easier to remember and quite obvious.
>
> Why do you need to Google when `git status` tells you how to do it?
>
>     $ touch foo
>     $ git add foo
>     $ git status
>     On branch master
>     Your branch is up to date with 'origin/master'.
>
>     Changes to be committed:
>       (use "git restore --staged <file>..." to unstage)
>         new file:   foo
>
>     $ git restore --staged foo
>     $ git status
>     On branch master
>     Your branch is up to date with 'origin/master'.
>
>     Untracked files:
>       (use "git add <file>..." to include in what will be committed)
>         foo
>
>     nothing added to commit but untracked files present (use "git add" to track)
>
> --
> Regards,
> Pratyush Yadav
