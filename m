Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052A81474B9
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322392; cv=none; b=q9DOhg8zSsEpfOJu2PX1zk5MywwKY40Azqg3T64Mh9ddDnNFYwKd/43iS0AsN8LirlVadirClJscTM0lNnqZXXL9AKj/GndaNuInfQ0VOFNw+VubbHvAujjW8Mk8uVRT6vVV5vLPQSjMgK5WlwNzIHoH3Y3QIlaAv86z/qXhGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322392; c=relaxed/simple;
	bh=2E3KFmB/ttJ0NjeHy09hAJAyrtN/5M/2tUWXVrbA5+4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=YnSVcHq5X0ExVrn53QfqxM16FKkGeOXLreuWmH1k8U4RF/SxFYihed+CjZ20+nB4z9Ueqip0RqPZjB+Sfan9d1vky734JPgBSo/9CCr94A/PwOsnk97TriEc9k/8jTio/XsJG45veCurCZc7WVjIXaK1BF2TRfKCQ5rbifgLNlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agUgLmny; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agUgLmny"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-50d431b0ae2so4163147e0c.1
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 02:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731322390; x=1731927190; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wtftw+iV+uwCERPohYEwK1HBxIxVXuVkAUQo6/Fzz+0=;
        b=agUgLmnyvyeymLnxGumXhl0pvgINnFphXUy6/jige7V33elHIpj/CK7/kB9Varg5MH
         bbTgCKrhRAv2WXtko60O0BisixJL0dH33FvPxaen/X8zx5epdVfkn1a5e0XFVNOAsj/j
         k4wE53txgGGpGTHjeNFpooskQ7j+f8YzbN/O4WRL7GNcJotPMIfaNRzls1pPlSPJ8Oqm
         Mxfsw6JJMJ3FAlt9DEWy05wtA5aEK4dcXK3UKCcw3uKBP+ovBfU+irjVt0vcFm9Sr2Sc
         0o1T4DKUU/gH6MNwHXAVU/JwOx5uKypA22mZfWI5FQZitirytrh9y6C5Vvlb0yjvTro/
         n7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731322390; x=1731927190;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wtftw+iV+uwCERPohYEwK1HBxIxVXuVkAUQo6/Fzz+0=;
        b=sYF5HT6ve7GRSZUTbcOVhDgleC4PS4+qPpOegDqy/MVwpDZdFLCdCz2IlCVStvLacl
         KpXBr7fP6RtNJ0rFURoOjrsmY3Bxk61B2Jv6phxlA4sq8Ex1fPi7furtY/9YRGKLrxY2
         Vr4mE7s+ZT4cU2inVkxtsR1m/bnxDKq1kvu+9qxgR+sps/6e8U0mafsm9ww/7R7VKOFO
         Nm6O3q+U71GZpzEGrWaGSftFVsMiF/HHjbsJ1DUzYYoUTcExgaTqq2Ob/t0o7OLQx4I1
         78NZ4urCTSf2ym0x2MKFvttCpUCYDIAz+IpTf75848TNrJ7cBDHfoHaXHRe1sqMUSPTu
         LCCw==
X-Forwarded-Encrypted: i=1; AJvYcCW4G1lRil84ClufrGSAF+VQ7CcJGb9X01AeqY89sjOo+eKMaFyZh2lqPhCVNF4WITwUd2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN6z9biPlcrwXostawiwBUdHjWbySuW93ZJF3wQRa5msOZnzuF
	/0JQrd1R/K+zYmXY92IS4cO7Afuqigk7qNDSOy1eXQPq5WNXmg1bzrLsWJDFQOQXdDJ979mL1IA
	FQLawAU9qTtIrPykSv4ecJkRf09JmYTBb
X-Google-Smtp-Source: AGHT+IEKOawxszMOIH0H3VX8CWtVqQGcx1eBoOlRMt2vMgF4wwI9GGRKj4v+Gog30zk3OvtwV09KqMfYJ6CX+hOAnBA=
X-Received: by 2002:a67:eb18:0:b0:4a4:71e5:eb76 with SMTP id
 ada2fe7eead31-4aadff4decfmr9423948137.10.1731322389747; Mon, 11 Nov 2024
 02:53:09 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Nov 2024 05:53:08 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241108-pks-refs-optimize-migrations-v1-6-7fd37fa80e35@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im> <20241108-pks-refs-optimize-migrations-v1-6-7fd37fa80e35@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Nov 2024 05:53:08 -0500
Message-ID: <CAOLa=ZRrPx2BMe+b3iOQMK9U+GiY6UVYpRJyqxrUamAG2b2EYg@mail.gmail.com>
Subject: Re: [PATCH 06/10] refs: skip collision checks in initial transactions
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000087b520626a0e8d9"

--000000000000087b520626a0e8d9
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/refs.c b/refs.c
> index 0f10c565bbb4e0d91210c52a3221a224e4264d28..d690eb19b3fd7083a5309deb98738547e4f48040 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2324,6 +2324,7 @@ int refs_verify_refname_available(struct ref_store *refs,
>  				  const char *refname,
>  				  const struct string_list *extras,
>  				  const struct string_list *skip,
> +				  int initial_transaction,
>  				  struct strbuf *err)
>  {
>  	const char *slash;
> @@ -2332,8 +2333,6 @@ int refs_verify_refname_available(struct ref_store *refs,
>  	struct strbuf referent = STRBUF_INIT;
>  	struct object_id oid;
>  	unsigned int type;
> -	struct ref_iterator *iter;
> -	int ok;
>  	int ret = -1;
>
>  	/*
> @@ -2363,7 +2362,8 @@ int refs_verify_refname_available(struct ref_store *refs,
>  		if (skip && string_list_has_string(skip, dirname.buf))
>  			continue;
>
> -		if (!refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
> +		if (!initial_transaction &&
> +		    !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,

Nit: It would be nice to have a comment here, perhaps something like:
     /* in initial transaction there are no refs in the ref store */

>  				       &type, &ignore_errno)) {
>  			strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
>  				    dirname.buf, refname);
> @@ -2388,21 +2388,26 @@ int refs_verify_refname_available(struct ref_store *refs,
>  	strbuf_addstr(&dirname, refname + dirname.len);
>  	strbuf_addch(&dirname, '/');
>
> -	iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
> -				       DO_FOR_EACH_INCLUDE_BROKEN);
> -	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
> -		if (skip &&
> -		    string_list_has_string(skip, iter->refname))
> -			continue;
> +	if (!initial_transaction) {
> +		struct ref_iterator *iter;
> +		int ok;
>
> -		strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
> -			    iter->refname, refname);
> -		ref_iterator_abort(iter);
> -		goto cleanup;
> -	}
> +		iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
> +					       DO_FOR_EACH_INCLUDE_BROKEN);
> +		while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
> +			if (skip &&
> +			    string_list_has_string(skip, iter->refname))
> +				continue;
>
> -	if (ok != ITER_DONE)
> -		BUG("error while iterating over references");
> +			strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
> +				    iter->refname, refname);
> +			ref_iterator_abort(iter);
> +			goto cleanup;
> +		}
> +
> +		if (ok != ITER_DONE)
> +			BUG("error while iterating over references");
> +	}
>
>  	extra_refname = find_descendant_ref(dirname.buf, extras, skip);
>  	if (extra_refname)
> diff --git a/refs.h b/refs.h
> index 024a370554e013d66febee635e4c0415ba061fe6..980bd20cf24e15144aeff991eeba8b27a936d386 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -101,13 +101,16 @@ int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refname,
>   * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
>   * "foo/barbados".
>   *
> + * If `initial_transaction` is truish, then all collision checks with
> + * preexisting refs are skipped.
> + *

Okay we have it here, so this should do.

[snip]

--000000000000087b520626a0e8d9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 68f51ac4dbabc587_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jeDRoTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkQ1Qy8wYk4zNVBsNDlYZ3lvTVR5eVpoSHBydFZUcgovWFRQVFphMWVq
Z2hmQzVTWHVmYkVERDlYOGpCa0diSGhZY2REOXlIbEQwWmtaUE5YQVJSWDl0MVNJUUVDd3ppCm9G
a3l0blpYUDdjQjZXd3lMZFQ2NWVDc1pKeTR5bjFxREptNGJ6NnVoZ3l0M3FncnZBcVBoV0R2R0Rq
dE4xalEKOXlxSWlOUms1WlRPOHdCL2x6SkFtT3RORDY5VEJvdXNWZzF0QnlFOEtUNjJzT3dqT3ZG
cklGSzFDdU9maHVLZQp0UlJ5NGVLcEs5T2VpRFVXMlZObjVhbk5aTTArSlVVSWk4cGdVU00wSFlm
eDVoRmR5Mm16ekpZQWdldTF2OTNOCjZzdVZJRWpwMFFaaDY0OU5WT2RhSmVGUExDRjdBalZQYlFI
alBvMXhJUDFtZXI5NWwxQXBkUTZCckRPaG84RmoKM0ZpLzNJUmVrOGg4bVg4UDMrWCtIcDBWbVkw
L2ZIN0IyNndyMFlsaTRMRHYyWGxVU2JBYmVRVmQzakJvcmpodAo5YXh5cjQycnRldkNEVE9pOVFs
c0RWT3V1ODVZSDhBdmFMWkM2VlhaTlE4L0ZxczJsZVV5WFhvaHBnY2Rja2J4CmJlWmhlWDg3MDU2
bnM2cFRadHR1QUtOUWxjd0o3OHQxSnV2N3ZUTT0KPSttN0QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000087b520626a0e8d9--
