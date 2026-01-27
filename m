Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16129156CA
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 00:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769472789; cv=pass; b=It2EQepkeuUU8kWLQDo7A+KcF9soK+t0sI/dF9rnEJIwb3uV4Dtd/vgUANVJiEstWkNk3zeOseBpPW8BauFiDc04ghYXJRgUGZxuxXraTjYKQymEeOtlKttXw+SgmF8UzyFhV/kKpR4MkhToR7HgROjlWPKfK3V+wstZygxPhOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769472789; c=relaxed/simple;
	bh=iL6DF8tKaZ/Z+Xnmx+WUwTpCkdddLNmLXqWYHq/Wiq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AkePu3ojhxdJtAEj/UZ+2vI/1eU+eoiG8DXezIVx5dQi1caDogIDDq5iGeTfojg+sUtpO4gXngW3TcMCKF3fUK400yXNIHKZ7T0XbxJDPFoLXYh8EskdYX3QFkgyIwXrCgocSGqMRa2zyC7Ll03H8lfsmLpHFrj/39Lcp/J2nNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JysRzCYM; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JysRzCYM"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5014b5d8551so128211cf.0
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 16:13:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769472787; cv=none;
        d=google.com; s=arc-20240605;
        b=V4SGgfxo5vnh4eq75VD70xaAf/2EqzzNVVcFxhIePPTxF46qZ1gDKYrzd93QDIZxOj
         mhhQvb47TTpJrE3EQrTjeWhir+Is+NrgEAg0gK5w7twcQ40v+1j6ehoX3rU10yi86q7P
         oED8RRayGTBqJV03r9Hfuoz4nW8gBpkA1UHZkG6yaxs+qhVUTXcivhrpgl/5UXiGTKeb
         hCjyrDlC1WIjJWCjvTSSa9Ocp34dhJNA9h2lyPfJ36CS7wDK0a1adxVMFFuQjY3VYKjv
         khwtC+Ocm0t1ix+1q4tpd5VUbVXtOWKCuNCtMLiTy8lWVGPfYyG9LlyD322+122Awr6l
         cIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qSNszUIisXbBoTlwU8ESiTEYz/GmDIN5BXxfn+40dkI=;
        fh=FBxxF6uhvMUUOMt3FNKZH+UKkt0riSceQMbVqlyuMfo=;
        b=A9stnSlZHssBXqIZFDJqCIRC6wspoH8SCwR0+wc1yVskBI8yy5TkUH3v6fweFY4ZH3
         LdKHZjC+vHG4+VCG90TN5hy5LqW1+LbBTcCG8UinbBo/P7xApnFJGsHIXo83Jl912X11
         FcyNzQU6H+a16gINZ2GfdlZwEUhbh0jW0Lfa/05/R64NpTYTjzs3g3wiU2BgTxApYM5Y
         DOjhBTVS6lww7E1eUwf/BTnrIMJKsuYIiypB1L5Q0h6Sjs93RI1He9cYpjRL7Knp1u9l
         jgr+tZ7k5bk1W4NYeM6/o58czvZW8HPlDjG7AK9Am5b8RipCVl9zCUpdWHev21dNZtwW
         FlsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769472787; x=1770077587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSNszUIisXbBoTlwU8ESiTEYz/GmDIN5BXxfn+40dkI=;
        b=JysRzCYM6v2Y5vprS1zmlxJKFBI8GIcYXPhDHCu8CBmuY6NwDasBzgrUrql3XCwFSv
         dMlfx705IPHeeq8NrDXgEo54Qvfik4tYl6thtXuRkJNb4llvunwWDYN10ZBM5Xckc6WV
         +YPUhHGcCvbzW7SRX0iUKFkauNJoq4aAoka8xam5KRhK9jE/EzZwaVezY9JxQqR1kCaD
         QIeCPQYkfDx7H924D70c0Xlv14zk5ejOEKz0SGFZF+YWiqqk8SXwOR1yi/R/6k9YbGEb
         9vd7DNoBnLdPcPaJOJro5Zr2yrOGwOi2gHnHlLFCflJV0FSY4BkjYPYdCjE+rfdrKAtV
         wfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769472787; x=1770077587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qSNszUIisXbBoTlwU8ESiTEYz/GmDIN5BXxfn+40dkI=;
        b=VnXjQpoGAaNbS8kdqUeTgAPAprpJOgynKxs6Bt3DMEpEBE2Z+/iWQQegWInKprIvJT
         d5VemXNnOLRdonzFAb9T9gTiB0h6qolgauOqLbEp4pn7OtxNtnqp0FHjLY6ctnI2Xlhr
         9kYIiGTfR/akmoB7lMTdFQW/Ft2H86ZtLLIwg4MYSNt2Y1fXNAfNYhsTsp27ea3ogDeh
         6KQRAcfzDQt8sbho8hAZRW6GHDFvHK0GV8uwgExbPI6d80PBKEdEIiQbaS/w/eXkMXCS
         eJQhc+0HbLI5QUapZX8oGwT50q4mZiDSba255UT601BxeBfFJO/ipOpnGqrivRwcTu5E
         YJ0A==
X-Gm-Message-State: AOJu0Yxe+KyQMvea6Foxv0fxG7qKgX8HTYG+3e8Mb50mnfvzDJYzVLY/
	mcXkfAWxucqLEAqmYj0R7MnBWSxPY95yWGoCOtlKJlYE92nf8T1JX6yqZXUAR4Ft/DHWfp+2gIN
	r1GcChKoD3onk/THJm7HFXNxbF3u6EqeWSK1H4Fa2
X-Gm-Gg: AZuq6aKUgd2KQ0pAjpfo0d8LkzU2n2MxNgAJCEk0Y67o9FQv4Qkz+yhMK+iMVOL6LBi
	NauvhbCS1/4IOxbq3XGPaUW3t6U/aYXf1ZqfC4bpZDFHx5hgoBbdfEIxhBaqUkpZVjiDj2LxghX
	ZFevkXWexjPDq0BQq0QtQrkBFuVgyzQFn3tWrs1QJotuc2t4o2P7SHesEpNwli/YF0uSeJj9KpB
	kajW9WrQQWbAfUg6NaWJ5ajj4rjRfTP90jmVWeBwUj/A9G6arXoKpTrDeyFHEWQqyV+gyBSZS7Q
	2ZS5Gs5UZ4gF3C9L+079LZ+XPrAITw==
X-Received: by 2002:ac8:7f43:0:b0:4f3:7b37:81b with SMTP id
 d75a77b69052e-5032a5344b0mr5570861cf.18.1769472786675; Mon, 26 Jan 2026
 16:13:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com> <20260121215436.1473800-12-adrian.ratiu@collabora.com>
In-Reply-To: <20260121215436.1473800-12-adrian.ratiu@collabora.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Mon, 26 Jan 2026 16:12:55 -0800
X-Gm-Features: AZwV_QiMaaTS3pfirCLHgcMdprH-TjAg_MSVMr_APLY8Ig-cfam_eQ0qItpfbtw
Message-ID: <CAJoAoZkBRr+CF9VHMaq15eS6o8Vgux1q88an5L6-eDLrP2AgAA@mail.gmail.com>
Subject: Re: [PATCH v7 11/12] receive-pack: convert update hooks to new API
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 1:55=E2=80=AFPM Adrian Ratiu <adrian.ratiu@collabor=
a.com> wrote:
>
> The hook API avoids creating a custom struct child_process and other
> internal hook plumbing (e.g. calling find_hook()) and prepares for
> the specification of hooks via configs or running parallel hooks.
>
> Execution is still sequential through the run_hooks_opt .jobs =3D=3D 1,
> which is the unchanged default for all hooks.
>
> When jobs=3D=3D1 the async muxer thread reads the hook stderr and writes
> to sideband 2, so run-command's poll loop is avoided and there's no
> need for ungroup=3D0 when running sequentially (Jeff's suggestion).
>
> When running in parallel, run-command with ungroup=3D0 will capture
> and de-interleave the output of each hook, then write to the parent
> stderr which is redirected via dup2 to the sideband muxer, so that
> parallel hook output is presented clearly to the client.
>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  builtin/receive-pack.c | 91 +++++++++++++++++++++++++-----------------
>  1 file changed, 55 insertions(+), 36 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 9c49174616..bcd019786e 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -941,29 +941,41 @@ static int run_receive_hook(struct command *command=
s,
>
>  static int run_update_hook(struct command *cmd)
>  {
> -       struct child_process proc =3D CHILD_PROCESS_INIT;
> +       struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
> +       struct async muxer;
>         int code;
> -       const char *hook_path =3D find_hook(the_repository, "update");
> +       int saved_stderr =3D -1;
> +       int muxer_started =3D 0;
>
> -       if (!hook_path)
> -               return 0;
> +       strvec_pushl(&opt.args,
> +                    cmd->ref_name,
> +                    oid_to_hex(&cmd->old_oid),
> +                    oid_to_hex(&cmd->new_oid),
> +                    NULL);
>
> -       strvec_push(&proc.args, hook_path);
> -       strvec_push(&proc.args, cmd->ref_name);
> -       strvec_push(&proc.args, oid_to_hex(&cmd->old_oid));
> -       strvec_push(&proc.args, oid_to_hex(&cmd->new_oid));
> +       if (use_sideband) {
> +               memset(&muxer, 0, sizeof(muxer));
> +               muxer.proc =3D copy_to_sideband;
> +               muxer.in =3D -1;
> +               if (!start_async(&muxer)) {
> +                       muxer_started =3D 1;
> +                       saved_stderr =3D dup(STDERR_FILENO);
> +                       if (saved_stderr >=3D 0)
> +                               dup2(muxer.in, STDERR_FILENO);
> +                       close(muxer.in);
> +               }
> +       }
>
> -       proc.no_stdin =3D 1;
> -       proc.stdout_to_stderr =3D 1;
> -       proc.err =3D use_sideband ? -1 : 0;
> -       proc.trace2_hook_name =3D "update";
> +       code =3D run_hooks_opt(the_repository, "update", &opt);
>
> -       code =3D start_command(&proc);
> -       if (code)
> -               return code;
> -       if (use_sideband)
> -               copy_to_sideband(proc.err, -1, NULL);
> -       return finish_command(&proc);
> +       if (saved_stderr >=3D 0) {
> +               dup2(saved_stderr, STDERR_FILENO);
> +               close(saved_stderr);
> +       }
> +       if (muxer_started)
> +               finish_async(&muxer);
> +
> +       return code;
>  }
>
>  static struct command *find_command_by_refname(struct command *list,
> @@ -1639,34 +1651,41 @@ static const char *update(struct command *cmd, st=
ruct shallow_info *si)
>
>  static void run_update_post_hook(struct command *commands)
>  {
> +       struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
> +       struct async muxer;
>         struct command *cmd;
> -       struct child_process proc =3D CHILD_PROCESS_INIT;
> -       const char *hook;
> -
> -       hook =3D find_hook(the_repository, "post-update");
> -       if (!hook)
> -               return;
> +       int saved_stderr =3D -1;
> +       int muxer_started =3D 0;
>
>         for (cmd =3D commands; cmd; cmd =3D cmd->next) {
>                 if (cmd->error_string || cmd->did_not_exist)
>                         continue;
> -               if (!proc.args.nr)
> -                       strvec_push(&proc.args, hook);
> -               strvec_push(&proc.args, cmd->ref_name);
> +               strvec_push(&opt.args, cmd->ref_name);
>         }
> -       if (!proc.args.nr)
> +       if (!opt.args.nr)
>                 return;
>
> -       proc.no_stdin =3D 1;
> -       proc.stdout_to_stderr =3D 1;
> -       proc.err =3D use_sideband ? -1 : 0;
> -       proc.trace2_hook_name =3D "post-update";
> +       if (use_sideband) {
> +               memset(&muxer, 0, sizeof(muxer));
> +               muxer.proc =3D copy_to_sideband;
> +               muxer.in =3D -1;
> +               if (!start_async(&muxer)) {
> +                       muxer_started =3D 1;
> +                       saved_stderr =3D dup(STDERR_FILENO);
> +                       if (saved_stderr >=3D 0)
> +                               dup2(muxer.in, STDERR_FILENO);
> +                       close(muxer.in);
> +               }
> +       }
>
> -       if (!start_command(&proc)) {
> -               if (use_sideband)
> -                       copy_to_sideband(proc.err, -1, NULL);
> -               finish_command(&proc);
> +       run_hooks_opt(the_repository, "post-update", &opt);
> +
> +       if (saved_stderr >=3D 0) {
> +               dup2(saved_stderr, STDERR_FILENO);
> +               close(saved_stderr);
>         }
> +       if (muxer_started)
> +               finish_async(&muxer);

I guess I'm confused about how the muxer is working here. I guess I
would expect an async to get created for each child, then to dump the
entire output of the child when that child terminates, but it seems
like you're setting up the async to capture the output of all the
hooks (that is, it seems like start_async() and finish_async()
encapsulate run_hooks_opt(), which runs multiple children...?)

>  }
>
>  static void check_aliased_update_internal(struct command *cmd,
> --
> 2.52.0.732.gb351b5166d.dirty
>
