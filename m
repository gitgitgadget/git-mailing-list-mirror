Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737272F5307
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771142; cv=none; b=fgK4RLObODn33DSn2XQonUF8ojAhgzMFfhLmCQOofn5eszFzGClci91Cyqvt6mxuaXN86p6MTe3bHGdtb/uh+LDSFyVNopMLk+PawqNhEHZnk9+Lq+UnT/cHBUVU6zGFr0LK2ZwZx2smpIPkNcjpGBdU33e1RroYj5TQXA/QZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771142; c=relaxed/simple;
	bh=DZsnhMqRPd7Yuku6zGSNzfUoxPaMBi9pSHkNgNFUwMo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmhcbU2U4YIrtAOkBB6Bq7ZEn/mNT3TjMNvDnmfLa9ebj1zt40zcAyYnVCTuwttEEBmToCBv+GFiW3ZaKaSfqDsHrjEMyyMR4NUTwfcRO66OeAWOLTyNI8m4+cKlk/MdLeMGSSlHI7FjT8+326vuxJXtFVQfBZ/qDFQs5Arv9N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AglkwJtF; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AglkwJtF"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-53b17552198so281366e0c.3
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 03:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755771139; x=1756375939; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eIAy70+EKlXDzUx1QmsagML4eZ8NSVLtow177Ecbbvg=;
        b=AglkwJtF7CYjrglxbyK9anM37PCoU/ZycgVdFjkFzMjWExyFlunQFNrH8nUQlsawvj
         NQnuUOboC6N4Vl8SutWJPAEBtB9eukYMC2v+2MOTNns7d7KXt7vnFmknqnMR/eWvoWUt
         z1XUBTtAn+WdicysX2u7DSuC4UVAHvf6sfYIDRAarboR+X2z6ounjlEDpJ1ifBSpkMyO
         weTfcqSDPgi+KgzUKN7cNM8eQyR4IWpcqponDRJ6G88dPTP4pRdHrza7ofO0A0GlhhV0
         hc75jLfsq8Y71d97dN88AlSwcLbK7RpSbDHjpGuWLqZcL2AXlr+s6DQ/FDRos4xJ+ykq
         2dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755771139; x=1756375939;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIAy70+EKlXDzUx1QmsagML4eZ8NSVLtow177Ecbbvg=;
        b=OkSJptm/1vGtmk1p01Y7lWbOm1V6Ds6KDMCs8t64n3GQoU6OSaXyoQOvyhwqeZIAqK
         YmCdmpYQfuIBVtK4oPRWxA2kc0CWNpLeutC8/md6MAwRCyit+AxOjthsN33a3utXcwdD
         G6cfMzN1245lVwNoUBkaqDH9wqAoAxxRQPzpLLyrab7xVIPP0QYi/WmWAw4WjezwrJWC
         lLJA5AJDBrhI1139eLq13M3ghjsGaHrxYaClAAOU+AHZ9vtZbPGpcqlEyxbYe+2TxnFR
         2HKu78DH1WwCQmwFjz2L1NEMkNU0u4dZlrFoqXivd6MLP2dQYIre2Q6S5SoiMqIFI+Bd
         6/3g==
X-Forwarded-Encrypted: i=1; AJvYcCU3YJCxtN3/FFE0ZMlq0LPX5IPr+bspqGMwQPCYqeCvVUU3Arppfqo+Eeixi2VOoINs2q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwZI1J1zXJJ3LY0Wo2Oa3woCkiVDMbvPjn1WlUPrK32SNPn1Gh
	m9d44wjTHrrsk/RyNHZ7CIBUuQgNCInaWio11INRKSEM7d8XzrAL5u0IMTuhGokh4bLaHbwTSpd
	aFJS4PY1y1+cCiOH/t5oJFJMHm7e2Gnc=
X-Gm-Gg: ASbGnct75N7tp99q0gqbZI8GBLtXgFXzVYiuR+7CtK6MeW7X4bOhS3GldGygInTjsya
	BrXt/mD8CuKEPTPaIXNT5zZuYjFHyE7q7TWFAuTOMEJGwE0tx4Z79dTfHaDnRcnqajkozu5AFfT
	zSyaDHppNbMDkJHQVU83hFSF8idU/DPzze+/WIQGf9bdazifCQ1OoA4/St2GhZVhSs2lj1VCwlx
	DNQqspOduqUkrb5pGU4+KNHSOXvL8CFlWKQhKue8g==
X-Google-Smtp-Source: AGHT+IFq0CQd6qUzXNOUv2RFqHUZPxGAMull5CL2zONh30ZmjIG+ePN9csAQOK30ubErahbmJseBBTqERGU9hCBwF8Q=
X-Received: by 2002:a05:6122:4686:b0:53c:6d68:1cd4 with SMTP id
 71dfb90a1353d-53c7d8f713dmr447644e0c.14.1755771139136; Thu, 21 Aug 2025
 03:12:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Aug 2025 03:12:17 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 Aug 2025 03:12:17 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250820144247.79197-2-lucasseikioshiro@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com> <20250820144247.79197-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 21 Aug 2025 03:12:17 -0700
X-Gm-Features: Ac12FXznfx8bAgnQxJlKAY8rrCkO3ta1viGXUDJgLc9P9wlvTPpxFZooeUaXpYs
Message-ID: <CAOLa=ZQZCUsa7M0mh1oCq8hhBZS05=jw4y2Lr1r3rPe0-ajbhw@mail.gmail.com>
Subject: Re: [GSoC PATCH 1/2] repo: add the flag -z as an alias for --format=nul
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000000e41f1063cdd53dc"

--0000000000000e41f1063cdd53dc
Content-Type: text/plain; charset="UTF-8"

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Other Git commands that have nul-terminated output (e.g. git-config,
> git-status, git-ls-files) have a flag `-z` for using the null character
> as the record separator.
>
> Add the `-z` flag to git-repo-info as an alias for `--format=nul`,
> making it consistent with the behavior of the other commands.
>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  Documentation/git-repo.adoc |  6 ++++--
>  builtin/repo.c              | 17 ++++++++++++-----
>  t/t1900-repo.sh             | 12 ++++++++++++
>  3 files changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 2870828d93..f2dc71193c 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
>  SYNOPSIS
>  --------
>  [synopsis]
> -git repo info [--format=(keyvalue|nul)] [<key>...]
> +git repo info [--format=(keyvalue|nul)|-z] [<key>...]
>

Nit: Perhaps we can leave a space around '|' to make it easier to read?

>  DESCRIPTION
>  -----------
> @@ -18,7 +18,7 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>
>  COMMANDS
>  --------
> -`info [--format=(keyvalue|nul)] [<key>...]`::
> +`info [--format=(keyvalue|nul)|-z] [<key>...]`::
>  	Retrieve metadata-related information about the current repository. Only
>  	the requested data will be returned based on their keys (see "INFO KEYS"
>  	section below).
> @@ -40,6 +40,8 @@ supported:
>  	between the key and the value and using a NUL character after each value.
>  	This format is better suited for being parsed by another applications than
>  	`keyvalue`. Unlike in the `keyvalue` format, the values are never quoted.
> ++
> +`-z` is an alias for `--format=nul`.
>
>  INFO KEYS
>  ---------
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 8c6e7f42ab..b2ec66e454 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -9,7 +9,7 @@
>  #include "shallow.h"
>
>  static const char *const repo_usage[] = {
> -	"git repo info [--format=(keyvalue|nul)] [<key>...]",
> +	"git repo info [--format=(keyvalue|nul)|-z] [<key>...]",
>  	NULL
>  };
>
> @@ -115,20 +115,27 @@ static int print_fields(int argc, const char **argv,
>  static int repo_info(int argc, const char **argv, const char *prefix,
>  		     struct repository *repo)
>  {
> -	const char *format_str = "keyvalue";
> +	const char *format_str = NULL;
>  	enum output_format format;
> +	int format_nul = 0;
>  	struct option options[] = {
>  		OPT_STRING(0, "format", &format_str, N_("format"),
>  			   N_("output format")),
> +		OPT_BOOL('z', NULL, &format_nul, N_("alias for --format=nul")),
>  		OPT_END()
>  	};
>
>  	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
>
> -	if (!strcmp(format_str, "keyvalue"))
> -		format = FORMAT_KEYVALUE;
> -	else if (!strcmp(format_str, "nul"))
> +	die_for_incompatible_opt2(!!format_nul, "-z",
> +				  !!format_str, "--format");
> +
> +	format_str = format_str ? format_str : "keyvalue";
> +
> +	if (format_nul || !strcmp(format_str, "nul"))
>  		format = FORMAT_NUL_TERMINATED;
> +	else if (!strcmp(format_str, "keyvalue"))
> +		format = FORMAT_KEYVALUE;
>  	else
>  		die(_("invalid format '%s'"), format_str);
>
> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> index a69c715357..3df55dcc79 100755
> --- a/t/t1900-repo.sh
> +++ b/t/t1900-repo.sh
> @@ -92,4 +92,16 @@ test_expect_success 'git-repo-info aborts when requesting an invalid format' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success '-z uses nul-terminated format' '
> +	printf "layout.bare\nfalse\0layout.shallow\nfalse\0" >expected &&
> +	git repo info -z layout.bare layout.shallow >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'git repo info fails when using --format and -z' '
> +	echo "fatal: options ${SQ}-z${SQ} and ${SQ}--format${SQ} cannot be used together" >expected &&
> +	test_must_fail git repo info -z --format=keyvalue 2>actual &&
> +	test_cmp expected actual
> +'
> +
>  test_done
> --
> 2.39.5 (Apple Git-154)

The rest looks good.

--0000000000000e41f1063cdd53dc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5506ab87d687c559_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pbThRQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMHlTQy80aGZQUE4wN3I2VmR6bWp3dXJ6LzlsRUthVgpQcmRmdXV5VHBz
U2tFL1c3ck1IYTFNN2RlWVpQOTRkTlVmaExjTUFJTXdmMUhpMS9Xd1dZUXFGZE1UbFhvNDh2CjZl
cWQ4RnpCT3R2V2NnZTRuQUxNQWVmZFhZSDM5eDhYQWgzbXE0UjR3bnpWYnFFdWtZUWhzWHNUeWlY
NGxjSmwKRzJLOXR1cVFsOWE1aEJ0MFJTUnkxNEJ2bzV5d3VZODRUM3M0NC9IMGExWWtReGZsSG94
Vm1LZTVnbG5xQytaUwo5cGI4T2lFeklmZlJSN1crd0dKcVFjaTlXL3FjUlN0a0thK1RYYVlqYTRN
RExBM1VhTzZaYlY3ZUJ6OFlxbG5oClBTT0puSlNqVUlXeUhPZkNaVG5UNUo5U3dJSGsvRHBwY2tR
OWxPRlpKRDZmZUpBUndUb2pyK3NGc3YwbWxYc1YKeFpUQklXL1AxcGpWWUJLc3BIM2NoeE8xK0NS
M0RPd2xQall6emFvTk1hdWx0bERiUVc3aWtOS3pEY3lrOW5zNwp1bnVtVi9DVVVERG1CWmdCK0dJ
LzJQNVE5dll3SDVKdUlJTVYwd1FPTGpPanR4dk5ORHpjdFJRaGM1RXNOckR0CnQ2cmN0alkzUGZR
d1BkREJKb2hsc3Y1YnhkandudlZQOUoxVXJUOD0KPUdsekoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000e41f1063cdd53dc--
