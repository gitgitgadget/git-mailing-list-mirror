Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2263769F2
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254823; cv=pass; b=k2bzEq1m2wc3jEa/wNvwymd/6fzLAlrGqNCGygw3v4de9hvyOwfvUIgBRel1XltdQztPe4OokEhAiL8XgzxCeca0KNamE4gq5X73/u5ixWY6sDwlm+uHIey78d6/dJbW0Z/vJG3iMblr7sn9Pyhzch/cqk50bo76B7VuqcztCk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254823; c=relaxed/simple;
	bh=69BCGbmUMbqS6XNkgQW6hACfzaB7imLM7DZCCanF1r8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=LoO4Hom0wGQZB1jo1ssEoOaFtb6BpOLTZnbJUWPG+qMxQNLBW10Qyoft4UNZNX+Tz4RsL4abQf+apsviK51iIxgZrsYpGr35TooPwv81pQWxByNDy0xtYixR3wunT8Ubmwj7uxPERRzBrUrgzrZ/2yArcB2fbRE5sSxfk28egzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H14AZ1F4; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H14AZ1F4"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-6cfdce656bfso253416137.3
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 02:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781254821; cv=none;
        d=google.com; s=arc-20240605;
        b=QD1tJbVAW5D3vt7fgPVcf61RxjHWFNoIeaD7Ki86LmL1dPEH36o5Bie6aE9gx02u5r
         DiYppqG/MbN73XbxKS1HVbb9jbG85MQz2i3SAclA4NV8TQON1G/VzZR5abbnlr1JzNPB
         CW7WBtIQcNxSLPGnnOehrwY9u+BFLE1HqRxk+d6qX86dQwXRP8/ZJJtq4ty9YIU1WC/Z
         hlSPXVfSaPPwvAB/JpyUBbhtAl/jaCXbXqaZ2zqvx/nvGPwcbfdDwePCtSZ6A5ut4KVI
         So6UIEUmRoW6OlC7bcxQPCy9uSAaCSOVsc5G+NcaA+8SEktkRfZeihfGT/IHaj2Gx/iH
         Nfvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=VC3PE8niJoqcn4va5ZKaNey5eKIOjGzpV/DvUf9KliE=;
        fh=xtsKhoA/zJ36GGlScEUWIEGKNnJr0KQ8qCD3Fc2+DEM=;
        b=hLHlvw5iO6rDTtZ0AjkHX4wpNNl2Iknizmn3tafNalJkHPeNwxSssgiS/OlMqvxY2u
         fYV7mzKM4tDjnY+ynZ/bQ2Sc+64w5sHcovrWkCZENgFPmkb61Z3c7ikSzFIHJS4qTqh3
         V326okse5Pr7/okreCvWsBjxJVrwRzG8bvP721GOmJ0A0oykaW5MoKQWFX4oKSLORUjM
         o6QPZNppcdzTp0ZM1Xe1eeExFaE+u60vqggcdstgTvFlNtRGVtt4O2N7MZYrKpDtLLTl
         mLpohq+CQAHRJk7464hGW2M7TULObCBri2+iWP96ciwVDN9MaH6O69R+ZTsswI29jGgh
         IB2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781254821; x=1781859621; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VC3PE8niJoqcn4va5ZKaNey5eKIOjGzpV/DvUf9KliE=;
        b=H14AZ1F4NnVQ6cLmNJ2zTxp/2cfiQPcv9lsImEFzqC2P+1SrnnBzEENicLp/jGd2aM
         PH5ApOUFQClZ5bMBm30lzmudUYlrzWY0MJ2lpqWskmM9DmJuAyplqMn9OsIHf+JZ0MwY
         8Y+VqCsHTG4kapbIFjf4+6RHQY0KANptsdxaT7KK0Wap/8My54f2NLYCNalSsT2nEFlZ
         yTjCa/oh2qB/Yff04byMktrhig3ZCpjZY6a7eCpJr92qoz3cVPRx22/CjXby8LLb+G3j
         r0pV+qjy/AY3QJPGKYcRbWxRgON7AEaVKhoU9a3kquU9PctLYGSgP5MVHdEuFiAbUMeG
         Ye6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254821; x=1781859621;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VC3PE8niJoqcn4va5ZKaNey5eKIOjGzpV/DvUf9KliE=;
        b=OCgq3XZxoYiw0jj/rwaMZKRgVtN5zM7VtBJ9sul6jzy5crxc2RgxFQjbYujHLWKMLQ
         yzZllDY6d/Nqk+FxMNepwFm9XbRD+kk3eFwKoCIqDMOVKz/dCL4Os8Kq5AMFmkBKROJ8
         dSOtL0ZQROBRE9gSOfi3h+mdrGwBnIWkRZCVD5FoFLz7qH74MHZ3ijvXx8yYBzDxE0X7
         aZVfF3o1PcGI64I4uPpUAMmfbRdjp6OmLMiRjioYG1fyPYjPnQyYjYtiQPT4fGKyGDNm
         39dDu+ys/aqvlfZMp2rnW/AKiaXB2f21gQJ3okKfXjX+M7a4sfF4PyQMR2fyrJdrD1xJ
         Fohw==
X-Forwarded-Encrypted: i=1; AFNElJ8KTN4mNcFNO7Wfu0o5uQ1SScLiuyLxrHDKqBCHlvHYcb0WULlXq0nYJwGqbK1eRRxTMv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/cAQPBZnMLOXbgIVtHc7cyJnpEFjA2Xv18yyJx/0dRcocDNAb
	fLJS58zD16xXONsC9Gp3gqmkc7Rk5hsrCa5mP4MOfIoO/0AF/tGvymIj9C2Fre6BukmhEPtvCzV
	UrVCUgJrYRQqlPCtbXZIAHaVb0h6oIU7xFg==
X-Gm-Gg: Acq92OGh/Hzt3KouaP9j4JBQj1RDfNtTsUjjWY/Zs8kcSz7My3axPmUwrq0PS3TSRer
	IsFzLZqNjgyN1CZqMPm6kh/pr5ZPxh2nrIVliPGF6/M4cqoBNHX/KiMmMaQzMYwnAKVZnGLOSuy
	m1i/SqbocrWXMZtq8zFwTyRorCLAydSjQXVOyYfssyUkS89JBBWk7Zkx0ntj3ZqmkM/iEMvDZEO
	iR7nOiTz2oHqTLKtpZxrj1hpxr1/iQqP+yuJe+8BJgLQBKFKeGgwFDBU/MLaPawgP1XBbEueecz
	15otkeDZ3MOTpfwA8ITLW8AFRaD6ZjQWc1F3WaUpyN43s/Yim1hHbPhNycRSAHmwYKULRPMueQ=
	=
X-Received: by 2002:a05:6102:5113:b0:6c6:74d:e09c with SMTP id
 ada2fe7eead31-71e88b32723mr616403137.11.1781254821070; Fri, 12 Jun 2026
 02:00:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Jun 2026 02:00:20 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Jun 2026 02:00:20 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-2-56c864b01c43@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
 <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-2-56c864b01c43@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 12 Jun 2026 02:00:20 -0700
X-Gm-Features: AVVi8CdQTS743gzWQ8c6pzKyplah50jLyYQxGz8SQgqG2omg-aWh38Xoaa7waXw
Message-ID: <CAOLa=ZQC7YCBxjxkbm8qcWqpNFgAKNpvw9B6t=+XnX4bbkGq0Q@mail.gmail.com>
Subject: Re: [PATCH 2/9] setup: stop applying repository format twice
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000dd6bae06540ab4dd"

--000000000000dd6bae06540ab4dd
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When discovering the repository in "setup.c" we apply the final
> repository format multiple times:
>
>   - Once via `repository_format_configure()`, where we configure the
>     repository format for both `struct repository_format` and `struct
>     repository`.
>
>   - And once via `apply_repository_format()`, where we then apply the
>     `struct repository_format` to the `struct repository` again.
>

Okay so we're talking applying the repository format to the `struct
repository` specifically.

> As the format will be applied to the repository when applying the format
> it's thus somewhat unnecessary to also apply it to the repository when
> adapting the discovered format.

This was a bit confusing to read at first. Okay since we already apply
the format in the second step, the first is not necessary.

> The only reason we have to do this is
> because we call `repository_format_configure()` after we have already
> applied it.

Right, so there is a need to do this.

>
> Refactor the code so that we first configure the repository format
> before applying it to the repository so that we can stop setting the
> hash and reference storage format multiple times.
>

Makse sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  setup.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index a9db1f2c23..2748155964 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2710,8 +2710,7 @@ static int read_default_format_config(const char *key, const char *value,
>  	return ret;
>  }
>
> -static void repository_format_configure(struct repository *repo,
> -					struct repository_format *repo_fmt,
> +static void repository_format_configure(struct repository_format *repo_fmt,
>  					int hash, enum ref_storage_format ref_format)
>  {
>  	struct default_format_config cfg = {
> @@ -2748,7 +2747,6 @@ static void repository_format_configure(struct repository *repo,
>  	} else if (cfg.hash != GIT_HASH_UNKNOWN) {
>  		repo_fmt->hash_algo = cfg.hash;
>  	}
> -	repo_set_hash_algo(repo, repo_fmt->hash_algo);
>
>  	env = getenv("GIT_DEFAULT_REF_FORMAT");
>  	if (repo_fmt->version >= 0 &&
> @@ -2786,9 +2784,6 @@ static void repository_format_configure(struct repository *repo,
>
>  		free(backend);
>  	}
> -
> -	repo_set_ref_storage_format(repo, repo_fmt->ref_storage_format,
> -				    repo_fmt->ref_storage_payload);
>  }
>
>  int init_db(struct repository *repo,
> @@ -2830,10 +2825,10 @@ int init_db(struct repository *repo,
>  	 * is an attempt to reinitialize new repository with an old tool.
>  	 */
>  	check_repository_format_gently(repo_get_git_dir(repo), &repo_fmt, NULL);
> +	repository_format_configure(&repo_fmt, hash, ref_storage_format);
>  	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
>  		die("%s", err.buf);
>  	startup_info->have_repository = 1;
> -	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);
>
>  	/*
>  	 * Ensure `core.hidedotfiles` is processed. This must happen after we
>
> --
> 2.54.0.1189.g8c84645362.dirty

The patch looks good.

--000000000000dd6bae06540ab4dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: aa41cf3ec3b8bc72_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vcnlxSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md2lpREFDTmwxbHM0cytLYjRmTlRPQ1Zhbm1Cc2xkSwoycjNqTk9VUm5r
TGd6MERTNHRrazNISi91M3AzU0lXYzF0dEc5c2NWb3NUQlIvZUl5djVtN0lwaXJhSVN1SUNqCjhl
WTIwMEhFK2hHTGtoa2w5RkxlRzMvMkNocytjSk5MVGN0NXZ6UDlWWC8vRENJZ01DS2xzczBUR1JK
ajVoWUMKVTBRRk5XWWR1cGRhZnhSVjFqQUNRVDFNeDU2YjIvNFc1V3VpeFQ1eDZsUXE4alJ3a0d1
aXF0WWptM1kxR21jUApHenNKT2xyYjBBT2xsM2FZVzYzTXhmZHNjUGJsZ0UxZi9VK1BrRi8yLzc4
bE4wSjZQSlJHeVc5UXB6WnUzR0ZVCkV0aVFsY3Z6MHZHK1FCdXUwWEFvU0pVdWREU3NnRFJ5SUdH
T1I0cnRaSDZiaENVa2hFSWR3cjNjZUJDaE1IdlEKNUwyalNWcW05TUwrSVFqWWdYV0d3dzNkZDMv
akVvTkx0dXBrTHE0TTFwdlo3NkxoUURmYXNQZlpUa09kMElJTwphUU5jNzBHYjA0MHptRGtGQjlh
eWpFR0R5a3ljeiswMG4vMExRc0ZDeU95VHBKYWlBekpBM09KTHRJclplY0hOCkRldXh3MU9ib2Rk
YUhXb2F6MEFkdzRieG95b1ZGbjFUUlpHME1maz0KPUdLZWIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000dd6bae06540ab4dd--
