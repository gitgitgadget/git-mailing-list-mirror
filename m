Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A1321CA02
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524797; cv=none; b=BPuFsvSu8iQHZiZldUDf2kLhd+BTclrR4jQ3uUEYFzWRCa7xEtUIvmIbjh1b4SOe4EWB4gdaC20NTAPbTRydO49kB+dip9nkctW2YGhLwmFeyazahYNKHGJDHVEKNyqhuXliuzTQG93lrOFTqP0DZbH0u7JEeBkQVWZ3UcAYU6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524797; c=relaxed/simple;
	bh=2lj8zb+BLQWszTun3CYV68KjH97nc5VvfUNQnuwS3BU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IlhHEhVYQOvoKt+ffRMoJN83+KScqQM3HMKopksBcTTjAF8AroI0Ucfr7K6Hl4iFH98tcbQFw6MI5yT8DYUQLqu1TZ4r9WJcsN8QOPITXeZVQjeOxZmRxIzpW3SFe+DXJiel+yUJJl9VSx08Rapf7pwanxURfc9mIAaGpYsoVss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jz4BKulR; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jz4BKulR"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-51f405fce23so559694e0c.0
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 01:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739524794; x=1740129594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dChpWPcGw3K9pCKGYYWQ6317gn3R+zIg54rGnV3owC0=;
        b=jz4BKulRR91R6r9Sixa/s8x1IxxfxgifGhYT7vqEXFOWcKDYlSfmosOYx3H+aCL6kd
         8AbE5oUiKFaYa0edPF/TnKoIyIHvTfQFoL/jWo0/Eii5LH3nv6e9KcOXTgSeEIwUSett
         /wlHmQNaQ34bcLU/pGU6VooT+W0DXAt66q6Uc3X45lMxXukOia3sDsi0K3nHWtQoFO0u
         /xi+mYE4lntTBvA3GlzdeBrRXZuzKwyu5yECsNlUS90rWzKHsgrKwKrAARfvi/lvCrpy
         gNYa4DAvsq3wPmZsmn2jipm13ZJqxQwtjk6ckOTByg4qA4LHz7uqKihzAWlmuEBpYthK
         +P4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524794; x=1740129594;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dChpWPcGw3K9pCKGYYWQ6317gn3R+zIg54rGnV3owC0=;
        b=PyEp4JJIH3+OryaOZ+kJMbqKlasj5qFSeKluVqhxQsiJFuXz9Z6GcFgcpsf9kOMWWI
         Z9Zlg4jMwqc3BG5ZSgdRYbknkdh5vj5KTduXp/C2pxfh0B3gbp6Bs156Vm1mGcefPgc2
         HpQVIhqVDE5qo4eOMyJ+X/Nk+3acyWvl62i04y9jxYAN5DqHWyv/rJO3TSP7nJqlgcoA
         eUfQ/XVK2nPTO4VdLFNGLQPPzoHY/hDW1R8yhEwB2mnFFFOCO6+Az9Onx8iB7tyB2xo2
         rZu4AW1R2Zyy9LRU/SdUsibN0te7TsjBkbt+8SqmfVeq0MLqwFhRyxC4BnHtobz5K6E2
         wbaw==
X-Forwarded-Encrypted: i=1; AJvYcCXxK0J0cMEaY9hBKHqGWNLER3y5TWf1Zqz8aFmxVIBy/GkytKoOur6ah8oPq56TSro+djw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIBUSlyW4uk48SrSqMHj0d6o8bGnVYfgpCY8sMLhjCJ1ZxtX8J
	Psvq9nusfajiqaN12GBeG9l8EAVPzguMGRCdG/VBUnp+Y8vOz9C2ejxWA9f10CGr4H4XNoCpGI/
	SBpKB6sLzfFs83N6LhnKilpdH+28=
X-Gm-Gg: ASbGncuOEuEqXy8IkxwU79QZ6WeSh9gYlfypeFvPLa+YmpUXHkV0jKVT0OA7QJtjyvS
	xco9N0GrrMETELuuzQgI37KHWMNI30wYREsA90ZPSBfNFQ34RYp9+OjIC2eG/vIaAU0yNadiLqQ
	==
X-Google-Smtp-Source: AGHT+IFDsxAmsMvOlaj1uYLoHmJh0403Tb3rJG9zvjjnCbN7krBJtyE9IPQPLFwf3zBTkBJxFGnbPOjSYsLFpzQMzRw=
X-Received: by 2002:a05:6122:202a:b0:520:3536:feac with SMTP id
 71dfb90a1353d-52077fbe78bmr4420912e0c.11.1739524794196; Fri, 14 Feb 2025
 01:19:54 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Feb 2025 01:19:53 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z67L_lmCd6NNXpWZ@ArchLinux>
References: <Z67LkxAFIAeaYr0U@ArchLinux> <Z67L_lmCd6NNXpWZ@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Feb 2025 01:19:53 -0800
X-Gm-Features: AWEUYZk0CnkXNjsGM_jWJTRq7j8cZKKNgXUJ7kso4BqpX8JhAUBICIWT_oHFvdc
Message-ID: <CAOLa=ZS3w3KkEoQksXZtLYCT6BJVs6o2+nmpVUapbnqVA4zfng@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] builtin/refs: get worktrees without reading head information
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: multipart/mixed; boundary="0000000000006fd664062e16ad36"

--0000000000006fd664062e16ad36
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> In "packed-backend.c", there are some functions such as "create_snapshot"
> and "next_record" which would check the correctness of the content of
> the "packed-ref" file. When anything is bad, the program will die.
>
> It may seem that we have nothing relevant to above feature, because we
> are going to read and parse the raw "packed-ref" file without creating
> the snapshot and using the ref iterator to check the consistency.
>
> However, when using "get_worktrees" in "builtin/refs", we would parse
> the "HEAD" information. If the referent of the "HEAD" is inside the
> "packed-ref", we will call "create_snapshot" function to parse the
> "packed-ref" to get the information. No matter whether the entry of
> "HEAD" in "packed-ref" is correct, "create_snapshot" would call
> "verify_buffer_safe" to check whether there is a newline in the last
> line of the file. If not, the program will die.
>

Nit: while the second paragraph above makes sense in the context of what
we're trying to achieve in this patch series. It doesn't make much sense
for this patch in isolation. Perhaps we want to give some more context
around what we're trying to solve for in the upcoming patches and hence
how it hinders that.

> Although this behavior has no harm for the program, it will
> short-circuit the program. When the users execute "git refs verify" or
> "git fsck", we should avoid reading the head information, which may
> execute the read operation in packed backend with stricter checks to die
> the program. Instead, we should continue to check other parts of the
> "packed-refs" file completely.
>
> Fortunately, in 465a22b338 (worktree: skip reading HEAD when repairing
> worktrees, 2023-12-29), we have introduced a function
> "get_worktrees_internal" which allows us to get worktrees without
> reading head information.
>
> Create a new exposed function "get_worktrees_without_reading_head", then
> replace the "get_worktrees" in "builtin/refs" with the new created
> function.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  builtin/refs.c | 2 +-
>  worktree.c     | 5 +++++
>  worktree.h     | 6 ++++++
>  3 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/refs.c b/builtin/refs.c
> index a29f195834..55ff5dae11 100644
> --- a/builtin/refs.c
> +++ b/builtin/refs.c
> @@ -88,7 +88,7 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
>  	git_config(git_fsck_config, &fsck_refs_options);
>  	prepare_repo_settings(the_repository);
>
> -	worktrees = get_worktrees();
> +	worktrees = get_worktrees_without_reading_head();
>  	for (size_t i = 0; worktrees[i]; i++)
>  		ret |= refs_fsck(get_worktree_ref_store(worktrees[i]),
>  				 &fsck_refs_options, worktrees[i]);
> diff --git a/worktree.c b/worktree.c
> index 248bbb39d4..89b7d86cef 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -175,6 +175,11 @@ struct worktree **get_worktrees(void)
>  	return get_worktrees_internal(0);
>  }
>
> +struct worktree **get_worktrees_without_reading_head(void)
> +{
> +	return get_worktrees_internal(1);
> +}
> +
>  const char *get_worktree_git_dir(const struct worktree *wt)
>  {
>  	if (!wt)
> diff --git a/worktree.h b/worktree.h
> index 38145df80f..1ba4a161a0 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -30,6 +30,12 @@ struct worktree {
>   */
>  struct worktree **get_worktrees(void);
>
> +/*
> + * Like `get_worktrees`, but does not read HEAD. This is useful when checking
> + * the consistency, as reading HEAD may not be necessary.

Checking what consistency? We should be a bit more verbose here. You can
mention that skipping HEAD allows to get the worktree without worrying
about failures pertaining to parsing the HEAD ref.

> + */
> +struct worktree **get_worktrees_without_reading_head(void);
> +
>  /*
>   * Returns 1 if linked worktrees exist, 0 otherwise.
>   */
> --
> 2.48.1

--0000000000006fd664062e16ad36
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bee92e81b0bec1ec_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ldkNyZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlRMQy85bm9KS2JvZXhKNXk3OTlPSm5vTlVRY292dApTd2N6bSt2UEtV
NGZ6Qmx2RmdpSVRCd0V6aEw1UWowQWlGYm85WHdwYmVVbzFnZmNoQktEY1h5VG1hZU0zRE96Ck9w
K1hTd1BFc0lGNnFDUlJmK01hWURSNk8vUGY1QlZrSjVMSEpBeDgybVM4Ky8xeGpVelRhdXF0Y3hr
bEgxeTcKRkVabkpKWURiaGVKNnBZdVoveExST3BsZ3Vyc2cyemlnSm9iZVV0SU1CKzRIdzZHZkpj
MEZMY1pTc0hxREloTwpkM08rcFNqdlVZMXIwa3ljUXIzZTJYTytMM2QyZzdVSlRRT3ZISk9OWnhu
MldTM25Gb2RZYldQL2o5Umthd3U4CklmRDRHZ1ByZFlYcks5ejk1YVRwU2xXVlBVSVAvY05EVUZr
M05tNitONTBUblhJQ3NwcTg0d3Q5TFRvUll2ZUwKWXEvZmhScHBiaGZtaVJzQ1FITXFJcEI3Q20r
M2xUZkpoN0dxbGdPa0k2YVU5OTFmdUJQdGhJaC9Rb2UxWnlqagpDRjl1OExkVXJ0YXRtYTlnSjVh
TWtWZENYN2pvejRTSU01L2JTTWNmV1dQUHg5N2llUWhnd1JKZjBQS3V1L0xPCmlER2F5cUhZakVL
RUJHVWFHSHVudnp3RTQ4L2RHODMyL2haTHIwbz0KPUF3d3gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006fd664062e16ad36--
