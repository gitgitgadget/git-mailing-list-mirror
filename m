Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC051CB53F
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804584; cv=none; b=sT1no59P0cUB11rzHMk8o4fldkU1/bqGarsP5WqkdC2UKuuCQCoA/bLMlXX8LdoqnZq5nk84MHpe1kGjB9YjftI8L9K0Dww0eCvyfMuh9i+b4TBd3n5+IbD/jiJxkDLgcXNqbV2bE3LVSzQ7mKqbP1tB4Obnyix6nz+DIUoThIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804584; c=relaxed/simple;
	bh=MTzUB0ANYJ2cgkPROfGjzsYYG9SZhADV4H2oyJb4ilA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=FrrS6TZcXfMWJANeOOH84eBn8oraeqpyL96BBFfTQfY/cUs1vgy/lBeSQVssDgrTlmCgB2gscpMbw07Js0pN5VTdgMDS4p0LKHm7bpKBQouh5L/RhPchgn0O7vsmNGJsBPqEG8jqkj9YpmzUv66XTfelRmAX8f5LZPxYERistfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z82FmGfM; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z82FmGfM"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-84fd2310413so1717428241.0
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 03:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730804581; x=1731409381; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rD3jFptGzub5rCEsHqx7FDWthbdeSirn+CNyk1tyOVQ=;
        b=Z82FmGfMNtZQXCrLcjLVzjcnTVdoUPjWyU6S003kSqADG99VX6WF5zYILPTsTnPXwS
         nRfhHvdmgpQ/cYMFnebOJoZGHxj7Kj8JyUbPpKRkvZuBQ6BRAYNCAqQfLo8EHOL3Kz+x
         z7t1dyIzlrIbUAmnAkW3+j0Q+RMMe89IkGAzGp7b6OnijE8cAobfQhRmmzcbO4Jn9t9+
         sYDF4L7BHrI/FWe40AmPDMY8BuC96aK3oMv774pvyXmXtUKLPGmegqjXLUvLOx4BYC0h
         MJySpY5uKCH5t9jeTRz2+tGD5BBUcwHZLYzxCR+7oqrVF2I1mbuBIMF6LPMKhRK/a1Hr
         U/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730804581; x=1731409381;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rD3jFptGzub5rCEsHqx7FDWthbdeSirn+CNyk1tyOVQ=;
        b=iK2keyzmS6ViwBj7z70+vtWpL8d+3pzgualFayuUrcwW9Al1JaDwb1d/VjAA6etkpo
         818aLQjWWVYLqCH46P/+DTuJFtqNn8YPQhzdvH9jpTuJVoNN/NZelmZjLWVrel1VLMM+
         NnwEtrON8kRsFOmLIxl5LDCo/zJTLo+EzMIcKETIySCnYPM5MeUj/k7rqtdJmA7JvsJs
         SNV78wA0i0AX9H/dqgLCx5XiZfHldiguybIxaBiY+m5D7UmJ0RlOBDrExXsoPz8P7mO+
         T3d4qfHI/Pv2hnhrAOWIQQMDQEGm9mNuiKW1OSgHxK/ehFjlRji+VQs9T2U2WWhuH8V7
         eJVw==
X-Forwarded-Encrypted: i=1; AJvYcCXrh8+BB1C+U4BGkY9uuPBGHC3ttDbim/INWtnbG3K0tCczMw3UZUQqREMYvRQjFeKLCWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwovfiByvZEkTGBvk6wGKL0IEj7uwYb71I5Mw5nDA7aTGU3ji90
	g19bpG7HiSzgDlWe5SaRrZSp8CLd7WhwcVJOifEINsQ+3mKIU6YluNFnTKcqO4Q+VKBgxYaUilF
	dd8kKtmDa4Hoh3tfnTDt90QRhQCgltiQd
X-Google-Smtp-Source: AGHT+IG33gTmxhJv6y+BwdqUS7pXSfUTLED7hLQlBYMbun6ZpJx+sH6rmQnVzsXdqjbdrHZbDzh3aHU/zXi0xBuMPdI=
X-Received: by 2002:a05:6122:17a9:b0:50d:4257:5bde with SMTP id
 71dfb90a1353d-51015027590mr30510765e0c.5.1730804580965; Tue, 05 Nov 2024
 03:03:00 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Nov 2024 05:03:00 -0600
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <b599bcdac191fd3cfb7797accebd79211e757c47.1730732881.git.ps@pks.im>
References: <cover.1730732881.git.ps@pks.im> <b599bcdac191fd3cfb7797accebd79211e757c47.1730732881.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 5 Nov 2024 05:03:00 -0600
Message-ID: <CAOLa=ZR89CRuJ7nwBfbGhi-wFuwEc96qNoid8sNKHD5ssmrOXg@mail.gmail.com>
Subject: Re: [PATCH 1/8] refs/reftable: encapsulate reftable stack
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003980e60626285850"

--0000000000003980e60626285850
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The reftable ref store needs to keep track of multiple stacks, one for
> the main worktree and an arbitrary number of stacks for worktrees. This
> is done by storing pointers to `struct reftable_stack`, which we then
> access directly.
>
> Wrap the stack in a new `struct reftable_backend`. This will allow us to
> attach more data to each respective stack in subsequent commits.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c | 129 +++++++++++++++++++++++-----------------
>  1 file changed, 73 insertions(+), 56 deletions(-)
>
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 38eb14d591..43cba53cb1 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -32,6 +32,23 @@
>   */
>  #define REF_UPDATE_VIA_HEAD (1 << 8)
>
> +struct reftable_backend {
> +	struct reftable_stack *stack;
> +};
> +
> +static int reftable_backend_init(struct reftable_backend *be,
> +				 const char *path,
> +				 const struct reftable_write_options *opts)
> +{
> +	return reftable_new_stack(&be->stack, path, opts);
> +}
> +
> +static void reftable_backend_release(struct reftable_backend *be)
> +{
> +	reftable_stack_destroy(be->stack);
> +	be->stack = NULL;
> +}
> +
>  struct reftable_ref_store {
>  	struct ref_store base;
>
> @@ -39,17 +56,17 @@ struct reftable_ref_store {
>  	 * The main stack refers to the common dir and thus contains common
>  	 * refs as well as refs of the main repository.
>  	 */

Shouldn't these comments be updated to say s/stack/backend, while the
backend contains the stack, it is confusing to read stack and see
backend.

> -	struct reftable_stack *main_stack;
> +	struct reftable_backend main_backend;
>  	/*
>  	 * The worktree stack refers to the gitdir in case the refdb is opened
>  	 * via a worktree. It thus contains the per-worktree refs.
>  	 */

Here too.

> -	struct reftable_stack *worktree_stack;
> +	struct reftable_backend worktree_backend;
>  	/*
>  	 * Map of worktree stacks by their respective worktree names. The map
>  	 * is populated lazily when we try to resolve `worktrees/$worktree` refs.
>  	 */

Here too.

> -	struct strmap worktree_stacks;
> +	struct strmap worktree_backends;
>  	struct reftable_write_options write_options;
>
>  	unsigned int store_flags;

[snip]

> @@ -772,14 +789,14 @@ static struct ref_iterator *reftable_be_iterator_begin(struct ref_store *ref_sto
>  	 * right now. If we aren't, then we return the common reftable
>  	 * iterator, only.
>  	 */
> -	 if (!refs->worktree_stack)
> +	 if (!refs->worktree_backend.stack)

Nit: Not your fault, but this is misaligned no?

>  		return &main_iter->base;
>

[snip]

--0000000000003980e60626285850
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d8d6d70403975412_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jcCsxMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0NFQy85MXpBQ2drWGpuQlhWaFJnd2J2ZXIzYXZPOApPRFNCdlNyaVlh
TDBCN3UxK3owNUJZMS9xb1RVR01TVjMzNjZhcXNwZHZwdDlHU0tKMjFjS3hHbFlmVXl6QVFhCkhK
bE5WSFFZS0tnaUlmYWlVTy95UEdGK1lrOGgyTDdlRnVTVUR2b2hZNi9tYi91OWNiM2k4Rlc2bVpY
WmowYksKMlhDVmd4OHUyR1RDWE14cjlVdUJEN1ZPQjZWQ1FPU1BXRzFaLzlLaytCQVVkSThNNGZV
OEptSXIxWDZCNUV1ago2Y0k3THhmRlhOU1daMElFdWtETU53MWQvMEZEM0hKSjNQWFVrbkNPa2hP
bWwrYUloTEl1ZTVCZU1qNkh3UExxCk5PcFFuQzgzUGJHbmZDMkQ1VDJUc3IyT2FxQ3h3VG42bERa
ai9YSlNNQ1ptNjN2TEpSRnNxVGtlOVM5dlNBL1EKQ2JnMnJhRWJXNkt3QmdoVDI0cnpvUWM5aUxa
ejhJUTJsa2hBN25OdlpHTllOVWtYOURTTzNDaFZqTTRlMGlwMApKZmpWZmNNaEIwNFMzVTdaRlha
eElMZHoyczZjQ1N6UHlRbEtvQ2psQkpSeThLMGI5VjdIcDZuRzgvd1NzcXRSCmt4ODVhbzJVTlow
Zk5vT3NmeHZQYWVScmdGU2w4clRWZFJjU21yQT0KPWdJNFUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003980e60626285850--
