Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6744D2248B2
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738830600; cv=none; b=Qque2eCWlctq8ePx7p+pMdbroWPZS2WkEs+xcL2etqugWuCm44yr83z2/pyjpqqdl+5zn19WE6WigRpi1yGrYjKOPez5Gi/vho4/C74uUtpV2uHxmIrInEwJnCrdhGYE/hTiiBk4UlwisRbKo4QN8pe6Fv41FmtsvSz2zM3B5P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738830600; c=relaxed/simple;
	bh=BlKsNyiCxa+cjz5Ey6uWBmK5abZZ/TcW/8La0Bn4AFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFRTbyo6UdLSkyLVzEZohkXWeArBYHpFnB/5XcGQ6ogwxVOWsg2Yr9ETyZnEi0pHk3MZre0kNpdkJjqAjZb0ha4X4FHxiC/suCt+TC0lpZ5JuLYhREsajCxu/V5RXZMO6TNtA8/nDDhXl40HyYDWYCJTXd5b8L2rKyMiYeHBAb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeuAxpJ8; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeuAxpJ8"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-844e10ef3cfso55197039f.2
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 00:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738830597; x=1739435397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIx+v2vx8JSagVkuQ5oz974nWT1yRGcfgI/SbXjDUt0=;
        b=FeuAxpJ86C718X1cvUZPpaj3nBU9kjaGFqiX7w5PlfCjkqmrH8c97pJXeKHGcuuT+k
         oxWGWdo85iokepwoInvXPaXybLorEqerxmu3soh1tSpM5y0iC3kbaWW3CMY+AJuetMrT
         j4iy4VAlerRE8HFjZs5kMwKIQYLeT8JaiQEJJlkf2ishiUl3lW8FXw5RyHLHu4+BChKt
         JEdDY42U1JbBwsW9EzZV8cfRsl7QDQwESZXB2LWfuEyQzYIMLXNEMx5xZRd1XbElaA3A
         NbtEF+FefG8ClebabliciJiQZMgGaA7/dQSI9+lwQC/pfcOiZO0DaUr37zp+hsIsTOzw
         gr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738830597; x=1739435397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIx+v2vx8JSagVkuQ5oz974nWT1yRGcfgI/SbXjDUt0=;
        b=aS1t04g63qQXrGQF5hAQOuMmQ9ZuWRSkHi+VrVia+56LxKnQ9Thctluxt5+b5n54Zw
         kVXlm5Q8KaAXIrMY5TeXpKdOpdBniWNzfQH42H9w/z2GdeFN0FXlSuP8POIVM6dsm80B
         ud1NYc8xgZuBeaz0M2DBZccpLmk1ZED8OczupV537I4dv4xxTTBaCUD5K9OGVhCwaySX
         jXEPnY6BQAI/1RKPAJCU6ltRgsqB8c13o+fKTIZsTtCzWwvCnb2Lj5Uq0jpXFR6VQ6gY
         0O+/k2ESfK9yI4VX4b4jGta6w0ReSinVdeQ8yEjgcVy/iaYUeoLwAjZG/drOj8iVkFQY
         zaSw==
X-Gm-Message-State: AOJu0YwaI18n0OBb1hHlv93nfOZsTLucdw+lf68ECGFh41d1y/DxQFdb
	vWzqLajGfhICzJUx4yjfHXPjyA/6NoR8VS0qrDTwgyYyMupHZcKTjukaajMyMy4AFtlE96454E5
	Srx/ZLn4zxK/R7CMYXmTAXBAc27E=
X-Gm-Gg: ASbGnctDLpV86RCavrol7RhB/3PvWD3wutuNK2xzbmgGsHqDrKUA1S+WYSg/2EyIFCk
	NrezvkzSX0yPJ3rcrBJp6mctMR+Vbf4V2z6E/1GSrRL/QUz/uZUbZ43MMnEisydl80kfXoGdiLL
	Fd9ErfBMmlqo4=
X-Google-Smtp-Source: AGHT+IFghtaTkjilRdaT2ejRQGJBOdeH2Mrf9kwpnS4IjhifFxUHtZ8Gj/ULFaUfcAqkaVXoiHiWz7BlrKuRVkKKu3E=
X-Received: by 2002:a05:6602:6cc2:b0:843:e8d0:a728 with SMTP id
 ca18e2360f4ac-854ea4401ebmr803319139f.4.1738830597381; Thu, 06 Feb 2025
 00:29:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206042010.865947-1-davvid@gmail.com>
In-Reply-To: <20250206042010.865947-1-davvid@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Feb 2025 00:29:46 -0800
X-Gm-Features: AWEUYZnIqpZq4wkV_cxggrmwWKk5lgREbRnuv0iQau4pCAUsUJCQ3TbmwCX8Ihs
Message-ID: <CABPp-BGnRgDxwgfagyvhwjso_kWVgcR-NxOUwUSJve5RHwyFZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] difftool: eliminate use of global variables
To: David Aguilar <davvid@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 8:20=E2=80=AFPM David Aguilar <davvid@gmail.com> wro=
te:
>
> Move difftool's global variables into a difftools_option struct
> in preparation for removal of USE_THE_REPOSITORY_VARIABLE.

Thanks for splitting these out.

> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  builtin/difftool.c | 51 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 33 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index 03a8bb92a9..0b6b92aee0 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -36,18 +36,27 @@
>  #include "entry.h"
>  #include "setup.h"
>
> -static int trust_exit_code;
> -
>  static const char *const builtin_difftool_usage[] =3D {
>         N_("git difftool [<options>] [<commit> [<commit>]] [--] [<path>..=
.]"),
>         NULL
>  };
>
> +struct difftool_options {
> +       int has_symlinks;
> +       int symlinks;
> +       int trust_exit_code;
> +};
> +
>  static int difftool_config(const char *var, const char *value,
>                            const struct config_context *ctx, void *cb)
>  {
> +       struct difftool_options *dt_options =3D (struct difftool_options =
*)cb;
>         if (!strcmp(var, "difftool.trustexitcode")) {
> -               trust_exit_code =3D git_config_bool(var, value);
> +               dt_options->trust_exit_code =3D git_config_bool(var, valu=
e);
> +               return 0;
> +       }
> +       if (!strcmp(var, "core.symlinks")) {
> +               dt_options->has_symlinks =3D git_config_bool(var, value);

It appears that the only use for has_symlinks....

>                 return 0;
>         }
>
> @@ -291,13 +300,14 @@ static int ensure_leading_directories(char *path)
>   * to compare the readlink(2) result as text, even on a filesystem that =
is
>   * capable of doing a symbolic link.
>   */
> -static char *get_symlink(const struct object_id *oid, const char *path)
> +static char *get_symlink(struct difftool_options *dt_options,
> +                        const struct object_id *oid, const char *path)
>  {
>         char *data;
>         if (is_null_oid(oid)) {
>                 /* The symlink is unknown to Git so read from the filesys=
tem */
>                 struct strbuf link =3D STRBUF_INIT;
> -               if (has_symlinks) {
> +               if (dt_options->has_symlinks) {

Why is this based on dt_options->has_symlinks rather than dt_options->symli=
nks?

(I guess this question is equivalent to asking why the preimage code
was using has_symlinks, instead of the symlinks parameter set from the
command line option.  As far as I can see, has_symlinks is supposed to
merely function as a default value for symlinks in the case no command
line parameter is passed...but this is the one counter-example.  But
was it an intentional counter-example, or an accident?)

That said, fixing this, if fixing is needed, doesn't belong in this
patch; it'd probably be better as a preparatory patch.  But, it trips
up reviewers (looks like Patrick was wondering about the same thing on
v1 of your series), so it at least would probably be helpful to
mention in the commit message if no other cleanup is needed with
these.

>                         if (strbuf_readlink(&link, path, strlen(path)))
>                                 die(_("could not read symlink %s"), path)=
;
>                 } else if (strbuf_read_file(&link, path, 128))
> @@ -355,7 +365,8 @@ static void write_standin_files(struct pair_entry *en=
try,
>                 write_file_in_directory(rdir, rdir_len, entry->path, entr=
y->right);
>  }
>
> -static int run_dir_diff(const char *extcmd, int symlinks, const char *pr=
efix,
> +static int run_dir_diff(struct difftool_options *dt_options,
> +                       const char *extcmd, const char *prefix,
>                         struct child_process *child)
>  {
>         struct strbuf info =3D STRBUF_INIT, lpath =3D STRBUF_INIT;
> @@ -469,13 +480,13 @@ static int run_dir_diff(const char *extcmd, int sym=
links, const char *prefix,
>                 }
>
>                 if (S_ISLNK(lmode)) {
> -                       char *content =3D get_symlink(&loid, src_path);
> +                       char *content =3D get_symlink(dt_options, &loid, =
src_path);
>                         add_left_or_right(&symlinks2, src_path, content, =
0);
>                         free(content);
>                 }
>
>                 if (S_ISLNK(rmode)) {
> -                       char *content =3D get_symlink(&roid, dst_path);
> +                       char *content =3D get_symlink(dt_options, &roid, =
dst_path);
>                         add_left_or_right(&symlinks2, dst_path, content, =
1);
>                         free(content);
>                 }
> @@ -528,7 +539,7 @@ static int run_dir_diff(const char *extcmd, int symli=
nks, const char *prefix,
>                                         goto finish;
>                                 }
>                                 add_path(&wtdir, wtdir_len, dst_path);
> -                               if (symlinks) {
> +                               if (dt_options->symlinks) {
>                                         if (symlink(wtdir.buf, rdir.buf))=
 {
>                                                 ret =3D error_errno("coul=
d not symlink '%s' to '%s'", wtdir.buf, rdir.buf);
>                                                 goto finish;
> @@ -614,7 +625,7 @@ static int run_dir_diff(const char *extcmd, int symli=
nks, const char *prefix,
>                 if (lstat(rdir.buf, &st))
>                         continue;
>
> -               if ((symlinks && S_ISLNK(st.st_mode)) || !S_ISREG(st.st_m=
ode))
> +               if ((dt_options->symlinks && S_ISLNK(st.st_mode)) || !S_I=
SREG(st.st_mode))
>                         continue;
>
>                 if (!indices_loaded) {
> @@ -704,9 +715,13 @@ int cmd_difftool(int argc,
>                  const char *prefix,
>                  struct repository *repo UNUSED)
>  {
> -       int use_gui_tool =3D -1, dir_diff =3D 0, prompt =3D -1, symlinks =
=3D 0,
> -           tool_help =3D 0, no_index =3D 0;
> +       int use_gui_tool =3D -1, dir_diff =3D 0, prompt =3D -1, tool_help=
 =3D 0, no_index =3D 0;
>         static char *difftool_cmd =3D NULL, *extcmd =3D NULL;
> +       struct difftool_options dt_options =3D {
> +               .has_symlinks =3D 1,
> +               .symlinks =3D 1,
> +               .trust_exit_code =3D 0
> +       };
>         struct option builtin_difftool_options[] =3D {
>                 OPT_BOOL('g', "gui", &use_gui_tool,
>                          N_("use `diff.guitool` instead of `diff.tool`"))=
,
> @@ -717,14 +732,14 @@ int cmd_difftool(int argc,
>                         0, PARSE_OPT_NONEG),
>                 OPT_SET_INT_F(0, "prompt", &prompt, NULL,
>                         1, PARSE_OPT_NONEG | PARSE_OPT_HIDDEN),
> -               OPT_BOOL(0, "symlinks", &symlinks,
> +               OPT_BOOL(0, "symlinks", &dt_options.symlinks,
>                          N_("use symlinks in dir-diff mode")),
>                 OPT_STRING('t', "tool", &difftool_cmd, N_("tool"),
>                            N_("use the specified diff tool")),
>                 OPT_BOOL(0, "tool-help", &tool_help,
>                          N_("print a list of diff tools that may be used =
with "
>                             "`--tool`")),
> -               OPT_BOOL(0, "trust-exit-code", &trust_exit_code,
> +               OPT_BOOL(0, "trust-exit-code", &dt_options.trust_exit_cod=
e,
>                          N_("make 'git-difftool' exit when an invoked dif=
f "
>                             "tool returns a non-zero exit code")),
>                 OPT_STRING('x', "extcmd", &extcmd, N_("command"),
> @@ -734,8 +749,8 @@ int cmd_difftool(int argc,
>         };
>         struct child_process child =3D CHILD_PROCESS_INIT;
>
> -       git_config(difftool_config, NULL);
> -       symlinks =3D has_symlinks;
> +       git_config(difftool_config, &dt_options);
> +       dt_options.symlinks =3D dt_options.has_symlinks;

If the get_symlink() function should have been using
dt_options.symlinks instead of dt_options.has_symlinks, then
dt_options.has_symlinks is merely functioning as a default, but would
actually be superfluous.  A follow-up patch could remove that extra
field.

>
>         argc =3D parse_options(argc, argv, prefix, builtin_difftool_optio=
ns,
>                              builtin_difftool_usage, PARSE_OPT_KEEP_UNKNO=
WN_OPT |
> @@ -783,7 +798,7 @@ int cmd_difftool(int argc,
>         }
>
>         setenv("GIT_DIFFTOOL_TRUST_EXIT_CODE",
> -              trust_exit_code ? "true" : "false", 1);
> +              dt_options.trust_exit_code ? "true" : "false", 1);
>
>         /*
>          * In directory diff mode, 'git-difftool--helper' is called once
> @@ -799,6 +814,6 @@ int cmd_difftool(int argc,
>         strvec_pushv(&child.args, argv);
>
>         if (dir_diff)
> -               return run_dir_diff(extcmd, symlinks, prefix, &child);
> +               return run_dir_diff(&dt_options, extcmd, prefix, &child);
>         return run_file_diff(prompt, prefix, &child);
>  }
> --
