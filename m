Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC41DD526
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739273603; cv=none; b=U9/3H4ZWFuqQtb7vDYpXiODOSYJ4kZ/zvqmEw7mhlfkznSmepTsd1LgmUvndiAk5YZY/sxVs3sl3Ivn6SHBBTlvzyfI/UlyLe8JQDjTbetEAiLfgy3ivy9ah0VW1HpmKfXGe9erkP4vVeJ+FDdDKwVkiah+DGrLZnyFmOAzSeBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739273603; c=relaxed/simple;
	bh=QsVafd71PnBeJI/kUJowUS9XZ88ktGLkJ+C6WVY3jcU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mB4UWhMgZTqR3LeIBwLb45jjrSM7vewNX5A835lhFKtEfHSfPxM6hbBbqSE39xQo9fM+7u0RdnsBEqnLYArVeTDiWoUtI6TRaHtV8LfA2/lCJHtx1z1CZtzXuAR2ABFAFWWiMN1FZCLiuc9xkt83IkQLSpYYN/6hiLZRuolUxhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=R+f1H9DV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="R+f1H9DV"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38dc73cc5acso2557052f8f.0
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 03:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1739273599; x=1739878399; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hBoAApiQkXhfgxmLK/tBQaH8K4gk2DOSKwWzeFWL3vk=;
        b=R+f1H9DVwKTJd0jlFCGq6aMy6Okj+TsRQg3vjpPvVjRkfGatIdrlF2A4UfpaEyj+Ct
         9maSFOo+410wslpaWgcKqrFQBa6D3my+wi44lr2B2QGO85PNBxGXeK5imTAFwIDG6zIN
         uvAE/+z+195XSRV7TxeVnJHxZ4itNQJ3XVYqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739273599; x=1739878399;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBoAApiQkXhfgxmLK/tBQaH8K4gk2DOSKwWzeFWL3vk=;
        b=pS3/By9lopCRscp8cnN7LDPyfblOsaOup2JeaarxBO4iyzmbQ7FhQhmOjoBcYesE//
         aMUGMZJH9eSa8GFjDVUHJA95A6blLnMxk7/MQJ0H/ui3p7tMOOIw2MwfhjB2bnZqRP9W
         DYzWyBQj28AIu3GI+ZDznFj5C5BFPA9WaV276L8uuGJ6Tl29NJyHqyguG52SpB54m457
         iuD3sdbOlCQrvfrj5/a5Sjbo556chzyseyy9j6SbeT6Q0nTa6Bg16LWGT7su/a5HyAV3
         /IFLVlL1F7tAxhLR/kXGB4NaszWKHFIKyapyr5Ur5v9iAGSAzx/Xak0XzUbhvhcuOweo
         6q5A==
X-Gm-Message-State: AOJu0YzdpB8BbuvWaC9OR2OgZvu+K3zWLlYVoaywatXjpMuqWnO7JxJU
	eieTYQc+Fmw5zw3wpxcT47XkCrqIcqacBF1j7Mh6ydcA4yF+5JxHWSrwS9xMFhA=
X-Gm-Gg: ASbGncupukrihrLHuRh6uKtSUhgWZOrZSRQ4dMqNRq9NyIP7nVqEQbMR/y/XkcicGdb
	3QalueXxfPVFVeLWLPsMVih1ObPa+blcVyqaFGK6nSXSQV2Z2VrvGtp1BSfhynpSD306Xv6LjRS
	aVEErtVJVNuemHhVfVvmUa2I2VmHP++AEhrej7gxxyBll3MFYE2R+rHfGRVHBjS9Roge3r0h4r7
	upAyZe5/4BINq7rKz84Ek/fOFIDW4yq7hOApnQQXAuz1l1GDkt+jd4zW3tDh2f8oeVuIIcyr06R
	u9SBwGvxsyXgCLcjzFtPPWM+qsFimqUPSni5c5KNYEeVf2KJUgnx
X-Google-Smtp-Source: AGHT+IGVWxoQgIoEcd05XUDQKaSu5rcQmxbOvJy/0jnZ6lfFQi4ZWr04BhRnAiTUE0IyEcsWT9bDdg==
X-Received: by 2002:a5d:5985:0:b0:38d:d274:4537 with SMTP id ffacd0b85a97d-38de439d615mr2379528f8f.7.1739273598528;
        Tue, 11 Feb 2025 03:33:18 -0800 (PST)
Received: from [10.0.0.21] (94-43-143-139.dsl.utg.ge. [94.43.143.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38ddaf333c5sm6664546f8f.36.2025.02.11.03.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 03:33:18 -0800 (PST)
Message-ID: <bc0de52b59f289e1388f1581fcfa49453365e21a.camel@intelfx.name>
Subject: Re: [PATCH] rebase: add `--update-refs=interactive`
From: Ivan Shapovalov <intelfx@intelfx.name>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, Derrick Stolee
	 <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, Alex Henrie
	 <alexhenrie24@gmail.com>
Date: Tue, 11 Feb 2025 15:33:15 +0400
In-Reply-To: <CALnO6CAM7WCOJV8s8ZARi3BAFwkh0TNTCod_YH9s+EpO7t-Qtg@mail.gmail.com>
References: <20250210191650.316329-1-intelfx@intelfx.name>
	 <CALnO6CAM7WCOJV8s8ZARi3BAFwkh0TNTCod_YH9s+EpO7t-Qtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On 2025-02-10 at 15:22 -0500, D. Ben Knoble wrote:
> On Mon, Feb 10, 2025 at 2:17=E2=80=AFPM Ivan Shapovalov <intelfx@intelfx.=
name> wrote:
> >=20
> > In rebase-heavy workflows involving multiple interdependent feature
> > branches, typing out `--update-refs` quickly becomes tiring, which
> > can be mitigated with setting the `rebase.updateRefs` git-config option
> > to perform update-refs by default.
> >=20
> > However, the utility of `rebase.updateRefs` is somewhat limited because
> > you rarely want it in a non-interactive rebase (as it does not give you
> > the chance to review the update-refs candidates, likely leading to
> > updating refs that you didn't want updated -- I made quite an amount
> > of mess by setting this option and subsequently forgetting about it).
> >=20
> > Try to find a middle ground by introducing a third value,
> > `--update-refs=3Dinteractive` (and `rebase.updateRefs=3Dinteractive`)
> > which means `--update-refs` when starting an interactive rebase and
> > `--no-update-refs` otherwise. This option is primarily intended to be
> > used in the gitconfig, but is also accepted on the command line
> > for completeness.
> >=20
> > Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
> > ---
> >  Documentation/config/rebase.txt |  7 +++-
> >  Documentation/git-rebase.txt    |  8 +++-
> >  builtin/rebase.c                | 72 +++++++++++++++++++++++++++++----
> >  3 files changed, 77 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/Documentation/config/rebase.txt b/Documentation/config/reb=
ase.txt
> > index c6187ab28b..d8bbaba69a 100644
> > --- a/Documentation/config/rebase.txt
> > +++ b/Documentation/config/rebase.txt
> > @@ -24,7 +24,12 @@ rebase.autoStash::
> >         Defaults to false.
> >=20
> >  rebase.updateRefs::
> > -       If set to true enable `--update-refs` option by default.
> > +       If set to true, enable the `--update-refs` option of
> > +       linkgit:git-rebase[1] by default. When set to 'interactive',
> > +       only enable `--update-refs` by default for interactive mode
> > +       (equivalent to `--update-refs=3Dinteractive`).
> > +       This option can be overridden by specifying any form of
> > +       `--update-refs` on the command line.
> >=20
> >  rebase.missingCommitsCheck::
> >         If set to "warn", git rebase -i will print a warning if some
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
> > index b18cdbc023..ae6939588d 100644
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -647,12 +647,18 @@ rebase --continue` is invoked. Currently, you can=
not pass
> >=20
> >  --update-refs::
> >  --no-update-refs::
> > +--update-refs=3Dinteractive::
>=20
> Based on `git grep -e '--.*\[=3D' Documentation/git-*.txt`, I think this
> should be more like
>=20
>     --update-refs[=3Dinteractive]::
>     --no-update-refs::
>=20
> But maybe that unintentionally suggests that `=3Dinteractive` is the defa=
ult?

Perhaps --update-refs[=3D(yes|no|interactive)] then? Or is that too
verbose? Anyway, I don't have a preference, I'll just do what I'm told
here.

>=20
> >         Automatically force-update any branches that point to commits t=
hat
> >         are being rebased. Any branches that are checked out in a workt=
ree
> >         are not updated in this way.
> >  +
> > +If `--update-refs=3Dinteractive` is specified, the behavior is equival=
ent to
> > +`--update-refs` if the rebase is interactive and `--no-update-refs` ot=
herwise.
> > +(This is mainly useful as a configuration setting, although it might a=
lso be
> > +of use in aliases.)
> > ++
> >  If the configuration variable `rebase.updateRefs` is set, then this op=
tion
> > -can be used to override and disable this setting.
> > +can be used to override or disable the configuration.
> >  +
> >  See also INCOMPATIBLE OPTIONS below.
> >=20
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 6c9eaf3788..57b456599b 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -129,10 +129,17 @@ struct rebase_options {
> >         int reschedule_failed_exec;
> >         int reapply_cherry_picks;
> >         int fork_point;
> > -       int update_refs;
> > +       // UPDATE_REFS_{UNKNOWN,NO,ALWAYS} numeric values must never
> > +       // change as post-option-parsing code works with {,config_}upda=
te_refs
> > +       // as if they were ints
> > +       enum {
> > +               UPDATE_REFS_UNKNOWN =3D -1,
> > +               UPDATE_REFS_NO =3D 0,
> > +               UPDATE_REFS_ALWAYS =3D 1,
> > +               UPDATE_REFS_INTERACTIVE,
> > +       } update_refs, config_update_refs;
> >         int config_autosquash;
> >         int config_rebase_merges;
> > -       int config_update_refs;
> >  };
> >=20
> >  #define REBASE_OPTIONS_INIT {                          \
> > @@ -150,8 +157,8 @@ struct rebase_options {
> >                 .autosquash =3D -1,                       \
> >                 .rebase_merges =3D -1,                    \
> >                 .config_rebase_merges =3D -1,             \
> > -               .update_refs =3D -1,                      \
> > -               .config_update_refs =3D -1,               \
> > +               .update_refs =3D UPDATE_REFS_UNKNOWN,     \
> > +               .config_update_refs =3D UPDATE_REFS_UNKNOWN, \
> >                 .strategy_opts =3D STRING_LIST_INIT_NODUP,\
> >         }
> >=20
> > @@ -412,6 +419,18 @@ static void imply_merge(struct rebase_options *opt=
s, const char *option)
> >         }
> >  }
> >=20
> > +static int coerce_update_refs(const struct rebase_options *opts, int u=
pdate_refs)
> > +{
> > +       /* coerce "=3Dinteractive" into "no" rather than "not set" when=
 not interactive
> > +        * this way, `git -c rebase.updateRefs=3Dyes rebase --update-re=
fs=3Dinteractive [without -i]`
> > +        * will not inherit the "yes" from the config */
> > +       if (update_refs =3D=3D UPDATE_REFS_INTERACTIVE)
> > +               return (opts->flags & REBASE_INTERACTIVE_EXPLICIT)
> > +                      ? UPDATE_REFS_ALWAYS
> > +                      : UPDATE_REFS_NO;
> > +       return update_refs;
> > +}
> > +
> >  /* Returns the filename prefixed by the state_dir */
> >  static const char *state_dir_path(const char *filename, struct rebase_=
options *opts)
> >  {
> > @@ -779,6 +798,17 @@ static void parse_rebase_merges_value(struct rebas=
e_options *options, const char
> >                 die(_("Unknown rebase-merges mode: %s"), value);
> >  }
> >=20
> > +static int parse_update_refs_value(const char *value, const char *desc=
)
> > +{
> > +       int v =3D git_parse_maybe_bool(value);
> > +       if (v >=3D 0)
> > +               return v ? UPDATE_REFS_ALWAYS : UPDATE_REFS_NO;
> > +       else if (!strcmp("interactive", value))
> > +               return UPDATE_REFS_INTERACTIVE;
> > +
> > +       die(_("bad %s value '%s'; valid values are boolean or \"interac=
tive\""), desc, value);
> > +}
> > +
> >  static int rebase_config(const char *var, const char *value,
> >                          const struct config_context *ctx, void *data)
> >  {
> > @@ -821,7 +851,8 @@ static int rebase_config(const char *var, const cha=
r *value,
> >         }
> >=20
> >         if (!strcmp(var, "rebase.updaterefs")) {
> > -               opts->config_update_refs =3D git_config_bool(var, value=
);
> > +               opts->config_update_refs =3D parse_update_refs_value(va=
lue,
> > +                       "rebase.updateRefs");
> >                 return 0;
> >         }
> >=20
> > @@ -1042,6 +1073,19 @@ static int parse_opt_rebase_merges(const struct =
option *opt, const char *arg, in
> >         return 0;
> >  }
> >=20
> > +static int parse_opt_update_refs(const struct option *opt, const char =
*arg, int unset)
> > +{
> > +       struct rebase_options *options =3D opt->value;
> > +
> > +       if (arg)
> > +               options->update_refs =3D parse_update_refs_value(arg,
> > +                       "--update-refs");
> > +       else
> > +               options->update_refs =3D unset ? UPDATE_REFS_NO : UPDAT=
E_REFS_ALWAYS;
> > +
> > +       return 0;
> > +}
> > +
> >  static void NORETURN error_on_missing_default_upstream(void)
> >  {
> >         struct branch *current_branch =3D branch_get(NULL);
> > @@ -1187,9 +1231,11 @@ int cmd_rebase(int argc,
> >                 OPT_BOOL(0, "autosquash", &options.autosquash,
> >                          N_("move commits that begin with "
> >                             "squash!/fixup! under -i")),
> > -               OPT_BOOL(0, "update-refs", &options.update_refs,
> > -                        N_("update branches that point to commits "
> > -                           "that are being rebased")),
> > +               OPT_CALLBACK_F(0, "update-refs", &options,
> > +                       N_("(bool|interactive)"),
> > +                       N_("update branches that point to commits "
> > +                          "that are being rebased"),
> > +                       PARSE_OPT_OPTARG, parse_opt_update_refs),
> >                 { OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id=
"),
> >                         N_("GPG-sign commits"),
> >                         PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> > @@ -1528,6 +1574,16 @@ int cmd_rebase(int argc,
> >         if (isatty(2) && options.flags & REBASE_NO_QUIET)
> >                 strbuf_addstr(&options.git_format_patch_opt, " --progre=
ss");
> >=20
> > +       /* coerce --update-refs=3Dinteractive into yes or no.
> > +        * we do it here because there's just too much code below that =
handles
> > +        * {,config_}update_refs in one way or another and modifying it=
 to
> > +        * account for the new state would be too invasive.
> > +        * all further code uses {,config_}update_refs as a tristate. *=
/
> > +       options.update_refs =3D
> > +               coerce_update_refs(&options, options.update_refs);
> > +       options.config_update_refs =3D
> > +               coerce_update_refs(&options, options.config_update_refs=
);
> > +
> >         if (options.git_am_opts.nr || options.type =3D=3D REBASE_APPLY)=
 {
> >                 /* all am options except -q are compatible only with --=
apply */
> >                 for (i =3D options.git_am_opts.nr - 1; i >=3D 0; i--)
> > --
> > 2.48.1.5.g9188e14f140
> >=20
> >=20
>=20
> Should we add a test for this?
>=20

Any suggestions what exactly I should test here? I don't have much
experience testing interactive CLI tools, so I'd appreciate some hints.

--=20
Ivan Shapovalov / intelfx /
