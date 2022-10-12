Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041DDC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 00:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJLAOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 20:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJLAOD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 20:14:03 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C0160488
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 17:14:01 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-360871745b0so81915917b3.3
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 17:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AkbRYWeIzaj6e/izI4E+2jPNcWP4kFILCT7HSYGcfbY=;
        b=oHXemAlWQWRCLOqRQog2E/ygkxjQ7XYXlDSzCfTVm3CkEOJxOGi5ihnOf2bis6uIRE
         lORnpRBzk1+LrKzMmEvux5R8WFUAlL8y6u2MrvNvIVYRm6gxUmxfsfMW2VVIFOisiu3Q
         eERJKGxKwFnHhy6P6BgKURiU/lZoEKJWjGpRDp+J562V0ZJEmDRUJN4JNi3FW+hTOs2X
         WOOH0zFH0V8XUBX1N8ZWT6lNCZpbMuzJ/vkETuedPaAUXiTz6UDQ1qW5UpnFe2yZJqRr
         nMhpjXfO+EyidQjzC2Pp0tHBcVD2wQx2sLK63FUFUnYpV5Mr3rhJaHZRaklqSiN7jDPA
         Osmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkbRYWeIzaj6e/izI4E+2jPNcWP4kFILCT7HSYGcfbY=;
        b=dzZl2IBWVfF7MiyEu29xga/al5jKt/cfj3OU/RUvvA3uUJDCw/DQYv1Z/XpdmTPRrg
         PAbcx/qinAQ3Ty7Hb5o00ZvLRUW6O4duWOIedh6SOIKen5sBMvkr6Auv0oiDePhfU9xd
         Tq9uIu0jjjh/4tcb+rx8ybgFvZ0GgHgN7jxmGTcYj3bPPVESS6fGaE+GLxdmoR70zdqi
         F8msKks86bACxhfJWdp5q8JTCpKrDDzk+/w3QKjSAeSQalt4vqmmtX70AxnCByM5jxKV
         ovK4tIfjyhNJ8m/Z3pE/CrZo8s1OIgN69CLN+NG26uEKSPwfrd35U9PfKNdrBBbmy0XN
         HbEA==
X-Gm-Message-State: ACrzQf2dyh6/5jiO0DasUGRvkKoaqVDcLZ3B07oyfsG1wCizEg08B4x5
        RDIweDtma2SibQ9DgcfS/DyYLoUptNKO3OVyTrA=
X-Google-Smtp-Source: AMsMyM5cvephc9LoCuChJtuDbEu1I2g8D6Qb+NuF+dZudXpDGy+Wob0w87UfAh6bhaF5r8suwBT8M0k6bv5Dwkp/4GU=
X-Received: by 2002:a0d:c0c1:0:b0:348:fec3:7aeb with SMTP id
 b184-20020a0dc0c1000000b00348fec37aebmr23848491ywd.145.1665533640986; Tue, 11
 Oct 2022 17:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <CA+P7+xrnAXceHJbBYV8Z9Ay9xbkzpiX3P0wXLwN7jfnifW2OBQ@mail.gmail.com>
 <kl6lzgeblap2.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CA+P7+xq3NGGTq2U2Di9ZTBO3buqeEMb2smC=v78V9Subt2cDMw@mail.gmail.com> <kl6lilkq0zpr.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lilkq0zpr.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 11 Oct 2022 17:13:50 -0700
Message-ID: <CA+P7+xqf_Q35C0VT8A-zCRf46zSbXHhH5EhTo2vLvTJ9B6jyow@mail.gmail.com>
Subject: Re: issue with submodules using origin remote unexpectadly
To:     Glen Choo <chooglen@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2022 at 3:20 PM Glen Choo <chooglen@google.com> wrote:
>
> Jacob Keller <jacob.keller@gmail.com> writes:
>
> > On Tue, Oct 4, 2022 at 11:12 AM Glen Choo <chooglen@google.com> wrote:
> >>
> >> Hi Jacob! Thanks for the report!
> >>
> >
> > Thanks for responding!
>
> :)
>
> >> Or, if you could include a reproduction script, that would be really
> >> helpful :)
> >>
> >
> > I'm not sure how to do this, because it is only an intermittent
> > failure. I suspect it has to do with when the submodule actually needs
> > to update.
> >
> > Perhaps I can come up with something though. If I can, I'll send it as
> > a new test.
>
> That would be greatly appreciated, thanks!
>
> If you find code pointers useful,
>
> - builtin/submodule--helper.c:fetch_in_submodule() contains the logic
>   for fetching during "git submodule update"
>
> - submodule.c:fetch_submodules() contains the logic for fetching during
>   "git fetch --recurse-submodules" (which is invoked by "git pull
>   --recurse-submodules").
>

I was able to get a test highlighting the failure. It shows the case
of a single remote working but adding another remote causes it to fail
as it falls back to the 'origin'.

>
> >> >
> >> > remote: Enumerating objects: 210, done.
> >> > remote: Counting objects: 100% (207/207), done.
> >> > remote: Compressing objects: 100% (54/54), done.
> >> > remote: Total 210 (delta 123), reused 197 (delta 119), pack-reused 3
> >> > Receiving objects: 100% (210/210), 107.20 KiB | 4.29 MiB/s, done.
> >> > Resolving deltas: 100% (123/123), completed with 48 local objects.
> >> > From <redacted>
> >> > ...
> >> > Fetching submodule submodule
> >> > From <redacted>
> >> >    85e0da7533d9..80cc886f1187  <redacted>
> >> > Fetching submodule submodule2
> >> > fatal: 'origin' does not appear to be a git repository
> >> > fatal: Could not read from remote repository.
> >> >
> >> > Please make sure you have the correct access rights
> >> > and the repository exists.
> >> > Errors during submodule fetch:
> >> >         submodule2
> >>
> >> I assume this is `git fetch` running in the superproject?
> >>
> >
> > Its git pull --rebase, but I suppose as part of this it will run
> > something equivalent to git fetch?
>
> Unfortunately, this doesn't narrow it down much because "git pull
> --recurse-submodules" runs _both_ "git fetch --recurse-submodules" _and_
> "git submodule update [--rebase]" ;) Without more context, it's not
> clear which of those is failing.
>

It's definitely "git fetch --recurse-submodules", the new test should show this.

> >> When fetching with `git fetch`, submodules are fetched without
> >> specifying the remote name, which means Git guesses which remote you
> >> want to fetch from, which is documented at
> >> https://git-scm.com/docs/git-fetch. I believe (I haven't reread this
> >> very closely) this is, in order:
> >>
> >> - The remote of your branch, i.e. the value of the config value
> >>   `branch.<name>.remote`
> >
> > So basically if its checked out to a branch it will fetch from the
> > remote of that branch, but...
> >
> >> - origin
> >>
> >
> > It defaults to origin, so if you have the usual "checked out as a
> > detached head" style of submodule, it can't find the remote branch.
>
> Yes, this sounds about right. I was quite certain that we only default
> to "origin", but I observe that "git fetch" doesn't fail if there is
> only one remote and it is not named "origin". Perhaps I'm mistaken, or I
> simply couldn't track down that logic.
>

We definitely default to the single/lone remote, I have two tests, one
which shows the single remote working and another which shows the
additional remote causing the failure.

> >> But... I'll mention another wrinkle for completeness' sake (though I
> >> don't think it applies to you). If you fetch using `git submodule
> >> update`, the submodule is fetched using a _named_ remote, specifically:
> >>
> >> - If the superproject has a branch checked out, it uses the name of the
> >>   superproject branch's remote.
> >
> > Right, so that explains why I can re-run git submodule update after a
> > git pull --rebase and it works.
> >
> > In theory wouldn't it make more sense to use the remote based on the
> > URL of the .gitmodules file?
>
> Ah, yes that's one possibility we (the folks working on an improved
> Submodules UX) have considered. Another would be to teach submodules to
> actually use branches correctly and to use the remotes of the branches.
>

Yes, if we can have it checkout on a branch and just rewind that
branch to match the expected commit instead of having it in a detached
state, things would be much easier. I recall work being done on this
years ago, but it is quite a thorny problem.

> In general, the project tries not to respect config coming directly from
> .gitmodules (c.f. [1]), but I agree that there's a lot of room for
> improvement.
>

Right. I think I'd rather go with a config option inside the
.git/config [submodule] section. I don't think gitmodules itself needs
to know this, just that the parent project could be informed of what
remote to default to when fetching inside the submodule. That or
somehow unify the git submodule update code with the recursive
fetching?

> [1] https://lore.kernel.org/git/xmqq35bze3rr.fsf@gitster.g
>
> >> - If the superproject does not have a branch checked out, it uses
> >>   "origin".
> >>
> >
> > I suppose one option would be to make this configurable. I started
> > using "upstream" as the default remote name for most of my
> > repositories when I began working with forks a lot more.
>
> My hope is that the work I mentioned earlier makes this code obsolete
> and nobody ever has to configure this ;)
>

Yea. I definitely like the idea of using branches instead of a
detached head state.

I think for now I can avoid this by just disabling recursive fetch in
my config, which at least gets around the problem well enough.

Another alternative I thought was maybe "try to fetch every remote"
instead of trying to fetch only a single remote?

> >
> >> >
> >> > Thanks,
> >> > Jake
