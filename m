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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E45C48BDF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 21:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6A761059
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 21:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhFJVcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 17:32:16 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44012 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFJVcM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 17:32:12 -0400
Received: by mail-ot1-f45.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso1115441otu.10
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 14:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igTf5iJLbCcOgO5o4waYO+/9w5PFYeKnVQRvHQMkDQQ=;
        b=MqGxqRePyUY0rKER2Un8J4Ah+g35fB1oUGUJNLa18A6ofmigBUPFsN9Ng5+HNl8es6
         TNAFSrIimkjjDhGO0VZaF48OGS/kPCtUlsNe5jtMHqJlQG/m3BiM+lb9n93rYxoZ+gxo
         ltkk9uFYeYqX+r5+I8GkRg9B5HKec1nRjWMP1YfZjLlQibpmWDDgxJQhdulYPCigsQ7Y
         cyRS3Vri4y8iYjoEo9pvvDQlc3u2VlRt3bZMt3vk7T87NUK7YVDSEgnY2N2J1yKhKIIG
         a3cipO04DEwNJYSKE3g1x6e/6U9MQWm1RVXLfJuwz+B3DqZKm23JzhaiAor7rnW6aerI
         Qw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igTf5iJLbCcOgO5o4waYO+/9w5PFYeKnVQRvHQMkDQQ=;
        b=W1bMOZlUP0pCa3cMOJ9BCoB7FS2MG7y4vxUSr3e7OHDCiPZPSMsIp7pkyYa+G5aZdj
         RzzI0SuF4GStMqCLk9FkCt/jzGHfbZl1fd8PFZ924HtNu9r+MNhO2IQJ2s0xxjhsEpvU
         +6MRndbT8L8o8A4rFQxY2yKkKKYGgtym5bEHJ4fqxfLYEDFwKW9UOIKLGXlfIVjM/bmO
         U50DbtHm2blhgWDWnfb94uwolyM0vOR7+GAlauXNg7RSpdxudY31/t79Byh3obZuruB5
         +pc7kSoGyBeaDMjUXGz1l8FcpwKFLKq4ZMIm3j1Z9jpcM34cQZFYZq1DlsNktvIP64TQ
         gLBA==
X-Gm-Message-State: AOAM532qcEe/lHTqk6NzZF9WkEkU7QP6cAV7zECw29Me4xV8VCilnbIE
        zLrfWoqtLOC0F2a5sWEE1I+yzdGxQCN42gLo8jQ=
X-Google-Smtp-Source: ABdhPJwZ0hRzMCIaGuhRbpsQ9nJysKK6g5oCzFwvEKe8rHHzscnpnvGr+uRF21VOXeXk7uGA2QWZA9QRJfdCm/LiQtg=
X-Received: by 2002:a9d:1a8:: with SMTP id e37mr326413ote.316.1623360555258;
 Thu, 10 Jun 2021 14:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com> <cover.1623345496.git.jonathantanmy@google.com>
In-Reply-To: <cover.1623345496.git.jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 10 Jun 2021 14:29:03 -0700
Message-ID: <CABPp-BEEiPP7AEk4Wexw4_MDHcin2n8xkMowO=OXTn9pNPaG0A@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] First steps towards partial clone submodules
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 10:35 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> I think I've addressed all review comments. As for Junio's suggestion
> about also printing the type in the former patch 4 (now patch 5) [1], I
> decided to just leave the code as-is and not also print the type.
>
> The main changes are that patch 1 is somewhat rewritten - we still
> remove the global variable, but we no longer read the
> extensions.partialClone config directly from promisor-remote.c. Instead,
> we store it in struct repository when the format of a repository is
> being verified, and promisor-remote.c merely reads it from there. Patch
> 3 is a new patch that updates the environment variable preparation
> before it is moved in patch 4 (formerly patch 3).

I've read through all the patches.  2 & 5 look good to me, I had small
nitpicks on 1 & 4, and I'm totally lost on patch 3.  Patch 3 is just a
one-liner and it might be fine, but for some reason I can't figure out
the code before or after the patch even after digging around into
other commits and other files to try to get my bearings.  Hopefully
someone else can comment on that one.

>
> [1] https://lore.kernel.org/git/xmqq7dj2ik7k.fsf@gitster.g/
>
> Jonathan Tan (5):
>   repository: move global r_f_p_c to repo struct
>   promisor-remote: support per-repository config
>   submodule: refrain from filtering GIT_CONFIG_COUNT
>   run-command: refactor subprocess env preparation
>   promisor-remote: teach lazy-fetch in any repo
>
>  Makefile                      |   1 +
>  object-file.c                 |   7 +--
>  promisor-remote.c             | 108 ++++++++++++++++++----------------
>  promisor-remote.h             |  28 ++++++---
>  repository.c                  |   9 +++
>  repository.h                  |   5 ++
>  run-command.c                 |  12 ++++
>  run-command.h                 |  10 ++++
>  setup.c                       |  16 +++--
>  submodule.c                   |  17 +-----
>  t/helper/test-partial-clone.c |  43 ++++++++++++++
>  t/helper/test-tool.c          |   1 +
>  t/helper/test-tool.h          |   1 +
>  t/t0410-partial-clone.sh      |  23 ++++++++
>  14 files changed, 196 insertions(+), 85 deletions(-)
>  create mode 100644 t/helper/test-partial-clone.c
>
> Range-diff against v2:
> 1:  d99598ca50 < -:  ---------- promisor-remote: read partialClone config here
> -:  ---------- > 1:  255d112256 repository: move global r_f_p_c to repo struct
> 2:  5a1ccae335 ! 2:  a52448cff2 promisor-remote: support per-repository config
>     @@ promisor-remote.c
>       #include "transport.h"
>       #include "strvec.h"
>
>     --static char *repository_format_partial_clone;
>      +struct promisor_remote_config {
>     -+  char *repository_format_partial_clone;
>      +  struct promisor_remote *promisors;
>      +  struct promisor_remote **promisors_tail;
>      +};
>     -
>     ++
>       static int fetch_objects(const char *remote_name,
>                          const struct object_id *oids,
>     +                    int oid_nr)
>      @@ promisor-remote.c: static int fetch_objects(const char *remote_name,
>         return finish_command(&child) ? -1 : 0;
>       }
>     @@ promisor-remote.c: static void promisor_remote_move_to_tail(struct promisor_remo
>         const char *name;
>         size_t namelen;
>         const char *subkey;
>     -@@ promisor-remote.c: static int promisor_remote_config(const char *var, const char *value, void *data
>     -            * NULL value is handled in handle_extension_v0 in setup.c.
>     -            */
>     -           if (value)
>     --                  repository_format_partial_clone = xstrdup(value);
>     -+                  config->repository_format_partial_clone = xstrdup(value);
>     -           return 0;
>     -   }
>     -
>      @@ promisor-remote.c: static int promisor_remote_config(const char *var, const char *value, void *data
>
>                 remote_name = xmemdupz(name, namelen);
>     @@ promisor-remote.c: static int promisor_remote_config(const char *var, const char
>      +  config->promisors_tail = &config->promisors;
>
>      -  git_config(promisor_remote_config, NULL);
>     -+  git_config(promisor_remote_config, config);
>     ++  repo_config(r, promisor_remote_config, config);
>
>     --  if (repository_format_partial_clone) {
>     -+  if (config->repository_format_partial_clone) {
>     +-  if (the_repository->repository_format_partial_clone) {
>     ++  if (r->repository_format_partial_clone) {
>                 struct promisor_remote *o, *previous;
>
>     --          o = promisor_remote_lookup(repository_format_partial_clone,
>     +-          o = promisor_remote_lookup(the_repository->repository_format_partial_clone,
>      +          o = promisor_remote_lookup(config,
>     -+                                     config->repository_format_partial_clone,
>     ++                                     r->repository_format_partial_clone,
>                                            &previous);
>                 if (o)
>      -                  promisor_remote_move_to_tail(o, previous);
>      +                  promisor_remote_move_to_tail(config, o, previous);
>                 else
>     --                  promisor_remote_new(repository_format_partial_clone);
>     -+                  promisor_remote_new(config, config->repository_format_partial_clone);
>     +-                  promisor_remote_new(the_repository->repository_format_partial_clone);
>     ++                  promisor_remote_new(config, r->repository_format_partial_clone);
>         }
>       }
>
>     @@ promisor-remote.c: static int promisor_remote_config(const char *var, const char
>      -  while (promisors) {
>      -          struct promisor_remote *r = promisors;
>      -          promisors = promisors->next;
>     -+  FREE_AND_NULL(config->repository_format_partial_clone);
>     -+
>      +  while (config->promisors) {
>      +          struct promisor_remote *r = config->promisors;
>      +          config->promisors = config->promisors->next;
>     @@ repository.h: struct lock_file;
>       enum untracked_cache_setting {
>         UNTRACKED_CACHE_UNSET = -1,
>      @@ repository.h: struct repository {
>     -   /* True if commit-graph has been disabled within this process. */
>     -   int commit_graph_disabled;
>
>     -+  /* Configurations related to promisor remotes. */
>     +   /* Configurations related to promisor remotes. */
>     +   char *repository_format_partial_clone;
>      +  struct promisor_remote_config *promisor_remote_config;
>     -+
>     +
>         /* Configurations */
>
>     -   /* Indicate if a repository has a different 'commondir' from 'gitdir' */
> -:  ---------- > 3:  e1a40108f4 submodule: refrain from filtering GIT_CONFIG_COUNT
> 3:  3f7c4e6e67 ! 4:  fd6907822c run-command: move envvar-resetting function
>     @@ Metadata
>      Author: Jonathan Tan <jonathantanmy@google.com>
>
>       ## Commit message ##
>     -    run-command: move envvar-resetting function
>     +    run-command: refactor subprocess env preparation
>
>     -    There is a function that resets environment variables, used when
>     -    invoking a sub-process in a submodule. The lazy-fetching code (used in
>     -    partial clones) will need this function in a subsequent commit, so move
>     -    it to a more central location.
>     +    submodule.c has functionality that prepares the environment for running
>     +    a subprocess in a new repo. The lazy-fetching code (used in partial
>     +    clones) will need this in a subsequent commit, so move it to a more
>     +    central location.
>
>          Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>
>     @@ run-command.c: int run_auto_maintenance(int quiet)
>         return run_command(&maint);
>       }
>      +
>     -+void prepare_other_repo_env(struct strvec *env_array)
>     ++void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir)
>      +{
>      +  const char * const *var;
>      +
>      +  for (var = local_repo_env; *var; var++) {
>     -+          if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
>     ++          if (strcmp(*var, CONFIG_DATA_ENVIRONMENT) &&
>     ++              strcmp(*var, CONFIG_COUNT_ENVIRONMENT))
>      +                  strvec_push(env_array, *var);
>      +  }
>     ++  strvec_pushf(env_array, "%s=%s", GIT_DIR_ENVIRONMENT, new_git_dir);
>      +}
>
>       ## run-command.h ##
>     @@ run-command.h: int run_processes_parallel_tr2(int n, get_next_task_fn, start_fai
>                                const char *tr2_category, const char *tr2_label);
>
>      +/**
>     -+ * Convenience function which adds all GIT_* environment variables to env_array
>     -+ * with the exception of GIT_CONFIG_PARAMETERS. When used as the env_array of a
>     -+ * subprocess, these entries cause the corresponding environment variables to
>     -+ * be unset in the subprocess. See local_repo_env in cache.h for more
>     ++ * Convenience function which prepares env_array for a command to be run in a
>     ++ * new repo. This adds all GIT_* environment variables to env_array with the
>     ++ * exception of GIT_CONFIG_PARAMETERS (which cause the corresponding
>     ++ * environment variables to be unset in the subprocess) and adds an environment
>     ++ * variable pointing to new_git_dir. See local_repo_env in cache.h for more
>      + * information.
>      + */
>     -+void prepare_other_repo_env(struct strvec *env_array);
>     ++void prepare_other_repo_env(struct strvec *env_array, const char *new_git_dir);
>      +
>       #endif
>
>     @@ submodule.c: static void print_submodule_diff_summary(struct repository *r, stru
>      -  const char * const *var;
>      -
>      -  for (var = local_repo_env; *var; var++) {
>     --          if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
>     +-          if (strcmp(*var, CONFIG_DATA_ENVIRONMENT) &&
>     +-              strcmp(*var, CONFIG_COUNT_ENVIRONMENT))
>      -                  strvec_push(out, *var);
>      -  }
>      -}
>     @@ submodule.c: static void print_submodule_diff_summary(struct repository *r, stru
>       void prepare_submodule_repo_env(struct strvec *out)
>       {
>      -  prepare_submodule_repo_env_no_git_dir(out);
>     -+  prepare_other_repo_env(out);
>     -   strvec_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
>     -                DEFAULT_GIT_DIR_ENVIRONMENT);
>     +-  strvec_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
>     +-               DEFAULT_GIT_DIR_ENVIRONMENT);
>     ++  prepare_other_repo_env(out, DEFAULT_GIT_DIR_ENVIRONMENT);
>       }
>
>       static void prepare_submodule_repo_env_in_gitdir(struct strvec *out)
>       {
>      -  prepare_submodule_repo_env_no_git_dir(out);
>     -+  prepare_other_repo_env(out);
>     -   strvec_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
>     +-  strvec_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
>     ++  prepare_other_repo_env(out, ".");
>       }
>
>     + /*
> 4:  655607d575 ! 5:  a6d73662b1 promisor-remote: teach lazy-fetch in any repo
>     @@ Commit message
>          prevents testing of the functionality in this patch by user-facing
>          commands. So for now, test this mechanism using a test helper.
>
>     +    Besides that, there is some code that uses the wrapper functions
>     +    like has_promisor_remote(). Those will need to be checked to see if they
>     +    could support the non-wrapper functions instead (and thus support any
>     +    repository, not just the_repository).
>     +
>          Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>
>       ## Makefile ##
>     @@ promisor-remote.c: static int fetch_objects(const char *remote_name,
>
>         child.git_cmd = 1;
>         child.in = -1;
>     -+  if (repo != the_repository) {
>     -+          prepare_other_repo_env(&child.env_array);
>     -+          strvec_pushf(&child.env_array, "%s=%s", GIT_DIR_ENVIRONMENT,
>     -+                       repo->gitdir);
>     -+  }
>     ++  if (repo != the_repository)
>     ++          prepare_other_repo_env(&child.env_array, repo->gitdir);
>         strvec_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=noop",
>                      "fetch", remote_name, "--no-tags",
>                      "--no-write-fetch-head", "--recurse-submodules=no",
>     -@@ promisor-remote.c: static void promisor_remote_init(struct repository *r)
>     -           xcalloc(sizeof(*r->promisor_remote_config), 1);
>     -   config->promisors_tail = &config->promisors;
>     -
>     --  git_config(promisor_remote_config, config);
>     -+  repo_config(r, promisor_remote_config, config);
>     -
>     -   if (config->repository_format_partial_clone) {
>     -           struct promisor_remote *o, *previous;
>      @@ promisor-remote.c: int promisor_remote_get_direct(struct repository *repo,
>
>         promisor_remote_init(repo);
> --
> 2.32.0.rc1.229.g3e70b5a671-goog
>
