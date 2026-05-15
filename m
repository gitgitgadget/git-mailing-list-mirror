Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EC837C0E9
	for <git@vger.kernel.org>; Fri, 15 May 2026 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827655; cv=none; b=mr2HtN2OHZCQu7Maa/clMtX4BrIuYBQDfTn2xOOMtJiqCoJTbimukVo5NanIKQpdnEaVnu9Fe1iwnSGWj1aVM1Cu+C8YlmZ7Qna2K5ysaAbwkCgP1ZN0pzcYuHgl068FZdRfvC3IulmkXgnDR06z3SU4P4sxX+wqhnL2sAj9LJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827655; c=relaxed/simple;
	bh=oiLweR8C7jX/xYLQHfsuk6w3+Km2IKXCcr5xFoVBVuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkGzd4oywguv+shQrXu/oe6g0c/XaBM/YEf7Y9Hk0XLUetKRcCkUecvd+dCvOAEQT6hHRVVzmTcyA4wtfP1WH5dvohA0uq7CYSDbYWoBZVnOOW36yhrQniWUwEYLsHfJqViJhzCgKbsdEUL3tltUYE4GfTYYsHfiKPZM5XE7JeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=L5wDlY3+; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="L5wDlY3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778827645; x=1779432445; i=l.s.r@web.de;
	bh=M6IrPZV/ygKFwXD/p+gsWnqO0v2NNit1yGJ8RJ7eMWs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L5wDlY3+ljKdLdjd8N380CLM7t/5VJQjsFXzHNVQ1GwK7CuR4vncjdYDHqLMmhYO
	 puPIYGvsaWlWb4w8ifRJ3Lw5eu6IYaEaPyW7saT/tde2rBgf3opIYYitpEUQk3AYQ
	 FAsUfMGa51aaBgvUZEFf/eLh6M4NnLN2s3oZELYTi0Y240U8akKSco6VvJIqcQBF+
	 uWEE925KXxKhl2J8WwkFVCSmhTzPsqCh6v2xz1+UzTxYcwdtthmOvd3KcG3v0+WqX
	 lBiPbaD4YoRh9NbrFbvtDPik+dOn+/j4mO0pEbDsgCnXyuHhHDjpm3oD2OmnQ8ASe
	 stlFDXJtmrz3oSWQRA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUCut-1wnrt03arL-00Oiu6; Fri, 15
 May 2026 08:47:25 +0200
Message-ID: <0b673b25-1f0e-44f5-b24c-7f7183d58cee@web.de>
Date: Fri, 15 May 2026 08:47:25 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] trailer: change strbuf in-place in unfold_value()
To: Ramsay Jones <ramsay@ramsayjones.plus.com>, Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>
References: <9629b0c1-b28f-4cd2-8d59-67d909ca9052@web.de>
 <a4da346d-3800-40ea-8828-970b15088bf3@ramsayjones.plus.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <a4da346d-3800-40ea-8828-970b15088bf3@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BwYvTJMsKNabFst0xi004E9jNAA4mFp8+YKPuP77tq+qvbld5YY
 Wj2b3ZFOomQy8CwrL3pVU0ZGAko+fKLZ0j9owKAhlfUJQY4yuxnsMlz8qyT01d57gaWf4Nk
 g6do9Vvgflw3HCh86V8n2sjbxGo9YE+MY1kOBLH30caYirJStwIoCsZN1ZUp27DKj55IKxK
 CInjx169lcztfU9FdCpHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V/TzrbQPZ0E=;RnDF60pqwZLRbktEPlrLRyLqVtG
 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
 it6SOlDEqZu0EQw==

On 5/14/26 11:30 PM, Ramsay Jones wrote:
>=20
>> diff --git a/trailer.c b/trailer.c
>> index 470f86a4a2..b89fa12fe7 100644
>> --- a/trailer.c
>> +++ b/trailer.c
>> @@ -988,29 +988,25 @@ static int ends_with_blank_line(const char *buf, =
size_t len)
>> =20
>>  static void unfold_value(struct strbuf *val)
>>  {
>> -	struct strbuf out =3D STRBUF_INIT;
>>  	size_t i;
>> +	size_t pos =3D 0;
>> =20
>> -	strbuf_grow(&out, val->len);
>>  	i =3D 0;
>>  	while (i < val->len) {
>>  		char c =3D val->buf[i++];
>>  		if (c =3D=3D '\n') {
>>  			/* Collapse continuation down to a single space. */
>>  			while (i < val->len && isspace(val->buf[i]))
>>  				i++;
>> -			strbuf_addch(&out, ' ');
>> -		} else {
>> -			strbuf_addch(&out, c);
>> +			val->buf[pos++] =3D ' ';
>> +		} else if (pos !=3D i) {
>=20
> Hmm, isn't 'pos' strictly (always) less than 'i' here? (note the post up=
date
> of 'i' when setting 'c' at the head of the loop).

Ah, yes, good find.  Initially I used a for loop which incremented i
only at the end, but converted it back to minimize the patch and
forgot to adjust this comparison.

Ren=C3=A9

