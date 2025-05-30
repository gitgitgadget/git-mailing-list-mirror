Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F17915E97
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748612217; cv=none; b=QaKrqXkh3WRs4gNzGJX5jXk69Ma0nJ75R5fnHUaiAvr5D4xVkoQDCx+0c+/yPUew+CWRAvWBXR9gNQZZIAbzyJX+jEUvRTwr0i4TDyW8NGsIRXRFhTECV4XnmXQehYhpgZUWuc2woz+wpqtBxD3rWQj03ZxcZPvokdgWxWmwgaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748612217; c=relaxed/simple;
	bh=oDsxqPgEWuQhGGPdv9eBoOueHNcDHDYyHN1l6y3UTXY=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:To:Cc; b=iFjl8am+m7YvKq6oJiLkFCgnKab742MiMuRpoBMFMSPU5TqtCdkKZ2F8zlkKztv5ViTwM5wJ7k5J2H9oEYcvHXtjXN1costj3iot8IcUV9fndIlMnQXgVaQS8nfMQk1u+SP5zIMaAEgXoj5G8FPoTXv6Tgmk3ZW97rORDeaP3HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORGhF9XJ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORGhF9XJ"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6facf4d8ea8so9948046d6.0
        for <git@vger.kernel.org>; Fri, 30 May 2025 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748612214; x=1749217014; darn=vger.kernel.org;
        h=cc:to:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZT/p2PceK6+goU21uFbiozWg5ief72YUy9qdXQMYvg=;
        b=ORGhF9XJZlnCzOMYjNixEIDPdSsCJOQX6Ub1kz/+WVxSt5qcn3MwE6+O6jD4hbIlB2
         qgcnqQQCHRC3g/jM4y9/92zDtKD/ChSAultDF65f6KAtNfTshdwbNaET18l+SLmWrPlV
         oYH3P86fjTYAP4AIiGqTV3yi3oXbxFt32Z+a4YvjBkLmRS3HfQ0lxZRTK51UpvUm2Ov/
         Sl0v1HhV/CstIfoQcFVyAJEtyE2YfH2K5tIwOyQ2qI8ORztOCDTIQ+1OCprHrzrt4Wya
         34MMxqh/cC+ztuDDmO/LdlSrdCkgeDm/yTqJYZi/U5zl0rtNZKgao6Sa4YhAFgznql3b
         hgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748612214; x=1749217014;
        h=cc:to:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hZT/p2PceK6+goU21uFbiozWg5ief72YUy9qdXQMYvg=;
        b=nRsdjOJa2DoMJ6zxlufwTmq0OxIsZ6x9EUeYE0kFkIBJdMuv1iAuHDKWXywJfGMddI
         3iThACk3lmtQACkisJPRfRZ5o+oZZvYinfFL1dtYzwAv6FAs77mRkG8UsPlRI3iZjVXq
         MYhDgRiE9QwS00cVOnpsmDDJxaB7LEEV20eInEC/qN8LzB41h75k8aL7Sgxnfr6liN8U
         +WkGpJQAFfqPr/Q0BaOWYhzmhkaBFFG/wwnEPFXj0yHVqZOMrQGZmZzTOK8Gh34wtInW
         nm2gkbNhKghboOPuYTckk8e4tCaEjHt6AHkhUzEaTlOYxeMinojudgxgsCU7XvRbz7lq
         05ZQ==
X-Gm-Message-State: AOJu0Yw7DX+fIODG2ShL03+UUtWqJ+8nDXpz+ILCTeE1OgKopbdsxT2B
	2qYTUJ6xEKBchEkk9MRijTa6M9Tm/KjEaQhKFgcssZ3f2yONwRJ4ddVW
X-Gm-Gg: ASbGncuxZ45k5faPZmxzAwxP/mfyqzVCTcW54K78bl+DavPGElZbYUxvr1lOl+K51aV
	7IZR9BdYevBycy9K042niZWnJLMtBD2NN5dJr62OSOImgKuZwEGcgJWIEpYJm2g7i3lvvlbjtoC
	vJmiBDsxty7JujD7+kaOMOVso9zEHDmnKCXjeQ9BOX/DR1o307hVFHc9JC4uQOAo5nTG7Fh6hJ8
	phBfDDoTH1ZBroGL1ziiBxtFrXIcyDFAMjo19TkwMfKfXXPWYTwvmXMYefI/GqD2+uUfDHvObju
	SptZ9CUY6VQB1X1y9WXrNWizsYako8k004H0Yope3nhdaNCuz9ljRH/NhDH0XsnmYxRkHvaJqr6
	g7VoH
X-Google-Smtp-Source: AGHT+IHiuakO8NZ9oI1gb/vccq2CgvvFqA70iFvVhQP5ZcFnD7OwKfwPJ/wAaFwkzxq0Iv3QiLc1lA==
X-Received: by 2002:a05:6214:5292:b0:6f8:ae25:b717 with SMTP id 6a1803df08f44-6facebe8020mr65115946d6.34.1748612210847;
        Fri, 30 May 2025 06:36:50 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b104:32c0:b484:4436:c503:cced])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6c03c58sm22884546d6.0.2025.05.30.06.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 06:36:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 10/11] builtin/gc: avoid global state in `gc_before_repack()`
Message-Id: <6EE3E4F8-16DB-45AB-AD67-FADE12FBFBBD@gmail.com>
Date: Fri, 30 May 2025 08:56:36 -0400
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Yonatan Roth <yroth@paloaltonetworks.com>,
 david asraf <dasraf9@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 27 mai 2025 =C3=A0 10:05, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFThe `gc_before_repack()` should only ever run once in git-gc(1), b=
ut we
> may end up calling it twice when the "--detach" flag is passed. The
> duplicated call is avoided though via a static flag in this function.
>=20
> This pattern is somewhat unintuitive though. Refactor it to drop the
> static flag and instead guard the second call of `gc_before_repack()`
> via `opts.detach`.
>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> builtin/gc.c | 24 +++++++++---------------
> 1 file changed, 9 insertions(+), 15 deletions(-)
>=20
> diff --git a/builtin/gc.c b/builtin/gc.c
> index e5d1114bd2d..174357b9c25 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -816,22 +816,14 @@ static int report_last_gc_error(void)
>  return ret;
> }
>=20
> -static void gc_before_repack(struct maintenance_run_opts *opts,
> -                 struct gc_config *cfg)
> +static int gc_before_repack(struct maintenance_run_opts *opts,
> +                struct gc_config *cfg)
> {
> -    /*
> -     * We may be called twice, as both the pre- and
> -     * post-daemonized phases will call us, but running these
> -     * commands more than once is pointless and wasteful.
> -     */
> -    static int done =3D 0;
> -    if (done++)
> -        return;
> -
>  if (cfg->pack_refs && maintenance_task_pack_refs(opts, cfg))
> -        die(FAILED_RUN, "pack-refs");
> +        return error(FAILED_RUN, "pack-refs");
>  if (cfg->prune_reflogs && maintenance_task_reflog_expire(opts, cfg))
> -        die(FAILED_RUN, "reflog");
> +        return error(FAILED_RUN, "reflog");
> +    return 0;
> }
>=20
> int cmd_gc(int argc,
> @@ -965,7 +957,8 @@ int cmd_gc(int argc,
>          goto out;
>      }
>=20
> -        gc_before_repack(&opts, &cfg); /* dies on failure */
> +        if (gc_before_repack(&opts, &cfg) < 0)
> +            exit(127);

If I (a relative novice to this part of the code) am reading correctly, we t=
rade an implicit die in a private helper for explicit exit in a =C2=AB main =C2=
=BB function, which I find much easier to reason about. Nice!

What I don=E2=80=99t see (being away from the rest of the source at the mome=
nt) is where 127 comes from. I don=E2=80=99t intend a crusade against magic n=
umbers :) and I=E2=80=99ve certainly seen enough exit-codes of 127 to guess w=
hat this means, but reading only the patch the number does appear out of thi=
n air.

>      delete_tempfile(&pidfile);
>=20
>      /*
> @@ -995,7 +988,8 @@ int cmd_gc(int argc,
>      free(path);
>  }
>=20
> -    gc_before_repack(&opts, &cfg);
> +    if (opts.detach <=3D 0)
> +        gc_before_repack(&opts, &cfg);
>=20
>  if (!repository_format_precious_objects) {
>      struct child_process repack_cmd =3D CHILD_PROCESS_INIT;
>=20
> --
> 2.49.0.1266.g31b7d2e469.dirty
