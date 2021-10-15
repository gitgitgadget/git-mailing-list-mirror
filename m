Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70711C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F2660F70
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbhJOJH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbhJOJHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:07:25 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8345C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:05:19 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t11so5983537plq.11
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8hk/km4dcduTOX/IAgB63Z6+vMers5bfdYbYxJRUPo=;
        b=TlklrYfnWE3CAQYvlPeTk6fKR/7/A76E/YkaYoF8cE75ArlXntoa/y46TJt74d8d+E
         VDcRxq/oRQ19hG3VEmu4Sbx1bhS5HBowRYMFMFMN/LSZ5LF2Yb5yP2E+uSCvL2MDlWvx
         V0BQQBJer5o6t65Ow1//krI7N6r79/R92qvCgCwXKLqdh+QSIpT6ai77+D1NRQXvf51b
         Be4WMFXQNHORMbYY8f/q6D8230KbgoLBvr8P/OOCrWgP72Ye1EphANS+52vc8wIA4Ws9
         HiRsj4Bu8krX+a8wJNt/f0OoDrcr11HqmMLed/NjVzgfWdbybvTy6LRwna/7Ef9vonfC
         hSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8hk/km4dcduTOX/IAgB63Z6+vMers5bfdYbYxJRUPo=;
        b=sZkBrhNce0iH8FE43VLW+/wqhVJxlJocLYr4QOJ9aAnHawriOkYAEy2ftV33mJCh+U
         Cnf1o34i8klq6tDAlxhvMEwpNnIYBkP1cHsGwDPJ/vnfl9jQMkLgZZyGco6UzR7Y8qve
         /T7FnvmyQCRgtSG5Le5eg5RpZyKuDelHeSZ3pmc5tr1UGg8wUoC7sXhFImqxAOKQAcB5
         2A8OJKfrxwUoXD8whVQsQ/TygjO6LJYLTKULlmnnZdSuUzBjthWO2yCstABmGQWypeGb
         6LdwDSpTdNqHlyf2zulSTNIMQGQ5XHR9nse5gBsXRXeLZV6Pc0LYnkWRXlidNHUWZfNx
         t8fg==
X-Gm-Message-State: AOAM532C9kbl9J4hMWw1CtesMqCi4zbQK0DPrXwasQFjeCy0FpzOyZW0
        1Vkl9W0s2v+CpNXbhy9B9meglgvwtD01tTaPCL9vxENWv1PzBw==
X-Google-Smtp-Source: ABdhPJwPuqGh3XYjgQ40ymNMUAhto9qfctiYs3zLzVH9v/8nmV5z5+bUMKedurmwERS9CLzeFMiA4rXpvW1kGRy3Ykw=
X-Received: by 2002:a17:90a:530f:: with SMTP id x15mr1039556pjh.156.1634288718543;
 Fri, 15 Oct 2021 02:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAA1vfca+kPSsitsZad-bmrd+o1ay60NXZrH2zGLpwN69Px-rtw@mail.gmail.com>
In-Reply-To: <CAA1vfca+kPSsitsZad-bmrd+o1ay60NXZrH2zGLpwN69Px-rtw@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 15 Oct 2021 02:05:07 -0700
Message-ID: <CAGyf7-HZirxc0qoD1u9a3jx4egsjq=-Mdy_HCf2o-oWBrdUX+A@mail.gmail.com>
Subject: Re: Git submodule update remote keeps using previous default branch
To:     Sjoerd Langkemper <sjoerd-2021@linuxonly.nl>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 15, 2021 at 1:35 AM Sjoerd Langkemper
<sjoerd-2021@linuxonly.nl> wrote:
>
> I am having trouble with git 2.33.1 checking out the wrong branch for
> submodules for which the default branch has changed. `git submodule
> update --remote` seems to remember the branch name to retrieve, while
> I expect it to use the remote HEAD every time. This causes unexpected
> behaviour when the remote HEAD starts pointing to another branch.
>
> I create a new git project and add a submodule, with `git submodule
> add git@host:foo/testproject.git`.
>
> This checks out the default branch, `master` in this case. `git remote
> show origin` also shows that `master` is the HEAD branch. Running `git
> submodule update --remote` updates the submodule to the latest master.
>
> Now I change the default branch on the remote (using Gitlab's web
> interface) to `newmaster`.
>
> `git remote show origin` now correctly shows `newmaster` as the
> remote's HEAD branch. However, running `git submodule update --remote`
> still updates the submodule to the latest `master` branch, while I
> expect it to update to the lastest `newmaster` branch.

I suspect this is going to be the same answer I gave on the last
thread about submodules[1]. Submodules in Git store the _commit ID_
they point to in the tree, but they do not store a _ref name_, nor do
they have some indicator for "It was the default branch". They choose
a ref by (essentially) looping over the refs from the remote (which
are always sent in alphabetical order) and choosing the first one with
a matching SHA. If your "newmaster" is alphabetically after "master",
and "master" still exists, and both refs point to the same commit (or
only "master" points to it), I suspect your submodule is going to
choose that.

[1] https://lore.kernel.org/git/CAGyf7-FAHJOb6iQYqYNt0WSk+zUHUJ_FjrU1xis1bBQd9Z6KPQ@mail.gmail.com/

>
> There's no branch specified in .gitmodules or .git/config. I am not
> sure how git remembers the branch. When switching `testproject` to
> `newmaster` manually and then running `git submodule update --remote`,
> it is reset to `master` again.
>
> Is this a bug? Can I change the branch somehow?

If you updated the submodule to reference a commit that was on
"newmaster" and not present on "master", I think it'd change.

>
> Regards,
>
> Sjoerd Langkemper
