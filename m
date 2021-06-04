Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD6DC4743C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 21:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F8C61246
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 21:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhFDVid (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 17:38:33 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:34466 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhFDVic (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 17:38:32 -0400
Received: by mail-oi1-f174.google.com with SMTP id u11so11149836oiv.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 14:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r7dcVJ23VnTlYKfufdE19BCq5lmk+xshQmjchvGhcVY=;
        b=FODgr061hPb2ZPxtGGdxlToCoGwGUa8FJPHPUUaYNzFyOBxXHMJPgoSd1eOZGIZfhC
         BFSBDHjqi+UgP7VHLm+X9mryew5kR5g5httqI/Zvtpy+VJGSfmgkMK/n0gzFdDlZ7kdy
         sqMxhhWasTDjOp3xc0p6vmHEKY2xM87Zkbq57rRR6lgi+mDeIJHMvYRKczT1KaZxxC0v
         DPzQYfVUgJZV3rd5t6cYAH05nw4iDP73MUS+oO3YbUGsG1jux2sPGTjVT/sxMySRBW5W
         Nffl6QNnIeTsH9Cfw1b1xl77C+dY9zPu8U3v7u+sscNzGJPPBYSiJH9zWoHXBzzJDrGN
         UD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r7dcVJ23VnTlYKfufdE19BCq5lmk+xshQmjchvGhcVY=;
        b=RPsxo9DOjrWjyQfwstfr0VyV6rrJtl1VjJATnxXl4gbq7BzcHUZypS+KEARFLlZWky
         zSD2kAlRg1vY72cza1Dj5Yqv94e9dqrV8KCbhtT3sa61eu7F9UyHRM1PXHGmRZ2IMoGk
         sAyZy8wK9dVovbv2mFfbpU6QQKOxXiXZnawfV+ldKnuJJP21FOFqpS+OMgjC4Gg0V+7Z
         jWrLhewCA8xRac4OHBTFhcXPUmxwcqZD2IIQ93LLFDZ2TQnwZSQsnDPlVbBrMqsjVhEf
         Lq5/aUIysWkCEybO+yRxGx6iBUtjlQuBJkPPKuI/4MwRinpB/gpljy7RqKxgN4K5QZzd
         6xhQ==
X-Gm-Message-State: AOAM530sj9ai+EWVgY6Bi6z0Zp+k3P2LBwhsfP4JXUSnM2ythry8Rgnm
        kxlYcMFGaHTCuvzZ2zhaLRCk87v2LZhKBYVVDwU=
X-Google-Smtp-Source: ABdhPJw2lu8apAP3mhFonT0tGmFaEmY9/EiyxlIZ5r2QCQopiWxfpOcc7DpBDl6FYvdlEMUBZjk9qjpzJhfm3CpGnvo=
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr4365191oiw.31.1622842545785;
 Fri, 04 Jun 2021 14:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com> <b70a00b9b06e5142bb95891cfc2faa87d708ef0d.1622580781.git.jonathantanmy@google.com>
In-Reply-To: <b70a00b9b06e5142bb95891cfc2faa87d708ef0d.1622580781.git.jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Jun 2021 14:35:34 -0700
Message-ID: <CABPp-BGeOVQokV+zg2-PUcmjEQ8+jmn6e=UeE=cOn=-Qm32p_Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] promisor-remote: teach lazy-fetch in any repo
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 1, 2021 at 2:38 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> This is one step towards supporting partial clone submodules.
>
> Even after this patch, we will still lack partial clone submodules
> support, primarily because a lot of Git code that accesses submodule
> objects does so by adding their object stores as alternates, meaning
> that any lazy fetches that would occur in the submodule would be done
> based on the config of the superproject, not of the submodule. This also
> prevents testing of the functionality in this patch by user-facing
> commands. So for now, test this mechanism using a test helper.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Makefile                      |  1 +
>  object-file.c                 |  7 ++-----
>  promisor-remote.c             | 14 +++++++++-----
>  t/helper/test-partial-clone.c | 34 ++++++++++++++++++++++++++++++++++
>  t/helper/test-tool.c          |  1 +
>  t/helper/test-tool.h          |  1 +
>  t/t0410-partial-clone.sh      | 24 ++++++++++++++++++++++++
>  7 files changed, 72 insertions(+), 10 deletions(-)
>  create mode 100644 t/helper/test-partial-clone.c
>
> diff --git a/Makefile b/Makefile
> index c3565fc0f8..f6653bcd5e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -725,6 +725,7 @@ TEST_BUILTINS_OBJS += test-oidmap.o
>  TEST_BUILTINS_OBJS += test-online-cpus.o
>  TEST_BUILTINS_OBJS += test-parse-options.o
>  TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
> +TEST_BUILTINS_OBJS += test-partial-clone.o
>  TEST_BUILTINS_OBJS += test-path-utils.o
>  TEST_BUILTINS_OBJS += test-pcre2-config.o
>  TEST_BUILTINS_OBJS += test-pkt-line.o
> diff --git a/object-file.c b/object-file.c
> index f233b440b2..ebf273e9e7 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1570,15 +1570,12 @@ static int do_oid_object_info_extended(struct repository *r,
>                 }
>
>                 /* Check if it is a missing object */
> -               if (fetch_if_missing && has_promisor_remote() &&
> -                   !already_retried && r == the_repository &&
> +               if (fetch_if_missing && repo_has_promisor_remote(r) &&
> +                   !already_retried &&

So here you removed the special check against the_repository while
looking for promisor_remotes.  There are other such special checks in
the code; I also see:

diff.c: if (options->repo == the_repository && has_promisor_remote() &&
diffcore-break.c:       if (r == the_repository && has_promisor_remote()) {
diffcore-rename.c:      if (r == the_repository && has_promisor_remote()) {

and a series I'm planning to submit soon will add another to merge.ort.c.

Do these need to all be fixed as part of the partial clone submodule
support as well?  Do I need to change anything about my series?  I
guess since I'm asking that, I should probably submit it first so you
can actually see it and answer my question.  (And the timing may be
good since the area is fresh in your memory...)

>                     !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
>                         /*
>                          * TODO Investigate checking promisor_remote_get_direct()
>                          * TODO return value and stopping on error here.
> -                        * TODO Pass a repository struct through
> -                        * promisor_remote_get_direct(), such that arbitrary
> -                        * repositories work.

Odd, it appears that when this comment was added (in commit b14ed5adaf
("Use promisor_remote_get_direct() and has_promisor_remote()",
2019-06-25)), a repository was passed to promisor_remote_get_direct().
Sure, it was just a transliteration of the comment that was there
before when fetch_objects() was the function being called, but since
the code was being changed and the comment being updated, it seems the
TODO should have been removed back then.

Oh, well, good to update it now at least.

>                          */
>                         promisor_remote_get_direct(r, real, 1);
>                         already_retried = 1;
> diff --git a/promisor-remote.c b/promisor-remote.c
> index 5819d2cf28..1601f05d79 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -11,7 +11,8 @@ struct promisor_remote_config {
>         struct promisor_remote **promisors_tail;
>  };
>
> -static int fetch_objects(const char *remote_name,
> +static int fetch_objects(struct repository *repo,
> +                        const char *remote_name,
>                          const struct object_id *oids,
>                          int oid_nr)
>  {
> @@ -21,6 +22,11 @@ static int fetch_objects(const char *remote_name,
>
>         child.git_cmd = 1;
>         child.in = -1;
> +       if (repo != the_repository) {
> +               prepare_other_repo_env(&child.env_array);
> +               strvec_pushf(&child.env_array, "%s=%s", GIT_DIR_ENVIRONMENT,
> +                            repo->gitdir);
> +       }
>         strvec_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=noop",
>                      "fetch", remote_name, "--no-tags",
>                      "--no-write-fetch-head", "--recurse-submodules=no",
> @@ -150,7 +156,7 @@ static void promisor_remote_init(struct repository *r)
>                 xcalloc(sizeof(*r->promisor_remote_config), 1);
>         config->promisors_tail = &config->promisors;
>
> -       git_config(promisor_remote_config, config);
> +       repo_config(r, promisor_remote_config, config);
>
>         if (config->repository_format_partial_clone) {
>                 struct promisor_remote *o, *previous;
> @@ -246,10 +252,8 @@ int promisor_remote_get_direct(struct repository *repo,
>
>         promisor_remote_init(repo);
>
> -       if (repo != the_repository)
> -               BUG("only the_repository is supported for now");
>         for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
> -               if (fetch_objects(r->name, remaining_oids, remaining_nr) < 0) {
> +               if (fetch_objects(repo, r->name, remaining_oids, remaining_nr) < 0) {
>                         if (remaining_nr == 1)
>                                 continue;
>                         remaining_nr = remove_fetched_oids(repo, &remaining_oids,
> diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
> new file mode 100644
> index 0000000000..e7bc7eb21f
> --- /dev/null
> +++ b/t/helper/test-partial-clone.c
> @@ -0,0 +1,34 @@
> +#include "cache.h"
> +#include "test-tool.h"
> +#include "repository.h"
> +#include "object-store.h"
> +
> +static void object_info(const char *gitdir, const char *oid_hex)
> +{
> +       struct repository r;
> +       struct object_id oid;
> +       unsigned long size;
> +       struct object_info oi = {.sizep = &size};
> +       const char *p;
> +
> +       if (repo_init(&r, gitdir, NULL))
> +               die("could not init repo");
> +       if (parse_oid_hex(oid_hex, &oid, &p))
> +               die("could not parse oid");
> +       if (oid_object_info_extended(&r, &oid, &oi, 0))
> +               die("could not obtain object info");
> +       printf("%d\n", (int) size);
> +}
> +
> +int cmd__partial_clone(int argc, const char **argv)
> +{
> +       if (argc < 4)
> +               die("too few arguments");
> +
> +       if (!strcmp(argv[1], "object-info"))
> +               object_info(argv[2], argv[3]);
> +       else
> +               die("invalid argument '%s'", argv[1]);
> +
> +       return 0;
> +}
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index c5bd0c6d4c..b21e8f1519 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -46,6 +46,7 @@ static struct test_cmd cmds[] = {
>         { "online-cpus", cmd__online_cpus },
>         { "parse-options", cmd__parse_options },
>         { "parse-pathspec-file", cmd__parse_pathspec_file },
> +       { "partial-clone", cmd__partial_clone },
>         { "path-utils", cmd__path_utils },
>         { "pcre2-config", cmd__pcre2_config },
>         { "pkt-line", cmd__pkt_line },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index e8069a3b22..f845ced4b3 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -35,6 +35,7 @@ int cmd__oidmap(int argc, const char **argv);
>  int cmd__online_cpus(int argc, const char **argv);
>  int cmd__parse_options(int argc, const char **argv);
>  int cmd__parse_pathspec_file(int argc, const char** argv);
> +int cmd__partial_clone(int argc, const char **argv);
>  int cmd__path_utils(int argc, const char **argv);
>  int cmd__pcre2_config(int argc, const char **argv);
>  int cmd__pkt_line(int argc, const char **argv);
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 584a039b85..e804d267e6 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -604,6 +604,30 @@ test_expect_success 'do not fetch when checking existence of tree we construct o
>         git -C repo cherry-pick side1
>  '
>
> +test_expect_success 'lazy-fetch when accessing object not in the_repository' '
> +       rm -rf full partial.git &&
> +       test_create_repo full &&
> +       printf 12345 >full/file.txt &&
> +       git -C full add file.txt &&
> +       git -C full commit -m "first commit" &&
> +
> +       test_config -C full uploadpack.allowfilter 1 &&
> +       test_config -C full uploadpack.allowanysha1inwant 1 &&
> +       git clone --filter=blob:none --bare "file://$(pwd)/full" partial.git &&
> +       FILE_HASH=$(git hash-object --stdin <full/file.txt) &&
> +
> +       # Sanity check that the file is missing
> +       git -C partial.git rev-list --objects --missing=print HEAD >out &&
> +       grep "[?]$FILE_HASH" out &&
> +
> +       OUT=$(test-tool partial-clone object-info partial.git "$FILE_HASH") &&
> +       test "$OUT" -eq 5 &&
> +
> +       # Sanity check that the file is now present
> +       git -C partial.git rev-list --objects --missing=print HEAD >out &&
> +       ! grep "[?]$FILE_HASH" out
> +'
> +
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd
>
> --
> 2.32.0.rc0.204.g9fa02ecfa5-goog

Looks good to me.
