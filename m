Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E8729CE1
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820490; cv=none; b=EQC7Me77HfIMlhK+FQuW4a41hnwhSocanQ4wiTYGKHH2tcrXMV5LvzTYpQefdnzCub+Mu53S5qaq9c8WIRxhgDIGJM+3D9KelgImk57EQHBg8SufSdpO9bMYCr5q2Z1WrM1Cex4DuCxj8Lw2CU7pxNmA44cB4nAPvCPlzN34In4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820490; c=relaxed/simple;
	bh=g4qg2iWpe650w8Vcxn7ysyt5AsVek3f2L3+1J/DY+iE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=ncGV/Mbyn04ePRiRPDvVMOI/GiN+VBFcNi7ENl1VU/QD6lbLlCM8fSaGmucELu6Zce7J0AtlpL+YrZvX/U7ps0SuFmOcD6OsFc+GbPGq8xxWArA7vQPn5r6DVYx8OuQfXZSMbxWL7K5Pz8r3Yn1tBavFBsQ0j7HqiOddujaIOdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vq+1HQ1j; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vq+1HQ1j"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-932bbd6ba76so328624241.0
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 03:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761820488; x=1762425288; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6A527lyNwF9QsOGJ9xSCCzACrh+/e0SQKTR/lePHpY=;
        b=Vq+1HQ1jva1xZbMu1fhL4vYU8oFy62Yq+pWfvM6NNVAf+x9AE1J2XqdAQwNUiI0abp
         LdjiJKLHobA/kUjBCZOAEUH7MNT1YFFBVMUxoMWehEKmmg5GSqeHnN08r+jnFVs84MrT
         lXPC1AAEO83r5xK7TxwqydcFgySIpawk8mmTZYonMcNsYQOY3Cud20JLVVJ2XOM9cLgc
         EIpMH5YgKZajKXVL/OKNSZvapF5Zb9UvxoQrLGkELHf9CvrwremzkFBC40fqOnyuklb0
         fqcOD4xUGoX5jKp2IEQBSNEA/oivjM1eBvGB3wmMviDI9/M0r1Ny3fZQuQr0X3L1JLGk
         Hpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761820488; x=1762425288;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6A527lyNwF9QsOGJ9xSCCzACrh+/e0SQKTR/lePHpY=;
        b=e8xvUo9I0+Lyo2lOJ1zw9Em9Ldc7i3/s/nLx3Kbm12+jvxguSfHs54xmO0kXRDLBpu
         fDS0rnrBOdryZ+z6PK42zMHfwlu/nFzJvAeVcP+g5EpUldJIdJdwIIxGZ+NBYej7EPbH
         09JweoiJkbLAjkgHDqcSqVyg5CzDuGpWG7B9UI5R8DhGYlrFNf3feIn1TKSnw6y+wEru
         ktMoGDbhI9EpK+Oubbe51uSOG4G2VDuSxNPjgArDig83ds/Ixhw6XJ7Vz5aJmcSJppJm
         YadwE3d6VjoboP/SKVN5RGUBmwmZ9DoYs5t6974Dd5uY3yzfODHtgPPUeeL/qAFMHszS
         4V3g==
X-Forwarded-Encrypted: i=1; AJvYcCXPKaNFLL88it8B1ClVY2297VUfy6DPlepJv+Fsr+zXme5AkT0TkOcYz92lsZfPcJX516E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy7TFe0ciss7pVyQzFIby06xofz1ORnX6kNwC6URbleoSEQAB2
	T6CupctMeakfmEC4JbxNosOz1asAjN3Noh5B6IfUnBSY78hFPWUG7apvs/7JoSfIHvQBmeSSpap
	bH/h/nO/FJNEDm4ZPnJD5vDLnubCwAJsEzSrL
X-Gm-Gg: ASbGncuf123NLTwPf3TFrm4R7B2QCtRlZtS4Xl58AFaC2u4WLzrAfBA9uNrNRh8SEGk
	NOblXytY8xoZFMEAtvqet6+7F/CVicvwCMLsNZ/XSPeAHHqEpHsMeUQMizqGa5GyOUaI+ehaHIF
	7ySTWnt1rmDxtAUmjmr75sY04W64Rig/riZk5fl/hDR6LC01X5clI4qHDldLxLCT8jhlkpJMFaA
	siV86sOIFXXi8ddybus32xLwR9MRJp9enCR08wteeaW41EUpN9fSgRrs7DRUGmzxfJfEE62Xrr/
	Amfrfg94dFwsITu0ew==
X-Google-Smtp-Source: AGHT+IES99Ufz7B6eG/9Q7Sf8Oye0Vv9abDpqYya6tMT3gJWdxvjcqfl7NBta+0BXB1Y++5Oid4mpJTp5xwR9hbAokk=
X-Received: by 2002:a05:6102:6886:b0:523:759e:b0cf with SMTP id
 ada2fe7eead31-5db90655142mr1765761137.21.1761820487708; Thu, 30 Oct 2025
 03:34:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Oct 2025 03:34:46 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Oct 2025 03:34:46 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-1-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im> <20251024-b4-pks-odb-loose-backend-v1-1-1a4202273c38@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Oct 2025 03:34:46 -0700
X-Gm-Features: AWmQ_bkv4GWNjuUkoZN1gKpx0mMKHvkSBtshq8lqVnY6wyt_qRulvKmpfQspwbs
Message-ID: <CAOLa=ZRYutkG8gDBy9VpvptjovDo5o1fzJxbaL_=ggGZDcnY=A@mail.gmail.com>
Subject: Re: [PATCH 01/13] odb: fix subtle logic to check whether an alternate
 is usable
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000541a7c06425dccaf"

--000000000000541a7c06425dccaf
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When adding an alternate to the object database we first check whether
> or not the path is usable. A path is usable if:
>
>   - It actually exists.
>
>   - We don't have it in our object sources yet.
>
> While the former check is trivial enough, the latter part is somewhat
> subtle and prone for bugs. This is because the function doesn't only
> check whether or not the given path is usable. But if it _is_ usable, we
> also store that path in the map of object sources immediately.
>
> The tricky part here is that the path that gets stored in the map is
> _not_ copied. Instead, we rely on the fact that subsequent code uses
> `strbuf_detach()` to store the exact same allocated memory in the
> created object source. Consequently, the memory is owned by the source
> but _also_ stored in the map. This subtlety is easy to miss, so if one
> decides to refactor this code one can easily end up breaking this
> mechanism.
>
> Make the relationship more explicit by not storing the path as part of
> `alt_odb_usable()`. Instead, we store the path after we have created the
> source now so that we can use the source's path pointer directly.
>

Nit: The last sentence would read a little better with s/we// and s/now//

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/odb.c b/odb.c
> index 00a6e71568b..57d85ed9505 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -86,17 +86,16 @@ int odb_mkstemp(struct object_database *odb,
>  /*
>   * Return non-zero iff the path is usable as an alternate object database.
>   */
> -static int alt_odb_usable(struct object_database *o,
> -			  struct strbuf *path,
> -			  const char *normalized_objdir, khiter_t *pos)
> +static int alt_odb_usable(struct object_database *o, const char *path,
> +			  const char *normalized_objdir)
>  {
>  	int r;
>
>  	/* Detect cases where alternate disappeared */
> -	if (!is_directory(path->buf)) {
> +	if (!is_directory(path)) {
>  		error(_("object directory %s does not exist; "
>  			"check .git/objects/info/alternates"),
> -		      path->buf);
> +		      path);
>  		return 0;
>  	}
>
> @@ -113,11 +112,14 @@ static int alt_odb_usable(struct object_database *o,
>  		assert(r == 1); /* never used */
>  		kh_value(o->source_by_path, p) = o->sources;
>  	}
> -	if (fspatheq(path->buf, normalized_objdir))
> +
> +	if (fspatheq(path, normalized_objdir))
> +		return 0;
> +
> +	if (kh_get_odb_path_map(o->source_by_path, path) < kh_end(o->source_by_path))
>  		return 0;
> -	*pos = kh_put_odb_path_map(o->source_by_path, path->buf, &r);
> -	/* r: 0 = exists, 1 = never used, 2 = deleted */
> -	return r == 0 ? 0 : 1;
> +
> +	return 1;
>  }
>

Okay as part of `alt_obd_usable()` we no longer add the path to the list
of alternates.

>  /*
> @@ -148,6 +150,7 @@ static struct odb_source *link_alt_odb_entry(struct object_database *odb,
>  	struct strbuf pathbuf = STRBUF_INIT;
>  	struct strbuf tmp = STRBUF_INIT;
>  	khiter_t pos;
> +	int ret;
>
>  	if (!is_absolute_path(dir) && relative_base) {
>  		strbuf_realpath(&pathbuf, relative_base, 1);
> @@ -172,20 +175,21 @@ static struct odb_source *link_alt_odb_entry(struct object_database *odb,
>  	strbuf_reset(&tmp);
>  	strbuf_realpath(&tmp, odb->sources->path, 1);
>
> -	if (!alt_odb_usable(odb, &pathbuf, tmp.buf, &pos))
> +	if (!alt_odb_usable(odb, pathbuf.buf, tmp.buf))
>  		goto error;
>
>  	CALLOC_ARRAY(alternate, 1);
>  	alternate->odb = odb;
>  	alternate->local = false;
> -	/* pathbuf.buf is already in r->objects->source_by_path */
>  	alternate->path = strbuf_detach(&pathbuf, NULL);
>
>  	/* add the alternate entry */
>  	*odb->sources_tail = alternate;
>  	odb->sources_tail = &(alternate->next);
> -	alternate->next = NULL;
> -	assert(odb->source_by_path);
> +
> +	pos = kh_put_odb_path_map(odb->source_by_path, alternate->path, &ret);
> +	if (!ret)
> +		BUG("source must not yet exist");
>  	kh_value(odb->source_by_path, pos) = alternate;
>
>  	/* recursively add alternates */
>

Instead we now add it as part of `link_alt_obd_entry()`. This makes a
lot more sense.

> --
> 2.51.1.930.gacf6e81ea2.dirty

--000000000000541a7c06425dccaf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5402617372a20f94_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rRFAwVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL1duQy93TlFONWxTd1NtbHFkbEZidU1wckozRTZnRQpkcXFXMHZ0UDNo
S3UzTHp0Y2VpQlB6bjFRL2xoMTNtWmI2QXB2MW1aaU9UNFQ2RUs0RDBUeFh6ekFrQUNSYjAyClV1
dkhIZUt1c1VRa0VCN1dwUzhzU1o5cGk1S0ZaUEtlaXhKOWRlS0xNTHV0NitwczhrdTd4djJsNDlo
eXE3bmwKaXMwalRwb0xobTV6NzczbGhXeGVhRDJ2QmRzaFY3bHhmTDlHVGlRa1NyckorSlk5bnBF
SjQ1dE9ZRjJqenZmcAozUmtNRXh3OWN0cDRTL052d1ZPZ3pwTzhhT29wL0RiYkQrem9CNlp6L3Bw
QzBLcC8xZFFEbkVOMEJHempUM0VQCkdPeHpKMkRlUkp6TVhRZlJRVmNBME5wNHE4Ty9PNzNYM2Zw
YStZRjFlL2sraWpNQWlFc01yTDNISGhsOVVBSWwKbmJXWkFRM3JmQVRYdVBvMU1XVldiRHpYTlc2
VzYrQkVzTDBzT2xaaW05WCs4MzhqbVI3YjVSUEc2cmpvRWRhdQpzZERtaTVmTXNpU1kwZkE2Y1A0
Y0dOcWFJRmswM0R4OFkvWG9SaHZIZVNNU3NZQ1Q5d2RZdjY3RDR6WkNVd0poClh0bXQyM1J3OUhH
M1lTdlNpQjRzWS9HWmVLeWZIT2picUJqNU1ycz0KPUdEN0sKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000541a7c06425dccaf--
