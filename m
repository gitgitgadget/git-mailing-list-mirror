Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77F018DF9E
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594762; cv=none; b=bH2gCUhiQmRzanQzztIuuqj9LJWKK5xRkpK08TXzR9RGn4v/k0Em03iMiJpuLrgrPb8IHzgnkC5i4YChqCwCcF2rI71OdTpKlfhnUBoAIaOLsc8GCeUc1fb2DzOyya7A5pTUI7VSbucvgbmWI3yN0rTxTYiJQBIdAfjWAJaFV3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594762; c=relaxed/simple;
	bh=EbowzoWayO7U9C0TBpZPylq5mC1zpBJwRTHx7O7NX5c=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXNoqhA5US50SGWwIeur6HX7YjIxHMvoU6S3McvGcS0eclmULsNrqWf9kOmfrgQ3zSeounXt8IteQPqiP/AjZ15L0GMeD+dtuSsxzPDfK1FuQWCS+nYbUMWdN6bj8pgFCnCqQNZdOr/A2pfzT5RuU4tWnNzkK27Esrc4M6gTzqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjL9nmjU; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjL9nmjU"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-84fd764f6ddso531260241.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594759; x=1729199559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mriETGIu4txh81zUp9Mp/jCI13OuEvLpF/daY6gMOkM=;
        b=UjL9nmjUZZIY/OXz5OP+Y+ZSmAJsyUdVhClcUlScNwGriGBJ/n1SxB1s0juC7hbxNg
         3uk0LD+AsT4E7PTsYlxNo+UCL7kQdygdahtaZK5wNbWajd/j4ifNFTVCKYMaOmRrmzaJ
         qKN4NY3euKVtRqVUj5R6gKRdsXy1Kvn1NbPJu+cDQ7s08DLbWev2sevS6fA3EzRtJvJx
         zReuXdbzvt3t6V2lv6inLZ33CW51vDWpuS3cAxy/HkhWm+b59LBazdjVsUvkAy7K4LSM
         UGXn91f6K0LL1rv/TglmwK4TsqoQEA1NV/2tJPvtYOwv6tU+pwlNmguJJ+bd+6TAg9aA
         xtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594759; x=1729199559;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mriETGIu4txh81zUp9Mp/jCI13OuEvLpF/daY6gMOkM=;
        b=V+XpEdT9r65dERA6Sb8OF73GldCo7CRZKMNeqNMVBtWOyZ06sRd/492LlXNygPnvi9
         GSlMSyOlvHhCL5VceMhxYOvBWMOWw573f7LlHhAYw9sIUWmA12HVSGbPm49M3DvyEhzZ
         +rKtwFlyGIglk9tfGoR1SiHpd16MEZd61g6ONZfi/W8G8u+I1CNLOTSdNuKrvT1woXdY
         iyTHIHsmZETSxoSCVIz8uGgZTk+llE/YYr+NENc+ojwHV29CEvIcOWSPe2Hj3BPVfcw9
         j1IDuxefg33vX39gQw0qLgTPtkY6pc3YKR8jxuYLfaS+FvwUpygy2NqWvvWuB90PGIna
         fy7g==
X-Forwarded-Encrypted: i=1; AJvYcCXXVO2H/yjqac9yTomscduyLj10MRlW6VhaPZ6MGd0jBexhVrHy/b/Sp2vogF77mnEgKAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLRFG9XTm7qfp6vNfkfPGHUGn5TTYdP7kQNPtZvtDQlx2mz9aZ
	FrgYwMFcfVdFuAb0nRluePLL2AlJwNVMy8LU5Npn9Nq7NfjSmgn10CggQqra6xzJ97GcOc148kx
	CCJlBFyG8hVI/Lv7FkykUKfxMAhbsijgo
X-Google-Smtp-Source: AGHT+IF9gg1BdCogI89IqSqUAuzGdZLuu68vSn5AhMVUfGjmwAPjewn53pvAoOJGNAlrsR/1etFt1IlRVRkJiR+49Bk=
X-Received: by 2002:a05:6102:510e:b0:49b:e4eb:37d2 with SMTP id
 ada2fe7eead31-4a4543cb9d9mr4208053137.11.1728594759605; Thu, 10 Oct 2024
 14:12:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Oct 2024 16:12:38 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241010133022.1733542-4-bence@ferdinandy.com>
References: <xmqqzfndndfm.fsf@gitster.g> <20241010133022.1733542-1-bence@ferdinandy.com>
 <20241010133022.1733542-4-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Oct 2024 16:12:38 -0500
Message-ID: <CAOLa=ZQA6vc246LRxW8n+a5qNDGxsSLUAhT-x-9tdAKDb2LBCQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] transaction: add TRANSACTION_CREATE_EXISTS error
To: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, Taylor Blau <me@ttaylorr.com>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000009b7ace062425d4bb"

--0000000000009b7ace062425d4bb
Content-Type: text/plain; charset="UTF-8"

Bence Ferdinandy <bence@ferdinandy.com> writes:

> transaction: add TRANSACTION_CREATE_EXISTS error

Nit: but it would be nice to have s/transaction/refs here and similarly
in other patches. Phrasing 'Documentation/SubmittingPatches':

  It is also conventional in most cases to prefix the first line with
  "area: " where the area is a filename or identifier for the general
  area of the code being modified, e.g.

    * doc: clarify distinction between sign-off and pgp-signing
    * githooks.txt: improve the intro section

So in this sense, it would be the refs area, no?

> Currently there is only one special error for transaction, for when
> there is a naming conflict, all other errors are dumped under a generic
> error. Add a new special error case for when the caller requests the
> reference to be updated only when it does not yet exist and the
> reference actually does exist.
>
> Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
> ---
>
> Notes:
>     v4: new patch
>     v5: no change
>     v6: no change
>
>  refs.h                  |  4 +++-
>  refs/files-backend.c    | 28 ++++++++++++++++++++--------
>  refs/reftable-backend.c |  6 ++++--
>  3 files changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/refs.h b/refs.h
> index f38616db84..166affbc89 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -759,8 +759,10 @@ int ref_transaction_verify(struct ref_transaction *transaction,
>
>  /* Naming conflict (for example, the ref names A and A/B conflict). */
>  #define TRANSACTION_NAME_CONFLICT -1
> +/* When only creation was requested, but the ref already exists. */
> +#define TRANSACTION_CREATE_EXISTS -2
>  /* All other errors. */
> -#define TRANSACTION_GENERIC_ERROR -2
> +#define TRANSACTION_GENERIC_ERROR -3
>
>  /*
>   * Perform the preparatory stages of committing `transaction`. Acquire
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 8415f2d020..272ad81315 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2502,14 +2502,18 @@ static int split_symref_update(struct ref_update *update,
>  static int check_old_oid(struct ref_update *update, struct object_id *oid,
>  			 struct strbuf *err)
>  {
> +	int ret = TRANSACTION_GENERIC_ERROR;
> +
>  	if (!(update->flags & REF_HAVE_OLD) ||
>  		   oideq(oid, &update->old_oid))
>  		return 0;
>
> -	if (is_null_oid(&update->old_oid))
> +	if (is_null_oid(&update->old_oid)) {
>  		strbuf_addf(err, "cannot lock ref '%s': "
>  			    "reference already exists",
>  			    ref_update_original_update_refname(update));
> +		ret = TRANSACTION_CREATE_EXISTS;
> +	}
>  	else if (is_null_oid(oid))
>  		strbuf_addf(err, "cannot lock ref '%s': "
>  			    "reference is missing but expected %s",
> @@ -2522,7 +2526,7 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
>  			    oid_to_hex(oid),
>  			    oid_to_hex(&update->old_oid));
>
> -	return -1;
> +	return ret;
>  }
>
>  /*
> @@ -2603,9 +2607,13 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>  					ret = TRANSACTION_GENERIC_ERROR;
>  					goto out;
>  				}
> -			} else if  (check_old_oid(update, &lock->old_oid, err)) {
> -				ret = TRANSACTION_GENERIC_ERROR;
> -				goto out;
> +			} else {
> +				int checkret;
> +				checkret = check_old_oid(update, &lock->old_oid, err);
> +				if  (checkret) {
> +					ret = checkret;
> +					goto out;
> +				}

Can't we simply do:

  ret = check_old_oid(update, &lock->old_oid, err);
  if (ret) {
     goto out
  }

if ret is '0', it shouldn't matter no?

[snip]

--0000000000009b7ace062425d4bb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e6110cea5ca63f3f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jSVEwUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNS9mQy85YXhSL1hHWDFHNFRBUjdBd09PNTd6R1JPcwpYbC9nSXVGSVUy
T3BvOVBzRnZtVXhPaDRxbVg4eVF5K3JqU2hkcldTdE0wa01oc0tVWTlPL24yT0EvMGdpN0xDCnBV
SzJtcS9HaUpGK0pIWlJLNU00WEQ5bVRXZ2gzQTNneDVQR0grMVhXNTAxVktvUTdJY0ltcG9DV3g1
emVmVXQKZ0pDMGFXUVJhNkV4enRUaXlSUHJRU1hDVTQ5WkZLdzZQRm9SeFBTanI5eTJVZ05XV3lz
am1zcGJObEYyRTdRNgpPRVZsS0k2eWNIQ0cxeThDdFc5bzN6MjZBVjJWMldTS2tUMmNMeDd6Wmxh
aDUzS2ZIRm5xZnVOU0lyRStGNzRaCnM1MzRjVmU1QWZTUTMwSkJaampVWnFmZzAwRWhRUW5reVdH
dkIybzMzaklXVGY5eUN3QlV4T2tzeW1SNmxUN3YKbVhaWmkzU2hZaEY0UXg0ay9PK0lna3U5bXV4
MjcwV21KdmxJN0V6REhBVlVFU0pRalNtQUtMeDh0UWFwRDlzNApBKzFUQ2F2UGV6RC9Vd1IvQndV
RVM4N0F6QTd0MVRWbUwxRXQwb29aekRhQWQvRktKeERWakFNZW5mdmxtV2dvCldnSjVNdGRxK2pS
QWg4SkE5NTcvVU53ekhZc2gzOVFaNDI2bGY2dz0KPW10dTgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009b7ace062425d4bb--
