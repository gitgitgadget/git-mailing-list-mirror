Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B908C433E1
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 20:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29AC420684
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 20:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="zCIQpFji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgGUUKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgGUUKt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 16:10:49 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB862C061794
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 13:10:49 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id t18so17526325ilh.2
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 13:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGg4q+/o9mA61VrTofoZQOqotlBMIZhr2/e8GgjgLhU=;
        b=zCIQpFjiro/vX8LHURXvBCQWlJQFJGE2fCJN/UOAcgm3Bq/ZnfJBbuE38W5YGsioQC
         xSv6gCbRH6SbgUDAKKoGigxcSCpFdGLqpkmI2lOEnmndjTok9WLUks5KEb4UbAkIGMGC
         8u1asNo4HVlLdXSaIvkBiJM44EbqjdgJvjoPMwaQ2427ktR5kOQKkjcobhTis5aRFcQD
         mLr23kGHL8GzZzLg0MLEWW1VXzuB4Nvj8mlGG4jzSyQD9Han/MkICG2EgYFREJrQ06TQ
         gWQLI5cJ18791HclnDwFppimft8kFy9/Uv4RF/gcLjyLFpXNg+/MoKP9VlkOyIVNXeAA
         qilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGg4q+/o9mA61VrTofoZQOqotlBMIZhr2/e8GgjgLhU=;
        b=V3Ucnavil3PMFnPFXlQiao3JoBoYS6RDKHpUCm6DZ0X370p/H6kpBh2l2FytWz7OeF
         g5Pyi0RG7bTZQgdM03E5zEii6P4CXC0qbx3mgozAWKvY1TZqeZ3UY6aiwWtMJPrpnx3I
         4xo4cELFvYxZBqkGSx7fJdkt/ohZO8tOmmiveul0jBHPVfkqmZZhZ036C5W1/TPsozBs
         iOzDyX8gAUDbIGCh6IR4F/2RbFsRcKj1VKF+6mjbwwhpKXXwQaEsujvqzIi8RpVGz3yS
         sp5GL0uwv9zhv2h3jDaK9LNsgOvsa41yg0Wc0PsSYlbkYvsTWhwq+XIb+DX/rGng2XES
         bMCQ==
X-Gm-Message-State: AOAM532Mp2oRNrPacFaA5bmKG1227F9tznqJxVWA4BH40SJoWFTebYxk
        cQEfcwMoBhLPUdaAondREYZBUhPIxyaenyglLxl0ent5
X-Google-Smtp-Source: ABdhPJzBG/40FsAGChD3JZn7CwNWTax69DcS1OkVaDVfV64gexqlxGBduldyY/Z/crG9qey9QC8b2pfz61A5U5t3oRM=
X-Received: by 2002:a05:6e02:13cd:: with SMTP id v13mr27577323ilj.15.1595362248724;
 Tue, 21 Jul 2020 13:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAP16ngo5FRjhz2DwwcMunm4KfjQQDUe-hiigRk_oc1ugwe2xew@mail.gmail.com>
In-Reply-To: <CAP16ngo5FRjhz2DwwcMunm4KfjQQDUe-hiigRk_oc1ugwe2xew@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 21 Jul 2020 13:10:37 -0700
Message-ID: <CAGyf7-GodFVdPRhPxpRqwyW2jjFUTaOT9XuXz6fsiQ--BfBPFQ@mail.gmail.com>
Subject: Re: Trying to push from my local dir to the Github repo
To:     bruce <badouglas@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 21, 2020 at 11:28 AM bruce <badouglas@gmail.com> wrote:
>
> Hi.
>
> As a test, I cloned a repo to my local machine.
>
> I then made a few changes to files.
>
> I'm now trying to push the files/repo to the new Github repo
>
> It appears I'm missing something. No matter what I'm doing, the new
> repo in Github, is populated with the files from the initial/cloned
> repo.
>
> The steps I've used
>
> mkdir foo
> cd foo
> git clone http:/github.com/foo/cat.git
>
> git remote rename origin upstream
> git remote add origin https://github.com/numinds/testapp.git
> git remote -v
> master    https://github.com/numinds/testapp.git (fetch)
> master    https://github.com/numinds/testapp.git (push)
> origin    https://github.com/numinds/testapp.git (fetch)
> origin    https://github.com/numinds/testapp.git (push)
> remote    https://github.com/numinds/testapp.git (fetch)
> remote    https://github.com/numinds/testapp.git (push)
> upstream    https://github.com/numinds/testapp.git (fetch)
> upstream    https://github.com/numinds/testapp.git (push)

You don't really need the same remote URL 4 times; it looks like you
could just remove "master", "remote" and "upstream" as they're all the
same as "origin". (It's unlikely this is causing any problem; it just
means you have 4 remote-tracking refs for each branch in
numinds/testapp.

>
> git push origin master
> Username for 'https://github.com': numinds
> Password for 'https://numinds@github.com':
> Enumerating objects: 3050, done.
> Counting objects: 100% (3050/3050), done.
> Compressing objects: 100% (2816/2816), done.
> Writing objects: 100% (3050/3050), 6.01 MiB | 15.23 MiB/s, done.
> Total 3050 (delta 120), reused 3050 (delta 120)
> remote: Resolving deltas: 100% (120/120), done.
>
> To https://github.com/numinds/testapp.git
>
>  * [new branch]      master -> master
>
> Obviously, I'm missing something in the process.

So you're explicitly pushing "master". Is that the branch you have
checked out? What does "git branch" or "git status" show? If you have
some other branch checked out but you push "master", then your changes
won't be visible.

Your example steps don't actually show anything related to making
changes. They show your remotes (excessive, but functional) and they
show a successful push. They don't show you modifying any files or
committing any files.

Perhaps you can provide some more details? Everything you've shown so
far looks fine.

Best regards,
Bryan Turner
