Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3ED1459F7
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895129; cv=none; b=A4aXKPREP/ZnFJ9iuHLX6r0dPgG8Jwc8806uprGanTRKcB5YdHnGWHyjL/ot/SbsuCiQ+utMxF8+Fn2RJYL5kL53nkKuNZcS4G69ZAqX5jQmvbaQmxpeTTK7BF69oqgTt49AK85fiPjs4EPOX0U6Ab6l9rIaz4y2NJL2JYsduUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895129; c=relaxed/simple;
	bh=cKUPdEAMAwFNXB3QexHZmsFS3z8V99hJBQIBs6UI0WI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDFhVJw002b2Ndtg1NFvpJYWXvspQh01J+Wlb89r/g+l75oIf8DvLn7DtwjDWvDtRrpyfKfZDCAdvKeyPkfZwT6Dv7JxUc3h0BypEoOth+eex3OOJhKmfzREfDF7YEuvmmMa/u4UN0xTCXZ5jXqRoU8y1hrB0ld8gGweLSB9dqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFExw7lW; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFExw7lW"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso100586326d6.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 08:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739895126; x=1740499926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=t7jLDtwEBp0fTLY+52z2kFGsdtWvpMYgMBTe6EGlg+c=;
        b=TFExw7lW1KTZ5716VyQQ0qVyh13asHf5xrqfGFdQZF0dYNZIiKn66RdmoFqpkSwmqK
         p+6ec75PPq8xtg6VpwDd1epeOfKjP5gIq0Ylrg/rugUEGE50pMf8VZBV+ZDwPalAaQ9m
         Wc7gW/ub59Z8ixz2xKxkLiBRrFd/6pXTXUflP5xIReS3RVzyMUSHdEYg16jTt+ua8ko/
         tmI0BFYcYuB/kUvro3Y6oCQ3Sx7Rjwyg3jPhR0RgZZfO0cUP0ew4sb/Nqxq3ksiGDK0J
         QdWIQmbVvW9rWJDddLawqxGmPyZRStLPZebnpzPayMargJ73e2tKHAKwxCmpfQCCOdnM
         0osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739895126; x=1740499926;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7jLDtwEBp0fTLY+52z2kFGsdtWvpMYgMBTe6EGlg+c=;
        b=ADqKrTdTQo/mcTMAzbUrYCpdOabg1imJOZWhvaAbSbYyQMJZmyq484HSA/QnvDMiyy
         8e/q1u5H5xvCMq3fadtD27DmxCHWVyqcILMZ/WKfo0hdorupHD3Pf582Vexbf0K5EWBO
         GcWb5hA8m5k7BBI+OPbdhKHF8oazYirPDhVRIgj4Bqkmm0MNr/aCH4Hyf8Dbn3TZJVUk
         PtgZlJr/hLdZckuTZqYvwAROqEgbUY4LBYLNRR36jOuewhujvj7syZzpuEl6slxVTBai
         bPuqQgvM6eoEZ3F18SHERwZHnljPqREY0cViT8BdR1YsTRYqbH8b7CVQ9fI5pkIW0/jZ
         DnkA==
X-Forwarded-Encrypted: i=1; AJvYcCV9JuziGtm/EQjTETHqnIF8V6oZiu+7niQPzxC5bcHFGGP5awcAuqZbrnlSYBSjFkKQypY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC19iOcSsLp2Ef0yz0fVAEmiVpjsrjDAuHuZnIiyf43+1hpZr6
	G/aM6vaf8s4neJwiZU3RNAjmzZkZFtu54VPWzTCv1jdQHSqkwGIzPzLDkQPtpXMnNBmlLLItjLc
	nbyTL5mOz7w4mX4xzr/j5t6TjlnRKCdYn
X-Gm-Gg: ASbGnctX8qHG0Dqcx3ioBESQy0gW14jQnnEwql506KoGge7wPoeM2cAE8AP7IHOSkkR
	cfhq89ltnPB4Mp75LAeteYcg1cwQv2gVScEeeYfUJ5otk8ulYzjBooAxhcNTYhRXTQYgyzJk5vq
	rrV1FnFfXOr/Wy41jjiQMSJ1uZb4Ypemw=
X-Google-Smtp-Source: AGHT+IGBnZsN/VuNtinHzd35NuSFyff3zeIXlgbA0dV5kG1V4yF3vzDw5Hpa60hZZQp3qFsfD6VVJMVh1JFP6dGgqNs=
X-Received: by 2002:a05:6214:1d2f:b0:6d4:1ea3:981d with SMTP id
 6a1803df08f44-6e66ce28bdcmr213347236d6.43.1739895126273; Tue, 18 Feb 2025
 08:12:06 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Feb 2025 08:12:05 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-6-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im> <20250217-pks-update-ref-optimization-v1-6-a2b6d87a24af@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Feb 2025 08:12:05 -0800
X-Gm-Features: AWEUYZlMx2DraPbvLWVZhIgF0G4uq2ceTH5O01yzC6pcrT4ES4DmILM8gxb-LNI
Message-ID: <CAOLa=ZQC+UXQGjOqot=pTopkd8mOjduixQ=rBnsis9g_3_HOqw@mail.gmail.com>
Subject: Re: [PATCH 06/14] refs: stop re-verifying common prefixes for availability
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000f30a3b062e6ce62e"

--000000000000f30a3b062e6ce62e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> One of the checks done by `refs_verify_refnames_available()` is whether
> any of the prefixes of a reference already exists. For example, given a
> reference "refs/heads/main", we'd check whether "refs/heads" or "refs"
> already exist, and if so we'd abort the transaction.
>
> When updating multiple references at once, this check is performed for
> each of the references individually. Consequently, because references
> tend to have common prefixes like "refs/heads/" or refs/tags/", we
> evaluate the availability of these prefixes repeatedly. Naturally this
> is a waste of compute, as the availability of those prefixes should in
> general not change in the middle of a transaction. And if it would,
> backends would notice at a later point in time.
>
> Optimize this pattern by storing prefixes in a `strset` so that we can
> trivially track those prefixes that we have already checked. This leads
> to a significant speedup when creating many references that all share a
> common prefix:
>
>     Benchmark 1: update-ref: create many refs (refformat =3D reftable, pr=
eexisting =3D 100000, new =3D 10000, revision =3D HEAD~)
>       Time (mean =C2=B1 =CF=83):      63.1 ms =C2=B1   1.8 ms    [User: 4=
1.0 ms, System: 21.6 ms]
>       Range (min =E2=80=A6 max):    60.6 ms =E2=80=A6  69.5 ms    38 runs
>
>     Benchmark 2: update-ref: create many refs (refformat =3D reftable, pr=
eexisting =3D 100000, new =3D 10000, revision =3D HEAD)
>       Time (mean =C2=B1 =CF=83):      40.0 ms =C2=B1   1.3 ms    [User: 2=
9.3 ms, System: 10.3 ms]
>       Range (min =E2=80=A6 max):    38.1 ms =E2=80=A6  47.3 ms    61 runs
>
>     Summary
>       update-ref: create many refs (refformat =3D reftable, preexisting =
=3D 100000, new =3D 10000, revision =3D HEAD) ran
>         1.58 =C2=B1 0.07 times faster than update-ref: create many refs (=
refformat =3D reftable, preexisting =3D 100000, new =3D 10000, revision =3D=
 HEAD~)
>
> Note that the same speedup cannot be observed for the "files" backend
> because it still performs availability check per reference.
>

In the previous commit, you started using the new function in the
reftable backend, can we not make a similar change to the files backend?

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/refs.c b/refs.c
> index 5a9b0f2fa1e..eaf41421f50 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2476,6 +2476,7 @@ int refs_verify_refnames_available(struct ref_store=
 *refs,
>  {
>  	struct strbuf dirname =3D STRBUF_INIT;
>  	struct strbuf referent =3D STRBUF_INIT;
> +	struct strset dirnames;
>  	int ret =3D -1;
>
>  	/*
> @@ -2485,6 +2486,8 @@ int refs_verify_refnames_available(struct ref_store=
 *refs,
>
>  	assert(err);
>
> +	strset_init(&dirnames);
> +
>  	for (size_t i =3D 0; i < refnames->nr; i++) {
>  		const char *refname =3D refnames->items[i].string;
>  		const char *extra_refname;
> @@ -2514,6 +2517,14 @@ int refs_verify_refnames_available(struct ref_stor=
e *refs,
>  			if (skip && string_list_has_string(skip, dirname.buf))
>  				continue;
>
> +			/*
> +			 * If we've already seen the directory we don't need to
> +			 * process it again. Skip it to avoid checking checking
> +			 * common prefixes like "refs/heads/" repeatedly.
> +			 */
> +			if (!strset_add(&dirnames, dirname.buf))
> +				continue;
> +

This was simple and neat. Nice.

>  			if (!initial_transaction &&
>  			    !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
>  					       &type, &ignore_errno)) {
> @@ -2574,6 +2585,7 @@ int refs_verify_refnames_available(struct ref_store=
 *refs,
>  cleanup:
>  	strbuf_release(&referent);
>  	strbuf_release(&dirname);
> +	strset_clear(&dirnames);
>  	return ret;
>  }
>
>
> --
> 2.48.1.666.gff9fcf71b7.dirty

--000000000000f30a3b062e6ce62e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ddf7f0f17c4b2d22_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lMHNWTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOS9EREFDSVFSSmtKS2pYMDVXOHNzRko0SnpPaG9aVApyN1RYRGswL3VI
NnZ3OXR2Qk9LQjFmVjk3MzFBWUZBbmMySTArd3RITFh6ZXo5MXlOWTB6S0p4RHYrbWRJVHZxCmVa
bVJ2VWxsOUdlRFFpdE1GajlwV3FHWUYvTXVoSmwxM010eFJzVHdPNWE5TzE2citYcU4xNnNsNlAx
OC9yYWkKdjlPTE5hS0grSzBRdFo3ZTdDQ01jYlBTcTRmNXlWNmpQRjYxUmFDQVJjK1NoUXRYbmFq
eVcyRXdhMzBFcE83dAptaWJic2UwY3dJZ0FiNnc2Rk9OakhCZHFUWmpCeWlucjlsYUNrck5oR2FX
RVhjUlBlbFNBQXpsQndyNTd0Vi9UCi93eFFuWEh6dnFNTG1kZlN1VUIwR0krQXFramp3TE1SZTZl
QWNKZXgzcTFFRW9wdVR1dnpxUE83a3dPRnhBL1YKT0NIQTZIZG5qMTJ6ZDdZRlNBNFFHQkFLUTZM
dkhjdDdSRXBDZ0UxTlpFWndCZERiUXBLZG9JN243TzRCdjUvQgovTkZaSWJpMTVqMTlSU2hzZldC
MWROcEJtNlJUZytSMk9iK2NpMUNDa0VYdU16ZEVUcC84R2ZxaUpLWGRhSTVBCktkejc2Z3JqUStU
KzJuZDlYbnJsUFdyNVVEODFzM3RLN0FyVjBFMD0KPUk0NnkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f30a3b062e6ce62e--
