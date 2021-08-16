Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154BBC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 14:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6635601FA
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 14:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhHPOtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbhHPOtC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 10:49:02 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A422C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 07:48:30 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id n6so27570082ljp.9
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5JumYVPJUGJAfeN4iDlGfVXQMKQDbWWvIm605bA0rE=;
        b=J/VywDcRoggg/vOv8a0rehZCtZwqNDhF7dS+DNX+EXy2gdX2r9LcRJZ7+ssBRb8QNd
         p2JlmjCIe0gCr8Kr1SQ8cS5NMILqTjVCVa3tG156sxojQpTTUQHO6j50kAg+C8uO13Xv
         AQkLsgJXKPi3J4L5DmYcGp+VhaTDhH0qbDFE1Ok85lHnzb1kMr9gPsW2CckDNJPLLE1K
         WlnzlTlX9RtjXD2+jQfXFfST/oe/ameQQm/QBcEcJXXg6XhVKB9LuGOLF39n0LR6ZI65
         CC2Kkw+CzkR02FRhrOHTv6TeTB6JPtoAyv+Qofa+mDqMRqfoZ8CovvUaLR74LdGx6Ruq
         yUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5JumYVPJUGJAfeN4iDlGfVXQMKQDbWWvIm605bA0rE=;
        b=HTNUWBPeRmxSCtZS4yvlXBwG7Q0ldYKivKXgvQBoxnYKWtNXf4CkuKJBJU1kPlKHoP
         4Srle2MvKSzX2O/n5oAusSogzVVMaabiAHvdaSdFvNJmB3kmwFCtAozBeAM8yL6KDCfX
         p7RsQVw7Agp94ssIWlE1hC8OBed8fSMUx4LXiAeMbV4SnGgh3qmPu8RDOJPHQlwSeG5m
         mWbAheIMz8qbYhhNpiaBtmTeD99hnfA/Z2mukV/j9uRzJ9lnAmKJlnX14WzA/dWRrmvj
         AwANh8/wqCCxjktXefOrbsEFbXO1Dqdd1+f26oiM0euKbSTQwneaPjT6rHrVQ0wwCW7h
         v7Lw==
X-Gm-Message-State: AOAM531c6AVbEX4dMrskl99UCNeYQlk9z32W6ptiebKsW63t1uMOB9W6
        uwHD7HPo8dk+HJ7fFJ4NkDtjpLpqxrmUW6NBl7PYIg==
X-Google-Smtp-Source: ABdhPJxlssl1XXH66X2TH3FhfIBihID7S+Lm5y7EO4keArRHgU0iaYIJ/bJJ2GMk/tFg8zNUqhTvgsv6yAGt6lVuHgw=
X-Received: by 2002:a05:651c:211c:: with SMTP id a28mr4191975ljq.8.1629125308684;
 Mon, 16 Aug 2021 07:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com>
 <cover.1628888668.git.jonathantanmy@google.com> <50c69a988b2afca68f06e36949e4a8cc3a93940a.1628888668.git.jonathantanmy@google.com>
In-Reply-To: <50c69a988b2afca68f06e36949e4a8cc3a93940a.1628888668.git.jonathantanmy@google.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 16 Aug 2021 11:48:17 -0300
Message-ID: <CAHd-oW7cLgZZhGdvONfujDBpNtG1xXfECE=1hLeUzCm8U-N9QQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] grep: add repository to OID grep sources
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 13, 2021 at 6:05 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Record the repository whenever an OID grep source is created, and teach
> the worker threads to explicitly provide the repository when accessing
> objects.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/grep.c | 15 ++++++---------
>  grep.c         |  7 +++++--
>  grep.h         | 13 ++++++++++++-
>  3 files changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 69d8ea0808..d27e95e092 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -349,7 +349,7 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
>         struct grep_source gs;
>
>         grep_source_name(opt, filename, tree_name_len, &pathbuf);
> -       grep_source_init_oid(&gs, pathbuf.buf, path, oid);
> +       grep_source_init_oid(&gs, pathbuf.buf, path, oid, opt->repo);
>         strbuf_release(&pathbuf);
>
>         if (num_threads > 1) {
> @@ -462,14 +462,11 @@ static int grep_submodule(struct grep_opt *opt,
>         repo_read_gitmodules(subrepo, 0);
>
>         /*
> -        * NEEDSWORK: This adds the submodule's object directory to the list of
> -        * alternates for the single in-memory object store.  This has some bad
> -        * consequences for memory (processed objects will never be freed) and
> -        * performance (this increases the number of pack files git has to pay
> -        * attention to, to the sum of the number of pack files in all the
> -        * repositories processed so far).  This can be removed once the object
> -        * store is no longer global and instead is a member of the repository
> -        * object.
> +        * All code paths tested by test code no longer need submodule ODBs to
> +        * be added as alternates, but add it to the list just in case.
> +        * Submodule ODBs added through add_submodule_odb_by_path() will be
> +        * lazily registered as alternates when needed (and except in an
> +        * unexpected code interaction, it won't be needed).

Nice.

>          */
>         add_submodule_odb_by_path(subrepo->objects->odb->path);
>         obj_read_unlock();
> diff --git a/grep.c b/grep.c
> index 8a8105c2eb..79598f245f 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1863,7 +1863,8 @@ void grep_source_init_file(struct grep_source *gs, const char *name,
>  }
>
>  void grep_source_init_oid(struct grep_source *gs, const char *name,
> -                         const char *path, const struct object_id *oid)
> +                         const char *path, const struct object_id *oid,
> +                         struct repository *repo)
>  {
>         gs->type = GREP_SOURCE_OID;
>         gs->name = xstrdup_or_null(name);
> @@ -1872,6 +1873,7 @@ void grep_source_init_oid(struct grep_source *gs, const char *name,
>         gs->size = 0;
>         gs->driver = NULL;
>         gs->identifier = oiddup(oid);
> +       gs->repo = repo;
>  }
>
>  void grep_source_clear(struct grep_source *gs)
> @@ -1900,7 +1902,8 @@ static int grep_source_load_oid(struct grep_source *gs)
>  {
>         enum object_type type;
>
> -       gs->buf = read_object_file(gs->identifier, &type, &gs->size);
> +       gs->buf = repo_read_object_file(gs->repo, gs->identifier, &type,
> +                                       &gs->size);
>         if (!gs->buf)
>                 return error(_("'%s': unable to read %s"),
>                              gs->name,
> diff --git a/grep.h b/grep.h
> index 480b3f5bba..24c6b64cea 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -120,7 +120,16 @@ struct grep_opt {
>         struct grep_pat *header_list;
>         struct grep_pat **header_tail;
>         struct grep_expr *pattern_expression;
> +
> +       /*
> +        * NEEDSWORK: See if we can remove this field, because the repository
> +        * should probably be per-source, not per-repo.

Hmm, I think the "not per-repo" part is a bit confusing, as it refers
to "the repository" ("the repository should not be per-repo"?) Could
we remove that part?

Maybe we could also be a bit more specific regarding the suggested
conversion:  "See if we can remove this field, because the repository
should probably be per-source. That is, grep.c functions using
`grep_opt.repo` should probably start using `grep_source.repo`
instead." (But that's nitpicking from my part, feel free to ignore
it.)

>             [...] This is potentially the
> +        * cause of at least one bug - "git grep" ignoring the textconv
> +        * attributes from submodules. See [1] for more information.
> +        * [1] https://lore.kernel.org/git/CAHd-oW5iEQarYVxEXoTG-ua2zdoybTrSjCBKtO0YT292fm0NQQ@mail.gmail.com/
> +        */
>         struct repository *repo;
> +
>         const char *prefix;
>         int prefix_length;
>         regex_t regexp;
> @@ -187,6 +196,7 @@ struct grep_source {
>                 GREP_SOURCE_BUF,
>         } type;
>         void *identifier;
> +       struct repository *repo; /* if GREP_SOURCE_OID */
>
>         char *buf;
>         unsigned long size;
> @@ -198,7 +208,8 @@ struct grep_source {
>  void grep_source_init_file(struct grep_source *gs, const char *name,
>                            const char *path);
>  void grep_source_init_oid(struct grep_source *gs, const char *name,
> -                         const char *path, const struct object_id *oid);
> +                         const char *path, const struct object_id *oid,
> +                         struct repository *repo);
>  void grep_source_clear_data(struct grep_source *gs);
>  void grep_source_clear(struct grep_source *gs);
>  void grep_source_load_driver(struct grep_source *gs,
> --
> 2.33.0.rc1.237.g0d66db33f3-goog
>
