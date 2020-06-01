Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF65C433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 04:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA572073E
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 04:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="BWF/tCYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgFAEib (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 00:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFAEia (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 00:38:30 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F37EC061A0E
        for <git@vger.kernel.org>; Sun, 31 May 2020 21:38:30 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 9so4998252ljc.8
        for <git@vger.kernel.org>; Sun, 31 May 2020 21:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2RfgXqmj75kVxqlnlv7bXWRqPACvve0yQb96JWyeFPM=;
        b=BWF/tCYGiOusNH5pDbaFjQPe7Hyf7v3Pl6Q8c0Yb8I7YPX3gM06G4dCsawLBSwixiG
         canrjSgtqws80+n1pBHEoMn6hijz/WOSiYqcidVr1ZgRIZaGwo1qg2ug5yMvx5E5NQex
         EV5zQYFt3BweHK1fKbasgkkZF+8Y+TBNXBiqZDZNvHFQxJ7to+ntV0iKCiQjzezUZXkO
         aLYEzoq4ZoR6G/c4TwiMkYxLJQKc6aJyIAOH+e8FTsrn0ubquLjUPztiPd0sl1xM0udu
         zUf+2PU411R7osuVtQ/uObooQG+O2CRJxd6w0rjc1NvCMY6rQPTNnD0W3mAGeY7Gr0og
         mrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2RfgXqmj75kVxqlnlv7bXWRqPACvve0yQb96JWyeFPM=;
        b=hgGSmm4weoYLWRgggX9Jbx8HMicYVjIm2Hqck+8ns61GaT6vZ0lebW2M80Rwv8ASeS
         buz/terSAyfoRtb/o2DagYioWJa90PKE+Kq1JnaIBOOuTIMunUf9f+5qzF4pE73vgT1O
         J+V5x3pnUIBwL1K+zuRoB7srhpu7tjdQtATjzA/Gls6bZurHnsZqoPyY4xNzyqfF6ix1
         t1kmtgcE4OePwPAAyrKcFjvfHzLivoJcgsaHWQajTnmw9UOwwuet3WU3srjRd62GRv6A
         NwTaI1XCiw5w5slpakH/PzUlzh9+bwg5kSY9Le/ltKmKM6J1egIQtTTEccExAXYpOME2
         tY1A==
X-Gm-Message-State: AOAM531VVR8JcfuTJWCBqS2kCMiKPcVuUHF/HcK1EctPaHZxOjE3HseI
        JlsBqlWC8YeesXx9hwYqqeMdEthZ7eUybueHnhExLQ==
X-Google-Smtp-Source: ABdhPJx4M6cZ0/MYHXVk1YJZfiUpJeK1k7PKLmFd492d8V7S+/bWN5LMgPh3ypIpHjKI7OQc6l55uMq08Er93wW+fJo=
X-Received: by 2002:a2e:9787:: with SMTP id y7mr9114389lji.107.1590986308827;
 Sun, 31 May 2020 21:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590627264.git.matheus.bernardino@usp.br>
 <448e0efffd0bbc89d8ea891923f242b5123c5826.1590627264.git.matheus.bernardino@usp.br>
 <CABPp-BGVaMM9Naiu3HeO6n2aOxsHwiuc813MF-hFWezSFa9CsA@mail.gmail.com>
In-Reply-To: <CABPp-BGVaMM9Naiu3HeO6n2aOxsHwiuc813MF-hFWezSFa9CsA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 1 Jun 2020 01:38:17 -0300
Message-ID: <CAHd-oW7==zM5goS6ZrHNYADDgdkYdXLqZgKxCL2UwFAacvVsNg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] config: correctly read worktree configs in submodules
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 30, 2020 at 11:49 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, May 27, 2020 at 6:13 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > One of the steps in do_git_config_sequence() is to load the
> > worktree-specific config file. Although the function receives a git_dir
> > string, it relies on git_pathdup(), which uses the_repository->git_dir,
> > to make the path to the file. Furthermore, it also checks that
> > extensions.worktreeConfig is set through the
> > repository_format_worktree_config variable, which refers to
> > the_repository only. Thus, when a submodule has worktree settings, a
> > command executed in the superproject that recurses into the submodule
> > won't find the said settings.
> >
> > Such a scenario might not be needed now, but it will be in the following
>
> It's not needed?  Are there not other config values that affect grep's
> behavior, such as smudge filters of the submodule that might be
> important if doing a 'git grep --recurse-submodules $REVISION'?

Hmm, I haven't used smudge filters before, but it seems to me that
`git grep $REVISION` does not honor them.

> Also, is there a similar issue here for .gitattributes?  (e.g. if the
> submodule declares certain files to be binary?)

Declaring files as binary in the submodule works fine. But I noticed
that textconv filter specifications in the submodule's config are
currently ignored. To be honest, I wasn't aware of this issue before.

> I don't actually know if these are issues but I'm just surprised to
> hear that this would be the first case that would need to look at
> submodule-specific configuration.

Hmm, not to submodule-specific configuration but to worktree-specific
configuration of a submodule, right? I.e. a config.worktree file from
within a submodule. Reconsidering this now, we could indeed have a
diff.<driver>.textconv or core.quotePath settings specified in the
worktree scope of a submodule. And we should honor them when recursing
in grep. I guess I thought the "most natural" place for these
settings, in a submodule, would be in the standard .git/config file
(as opposed to the sparse-checkout ones, which are normally at
config.worktree). That's probably why I wrote "Such scenario might not
be needed now". But we should indeed support reading
diff.<driver>.textconv from config.worktree as well (although grep
currently ignores this setting in submodules, both in the local and
worktree scopes). So the said sentence doesn't make much sense,
indeed. I will remove it. Thanks!

> > diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> > index 1c8e965840..284f83a921 100644
> > --- a/t/helper/test-config.c
> > +++ b/t/helper/test-config.c
> > @@ -84,33 +91,63 @@ int cmd__config(int argc, const char **argv)
> >         int i, val;
> >         const char *v;
> >         const struct string_list *strptr;
> > -       struct config_set cs;
> > +       struct config_set cs = { .hash_initialized = 0 };
> >         enum test_config_exit_code ret = TC_SUCCESS;
> > +       struct repository *repo = the_repository;
> > +       const char *subrepo_path = NULL;
> > +
> > +       argc--; /* skip over "config" */
>
> This line alone is responsible for a fairly big set of changes
> throughout this file, just decrementing indices everywhere.  It might
> be nice for review purposes if this and the other changes it caused
> were pulled out into a separate step, so we can more easily
> concentrate on the primary additions and changes you are making to
> this file.

OK, will do.
