Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EF62253A4
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385709; cv=none; b=J38l/KeK/7LpyoIqsqWkDzGeqZ+Q3hXfddhFU+r0Puht/4z/ktdAT3bBmkVPefx8BqEY4PIHneinyYjJ+DZ3qeUFUrw1YD77pJsB6pg6dRgUfJfYGbynKFk9hCTd/03eWM8BzShd//zP+vfkeDFio57a27nYjaQNae3BM/cDw6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385709; c=relaxed/simple;
	bh=4v9LkZO/bdQ8NWL1z4AyK16MZQ0fN4WBxjlx+fr+3Kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWIpBdhmOLXUqfZYdA4Yre+xrmq9xH61sgKSvRiZyrPlmh1e7valojL+mhNRDVbdSd583BTLXoDhS68pyWuXk9gGgH53yk8eL0QNsyuMZKc9zArVkDxo1fHdsVNqMk6rnwyUDNIp86UWJVF6cj0a2VFeRZDfWxnG8QVdjW63/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=PTvL94dR; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="PTvL94dR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751385705; x=1751990505; i=l.s.r@web.de;
	bh=eenmidEx39RUxcXdSEiMZrLHdARs0xn4v4w9S47DMnM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PTvL94dRFq6IhRvQO2070Eg8LfdqQMXbCMYoPOTsz69YFmaTJ4ubSNkUVp06+NCK
	 LO5aSUxUtrx1OpgzUVR/wT4I2SnkvsYE8/eG7d2olsmSynvD4UPUKtj0ACbfa2hWE
	 T0RaqMq0QAB1PDt7J4ltG3OYM18XXu1Yo+MIW9fcDP1C06gctqZny0P+dnhHgDMPx
	 XqP5BcGEDao46SHRltl+69uvGBcfxPbjRjSWVKBTJjExAC5Be1+lIxhjfYOwuB63R
	 SbRiy58NoB+gJgvvHiReZNafI9ymhqAzx3BeLfNTs8F1IjWl4Ch2IiTrZQU6N9VO5
	 hO3/TAwB4lpMHMp9gQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMXx5-1uEpA61Sr9-00W4Dq; Tue, 01
 Jul 2025 18:01:45 +0200
Message-ID: <591d618f-1b86-414c-8069-3621e00add74@web.de>
Date: Tue, 1 Jul 2025 18:01:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] parse-options: add precision handling for
 OPTION_COUNTUP
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>
References: <cf5cd57d-733f-4239-80f8-23bdc1523ab2@web.de>
 <7322758a-9310-4892-b476-50dc57d559b4@web.de> <aGO-nSyCN7OD9Zae@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <aGO-nSyCN7OD9Zae@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SvHpyX4YucO6VAHYzYLrH7wkXkWiZeSIzcpfy7ms03UoMsGPtou
 AmKAL8KKLodBYp3wbxXG55cAIxctYf/9EHa71HSON/6JBQy36l5+rmkg7irsz+JVAgoFiYk
 /qPn7ENee4nTo9oK6Jh58cWr+NnRf75R8aZEPElGEpwDw7TwbgZ4l/CLYaHotvCn7lsyclV
 2bLifZTPCXlu1KEt/OttA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dzwk8voRt2g=;o/hjood0j6mqANxl/5QkGEqUcQ4
 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

On 7/1/25 12:55 PM, Patrick Steinhardt wrote:
> On Sun, Jun 29, 2025 at 01:51:36PM +0200, Ren=C3=A9 Scharfe wrote:
>> diff --git a/parse-options.c b/parse-options.c
>> index 0dc9b0324a..0dd08a3a77 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -166,10 +166,22 @@ static enum parse_opt_result do_get_value(struct =
parse_opt_ctx_t *p,
>>  	}
>> =20
>>  	case OPTION_COUNTUP:
>> -		if (*(int *)opt->value < 0)
>> -			*(int *)opt->value =3D 0;
>> -		*(int *)opt->value =3D unset ? 0 : *(int *)opt->value + 1;
>> -		return 0;
>> +	{
>> +		size_t bits =3D CHAR_BIT * opt->precision;
>> +		intmax_t upper_bound =3D INTMAX_MAX >> (bitsizeof(intmax_t) - bits);
>> +		intmax_t value =3D get_int_value(opt);
>> +
>> +		if (value < 0)
>> +			value =3D 0;
>> +		if (unset)
>> +			value =3D 0;
>> +		else if (value < upper_bound)
>> +			value++;
>> +		else
>> +			return error(_("value for %s exceeds %"PRIdMAX),
>> +				     optname(opt, flags), upper_bound);
>> +		return set_int_value(opt, flags, value);
>> +	}
>> =20
>>  	case OPTION_SET_INT:
>>  		return set_int_value(opt, flags, unset ? 0 : opt->defval);
>> @@ -630,10 +642,10 @@ static void parse_options_check(const struct opti=
on *opts)
>>  		case OPTION_BIT:
>>  		case OPTION_NEGBIT:
>>  		case OPTION_BITOP:
>> +		case OPTION_COUNTUP:
>>  			if (!signed_int_fits(opts->defval, opts->precision))
>>  				optbug(opts, "has invalid defval");
>>  			/* fallthru */
>> -		case OPTION_COUNTUP:
>>  		case OPTION_NUMBER:
>>  			if ((opts->flags & PARSE_OPT_OPTARG) ||
>>  			    !(opts->flags & PARSE_OPT_NOARG))
>> diff --git a/parse-options.h b/parse-options.h
>> index 8bdf469ae9..312045604d 100644
>> --- a/parse-options.h
>> +++ b/parse-options.h
>> @@ -183,6 +183,7 @@ struct option {
>>  	.short_name =3D (s), \
>>  	.long_name =3D (l), \
>>  	.value =3D (v), \
>=20
> It's a bit surprising that `COUNTUP` accepts a signed integer, so should
> we maybe add `BARF_UNLESS_SIGNED(*(v))` here?

Perhaps, but that would require more changes to callers that use unsigned
variables than I can stomach.  That's why I declared it out of scope for
this series in its cover letter.  Later, unless (hopefully) someone beats
me to it.

>=20
>> +	.precision =3D sizeof(*v), \
>>  	.help =3D (h), \
>>  	.flags =3D PARSE_OPT_NOARG|(f), \
>>  }
>=20
> Patrick

