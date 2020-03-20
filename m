Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796AFC4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 02:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385892051A
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 02:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLEhNeP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgCTC3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 22:29:25 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46166 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgCTC3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 22:29:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id 111so4583287oth.13
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 19:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B289AePn36aLL04cViJKrGyGCFWhZ1wY109dp0llbMU=;
        b=eLEhNeP51RPV/t+5l9ijPV5nUYzGhMaXYUKSrbI2D5zuawrA/QdggBouHcVu5pZboh
         a1VqKs8/CzoRbW1Hrb+ctOc1djFeZRUJ38rcSAq55bN0j3UO/fs7fMtbccX7xtfqb03i
         FXsUUIl+zWd+wxPanR4F4ftygnIHvbclJa32R4XubYwvwSw9a7QNAYrlBoAaWNHbEvSt
         d8MswdMqwXOt6Mui6LAVwxUq0inGemept0qKi2segdfR2LTvE9IFltWcbTwZPcxyRriQ
         iiRhU6JjvASJ8yk5ZlqwczsCaB4ViLAM0j21IZDkiwD8MNH84uDIkju4xbbH9pKOjfUZ
         XgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B289AePn36aLL04cViJKrGyGCFWhZ1wY109dp0llbMU=;
        b=RzpDrMVEhdbN04ZXZTh/JEpWErvkHg96iftvP5zLJrn+2dq8544Bn6FfYgOSxR0NCg
         16RiQRC0k+KzaVIKAr3vBXglpW3VOsngmJ2Sr0iHMkRkvZx0M7Lq5f/ydWXY6f+bU4Gj
         LIJiMqqgp9h7qfjzTeHwS3Nuo+0J51jUJcb5eIVEV7ZA2I8DinK6eMb3RIiUXrJp9EFa
         JOHssWVAV7gFO9qJJbpUENs2Ut++/Zel+6XH+C7UJwLw3ICy+lo+vqrznHuRtMsNeSIk
         y76Kx9Da0AVEv3h7Qx/rE7cMU/abGmGa8JkYhzep7QbmzPPzcxgMXAKMMZ9aspcWuvRH
         MAXw==
X-Gm-Message-State: ANhLgQ1noV3snTQv9VWtvOqcOO029FXOQFBrk2dODNrSfjUyhgsIaLza
        J6MYRHKdRlDHSWJkNax9Fi4GuNxOEQEIDp17aNE=
X-Google-Smtp-Source: ADFU+vvDGw+1mxS3qO/jpb0c602BNBgbNd9n61NydwNQJK7esl1KaTrIDmb4pEA7ZoUoe4EpB707D7jC6gKBvVe51iM=
X-Received: by 2002:a9d:a68:: with SMTP id 95mr4719553otg.87.1584671364123;
 Thu, 19 Mar 2020 19:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <CANri+Ey71QbWxNH+RhMfYuUSDEpYtv28ushUhK8Tt0xWUAU9iw@mail.gmail.com>
 <20200319064407.GA26408@dcvr> <20200319165149.GA4074934@coredump.intra.peff.net>
In-Reply-To: <20200319165149.GA4074934@coredump.intra.peff.net>
From:   Timothee Cour <timothee.cour2@gmail.com>
Date:   Thu, 19 Mar 2020 19:28:58 -0700
Message-ID: <CANri+EzrP0TeHTfjhsf=LZkwkEZU7fSRnnKN9NLga7CNow9F0Q@mail.gmail.com>
Subject: Re: git makes it impossible to ignore or override global gitconfig,
 needs `GITCONFIGFILE`
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@yhbt.net>, Timothee Cour <timothee.cour2@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* GIT_CONFIG doesn't work as you mentioned and as was already
mentioned in https://stackoverflow.com/questions/23400449/how-to-make-git-temporarily-ignore-gitconfig
* `HOME= `doesn't work for many reasons: it breaks other commands as
you mentioned, it breaks `~`, and it doesn't work if users' git config
is in /Users/timothee/.config//git/config ; and pointing it to an
alternate home where you'd have `newhome/.gitconfig`  would require a
lot of workarounds to update paths including `~`
*  `XDG_CONFIG_HOME= ` also doesn't work (even if users' git config is
in /Users/timothee/.config//git/config), which really seems buggy,
eg:`XDG_CONFIG_HOME= git diff HEAD^` is still reading
`/Users/timothee/.config//git/config` somehow
* GIT_CONFIG_NOGLOBAL is also not good, I want to be able to simply
point my config to some place else, not simply suppress reading git
config
* require passing commands (eg `git -c`) is not good either; it'd
require updating scripts that rely on git (this could be arbitrarily
complex, sometimes impossible if you just have a binary and no source
code access)

In contrast, what I'm suggesting is extremely simple to use, robust,
and my understanding is it shouldn't be hard to implement.
```
GITCONFIGFILE=   git diff HEAD^ # empty config
GITCONFIGFILE=/pathto/gitconfig2   git diff HEAD^ # uses specified git
config file
GITCONFIGFILE=/pathto/gitconfig2   run_some_complex_script # uses
specified git config file everywhere
```
by contrast, any approach based on passing command line flag (eg `git
-c /pathto/gitconfig2 diff HEAD^`) will make the last case impossible
to do since you'd need to update every git command inside (which could
be in a compiled binary, etc)

What i'm asking is the analog of `TIGRC_USER` for tig
(https://jonas.github.io/tig/doc/tig.1.html) and many other programs

On Thu, Mar 19, 2020 at 9:51 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Mar 19, 2020 at 06:44:07AM +0000, Eric Wong wrote:
>
> > Timothee Cour <thelastmammoth@gmail.com> wrote:
> > > git makes it impossible to ignore global gitconfig. This is
> > > essentially what's being asked here:
> > > https://stackoverflow.com/questions/23400449/how-to-make-git-temporarily-ignore-gitconfig
> > >
> > > ## proposal:
> > > add an environment variable (like for tig and other programs), eg:
> > > `GITCONFIGFILE=~/.gitconfig_temp git diff`
> > > seems like an easy change that would make it easy for users to ignore
> > > or override their gitconfig
> >
> > You can use GIT_CONFIG for that, and there's also
> > GIT_CONFIG_NOSYSTEM.  They're both documented in the
> > git-config(5) manpage.
>
> I don't think $GIT_CONFIG is what Timothee whats. It only affects the
> git-config command, not config lookup in other programs. And it
> overrides _all_ config lookup, as if "git config --file" had been used.
>
> There's no variable to suppress just the user-level gitconfig. The usual
> technique (that we use in the test scripts) is to point $HOME somewhere
> else, but that may affect other programs.
>
> I wouldn't be opposed to GIT_CONFIG_NOGLOBAL if there's a use case, but
> it sounds like the desire is to actually provide new config. That can
> also be done for specific options with "git -c". Under the hood that is
> using GIT_CONFIG_PARAMETERS in the environment; you can set it
> individually, but note that it's a little picky about quoting (the
> individual keys are shell-quoted, but it insists that there is an outer
> layer of single-quotes, even if they weren't necessary; I wouldn't be
> opposed to making it more friendly). You can see what it produces like
> this:
>
>   git -c alias.dump='!echo "$GIT_CONFIG_PARAMETERS"' dump
>
> -Peff
