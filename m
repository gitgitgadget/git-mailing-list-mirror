Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D92420AF7D
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267312; cv=none; b=WPAcdA+AoZ98L7grwOlJn3wvU85fVqL2jrpI/k8qlczrSxnp8Cb0/woWTZvBRy1a3mM5l7aIrgum+7jcNijO3HTFEPfBsoU9Azm60FzNhg+8zA+tvrR8Lmrc0eW1Ic1nawmqfRniB9avZR+47Yr3x7jz0AE0ol9EN6kzoOVL2gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267312; c=relaxed/simple;
	bh=x0dG2Wmb3FhzpsnPYUt29DjD6WW7SYZS12SNiAXiQkI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhGBAl6YUuM3iBCfGXT80Gmaq/cmRn87N6qKGBuh23cUeW/FKy/QfBQqhQJWgprKglfR7IPxdgiSbdtL1R9HLATh5wcRzN5+w9UKpcgABdysCNhLU6+PZbfTUMK1a05ntoCtamFzX0s2fUUXVC9W+3oVqSwRjsqkqA8VI+Yhows=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFoBJTBi; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFoBJTBi"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86911fd168dso244938241.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 05:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741267309; x=1741872109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ycY3sfaKPhCMjfm7Z4BHNOq080pzW8rhqJT8xiAWc7Q=;
        b=dFoBJTBieSPKQI86yqu0U6a6AyJ2zVO2Gp3/Q8JzlJdG8eVnbZC9feInK3v5bNCQYu
         txVJLFdB2CzvEtzOSwQOA4IH2Ew5duGlI7qKd4/ILAfITMQlrMkLAvXIlad+V0yfQwpT
         WESIjT/t0aSqx9G2e1HPV6UPXDlxpqbDsQ3iCrdL3qAxYk9r+XteKO7NAygJPeZdBk6r
         iPzB8F6LWxsEIUIF27asxQc+iYlBBXAHpxfD2Xvl/MHZdXH10idZYpfnlMy4M9Ps/W4S
         LojLmMCCbtZ/+QwGbgwSn8brcLjeq7BddeMaIZWit9grpka9Dg0++Obzjcm04iJDJ9Qj
         2f1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741267309; x=1741872109;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycY3sfaKPhCMjfm7Z4BHNOq080pzW8rhqJT8xiAWc7Q=;
        b=MPINGjusvJWXGwibiiiZDEQstfkZLxblNF6EQc8E44LJkN5i/FH3jGgrh6XXaG+QHF
         X1ZpIbP00HV1bl1jIkpuwMTsLDgsomg2U7Dpm4gIwsTRNaF/b2ExDh7dXEa9RcBHcLpD
         2XmEvwB0gBXNvDDdkUSO6WijIKS5bnuwhk0LtaxtYAuvNq6QFS16dAxavf5Sue+moKyv
         d9oFCdDhlB6DJGnytNWGzxkXEVcvLp5VHABjpPIVIRhrld6SqlD7iFsSOtghGt5zOe/a
         +YEKTFjuwyTORshwdMWKt/e5kVN6dhy9QdTtDYRe+xmTyrnWSyOyAfqjhbHQnVhpUZgL
         IlqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkqc0o/fXaVBnZMvZG8uqI7NcH3KipUtu93e7jAJB9/0HeQAXISVvcgO1GcKjIi0aVzqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJAGmIAH2fYdcMTafUPHBDHRAZiCuhwhiKHLy56hQpqiLd1Kpk
	OKEHuF37/P09veis70Q/G2Rn1omM1oL0bzBZr8Lr2vN/slILtYVJr4sa65WuxtTClVBw/nVlPgi
	POQdpvXf7H+FaycExEhPEnexwcqw=
X-Gm-Gg: ASbGncuQN15RZvgWu30hoR5EHytetoYRWC4wLfGgn/T6IixAjw1dSbysIAKs1z6reyj
	pnWKdmrekgp1UzzZvTWE7dZswuC09FwbdvzBFDAC5E+3zdJFoQh5qTtM0tXwtcLpdSEa+DRFXm2
	Yp3W0ILdn/8KTa157YgnZXThWe
X-Google-Smtp-Source: AGHT+IGyKcTbwxJDrK2l/ReRrsAn+LNSJccbA5dLhOIAUvl9AU9EPglLFpMNbm8epreKBfD6vO8uvLEvLdd0u2gpY9k=
X-Received: by 2002:a05:6102:c46:b0:4c1:935a:2446 with SMTP id
 ada2fe7eead31-4c2e295204cmr4392126137.19.1741267309214; Thu, 06 Mar 2025
 05:21:49 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 05:21:47 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-2-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im> <20250228-pks-update-ref-optimization-v4-2-6425c04268b5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Mar 2025 05:21:47 -0800
X-Gm-Features: AQ5f1JphALFgjfrYDheM29XYfT65FjExdM0H62ThVrKpMKTbKVhs_h2ePtQx4qQ
Message-ID: <CAOLa=ZR=+4rzudsXKQv0OT5NkY3KeM08PxUA=UFhERO0RpF1uA@mail.gmail.com>
Subject: Re: [PATCH v4 02/16] object-name: allow skipping ambiguity checks in
 `get_oid()` family
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000006cdceb062fac6351"

--0000000000006cdceb062fac6351
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When reading an object ID via `get_oid_basic()` or any of its related
> functions we perform a check whether the object ID is ambiguous, which
> can be the case when a reference with the same name exists. While the
> check is generally helpful, there are cases where it only adds to the
> runtime overhead without providing much of a benefit.
>
> Add a new flag that allows us to disable the check. The flag will be
> used in a subsequent commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  hash.h        | 1 +
>  object-name.c | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hash.h b/hash.h
> index 4367acfec50..79419016513 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -204,6 +204,7 @@ struct object_id {
>  #define GET_OID_ONLY_TO_DIE    04000
>  #define GET_OID_REQUIRE_PATH  010000
>  #define GET_OID_HASH_ANY      020000
> +#define GET_OID_SKIP_AMBIGUITY_CHECK 040000
>

Nit: not worth re-rolling for, but the other macros are aligned. Our
styling guide is to align them and this is only set in our
'clang-format' [1].

[1] : https://clang.llvm.org/docs/ClangFormatStyleOptions.html#alignconsecutiveassignments

>  #define GET_OID_DISAMBIGUATORS \
>  	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
> diff --git a/object-name.c b/object-name.c
> index 233f3f861e3..85444dbb15b 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -961,7 +961,9 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
>  	int fatal = !(flags & GET_OID_QUIETLY);
>
>  	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
> -		if (repo_settings_get_warn_ambiguous_refs(r) && warn_on_object_refname_ambiguity) {
> +		if (!(flags & GET_OID_SKIP_AMBIGUITY_CHECK) &&
> +		    repo_settings_get_warn_ambiguous_refs(r) &&
> +		    warn_on_object_refname_ambiguity) {
>  			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0);
>  			if (refs_found > 0) {
>  				warning(warn_msg, len, str);
>
> --
> 2.49.0.rc0.375.gae4b89d849.dirty

--0000000000006cdceb062fac6351
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 101e638007955aba_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSm9Xb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkhWQy93TDdEWW1FWXZXUjJCaVZ5VkV0VkU5T05jVgpVeFR0QjdqOG0z
OEV2SnVPNG5uNWk5V05aMkYvWnJZV2lrRldKYkVvejR2Uk5NN1R6VkxLS3hhMnVUOTJWY1UxCnVp
OHRnUTY5dFhraUU5U1Z0d1pRaHM0UmV5c2sycDZWRFFibklJOGpSY2pHSTU5ZXVpUnIva3piblNT
a2lsNDQKWE5SRkplZ2F3bzdrM1VZRG9vanptMG5hQ3Yrakl0ZUdlY1Y5SFdBMk5mK3krVGhXNFp5
d2kzTGNkYW9VZ0I2WApaS1l0M3pQTzFsbmtiN29TL3JpcTJKOTdMRE9nS3dCNVMxaDgrcitIUXVU
ZXd6VWV5LzhrVU81WFoyZGFYR1g3CktmRnBkWEtVUkdGWHVhenN4VEVHeGRza1NaYk1YSSs3WWU0
WFh0MEorSFFDNG9oNDcvMDdIblhzVmUxS0JOMkgKV2xkMk02Vzg5YzBYK3UxV0xleitNVndvNWdH
cnNaY0J6Zyt4bGs1Mmhpa2V2Z1hCdEFHVWtkKzQ5QkxOdDN0NApGNnFpMnBxRENTd09rMWdHeDEy
NjVoY0RMdmx0dG1kbDg3bzZVRmp5ZTI5blptaVZITFhYODJ5Tlp2VURLR1RICm9OMHk3RVJwQm1q
ZDhtOUh4UVNUeFpqMXNlSmJBdk45T0drZlRFZz0KPVBBeTgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006cdceb062fac6351--
