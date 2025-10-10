Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC011EEC0
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760126253; cv=none; b=bLcLN0hge5wtWEquYBlAP2RvK6UZPfocnQdC3IPqhih1x7hpVnf5QIGkvC5fCt2EPK5I90H/FcqNwtlkrBgmxnKHcE4awf2r19mSiY4mVjYzXtEjEzAYsKnrIolln41UdtCxZ7yo+wxxlbkBKFwDPVlo4r3sEcfbNVTYPYCtDhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760126253; c=relaxed/simple;
	bh=BcYHTuOzEpLN0bPXf7yHzycco690FtOfWp8qpChTz9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIyeK7mRRXdNa0pV++wmVznceiV5A9CyLBSXIOiRE47Q5bS7Y15oOV4V/wQL7ve7rKnLhlBFy2qjEE8e06iBcVLaL+R45TY2jQf4W2kev0UtRzveRc/lFixkCE2ol7rXNtj8pMLMEYnnA9++ifUhUt/YHgQeTcNzOL/FPXpzBG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kkOjTNCL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kkOjTNCL"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27eeafd4882so49195ad.0
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760126251; x=1760731051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gI/5KdUi6dV9X2m69qWeI7AurmXqa1JxFh4E3Isk1m0=;
        b=kkOjTNCLNDP0lSUs5H9Ko9HyT22khIv4HK8W4SAqdW4MT8lcV6L92Y+vVa2VMi4mKs
         33Iw7nkddO7MlI1gKMbR4/neRb82LfOhkulqQZOUZfc91vKYu0rLRNsNCGW6U9hVC/mZ
         eqxHo515Cqz+SS8teqsPxMY2yNCRfYYp9I+o/XFeu322gqLOWMmNwtMiZOmamRMMky60
         ru+84sXWXZyp6MRxUgN9k0ff8m3zrta56fTFS3BPG/NIX37br9tav5bF2QCWDafIl1Ca
         dK4rshrtZo8PhxqVI+IIN4jQKGcayinvfRb0o4n70q20G1qAeLRYkNdLTroGZhQZIYXi
         B+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760126251; x=1760731051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gI/5KdUi6dV9X2m69qWeI7AurmXqa1JxFh4E3Isk1m0=;
        b=tZeGP4qke0V+29Yj3DcHI5kp/F3IUEEE6Tq3H55QMX6LuwGJXViRho0Q9f+dzoH+Z1
         VqLJzR1PtfNODw4mzxVTkjdd/UPKQAIQKHP10sM0dyTtUhdgxKKMWpUYLm7QIbr1R0Ii
         faHIhKqUrsTx3aEqd7k4kafA782THkmY4ZxjVeCjtIBLmsZzgmNaj+VF4rnD0m8CtKCC
         hSIfs9+mluTFTSeEA+HzHiYpScpBmhVUaD1+KIvfzP2ldCA2nUBl5i2gNrpQFzx4qfbG
         LMEs0+7MTrYC5iaduTb2D5HO7fwxi/SnQNM98FTpc1OF49e+pP77k/FqRJxJjRkK/X6r
         82hg==
X-Gm-Message-State: AOJu0Yz0fILNazlvSsaAlwNhwPiKmcSUR6YnekvZ6y3drfeyJs/IZz8S
	O/3PHVnUq4YILGwybOZ6XYE6uF79CMU/dySvx/AcYAorMkocjHh0c7jcDJ7OY67kACZznlPMZ8l
	W65hLFA04lyUE9ZDSNRVSdYY4Krp9/kL3M8bohjVf
X-Gm-Gg: ASbGnctGDCim1RVoC22pV6bsMlZ88jLVz+l+LovAToZZAM1lEdXMf8ldVQ3L7h7nO+5
	5VnAcChXDiWp3hgNtYD3TnA1wYPBh5ig5uaqMgXz3PyNmcPlbZ+2wfnww6AsNGCJ+9kqYzlEdFb
	MZRW+zeLxxFVsFYXUu0w3dOVHkzSONYi2bZougyZstj1CkawLMzfYjipdcfe66ktH3lDn/J+gIG
	w1i8q7czv1PJTKLz6+UlH3V5A9fguLRmUQh3n6Vz7gOYtnXJvjLgHSXUFbRYJA=
X-Google-Smtp-Source: AGHT+IE9pnmer53qBm5e7uI8Ro+IKue+K0zVinqina5e7U2lEjE1yB58HqZrQZrCm8/KPEY4BHniB8MEPjJ4TByr2bg=
X-Received: by 2002:a17:903:904:b0:24b:1741:1a4c with SMTP id
 d9443c01a7336-290274dd515mr21687115ad.0.1760126250403; Fri, 10 Oct 2025
 12:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com> <20250925125352.1728840-9-adrian.ratiu@collabora.com>
In-Reply-To: <20250925125352.1728840-9-adrian.ratiu@collabora.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Fri, 10 Oct 2025 12:57:17 -0700
X-Gm-Features: AS18NWCP6dDEVUwQJAsq28_5CN7nPZMSzTrQl_sK_fDR8DK45-HHr_dMxvcXHVs
Message-ID: <CAJoAoZ=HRKjjU-N6y+kHo6vpOY6jN4Q7nDdDRpT=cv0k0PtxGg@mail.gmail.com>
Subject: Re: [PATCH 08/10] receive-pack: convert 'update' hook to hook.h
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
> This makes use of the new sideband API in hook.h added in the
> preceding commit.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/receive-pack.c | 60 +++++++++++++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 19 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 1113137a6f..d5192ce132 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -939,31 +939,53 @@ static int run_receive_hook(struct command *command=
s,
>         return status;
>  }
>
> -static int run_update_hook(struct command *cmd)
> +static void hook_output_to_sideband(struct strbuf *output, void *cb_data=
 UNUSED)
>  {
> -       struct child_process proc =3D CHILD_PROCESS_INIT;
> -       int code;
> -       const char *hook_path =3D find_hook(the_repository, "update");
> +       int keepalive_active =3D 0;
>
> -       if (!hook_path)
> -               return 0;
> +       if (keepalive_in_sec <=3D 0)
> +               use_keepalive =3D KEEPALIVE_NEVER;
> +       if (use_keepalive =3D=3D KEEPALIVE_ALWAYS)
> +               keepalive_active =3D 1;

This hook wasn't using the keepalive at all before, right? What's the
reason to use it now? I am worried it might be going to a sideband
consumer who wasn't expecting it because it's not documented in
githooks.


>
> -       strvec_push(&proc.args, hook_path);
> -       strvec_push(&proc.args, cmd->ref_name);
> -       strvec_push(&proc.args, oid_to_hex(&cmd->old_oid));
> -       strvec_push(&proc.args, oid_to_hex(&cmd->new_oid));
> +       /* send a keepalive if there is no data to write */
> +       if (keepalive_active && !output->len) {
> +               static const char buf[] =3D "0005\1";
> +               write_or_die(1, buf, sizeof(buf) - 1);
> +               return;
> +       }
>
> -       proc.no_stdin =3D 1;
> -       proc.stdout_to_stderr =3D 1;
> -       proc.err =3D use_sideband ? -1 : 0;
> -       proc.trace2_hook_name =3D "update";
> +       if (use_keepalive =3D=3D KEEPALIVE_AFTER_NUL && !keepalive_active=
) {
> +               const char *first_null =3D memchr(output->buf, '\0', outp=
ut->len);
> +               if (first_null) {
> +                       /* The null bit is excluded. */
> +                       size_t before_null =3D first_null - output->buf;
> +                       size_t after_null =3D output->len - (before_null =
+ 1);
> +                       keepalive_active =3D 1;
> +                       send_sideband(1, 2, output->buf, before_null, use=
_sideband);
> +                       send_sideband(1, 2, first_null + 1, after_null, u=
se_sideband);
> +
> +                       return;
> +               }
> +       }
> +
> +       send_sideband(1, 2, output->buf, output->len, use_sideband);
> +}
> +
> +static int run_update_hook(struct command *cmd)
> +{
> +       struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
> +
> +       strvec_pushl(&opt.args,
> +                    cmd->ref_name,
> +                    oid_to_hex(&cmd->old_oid),
> +                    oid_to_hex(&cmd->new_oid),
> +                    NULL);
>
> -       code =3D start_command(&proc);
> -       if (code)
> -               return code;
>         if (use_sideband)
> -               copy_to_sideband(proc.err, -1, NULL);
> -       return finish_command(&proc);
> +               opt.consume_sideband =3D hook_output_to_sideband;
> +
> +       return run_hooks_opt(the_repository, "update", &opt);
>  }
>
>  static struct command *find_command_by_refname(struct command *list,
> --
> 2.49.1
>
