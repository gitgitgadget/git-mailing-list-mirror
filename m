Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC5CEEC0
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760126265; cv=none; b=gH+EqZQeTdopIRA+/L5lGyvPH/1oyJOcEkTa/YIjqgSLKFambDjPx/0uR64hVY4pmuyEmIkrkrDVoCrprWkmhXDjhdukrpQGRU5E+Kb+9FSOkyg1IsFSZvaIPu97YdzqdBW3H6yTF+i3y0r7kL2Jj8iyi7hsHCL8LDJT6IwGJ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760126265; c=relaxed/simple;
	bh=cycRgdQ0R5Qv7LXTsyKtHgrV4hM4uzkK0wXZbKhNYSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lf+xbWcyD16bbGcVBu7Lp7ZJjZKoxNhDycDmYoy6adjOmIjCDNrRdxtyugDDma55gKygz4BxmT7k9l8Ja2020PK3i5AOtH66MpVEZ2wNo50Vou2jGUpowoJp6/rHxa5kGPk5cApUPXxo1g/gqCe97JvBewyHpz6LPwTMQexFsas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h93LC0I0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h93LC0I0"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27eeafd4882so49255ad.0
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 12:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760126263; x=1760731063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqcHCtDfqEB7tonyuoU6FpjkhGwolK4mU1mF+DGSXhY=;
        b=h93LC0I03bPlBibEhcTRX59WbF9Hz5fNMLoonvAwnIIceHWAoynToz8SNLjP6SgEw+
         YEyQdUOFYJFBJJmKqI5WRryH3WVtnsrVV0vcv4QcDEjKCegRB/4RDlVg0SSgobqWNAhc
         MGyUztCbQNk+X4Zd+Udum6p+L0Q6GoHWqu0UBRtgK7JUVRVPvHfTf+87sGCT7wYWZSzx
         9gaKkR6MDmB2UHd9JPK/AOxldUqya7RMapX3RESiob8letRtsdFcf/uo5rKiX+9wkIIv
         99RML+xpljAYKswCzh3e4ugBYrPY4c7/LaijF06+Jft0t4cmaKzAeYMLtoxp24MnI0NT
         oEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760126263; x=1760731063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqcHCtDfqEB7tonyuoU6FpjkhGwolK4mU1mF+DGSXhY=;
        b=lh0ei+FQ2o9OY01tXUdpNEYA0DVJMpOl84NlLXAnC630Shq88VB4fPz61nGPoHPtK7
         4kkS9li9esJt8P/x6Vz4cQPcQAL9NISNYGjmjGgjHIsFuuxGY7bBSx93CbwXZYTyr8UU
         A9ob5MSvlqnAcW30C27KIg1DfjFf5DVaYCba8//1TfAkK2iSV3wV4+kMr9Gdw84UuLfX
         DhL9Hm+XEJCYg9lh0BgGHRKQGxI+vqQtZV7biuQYP00gHefXKwfq1jPY60IviJZymbNv
         TyMahVAxdEr3RaZF02VDt1SESjqx/LdTxh3mluzUpt7aempvwlgj+3pTHAWJr3Ucll0W
         GeUQ==
X-Gm-Message-State: AOJu0Yw5UvK5vHkQd/Gvv/Ax2XtY7o1OQMeM4XO2lnUcf8yutjhqrsCe
	tmYIwKPePBFvRtZycLKUasKRAQp5/2OII+rHkVkaiZr5yNJNN3ekmxAWY2ExMH0tHWkAx4c+ZvU
	uaPZzOyhz8NeqwU2pGim62OUbtEHK686mwh0F5nEK
X-Gm-Gg: ASbGncvRagJQjwFgWMK7q6LlTDgaPnS7vlKtaqAsxhpwwmIaYxUrBZW13rbboX4/IM/
	xHH6DEioRiVWpfBiNAQvehaPA7uw0K0KMen4rc5cq9Gma5DVlG9kHE4dgs6lZYNsO3xuFZJXrYd
	OR2SQ+hQxCBXKEcDjFxwqPL6tCNizRIYWBYmMBYvv1E8salvBlPo+bts/lV3w1fciJM0iaM5Mn6
	ZO/PgRtvZBsecm8kSb3Vf3UWIFhtz54PECzria5WrGbThHU1KLgpshTogwCi0B1uTQ9Aa3pug==
X-Google-Smtp-Source: AGHT+IHy0CdKBJSR+frqFEU7uhUCMSBbt55toEO/ublkxs0iM5us6QZrZGaq7NtYM750Pk/ogB66x+TX1eChnI0wkR0=
X-Received: by 2002:a17:902:f687:b0:268:cc5:5e3c with SMTP id
 d9443c01a7336-29027698f62mr20437055ad.10.1760126262504; Fri, 10 Oct 2025
 12:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com> <20250925125352.1728840-3-adrian.ratiu@collabora.com>
In-Reply-To: <20250925125352.1728840-3-adrian.ratiu@collabora.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Fri, 10 Oct 2025 12:57:13 -0700
X-Gm-Features: AS18NWC8rX_zQrY1L3kRX6lCRtWcw8fcruWPsW6JML3zwE9Vu6ExRNOziVdm378
Message-ID: <CAJoAoZm6uNtEoo_tdbqjGMSj4OnQuFesxt_iyOTgNHA1LX3iwQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] hook: provide stdin via callback
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Rodrigo Damazio Bovendorp <rdamazio@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 5:54=E2=80=AFAM Adrian Ratiu <adrian.ratiu@collabor=
a.com> wrote:
>
> From: Emily Shaffer <emilyshaffer@google.com>
>
> This adds a callback mechanism for feeding stdin to hooks alongside
> the existing path_to_stdin (which slurps a file's content to stdin).
>
> The advantage of this new callback is that it can feed stdin without
> going through the FS layer. This helps when feeding large amount of
> data and uses the run-command parallel stdin callback introduced in
> the preceding commit.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  hook.c |  8 ++++++++
>  hook.h | 22 ++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/hook.c b/hook.c
> index b3de1048bf..54568d5bc0 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -69,6 +69,10 @@ static int pick_next_hook(struct child_process *cp,
>         if (hook_cb->options->path_to_stdin) {
>                 cp->no_stdin =3D 0;
>                 cp->in =3D xopen(hook_cb->options->path_to_stdin, O_RDONL=
Y);
> +       } else if (hook_cb->options->feed_pipe) {
> +               cp->no_stdin =3D 0;
> +               /* start_command() will allocate a pipe / stdin fd for us=
 */
> +               cp->in =3D -1;
>         }
>         cp->stdout_to_stderr =3D 1;
>         cp->trace2_hook_name =3D hook_cb->hook_name;
> @@ -140,6 +144,7 @@ int run_hooks_opt(struct repository *r, const char *h=
ook_name,
>
>                 .get_next_task =3D pick_next_hook,
>                 .start_failure =3D notify_start_failure,
> +               .feed_pipe =3D options->feed_pipe,
>                 .task_finished =3D notify_hook_finished,
>
>                 .data =3D &cb_data,
> @@ -148,6 +153,9 @@ int run_hooks_opt(struct repository *r, const char *h=
ook_name,
>         if (!options)
>                 BUG("a struct run_hooks_opt must be provided to run_hooks=
");
>
> +       if (options->path_to_stdin && options->feed_pipe)
> +               BUG("choose only one method to populate hook stdin");
> +
>         if (options->invoked_hook)
>                 *options->invoked_hook =3D 0;
>
> diff --git a/hook.h b/hook.h
> index 11863fa734..8fdbc8c673 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -1,6 +1,7 @@
>  #ifndef HOOK_H
>  #define HOOK_H
>  #include "strvec.h"
> +#include "run-command.h"
>
>  struct repository;
>
> @@ -37,6 +38,24 @@ struct run_hooks_opt
>          * Path to file which should be piped to stdin for each hook.
>          */
>         const char *path_to_stdin;
> +
> +       /**
> +        * Callback to ask for more content to pipe to each hook stdin.
> +        *
> +        * If a hook needs to consume large quantities of data (e.g. a li=
st of all refs received in a
> +        * client push), feeding data via in-memory strings or slurping t=
o/from files via path_to_stdin
> +        * will not be efficient, so this callback allows for piecemeal r=
eading and writing.
> +        *
> +        * Add initalization context to hook.feed_pipe_ctx.
> +        */
> +       feed_pipe_fn feed_pipe;
> +       void *feed_pipe_ctx;
> +
> +       /**
> +        * Use this to keep internal state for your feed_pipe_fn callback=
.
> +        * Only useful if you are using run_hooks_opt.feed_pipe. Otherwis=
e, ignore it.
> +        */
> +       void *feed_pipe_cb_data;
>  };
>
>  #define RUN_HOOKS_OPT_INIT { \
> @@ -44,6 +63,9 @@ struct run_hooks_opt
>         .args =3D STRVEC_INIT, \
>  }
>
> +/**
> + * Callback data provided to feed_pipe_fn.
> + */

It looks like this comment was maybe a note to yourself? (Or a note to
myself, eons ago?) But hook_cb_data is used in all the parallel hook
callbacks, not just feed_pipe_fn, so I don't think this is accurate.


>  struct hook_cb_data {
>         /* rc reflects the cumulative failure state */
>         int rc;
> --
> 2.49.1
>
