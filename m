Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E94B1514EE
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738830669; cv=none; b=j6SSP+/cZxhMaDXIPmIwV9ZLzsP3Scc8QWNTMmI4dJ9f628qouj1KduqGdI0WkgVUUBZHcClNlCYVaulhBVCNnfGdcUVxfn7LHfU9NfpVmnc/y5QyqTuZrT2Cq3m82I2tInu06JgdXIL63D4eata9gfu5KovAogu9gfMgHiBsLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738830669; c=relaxed/simple;
	bh=Z/ZI7KFciP4VSGRLsUc4o8p2/IBOQYyC99FPpJF+PwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crhVT7Z7Jdjsbo0JFQW2jMCWw4oPdt4sDHwL6LJagDL3GFSC5RGsVrjgI36NPEfnZ1bJjiP+WEXX3sD87zqIIaIWtC43HtJe9cifrjMdgXJJHWqiexekqVGsiawCBng72y8EsLiCHdjyOTCoZeVty+uFYde9wy5EXD8B6RcvIqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEUYM8j/; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEUYM8j/"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-844eb33827eso22143339f.2
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 00:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738830667; x=1739435467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ws27ioaKZvq/Ss7cR4vdZciEiVUXgP8RgUSRwl9it8k=;
        b=JEUYM8j/Rf/EfNNWpTAtHBJeiT79hzJzhyPkKuys+a9PURzbwL93GpeafcaTDjEvNV
         Pad8za0pj/wmLNpguW5qPP7gsS4zXtJlW6pCDwZP0HFthWBeYpKMbi44B/deWo2UHOdY
         WtxValiDa/vBibGJP5HNOD6jT+0NBNmbNXW+S070uWYLzNb2Nr5sqOuquwFbcgYxR974
         4HhNohKz8XAL51LjAU0EL0yUgTxweFZRPu0eNl8xjg/KSrx6entkg4mwAVLpIRvsidRk
         4Rn5mUTI5TTZYG03gQE9GyjnyOQt3U84Fb6SiM1FEHo3mYxSkM9VnP/pmE5N1q4KfVPA
         fTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738830667; x=1739435467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ws27ioaKZvq/Ss7cR4vdZciEiVUXgP8RgUSRwl9it8k=;
        b=kan2Kh/LVUmHiwaucvev+LVTZnCJdv/3NwkFYXsOpKG7i2w+vRNOrzWl6Qo+xJp8K3
         gOa6JUwCtvpfgK431FjRXLzsBlExO+h6PEW0z1+7U5TV3mQ0Y9nUq2tzTXLMixtyndyN
         PFuFY0GHDDiuEKrlYka992mXO5N7ycWRQs/9D9w6NtqJIsRnEHULax0rogFcE0dj4UlJ
         SaKtgZz9qgMhMgVO2NVRC14XgoefXvbjduuBwCnBse59kzjtCegVG7khop4KkoJS8ReI
         Kxk7vsGtTfAf7p4m41GBXT97RH8jW+d/aoCSGm7za4yFxMjFHyoLjiikp7WRedpoE9/y
         miOA==
X-Gm-Message-State: AOJu0YyZ80Mtg0NblfAeLfQmY+Dy6XGKpKjJmhLdkKuQ+Sx3ECSUIVy/
	0DTzdcE3uae1YZDHabDV5/HA/FfMjrL0A7HV9w1omXhFWkNVIhxF1QZVuCVkqemFp5AMzY5LYZv
	A7bh7EceqWIT4LqpFZcGp35TOOFU=
X-Gm-Gg: ASbGnctGce0dZqNnhhSLmNx/2xRve7I0Ci0CQdbL52a8QJQN5kdbrr3WbqFNK12yvpl
	f9PzLpJlMiUYxizRKPm/n+Km7zMofkEHUkfIuC9gOXyiKd6XK1+Q25vD0uGQJBB6WWCu/MnkIUy
	F0X/BQKO5ThFA=
X-Google-Smtp-Source: AGHT+IGnbicP0O2oShFhs44DIe5u34PK9NVhw24gWwAiYTUCpYPYoUF9QrUJoogQA1aQ6+ue8GHtfeFia9/gxSvVrpw=
X-Received: by 2002:a05:6602:7508:b0:844:c9b1:f08f with SMTP id
 ca18e2360f4ac-854ea41b7d0mr654238139f.3.1738830667116; Thu, 06 Feb 2025
 00:31:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206042010.865947-1-davvid@gmail.com> <20250206042010.865947-2-davvid@gmail.com>
In-Reply-To: <20250206042010.865947-2-davvid@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Feb 2025 00:30:54 -0800
X-Gm-Features: AWEUYZk-jwsfpi2LrM05SWyAUOG9-eVqPEFlo9rshATXs_ttIjM-odW4UYBcjkA
Message-ID: <CABPp-BE_DAopJQPMR1s1m1pvBhsKUUe48GtXJgmhVr_VfvYR5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] difftool: eliminate use of the_repository
To: David Aguilar <davvid@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 8:20=E2=80=AFPM David Aguilar <davvid@gmail.com> wro=
te:
>
> Make callers pass a repository struct into each function instead
> of relying on the global the_repository variable.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  builtin/difftool.c | 54 +++++++++++++++++++++++++---------------------
>  1 file changed, 29 insertions(+), 25 deletions(-)
>
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index 0b6b92aee0..81d733dfdf 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -72,7 +72,8 @@ static int print_tool_help(void)
>         return run_command(&cmd);
>  }
>
> -static int parse_index_info(char *p, int *mode1, int *mode2,
> +static int parse_index_info(struct repository *repo,
> +                           char *p, int *mode1, int *mode2,
>                             struct object_id *oid1, struct object_id *oid=
2,
>                             char *status)
>  {
> @@ -84,11 +85,11 @@ static int parse_index_info(char *p, int *mode1, int =
*mode2,
>         *mode2 =3D (int)strtol(p + 1, &p, 8);
>         if (*p !=3D ' ')
>                 return error("expected ' ', got '%c'", *p);
> -       if (parse_oid_hex(++p, oid1, (const char **)&p))
> +       if (parse_oid_hex_algop(++p, oid1, (const char **)&p, repo->hash_=
algo))
>                 return error("expected object ID, got '%s'", p);
>         if (*p !=3D ' ')
>                 return error("expected ' ', got '%c'", *p);
> -       if (parse_oid_hex(++p, oid2, (const char **)&p))
> +       if (parse_oid_hex_algop(++p, oid2, (const char **)&p, repo->hash_=
algo))
>                 return error("expected object ID, got '%s'", p);
>         if (*p !=3D ' ')
>                 return error("expected ' ', got '%c'", *p);
> @@ -115,7 +116,8 @@ static void add_path(struct strbuf *buf, size_t base_=
len, const char *path)
>  /*
>   * Determine whether we can simply reuse the file in the worktree.
>   */
> -static int use_wt_file(const char *workdir, const char *name,
> +static int use_wt_file(struct repository *repo,
> +                      const char *workdir, const char *name,
>                        struct object_id *oid)
>  {
>         struct strbuf buf =3D STRBUF_INIT;
> @@ -130,7 +132,7 @@ static int use_wt_file(const char *workdir, const cha=
r *name,
>                 int fd =3D open(buf.buf, O_RDONLY);
>
>                 if (fd >=3D 0 &&
> -                   !index_fd(the_repository->index, &wt_oid, fd, &st, OB=
J_BLOB, name, 0)) {
> +                   !index_fd(repo->index, &wt_oid, fd, &st, OBJ_BLOB, na=
me, 0)) {
>                         if (is_null_oid(oid)) {
>                                 oidcpy(oid, &wt_oid);
>                                 use =3D 1;
> @@ -221,13 +223,14 @@ static int path_entry_cmp(const void *cmp_data UNUS=
ED,
>         return strcmp(a->path, key ? key : b->path);
>  }
>
> -static void changed_files(struct hashmap *result, const char *index_path=
,
> +static void changed_files(struct repository *repo,
> +                         struct hashmap *result, const char *index_path,
>                           const char *workdir)
>  {
>         struct child_process update_index =3D CHILD_PROCESS_INIT;
>         struct child_process diff_files =3D CHILD_PROCESS_INIT;
>         struct strbuf buf =3D STRBUF_INIT;
> -       const char *git_dir =3D absolute_path(repo_get_git_dir(the_reposi=
tory));
> +       const char *git_dir =3D absolute_path(repo_get_git_dir(repo));
>         FILE *fp;
>
>         strvec_pushl(&update_index.args,
> @@ -300,7 +303,8 @@ static int ensure_leading_directories(char *path)
>   * to compare the readlink(2) result as text, even on a filesystem that =
is
>   * capable of doing a symbolic link.
>   */
> -static char *get_symlink(struct difftool_options *dt_options,
> +static char *get_symlink(struct repository *repo,
> +                        struct difftool_options *dt_options,
>                          const struct object_id *oid, const char *path)
>  {
>         char *data;
> @@ -317,8 +321,7 @@ static char *get_symlink(struct difftool_options *dt_=
options,
>         } else {
>                 enum object_type type;
>                 unsigned long size;
> -               data =3D repo_read_object_file(the_repository, oid, &type=
,
> -                                            &size);
> +               data =3D repo_read_object_file(repo, oid, &type, &size);
>                 if (!data)
>                         die(_("could not read object %s for symlink %s"),
>                                 oid_to_hex(oid), path);
> @@ -365,7 +368,8 @@ static void write_standin_files(struct pair_entry *en=
try,
>                 write_file_in_directory(rdir, rdir_len, entry->path, entr=
y->right);
>  }
>
> -static int run_dir_diff(struct difftool_options *dt_options,
> +static int run_dir_diff(struct repository *repo,
> +                       struct difftool_options *dt_options,
>                         const char *extcmd, const char *prefix,
>                         struct child_process *child)
>  {
> @@ -386,7 +390,7 @@ static int run_dir_diff(struct difftool_options *dt_o=
ptions,
>         struct hashmap symlinks2 =3D HASHMAP_INIT(pair_cmp, NULL);
>         struct hashmap_iter iter;
>         struct pair_entry *entry;
> -       struct index_state wtindex =3D INDEX_STATE_INIT(the_repository);
> +       struct index_state wtindex =3D INDEX_STATE_INIT(repo);
>         struct checkout lstate, rstate;
>         int err =3D 0;
>         struct child_process cmd =3D CHILD_PROCESS_INIT;
> @@ -394,7 +398,7 @@ static int run_dir_diff(struct difftool_options *dt_o=
ptions,
>         struct hashmap tmp_modified =3D HASHMAP_INIT(path_entry_cmp, NULL=
);
>         int indices_loaded =3D 0;
>
> -       workdir =3D repo_get_work_tree(the_repository);
> +       workdir =3D repo_get_work_tree(repo);
>
>         /* Setup temp directories */
>         tmp =3D getenv("TMPDIR");
> @@ -449,8 +453,7 @@ static int run_dir_diff(struct difftool_options *dt_o=
ptions,
>                                "not supported in\n"
>                                "directory diff mode ('-d' and '--dir-diff=
')."));
>
> -               if (parse_index_info(info.buf, &lmode, &rmode, &loid, &ro=
id,
> -                                    &status))
> +               if (parse_index_info(repo, info.buf, &lmode, &rmode, &loi=
d, &roid, &status))
>                         break;
>                 if (strbuf_getline_nul(&lpath, fp))
>                         break;
> @@ -480,13 +483,13 @@ static int run_dir_diff(struct difftool_options *dt=
_options,
>                 }
>
>                 if (S_ISLNK(lmode)) {
> -                       char *content =3D get_symlink(dt_options, &loid, =
src_path);
> +                       char *content =3D get_symlink(repo, dt_options, &=
loid, src_path);
>                         add_left_or_right(&symlinks2, src_path, content, =
0);
>                         free(content);
>                 }
>
>                 if (S_ISLNK(rmode)) {
> -                       char *content =3D get_symlink(dt_options, &roid, =
dst_path);
> +                       char *content =3D get_symlink(repo, dt_options, &=
roid, dst_path);
>                         add_left_or_right(&symlinks2, dst_path, content, =
1);
>                         free(content);
>                 }
> @@ -511,7 +514,7 @@ static int run_dir_diff(struct difftool_options *dt_o=
ptions,
>                         }
>                         hashmap_add(&working_tree_dups, &entry->entry);
>
> -                       if (!use_wt_file(workdir, dst_path, &roid)) {
> +                       if (!use_wt_file(repo, workdir, dst_path, &roid))=
 {
>                                 if (checkout_path(rmode, &roid, dst_path,
>                                                   &rstate)) {
>                                         ret =3D error("could not write '%=
s'",
> @@ -637,9 +640,9 @@ static int run_dir_diff(struct difftool_options *dt_o=
ptions,
>                                 ret =3D error("could not write %s", buf.b=
uf);
>                                 goto finish;
>                         }
> -                       changed_files(&wt_modified, buf.buf, workdir);
> +                       changed_files(repo, &wt_modified, buf.buf, workdi=
r);
>                         strbuf_setlen(&rdir, rdir_len);
> -                       changed_files(&tmp_modified, buf.buf, rdir.buf);
> +                       changed_files(repo, &tmp_modified, buf.buf, rdir.=
buf);
>                         add_path(&rdir, rdir_len, name);
>                         indices_loaded =3D 1;
>                 }
> @@ -713,7 +716,7 @@ static int run_file_diff(int prompt, const char *pref=
ix,
>  int cmd_difftool(int argc,
>                  const char **argv,
>                  const char *prefix,
> -                struct repository *repo UNUSED)
> +                struct repository *repo)
>  {
>         int use_gui_tool =3D -1, dir_diff =3D 0, prompt =3D -1, tool_help=
 =3D 0, no_index =3D 0;
>         static char *difftool_cmd =3D NULL, *extcmd =3D NULL;
> @@ -749,7 +752,8 @@ int cmd_difftool(int argc,
>         };
>         struct child_process child =3D CHILD_PROCESS_INIT;
>
> -       git_config(difftool_config, &dt_options);
> +       if (repo)
> +               repo_config(repo, difftool_config, &dt_options);
>         dt_options.symlinks =3D dt_options.has_symlinks;
>
>         argc =3D parse_options(argc, argv, prefix, builtin_difftool_optio=
ns,
> @@ -764,8 +768,8 @@ int cmd_difftool(int argc,
>
>         if (!no_index){
>                 setup_work_tree();
> -               setenv(GIT_DIR_ENVIRONMENT, absolute_path(repo_get_git_di=
r(the_repository)), 1);
> -               setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(repo_get_=
work_tree(the_repository)), 1);
> +               setenv(GIT_DIR_ENVIRONMENT, absolute_path(repo_get_git_di=
r(repo)), 1);
> +               setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(repo_get_=
work_tree(repo)), 1);
>         } else if (dir_diff)
>                 die(_("options '%s' and '%s' cannot be used together"), "=
--dir-diff", "--no-index");
>
> @@ -814,6 +818,6 @@ int cmd_difftool(int argc,
>         strvec_pushv(&child.args, argv);
>
>         if (dir_diff)
> -               return run_dir_diff(&dt_options, extcmd, prefix, &child);
> +               return run_dir_diff(repo, &dt_options, extcmd, prefix, &c=
hild);
>         return run_file_diff(prompt, prefix, &child);
>  }
> --
> 2.48.1.461.g612e419e04

This is so much easier to read with the separate option struct being
split out into a separate patch.  Looks good to me.
