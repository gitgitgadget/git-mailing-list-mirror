Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EF7287258
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763622249; cv=none; b=IqYRJtyDeNkFlWL+OFNcr4j2A9pESzk2mwbsRn4/w+ZdECQGTitrsf70UTSPYimxNU169QNk6Tf9/XFkjr3P1yP/cfsXLaFTKGLBoaQ4pVoD3B8vVgfbkdrqrEX2jFyHG74MYyUgK+y5MXGbQYskDdJNjHmGAY8KgZ9YWmrn+CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763622249; c=relaxed/simple;
	bh=bSrWSXzNSWDzo1zyVqcmu80AMl5m1tEO3XPws2sNrjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyjzffUWqVX4uTemBSx4C14Z2hTcz/kRNASKaHIUuNlEGrnf077QM69JQOVuUJisG/Lu6bbzGZD/VNWavX8AXK93g6PgJx6ZHjpb96kK0+1rDozB5sUy/NwfAahro33eumW5bOaRANdVrxOgOHgCJIc6nGOWO/gvnqAN+jNBomU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDfwPb6w; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDfwPb6w"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-949325df6c8so25321239f.1
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 23:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763622245; x=1764227045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXn47NRoFmfPY5cVpPU0ZwfLcv10T71oTyGF2b/LAZI=;
        b=LDfwPb6wkZO7eRL2d+A1Xx11Z7EpT7JzzFdLvOGMWFeqZ08RkxfuQAb8QAeXUidJu9
         JrhrBNvKGpF5qUpXciFGkjnnOzo4cbHgKyGio5FeQfj2Sbbe0gD+quXsTqqMsFF7VKxm
         vDs+uQIUqw2JXEHyj/BuDLt8CGCsZKhZS6RJkpgZkvD6fmabZFEVA4Ee2dXYCAqULpDW
         wRikbMaaurjZA6IVXHmasknUIh7/YruXDqrxlydpZChIIv/hdPqQseS4i8aehzOixlTa
         G6Wl8qN8qaYa5mkp/lWwsshp4ntPA5+gn20Sm8pZPH9E/e4TilMmqFyOFOK4fIcOONA3
         ChNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763622245; x=1764227045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nXn47NRoFmfPY5cVpPU0ZwfLcv10T71oTyGF2b/LAZI=;
        b=mSEbuNYxAdD3TvprqchYK6j5jJdvy32MszL1VVHUJtwqr3geT/F69Bau8Y2iQzP5+i
         HgYOBRZHTazlqTUcbO+6obFvyUnjGiqJtR256DsEa7MTlIqkwL19D82VitZWEote872l
         Yfd53rxVr9WLNBJye/SUytq3NlDqwd+LXItNsE7JrU4LYUcGqCypLGTPhFEIYIUVCPrB
         CRpQrhH62nDLIJ4UU3fUthRaSl5BZ8VC1n1veY5u28n+9EFFu9b2osWAFbdVnYRODr7r
         qUxwUbphLI0nQ5Yh9ckCh4PjUDxwMenR6xxkp0MmCfN9Ahth3Bnb7qiWhojdk1vtUrPD
         yAvA==
X-Gm-Message-State: AOJu0YxLzCWMJCjA/2Z3LQaIqUevKqknPe9Nyju2Z+dgENfBhvII5Dxa
	W9vKeoFJg6mZL/HxFMM04/70+uyqru4XiFwPFeH4H046ne1satR29hhaXYj5wcurTmJhlgIv8k4
	wJyMFJjddICj3g4VCh2cqwCVlRBes+7A=
X-Gm-Gg: ASbGncsKXZSzFI/THxvWwqF/OdInwd5EPdOoHXcFnZuh02o7vyxuZEKi85xTTvUv2C1
	f/Xle9oIJToCptA2WEpGWfV+URXTLe991wml/N4vNF+VlZC3lPAPAbR0VlkiftVO/dm66V7iMHP
	7ifKdm6H2aptkuSMRgnEcev1cRNwQHcoK77vyEDHkvyXUI/7lNtuORJdQCvYrj/ne2zaj+OYG6U
	kP7UJmC/pSFEqAGMFh7YTA1UPUa4qfa4SwAw75ducqMx6ViNyDAhUHCP9HI3d2X7BjRKKCEReY1
	qatnht0N33XYk9jkKzIdGf4azc10
X-Google-Smtp-Source: AGHT+IEaOoEGb9/q6xyDhT5kZOSsc0loM/GvpVMnoN28Splw2ZNmA/K2KEBX4tecKy28g5Wb1iqpBKGA3gR9JiqcpGg=
X-Received: by 2002:a05:6638:8e03:b0:5b7:d710:661f with SMTP id
 8926c6da1cb9f-5b9541d7ae7mr1365952173.22.1763622244726; Wed, 19 Nov 2025
 23:04:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im> <20251027-b4-pks-history-builtin-v6-8-407dd3f57ad3@pks.im>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-8-407dd3f57ad3@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Nov 2025 23:03:53 -0800
X-Gm-Features: AWmQ_bkji_Pd5cKd-kXBBrZWBCAODEuMQcqRcFYVEAnbDbWPDmXkcMOOMNSibL4
Message-ID: <CABPp-BGZZ_+EL_cQgNbmAP_WLiF9TYc2h14rzpLWc0MQNtKOhw@mail.gmail.com>
Subject: Re: [PATCH v6 08/11] add-patch: remove dependency on
 "add-interactive" subsystem
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:34=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> With the preceding commit we have split out interactive configuration
> that is used by both "git add -p" and "git add -i". But we still
> initialize that configuration in the "add -p" subsystem by calling
> `init_add_i_state()`, even though we only do so to initialize the
> interactive configuration as well as a repository pointer.
>
> Stop doing so and instead store and initialize the interactive
> configuration in `struct add_p_state` directly.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  add-patch.c | 70 ++++++++++++++++++++++++++++++++-----------------------=
------
>  1 file changed, 37 insertions(+), 33 deletions(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index 5c6969927a..790c848e79 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -2,7 +2,6 @@
>  #define DISABLE_SIGN_COMPARE_WARNINGS
>
>  #include "git-compat-util.h"
> -#include "add-interactive.h"
>  #include "add-patch.h"
>  #include "advice.h"
>  #include "config.h"
> @@ -263,7 +262,8 @@ struct hunk {
>  };
>
>  struct add_p_state {
> -       struct add_i_state s;
> +       struct repository *r;
> +       struct interactive_config cfg;
>         struct strbuf answer, buf;
>
>         /* parsed diff */
> @@ -408,7 +408,7 @@ static void add_p_state_clear(struct add_p_state *s)
>         for (i =3D 0; i < s->file_diff_nr; i++)
>                 free(s->file_diff[i].hunk);
>         free(s->file_diff);
> -       clear_add_i_state(&s->s);
> +       interactive_config_clear(&s->cfg);
>  }
>
>  __attribute__((format (printf, 2, 3)))
> @@ -417,9 +417,9 @@ static void err(struct add_p_state *s, const char *fm=
t, ...)
>         va_list args;
>
>         va_start(args, fmt);
> -       fputs(s->s.cfg.error_color, stdout);
> +       fputs(s->cfg.error_color, stdout);
>         vprintf(fmt, args);
> -       puts(s->s.cfg.reset_color_interactive);
> +       puts(s->cfg.reset_color_interactive);
>         va_end(args);
>  }
>
> @@ -437,7 +437,7 @@ static void setup_child_process(struct add_p_state *s=
,
>
>         cp->git_cmd =3D 1;
>         strvec_pushf(&cp->env,
> -                    INDEX_ENVIRONMENT "=3D%s", s->s.r->index_file);
> +                    INDEX_ENVIRONMENT "=3D%s", s->r->index_file);
>  }
>
>  static int parse_range(const char **p,
> @@ -542,12 +542,12 @@ static int parse_diff(struct add_p_state *s, const =
struct pathspec *ps)
>         int res;
>
>         strvec_pushv(&args, s->mode->diff_cmd);
> -       if (s->s.cfg.context !=3D -1)
> -               strvec_pushf(&args, "--unified=3D%i", s->s.cfg.context);
> -       if (s->s.cfg.interhunkcontext !=3D -1)
> -               strvec_pushf(&args, "--inter-hunk-context=3D%i", s->s.cfg=
.interhunkcontext);
> -       if (s->s.cfg.interactive_diff_algorithm)
> -               strvec_pushf(&args, "--diff-algorithm=3D%s", s->s.cfg.int=
eractive_diff_algorithm);
> +       if (s->cfg.context !=3D -1)
> +               strvec_pushf(&args, "--unified=3D%i", s->cfg.context);
> +       if (s->cfg.interhunkcontext !=3D -1)
> +               strvec_pushf(&args, "--inter-hunk-context=3D%i", s->cfg.i=
nterhunkcontext);
> +       if (s->cfg.interactive_diff_algorithm)
> +               strvec_pushf(&args, "--diff-algorithm=3D%s", s->cfg.inter=
active_diff_algorithm);
>         if (s->revision) {
>                 struct object_id oid;
>                 strvec_push(&args,
> @@ -576,9 +576,9 @@ static int parse_diff(struct add_p_state *s, const st=
ruct pathspec *ps)
>         }
>         strbuf_complete_line(plain);
>
> -       if (want_color_fd(1, s->s.cfg.use_color_diff)) {
> +       if (want_color_fd(1, s->cfg.use_color_diff)) {
>                 struct child_process colored_cp =3D CHILD_PROCESS_INIT;
> -               const char *diff_filter =3D s->s.cfg.interactive_diff_fil=
ter;
> +               const char *diff_filter =3D s->cfg.interactive_diff_filte=
r;
>
>                 setup_child_process(s, &colored_cp, NULL);
>                 xsnprintf((char *)args.v[color_arg_index], 8, "--color");
> @@ -811,7 +811,7 @@ static void render_hunk(struct add_p_state *s, struct=
 hunk *hunk,
>                                    hunk->colored_end - hunk->colored_star=
t);
>                         return;
>                 } else {
> -                       strbuf_addstr(out, s->s.cfg.fraginfo_color);
> +                       strbuf_addstr(out, s->cfg.fraginfo_color);
>                         p =3D s->colored.buf + header->colored_extra_star=
t;
>                         len =3D header->colored_extra_end
>                                 - header->colored_extra_start;
> @@ -833,7 +833,7 @@ static void render_hunk(struct add_p_state *s, struct=
 hunk *hunk,
>                 if (len)
>                         strbuf_add(out, p, len);
>                 else if (colored)
> -                       strbuf_addf(out, "%s\n", s->s.cfg.reset_color_dif=
f);
> +                       strbuf_addf(out, "%s\n", s->cfg.reset_color_diff)=
;
>                 else
>                         strbuf_addch(out, '\n');
>         }
> @@ -1222,12 +1222,12 @@ static void recolor_hunk(struct add_p_state *s, s=
truct hunk *hunk)
>
>                 strbuf_addstr(&s->colored,
>                               plain[current] =3D=3D '-' ?
> -                             s->s.cfg.file_old_color :
> +                             s->cfg.file_old_color :
>                               plain[current] =3D=3D '+' ?
> -                             s->s.cfg.file_new_color :
> -                             s->s.cfg.context_color);
> +                             s->cfg.file_new_color :
> +                             s->cfg.context_color);
>                 strbuf_add(&s->colored, plain + current, eol - current);
> -               strbuf_addstr(&s->colored, s->s.cfg.reset_color_diff);
> +               strbuf_addstr(&s->colored, s->cfg.reset_color_diff);
>                 if (next > eol)
>                         strbuf_add(&s->colored, plain + eol, next - eol);
>                 current =3D next;
> @@ -1356,7 +1356,7 @@ static int run_apply_check(struct add_p_state *s,
>
>  static int read_single_character(struct add_p_state *s)
>  {
> -       if (s->s.cfg.use_single_key) {
> +       if (s->cfg.use_single_key) {
>                 int res =3D read_key_without_echo(&s->answer);
>                 printf("%s\n", res =3D=3D EOF ? "" : s->answer.buf);
>                 return res;
> @@ -1370,7 +1370,7 @@ static int read_single_character(struct add_p_state=
 *s)
>  static int prompt_yesno(struct add_p_state *s, const char *prompt)
>  {
>         for (;;) {
> -               color_fprintf(stdout, s->s.cfg.prompt_color, "%s", _(prom=
pt));
> +               color_fprintf(stdout, s->cfg.prompt_color, "%s", _(prompt=
));
>                 fflush(stdout);
>                 if (read_single_character(s) =3D=3D EOF)
>                         return -1;
> @@ -1678,15 +1678,15 @@ static int patch_update_file(struct add_p_state *=
s,
>                 else
>                         prompt_mode_type =3D PROMPT_HUNK;
>
> -               printf("%s(%"PRIuMAX"/%"PRIuMAX") ", s->s.cfg.prompt_colo=
r,
> +               printf("%s(%"PRIuMAX"/%"PRIuMAX") ", s->cfg.prompt_color,
>                               (uintmax_t)hunk_index + 1,
>                               (uintmax_t)(file_diff->hunk_nr
>                                                 ? file_diff->hunk_nr
>                                                 : 1));
>                 printf(_(s->mode->prompt_mode[prompt_mode_type]),
>                        s->buf.buf);
> -               if (*s->s.cfg.reset_color_interactive)
> -                       fputs(s->s.cfg.reset_color_interactive, stdout);
> +               if (*s->cfg.reset_color_interactive)
> +                       fputs(s->cfg.reset_color_interactive, stdout);
>                 fflush(stdout);
>                 if (read_single_character(s) =3D=3D EOF)
>                         break;
> @@ -1848,7 +1848,7 @@ static int patch_update_file(struct add_p_state *s,
>                                 err(s, _("Sorry, cannot split this hunk")=
);
>                         } else if (!split_hunk(s, file_diff,
>                                              hunk - file_diff->hunk)) {
> -                               color_fprintf_ln(stdout, s->s.cfg.header_=
color,
> +                               color_fprintf_ln(stdout, s->cfg.header_co=
lor,
>                                                  _("Split into %d hunks."=
),
>                                                  (int)splittable_into);
>                                 rendered_hunk_index =3D -1;
> @@ -1866,7 +1866,7 @@ static int patch_update_file(struct add_p_state *s,
>                 } else if (s->answer.buf[0] =3D=3D '?') {
>                         const char *p =3D _(help_patch_remainder), *eol =
=3D p;
>
> -                       color_fprintf(stdout, s->s.cfg.help_color, "%s",
> +                       color_fprintf(stdout, s->cfg.help_color, "%s",
>                                       _(s->mode->help_patch_text));
>
>                         /*
> @@ -1884,7 +1884,7 @@ static int patch_update_file(struct add_p_state *s,
>                                 if (*p !=3D '?' && !strchr(s->buf.buf, *p=
))
>                                         continue;
>
> -                               color_fprintf_ln(stdout, s->s.cfg.help_co=
lor,
> +                               color_fprintf_ln(stdout, s->cfg.help_colo=
r,
>                                                  "%.*s", (int)(eol - p), =
p);
>                         }
>                 } else {
> @@ -1904,7 +1904,7 @@ static int patch_update_file(struct add_p_state *s,
>                 strbuf_reset(&s->buf);
>                 reassemble_patch(s, file_diff, 0, &s->buf);
>
> -               discard_index(s->s.r->index);
> +               discard_index(s->r->index);
>                 if (s->mode->apply_for_checkout)
>                         apply_for_checkout(s, &s->buf,
>                                            s->mode->is_reverse);
> @@ -1915,8 +1915,8 @@ static int patch_update_file(struct add_p_state *s,
>                                          NULL, 0, NULL, 0))
>                                 error(_("'git apply' failed"));
>                 }
> -               if (repo_read_index(s->s.r) >=3D 0)
> -                       repo_refresh_and_write_index(s->s.r, REFRESH_QUIE=
T, 0,
> +               if (repo_read_index(s->r) >=3D 0)
> +                       repo_refresh_and_write_index(s->r, REFRESH_QUIET,=
 0,
>                                                      1, NULL, NULL, NULL)=
;
>         }
>
> @@ -1929,11 +1929,15 @@ int run_add_p(struct repository *r, enum add_p_mo=
de mode,
>               const struct pathspec *ps)
>  {
>         struct add_p_state s =3D {
> -               { r }, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
> +               .r =3D r,
> +               .answer =3D STRBUF_INIT,
> +               .buf =3D STRBUF_INIT,
> +               .plain =3D STRBUF_INIT,
> +               .colored =3D STRBUF_INIT,
>         };
>         size_t i, binary_count =3D 0;
>
> -       init_add_i_state(&s.s, r, opts);
> +       interactive_config_init(&s.cfg, r, opts);
>
>         if (mode =3D=3D ADD_P_STASH)
>                 s.mode =3D &patch_mode_stash;
>
> --
> 2.51.1.930.gacf6e81ea2.dirty

Viewing the patch under --color-words=3D. makes it clear that in most
places in the patch you were just removing "s." for accessing fields.
Just the beginning and end of the patch are better viewed without that
field.  Anyway, all looks reasonable to me.
