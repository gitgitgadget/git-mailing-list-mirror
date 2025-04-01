Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9767720FA96
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743533249; cv=none; b=depdfLeuljxNr6LW2vuYr91KrNsQk6dnvpCTO6i4j/OFUHOk69mevbht7L3ufCGqCnF5B7XhULQRCOiIez10ne2IeM6xOG9vz0RXSt0Ap0IYsN4vV9oGMsVH4ifGh3WZ89nvIuyQeyZ+rE+9YAf6nBzAqry/E4pzS0lngb3WQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743533249; c=relaxed/simple;
	bh=mBCYXSQzPCHEy+adHOWNkk1O6Gusju7AdcW8znQ4V8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2PpNsQym52RfBlMJYTqjSbgobn3bofkk+tAcnXA2isvS0ndG3kbGORXO2yG0oHSPOT6IqDzJg5fppiN66oBXxQXxqmfqtxk7yaxuGaUMl1xdBWPydMGww83FGjLD2zLN9IfSnlXLD4cYXYqxu3prwQYqNiu6xJRUu1QP3kEM1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=EeOWB5FT; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="EeOWB5FT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743533233; x=1744138033; i=l.s.r@web.de;
	bh=58nV6bs8Vck35RZ20rqL5MPCsvkugiushBdp4srdVh4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EeOWB5FT+MfxlJurC7E/ML/JKpT645SsVZZue5xeXaksy8trBFaWlsQD2+9amsFH
	 PNfuxe8T7XMp7ITKaWOu799R1000GLB2y9HNn+jZtpJV3PTyBF1aD+/Qxj0mX0F8R
	 tGNskFGyzatmB9GBYigxIx4FfzXwnvFTi1VnrKCzeU2rca18i7Ia0lGCmpAVWkWPS
	 GjT3T1bTDyAeoRyHbuJckbcIwZ2fZAtIQNp1AS9yXOLgnVm9qBEt2Ta5Mgb7VfzJq
	 BUbPBMdvsLJBwsGh+xuvNfuN2INxMKrCCnnFU478jLh3CKnaQb+N5rBorQynNXfpF
	 +OoXFyUkL00iF81oxA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.31.75]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7xeZ-1t5TNK1ist-00sjr1; Tue, 01
 Apr 2025 20:47:13 +0200
Message-ID: <f6c7c92b-931c-4be4-8d76-9d4ed147e983@web.de>
Date: Tue, 1 Apr 2025 20:47:12 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] parse-options: introduce precision handling for
 `OPTION_INTEGER`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Todd Zullinger <tmz@pobox.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?=
 <szeder.dev@gmail.com>, Derrick Stolee <stolee@gmail.com>,
 Jeff King <peff@peff.net>
References: <20250401-b4-pks-parse-options-integers-v1-0-a628ad40c3b4@pks.im>
 <20250401-b4-pks-parse-options-integers-v1-2-a628ad40c3b4@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250401-b4-pks-parse-options-integers-v1-2-a628ad40c3b4@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VdF8gT5byeZZ5bck8yLUkpSdjEaT6gn1ibu3VMI2XpVF83icx8r
 F7EuZb4FUK94WTd0ykbwIRghAYW/1lzJuPWxd4BjVR/s8dNeYnbJ8HFiqRbtxiSFN1U6RNh
 fdr+UzgGRuw1RGi1KLTW376u72UXZfrgojL5soTnx9HvdT8UV0cQvGdpKLlRY6EQsrj2/8B
 8Ghy9f31xvLyympMzbmPg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0xdepISKICg=;eDI5wNpFSNzZKAOfEw+/0NMLybK
 hWeQhrD4pYRUfV6HQ3MiziUIQ4qfcH3/Y3zMMTb5+3uvYcYdyrWKXYAQijA69CyMpUGsYOLhe
 TrUGxbpNWT2FLacywJRLMUnJfCI29+fmtDMmZHabVKIf/ZZv64z0poiANggELmLFuDANduFib
 sZERMt/cLHfW5XRTebiDjzdfWYuxxCAqhH+T1335I7UDnaJ6IRlDCloGK+HDMeQCedDJpo1rT
 kJlY3tbBIEDuZ2v2GTbVfCx6AMnC7YKG5tBQqiO5EVznavK2bTzK3e6t9YTSBGNcn6kACDShB
 YNv32JI7YXA/P8JicaBPtvlTU1RyBQStCdVSYfmy/gBaK7E9JbsbwVYsGe9VCTz6E+hpHMoR1
 ul/uu/ZKbAHHGKQgtyzCVWfkv7dl2fG/7kwEhqtyUknGrwVWohaRH49f80qM1Plti9uZyFrNu
 DMX0juIBJu1xGidRu/SGRqe6x8fzOLYLJw8vuOCRTse3y9svL9QQ92GhvLtoT/6vEYOtzxTgD
 mkFXI8rnxdDi3Reaqutq8AT4kR0iD31n1n7SdBKJTXDruw5TEzq2vq6GvDS1ODp+kXjfvcbFy
 iO721H2BDHLbUYtLljnl99LGKw9rURy4UbaeBcWQduHhj5+GKRQ1hwIKdwCCnIf9l9T4w2nQ9
 2F654dI2JMiV+HefF5BjvX0grMACslbThrluY8nbNTMXDutjDM2Ae33jmoxxHvF3pmPnVCall
 nGVLbzfhoAQGLr+O85bEQA/zFhY187dGi+F2FhjxUY/xW/L15BeqWy3USDbcJg9friTB2/7Of
 amRzgmw/ivhBSQDXEWHfvqGgJ9m9Ks58STeobTnbUt7O7h2Yd3d72Q5Ih1TheyKDIIKdPlks5
 EuriDrk691bubETX8WEvml4IwXcvqf54pOWen/GLPAgiXKJk7/T/9ncO0mqD+4weQNethpAup
 pvYpQtjI/lTEkHvmxHAn9NDyRXwH21bdUj2q922WkPDDW2y2dJ1LI2p99tmE/UXH6GlZWjMGc
 FMdOq8Sbjp65HwttqG5fpISF2UGBV9KlbAalTSgU1sO+vaJr0pklSAZXKdcLtLeG4vs4FLPzc
 p6zybj/MKwCMTm4rzN3f2w4qDBoOTyuh+CHeWBCuUYemGSRt91jPwvDABQdFjGMVb1Pwf9SWn
 5MckQme+0i2AN8XiP+NS7cf+RMflfJxr45xLMz7RiEPuX5eEKKvOIcHF61BK6SwJjtzJ7uan9
 qPiMHOo7JHo90Ng/2y9i8MRZHzWIcL8fkStRQF6umEAgZs8oPYw8kpVuG2y1zaVnsHtu2SBy/
 Ay2v0ozxaHwd3htdV5VAEiE8cUBz3/+o/ANfwrLYVo1sC0cIuMQUQCLxuaeYZR0SRdVvPlE/n
 lbCAw0U6Nvz/Fs8rPEi9m5U1EuCplJLxW9juMVKcfaM6vDUHrKAYN34cBdXDV+0MMKrSbjAxs
 KEa69ASqvXVLWEYbh2gJsYK9XUgY=

Am 01.04.25 um 17:01 schrieb Patrick Steinhardt:
> diff --git a/parse-options.c b/parse-options.c
> index 35fbb3b0d63..dbda9b7cfe7 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -172,25 +172,50 @@ static enum parse_opt_result do_get_value(struct p=
arse_opt_ctx_t *p,
>  			return (*opt->ll_callback)(p, opt, p_arg, p_unset);
>  	}
>  	case OPTION_INTEGER:
> +	{
> +		intmax_t upper_bound =3D (((intmax_t) 1 << (opt->precision * 8 - 1)) =
- 1);

Ugh, how does this not overflow?  The macro maximum_signed_value_of_type
does a similar calculation better.

> +		intmax_t lower_bound =3D -upper_bound - 1;

This depends on two's complement being used, which is bad for purity and
portability to obsolete machines, but probably OK in practice.

> +		intmax_t value;
> +
>  		if (unset) {
> -			*(int *)opt->value =3D 0;
> -			return 0;
> -		}
> -		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
> -			*(int *)opt->value =3D opt->defval;
> -			return 0;
> -		}
> -		if (get_arg(p, opt, flags, &arg))
> +			value =3D 0;
> +		} else if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
> +			value =3D opt->defval;
> +		} else if (get_arg(p, opt, flags, &arg)) {
>  			return -1;
> -		if (!*arg)
> +		} else if (!*arg) {
>  			return error(_("%s expects a numerical value"),
>  				     optname(opt, flags));
> -		*(int *)opt->value =3D strtol(arg, (char **)&s, 10);
> -		if (*s)
> -			return error(_("%s expects a numerical value"),
> -				     optname(opt, flags));
> -		return 0;
> +		} else {
> +			value =3D strtoimax(arg, (char **)&s, 10);
> +			if (*s)
> +				return error(_("%s expects a numerical value"),
> +					     optname(opt, flags));
> +
> +		}
>
> +		if (value < lower_bound || value > upper_bound)
> +			return error(_("value %"PRIdMAX" for %s not in range [%"PRIdMAX",%"P=
RIdMAX"]"),
> +				     value, optname(opt, flags), lower_bound, upper_bound);
> +
> +		switch (opt->precision) {
> +		case 1:
> +			*(int8_t *)opt->value =3D value;
> +			return 0;
> +		case 2:
> +			*(int16_t *)opt->value =3D value;
> +			return 0;
> +		case 4:
> +			*(int32_t *)opt->value =3D value;
> +			return 0;
> +		case 8:
> +			*(int64_t *)opt->value =3D value;
> +			return 0;

Do we even need all these sizes?  Or can we whittle it down to ssize_t?

And for which quantities do we need to accept negative values anyway?

Ren=C3=A9

