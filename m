Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2FFF20282
	for <e@80x24.org>; Tue, 20 Jun 2017 19:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbdFTT53 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:57:29 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36121 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdFTT51 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:57:27 -0400
Received: by mail-pg0-f49.google.com with SMTP id u62so47810281pgb.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dETPfUEmawJxDlIWFgZFsEjcK7RhvMmT3w+1p+1vy18=;
        b=IwA1AhWUwwLbyA+X3yUhUIWN2+cDcBClH/xLkKcX1wGWg+Nf2alUk1a9G8HYC6lZSa
         R1K8NzDba5gH4ZfkvC7XtbTg0HAbbxPUgTexWVx78++spHWnRs6d4IVzMqPTpPXRosaB
         GOEE6JdwTQ05komuqcTKp1vG0i8m7OyIzHVoStwV9yezUgJ0g0e0qXG3OXeaHZyeNE0j
         0HWnZTQf6Pp22lb/J4BUPzZoKV7/+yd5oQBDMGcsyWkBnxDtqWeGXSS9JkU7wSANzeCX
         jGgr7krWJqe/RrVsjMXohwx9TkejcxJGPmhesdqRWVfEsSZtqs3MGbAeCiv8GiQXe0MC
         7rCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dETPfUEmawJxDlIWFgZFsEjcK7RhvMmT3w+1p+1vy18=;
        b=qzd2WqNUUNoWLC/HI79vzfyhpgc8A60cSfi2YPAN1pKBT2dQKpUT0Le9SEfEYVJFS3
         C2FfZBHPrPFON4IPIRfwJ7d0K1o46Gccbg3IMh6d8BcBQ3WfrgNQWx5fJ8l+edUAQNoh
         IO9jIQSobHzYUsnJWtbZFOEKwgbK9cch1VOdgowwVhuazO4kRTfvfEMq2OZjUA+lr4HA
         /TM/3+j9Boa8JjsCgPVoHlD8Puk8sudoTWdMaQprASTEVOUCeWKcR0LMgbkwXAqlLwlB
         jnP+BUR+4RjsaLVDolmqY5mcRsjqGyVkbd6eZIGrQNIelM8h/HSsVsMfHWctQfIVTRQE
         fbFg==
X-Gm-Message-State: AKS2vOwVAEie/V6nUjlhW2JnOPqGu96r2u+0Qfv5Zcb8SPLk023mQjlR
        QCg4VDlXztXODgpMIFyGABOA9nhb8Ono
X-Received: by 10.98.49.2 with SMTP id x2mr12072373pfx.48.1497988646942; Tue,
 20 Jun 2017 12:57:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Tue, 20 Jun 2017 12:57:26 -0700 (PDT)
In-Reply-To: <20170620191951.84791-5-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com> <20170620191951.84791-1-bmwill@google.com>
 <20170620191951.84791-5-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Jun 2017 12:57:26 -0700
Message-ID: <CAGZ79kaUiODQm8KsGOAtAoATNW7mci3DRM=RimXXv-6--9NOKw@mail.gmail.com>
Subject: Re: [PATCH v3 04/20] repository: introduce the repository object
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2017 at 12:19 PM, Brandon Williams <bmwill@google.com> wrote:
> Introduce the repository object 'struct repository' which can be used to
> hold all state pertaining to a git repository.
>
> Some of the benefits of object-ifying a repository are:
>
>   1. Make the code base more readable and easier to reason about.
>
>   2. Allow for working on multiple repositories, specifically
>      submodules, within the same process.  Currently the process for
>      working on a submodule involves setting up an argv_array of options
>      for a particular command and then launching a child process to
>      execute the command in the context of the submodule.  This is
>      clunky and can require lots of little hacks in order to ensure
>      correctness.  Ideally it would be nice to simply pass a repository
>      and an options struct to a command.
>
>   3. Eliminating reliance on global state will make it easier to
>      enable the use of threading to improve performance.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

> +/*
> + * Initialize 'repo' based on the provided 'gitdir'.
> + * Return 0 upon success and a non-zero value upon failure.

Non zero or negative? The point of the question is if we want to
ask users of this function to be cautious early on. So in the future,
do we want to rather see

    if (repo_init(...))
        die("you're doomed");

or rather

    int x = repo_init(...);
    if (x < 0)
        die("you're doomed");
    else if (x == 1)
        warning("you're not doomed, but close."\
             "Not distimming the gostaks.")
    else
        ; /* we're fine, carry on with life */

I guess we can still refactor later, it's just one
thing to thing about when introducing an API
that will likely be used a lot down the road.

> +struct repository {
> +       /* Environment */
> +       /* Path to the git directory */
> +       char *gitdir;
> +
> +       /* Path to the common git directory */
> +       char *commondir;
> +
> +       /* Path to the repository's object store */
> +       char *objectdir;
> +
> +       /* Path to the repository's graft file */
> +       char *graft_file;
> +
> +       /* Path to the current worktree's index file */
> +       char *index_file;
> +
> +       /* Path to the working directory */
> +       char *worktree;
> +
> +       /* Configurations */
> +       /*
> +        * Bit used during initialization to indicate if repository state (like
> +        * the location of the 'objectdir') should be read from the
> +        * environment.  By default this bit will be set at the begining of
> +        * 'repo_init()' so that all repositories will ignore the environment.
> +        * The exception to this is 'the_repository', which doesn't go through
> +        * the normal 'repo_init()' process.
> +        */
> +       unsigned ignore_env:1;
> +
> +       /* Indicate if a repository has a different 'commondir' from 'gitdir' */
> +       unsigned different_commondir:1;
> +};

I applaud the effort towards documenting what each variable is
supposed to contain. But some of them read like

    /* increments i by one */
    i++;

which is considered bad comment style (it doesn't add
more information, it just wastes a line), so specifically for
all the "Path to X" comments:
* Are they absolute path, or relative path?
  If relative, then relative to what?
* Can they be NULL? When?

(* Why do we need so many path?
    Could one of them be constructed using
    another and then hardcoding a string relative to it?
    This question may rather be answered in the commit
    message)
