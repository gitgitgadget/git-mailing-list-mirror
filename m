Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA272C76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 05:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjDGFo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 01:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjDGFo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 01:44:57 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7487686A6
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 22:44:55 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id k37so53387648lfv.0
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 22:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680846292; x=1683438292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R13NrSeO1unRFKOKZ4AZigcqvXL5e+KGQHw2vj+Lw14=;
        b=c2Qz77E/G1awnlCLhwlmPJTFYGLHMRGJ8oF2QnqTb4zfKKw/9W3+FjYByxqBs9CuuE
         LNSDWqQITQr2MHq3RVjx7wa2mT+J4D688troiIALaUmzSiRo2LJ8VdBMSgGmD9vz5hqd
         nlqom44TyFVLjVyeGFlLpBMM3qt+wie3i2XYRZBj0t+Y0B2UaCFjy/5Se3e/tk3yh4nx
         q+09qfSsxkKvhbTX3QDBjLEDrL4ZiHtoQ0fhqsulMAYeEapARV6e/Do7j3UmdAJUMAH5
         1tAdldGSt8DNcbaZp/SL6mMxP3Ib+LqwYPMS2LpHremt2LiFFvWQ8zkwmqXkFvQwK5pJ
         vZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680846292; x=1683438292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R13NrSeO1unRFKOKZ4AZigcqvXL5e+KGQHw2vj+Lw14=;
        b=kInOjVJcs8Yzo4iB5j5lp1fQjhbWcXwlAZjbHuUKg53ykaeCw5TSavlUTor4dLXObj
         TgTViIg1/TSyvBvHfDx/Qim38Hgn3sJX2+L3t34TlgvxLRmdg9KVQCfJWcx/zBhm3VII
         a0TdrPM2IRqg/sq8bfDdBOegu+JpXrKnW/20StWHsjMf1qpOVcZI2nk6KG2GIXHbyMnd
         /ovDyxvI0QSF+Qyvnx6ml4PyZejUMy1iYUVAY9TqBpCJDuti188sBeEF0QesvoKpgMik
         p2fa9oDXOuOHf56GzyAPKORvs/33grxuQVOM2axNDS4HvapzecFuPstFN86dmUMLpFaN
         4D5Q==
X-Gm-Message-State: AAQBX9eZRmcZU7Uv6IYMDXl/AjZRK0KoL4kAg7I/y6R2ez+JkoEmag2J
        WXTe4X0iDdMW/Hla0jLYdB/XU4VWsiuRfRkqd/k=
X-Google-Smtp-Source: AKy350aySoq/wXisd9X8tC/zy/D7wyZumMm/AycrHUzt1iw+z6XoMVB7cCNyP7nFu7fgDZjiwyoo7wuQgD2dHAijfmg=
X-Received: by 2002:ac2:5188:0:b0:4d5:ca42:e43e with SMTP id
 u8-20020ac25188000000b004d5ca42e43emr405430lfi.7.1680846291382; Thu, 06 Apr
 2023 22:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
 <cover.1680708043.git.phillip.wood@dunelm.org.uk> <dd7b82cdd54cc962385dff8a1adab4c1d4fb2167.1680708043.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <dd7b82cdd54cc962385dff8a1adab4c1d4fb2167.1680708043.git.phillip.wood@dunelm.org.uk>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 6 Apr 2023 22:44:39 -0700
Message-ID: <CABPp-BF8ND=Q_ONb3=WV+4F8ZVJ6h+0FeVNOr_YV-7s02uJXSA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] sequencer: use struct strvec to store merge
 strategy options
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 8:22=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The sequencer stores the merge strategy options in an array of strings
> which allocated with ALLOC_GROW(). Using "struct strvec" avoids manually
> managing the memory of that array and simplifies the code.
>
> Aside from memory allocation the changes to the sequencer are largely
> mechanical, changing xopts_nr to xopts.nr and xopts[i] to xopts.v[i]. A
> new option parsing macro OPT_STRVEC() is also added to collect the
> strategy options.  Hopefully this can be used to simplify the code in
> builtin/merge.c in the future.
>
> Note that there is a change of behavior to "git cherry-pick" and "git
> revert" as passing =E2=80=9C--no-strategy-option=E2=80=9D will now clear =
any previous
> strategy options whereas before this change it did nothing.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/revert.c   | 20 +++-----------------
>  parse-options-cb.c | 16 ++++++++++++++++
>  parse-options.h    | 10 ++++++++++
>  sequencer.c        | 47 ++++++++++++++++++++--------------------------
>  sequencer.h        | 11 ++++++++---
>  5 files changed, 57 insertions(+), 47 deletions(-)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 62986a7b1b..362857da65 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -44,20 +44,6 @@ static const char * const *revert_or_cherry_pick_usage=
(struct replay_opts *opts)
>         return opts->action =3D=3D REPLAY_REVERT ? revert_usage : cherry_=
pick_usage;
>  }
>
> -static int option_parse_x(const struct option *opt,
> -                         const char *arg, int unset)
> -{
> -       struct replay_opts **opts_ptr =3D opt->value;
> -       struct replay_opts *opts =3D *opts_ptr;
> -
> -       if (unset)
> -               return 0;
> -
> -       ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
> -       opts->xopts[opts->xopts_nr++] =3D xstrdup(arg);
> -       return 0;
> -}
> -
>  static int option_parse_m(const struct option *opt,
>                           const char *arg, int unset)
>  {
> @@ -114,8 +100,8 @@ static int run_sequencer(int argc, const char **argv,=
 struct replay_opts *opts)
>                              N_("select mainline parent"), option_parse_m=
),
>                 OPT_RERERE_AUTOUPDATE(&opts->allow_rerere_auto),
>                 OPT_STRING(0, "strategy", &opts->strategy, N_("strategy")=
, N_("merge strategy")),
> -               OPT_CALLBACK('X', "strategy-option", &opts, N_("option"),
> -                       N_("option for merge strategy"), option_parse_x),
> +               OPT_STRVEC('X', "strategy-option", &opts->xopts, N_("opti=
on"),
> +                       N_("option for merge strategy")),
>                 { OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("ke=
y-id"),
>                   N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_=
t) "" },
>                 OPT_END()
> @@ -176,7 +162,7 @@ static int run_sequencer(int argc, const char **argv,=
 struct replay_opts *opts)
>                                 "--signoff", opts->signoff,
>                                 "--mainline", opts->mainline,
>                                 "--strategy", opts->strategy ? 1 : 0,
> -                               "--strategy-option", opts->xopts ? 1 : 0,
> +                               "--strategy-option", opts->xopts.nr ? 1 :=
 0,
>                                 "-x", opts->record_origin,
>                                 "--ff", opts->allow_ff,
>                                 "--rerere-autoupdate", opts->allow_rerere=
_auto =3D=3D RERERE_AUTOUPDATE,
> diff --git a/parse-options-cb.c b/parse-options-cb.c
> index d346dbe210..8eb96c5ca9 100644
> --- a/parse-options-cb.c
> +++ b/parse-options-cb.c
> @@ -208,6 +208,22 @@ int parse_opt_string_list(const struct option *opt, =
const char *arg, int unset)
>         return 0;
>  }
>
> +int parse_opt_strvec(const struct option *opt, const char *arg, int unse=
t)
> +{
> +       struct strvec *v =3D opt->value;
> +
> +       if (unset) {
> +               strvec_clear(v);
> +               return 0;
> +       }
> +
> +       if (!arg)
> +               return -1;
> +
> +       strvec_push(v, arg);
> +       return 0;
> +}
> +
>  int parse_opt_noop_cb(const struct option *opt, const char *arg, int uns=
et)
>  {
>         return 0;
> diff --git a/parse-options.h b/parse-options.h
> index 26f19384e5..2d1d4d052f 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -285,6 +285,15 @@ struct option {
>         .help =3D (h), \
>         .callback =3D &parse_opt_string_list, \
>  }
> +#define OPT_STRVEC(s, l, v, a, h) { \
> +       .type =3D OPTION_CALLBACK, \
> +       .short_name =3D (s), \
> +       .long_name =3D (l), \
> +       .value =3D (v), \
> +       .argh =3D (a), \
> +       .help =3D (h), \
> +       .callback =3D &parse_opt_strvec, \
> +}
>  #define OPT_UYN(s, l, v, h) { \
>         .type =3D OPTION_CALLBACK, \
>         .short_name =3D (s), \
> @@ -478,6 +487,7 @@ int parse_opt_commits(const struct option *, const ch=
ar *, int);
>  int parse_opt_commit(const struct option *, const char *, int);
>  int parse_opt_tertiary(const struct option *, const char *, int);
>  int parse_opt_string_list(const struct option *, const char *, int);
> +int parse_opt_strvec(const struct option *, const char *, int);
>  int parse_opt_noop_cb(const struct option *, const char *, int);
>  enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
>                                            const struct option *,
> diff --git a/sequencer.c b/sequencer.c
> index c35a67e104..6e2f3357c8 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -355,9 +355,7 @@ void replay_opts_release(struct replay_opts *opts)
>         free(opts->reflog_action);
>         free(opts->default_strategy);
>         free(opts->strategy);
> -       for (size_t i =3D 0; i < opts->xopts_nr; i++)
> -               free(opts->xopts[i]);
> -       free(opts->xopts);
> +       strvec_clear (&opts->xopts);
>         strbuf_release(&opts->current_fixups);
>         if (opts->revs)
>                 release_revisions(opts->revs);
> @@ -693,8 +691,8 @@ static int do_recursive_merge(struct repository *r,
>         next_tree =3D next ? get_commit_tree(next) : empty_tree(r);
>         base_tree =3D base ? get_commit_tree(base) : empty_tree(r);
>
> -       for (i =3D 0; i < opts->xopts_nr; i++)
> -               parse_merge_opt(&o, opts->xopts[i]);
> +       for (i =3D 0; i < opts->xopts.nr; i++)
> +               parse_merge_opt(&o, opts->xopts.v[i]);
>
>         if (!opts->strategy || !strcmp(opts->strategy, "ort")) {
>                 memset(&result, 0, sizeof(result));
> @@ -2325,7 +2323,7 @@ static int do_pick_commit(struct repository *r,
>                 commit_list_insert(base, &common);
>                 commit_list_insert(next, &remotes);
>                 res |=3D try_merge_command(r, opts->strategy,
> -                                        opts->xopts_nr, (const char **)o=
pts->xopts,
> +                                        opts->xopts.nr, opts->xopts.v,
>                                         common, oid_to_hex(&head), remote=
s);
>                 free_commit_list(common);
>                 free_commit_list(remotes);
> @@ -2898,8 +2896,7 @@ static int populate_opts_cb(const char *key, const =
char *value, void *data)
>         else if (!strcmp(key, "options.gpg-sign"))
>                 git_config_string_dup(&opts->gpg_sign, key, value);
>         else if (!strcmp(key, "options.strategy-option")) {
> -               ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_a=
lloc);
> -               opts->xopts[opts->xopts_nr++] =3D xstrdup(value);
> +               strvec_push(&opts->xopts, value);
>         } else if (!strcmp(key, "options.allow-rerere-auto"))
>                 opts->allow_rerere_auto =3D
>                         git_config_bool_or_int(key, value, &error_flag) ?
> @@ -2920,22 +2917,21 @@ void parse_strategy_opts(struct replay_opts *opts=
, char *raw_opts)
>  {
>         int i;
>         int count;
> +       const char **argv;
>         char *strategy_opts_string =3D raw_opts;
>
>         if (*strategy_opts_string =3D=3D ' ')
>                 strategy_opts_string++;
>
> -       count =3D split_cmdline(strategy_opts_string,
> -                             (const char ***)&opts->xopts);
> +       count =3D split_cmdline(strategy_opts_string, &argv);
>         if (count < 0)
>                 die(_("could not split '%s': %s"), strategy_opts_string,
>                             split_cmdline_strerror(count));
> -       opts->xopts_nr =3D count;
> -       for (i =3D 0; i < opts->xopts_nr; i++) {
> -               const char *arg =3D opts->xopts[i];
> +       for (i =3D 0; i < count; i++) {
> +               const char *arg =3D argv[i];
>
>                 skip_prefix(arg, "--", &arg);
> -               opts->xopts[i] =3D xstrdup(arg);
> +               strvec_push(&opts->xopts, arg);
>         }
>  }
>
> @@ -3055,8 +3051,8 @@ static void write_strategy_opts(struct replay_opts =
*opts)
>         int i;
>         struct strbuf buf =3D STRBUF_INIT;
>
> -       for (i =3D 0; i < opts->xopts_nr; ++i)
> -               strbuf_addf(&buf, " --%s", opts->xopts[i]);
> +       for (i =3D 0; i < opts->xopts.nr; ++i)
> +               strbuf_addf(&buf, " --%s", opts->xopts.v[i]);
>
>         write_file(rebase_path_strategy_opts(), "%s\n", buf.buf);
>         strbuf_release(&buf);
> @@ -3080,7 +3076,7 @@ int write_basic_state(struct replay_opts *opts, con=
st char *head_name,
>                 write_file(rebase_path_verbose(), "%s", "");
>         if (opts->strategy)
>                 write_file(rebase_path_strategy(), "%s\n", opts->strategy=
);
> -       if (opts->xopts_nr > 0)
> +       if (opts->xopts.nr > 0)
>                 write_strategy_opts(opts);
>
>         if (opts->allow_rerere_auto =3D=3D RERERE_AUTOUPDATE)
> @@ -3464,13 +3460,10 @@ static int save_opts(struct replay_opts *opts)
>         if (opts->gpg_sign)
>                 res |=3D git_config_set_in_file_gently(opts_file,
>                                         "options.gpg-sign", opts->gpg_sig=
n);
> -       if (opts->xopts) {
> -               int i;
> -               for (i =3D 0; i < opts->xopts_nr; i++)
> -                       res |=3D git_config_set_multivar_in_file_gently(o=
pts_file,
> -                                       "options.strategy-option",
> -                                       opts->xopts[i], "^$", 0);
> -       }
> +       for (size_t i =3D 0; i < opts->xopts.nr; i++)
> +               res |=3D git_config_set_multivar_in_file_gently(opts_file=
,
> +                               "options.strategy-option",
> +                               opts->xopts.v[i], "^$", 0);
>         if (opts->allow_rerere_auto)
>                 res |=3D git_config_set_in_file_gently(opts_file,
>                                 "options.allow-rerere-auto",
> @@ -3880,7 +3873,7 @@ static int do_merge(struct repository *r,
>         struct commit *head_commit, *merge_commit, *i;
>         struct commit_list *bases, *j;
>         struct commit_list *to_merge =3D NULL, **tail =3D &to_merge;
> -       const char *strategy =3D !opts->xopts_nr &&
> +       const char *strategy =3D !opts->xopts.nr &&
>                 (!opts->strategy ||
>                  !strcmp(opts->strategy, "recursive") ||
>                  !strcmp(opts->strategy, "ort")) ?
> @@ -4063,9 +4056,9 @@ static int do_merge(struct repository *r,
>                         strvec_push(&cmd.args, "octopus");
>                 else {
>                         strvec_push(&cmd.args, strategy);
> -                       for (k =3D 0; k < opts->xopts_nr; k++)
> +                       for (k =3D 0; k < opts->xopts.nr; k++)
>                                 strvec_pushf(&cmd.args,
> -                                            "-X%s", opts->xopts[k]);
> +                                            "-X%s", opts->xopts.v[k]);
>                 }
>                 if (!(flags & TODO_EDIT_MERGE_MSG))
>                         strvec_push(&cmd.args, "--no-edit");
> diff --git a/sequencer.h b/sequencer.h
> index 33dbaf5b66..8a79d6b200 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -2,6 +2,7 @@
>  #define SEQUENCER_H
>
>  #include "strbuf.h"
> +#include "strvec.h"
>  #include "wt-status.h"
>
>  struct commit;
> @@ -60,8 +61,7 @@ struct replay_opts {
>         /* Merge strategy */
>         char *default_strategy;  /* from config options */
>         char *strategy;
> -       char **xopts;
> -       size_t xopts_nr, xopts_alloc;
> +       struct strvec xopts;
>
>         /* Reflog */
>         char *reflog_action;
> @@ -80,7 +80,12 @@ struct replay_opts {
>         /* Private use */
>         const char *reflog_message;
>  };
> -#define REPLAY_OPTS_INIT { .edit =3D -1, .action =3D -1, .current_fixups=
 =3D STRBUF_INIT }
> +#define REPLAY_OPTS_INIT {                     \
> +       .edit =3D -1,                             \
> +       .action =3D -1,                           \
> +       .current_fixups =3D STRBUF_INIT,          \
> +       .xopts =3D STRVEC_INIT,                   \
> +}
>
>  /*
>   * Note that ordering matters in this enum. Not only must it match the m=
apping
> --
> 2.40.0.670.g64ef305212.dirty

Simple, but very nice cleanup.  :-)
