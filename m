Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5902C77B7C
	for <git@archiver.kernel.org>; Wed, 31 May 2023 04:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjEaElx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 00:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjEaElu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 00:41:50 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5B710E
        for <git@vger.kernel.org>; Tue, 30 May 2023 21:41:47 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2af2958db45so55495221fa.1
        for <git@vger.kernel.org>; Tue, 30 May 2023 21:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685508106; x=1688100106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8m5lycifajSeR/xxN25rwrD/AtNXC1kjlWheJKQJfM=;
        b=hufthvW5TXDUCHR+GgofasJ2rdnBX9Ry2lJE54yvn9I99PwQ989JCq+iGhJ/y+qat2
         4dwbcO5zPaXxysuH81SDzDVs1f+V6ZHVxo2toApeVPOc4u2E56ZvVZ0W/dcPddAbr7au
         XS2qOgX4vi7KmxBMW8W7NLC9tMSokbkI8rjsaluf5LV/zHfpZV600ldI6S/3wnxj0aP0
         r3JYZG7oufGBLaUhmTVAm+sJUjBUYmM5vFHNDyrAY2cMNzXvSzRFo3lTF9/lsffSsvel
         DfFAhy22MSu94W4PYks0eioaMShQb6sIHab56xjfCsV0XZ0YNWjeAMk4VXt3N1Pq9JIi
         lkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685508106; x=1688100106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8m5lycifajSeR/xxN25rwrD/AtNXC1kjlWheJKQJfM=;
        b=Ij8bX+RwzUMrsov6efYaoFWm+BY7cmZ4O8/0/81vY5Ad0iLFpt119h//K+NbPhc+lM
         lw3F+jX/h9g6BLEjhJEGkeG9nQrzBW59R6SmNzgIzqHQ21+QcRZa0eH9RcCnfY1Bdjmf
         Nf3noNXKRRkRMmzUUJ5XNnvsM+nQN48OKaeJUvRt1Ymz+T4pB2QgHyKjdwNPYQC60qWZ
         CrsL+zYB7QeSr7sk5J541YWQLWvigf/RNQSgayG4E1B5thv+CsFeumvDWD5jaDM8CkbE
         9q78LLNMGc9hKF1feMvz6HCKiZ6vr2S/u2neerjSww8oCPvVdn7Qz1R5HO1i+i43nc18
         ey+Q==
X-Gm-Message-State: AC+VfDx+dSw4RDyPnpfl8wwUIpGGpzG5YLPxvkuBvhSU5IqlXfXckgeh
        3qBNJ4FezqGjMEG9CS1gMLqOuQJjjzHSOacxCes=
X-Google-Smtp-Source: ACHHUZ7mr5uGBAhYt2vPyGw7GcAtCEwmBYD+K/MicphUfQzm0qE/Uk/xpjbfbsfj8/sx9GE2tN1hGWKHL191e4sWb44=
X-Received: by 2002:a2e:9f0d:0:b0:2ac:7ae8:2c24 with SMTP id
 u13-20020a2e9f0d000000b002ac7ae82c24mr1782188ljk.45.1685508105865; Tue, 30
 May 2023 21:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com> <56544abc15d1fce6fb4a0946e709470af9225395.1685126618.git.gitgitgadget@gmail.com>
In-Reply-To: <56544abc15d1fce6fb4a0946e709470af9225395.1685126618.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 May 2023 21:41:33 -0700
Message-ID: <CABPp-BFzA0yVecHK1DEGMpAhewm7oyqEim7BCw7-DTKpUzWnpw@mail.gmail.com>
Subject: Re: [PATCH 1/3] repository: create disable_replace_refs()
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, me@ttaylorr.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 26, 2023 at 11:43=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <derrickstolee@github.com>
>
> Several builtins depend on being able to disable the replace references
> so we actually operate on each object individually. These currently do
> so by directly mutating the 'read_replace_refs' global.
>
> A future change will move this global into a different place, so it will
> be necessary to change all of these lines. However, we can simplify that
> transition by abstracting the purpose of these global assignments with a
> method call.
>
> We will never scope this to an in-memory repository as we want to make
> sure that we never use replace refs throughout the life of the process
> if this method is called.

I'm confused; doesn't the 3rd patch do exactly what this paragraph
says you'll never do?

> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/cat-file.c       | 2 +-
>  builtin/commit-graph.c   | 5 ++---
>  builtin/fsck.c           | 2 +-
>  builtin/index-pack.c     | 2 +-
>  builtin/pack-objects.c   | 3 +--
>  builtin/prune.c          | 3 ++-
>  builtin/replace.c        | 3 ++-
>  builtin/unpack-objects.c | 3 +--
>  builtin/upload-pack.c    | 3 ++-
>  environment.c            | 2 +-
>  git.c                    | 2 +-
>  replace-object.c         | 5 +++++
>  replace-object.h         | 8 ++++++++
>  repo-settings.c          | 1 +
>  14 files changed, 29 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 0bafc14e6c0..27f070267a4 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -805,7 +805,7 @@ static int batch_objects(struct batch_options *opt)
>                 if (repo_has_promisor_remote(the_repository))
>                         warning("This repository uses promisor remotes. S=
ome objects may not be loaded.");
>
> -               read_replace_refs =3D 0;
> +               disable_replace_refs();
>
>                 cb.opt =3D opt;
>                 cb.expand =3D &data;
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index a3d00fa232b..639c9ca8b91 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -122,7 +122,6 @@ static int graph_verify(int argc, const char **argv, =
const char *prefix)
>         return ret;
>  }
>
> -extern int read_replace_refs;
>  static struct commit_graph_opts write_opts;
>
>  static int write_option_parse_split(const struct option *opt, const char=
 *arg,
> @@ -323,13 +322,13 @@ int cmd_commit_graph(int argc, const char **argv, c=
onst char *prefix)
>         struct option *options =3D parse_options_concat(builtin_commit_gr=
aph_options, common_opts);
>
>         git_config(git_default_config, NULL);
> -
> -       read_replace_refs =3D 0;
>         save_commit_buffer =3D 0;
>
>         argc =3D parse_options(argc, argv, prefix, options,
>                              builtin_commit_graph_usage, 0);
>         FREE_AND_NULL(options);
>
> +       disable_replace_refs();
> +

In this place and several others in the file, you opt to not just
replace the assignment with a function call, but move the action line
to later in the file.  In some cases, much later.

I don't think it hurts things, but it certainly makes me wonder why it
was moved.  Did it break for some reason when called earlier?  (Is
there something trickier about this patch than I expected?)

>         return fn(argc, argv, prefix);
>  }
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 2cd461b84c1..8a2d7afc83a 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -927,7 +927,6 @@ int cmd_fsck(int argc, const char **argv, const char =
*prefix)
>         fetch_if_missing =3D 0;
>
>         errors_found =3D 0;
> -       read_replace_refs =3D 0;
>         save_commit_buffer =3D 0;
>
>         argc =3D parse_options(argc, argv, prefix, fsck_opts, fsck_usage,=
 0);
> @@ -953,6 +952,7 @@ int cmd_fsck(int argc, const char **argv, const char =
*prefix)
>
>         git_config(git_fsck_config, &fsck_obj_options);
>         prepare_repo_settings(the_repository);
> +       disable_replace_refs();
>
>         if (connectivity_only) {
>                 for_each_loose_object(mark_loose_for_connectivity, NULL, =
0);
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index bb67e166559..d0d8067510b 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1752,7 +1752,7 @@ int cmd_index_pack(int argc, const char **argv, con=
st char *prefix)
>         if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
>                 usage(index_pack_usage);
>
> -       read_replace_refs =3D 0;
> +       disable_replace_refs();
>         fsck_options.walk =3D mark_link;
>
>         reset_pack_idx_option(&opts);
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index a5b466839ba..55635bdf4b4 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -4284,9 +4284,8 @@ int cmd_pack_objects(int argc, const char **argv, c=
onst char *prefix)
>         if (DFS_NUM_STATES > (1 << OE_DFS_STATE_BITS))
>                 BUG("too many dfs states, increase OE_DFS_STATE_BITS");
>
> -       read_replace_refs =3D 0;
> -
>         sparse =3D git_env_bool("GIT_TEST_PACK_SPARSE", -1);
> +       disable_replace_refs();
>         if (the_repository->gitdir) {
>                 prepare_repo_settings(the_repository);
>                 if (sparse < 0)
> diff --git a/builtin/prune.c b/builtin/prune.c
> index 5dc9b207200..a8f3848c3a3 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -164,7 +164,6 @@ int cmd_prune(int argc, const char **argv, const char=
 *prefix)
>
>         expire =3D TIME_MAX;
>         save_commit_buffer =3D 0;
> -       read_replace_refs =3D 0;
>         repo_init_revisions(the_repository, &revs, prefix);
>
>         argc =3D parse_options(argc, argv, prefix, options, prune_usage, =
0);
> @@ -172,6 +171,8 @@ int cmd_prune(int argc, const char **argv, const char=
 *prefix)
>         if (repository_format_precious_objects)
>                 die(_("cannot prune in a precious-objects repo"));
>
> +       disable_replace_refs();
> +
>         while (argc--) {
>                 struct object_id oid;
>                 const char *name =3D *argv++;
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 981f1894436..6c6f0b3ed01 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -566,11 +566,12 @@ int cmd_replace(int argc, const char **argv, const =
char *prefix)
>                 OPT_END()
>         };
>
> -       read_replace_refs =3D 0;
>         git_config(git_default_config, NULL);
>
>         argc =3D parse_options(argc, argv, prefix, options, git_replace_u=
sage, 0);
>
> +       disable_replace_refs();
> +
>         if (!cmdmode)
>                 cmdmode =3D argc ? MODE_REPLACE : MODE_LIST;
>
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 2c52c3a741f..3f5f6719405 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -609,9 +609,8 @@ int cmd_unpack_objects(int argc, const char **argv, c=
onst char *prefix UNUSED)
>         int i;
>         struct object_id oid;
>
> -       read_replace_refs =3D 0;
> -
>         git_config(git_default_config, NULL);
> +       disable_replace_refs();
>
>         quiet =3D !isatty(2);
>
> diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
> index beb9dd08610..6fc9a8feab0 100644
> --- a/builtin/upload-pack.c
> +++ b/builtin/upload-pack.c
> @@ -36,7 +36,6 @@ int cmd_upload_pack(int argc, const char **argv, const =
char *prefix)
>         };
>
>         packet_trace_identity("upload-pack");
> -       read_replace_refs =3D 0;
>
>         argc =3D parse_options(argc, argv, prefix, options, upload_pack_u=
sage, 0);
>
> @@ -50,6 +49,8 @@ int cmd_upload_pack(int argc, const char **argv, const =
char *prefix)
>         if (!enter_repo(dir, strict))
>                 die("'%s' does not appear to be a git repository", dir);
>
> +       disable_replace_refs();
> +
>         switch (determine_protocol_version_server()) {
>         case protocol_v2:
>                 if (advertise_refs)
> diff --git a/environment.c b/environment.c
> index 8a96997539a..3b4d87c322f 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -185,7 +185,7 @@ void setup_git_env(const char *git_dir)
>         strvec_clear(&to_free);
>
>         if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
> -               read_replace_refs =3D 0;
> +               disable_replace_refs();
>         replace_ref_base =3D getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
>         git_replace_ref_base =3D xstrdup(replace_ref_base ? replace_ref_b=
ase
>                                                           : "refs/replace=
/");
> diff --git a/git.c b/git.c
> index 45899be8265..3252d4c7661 100644
> --- a/git.c
> +++ b/git.c
> @@ -185,7 +185,7 @@ static int handle_options(const char ***argv, int *ar=
gc, int *envchanged)
>                         if (envchanged)
>                                 *envchanged =3D 1;
>                 } else if (!strcmp(cmd, "--no-replace-objects")) {
> -                       read_replace_refs =3D 0;
> +                       disable_replace_refs();
>                         setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "1", 1);
>                         if (envchanged)
>                                 *envchanged =3D 1;
> diff --git a/replace-object.c b/replace-object.c
> index e98825d5852..ceec81c940c 100644
> --- a/replace-object.c
> +++ b/replace-object.c
> @@ -84,3 +84,8 @@ const struct object_id *do_lookup_replace_object(struct=
 repository *r,
>         }
>         die(_("replace depth too high for object %s"), oid_to_hex(oid));
>  }
> +
> +void disable_replace_refs(void)
> +{
> +       read_replace_refs =3D 0;
> +}
> diff --git a/replace-object.h b/replace-object.h
> index 500482b02b3..7786d4152b0 100644
> --- a/replace-object.h
> +++ b/replace-object.h
> @@ -48,4 +48,12 @@ static inline const struct object_id *lookup_replace_o=
bject(struct repository *r
>         return do_lookup_replace_object(r, oid);
>  }
>
> +/*
> + * Some commands override config and environment settings for using
> + * replace references. Use this method to disable the setting and ensure
> + * those other settings will not override this choice. This applies
> + * globally to all in-process repositories.
> + */
> +void disable_replace_refs(void);
> +
>  #endif /* REPLACE_OBJECT_H */
> diff --git a/repo-settings.c b/repo-settings.c
> index 7b566d729d0..1df0320bf33 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -3,6 +3,7 @@
>  #include "repository.h"
>  #include "midx.h"
>  #include "compat/fsmonitor/fsm-listen.h"
> +#include "environment.h"

Why?  There are no other changes in this file, so I don't see why
you'd need another include.

>
>  static void repo_cfg_bool(struct repository *r, const char *key, int *de=
st,
>                           int def)
> --
> gitgitgadget

I think the patch is probably fine, but I saw a few things that made
me wonder if I had missed something important, highlighted above.
