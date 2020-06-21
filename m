Return-Path: <SRS0=gxdb=AC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9427DC433E0
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 16:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65BAF23BC3
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 16:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="jLmzygus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgFUQFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Jun 2020 12:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbgFUQFR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jun 2020 12:05:17 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B78C061794
        for <git@vger.kernel.org>; Sun, 21 Jun 2020 09:05:17 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 9so16596380ljv.5
        for <git@vger.kernel.org>; Sun, 21 Jun 2020 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H4My5erqLL8dOrZfaL6YkbwXTldfSKlekx4sSgIaE1c=;
        b=jLmzygusf+Pxq1It9SYPrKBelANf3QKbvwEnuwZdrxBQop9wgSoY69VBgfutDGsXDg
         mAGCsyGj+Z9/76d/5d+WuWn69xz7RgI0CYkhiRiGfqhNiGU3kESCoa1w0Mnq9J2Tun3h
         g8s3AArNCubWy72WSp+KY5KiufitCh6gu6vfjQ/zurGfhkdVthaY8mePGDqPaCYiK/K+
         UpN8TewCB4QPA7G5ySTwobfuWJ4ySy+PlI1Qv6VX1UDw5wOUEZj6rllanL/mxwGRuoGH
         f11n3yt6HOkcI/E6fMRqYcHyJ1zoBvtjDv/5StEiWIaaZpQDvPbzxfG34mB9MVJ1IDMQ
         JJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4My5erqLL8dOrZfaL6YkbwXTldfSKlekx4sSgIaE1c=;
        b=iMLgciOF3uCQ/a3Wnm3Qqa+QhsHU9MnT+Qf02i7l2YLrpNOKox0xjW3jjPlDAEqClu
         WwHGUhT3s+SumpL/Du6988tHhbc1xTzAFR9QS+F4DRLD/C8XjxGn8xPc+KkzNukvOw6d
         No8t/SuNYeibv0cAYKhB460Ig+h2P0XjLXZ596TuCoTKT2FVmIcbMiqyL2e7w00ukVph
         F2ab7wiQcaLIseE/bWVAlX7iR3U5o33/48OMODjIL/8Y49nMBlOSda/5Ef/NaRN8X/k0
         CkyOYTiefskfJTZIEppRtpOH3PqMbuEcIvj/8lNm80aJOouNyQ7Aqwa1z3MhGeelCJRU
         Oeuw==
X-Gm-Message-State: AOAM531sVLNLVXuaOxm21n5c/SALkUk1KZDoF9KSXLcMUQcVgvQc6C3G
        twygOtBr2cBi85qfCQy1OmJSlBQ1hs+ssc8vAMCv5Q==
X-Google-Smtp-Source: ABdhPJxiDzj+Q7ljRtTG9jKRdTV+vo3fFuVdkE98TeL2rcbaPzgNap/dV+f/PjCXxfjPEzbTNySnCCBgFVMCvl/hmp0=
X-Received: by 2002:a2e:1558:: with SMTP id 24mr6487360ljv.202.1592755515398;
 Sun, 21 Jun 2020 09:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591974940.git.matheus.bernardino@usp.br>
 <6402c968077900d48d189551a652e10984437a9f.1591974940.git.matheus.bernardino@usp.br>
 <CABPp-BGdEyEeajYZj_rdxp=MyEQdszuyjVTax=hhYj3fOtRQUQ@mail.gmail.com>
In-Reply-To: <CABPp-BGdEyEeajYZj_rdxp=MyEQdszuyjVTax=hhYj3fOtRQUQ@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sun, 21 Jun 2020 13:05:04 -0300
Message-ID: <CAHd-oW5vKQMuVEtcnoqYARTAZz4M5bSt+j3R=z_iFcH4-oU6FQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] config: correctly read worktree configs in submodules
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 4:13 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Jun 12, 2020 at 8:45 AM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> >  config.c                   | 21 +++++++++---
> >  t/helper/test-config.c     | 67 +++++++++++++++++++++++++++++++++-----
> >  t/t2404-worktree-config.sh | 16 +++++++++
> >  3 files changed, 91 insertions(+), 13 deletions(-)
> >
> > diff --git a/config.c b/config.c
> > index 8db9c77098..c2d56309dc 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -1747,11 +1747,22 @@ static int do_git_config_sequence(const struct config_options *opts,
> >                 ret += git_config_from_file(fn, repo_config, data);
> >
> >         current_parsing_scope = CONFIG_SCOPE_WORKTREE;
> > -       if (!opts->ignore_worktree && repository_format_worktree_config) {
> > -               char *path = git_pathdup("config.worktree");
> > -               if (!access_or_die(path, R_OK, 0))
> > -                       ret += git_config_from_file(fn, path, data);
> > -               free(path);
> > +       if (!opts->ignore_worktree && repo_config && opts->git_dir) {
>
> What happens when opts->git_dir is NULL?  (Does that ever even
> happen?)  Should it fall back to the old code path in that case?

Sorry for not replying earlier.

Yes, opts->git_dir might be NULL in some cases. I did a quick grep
search, though, and it seems that this only happens in two
circumstances: (1) in builtin/config.c when
startup_info->have_repository is false; and (2) in
read_early_config(), if have_git_dir() returns false and
discover_git_directory() fails.

For (2), I think it is right to ignore the worktree config file when
opts->git_dir is NULL because we indeed don't have a repo to read the
file from. I'm tempted to say the same for (1), but I'm not very
familiar with setup.c. By the definition of have_git_dir() it seems
possible to have the_repository->git_dir set up even when
startup_info->have_repository == false:

int have_git_dir(void)
{
        return startup_info->have_repository
                || the_repository->gitdir;
}

Nevertheless, the current calls to config_with_options() either set
both opts->git_dir and opts->commondir or none. So if we were to fall
back to the_repository->git_dir, for the worktree config, when
startup_info->have_repository == false, the local config file would
still be ignored during the config sequence in such case. I think it
wouldn't make much sense to ignore the local config file but try to
load the worktree-specific one, which is also dependent on having a
repo, and even more specific. So I think we shouldn't fall back to the
old code path. But I would appreciate hearing from others more
familiar with this code.
