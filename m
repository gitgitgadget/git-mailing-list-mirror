Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85246CA64
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270218; cv=none; b=gEZ8Mwph4d9JwM5hFcFAWuniSO9uXZVJApQF/17zmfXijhgXZnBYeNOg3V1Za5FXu8cj91U03WS6rK2+bkdnxu21edDl1YuAeJXIsAeSdEyWIyUR6NOMBYBFH62D3TY77BKOxprR/y0fw/G3VoLbCq0CKtcxm4N9RXqsXKBoJ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270218; c=relaxed/simple;
	bh=lXcrhnnCB57hYje8fMu2Wh79bT0LbeUysS3Md3sUcMM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsMSwTJOAsJlAxKqkUIKmI7R4PDeYd5Z+K0NfgIdFk3qIUXqdDPFe1hM3aLQBJEq67BVyzJef+OTkLc44cHQFQocZdXuBf9apf7W3ZrGMjNrdE5TEtRpLuWgJCxe4aM0335NJRKUB+RvYFSZsPVyAtQ8D/RREa7tYhh0YsHEFpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLEgJK6+; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLEgJK6+"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86ba07fe7a4so546125241.2
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 06:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741270214; x=1741875014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sGrPXVfqbFNi25X/t+JQWagFPLG63PdlQZUOeBqFnsY=;
        b=FLEgJK6+vATksyMud6VSfQPPpG/3UID5Y2H1Z/LocI0YGjk+k7bTCBkpCtKtBXpNLu
         Amgd5bVNeek+HHnuT8u8/AAeFrgGHcOK1MKdeNzOmkua5BthdxEgJ7lgI/bf6C2voCr2
         sPzZ9bairj0M+/P0a4DiKOTqUyOVUl6/EQqsrITap/MLT/FItchLmYS+hEKcO9HhKbBl
         C/ZCmTPhRnyWJsxd4CaTR4ouuWv1NcuaKs1jhMEIocHm3yuiAyZoSzsfamShyBmlo5i7
         hxxnuF7QjFrIloADxMdxZGZ8ANhOVkckBllZsi2Ft/mvpxII+QmG+vvRr8G8wi1TWjke
         eegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270214; x=1741875014;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGrPXVfqbFNi25X/t+JQWagFPLG63PdlQZUOeBqFnsY=;
        b=NbOVUdBcxauGbp20sQ1AEquvMiBjYtOXr5U+1QjvuKRYWbSjTHkZKqyoRI2teWFWFP
         BV4tG/r510a7CcBzbWJSHrRUuM6gq4s19+Hiky4mmureK7AiXrH9Wb1loZmMG+0VgauK
         9ek5JeOKYnOV8AfA3fWi7c+9fuw+Pi65LFyVRqa+tYOIUw3xOTRqtBBTJZQO870YsUow
         Lwtub2ut8yZ7znls9P+lJIrfV/V30NaVuSq9X1I+UZHKHurNWRf0XApKle/n2KxMiJ5C
         GpUbVVZqYQhrm1fk03S/GfB3cks/GHhw52qokNc6eaQb5wsoaSm5oU5PnpFcIeMLJy4E
         j9ag==
X-Forwarded-Encrypted: i=1; AJvYcCUUl4fQ6pMGL57oE3WMBWpQ0Di0cI0XHc62nzNK8lziOcUWXP1V+135SqCI0lunUTMsIXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylqm6LtYydcAUjvf/QGyY6M2BaHJHesmntp+LNTJZtwBioKd5S
	iWzDWEw3Q5eCxDB8BaxML5wyWJ5/d3RyVAXXJ0eW4ka1vZQe/gsPunTXKkaI97rMYLRVKum2yzb
	PiQK2WjgZ63AX+hxfYVwhDs0qciE=
X-Gm-Gg: ASbGnctIo0vW4pZspzYccoE4JahmU1DqHeZqkzonHCP3IcrqgkOwguZsjdWU3Uvo/1G
	JpGo3LBIdhzklgzh1hzGlSpEbmXNvkeE+pwlGjMKHzElyFjdi8Ta0z3Ow0oy6PFdWuEAQcPG+E6
	gT+aIFl10kJaR1LyfMojZgP4f1
X-Google-Smtp-Source: AGHT+IHB3uQ/IfeWL8TjTgr5M2eKKS6n4qT16K+Oif2GCm0ID3sVcWPH6GjsQTKv388jOtl+3JbTlPErkn1h6wkEI5k=
X-Received: by 2002:a05:6122:4d81:b0:520:4996:7cf2 with SMTP id
 71dfb90a1353d-523c62cdb4dmr4235479e0c.10.1741270214262; Thu, 06 Mar 2025
 06:10:14 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 09:10:13 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-7-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im> <20250228-pks-update-ref-optimization-v4-7-6425c04268b5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Mar 2025 09:10:13 -0500
X-Gm-Features: AQ5f1JpIF9Rg8ovx8KslX1xc0K-FgRHL0HYR1lE-X1A2CwhgvG3BxVjY05vd13Y
Message-ID: <CAOLa=ZQAqVZeFhmQbDcT+j9vc0Zn=gSK3rzN-PigL_Bx0J6vPQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/16] refs/files: batch refname availability checks
 for initial transactions
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="00000000000094638f062fad10a2"

--00000000000094638f062fad10a2
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The "files" backend explicitly carves out special logic for its initial
> transaction so that it can avoid writing out every single reference as
> a loose reference. While the assumption is that there shouldn't be any
> preexisting references, we still have to verify that none of the newly
> written references will conflict with any other new reference in the
> same transaction.
>
> Refactor the initial transaction to use batched refname availability
> checks. This does not yet have an effect on performance as we still call
> `refs_verify_refname_available()` in a loop. But this will change in
> subsequent commits and then impact performance when cloning a repository
> with many references or when migrating references to the "files" format.
>
> This doesn't yet have an effect on performance as the underlying
> logic simply calls This will improve performance when cloning a repository with

Seems like this sentence needs to be re-written.

> many references or when migrating references from any format to the
> "files" format.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/files-backend.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 6ce79cf0791..11a620ea11a 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3056,6 +3056,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
>  	size_t i;
>  	int ret = 0;
>  	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
> +	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
>  	struct ref_transaction *packed_transaction = NULL;
>  	struct ref_transaction *loose_transaction = NULL;
>
> @@ -3105,11 +3106,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
>  		    !is_null_oid(&update->old_oid))
>  			BUG("initial ref transaction with old_sha1 set");
>
> -		if (refs_verify_refname_available(&refs->base, update->refname,
> -						  &affected_refnames, NULL, 1, err)) {
> -			ret = TRANSACTION_NAME_CONFLICT;
> -			goto cleanup;
> -		}
> +		string_list_append(&refnames_to_check, update->refname);
>
>  		/*
>  		 * packed-refs don't support symbolic refs, root refs and reflogs,
> @@ -3145,8 +3142,19 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
>  		}
>  	}
>
> -	if (packed_refs_lock(refs->packed_ref_store, 0, err) ||
> -	    ref_transaction_commit(packed_transaction, err)) {
> +	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
> +		ret = TRANSACTION_GENERIC_ERROR;
> +		goto cleanup;
> +	}
> +
> +	if (refs_verify_refnames_available(&refs->base, &refnames_to_check,
> +					   &affected_refnames, NULL, 1, err)) {
> +		packed_refs_unlock(refs->packed_ref_store);
> +		ret = TRANSACTION_NAME_CONFLICT;
> +		goto cleanup;
> +	}
> +
> +	if (ref_transaction_commit(packed_transaction, err)) {
>  		ret = TRANSACTION_GENERIC_ERROR;
>  		goto cleanup;
>  	}
> @@ -3167,6 +3175,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
>  		ref_transaction_free(packed_transaction);
>  	transaction->state = REF_TRANSACTION_CLOSED;
>  	string_list_clear(&affected_refnames, 0);
> +	string_list_clear(&refnames_to_check, 0);
>  	return ret;
>  }
>
>
> --
> 2.49.0.rc0.375.gae4b89d849.dirty

--00000000000094638f062fad10a2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2610163de1e6db0f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSnJNUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMXo1Qy85YkxDbkxKSWtxcVE5WkJUTjNScGdkWGFXUQp6a2tNWFJjb2la
MEh6SUJFQ0I1Szc5Y0hmKzJCWlJPa0wzbDBIOXg4TzBFRW9yZSs2V0tIcWt2RThKZU5kR1krCmlk
d0ZBWnVCdVJiMGlieTUxQlZrbXRod3YrRTYyYy8yMXZKUlBEaHd6YnFBYXQwUllwQ3ljU05YSkRW
aHowTksKdGhaRGcwRmhzUXdIZDlIa1J0NHY4OXVzRGVoV1NHUDdTUUx1MExLM0JILytTTXRrRjQx
Ums5K0ppbWp1dGltdgpoczZDSzJWNlNQN2JJUEJtL3I4YUQ4VXZuN0xwV1puVi83d25GZlVrNEU5
a0UvaXJNa2labEFpS3NweTV4cjZqCk9SVnpoQUhLNDlDQStHNEVzS1YyanljeEI5NTY3ZjgvVUt5
bmFoLzQwL0cvRStSZ0poUTFwcUh4TC9rQWVQOW8KMGZMWDFDRFRXVUtzYThlUHpGSlhNbXJObWpX
UGdJQTF4RE9OSWtXc05pYVRmQ3JJdkZrQ2hIQ2MyT3h3WGJrdApFWW9tbndpamt6d2dSQlRtcHk2
Qjh2clMxcWtnTFpmTlgvSVBpVUF1YzlJRUl5TGNWTU1WT0t1YUZVUkV6bnZhCnkySXhwc2RUUmor
R1B1QUdldm1CN0NvNVUrdjdwclpZRUdkYThDZz0KPXN1RzgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000094638f062fad10a2--
