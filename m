Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C3DC43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 14:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B02322206
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 14:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="E24i8LR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgIIOUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 10:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbgIINEj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 09:04:39 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7103BC061755
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 06:04:36 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u8so1559434lff.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 06:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LuRWIqUe1v3Sm+yFh1J9u4IkeFWeOYet/4eyk6GQVj4=;
        b=E24i8LR16EOKAEeRgDOdMni9lLhWrF39jXiAgQeSYxhZ72GIxFQwH2Agb4RkVKVENT
         /d1cQeQUJolwLiAQ9o1pMn2rjd8K6zSGqXJrkakka0CU86mJ8wRbtS5thn7yUyDxm+ed
         RtpXXQZs7ZvHXjkkJlteBB2CwQIDrSYFs/XULLTIx+2JCtlJBYcYLvqUKDF5Ntv/hPL6
         1nuOdySm/Q8ubAx2wnPorBm9OkkAkDOgzZF0jkVzH5at3Z9C5HYeoYEaJaKvReMsrRmI
         AI0HYTdzOx+xyzYax2aYjTn/b47DEN06uPyY9M5WwI3zPVjwbvwmODuLTBsFUWQvmhJG
         eHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuRWIqUe1v3Sm+yFh1J9u4IkeFWeOYet/4eyk6GQVj4=;
        b=nhx6kebLVcuMsdgGLUD618R1i7COSfXcRowivdV4oHIB28r1NK+iaf9bt8xEZlz9Eh
         ICgj5f8xmz9KSigrZGmaSAWxzb/QkGjImgO78oXFy553/HqJXT+L+14ypGKlLK9gdRwH
         sKhmK6W1deTpnPGcg/mRpTiWTwXNtSTIOhTWB/b2t5cvCBDae93OdbhnWnycTLUuFOAX
         gpHg7Q5YqJwHZefyUtBj7VrAPVyCxHEG7UlqYGYF0OqhggbpV8HnTlqcINw48D3+PbUp
         /fEJlra3MqqZm4DENdOHLZsOgrFgHEqTvqn1eKNdDNSlZx0kup1DPji08aHI9YZyZec2
         NMvw==
X-Gm-Message-State: AOAM530OcuzAQ0oq8wsgCcbzohWC+dXNP8W/xEf00Dc3hcKKuOyJjD9x
        LAqlDvkvmK+2QDfDFTXOsKqJHPmekmHzydS2RVNI5g==
X-Google-Smtp-Source: ABdhPJwjj+Qno/I9XkKRXBc1DHNXmYSQiMVPYO1ortBVxa9aE/p0MPwBS+R0PA16MGxIzhd5vLhB0qyn8KUFcOR4YRY=
X-Received: by 2002:a19:546:: with SMTP id 67mr1758927lff.99.1599656674440;
 Wed, 09 Sep 2020 06:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599026986.git.matheus.bernardino@usp.br>
 <3e02e1bd248438e0b435a19d857432edcaa15a2c.1599026986.git.matheus.bernardino@usp.br>
 <20200902201523.GA3941032@google.com>
In-Reply-To: <20200902201523.GA3941032@google.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 9 Sep 2020 10:04:23 -0300
Message-ID: <CAHd-oW6jCiaXdsKnhde0iBDWXpZyh4cf5j_8zW7x=W3BaZ9Kbg@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] config: correctly read worktree configs in submodules
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Jonathan

Sorry for the late reply, last week was quite busy.

On Wed, Sep 2, 2020 at 5:15 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Matheus Tavares wrote:
>
> > The config machinery is not able to read worktree configs from a
> > submodule in a process where the_repository represents the superproject.
>
> ... where the_repository represents the superproject and
> extensions.worktreeConfig is not set there, right?
>
> > Furthermore, when extensions.worktreeConfig is set on the superproject,
> > querying for a worktree config in a submodule will, instead, return
> > the value set at the superproject.
> >
> > The problem resides in do_git_config_sequence(). Although the function
> > receives a git_dir string, it uses the_repository->git_dir when making
>
> This part of the commit message seems to be rephrasing what the patch
> says; for that kind of thing, it seems better to let the patch speak
> for itself.  Can we describe what is happening at a higher level (in
> other words the intent instead of the details of how that is
> manifested in code)?  For example,
>
>  The relevant code is in do_git_config_sequence. Although it is designed
>  to act on an arbitrary repository, specified by the passed-in git_dir
>  string, it accidentally depends on the_repository in two places:
>
>  - it reads the global variable `repository_format_worktree_config`,
>    which is set based on the content of the_repository, to determine
>    whether extensions.worktreeConfig is set
>
>  - it uses the git_pathdup helper to find the config.worktree file,
>    instead of making a path using the passed-in git_dir falue
>
>  Sever these dependencies.

Yeah, much better, thanks! :)

> [...]
> > --- a/config.c
> > +++ b/config.c
> > @@ -1747,11 +1747,22 @@ static int do_git_config_sequence(const struct config_options *opts,
> >               ret += git_config_from_file(fn, repo_config, data);
> >
> >       current_parsing_scope = CONFIG_SCOPE_WORKTREE;
> > -     if (!opts->ignore_worktree && repository_format_worktree_config) {
> > +     if (!opts->ignore_worktree && repo_config && opts->git_dir) {
>
> repo_config is non-NULL if and only if commondir is non-NULL and
> commondir is always non-NUlL if git_dir is non-NULL (as checked higher
> in the function), right?  I think that means this condition could be
> written more simply as
>
>         if (!opts->ignore_worktree && opts->git_dir) {
>
> which I think should be easier for the reader to understand.

Nice, thanks.

> > +             struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
> > +             struct strbuf buf = STRBUF_INIT;
> > +
> > +             read_repository_format(&repo_fmt, repo_config);
> > +
> > +             if (!verify_repository_format(&repo_fmt, &buf) &&
> > +                 repo_fmt.worktree_config) {
>
> In the common case where we are acting on the_repository, this add
> extra complexity and slows the routine down.
>
> Would passing in the 'struct repository *' to allow distinguishing
> that case help?  Something like this:
>
> diff --git i/builtin/config.c w/builtin/config.c
> index 5e39f618854..ca4caedf33a 100644
> --- i/builtin/config.c
> +++ w/builtin/config.c
> @@ -699,10 +699,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>                 config_options.respect_includes = !given_config_source.file;
>         else
>                 config_options.respect_includes = respect_includes_opt;
> -       if (!nongit) {
> -               config_options.commondir = get_git_common_dir();
> -               config_options.git_dir = get_git_dir();
> -       }
> +       if (!nongit)
> +               config_options.repo = the_repository;
>
>         if (end_nul) {
>                 term = '\0';
> diff --git i/config.c w/config.c
> index 2bdff4457be..70a1dd0ad3f 100644
> --- i/config.c
> +++ w/config.c
> @@ -222,8 +222,8 @@ static int include_by_gitdir(const struct config_options *opts,
>         const char *git_dir;
>         int already_tried_absolute = 0;
>
> -       if (opts->git_dir)
> -               git_dir = opts->git_dir;
> +       if (opts->repo && opts->repo->gitdir)
> +               git_dir = opts->repo->gitdir;
>         else
>                 goto done;
>
> @@ -1720,10 +1720,10 @@ static int do_git_config_sequence(const struct config_options *opts,
>         char *repo_config;
>         enum config_scope prev_parsing_scope = current_parsing_scope;
>
> -       if (opts->commondir)
> -               repo_config = mkpathdup("%s/config", opts->commondir);
> -       else if (opts->git_dir)
> -               BUG("git_dir without commondir");
> +       if (opts->repo && opts->repo->commondir)
> +               repo_config = mkpathdup("%s/config", opts->repo->commondir);
> +       else if (opts->repo && opts->repo->gitdir)
> +               BUG("gitdir without commondir");
>         else
>                 repo_config = NULL;
>
> @@ -1824,27 +1824,33 @@ void read_early_config(config_fn_t cb, void *data)
>         struct config_options opts = {0};
>         struct strbuf commondir = STRBUF_INIT;
>         struct strbuf gitdir = STRBUF_INIT;
> +       struct repository the_early_repo = {0};
>
>         opts.respect_includes = 1;
>
>         if (have_git_dir()) {
> -               opts.commondir = get_git_common_dir();
> -               opts.git_dir = get_git_dir();
> +               opts.repo = the_repository;

I'm not very familiar with the code in setup.c so I apologize for the
noob question: have_git_dir() returns `startup_info->have_repository
|| the_repository->gitdir`; so is it possible that it returns true but
the_repository->gitdir is not initialized yet? If so, should we also
check the_repository->gitdir here (before assigning opts.repo), and
call BUG() when it is NULL, like get_git_dir() does?

Hmm, nevertheless, I see that you already check `opts.repo &&
opts.repo->gitdir` before trying to use it in
do_git_config_sequence(). So it should already cover this case, right?

>         /*
>          * When setup_git_directory() was not yet asked to discover the
>          * GIT_DIR, we ask discover_git_directory() to figure out whether there
>          * is any repository config we should use (but unlike
> -        * setup_git_directory_gently(), no global state is changed, most
> +        * setup_git_directory_gently(), no global state is changed; most
>          * notably, the current working directory is still the same after the
>          * call).
> +        *
> +        * NEEDSWORK: There is some duplicate work between
> +        * discover_git_directory and repo_init.  Update to use a variant of
> +        * repo_init that does its own repository discovery once available.
>          */
>         } else if (!discover_git_directory(&commondir, &gitdir)) {
> -               opts.commondir = commondir.buf;
> -               opts.git_dir = gitdir.buf;
> +               repo_init(&the_early_repo, gitdir.buf, NULL);
> +               opts.repo = &the_early_repo;
>         }
>
>         config_with_options(cb, data, NULL, &opts);
>
> +       if (the_early_repo.settings.initialized)
> +               repo_clear(&the_early_repo);
>
>         strbuf_release(&commondir);
>         strbuf_release(&gitdir);
>  }
> @@ -2097,8 +2103,7 @@ static void repo_read_config(struct repository *repo)
>         struct config_options opts = { 0 };
>
>         opts.respect_includes = 1;
> -       opts.commondir = repo->commondir;
> -       opts.git_dir = repo->gitdir;
> +       opts.repo = repo;
>
>         if (!repo->config)
>                 repo->config = xcalloc(1, sizeof(struct config_set));
> diff --git i/config.h w/config.h
> index 91cdfbfb414..e56293fb29f 100644
> --- i/config.h
> +++ w/config.h
> @@ -21,6 +21,7 @@
>   */
>
>  struct object_id;
> +struct repository;
>
>  /* git_config_parse_key() returns these negated: */
>  #define CONFIG_INVALID_KEY 1
> @@ -87,8 +88,7 @@ struct config_options {
>         unsigned int ignore_worktree : 1;
>         unsigned int ignore_cmdline : 1;
>         unsigned int system_gently : 1;
> -       const char *commondir;
> -       const char *git_dir;
> +       struct repository *repo;
>         config_parser_event_fn_t event_fn;
>         void *event_fn_data;
>         enum config_error_action {
> ==== >8 ====

Thanks a lot for this :) I was thinking of adding it as a preparatory
patch before the fix itself. May I have your S-o-B as the author?

Best,
Matheus
