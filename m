Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724FF187332
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738701; cv=none; b=ebyrQJ0at27mlFffGLtv9tdOnESNRDpOS7zfjkuN6qbB4EHBxkcG5E7xKFrggjrxx/6CbP15hOeqon8Go8PyQTH2B5KBVSd/C1DHmHbdJrcS2jQKw62PVE3rjFjtu6kEICx51kjo3NKdkoU3k/3GDhP8nCUevOcNPTpyMf780zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738701; c=relaxed/simple;
	bh=jfapx5UqlGB7GR0kxfaTP0G6g40eoo6XEeGpM25UlJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vaj+JYQSU0xvGWemMo43QK7uXDqBppRtaWO1+tjEAp9mpahVrnBdeO+gq1l54vqcBGx2cTPPsACEWVxDYyN0cELP6YdwzJ71T9QBbEYJfej/zUNZdTRi3LU7Rd+SXIcYW7bUM/iRrO8YdCBb9QK19kAVrT8sAajUrGOMMUV4+wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=tHUE3OfS; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="tHUE3OfS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744738685; x=1745343485; i=l.s.r@web.de;
	bh=4Un0k+ym0D/Yrsxrzbfq58rfmiJ/EIvT9nZVmr/D0H8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tHUE3OfS0+FDbFZhlocmEYsVTVCmEKyMFExEnAe/G6pfwbg82kTDSqZz55YP8Tke
	 cjTfPaK0LMZ2b5wQ9uGhaThwhe1GrydsvkyYIN+FFM1L0PZt7HGTodmEhVi6+U59N
	 zjM7ck+VYgvj6WY6xfRiiJR+hpm+sAbobsaf8Jm1zN3h/pXKXqMDCGBIKFCAHVqHc
	 BBF52DemslqEg5AIf7c6JIPwd7UVnpe+pxt7Yzy6I1Ud5F9i5d/6YrZzLbAe7eQuS
	 r5TkEM9/2WJSY2uzdyJwl0z68mvOrNArF2H0uUnznikGaJk5O5F+IA4lpi+TCvQNE
	 OZ1qOt0NH6hKB8ctcw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.31.75]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MD5nx-1twFm02hV3-004Ote; Tue, 15
 Apr 2025 19:38:05 +0200
Message-ID: <94f4ba9a-81a9-4e3a-932b-faee5aa2d2f4@web.de>
Date: Tue, 15 Apr 2025 19:38:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] parse-options: introduce `OPTION_UNSIGNED`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Todd Zullinger <tmz@pobox.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?=
 <szeder.dev@gmail.com>, Derrick Stolee <stolee@gmail.com>,
 Jeff King <peff@peff.net>
References: <20250415-b4-pks-parse-options-integers-v2-0-ce07441a1f01@pks.im>
 <20250415-b4-pks-parse-options-integers-v2-4-ce07441a1f01@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250415-b4-pks-parse-options-integers-v2-4-ce07441a1f01@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L7LXARVsMHDuPf7sG2qODSD6jck3ntFseGa5EZNVFis9yz44aRV
 99Vg7LRMwmNvSYzoDtVD60C3XOf2pelt8jFXzprhIFf+bD4ZSI4YUqWSmyVHDt1mwKHEyLB
 WGJurLTM3kbzEL98IonlzZ6UERbfaVB4PJmCLCcXwWoRvBUIIKK5EvR4KG3j9AOGFkndQjU
 P2GYA8NTDPH5eiUwVVi3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7rubhjqypHY=;IT9qYPvb06iWvUTXdCAgtKlpbod
 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

Am 15.04.25 um 14:14 schrieb Patrick Steinhardt:
> We have two generic ways to parse integers in the "parse-options"
> subsytem:

"subsystem"

>   - `OPTION_INTEGER` parses a signed integer.
>=20
>   - `OPTION_MAGNITUDE` parses an unsigned integer, but it also
>     interprets suffixes like "k" or "g".
>=20
> Notably missing is a middle ground that parses unsigned integers without
> interpreting suffixes. Introduce a new `OPTION_UNSIGNED` option type to
> plug this gap. This option type will be used in subsequent commits.
>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  parse-options.c               | 43 ++++++++++++++++++++++++++++++++++++=
+++++++
>  parse-options.h               | 12 ++++++++++++
>  t/helper/test-parse-options.c |  4 +++-
>  t/t0040-parse-options.sh      | 18 +++++++++++++++++-
>  4 files changed, 75 insertions(+), 2 deletions(-)
>=20
> diff --git a/parse-options.c b/parse-options.c
> index ae836c384c7..9670e46a679 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -216,6 +216,49 @@ static enum parse_opt_result do_get_value(struct pa=
rse_opt_ctx_t *p,
>  			    optname(opt, flags));
>  		}
>  	}
> +	case OPTION_UNSIGNED:
> +	{
> +		uintmax_t upper_bound =3D UINTMAX_MAX >> (bitsizeof(uintmax_t) - CHAR=
_BIT * opt->precision);
> +		uintmax_t value;
> +
> +		if (unset) {
> +			value =3D 0;
> +		} else if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
> +			value =3D opt->defval;
> +		} else if (get_arg(p, opt, flags, &arg)) {
> +			return -1;
> +		} else if (!*arg) {
> +			return error(_("%s expects a numerical value"),
> +				     optname(opt, flags));
> +		} else {
> +			value =3D strtoumax(arg, (char **)&s, 10);
> +			if (*s)
> +				return error(_("%s expects a numerical value"),
> +					     optname(opt, flags));
> +		}
> +
> +		if (value > upper_bound)
> +			return error(_("value %"PRIuMAX" for %s exceeds %"PRIuMAX),
> +				     value, optname(opt, flags), upper_bound);
> +
> +		switch (opt->precision) {
> +		case 1:
> +			*(int8_t *)opt->value =3D value;

uint8_t, surely.  Similarly for the other casts below.

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
> +		default:
> +			BUG("invalid precision for option %s",
> +			    optname(opt, flags));
> +		}
> +	}
>  	case OPTION_MAGNITUDE:
>  	{
>  		uintmax_t upper_bound =3D UINTMAX_MAX >> (bitsizeof(uintmax_t) - CHAR=
_BIT * opt->precision);
