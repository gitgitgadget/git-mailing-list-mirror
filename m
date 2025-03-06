Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC94C76
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269626; cv=none; b=gENr1IwMB2hWi4AA0pSbQFkq2E9L9IWLy6cNhDlkg1sO1vXhSd8lpse28oKmD3DBb2JzLsslIjKRGbFLdtncrKXdheDs9aKkAHUYyyUTcC2bWFl1ewzc4ixQ779aussOtNB6QnR6jVFRL858HlDBo9dPlOQ3sPtazUqPkL3+FOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269626; c=relaxed/simple;
	bh=paWkiy+ldj47mvIyp5tMoOHuTYthWhLCe5M3uCDyn14=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDyHcZV2FyDpn173t9GlIBR6PEwb+pwsnWyWKhAd+rHVsfEMqhj0JLD6Cga9Z+p6t964yElbCvlJmSnjDNWG+GEbVi+HRq+Fxmc83RNzSRJ/ZNzQXkw+YOtfy9nVJjQsyqS5pNUFMfQriQ4FnLsFR5DHX0rWdC84vnw6EQ/oRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDlPCl4s; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDlPCl4s"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86715793b1fso279696241.0
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 06:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741269623; x=1741874423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GvjZ9Azwz3CCgWPttc85fLdbJoN+HMddIYrTdN4Dji0=;
        b=XDlPCl4snorFhvqjNpyXhnC38mHzrF6seBoJ4+YxYhpTtwZv6Y4avhUduMNRNoHJiu
         0OHJbz31jIMTxkmixrn3o5NpT+/dU5aBPk4ggk1hEzux2WnGcGIK7FJiXWv7yMR93NLL
         EHA0hHk18F9glxcBF9X44QZir5dGIXiLw/xGaz5YLkpxHq90o3v2iN5Ty942V69BNCDz
         6Azqx10EijLiNC88JpxijBzGjVh+gzSHoGK5TVomwazqnA9psvF9Ir+PMU7WpABAfWhP
         O/2VlDoYRK7vvYmhuK+noe56IJpAtTq+BPwXNCi0HLJ6T0jjNdYU0En6FpW1qagzAtQM
         fFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741269623; x=1741874423;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvjZ9Azwz3CCgWPttc85fLdbJoN+HMddIYrTdN4Dji0=;
        b=krbol0CFyvFlwyU1T1dC8tAXIQLLJymvIEszTaMWB/MlDq6a66EFj5TLnvCW0R5w1a
         Id6/ygysHL2/zd24n8KS9FkbN8TrEDTNTCDJ1AI+GUe9vCdZxytVWFx83vDNpotGcnMu
         KomxPXOV9wpukQC5vlo6axqTbBa0gb2NK4IuWjl+SGvLlBFRCfK2QhcTvEYdz80eX4CH
         6W4IFzFFHfke2y8GfT2Tb0OjIHMN09AdNhiStH+sU1BPGJBXwr0vQ1dAXPRpgZij2YsZ
         vecCDwZiFRuBa3jKjY7cd1qm2msCSwP/jvvDSB8bTNK7Qjyw7eAM+YwNgPzmLdeKT6PN
         /egQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvjSEkcIgnGh9F61YGdqcsPGvC99KV5VjMmPUXp5DheOYFcS5f9+U1EIiELDRwXDt8f+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUJU4ZmYBk2ZUF2WRYRMeCTB1fv79g8Fl6b3eDY6QBGB7YltCn
	wWHior7lKTk1f5o/t8hd3JiWq9uK+zOTIC0Z+3c1n2VyTEkJzJ9/+lZGiXcD09lQjMJM1GjIev8
	Tntgl0Qt7CbTRcoMpGTfT2CJOZ9o=
X-Gm-Gg: ASbGncuBcS7jAVMLkhUJl/z41QxBoXto+ZEz4Q+wSMx38T2s7eNFfll8uPAS88nG6aU
	ooeNDE2lKxwiN4nt0XV/LFD0TLaqpRECoQCmwyo8vOKmdCEva7OOBp/JH/lkS3vgs8SWfxwz1Ns
	ILMsaAoM6xvQU4Nw+RLAUH8u5APUU=
X-Google-Smtp-Source: AGHT+IFu4/7EDigVuOZLLWww3TxyiaH/qwdsApmqb+p7Uj0a5cofjgOofptkVxbZVvtR55Bt/7HlkrAW6QDxuX4qQt4=
X-Received: by 2002:a05:6102:6d3:b0:4bb:dba6:99d4 with SMTP id
 ada2fe7eead31-4c2e276d7ecmr4096830137.7.1741269623438; Thu, 06 Mar 2025
 06:00:23 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 08:00:22 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-5-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im> <20250228-pks-update-ref-optimization-v4-5-6425c04268b5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Mar 2025 08:00:22 -0600
X-Gm-Features: AQ5f1JoJt5LRfCi3e1qrLThR5N8HPUcUMqxCZvwZ77R7o2lKfkf1n_6sbKTrmlM
Message-ID: <CAOLa=ZRUxYEOgsMOJCR1WGNFtkP2NU=PykRLCqYvQR=EnuUbUw@mail.gmail.com>
Subject: Re: [PATCH v4 05/16] refs/reftable: batch refname availability checks
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000005d1f5c062faced62"

--0000000000005d1f5c062faced62
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Refactor the "reftable" backend to batch the availability check for
> refnames. This does not yet have an effect on performance as we
> essentially still call `refs_verify_refname_available()` in a loop, but
> this will change in subsequent commits.
>

I thought this patch removes it from the loop. Which loop are you
talking about?

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index d39a14c5a46..2a90e7cb391 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1069,6 +1069,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  		reftable_be_downcast(ref_store, REF_STORE_WRITE|REF_STORE_MAIN, "ref_transaction_prepare");
>  	struct strbuf referent = STRBUF_INIT, head_referent = STRBUF_INIT;
>  	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
> +	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
>  	struct reftable_transaction_data *tx_data = NULL;
>  	struct reftable_backend *be;
>  	struct object_id head_oid;
> @@ -1224,12 +1225,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  			 * can output a proper error message instead of failing
>  			 * at a later point.
>  			 */
> -			ret = refs_verify_refname_available(ref_store, u->refname,
> -							    &affected_refnames, NULL,
> -							    transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
> -							    err);
> -			if (ret < 0)
> -				goto done;
> +			string_list_append(&refnames_to_check, u->refname);
>
>  			/*
>  			 * There is no need to write the reference deletion
> @@ -1379,6 +1375,13 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  		}
>  	}
>
> +	string_list_sort(&refnames_to_check);
> +	ret = refs_verify_refnames_available(ref_store, &refnames_to_check, &affected_refnames, NULL,
> +					     transaction->flags & REF_TRANSACTION_FLAG_INITIAL,
> +					     err);
> +	if (ret < 0)
> +		goto done;
> +
>  	transaction->backend_data = tx_data;
>  	transaction->state = REF_TRANSACTION_PREPARED;
>
> @@ -1394,6 +1397,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  	string_list_clear(&affected_refnames, 0);
>  	strbuf_release(&referent);
>  	strbuf_release(&head_referent);
> +	string_list_clear(&refnames_to_check, 0);
>
>  	return ret;
>  }
>
> --
> 2.49.0.rc0.375.gae4b89d849.dirty

--0000000000005d1f5c062faced62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e8799a2d14630acd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSnFuUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mODUrQy85L1F6OWo1THpZMnV3dlJSTlNXWGRIL0J3NApVNXBoSmJuQmUw
YXkrMmczQzVpcnRVRUd1TzJiZUdvTzBIM1BvS3NiQmlrb0FkdmlmVVd4S3hEaHVuUXFDaFdwCmVB
M2dPSGRDRU1YS21FZEdUbmdvVDRmblo2VVdwUUVqMWtWaktTczAwL1BKQm15SUFJZ1pDdGxlYUxH
UjMrakcKRitsdWhsd3Y4MGNVbWdmLzgrWXpLYTE5V2NIN0xScTU3S0p2cWRMRzRZZGRSUWtMTkFF
N0k0R1FJTnRDNjdIdQpkMjl6ays1VFZ6dVpnQ0REb3RGQzE1dzZUWCtIeldMSkdBcVVSUzBxUC9o
dXJwd21kRkhJcDErZmJrajJ6NTU2CmVLRWs1dXMzREhVQXpKWWxuWFN6dk5XSnVUeklSNlMxejlZ
dWlKbGxpTDZ1MUpYWUw1K2hON28wUXVnZFRBU1kKTWJ4bkJFMWdSYlFESmdNRHI1SjROWEI4RktB
ZGxmMTFDUHpQUitnc0E1eHpPdjBJZWYzVHdnOXZCYi9QWE51VwowVHdpcGxiL3R0dkNVc0JNZHpY
b1gwWEVobU5TNUlOaWlWWFZqRmd6bWJZcEJURGlNNDlIOE5lcVArNVRBS2RBCk5RL0wyWHRNR1FL
OGJDY3ZrVE9pN1BGbFVPbXZiMVlCRW9UendpVT0KPWZmN2YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005d1f5c062faced62--
