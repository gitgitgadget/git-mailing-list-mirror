Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F60C26B95A
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894673; cv=none; b=m88tudKknrUiGrl8q8VCezMZywOpVwpYwYAzbw1NsP58ULotiU39kKBnym3u6UZwZlh3h4x5Km0MuUN13xR51cOJzsm/QMc62YHZ1BUEMxQz70dKJC/PawvLgpw4CG4rTOGtNVbJ3VPdPpBWfWsVtCxB4BYiwPzBmH2GXY1T2V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894673; c=relaxed/simple;
	bh=fn/ZB7EtLRVZRUgmX+VWrxzfqIZhtYOoB1QhXDxzBMw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d97/C9N//lRwCdQPY9arjmvRLAnUWsn8xf7khdywucv3Y4YZd/MY+pyZIGcP8MRD2X56EevbHQ3jaT2Hf2tQ14zNChKTrtPnefU7XONiQ6ozHFlU/Kk/vc7Zmry8xb74n6z9rIAMQMc4kpL1c9ie2F6Qfh7IVpWuub8cRKYrQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcB9oE+J; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcB9oE+J"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e672a21b9dso31755536d6.1
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 08:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739894671; x=1740499471; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pyyAv6vTfD+vcBNDIt88PU2V7C+Gm6CK9Izbz/D4Kek=;
        b=kcB9oE+JQ64mi1aZgzQTRKkzk94UJpTZzNi1FyrlBhUuDaMK10zT7fpSwBlL3yuvsV
         rQO3o7HYVOT8rOqxYQrgwJqLJpDOCLHSBFBskhWYXQJUc6jJz/VwMwjWysCY+dyUgnEw
         4ADyPPGzTnzSgC5BPek3BA0dR5+GuCNpBIqxzXlYP7mxyorzNEWWUtrn74CGfZgU8/+l
         LKsxiBpBdqzIWEK2ehuPHXoww7HvC0rqcvTxjH0dNx7QWmlLQuMmXI9TB6WiargfZxb3
         m6Fdq36O0iaIR604JHugv1nk+ukQgSler6jOpMVM01A07y/dBW2U8TIKp5ylecWQO9uf
         zGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739894671; x=1740499471;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pyyAv6vTfD+vcBNDIt88PU2V7C+Gm6CK9Izbz/D4Kek=;
        b=rObC048uz5QK7wv9X+Es0MFYmyXixlc8YLPfD+nIebjpjck+hjcFCdS5/2cckv4C9N
         zaT0r5BNTodaEXv1FuGkQvapNNQRLUypoPFHlBsb+PZr1y35b2JpJ1vCW9028usJtR2z
         JmP4szZ+LpJtJeaPPpGKaf1IOeyzkhwX5r74UksbrpjuRR5DI85y5QRcobN4/U0MaoAD
         Jh7bpPYzyk2tBuVDBcRl4CuMxDTeSDwbwFAmLvsKb39k3glVcSnSv2+w0sLO61Ne76UE
         goSTrRzpZKpRmtHXx6FrIsAJ0usWIzU2Dliot/DlDpeSzq0M1c3e376iJuIgzBRKgKx6
         2y1w==
X-Forwarded-Encrypted: i=1; AJvYcCV1J376nN8oV/Yqds/38/lZ8FgV59k7NVodLPRAFZ7PLzJmc7Gy1lqWeE6Dq41PkA6K+Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGoE3qZRzY2fR5nRynYVbXFtaYnR1Fd8yVTgdTf98gUo8ALoi2
	jR5Me/P01SmLuiD2b9evTU76ugWyPCRB5YUUN6aB99rZ34bdB1zS1h629xNsnXpPMsxWyledyi3
	UyQHVCD8z895oN15cqlD0GEWThok=
X-Gm-Gg: ASbGncsse0rNqbS17NAYTVxoVHvyLioIgv42SQheWL9vd19cSfBSsFtewPtRdq9HhWU
	0+1rF2TDUcTnePwaI+RaV9H2GZrAGitMA/C8Lq0uDvmDvXjSNGb7Z+a01innhaXbdJ3OgQbrleV
	B+xzRKp/79DP+c05D9UXB3vxIeDxE2nCw=
X-Google-Smtp-Source: AGHT+IG7mNODUVRl9ktlhAGAMKex11WPJVAgcUmU4td8HWJT+9ysLyDsupx4iey3XXIwzvQXWRRrJZQeWVICk2MJVz8=
X-Received: by 2002:a05:6214:194c:b0:6e6:698f:cb00 with SMTP id
 6a1803df08f44-6e69758a7f5mr2322406d6.42.1739894670980; Tue, 18 Feb 2025
 08:04:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Feb 2025 08:04:29 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-3-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im> <20250217-pks-update-ref-optimization-v1-3-a2b6d87a24af@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Feb 2025 08:04:29 -0800
X-Gm-Features: AWEUYZmuc7bIQUZU-xYN0k6G1RG-oApkgiK5LpLYJx3K_VglztSi16H262O5EJk
Message-ID: <CAOLa=ZRJLDKKu4R0TVn7z4LVZ6pirCN+5VpiehJ2grdfHGe7ew@mail.gmail.com>
Subject: Re: [PATCH 03/14] builtin/update-ref: skip ambiguity checks when
 parsing object IDs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000cfc4d5062e6ccb77"

--000000000000cfc4d5062e6ccb77
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 4d35bdc4b4b..ac330748244 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -179,7 +179,8 @@ static int parse_next_oid(const char **next, const char *end,
>  		(*next)++;
>  		*next = parse_arg(*next, &arg);
>  		if (arg.len) {
> -			if (repo_get_oid(the_repository, arg.buf, oid))
> +			if (repo_get_oid_with_flags(the_repository, arg.buf, oid,
> +						    GET_OID_HASH_SKIP_AMBIGUITY_CHECK))
>  				goto invalid;
>  		} else {
>  			/* Without -z, an empty value means all zeros: */
> @@ -197,7 +198,8 @@ static int parse_next_oid(const char **next, const char *end,
>  		*next += arg.len;
>
>  		if (arg.len) {
> -			if (repo_get_oid(the_repository, arg.buf, oid))
> +			if (repo_get_oid_with_flags(the_repository, arg.buf, oid,
> +						    GET_OID_HASH_SKIP_AMBIGUITY_CHECK))
>  				goto invalid;
>  		} else if (flags & PARSE_SHA1_ALLOW_EMPTY) {
>  			/* With -z, treat an empty value as all zeros: */

So the above two instances are used within the individual sub-commands
for `--stdin` mode. The symref commands use `parse_refname()` for
parsing refnames, so all good.

> @@ -772,7 +774,8 @@ int cmd_update_ref(int argc,
>  		refname = argv[0];
>  		value = argv[1];
>  		oldval = argv[2];
> -		if (repo_get_oid(the_repository, value, &oid))
> +		if (repo_get_oid_with_flags(the_repository, value, &oid,
> +					    GET_OID_HASH_SKIP_AMBIGUITY_CHECK))
>  			die("%s: not a valid SHA1", value);
>  	}
>
> @@ -783,7 +786,8 @@ int cmd_update_ref(int argc,
>  			 * must not already exist:
>  			 */
>  			oidclr(&oldoid, the_repository->hash_algo);
> -		else if (repo_get_oid(the_repository, oldval, &oldoid))
> +		else if (repo_get_oid_with_flags(the_repository, oldval, &oldoid,
> +						 GET_OID_HASH_SKIP_AMBIGUITY_CHECK))
>  			die("%s: not a valid old SHA1", oldval);
>  	}
>

This is when the user uses 'git update-ref' directly. Makes sense.

>
> --
> 2.48.1.666.gff9fcf71b7.dirty

--000000000000cfc4d5062e6ccb77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 10105ab1d4c8051b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lMHI0c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLzZmREFDTUUvTGhhTWdMTXk3MUxzWXFiR2laM1lEcwprRU8xekVtdy9Q
cktUSzFUd3lmQUk3UWdQRi9iODc0WlFKNm1OeEdsbzBpTG9BZDdTa0VwVXNSV2h3OHNtOVFvClJk
THM3OXpzbDhmSGswcUlDNGYvcm5LVnJ2MFovbG5naGZGemV3S25lREpWWC9YczFhdFNJT0xBQW9q
WEdSK08KVDQxL25FbWhQbnpJOVRjTVRZZ2llSzJZS2N4MmdmQzJoR0tndGthbTZpL1Yzc0ExOG51
ZHVOQU5ONkY1OThKTwpwbDBhUnZlekg1VU41WFRDV0xoUm5EQTE4VzlXaWJXcWRUZ3FYblVqeFRk
WVhoRUJYSXY3dUp6OWxvVGlEL3VKCjFFTXFwb2NsalFmd2JIYmI0RzZOTlo3YWNMc0xGWjkyZUcz
aXNLSUlzc29RT2l6TjdnaUd6ME9PRjdOVk9CMmMKbVlaR1NFK2E4a0treWFtQ2s0YWFQVVdyME9m
VzVsSFhrSTZlMFVSMFkzTUU5QnFEb0x3UGVDVk1KRlJSMVJneQpIeHY1TWxKNDZHdmd3R1lNZmNh
alNnelpMSCtSaS9tbkozK01uWjlDTmtFdkFZaDROVUhtUDZEY2ptMmFabHdzCnZNMklTclZkeTky
K0hFV05yU0E0enZlZElGbEM2MXBXMDdTWkhQTT0KPWMwcWQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000cfc4d5062e6ccb77--
