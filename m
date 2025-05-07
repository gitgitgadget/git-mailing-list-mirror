Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B2D286899
	for <git@vger.kernel.org>; Wed,  7 May 2025 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621903; cv=none; b=g/yRBlY5JCaVKp7QxgH50Tft2xY0UPguJ8sTKRH1ER/BRUZvyU71A/JMjPOiKKBzLSVRgJ8kWSLMLWZUcJiq2M0M0oGOGbvUIBI75sxbyk0YNsTr6sborueNtaFnLpO03rI/Ue1gCRRDyx+rP08o4xEMqVehQQTFzRKCsldpuuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621903; c=relaxed/simple;
	bh=D4x1rfINvfNGYa1Lzlh5+dczvsrUcHQRA60Ani8ViVA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDSLfwxc/iA+zzXiHtmkr3f2Mfx4ofXJ3YfEfDkps2gmJiecGvYVI/79ysh6WQ1V8mVk/escYSxrUmNBS69/nQ9jGNZ+bw4YjOeGcO+RExoz4d2Zevjwti1JTy8cjWn7Pq11XoO8jk+VsuedswWMr1Ct4nJ4cNzLChnzljjfM88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1UWB5hU; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1UWB5hU"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4ce8aa3113aso4406077137.3
        for <git@vger.kernel.org>; Wed, 07 May 2025 05:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746621900; x=1747226700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RS7uCDVjJvFlghPfZDwYkOKEp/GzOCaKXMbAbV7d9xs=;
        b=D1UWB5hU3qEt3us0R3oWM5rvoyI3wsXnw/RTbzjiFa2S1fmO7p+J9UjknZNWuKzxsW
         INBFyz+xeSGA2M1OEUuW1uFpSLp+S7OUTfTWHca9uXjWMa8Y9DGhClHsfuMpy/0tFUsx
         tqijmOnOeP/mIfjniefhIFcHSpusVB9GuwihVSgLBr/HmfbWapd7Nw0NpABaQ5ZcUO8l
         obMpgud0k06gQZqd37p2K/REktVdhKtgRuT2TvVdHcFUfH18V01QMxzEUgtEIlcOlSMX
         qxm6NER9Z5UiK6wNjkM1cerDFOyNuh8sbE1QXF2bWxCRxnaep/X0+lFMeg6rCV5irwIa
         ZgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746621900; x=1747226700;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RS7uCDVjJvFlghPfZDwYkOKEp/GzOCaKXMbAbV7d9xs=;
        b=iHsH7we25TcvHLnQDjcZDfa4D0PZciy62cN9jHRqxo6EaakVfkhAjxcFfixaESqybM
         jcvUbXIGPZfxSdA52ffTkGJG/BFPyEVXM+LU7A7lNQBDS1+V/QpUxD4Hccbrq7Cbbzcu
         FHW7wGkb/jedXDiiECIQA7PQD/hD7xkd7fDzicczwxxTSgI4fMiPQu2AkToT8KYcDXZm
         2CF8hHSZfZLp+qZtG51yiV71o33HV1u8DapjpvBEK13Wlvw6x+86chzCiwbI0HH3LHeh
         VunTpcBil03huqdcohTWqyl74AQWokDQze5k3PUCDg+htIho+zvLBu17NRTY7NBi9xYu
         hoIg==
X-Forwarded-Encrypted: i=1; AJvYcCUb1ZvQU001/eF0G+bmNzgAu1zvbj7ZCcXWjy+0216fEdpxJ2X4q92n2hVYvVdtwvGOH+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI97rGOi0aWsADu9sKsb5l/MnlD3lCyvLQbTl7IqSAcntja+Ep
	N2g2fyjIPgAuIHy5KO+96UFFwyYA3eZ+VWVIB/Pa1i9i1EZ1CBLPri64WdoAoqjVqelJOWRK53U
	dSzCB/Lbjbp9XZ1RmjPDFxLKlvjI=
X-Gm-Gg: ASbGncuRA2KgkQ8QXBl/qa3eSdFm2wxNmtIx+YdV6Vij5ecKV8YJHVvfuFmV/Crkxp6
	BxZU/Ia9GN0QmcYHYFZA28arWKW5p3a00wrWy9LMbPDuafBza9X1XPxVYxXsfskJmhqVJwVVn76
	UqxvAcjWrwkNUkYOjTfeIJ
X-Google-Smtp-Source: AGHT+IHTBBe8U+vO2WCne/f/Gj1FASOf9y3cZY0zWDdL/xntAJ6mAfuOOhKrL57oVsMqXNA7a1BJ+oLEDNRjMRti5lI=
X-Received: by 2002:a05:6102:5f91:b0:4db:10c6:319f with SMTP id
 ada2fe7eead31-4dc7388d0e3mr1759699137.19.1746621900439; Wed, 07 May 2025
 05:45:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 May 2025 05:44:59 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 May 2025 05:44:59 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250429145243.992252-3-christian.couder@gmail.com>
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250429145243.992252-1-christian.couder@gmail.com> <20250429145243.992252-3-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 7 May 2025 05:44:59 -0700
X-Gm-Features: ATxdqUHrP04kbC359ScIaewcAz0oXfRsAeSs7f5363dedEbg8TfKEXTxFfpBSh4
Message-ID: <CAOLa=ZSwzvfQ8MupFzuMEpHCKJRY8p06m-FfyE-deqOsgK_feg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] promisor-remote: allow a server to advertise more fields
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000eee20406348b19f4"

--000000000000eee20406348b19f4
Content-Type: text/plain; charset="UTF-8"

Christian Couder <christian.couder@gmail.com> writes:

[snip]

> diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
> index 5598c93e67..b4648a7ce6 100644
> --- a/Documentation/gitprotocol-v2.adoc
> +++ b/Documentation/gitprotocol-v2.adoc
> @@ -785,33 +785,52 @@ retrieving the header from a bundle at the indicated URI, and thus
>  save themselves and the server(s) the request(s) needed to inspect the
>  headers of that bundle or bundles.
>
> -promisor-remote=<pr-infos>
> +promisor-remote=<pr-info>
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>  The server may advertise some promisor remotes it is using or knows
>  about to a client which may want to use them as its promisor remotes,
> -instead of this repository. In this case <pr-infos> should be of the
> +instead of this repository. In this case <pr-info> should be of the
>  form:
>
> -	pr-infos = pr-info | pr-infos ";" pr-info
> +	pr-info = pr-fields | pr-info ";" pr-info
>
> -	pr-info = "name=" pr-name | "name=" pr-name "," "url=" pr-url
> +	pr-fields = fld-name "=" fld-value | pr-fields "," pr-fields
>

From this, it seems like the order of the fields shouldn't matter, but
this is not the case. wouldn't it be better to say:

  pr-infos = pr-info | pr-infos ";" pr-info

  pr-info = "name=" pr-name | "name=" pr-name "," "url=" pr-url
  pr-info = pr-info | pr-info "," fld-name "=" fld-value

[snip]

> diff --git a/promisor-remote.c b/promisor-remote.c
> index 24d0e70132..70abec4c24 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -314,6 +314,84 @@ static int allow_unsanitized(char ch)
>  	return ch > 32 && ch < 127;
>  }
>
> +/*
> + * List of field names allowed to be used in the "promisor-remote"
> + * protocol capability. Each field should correspond to a configurable
> + * property of a remote that can be relevant for the client.
> + */
> +static const char *allowed_fields[] = {
> +	"partialCloneFilter", /* Filter used for partial clone */
> +	"token",              /* Authentication token for the remote */
> +	NULL
> +};
> +
> +/*
> + * Check if 'field' is in the list of allowed field names for the
> + * "promisor-remote" protocol capability.
> + */
> +static int is_allowed_field(const char *field)
> +{
> +	const char **p;
> +
> +	for (p = allowed_fields; *p; p++)
> +		if (!strcasecmp(*p, field))
> +			return 1;
> +	return 0;
> +}
> +
> +static int valid_field(struct string_list_item *item, void *cb_data)
> +{

Nit: Shouldn't this be `is_valid_field` similar to `is_allowed_field`?

> +	const char *field = item->string;
> +	const char *config_key = (const char *)cb_data;
> +
> +	if (!is_allowed_field(field)) {

Nit: Can't we just inline this?

> +		warning(_("unsupported field '%s' in '%s' config"), field, config_key);
> +		return 0;
> +	}
> +	return 1;
> +}
> +
> +static char *fields_from_config(struct string_list *fields_list, const char *config_key)
> +{
> +	char *fields = NULL;
> +
> +	if (!git_config_get_string(config_key, &fields) && *fields) {
> +		string_list_split_in_place(fields_list, fields, ", ", -1);
> +		filter_string_list(fields_list, 0, valid_field, (void *)config_key);
> +	}
> +
> +	return fields;
> +}
> +
> +static struct string_list *fields_sent(void)
> +{
> +	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
> +	static int initialized = 0;
> +
> +	if (!initialized) {
> +		fields_list.cmp = strcasecmp;
> +		fields_from_config(&fields_list, "promisor.sendFields");

Nit: Here too, can't this be inlined? While the modularity is nice, I'm
not sure the redirection is warranted for such small functions with very
specific usecases.

[snip]

Apart from the nits, the patch looks good :)

--000000000000eee20406348b19f4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8498e072a379ef03_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nYlZja1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK1RRREFDR3BZRU9NSjkrOXdCanNJclhZMWU0dS92MwpXd0JPM2F5bUZ3
RXF6UDZ1VFo5ODgxRDhROWhjTkthSCt4RlRNKzFRQlByOHRwVEQ2VEhzR3ZYYm1SRW1CVk1MClZE
bjRwYzdNMTNCdzBKOUNPa1hwMWxHRm9OVS9YQWlnYUY0Rlc1Mk1RaGxuTUl6S1ZVZWNXSThGWGgy
YmJObVgKTU5DRFU5U1oxVkdIcGFTYUZKUEJKbEhpaUdLeVd2SVFxY0lVbEhUb09IMXJnSWNRUXVF
TnVzZzFUTGZ4Q2d2cwpMWEF1S0NjZEdjV2dtTVFDcG5BV1gxS3pSdGZ5WWpVekd4VFRpUVlUTzZ0
UjV0QWVzVHZwcFk0RXhVanJLSkR3CnFDZ3BmWGJnL2lvWTBSU3R1dk5aWEtTVkJJS2RDc3VMQnFR
U3U3LzFVajd1ZnFxWWMyYmd1Z3VSR0x6WUc5dWQKamROWXBFZkJqSm1vRzlYbG9tR2d5VktGOGRL
OU1xYTlFNFZxUHBxRnBJc1IweTgxNThlMEhsV0ZscGxGSUNRUwp5ZUNlY253SnJDRFBGQTgrYnNj
QjJ4d0VxQWJ4cHUwS3l2SjJYSmVISXorNlJISi9Sd2kyaTdUYlQzTDZyVVh0CloyR1JGU3VOU0hN
WHJCbUNXUWxUL1ZTV25nc1oyRGE0cTJmV3dDbz0KPXd5MVMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000eee20406348b19f4--
