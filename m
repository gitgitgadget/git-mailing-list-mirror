Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7296A2066CF
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007755; cv=none; b=au2opFFlJMhHZAtsOGcPVRGRp746xiTvP9iD/laeWz8TbkaRpl+rfDdjL9OX1h2EGMHbM6MWlB6HfxkGyImEnfr5xnaN5my91D70S6GA99GCyXyBQBvOj5dMmV9pgEbEeMHuoPqmbQl4dBnvKuL4XydImxA2eiT4DUhYPqJghwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007755; c=relaxed/simple;
	bh=x9LowOJgjKQJjXVQFJPvb3imyiHtX8w0wvkHA6kO6rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SeOdl/2hL2sa9SDbCMBwMtvLW2UAX43VyYnAA1ciUrH++N+JAG5KkJbsshCHyXwnPxqKgbO2z/k/cG239tAngqkiKhmdbxRrN+G7n5Mlbdn8yXx4KgBvn6LkagDSRdDjV3H9xeup2g70JLedt5engtgtzwz8k4ooJOgBsquJm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzP5QVuO; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzP5QVuO"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3df2d111fefso42932445ab.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752007752; x=1752612552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hINcbh5LHaVCvvCPi9zv4PIGCyAy4s0gciuJ7UWlwE=;
        b=JzP5QVuOav5fXj+f8ERxe3cZtArxls0nWiwCxSkdrxjjPnJzsVYX+mlFMrKHVUgIWP
         DAm8l1UhpNjYbw7+hKVymti7U8qjIGyjW2JGEP48fUk/zGf9EiTCCt2COdcd/pujRgKE
         kNPtRXSTzPP75R25/bI96sLjAGcBvwwN7Fvk367gbItN7W/qd7OiqJhtgGvI1YP8OaML
         oHh0++ZAAjEggBodfu5HkU4SgMRORCnXvv6/cVeBQULDLz11TYu7oSG9n7LMfsmYq6PZ
         qAqAn/CDN1NihSS1OVZJrWK3YEQNOHkeHZh8ud4VzRLoavmDX8ykAypSjn7PY3k0zW9D
         dtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752007752; x=1752612552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hINcbh5LHaVCvvCPi9zv4PIGCyAy4s0gciuJ7UWlwE=;
        b=EkoOshrMhrXLEQUkXSWPN6PdvmtJjTwDGhEQal72uGZJ5RRk9JtELjMPseSKmvRw4/
         rvCv/X4+eOSAGXVf+FYKmgadCJhBvVeZU6jg4MU+SnsdJQVzdvhZHpYACMEP6QAPKTKB
         dLr0PA+wZjDyyqYaLuI0NXfe32KjtroUnZSFzPTBxkVBClGLUNQHUZIv3h4YU2HY+fXK
         8srJ3Ehq0Ss9vCE1LKjKuthI2cN8EDCkM32GnA5QFA90tamKrelyTbzGIXeZmXu895Nf
         djA7rZtxOQ/0r8JMEVXEQ9/rRea0OY/ofkPSWmfjHdQX8rWgj8RjA0mEwJKq+jEqetQ6
         uE1A==
X-Gm-Message-State: AOJu0YyKuimlr9qa8hBarYmeMoc7cfWsyS3iIL07tYMUzZzHm1Aiw8Yg
	2J2P55bFyI/o2c/0Fxot9y3ovLsA93oBh2nwjSvbP8NHDbmlFPZtPkkLOTQa5nEbHznilG2DVYB
	KR8nbwO/ur6xx1ajtTwpLMtNf7gRvcg4=
X-Gm-Gg: ASbGncvi8ckky3LKML4bAgByUtw7z7cMlWgHR7nxInHXhgkg4bRTBv0/CjfWkOSRJ7z
	2HZC7r+XSzXFDcWRTnJtb35O7s8QfkKvzihnYjV0t8PS7NIeE4b0o+q4yaWyx04SSXPthHPDx5L
	DofH5abl/irOJaXiNXJtdMkdYNPGcUxNTj9SgEfd8frXeAF11vlPuvHSUjnA==
X-Google-Smtp-Source: AGHT+IG/twxHhmK/qHM9pGAkw+lhKLwVbNz2On2vRucLPA6QgWqY44Yt/9LpQK5bJCc1OgdhjZG0YJaCmY/TjyDWURI=
X-Received: by 2002:a05:6e02:2487:b0:3df:45bb:2900 with SMTP id
 e9e14a558f8ab-3e1670007a7mr2012475ab.5.1752007752283; Tue, 08 Jul 2025
 13:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com> <3cdc44a9e8c8e6718b24bc25def291348a0b2613.1751973594.git.gitgitgadget@gmail.com>
In-Reply-To: <3cdc44a9e8c8e6718b24bc25def291348a0b2613.1751973594.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 8 Jul 2025 13:49:01 -0700
X-Gm-Features: Ac12FXxhbCeQ82lu221vfA5cNARoEIC4YZJ29suUSniDX5CDfxaFkopPWmYYbEs
Message-ID: <CABPp-BFu+0jME-56y+yyFYAUomfBHYrwDhr8hDLNCrp5oiOaXQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] sparse-checkout: remove use of the_repository
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 4:20=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> The logic for the 'git sparse-checkout' builtin uses the_repository all
> over the place, despite some use of a repository struct in different
> method parameters. Complete this removal of the_repository by using
> 'repo' when possible.
>
> In one place, there was already a local variable 'r' that was set to
> the_repository, so move that to a method parameter.

Always nice to see these cleanups.

> We cannot remove the USE_THE_REPOSITORY_VARIABLE declaration as we are
> still using global constants for the state of the sparse-checkout.

Thanks for calling this out and explaining it.

> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  builtin/sparse-checkout.c | 119 ++++++++++++++++++++------------------
>  1 file changed, 63 insertions(+), 56 deletions(-)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 1bf01591b275..8b70d0c6a441 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -204,12 +204,12 @@ static void clean_tracked_sparse_directories(struct=
 repository *r)
>                 ensure_full_index(r->index);
>  }
>
> -static int update_working_directory(struct pattern_list *pl)
> +static int update_working_directory(struct repository *r,
> +                                   struct pattern_list *pl)
>  {
>         enum update_sparsity_result result;
>         struct unpack_trees_options o;
>         struct lock_file lock_file =3D LOCK_INIT;
> -       struct repository *r =3D the_repository;
>         struct pattern_list *old_pl;
>
>         /* If no branch has been checked out, there are no updates to mak=
e. */
> @@ -327,7 +327,8 @@ static void write_cone_to_file(FILE *fp, struct patte=
rn_list *pl)
>         string_list_clear(&sl, 0);
>  }
>
> -static int write_patterns_and_update(struct pattern_list *pl)
> +static int write_patterns_and_update(struct repository *repo,
> +                                    struct pattern_list *pl)
>  {
>         char *sparse_filename;
>         FILE *fp;
> @@ -336,15 +337,15 @@ static int write_patterns_and_update(struct pattern=
_list *pl)
>
>         sparse_filename =3D get_sparse_checkout_filename();
>
> -       if (safe_create_leading_directories(the_repository, sparse_filena=
me))
> +       if (safe_create_leading_directories(repo, sparse_filename))
>                 die(_("failed to create directory for sparse-checkout fil=
e"));
>
>         hold_lock_file_for_update(&lk, sparse_filename, LOCK_DIE_ON_ERROR=
);
>
> -       result =3D update_working_directory(pl);
> +       result =3D update_working_directory(repo, pl);
>         if (result) {
>                 rollback_lock_file(&lk);
> -               update_working_directory(NULL);
> +               update_working_directory(repo, NULL);
>                 goto out;
>         }
>
> @@ -372,25 +373,26 @@ enum sparse_checkout_mode {
>         MODE_CONE_PATTERNS =3D 2,
>  };
>
> -static int set_config(enum sparse_checkout_mode mode)
> +static int set_config(struct repository *repo,
> +                     enum sparse_checkout_mode mode)
>  {
>         /* Update to use worktree config, if not already. */
> -       if (init_worktree_config(the_repository)) {
> +       if (init_worktree_config(repo)) {
>                 error(_("failed to initialize worktree config"));
>                 return 1;
>         }
>
> -       if (repo_config_set_worktree_gently(the_repository,
> +       if (repo_config_set_worktree_gently(repo,
>                                             "core.sparseCheckout",
>                                             mode ? "true" : "false") ||
> -           repo_config_set_worktree_gently(the_repository,
> +           repo_config_set_worktree_gently(repo,
>                                             "core.sparseCheckoutCone",
>                                             mode =3D=3D MODE_CONE_PATTERN=
S ?
>                                                 "true" : "false"))
>                 return 1;
>
>         if (mode =3D=3D MODE_NO_PATTERNS)
> -               return set_sparse_index_config(the_repository, 0);
> +               return set_sparse_index_config(repo, 0);
>
>         return 0;
>  }
> @@ -410,7 +412,7 @@ static enum sparse_checkout_mode update_cone_mode(int=
 *cone_mode) {
>         return MODE_ALL_PATTERNS;
>  }
>
> -static int update_modes(int *cone_mode, int *sparse_index)
> +static int update_modes(struct repository *repo, int *cone_mode, int *sp=
arse_index)
>  {
>         int mode, record_mode;
>
> @@ -418,20 +420,20 @@ static int update_modes(int *cone_mode, int *sparse=
_index)
>         record_mode =3D (*cone_mode !=3D -1) || !core_apply_sparse_checko=
ut;
>
>         mode =3D update_cone_mode(cone_mode);
> -       if (record_mode && set_config(mode))
> +       if (record_mode && set_config(repo, mode))
>                 return 1;
>
>         /* Set sparse-index/non-sparse-index mode if specified */
>         if (*sparse_index >=3D 0) {
> -               if (set_sparse_index_config(the_repository, *sparse_index=
) < 0)
> +               if (set_sparse_index_config(repo, *sparse_index) < 0)
>                         die(_("failed to modify sparse-index config"));
>
>                 /* force an index rewrite */
> -               repo_read_index(the_repository);
> -               the_repository->index->updated_workdir =3D 1;
> +               repo_read_index(repo);
> +               repo->index->updated_workdir =3D 1;
>
>                 if (!*sparse_index)
> -                       ensure_full_index(the_repository->index);
> +                       ensure_full_index(repo->index);
>         }
>
>         return 0;
> @@ -448,7 +450,7 @@ static struct sparse_checkout_init_opts {
>  } init_opts;
>
>  static int sparse_checkout_init(int argc, const char **argv, const char =
*prefix,
> -                               struct repository *repo UNUSED)
> +                               struct repository *repo)
>  {
>         struct pattern_list pl;
>         char *sparse_filename;
> @@ -464,7 +466,7 @@ static int sparse_checkout_init(int argc, const char =
**argv, const char *prefix,
>         };
>
>         setup_work_tree();
> -       repo_read_index(the_repository);
> +       repo_read_index(repo);
>
>         init_opts.cone_mode =3D -1;
>         init_opts.sparse_index =3D -1;
> @@ -473,7 +475,7 @@ static int sparse_checkout_init(int argc, const char =
**argv, const char *prefix,
>                              builtin_sparse_checkout_init_options,
>                              builtin_sparse_checkout_init_usage, 0);
>
> -       if (update_modes(&init_opts.cone_mode, &init_opts.sparse_index))
> +       if (update_modes(repo, &init_opts.cone_mode, &init_opts.sparse_in=
dex))
>                 return 1;
>
>         memset(&pl, 0, sizeof(pl));
> @@ -485,14 +487,14 @@ static int sparse_checkout_init(int argc, const cha=
r **argv, const char *prefix,
>         if (res >=3D 0) {
>                 free(sparse_filename);
>                 clear_pattern_list(&pl);
> -               return update_working_directory(NULL);
> +               return update_working_directory(repo, NULL);
>         }
>
> -       if (repo_get_oid(the_repository, "HEAD", &oid)) {
> +       if (repo_get_oid(repo, "HEAD", &oid)) {
>                 FILE *fp;
>
>                 /* assume we are in a fresh repo, but update the sparse-c=
heckout file */
> -               if (safe_create_leading_directories(the_repository, spars=
e_filename))
> +               if (safe_create_leading_directories(repo, sparse_filename=
))
>                         die(_("unable to create leading directories of %s=
"),
>                             sparse_filename);
>                 fp =3D xfopen(sparse_filename, "w");
> @@ -511,7 +513,7 @@ static int sparse_checkout_init(int argc, const char =
**argv, const char *prefix,
>         add_pattern("!/*/", empty_base, 0, &pl, 0);
>         pl.use_cone_patterns =3D init_opts.cone_mode;
>
> -       return write_patterns_and_update(&pl);
> +       return write_patterns_and_update(repo, &pl);
>  }
>
>  static void insert_recursive_pattern(struct pattern_list *pl, struct str=
buf *path)
> @@ -674,7 +676,8 @@ static void add_patterns_literal(int argc, const char=
 **argv,
>         add_patterns_from_input(pl, argc, argv, use_stdin ? stdin : NULL)=
;
>  }
>
> -static int modify_pattern_list(struct strvec *args, int use_stdin,
> +static int modify_pattern_list(struct repository *repo,
> +                              struct strvec *args, int use_stdin,
>                                enum modify_type m)
>  {
>         int result;
> @@ -696,22 +699,23 @@ static int modify_pattern_list(struct strvec *args,=
 int use_stdin,
>         }
>
>         if (!core_apply_sparse_checkout) {
> -               set_config(MODE_ALL_PATTERNS);
> +               set_config(repo, MODE_ALL_PATTERNS);
>                 core_apply_sparse_checkout =3D 1;
>                 changed_config =3D 1;
>         }
>
> -       result =3D write_patterns_and_update(pl);
> +       result =3D write_patterns_and_update(repo, pl);
>
>         if (result && changed_config)
> -               set_config(MODE_NO_PATTERNS);
> +               set_config(repo, MODE_NO_PATTERNS);
>
>         clear_pattern_list(pl);
>         free(pl);
>         return result;
>  }
>
> -static void sanitize_paths(struct strvec *args,
> +static void sanitize_paths(struct repository *repo,
> +                          struct strvec *args,
>                            const char *prefix, int skip_checks)
>  {
>         int i;
> @@ -752,7 +756,7 @@ static void sanitize_paths(struct strvec *args,
>
>         for (i =3D 0; i < args->nr; i++) {
>                 struct cache_entry *ce;
> -               struct index_state *index =3D the_repository->index;
> +               struct index_state *index =3D repo->index;
>                 int pos =3D index_name_pos(index, args->v[i], strlen(args=
->v[i]));
>
>                 if (pos < 0)
> @@ -779,7 +783,7 @@ static struct sparse_checkout_add_opts {
>  } add_opts;
>
>  static int sparse_checkout_add(int argc, const char **argv, const char *=
prefix,
> -                              struct repository *repo UNUSED)
> +                              struct repository *repo)
>  {
>         static struct option builtin_sparse_checkout_add_options[] =3D {
>                 OPT_BOOL_F(0, "skip-checks", &add_opts.skip_checks,
> @@ -796,7 +800,7 @@ static int sparse_checkout_add(int argc, const char *=
*argv, const char *prefix,
>         if (!core_apply_sparse_checkout)
>                 die(_("no sparse-checkout to add to"));
>
> -       repo_read_index(the_repository);
> +       repo_read_index(repo);
>
>         argc =3D parse_options(argc, argv, prefix,
>                              builtin_sparse_checkout_add_options,
> @@ -804,9 +808,9 @@ static int sparse_checkout_add(int argc, const char *=
*argv, const char *prefix,
>
>         for (int i =3D 0; i < argc; i++)
>                 strvec_push(&patterns, argv[i]);
> -       sanitize_paths(&patterns, prefix, add_opts.skip_checks);
> +       sanitize_paths(repo, &patterns, prefix, add_opts.skip_checks);
>
> -       ret =3D modify_pattern_list(&patterns, add_opts.use_stdin, ADD);
> +       ret =3D modify_pattern_list(repo, &patterns, add_opts.use_stdin, =
ADD);
>
>         strvec_clear(&patterns);
>         return ret;
> @@ -825,7 +829,7 @@ static struct sparse_checkout_set_opts {
>  } set_opts;
>
>  static int sparse_checkout_set(int argc, const char **argv, const char *=
prefix,
> -                              struct repository *repo UNUSED)
> +                              struct repository *repo)
>  {
>         int default_patterns_nr =3D 2;
>         const char *default_patterns[] =3D {"/*", "!/*/", NULL};
> @@ -847,7 +851,7 @@ static int sparse_checkout_set(int argc, const char *=
*argv, const char *prefix,
>         int ret;
>
>         setup_work_tree();
> -       repo_read_index(the_repository);
> +       repo_read_index(repo);
>
>         set_opts.cone_mode =3D -1;
>         set_opts.sparse_index =3D -1;
> @@ -856,7 +860,7 @@ static int sparse_checkout_set(int argc, const char *=
*argv, const char *prefix,
>                              builtin_sparse_checkout_set_options,
>                              builtin_sparse_checkout_set_usage, 0);
>
> -       if (update_modes(&set_opts.cone_mode, &set_opts.sparse_index))
> +       if (update_modes(repo, &set_opts.cone_mode, &set_opts.sparse_inde=
x))
>                 return 1;
>
>         /*
> @@ -870,10 +874,10 @@ static int sparse_checkout_set(int argc, const char=
 **argv, const char *prefix,
>         } else {
>                 for (int i =3D 0; i < argc; i++)
>                         strvec_push(&patterns, argv[i]);
> -               sanitize_paths(&patterns, prefix, set_opts.skip_checks);
> +               sanitize_paths(repo, &patterns, prefix, set_opts.skip_che=
cks);
>         }
>
> -       ret =3D modify_pattern_list(&patterns, set_opts.use_stdin, REPLAC=
E);
> +       ret =3D modify_pattern_list(repo, &patterns, set_opts.use_stdin, =
REPLACE);
>
>         strvec_clear(&patterns);
>         return ret;
> @@ -891,7 +895,7 @@ static struct sparse_checkout_reapply_opts {
>
>  static int sparse_checkout_reapply(int argc, const char **argv,
>                                    const char *prefix,
> -                                  struct repository *repo UNUSED)
> +                                  struct repository *repo)
>  {
>         static struct option builtin_sparse_checkout_reapply_options[] =
=3D {
>                 OPT_BOOL(0, "cone", &reapply_opts.cone_mode,
> @@ -912,12 +916,12 @@ static int sparse_checkout_reapply(int argc, const =
char **argv,
>                              builtin_sparse_checkout_reapply_options,
>                              builtin_sparse_checkout_reapply_usage, 0);
>
> -       repo_read_index(the_repository);
> +       repo_read_index(repo);
>
> -       if (update_modes(&reapply_opts.cone_mode, &reapply_opts.sparse_in=
dex))
> +       if (update_modes(repo, &reapply_opts.cone_mode, &reapply_opts.spa=
rse_index))
>                 return 1;
>
> -       return update_working_directory(NULL);
> +       return update_working_directory(repo, NULL);
>  }
>
>  static char const * const builtin_sparse_checkout_disable_usage[] =3D {
> @@ -927,7 +931,7 @@ static char const * const builtin_sparse_checkout_dis=
able_usage[] =3D {
>
>  static int sparse_checkout_disable(int argc, const char **argv,
>                                    const char *prefix,
> -                                  struct repository *repo UNUSED)
> +                                  struct repository *repo)
>  {
>         static struct option builtin_sparse_checkout_disable_options[] =
=3D {
>                 OPT_END(),
> @@ -955,7 +959,7 @@ static int sparse_checkout_disable(int argc, const ch=
ar **argv,
>          * are expecting to do that when disabling sparse-checkout.
>          */
>         give_advice_on_expansion =3D 0;
> -       repo_read_index(the_repository);
> +       repo_read_index(repo);
>
>         memset(&pl, 0, sizeof(pl));
>         hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
> @@ -965,14 +969,14 @@ static int sparse_checkout_disable(int argc, const =
char **argv,
>
>         add_pattern("/*", empty_base, 0, &pl, 0);
>
> -       prepare_repo_settings(the_repository);
> -       the_repository->settings.sparse_index =3D 0;
> +       prepare_repo_settings(repo);
> +       repo->settings.sparse_index =3D 0;
>
> -       if (update_working_directory(&pl))
> +       if (update_working_directory(repo, &pl))
>                 die(_("error while refreshing working directory"));
>
>         clear_pattern_list(&pl);
> -       return set_config(MODE_NO_PATTERNS);
> +       return set_config(repo, MODE_NO_PATTERNS);
>  }
>
>  static char const * const builtin_sparse_checkout_check_rules_usage[] =
=3D {
> @@ -987,14 +991,17 @@ static struct sparse_checkout_check_rules_opts {
>         char *rules_file;
>  } check_rules_opts;
>
> -static int check_rules(struct pattern_list *pl, int null_terminated) {
> +static int check_rules(struct repository *repo,
> +                      struct pattern_list *pl,
> +                      int null_terminated)
> +{
>         struct strbuf line =3D STRBUF_INIT;
>         struct strbuf unquoted =3D STRBUF_INIT;
>         char *path;
>         int line_terminator =3D null_terminated ? 0 : '\n';
>         strbuf_getline_fn getline_fn =3D null_terminated ? strbuf_getline=
_nul
>                 : strbuf_getline;
> -       the_repository->index->sparse_checkout_patterns =3D pl;
> +       repo->index->sparse_checkout_patterns =3D pl;
>         while (!getline_fn(&line, stdin)) {
>                 path =3D line.buf;
>                 if (!null_terminated && line.buf[0] =3D=3D '"') {
> @@ -1006,7 +1013,7 @@ static int check_rules(struct pattern_list *pl, int=
 null_terminated) {
>                         path =3D unquoted.buf;
>                 }
>
> -               if (path_in_sparse_checkout(path, the_repository->index))
> +               if (path_in_sparse_checkout(path, repo->index))
>                         write_name_quoted(path, stdout, line_terminator);
>         }
>         strbuf_release(&line);
> @@ -1016,7 +1023,7 @@ static int check_rules(struct pattern_list *pl, int=
 null_terminated) {
>  }
>
>  static int sparse_checkout_check_rules(int argc, const char **argv, cons=
t char *prefix,
> -                                      struct repository *repo UNUSED)
> +                                      struct repository *repo)
>  {
>         static struct option builtin_sparse_checkout_check_rules_options[=
] =3D {
>                 OPT_BOOL('z', NULL, &check_rules_opts.null_termination,
> @@ -1055,7 +1062,7 @@ static int sparse_checkout_check_rules(int argc, co=
nst char **argv, const char *
>                 free(sparse_filename);
>         }
>
> -       ret =3D check_rules(&pl, check_rules_opts.null_termination);
> +       ret =3D check_rules(repo, &pl, check_rules_opts.null_termination)=
;
>         clear_pattern_list(&pl);
>         free(check_rules_opts.rules_file);
>         return ret;
> @@ -1084,8 +1091,8 @@ int cmd_sparse_checkout(int argc,
>
>         git_config(git_default_config, NULL);
>
> -       prepare_repo_settings(the_repository);
> -       the_repository->settings.command_requires_full_index =3D 0;
> +       prepare_repo_settings(repo);
> +       repo->settings.command_requires_full_index =3D 0;
>
>         return fn(argc, argv, prefix, repo);
>  }
> --
> gitgitgadget

Patch looks good to me.
