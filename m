Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79AB1DE4E0
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764162190; cv=none; b=RIXp0VYdJNW44u7Oq/a/kzYfcLFvreBzecJDw6eJ41UiPAA4xcJsaSyb4hPzmZRQolDfDHGLQwFLwTowht3U7vuGoeStkjnXIvTg7G2bqdvMs0gVMbmIdp8oew2Dg+ng3Gy/Ot6uB+msf1EmVfUtzU0Hpbait1bk6dORURW+tyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764162190; c=relaxed/simple;
	bh=386k4ppo/pppJnCfqJOzLfV/h0gZ2kTcXBbwtq3excs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=sCPgifroutZGH9qzjxyqyDdJbHJn1yt8hvcGT5ZBbAMs1hFOB1c0RavCKT5XLxyHUOAs/IQ7qAaxX7N5gl5Tn4/kCjR2WFlvTW/C5X2nGsNhdZSmWNtRE/sBG4MZZSmZmbg73gMBGXlittIx4/a6EHQpqrzO40tlplw2M/B6ND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SC4pn7oS; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC4pn7oS"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3e2d1477b9cso4407436fac.2
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 05:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764162188; x=1764766988; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V5ok2hHlDeCpfbAKGgAMGtui18eYxBpIUsZTUUsTMeI=;
        b=SC4pn7oSkvteorE8RGa7AfpZFHgoMnmdrTzti9rtMbpbsMFqNcuv3GgnpENONL4nFo
         4eGBbw8gArOwMehT/j5kFN6auwgufYPkHscUt16YqzHSWffjOqjpGfkZtKBhCs8KjObT
         gvtenO92+8dUJsxB4nA8I+VYtz76rP/3A7g29ixDNgZ1P5GdLVmCuCIEnVahmldqlPmh
         5xTrBxivpVmrqxeyKFPpRGSTWf47DCMfup6W9ZPnRKLDT04ce/RrHvFwgamscM7Epinf
         MxQHIL0J8SmJ6U7jzdF2/vOUPZjrP99yF68m+ffCGPWSTdWbSTJZ7/hv1IRlQ1AqRPHS
         aZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764162188; x=1764766988;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5ok2hHlDeCpfbAKGgAMGtui18eYxBpIUsZTUUsTMeI=;
        b=e26dSHI2pPydanZsARpuaaqW2leBKKiydse7qG54g/3gax3ZbffdBjaf3PL3XzjR60
         +O5YQ8g/B0SLVG41rRgG0Ha1Npb7wO7jqeDm3uUk3HTndQuHo/AtO2nBwzbKGYffPhcC
         jLU0bwkeYpRw2YyM/6EzDOtWLnsE/sWcCR4yaF5CCDym998ozpbIpfkqGT8IQXqfJEoG
         N21lzS9HYHQ955VhebVZcqUz4BSKhUqFkwtp5A/Fw5yxIhJIIaiJ40V4S81Opz5XQu+x
         2ixI/VNptNgy7vWEAzKSIjvcfqTBsSaGF7y1z5m41tD0WODrA6NeK+bVFptig/7aepEv
         s8NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx8A3dGwCFlOtphY4FnsIprhTf4C3ZmzkHUX6KmU8yYgxtXTyIfWUQUCcZn7JkD+66rus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNdp/EfmGAWsApuRpE6epFgbWT+lVRPhq0lvKxso8pzlOyPkkG
	r9LMu+aee91QyVOE75FZWjsUY9hzaUahBBiDeUbBA7kxZSqtYzN2IJU8gPTlt2JG7RY01AxxW7z
	2JcLrJu3MswnTCzR/bFNztEr39+dZqgMSdQ==
X-Gm-Gg: ASbGncuSBXw2r4NvwC11P9KUPkGKXgcy0uzD8srYbPrMAJ4icqM+8E9LdUI9PQYPF9o
	cT7zHfMVkiIWQEJh02EuJx5AoyBBhUe24Phql1iL3dFVHJXfjOSv6mk2v86VGG90CGdgw1PJD+x
	1bJ0eUzp3056BpbyeahCVraLVtiuXIv+cIUGYDIwZj0Ab9odL9hdvU3V65VJ+9IYgKBpZaXeJAH
	8zWn0P/u0UeO25B10eOvzejNG8QtwmLRZ376IApF4u+wuSKlBDbNqKodqRityUIJuf3ssp7UG8o
	61FNhd1V4epVBCpIgvaBfyR1vTos0Q==
X-Google-Smtp-Source: AGHT+IFC7KyIDccftuEnZNnk5AZdOhR3bub6lcWsOw84sbNPNzyE/vp906ITADEQK0Akvra3E7kBKrf4Bim0RHga8Aw=
X-Received: by 2002:a05:6808:c1a8:b0:450:794a:6cee with SMTP id
 5614622812f47-45115a31b0amr7355515b6e.21.1764162187437; Wed, 26 Nov 2025
 05:03:07 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Nov 2025 05:03:06 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Nov 2025 05:03:06 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251126-toon-last-modified-zzzz-v1-1-608350df0caa@iotcl.com>
References: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com> <20251126-toon-last-modified-zzzz-v1-1-608350df0caa@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Nov 2025 05:03:06 -0800
X-Gm-Features: AWmQ_bkCi_PilsIoE3XTuDC8257iflMh6ObOr6JbpwrK4xrAOB6Y87drPYIOL3Q
Message-ID: <CAOLa=ZRn45fDriKvwVgLV5yXbKUr7bwLadHjemPjb+Mw2tHVqQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] last-modified: handle and document NUL termination
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000082cdad06447f0436"

--00000000000082cdad06447f0436
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> When option `-z` is provided to git-last-modified(1), each line is
> separated with a NUL instead of a newline.

This line make it seem like the option already exists..

> Document this properly and
> handle parsing of the option in the builtin itself.
>

But this line says we add the option now. Perhaps this should be
clearer.

> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  Documentation/git-last-modified.adoc | 21 ++++++++++++++++++++-
>  builtin/last-modified.c              | 13 ++++++++++---
>  2 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
> index 602843e095..cd4a5040b0 100644
> --- a/Documentation/git-last-modified.adoc
> +++ b/Documentation/git-last-modified.adoc
> @@ -9,7 +9,7 @@ git-last-modified - EXPERIMENTAL: Show when files were last modified
>  SYNOPSIS
>  --------
>  [synopsis]
> -git last-modified [--recursive] [--show-trees] [<revision-range>] [[--] <path>...]
> +git last-modified [--recursive] [--show-trees] [-z] [<revision-range>] [[--] <path>...]
>

This is a bit long now, let's wrap it.

>  DESCRIPTION
>  -----------
> @@ -32,6 +32,9 @@ OPTIONS
>  	Show tree entries even when recursing into them. It has no effect
>  	without `--recursive`.
>
> +`-z`::
> +	Terminate each line with a _NUL_ rather than a newline.
> +

Nit: perhaps it is just me, but it would nicer to read if it said 'a
_NUL_ character'

>  `<revision-range>`::
>  	Only traverse commits in the specified revision range. When no
>  	`<revision-range>` is specified, it defaults to `HEAD` (i.e. the whole
> @@ -44,6 +47,22 @@ OPTIONS
>  	Without an optional path parameter, all files and subdirectories
>  	in path traversal the are included in the output.
>
> +OUTPUT
> +------
> +
> +The output is in the format:
> +
> +------------
> + <oid> TAB <path> LF
> +------------
> +
> +If a path contains any special characters, the path is C-style quoted. To
> +avoid quoting, pass option `-z` to terminate each line with a NUL.
> +
> +------------
> + <oid> TAB <path> NUL
> +------------
> +
>  SEE ALSO
>  --------
>  linkgit:git-blame[1],
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index b0ecbdc540..9206bbdc1d 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -23,6 +23,10 @@
>  #define PARENT1 (1u<<16) /* used instead of SEEN */
>  #define PARENT2 (1u<<17) /* used instead of BOTTOM, BOUNDARY */
>
> +#define LAST_MODIFIED_INIT { \
> +	.line_termination = '\n', \
> +}
> +
>  struct last_modified_entry {
>  	struct hashmap_entry hashent;
>  	struct object_id oid;
> @@ -55,6 +59,7 @@ struct last_modified {
>  	struct rev_info rev;
>  	bool recursive;
>  	bool show_trees;
> +	int line_termination;
>

Wouldn't 'line_terminator' be a better name?

>  	const char **all_paths;
>  	size_t all_paths_nr;
> @@ -165,7 +170,7 @@ static void last_modified_emit(struct last_modified *lm,
>  		putchar('^');
>  	printf("%s\t", oid_to_hex(&commit->object.oid));
>
> -	if (lm->rev.diffopt.line_termination)
> +	if (lm->line_termination)

So it did exist before. But this was parsed as part of diff_options, why
make the change than?

>  		write_name_quoted(path, stdout, '\n');
>  	else
>  		printf("%s%c", path, '\0');
> @@ -507,10 +512,10 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
>  		      struct repository *repo)
>  {
>  	int ret;
> -	struct last_modified lm = { 0 };
> +	struct last_modified lm = LAST_MODIFIED_INIT;
>
>  	const char * const last_modified_usage[] = {
> -		N_("git last-modified [--recursive] [--show-trees] "
> +		N_("git last-modified [--recursive] [--show-trees] [-z] "
>  		   "[<revision-range>] [[--] <path>...]"),
>  		NULL
>  	};
> @@ -520,6 +525,8 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
>  			 N_("recurse into subtrees")),
>  		OPT_BOOL('t', "show-trees", &lm.show_trees,
>  			 N_("show tree entries when recursing into subtrees")),
> +		OPT_SET_INT('z', NULL, &lm.line_termination,
> +			N_("lines are separated with NUL character"), '\0'),
>  		OPT_END()
>  	};
>
>
> --
> 2.51.2

--00000000000082cdad06447f0436
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ae943fd30e8affd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rbStvZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meU95Qy85aW10MnJVNEdBVlpSTE02OFRIS0NOdUk3Lwo2alE3ZXpSak9h
OUlSekhPYU9XMFM3NFJlM1N1TUF4WmFxTnl5cnpBM1g3WjRIVzYyc21QRkg0UkQydnA1NUxNCkNm
cmxIc3JLbTZFajBldGhVT2ViNU5WcExWSG9ZbDd6NFBnRHJLWFFYdUorTUVHU003RTFHSEozaDQz
ekd1ZGEKUnhieC85NHBGbTFsM1czdjFBNjhwU1dMOE81aEQwZXRaR0NFUGIyVEZDREVPVWR6ampk
NU1lNXZ1T21DNXpLSwpjM2c0RXdoUjFDMEZ0NXZTdWpRSVpMR1VkVVJaaURxYmxiQkhIV0JvVmFE
MnZncTF5MzNzVUVTUDRPUFMxRjJSCkVRWS84VEZYL0YxbW5nSHZ0MUt1NjVuQU9yY2plSUV6VldR
YVdTUGpvdUJ4Z2xDclppclBPRGUwWHZvN1c2d2MKTjQ5dkN4VXoyaTJTTlkyeWRoRGlDN3RRNHYr
RGdtTTMybENRa0R5SVA3a3NvWmFhTVRuTVIvZGREbGVvTnV1YwpmQ3A1M09uQ2NXcWxHS1llYklU
a0ZXNVlPR1FMaGpXQ1BQQW1Qa0NrVkJuenIzNE9nQTcxbmo5bmJjMy9wTUZ3CmhERDRLeEJrMkF6
clhmVnIwS1lsaFZaN2E1UTE5SkRVUFdKOE51OD0KPTBBWU0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000082cdad06447f0436--
