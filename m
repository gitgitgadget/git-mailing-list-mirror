Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN4LmZd7"
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5064410DA
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 10:59:35 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50aabfa1b75so1568013e87.3
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 10:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700765973; x=1701370773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQEKfPvfkX33eifiqQxrB9heG/F4Datn21bKYqf/CtU=;
        b=nN4LmZd7g7jFAC/0JF/LmQTXoY/gGI+4ly6JeVKPbUO8zHLdQKL6cNaVopoz85afFI
         3oAjikDAPkJbxJy5LKFAkTffMK27M1xZTrLqXca7GUZfDbjX6v2BUqgblq17auLzAV5X
         BZEZ5wAYwKkwaMdEZaUjHn2hpCuCX7yDnn8g//Z4jgKfdDMgm+pehyGIZzArgfqP9LGd
         qMYVP4sMrncyou6F0WfLxOzQXbv0N0Y8dkSgPEiIZso3I6/6j8y45UnzvT7fEX880xGI
         zTNi843Fnx/f9T0H5o/xD36os5Ah8AjwkGD3wTVIRhLh0Yuhzi251I44u8KGYf031N46
         h51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700765973; x=1701370773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQEKfPvfkX33eifiqQxrB9heG/F4Datn21bKYqf/CtU=;
        b=Y2XQdVc0VTIw3LDKwIUBeTKdkCFBa/SfRCGRr/c6sJ3bhObCEE9vZqwkldEVAL5sfW
         qk9q82f4i3xVlZnZSvo0R2kWc7KeR5Ob8J2hwmC6Ilza93J4mr0TQfPuRIsiWDvTuP8C
         MU7fsiU+YinDzg7zZTaynLtdCNwE+nLFmWnJUP6mswi3QJ/6fS+Zw9vQ1e1velGyL9nc
         cMvJn6NN+r50ziD6RI0o3Q2MxRIplxAoT3cRDE+om3NpCQqPZtWI9XKa1w9dRUjzFiAk
         xXfk4eky+ML+K7Tl1hpg7lnPBQyPYqhcpjg6v3Gi/nZEhMOWf7b8+9pTIxlOLis4kLrO
         pC/w==
X-Gm-Message-State: AOJu0YwwRh3sUlSKnzzIYc8m7R/Zt0GltKabYdPNsQipfwPPCVdirBeR
	sIjipsbX19eF+DfDI0GlrTWOOg8siVWwaFnjJQ8=
X-Google-Smtp-Source: AGHT+IFVPG797SsIoq25QyENAocFaTV1ym2XrDehpsR5kfna6WC8WTl+NlO7GjtawcwJfo6suYxSWi9PEEHbHwEIy5g=
X-Received: by 2002:a05:6512:2809:b0:50a:6bbc:52e7 with SMTP id
 cf9-20020a056512280900b0050a6bbc52e7mr151042lfb.2.1700765973037; Thu, 23 Nov
 2023 10:59:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1616.git.1700680717.gitgitgadget@gmail.com> <a1686ab52f1bec4bddeaab973c9b77e55e8b539b.1700680717.git.gitgitgadget@gmail.com>
In-Reply-To: <a1686ab52f1bec4bddeaab973c9b77e55e8b539b.1700680717.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 23 Nov 2023 10:59:20 -0800
Message-ID: <CABPp-BELjVqVEB3oVx3fMzmvNfE1f7muLR_2k912_C+SaQtZtg@mail.gmail.com>
Subject: Re: [PATCH 2/4] trace2: redact passwords from https:// URLs by default
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 11:19=E2=80=AFAM Johannes Schindelin via GitGitGadg=
et
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It is an unsafe practice to call something like
>
>         git clone https://user:password@example.com/
>
> This not only risks leaking the password "over the shoulder" or into the
> readline history of the current Unix shell, it also gets logged via
> Trace2 if enabled.

Indeed.  Clone urls _also_ seem to be slurped up by other tools, such
as IDEs, and possibly sent off to various third-party cloud services
when users have various AI-assist plugins installed in their IDEs,
resulting in some infosec incidents and fire drills.  (Not a
theoretical scenario, and not fun.)

> Let's at least avoid logging such secrets via Trace2, much like we avoid
> logging secrets in `http.c`. Much like the code in `http.c` is guarded
> via `GIT_TRACE_REDACT` (defaulting to `true`), we guard the new code via
> `GIT_TRACE2_REDACT` (also defaulting to `true`).

Training users is hard.  I appreciate the changes here to make trace2
not be a leak vector, but is it time to perhaps consider bigger safety
measures: At the clone/fetch level, automatically warn loudly whenever
such a URL is provided, accompanied with a note that in the future it
will be turned into a hard error?

Either way, I agree with your "at least" comment here and the changes
you are making.

> The new tests added in this commit uncover leaks in `builtin/clone.c`
> and `remote.c`. Therefore we need to turn off
> `TEST_PASSES_SANITIZE_LEAK`. The reasons:
>
> - We observed that `the_repository->remote_status` is not released
>   properly.
>
> - We are using `url...insteadOf` and that runs into a code path where an
>   allocated URL is replaced with another URL, and the original URL is
>   never released.
>
> - `remote_states` contains plenty of `struct remote`s whose refspecs
>   seem to be usually allocated by never released.
>
> More investigation is needed here to identify the exact cause and
> proper fixes for these leaks/bugs.

Thanks for carefully documenting and explaining.

> Co-authored-by: Jeff Hostetler <jeffhostetler@github.com>
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t0210-trace2-normal.sh |  20 ++++++-
>  trace2.c                 | 120 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 136 insertions(+), 4 deletions(-)
>
> diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
> index 80e76a4695e..c312657a12c 100755
> --- a/t/t0210-trace2-normal.sh
> +++ b/t/t0210-trace2-normal.sh
> @@ -2,7 +2,7 @@
>
>  test_description=3D'test trace2 facility (normal target)'
>
> -TEST_PASSES_SANITIZE_LEAK=3Dtrue
> +TEST_PASSES_SANITIZE_LEAK=3Dfalse
>  . ./test-lib.sh
>
>  # Turn off any inherited trace2 settings for this test.
> @@ -283,4 +283,22 @@ test_expect_success 'using global config with includ=
e' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'unsafe URLs are redacted by default' '
> +       test_when_finished \
> +               "rm -r trace.normal unredacted.normal clone clone2" &&
> +
> +       test_config_global \
> +               "url.$(pwd).insteadOf" https://user:pwd@example.com/ &&
> +       test_config_global trace2.configParams "core.*,remote.*.url" &&
> +
> +       GIT_TRACE2=3D"$(pwd)/trace.normal" \
> +               git clone https://user:pwd@example.com/ clone &&
> +       ! grep user:pwd trace.normal &&
> +
> +       GIT_TRACE2_REDACT=3D0 GIT_TRACE2=3D"$(pwd)/unredacted.normal" \
> +               git clone https://user:pwd@example.com/ clone2 &&
> +       grep "start .* clone https://user:pwd@example.com" unredacted.nor=
mal &&
> +       grep "remote.origin.url=3Dhttps://user:pwd@example.com" unredacte=
d.normal
> +'
> +
>  test_done
> diff --git a/trace2.c b/trace2.c
> index 6dc74dff4c7..87d9a3a0361 100644
> --- a/trace2.c
> +++ b/trace2.c
> @@ -20,6 +20,7 @@
>  #include "trace2/tr2_tmr.h"
>
>  static int trace2_enabled;
> +static int trace2_redact =3D 1;
>
>  static int tr2_next_child_id; /* modify under lock */
>  static int tr2_next_exec_id; /* modify under lock */
> @@ -227,6 +228,8 @@ void trace2_initialize_fl(const char *file, int line)
>         if (!tr2_tgt_want_builtins())
>                 return;
>         trace2_enabled =3D 1;
> +       if (!git_env_bool("GIT_TRACE2_REDACT", 1))
> +               trace2_redact =3D 0;
>
>         tr2_sid_get();
>
> @@ -247,12 +250,93 @@ int trace2_is_enabled(void)
>         return trace2_enabled;
>  }
>
> +/*
> + * Redacts an argument, i.e. ensures that no password in
> + * https://user:password@host/-style URLs is logged.
> + *
> + * Returns the original if nothing needed to be redacted.
> + * Returns a pointer that needs to be `free()`d otherwise.
> + */
> +static const char *redact_arg(const char *arg)
> +{
> +       const char *p, *colon;
> +       size_t at;
> +
> +       if (!trace2_redact ||
> +           (!skip_prefix(arg, "https://", &p) &&
> +            !skip_prefix(arg, "http://", &p)))
> +               return arg;
> +
> +       at =3D strcspn(p, "@/");
> +       if (p[at] !=3D '@')
> +               return arg;
> +
> +       colon =3D memchr(p, ':', at);
> +       if (!colon)
> +               return arg;
> +
> +       return xstrfmt("%.*s:<REDACTED>%s", (int)(colon - arg), arg, p + =
at);
> +}
> +
> +/*
> + * Redacts arguments in an argument list.
> + *
> + * Returns the original if nothing needed to be redacted.
> + * Otherwise, returns a new array that needs to be released
> + * via `free_redacted_argv()`.
> + */
> +static const char **redact_argv(const char **argv)
> +{
> +       int i, j;
> +       const char *redacted =3D NULL;
> +       const char **ret;
> +
> +       if (!trace2_redact)
> +               return argv;
> +
> +       for (i =3D 0; argv[i]; i++)
> +               if ((redacted =3D redact_arg(argv[i])) !=3D argv[i])
> +                       break;
> +
> +       if (!argv[i])
> +               return argv;
> +
> +       for (j =3D 0; argv[j]; j++)
> +               ; /* keep counting */
> +
> +       ALLOC_ARRAY(ret, j + 1);
> +       ret[j] =3D NULL;
> +
> +       for (j =3D 0; j < i; j++)
> +               ret[j] =3D argv[j];
> +       ret[i] =3D redacted;
> +       for (++i; argv[i]; i++) {
> +               redacted =3D redact_arg(argv[i]);
> +               ret[i] =3D redacted ? redacted : argv[i];
> +       }
> +
> +       return ret;
> +}
> +
> +static void free_redacted_argv(const char **redacted, const char **argv)
> +{
> +       int i;
> +
> +       if (redacted !=3D argv) {
> +               for (i =3D 0; argv[i]; i++)
> +                       if (redacted[i] !=3D argv[i])
> +                               free((void *)redacted[i]);
> +               free((void *)redacted);
> +       }
> +}
> +
>  void trace2_cmd_start_fl(const char *file, int line, const char **argv)
>  {
>         struct tr2_tgt *tgt_j;
>         int j;
>         uint64_t us_now;
>         uint64_t us_elapsed_absolute;
> +       const char **redacted;
>
>         if (!trace2_enabled)
>                 return;
> @@ -260,10 +344,14 @@ void trace2_cmd_start_fl(const char *file, int line=
, const char **argv)
>         us_now =3D getnanotime() / 1000;
>         us_elapsed_absolute =3D tr2tls_absolute_elapsed(us_now);
>
> +       redacted =3D redact_argv(argv);
> +
>         for_each_wanted_builtin (j, tgt_j)
>                 if (tgt_j->pfn_start_fl)
>                         tgt_j->pfn_start_fl(file, line, us_elapsed_absolu=
te,
> -                                           argv);
> +                                           redacted);
> +
> +       free_redacted_argv(redacted, argv);
>  }
>
>  void trace2_cmd_exit_fl(const char *file, int line, int code)
> @@ -409,6 +497,7 @@ void trace2_child_start_fl(const char *file, int line=
,
>         int j;
>         uint64_t us_now;
>         uint64_t us_elapsed_absolute;
> +       const char **orig_argv =3D cmd->args.v;
>
>         if (!trace2_enabled)
>                 return;
> @@ -419,10 +508,24 @@ void trace2_child_start_fl(const char *file, int li=
ne,
>         cmd->trace2_child_id =3D tr2tls_locked_increment(&tr2_next_child_=
id);
>         cmd->trace2_child_us_start =3D us_now;
>
> +       /*
> +        * The `pfn_child_start_fl` API takes a `struct child_process`
> +        * rather than a simple `argv` for the child because some
> +        * targets make use of the additional context bits/values. So
> +        * temporarily replace the original argv (inside the `strvec`)
> +        * with a possibly redacted version.
> +        */
> +       cmd->args.v =3D redact_argv(orig_argv);
> +
>         for_each_wanted_builtin (j, tgt_j)
>                 if (tgt_j->pfn_child_start_fl)
>                         tgt_j->pfn_child_start_fl(file, line,
>                                                   us_elapsed_absolute, cm=
d);
> +
> +       if (cmd->args.v !=3D orig_argv) {
> +               free_redacted_argv(cmd->args.v, orig_argv);
> +               cmd->args.v =3D orig_argv;
> +       }
>  }
>
>  void trace2_child_exit_fl(const char *file, int line, struct child_proce=
ss *cmd,
> @@ -493,6 +596,7 @@ int trace2_exec_fl(const char *file, int line, const =
char *exe,
>         int exec_id;
>         uint64_t us_now;
>         uint64_t us_elapsed_absolute;
> +       const char **redacted;
>
>         if (!trace2_enabled)
>                 return -1;
> @@ -502,10 +606,14 @@ int trace2_exec_fl(const char *file, int line, cons=
t char *exe,
>
>         exec_id =3D tr2tls_locked_increment(&tr2_next_exec_id);
>
> +       redacted =3D redact_argv(argv);
> +
>         for_each_wanted_builtin (j, tgt_j)
>                 if (tgt_j->pfn_exec_fl)
>                         tgt_j->pfn_exec_fl(file, line, us_elapsed_absolut=
e,
> -                                          exec_id, exe, argv);
> +                                          exec_id, exe, redacted);
> +
> +       free_redacted_argv(redacted, argv);
>
>         return exec_id;
>  }
> @@ -637,13 +745,19 @@ void trace2_def_param_fl(const char *file, int line=
, const char *param,
>  {
>         struct tr2_tgt *tgt_j;
>         int j;
> +       const char *redacted;
>
>         if (!trace2_enabled)
>                 return;
>
> +       redacted =3D redact_arg(value);
> +
>         for_each_wanted_builtin (j, tgt_j)
>                 if (tgt_j->pfn_param_fl)
> -                       tgt_j->pfn_param_fl(file, line, param, value, kvi=
);
> +                       tgt_j->pfn_param_fl(file, line, param, redacted, =
kvi);
> +
> +       if (redacted !=3D value)
> +               free((void *)redacted);
>  }
>
>  void trace2_def_repo_fl(const char *file, int line, struct repository *r=
epo)
> --
> gitgitgadget
