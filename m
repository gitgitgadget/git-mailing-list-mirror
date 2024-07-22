Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC7216A399
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652787; cv=none; b=JAfHG1vPKyhMQNSJBczlmT9zpeAtr3cRzyYLz+zezC5MHaNwVKAaKnDOxUOaL3LmpCDH0FOSRNkYGbW9SN4rYmj4jruV7xzWU/gswOnv1xawAzJVw8HtHucKHUit5TYFksW75IBWueq5jF4El79KxsdicarALTgV0YQFu481M2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652787; c=relaxed/simple;
	bh=OQZ1+qhcU9WqTFsoVvpiqcxNFSyx3KZW6EAE1awtWBM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gT13/vAx+jSX106mhg5vuJBDD3MoXZAW+ezOJPR0XYeIzzjG7KTAZWCSAdcGRdUPluBqewRs2QP9Jry7i0C29E+Qf0mfKd9bd0C6/6TC6XdrN+NSjgli2lPUPLzli2YUbPIqOIUqrxEWropXsFYGNQFFZAScodlqSx21J6QRI8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFDXIKP+; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFDXIKP+"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2611da054fbso1463128fac.1
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721652785; x=1722257585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PE3LRAPM4H3fYxGiIBEJTUceenZyMzHJD0tHq+CQFWo=;
        b=CFDXIKP+bU8JdAb+L5LpEN4HHp9Zu1pDOpc3fl6MxoL4qaslLN7jmP+1IRLltOpIvy
         UhvxFRUYT/haPSWZbbw7hfpdb/Xl9ZJlXvt1FwY1c59ejNgt+Oggc87XJpJBo/Oe4ejC
         bvZqi/fvHqpg8mM4pQqpbAaOOBvTT1MN5Cqx+4Zqf9A90Uz0ue2xyDi+eLS/8JsLUAez
         Iybn5H4jrqUduOpEmifkvokMT8+gU/lfo6npd9clsDQwhTrv6ncj1skB5OvDoGvXtHYf
         wvA8u+DzrzCzZYpzcOZcD0cYMHpgbgzBlr7KGUaKY/yNsWG7dckvGs4K0/OFYtgZAAqs
         Fn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721652785; x=1722257585;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PE3LRAPM4H3fYxGiIBEJTUceenZyMzHJD0tHq+CQFWo=;
        b=e7tCNC5r1MqKMcBOD1u2M5aCsEMv5DDdBo2/ZRzncUuI1oRgc62gOy0KUSsfovcbEh
         PwATWScyWUum2ektpoLvzal6J3S9z6TTG7jua31WZRxhram8d+D8SC8+Qe9WYoCQ1qZM
         ChavKCN46Y56yPlzvd8AR/Z5i0vc1gfMsCTK1OpDItIwJsWJed+lQqBS2TQCFAo3nfTa
         1/tPKM8fjMNiG3OvxbpdWKqc6oKlxw1sqVTPzQp1XX5to9xnVlAr4UkjDcejJnwWUOEY
         jWkOb/jYpVcwc7vrcjOu6IL3P2Wi7ojzUU1aNI/BxiMjF96jWNAJZL1ITAyc5KAdvNLO
         l8hA==
X-Forwarded-Encrypted: i=1; AJvYcCXD8GgTZYa0B3lvp9X91X90orFTUOvGVdeXOvzI7QFL+zm769uoFtTDjiCxU9EMk7kJKv2REMfNgjuc0O/rVFDmNmTu
X-Gm-Message-State: AOJu0Ywv/UjHWCH1E7CQEO+L2dQYWEv8j2uaJt1yoaH08Y7kwjQzPoii
	0IF04Wmn3A82Pme9lu5I/4O44D05XDu5O7cAXeIujpKKSW1hT1NhZckgbIcQoQGabz/rPPkwr7m
	wSFa32QzHdy2yRnc4srWyb6PaxWo=
X-Google-Smtp-Source: AGHT+IFWABue7E6RKyYWli3Wwq1102S/HZV7jQc4XXGUPUbWkZrmT88TTRAnMWzKS7foNWxMKgJj/woKr+BMkpQZrsc=
X-Received: by 2002:a05:6870:831d:b0:261:1be0:b5b9 with SMTP id
 586e51a60fabf-263844adca5mr7076978fac.0.1721652785029; Mon, 22 Jul 2024
 05:53:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jul 2024 05:53:04 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240628125632.45603-1-shyamthakkar001@gmail.com>
References: <20240628125632.45603-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jul 2024 05:53:04 -0700
Message-ID: <CAOLa=ZQ8fuCksk+CGP2thMqKnT_KME4goLwEt6hKYvt+Gbn5tw@mail.gmail.com>
Subject: Re: [GSoC][PATCH] t: migrate helper/test-urlmatch-normalization to
 unit tests
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000adc2f1061dd586b3"

--000000000000adc2f1061dd586b3
Content-Type: text/plain; charset="UTF-8"

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

[snip]

> +static void compare_normalized_urls(const char *url1, const char *url2,
> +				    size_t equal)
[ 5 more citation lines. Click/Enter to show. ]
> +{
> +	char *url1_norm = url_normalize(url1, NULL);
> +	char *url2_norm = url_normalize(url2, NULL);
> +
> +	if (equal) {
> +		if (!check_str(url1_norm, url2_norm))
> +			test_msg("input url1: %s\n  input url2: %s", url1,
> +				 url2);

check_str() checks and prints the values if they don't match, so here
since the normalized urls will be printed by check_str(), we print the
input urls. Makes sense.

> +	} else if (!check_int(strcmp(url1_norm, url2_norm), !=, 0))
> +		test_msg(" url1_norm: %s\n   url2_norm: %s\n"
> +			 "  input url1: %s\n  input url2: %s",
> +			 url1_norm, url2_norm, url1, url2);

Here we use strcmp and hence, it won't print the normalized urls, so we
also print them. This is because we want to make sure they are not
equal.

I don't understand why there is inconsistent spacing in this message
though.

Apart from this small question, the patch looks great!

Thanks

--000000000000adc2f1061dd586b3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 34b0e15921ddefda_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hZVZpNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNDhyQy9zRks3NHN5Um12L1BpY2RLTEc4bGxFSXBWaQo0Vnh2ek1uMTMr
RnRJbWUxbWxkSWFabE9hSzRIZGN1RWFNOE1ZT2lwZDVyNVQ1TjgvZzBSbmMzeS8wK3FCVVEwCmd6
V2dVZEluRi9oUzVKZGlhUi9VcVpHZ3oxME1UTm9QUko1SmJ2ZDhmbW5iSGJvR00vcnZnYjk0UVp2
MGlXWGgKU0Y5Z05OQTMwTTl5b2h0QWVqcGhxNnA0Znp2czgraUR5SHlOdHZkK09QeWh6Q3p6bVVR
VE5iOElieVUxdDFlTwo2V2JNYlJKVUViQkhwZnRPSlRqZHhkV0plRHN6Mms2QVFRd2Y3OGxIdlNy
Sm9zeklONGxWb1M3RUNMYVhrYnhTCkJCNTlEejZvUzlxOE5uV3c1VEo2RTZhZW9HNk1VUDl1YVV0
NUx2djk2SjVaS2RpZTdoRjhoYXRpeEVNKzdNVlIKSHhEUTZEeHZkajBRekhMVnZIWUVtT2VTRWJO
eDBOVUc2Q0QxYzNBdGVKMGc1UlkwdFJmRGhaVWhsbjZZdWR0Rgp4WStxNGpybEZUSE03RHdORnhh
NWdMVFJsYk5rL0JuaVlUVytXYlFkOEw3SEwrVDVhK3BucTNSTWMvUkw0akVPCjhKWnBTbTEyVjdy
LzFpRkg2bTVRZFB2UzNLc2lZUldWOFZRZXJhZz0KPSt3USsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000adc2f1061dd586b3--
