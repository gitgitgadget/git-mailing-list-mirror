Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E6024C67D
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739218945; cv=none; b=FyfP5V09YFa4fhssMEp/YLQHAXTJaVTtx+riCAqtyyF04Z0i9+d8AXurDeocbU9mxtxaDRZmioKtqpvioLZw3Y3r5N7N1qO7m1A9SqtQLVIqTPaJ0DveyCYEWL54xhP+5UGeicljXHJOURhGKP/22Cf31nOyWaj5avv+2WIaP6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739218945; c=relaxed/simple;
	bh=xlf8ILlaUOOcnRsI2fAhDWheoufW9cJONvf0G2Tix1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/Rf7F+0ExKXyImAac8ndY0zUlLIhU/1FKgImLkkepsg9ozo5C780tEzmE90ZOudfAYtJaTfelu93A5COFEfKhS2d8C3YIx3SMbHUuQAaGAs+WmbUU8IuvVccf8vVpZOjdUU0CYrdq8APbt32LTyQ1TOJ7W8jj05+FcDu/JBVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI/718/p; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI/718/p"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7c501bbecso214768666b.2
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 12:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739218942; x=1739823742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBFPn93wJTCf/ohObTHff7lu1OWtFNK0cK/ATVNxa9o=;
        b=AI/718/pBWDoAuh1mDrXyaRfkd68bi93kh4ciNr4Zf8k4RBGVHsWFInlWIJRHR2z9C
         VWfXJs4wc+9XXsiiHfaK5f9InsTg8TNaHRnzNS+gsFYgx4jU1WymhdkgDOSFpB33czG5
         uNkU5ElM4MQhOrzE0Ne4QjE/jaf9tsJyMGdGjncSJ9AqxfwgiXOt62Q1NGHlBF2YGG1G
         WKFINGKBuUoQ58ZSngEgj8JSOZnXA1O3a+ivL28TIgb5neccztFNVAuRQqNa8PyP3Jsj
         KERRY/7wOJ2GQaLo3kJcW8pucn5e3UzAkCnqzrurINe4qykA2e9v1pdrFx8mRbd4Rpdi
         mRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739218942; x=1739823742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBFPn93wJTCf/ohObTHff7lu1OWtFNK0cK/ATVNxa9o=;
        b=lXQo8gjF14xO+9BEzXvP+c86nuAvshAZ3w9l1b7JW6T0S7dy+709ufeUh42RBn+p54
         tePYMVMy4HRniHXUcyxYmU/4GAlezfr8Wn3R3a/O/FQSu431Qv5lY41p87pt/Xr0hvSn
         h3pYU6QpDMdGRX4cCgt8V6p+JYE30usDJVy4oZt2yMqkYbGR+afKPhYGBn/1do4DAIwL
         k8EHH7kVa9UojD+Xx6ucTrKvzgdXI1L1UbEF1NDZt0Eujl/WndRQWWheer2n63AAzyoq
         qvRl4iklj7VkmMB6rWfnY2xWDJuftydsdRPaOr9XktLaYmVLK9bxCjyg0j67362pd1k/
         /vfg==
X-Gm-Message-State: AOJu0YwVMbToe3Rh8m5TUif2YUX0sa0BWSjjgwwvoKzvpYvbXxFvk0md
	6k4RmiW4uKMGylKCf1F4OX5Cdo1lJlwabr3CaYqTc0EtCtBZv5wN4IDZUhs54zpma+hecI4xkUR
	xXY5UJs0BpD2Zyf8zDUCbaXqxPm4=
X-Gm-Gg: ASbGncuf7gB5iRtgSFhDhvdvkrSyOHT8Oxkma3QtrvsErKxbjG+a6PVpg29ubub/lDK
	diNZvNsXdAN6SdeEp1jhhj9Bsfimu1I6thual9A+EnlIpGX/0F6wQjXunvVhfoXXz5A3k8y/ZGc
	qV8coAwBoAjbAubvlxrBVwD/139hQ=
X-Google-Smtp-Source: AGHT+IFGh3aUx5FZnnGeb1KpRyQ1uYRpEpniR7ZphOXrtlO1zQeFXEKDtqtPNCyDwArOTetITw07FFiBHJ9I6Adsf1U=
X-Received: by 2002:a17:907:bb88:b0:ab7:8d23:1fef with SMTP id
 a640c23a62f3a-ab78d23209bmr1347576166b.9.1739218941374; Mon, 10 Feb 2025
 12:22:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210191650.316329-1-intelfx@intelfx.name>
In-Reply-To: <20250210191650.316329-1-intelfx@intelfx.name>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 10 Feb 2025 15:22:09 -0500
X-Gm-Features: AWEUYZmDQpzmaDNczUPsTsNfotaV2MQjs1BCJJuC31uorxH1MMFB84LoDDGgVeg
Message-ID: <CALnO6CAM7WCOJV8s8ZARi3BAFwkh0TNTCod_YH9s+EpO7t-Qtg@mail.gmail.com>
Subject: Re: [PATCH] rebase: add `--update-refs=interactive`
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Alex Henrie <alexhenrie24@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 2:17=E2=80=AFPM Ivan Shapovalov <intelfx@intelfx.na=
me> wrote:
>
> In rebase-heavy workflows involving multiple interdependent feature
> branches, typing out `--update-refs` quickly becomes tiring, which
> can be mitigated with setting the `rebase.updateRefs` git-config option
> to perform update-refs by default.
>
> However, the utility of `rebase.updateRefs` is somewhat limited because
> you rarely want it in a non-interactive rebase (as it does not give you
> the chance to review the update-refs candidates, likely leading to
> updating refs that you didn't want updated -- I made quite an amount
> of mess by setting this option and subsequently forgetting about it).
>
> Try to find a middle ground by introducing a third value,
> `--update-refs=3Dinteractive` (and `rebase.updateRefs=3Dinteractive`)
> which means `--update-refs` when starting an interactive rebase and
> `--no-update-refs` otherwise. This option is primarily intended to be
> used in the gitconfig, but is also accepted on the command line
> for completeness.
>
> Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
> ---
>  Documentation/config/rebase.txt |  7 +++-
>  Documentation/git-rebase.txt    |  8 +++-
>  builtin/rebase.c                | 72 +++++++++++++++++++++++++++++----
>  3 files changed, 77 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebas=
e.txt
> index c6187ab28b..d8bbaba69a 100644
> --- a/Documentation/config/rebase.txt
> +++ b/Documentation/config/rebase.txt
> @@ -24,7 +24,12 @@ rebase.autoStash::
>         Defaults to false.
>
>  rebase.updateRefs::
> -       If set to true enable `--update-refs` option by default.
> +       If set to true, enable the `--update-refs` option of
> +       linkgit:git-rebase[1] by default. When set to 'interactive',
> +       only enable `--update-refs` by default for interactive mode
> +       (equivalent to `--update-refs=3Dinteractive`).
> +       This option can be overridden by specifying any form of
> +       `--update-refs` on the command line.
>
>  rebase.missingCommitsCheck::
>         If set to "warn", git rebase -i will print a warning if some
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index b18cdbc023..ae6939588d 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -647,12 +647,18 @@ rebase --continue` is invoked. Currently, you canno=
t pass
>
>  --update-refs::
>  --no-update-refs::
> +--update-refs=3Dinteractive::

Based on `git grep -e '--.*\[=3D' Documentation/git-*.txt`, I think this
should be more like

    --update-refs[=3Dinteractive]::
    --no-update-refs::

But maybe that unintentionally suggests that `=3Dinteractive` is the defaul=
t?

>         Automatically force-update any branches that point to commits tha=
t
>         are being rebased. Any branches that are checked out in a worktre=
e
>         are not updated in this way.
>  +
> +If `--update-refs=3Dinteractive` is specified, the behavior is equivalen=
t to
> +`--update-refs` if the rebase is interactive and `--no-update-refs` othe=
rwise.
> +(This is mainly useful as a configuration setting, although it might als=
o be
> +of use in aliases.)
> ++
>  If the configuration variable `rebase.updateRefs` is set, then this opti=
on
> -can be used to override and disable this setting.
> +can be used to override or disable the configuration.
>  +
>  See also INCOMPATIBLE OPTIONS below.
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 6c9eaf3788..57b456599b 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -129,10 +129,17 @@ struct rebase_options {
>         int reschedule_failed_exec;
>         int reapply_cherry_picks;
>         int fork_point;
> -       int update_refs;
> +       // UPDATE_REFS_{UNKNOWN,NO,ALWAYS} numeric values must never
> +       // change as post-option-parsing code works with {,config_}update=
_refs
> +       // as if they were ints
> +       enum {
> +               UPDATE_REFS_UNKNOWN =3D -1,
> +               UPDATE_REFS_NO =3D 0,
> +               UPDATE_REFS_ALWAYS =3D 1,
> +               UPDATE_REFS_INTERACTIVE,
> +       } update_refs, config_update_refs;
>         int config_autosquash;
>         int config_rebase_merges;
> -       int config_update_refs;
>  };
>
>  #define REBASE_OPTIONS_INIT {                          \
> @@ -150,8 +157,8 @@ struct rebase_options {
>                 .autosquash =3D -1,                       \
>                 .rebase_merges =3D -1,                    \
>                 .config_rebase_merges =3D -1,             \
> -               .update_refs =3D -1,                      \
> -               .config_update_refs =3D -1,               \
> +               .update_refs =3D UPDATE_REFS_UNKNOWN,     \
> +               .config_update_refs =3D UPDATE_REFS_UNKNOWN, \
>                 .strategy_opts =3D STRING_LIST_INIT_NODUP,\
>         }
>
> @@ -412,6 +419,18 @@ static void imply_merge(struct rebase_options *opts,=
 const char *option)
>         }
>  }
>
> +static int coerce_update_refs(const struct rebase_options *opts, int upd=
ate_refs)
> +{
> +       /* coerce "=3Dinteractive" into "no" rather than "not set" when n=
ot interactive
> +        * this way, `git -c rebase.updateRefs=3Dyes rebase --update-refs=
=3Dinteractive [without -i]`
> +        * will not inherit the "yes" from the config */
> +       if (update_refs =3D=3D UPDATE_REFS_INTERACTIVE)
> +               return (opts->flags & REBASE_INTERACTIVE_EXPLICIT)
> +                      ? UPDATE_REFS_ALWAYS
> +                      : UPDATE_REFS_NO;
> +       return update_refs;
> +}
> +
>  /* Returns the filename prefixed by the state_dir */
>  static const char *state_dir_path(const char *filename, struct rebase_op=
tions *opts)
>  {
> @@ -779,6 +798,17 @@ static void parse_rebase_merges_value(struct rebase_=
options *options, const char
>                 die(_("Unknown rebase-merges mode: %s"), value);
>  }
>
> +static int parse_update_refs_value(const char *value, const char *desc)
> +{
> +       int v =3D git_parse_maybe_bool(value);
> +       if (v >=3D 0)
> +               return v ? UPDATE_REFS_ALWAYS : UPDATE_REFS_NO;
> +       else if (!strcmp("interactive", value))
> +               return UPDATE_REFS_INTERACTIVE;
> +
> +       die(_("bad %s value '%s'; valid values are boolean or \"interacti=
ve\""), desc, value);
> +}
> +
>  static int rebase_config(const char *var, const char *value,
>                          const struct config_context *ctx, void *data)
>  {
> @@ -821,7 +851,8 @@ static int rebase_config(const char *var, const char =
*value,
>         }
>
>         if (!strcmp(var, "rebase.updaterefs")) {
> -               opts->config_update_refs =3D git_config_bool(var, value);
> +               opts->config_update_refs =3D parse_update_refs_value(valu=
e,
> +                       "rebase.updateRefs");
>                 return 0;
>         }
>
> @@ -1042,6 +1073,19 @@ static int parse_opt_rebase_merges(const struct op=
tion *opt, const char *arg, in
>         return 0;
>  }
>
> +static int parse_opt_update_refs(const struct option *opt, const char *a=
rg, int unset)
> +{
> +       struct rebase_options *options =3D opt->value;
> +
> +       if (arg)
> +               options->update_refs =3D parse_update_refs_value(arg,
> +                       "--update-refs");
> +       else
> +               options->update_refs =3D unset ? UPDATE_REFS_NO : UPDATE_=
REFS_ALWAYS;
> +
> +       return 0;
> +}
> +
>  static void NORETURN error_on_missing_default_upstream(void)
>  {
>         struct branch *current_branch =3D branch_get(NULL);
> @@ -1187,9 +1231,11 @@ int cmd_rebase(int argc,
>                 OPT_BOOL(0, "autosquash", &options.autosquash,
>                          N_("move commits that begin with "
>                             "squash!/fixup! under -i")),
> -               OPT_BOOL(0, "update-refs", &options.update_refs,
> -                        N_("update branches that point to commits "
> -                           "that are being rebased")),
> +               OPT_CALLBACK_F(0, "update-refs", &options,
> +                       N_("(bool|interactive)"),
> +                       N_("update branches that point to commits "
> +                          "that are being rebased"),
> +                       PARSE_OPT_OPTARG, parse_opt_update_refs),
>                 { OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id")=
,
>                         N_("GPG-sign commits"),
>                         PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> @@ -1528,6 +1574,16 @@ int cmd_rebase(int argc,
>         if (isatty(2) && options.flags & REBASE_NO_QUIET)
>                 strbuf_addstr(&options.git_format_patch_opt, " --progress=
");
>
> +       /* coerce --update-refs=3Dinteractive into yes or no.
> +        * we do it here because there's just too much code below that ha=
ndles
> +        * {,config_}update_refs in one way or another and modifying it t=
o
> +        * account for the new state would be too invasive.
> +        * all further code uses {,config_}update_refs as a tristate. */
> +       options.update_refs =3D
> +               coerce_update_refs(&options, options.update_refs);
> +       options.config_update_refs =3D
> +               coerce_update_refs(&options, options.config_update_refs);
> +
>         if (options.git_am_opts.nr || options.type =3D=3D REBASE_APPLY) {
>                 /* all am options except -q are compatible only with --ap=
ply */
>                 for (i =3D options.git_am_opts.nr - 1; i >=3D 0; i--)
> --
> 2.48.1.5.g9188e14f140
>
>

Should we add a test for this?

--=20
D. Ben Knoble
