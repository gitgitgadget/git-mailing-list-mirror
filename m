From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 28/44] builtin-am: pass git-apply's options to git-apply
Date: Mon, 29 Jun 2015 16:56:25 -0700
Message-ID: <CAGZ79kbzwv8m47t5W+1djFEWGL_X1nHPf7FWcwcKAZ34oFszxg@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-29-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 01:56:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9iun-0007vV-Fb
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 01:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbbF2X4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 19:56:32 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36234 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbbF2X40 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 19:56:26 -0400
Received: by ykdr198 with SMTP id r198so129405871ykd.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 16:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3WfisLlpYigT0bqx73U56CGW6+u/gSGW7rod9o/rklQ=;
        b=Sg/ra2DnYeCEqQJqqlCX3uVoEbpwgskMebZBxVwdtsqYP6iu9y5oNfIhdvD10HziDm
         IVPXR6eM2KvOfkNLaJG5A/siaVrljvQaPkFenPb576+dyE6xkGtyIAz88S4MYUezuYJw
         UjWDw71G+Juw8p3hM3tw3eKDrBC80mp3bO9z2j/+Xdq6ZJEzTgpWT1PBAAJ4atQmBrkA
         CaihvUAbSdJP6Ui0zOr/P/c1y0ZizqISFemvpBGRoO4WnC0J739ge8BejM9Nb1DDptYN
         tmLGCmBG0/dwjTlpsDwLmClBqmQi5jK6COVm1CBH5eYIt/owuTlllbQNrCH5mT7MvAAv
         GMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3WfisLlpYigT0bqx73U56CGW6+u/gSGW7rod9o/rklQ=;
        b=cWA2rHZg2fg4YEJgcgr75U5KgVIlKvDhvuasrVXysgYMSswjjrSLeBjbCEKvJWj15+
         /B81u7TDXbqDv7fbVCGEsLpXPp5Gf6KaWzhkyudLbDNH9OTbSRJOkGneR0gDJo+hGULo
         8Zff1cMQD/8BA/1/kvpd3MWbvxFqGqttklJGplqYgnRsRWlKUpD4vYHutUctLp+S/YaZ
         O7X59fwPIiWw4OrGaUvZK/kH9D1dF8E3quBGNfZsEZ6ANbfbg3W8VrJoEE4dhr2W/6ty
         fB+oV0L9UX3KWJGII26J1a1xUC6yrYEMsQH7Zukb9rd2riD2m0NhMJucZKW943U1RAeq
         mAtQ==
X-Gm-Message-State: ALoCoQl10jtGhjjFKUT/wXsj/2Pp+K0/mCkJ+M0OAgDjQPWfrUBjodD3cl6ZqcH8bvU0+HMOm4hM
X-Received: by 10.170.82.131 with SMTP id y125mr21846121yky.115.1435622185495;
 Mon, 29 Jun 2015 16:56:25 -0700 (PDT)
Received: by 10.37.4.80 with HTTP; Mon, 29 Jun 2015 16:56:25 -0700 (PDT)
In-Reply-To: <1435500366-31700-29-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273029>

On Sun, Jun 28, 2015 at 7:05 AM, Paul Tan <pyokagan@gmail.com> wrote:
> git-am.sh recognizes some of git-apply's options, and would pass them to
> git-apply:
>
> * --whitespace, since 8c31cb8 (git-am: --whitespace=x option.,
>   2006-02-28)
>
> * -C, since 67dad68 (add -C[NUM] to git-am, 2007-02-08)
>
> * -p, since 2092a1f (Teach git-am to pass -p option down to git-apply,
>   2007-02-11)
>
> * --directory, since b47dfe9 (git-am: add --directory=<dir> option,
>   2009-01-11)
>
> * --reject, since b80da42 (git-am: implement --reject option passed to
>   git-apply, 2009-01-23)
>
> * --ignore-space-change, --ignore-whitespace, since 86c91f9 (git apply:
>   option to ignore whitespace differences, 2009-08-04)
>
> * --exclude, since 77e9e49 (am: pass exclude down to apply, 2011-08-03)
>
> * --include, since 58725ef (am: support --include option, 2012-03-28)
>
> * --reject, since b80da42 (git-am: implement --reject option passed to
>   git-apply, 2009-01-23)
>
> Re-implement support for these options in builtin/am.c.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  builtin/am.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 55989e5..5aab627 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -115,6 +115,8 @@ struct am_state {
>         /* one of the enum scissors_type values */
>         int scissors;
>
> +       struct argv_array git_apply_opts;
> +
>         /* override error message when patch failure occurs */
>         const char *resolvemsg;
>
> @@ -147,6 +149,8 @@ static void am_state_init(struct am_state *state, const char *dir)
>         git_config_get_bool("am.messageid", &state->message_id);
>
>         state->scissors = SCISSORS_UNSET;
> +
> +       argv_array_init(&state->git_apply_opts);
>  }
>
>  /**
> @@ -168,6 +172,8 @@ static void am_state_release(struct am_state *state)
>
>         if (state->msg)
>                 free(state->msg);
> +
> +       argv_array_clear(&state->git_apply_opts);
>  }
>
>  /**
> @@ -447,6 +453,11 @@ static void am_load(struct am_state *state)
>         else
>                 state->scissors = SCISSORS_UNSET;
>
> +       read_state_file(&sb, state, "apply-opt", 1);
> +       argv_array_clear(&state->git_apply_opts);
> +       if (sq_dequote_to_argv_array(sb.buf, &state->git_apply_opts) < 0)
> +               die(_("could not parse %s"), am_path(state, "apply-opt"));
> +
>         state->rebasing = !!file_exists(am_path(state, "rebasing"));
>
>         strbuf_release(&sb);
> @@ -621,6 +632,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
>  {
>         unsigned char curr_head[GIT_SHA1_RAWSZ];
>         const char *str;
> +       struct strbuf sb = STRBUF_INIT;
>
>         if (!patch_format)
>                 patch_format = detect_patch_format(paths);
> @@ -683,6 +695,9 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
>
>         write_file(am_path(state, "scissors"), 1, "%s", str);
>
> +       sq_quote_argv(&sb, state->git_apply_opts.argv, 0);
> +       write_file(am_path(state, "apply-opt"), 1, "%s", sb.buf);
> +
>         if (state->rebasing)
>                 write_file(am_path(state, "rebasing"), 1, "%s", "");
>         else
> @@ -707,6 +722,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
>         write_file(am_path(state, "next"), 1, "%d", state->cur);
>
>         write_file(am_path(state, "last"), 1, "%d", state->last);
> +
> +       strbuf_release(&sb);
>  }
>
>  /**
> @@ -1099,6 +1116,8 @@ static int run_apply(const struct am_state *state, const char *index_file)
>
>         argv_array_push(&cp.args, "apply");
>
> +       argv_array_pushv(&cp.args, state->git_apply_opts.argv);
> +
>         if (index_file)
>                 argv_array_push(&cp.args, "--cached");
>         else
> @@ -1125,6 +1144,7 @@ static int build_fake_ancestor(const struct am_state *state, const char *index_f
>
>         cp.git_cmd = 1;
>         argv_array_push(&cp.args, "apply");
> +       argv_array_pushv(&cp.args, state->git_apply_opts.argv);
>         argv_array_pushf(&cp.args, "--build-fake-ancestor=%s", index_file);
>         argv_array_push(&cp.args, am_path(state, "patch"));
>
> @@ -1616,9 +1636,36 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>                   PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
>                 OPT_BOOL('c', "scissors", &state.scissors,
>                         N_("strip everything before a scissors line")),
> +               OPT_PASSTHRU_ARGV(0, "whitespace", &state.git_apply_opts, N_("action"),
> +                       N_("pass it through git-apply"),
> +                       0),
> +               OPT_PASSTHRU_ARGV(0, "ignore-space-change", &state.git_apply_opts, NULL,
> +                       N_("pass it through git-apply"),
> +                       PARSE_OPT_NOARG),
> +               OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &state.git_apply_opts, NULL,
> +                       N_("pass it through git-apply"),
> +                       PARSE_OPT_NOARG),
> +               OPT_PASSTHRU_ARGV(0, "directory", &state.git_apply_opts, N_("root"),
> +                       N_("pass it through git-apply"),
> +                       0),
> +               OPT_PASSTHRU_ARGV(0, "exclude", &state.git_apply_opts, N_("path"),
> +                       N_("pass it through git-apply"),
> +                       0),
> +               OPT_PASSTHRU_ARGV(0, "include", &state.git_apply_opts, N_("path"),
> +                       N_("pass it through git-apply"),
> +                       0),
> +               OPT_PASSTHRU_ARGV('C', NULL, &state.git_apply_opts, N_("n"),
> +                       N_("pass it through git-apply"),
> +                       0),
> +               OPT_PASSTHRU_ARGV('p', NULL, &state.git_apply_opts, N_("num"),
> +                       N_("pass it through git-apply"),
> +                       0),

I realize this was in am.sh as well, but I find the help strings a bit
unfortunate.
(Yes, you actually need to look them up at another place as most people are
not familiar with the apply options).

>                 OPT_CALLBACK(0, "patch-format", &patch_format, N_("format"),
>                         N_("format the patch(es) are in"),
>                         parse_opt_patchformat),
> +               OPT_PASSTHRU_ARGV(0, "reject", &state.git_apply_opts, NULL,
> +                       N_("pass it through git-apply"),
> +                       PARSE_OPT_NOARG),
>                 OPT_STRING(0, "resolvemsg", &state.resolvemsg, NULL,
>                         N_("override error message when patch failure occurs")),
>                 OPT_CMDMODE(0, "continue", &resume,
> --
> 2.5.0.rc0.76.gb2c6e93
>
