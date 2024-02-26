Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540B612EBEE
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971439; cv=none; b=KRINnM6HBjJ6l9itdeloKCd8USA0t6xBtAqgi7SqKC5LCN4r71VrnBhsXrVxF2yYncYLY6Uc6OEjVkbAjgA1ApOoJ5pdjTGMkEDSqD+IxgGx/xS7sxks2Tdz6T42bEbXLsad1lOjOkGijhjgWZeSVTo7jByBxUxokPw2DL9AW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971439; c=relaxed/simple;
	bh=/zrKp1I1xtoLdpGqFqcdZgU8Xu0WjJgdQo1MHjhsnHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZ/BPgJ8N+uzh9b0W55NZdxK7aaMDVsdc5ii6FcZQ3YvlO+jD29fQLjpQVDBBMQ7n7JygEXZikCTZ5Mtw+Ce1E4KbJHo6nZr/GzOdRUatIXYaNb7y4EMOGrA76rlCErjICYDlb3dkZFSjLmvIiI3ZteNQITlQ5yhe7QfTfOiSB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=jdimQ4hd; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="jdimQ4hd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708971421; x=1709576221; i=l.s.r@web.de;
	bh=/zrKp1I1xtoLdpGqFqcdZgU8Xu0WjJgdQo1MHjhsnHA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=jdimQ4hda4ngPVzdUQaNQJBvaLQ9CBP82RgJZuL36CtHyK4EHf7YNiUglJ180sth
	 WAFjsrViH+pscvjdypdHd+Uj/fFlfUxgeJL/EEWnyj+7FbpA5M/RVL8K2+ViYeR4D
	 ZuuYIkH5KOZzaJbKdguU9oGzQafpVjFylIBFwTd/6l2qLCb4+vbl5HZv6uEiNXnWA
	 n9ApaGhsABAZ+endbw8aktqWU1c89Nt2ptaNt2/MFkjKdTancFWDa9ittP/Ju8EAk
	 jOCct/DrJuHiJC88pFM+4GPRpFtzY0hwWdMLPM2HSvdeTeA7VlmHHKajoDSCiUFuM
	 8EOJ87NRNoGzoiYybA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHEbk-1rj5O03XaC-00DFo8; Mon, 26
 Feb 2024 19:17:00 +0100
Message-ID: <1868c502-b915-42fd-8cb2-efe90429f9b7@web.de>
Date: Mon, 26 Feb 2024 19:17:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mem-pool: add mem_pool_strfmt()
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <20240225113947.89357-1-l.s.r@web.de>
 <20240225113947.89357-2-l.s.r@web.de>
 <20240226070844.GB780982@coredump.intra.peff.net>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240226070844.GB780982@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wDn3E0vblpB0TUPYvT71gAvBeb+CpjeHaswcb/TrocuuV5Jw8Vi
 tf4lnnF5zLhIps2cD6obXi1LlLMVlOOvIcdDXQs8ompse1bvLgJoW7ljnI16+IGv4CKIBIX
 3+pmryH9dWHolm4cZqD4sOsSS/P+wxXylAf2tHIjCg+142+p/zK5xNv8iadsZHYUMeHe1EA
 kQ0HK5K79wFkrYiSC1yuA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A+XFDPlc48s=;4qJuQMGT0U2hr2R7RAjzV09W62r
 nG0xLEyjMN9M90r+YrqRw4gt9wiVnv6LwpxdWz7tG26zNtcX3RtLYXbC+xKu7jz/PxR5OAqdX
 lC836B+tYt2Kc5jiBPPlzuZKo7CUkcQrzyMDZKUgPFMhTPnXaD+yjjTWKqvaY7/H8BuVJGyUa
 Vy6JNMUQGFzKxySqSULfdwmT59s08y5ZdqIpu9hPskDik1Mw7zl8HBbIgakur9R3iW9yUn0Ux
 P28sQNRjF0caq2U+8LByRGbvwyldjU+/cUHM0euOV9Du3N6GXlMfwqvd0U8ohBjGNQveJ0a+S
 4HJAKiGJN3/5kyeFiKfHP4I6qR3VYKeF9ykyUlvGF2fUOOwCLw7kbk7CfB/nSmwhSf6JCl5Zx
 Ss9dgGtdwbHtvbltJfKBF49PZLSe6sGSWxPa0o6Z0tg/3EKjlIBT6NsKJoPX2+SVCRkjjjDxf
 lVlDZijxVBmCez7lLIz1JUVlXH3Zn6Bi2VATdEGmQVg/7sGz0czOUK4IPZ64cwK7EKJmm5L7+
 FFgGSqdkoSGm+jDMuujFDeW4cnib55P1dYL+bDz5I/Ab9P0Z2UsZWIMM3h2oX6lZeQyi3xw0j
 MI0v/GBKPZ9+Lh0A9RxW+OV0eqktfbwTpCpwFlQa2cii3SQQKKe9vmt/gIFcgHe0OWwE+Y7KV
 AZXs7/hGD2gxYdhYVigHMtehxD7roMm5vd0KBXsARALXBS/f0dv4FIGh8v4ylBNt8TjOE9fjX
 U/euLMatzoIXNuAOFPQC4BbZ+yd6q4+uopebXHfCYmL8hSpFaBQL+6oNV5ZG/1lgDuugCRcYT
 02UGS4sbbvd6T9AVItG294yMp7f9fYRA6mUyibbAGMG3Q=

Am 26.02.24 um 08:08 schrieb Jeff King:
> On Sun, Feb 25, 2024 at 12:39:44PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> +static char *mem_pool_strvfmt(struct mem_pool *pool, const char *fmt,
>> +			      va_list ap)
>> +{
>> +	struct mp_block *block =3D pool->mp_block;
>> +	char *next_free =3D block ? block->next_free : NULL;
>> +	size_t available =3D block ? block->end - block->next_free : 0;
>> +	va_list cp;
>> +	int len, len2;
>> +	char *ret;
>> +
>> +	va_copy(cp, ap);
>> +	len =3D vsnprintf(next_free, available, fmt, cp);
>> +	va_end(cp);
>> +	if (len < 0)
>> +		BUG("your vsnprintf is broken (returned %d)", len);
>> +
>> +	ret =3D mem_pool_alloc(pool, len + 1);  /* 1 for NUL */
>> +
>> +	/* Shortcut; relies on mem_pool_alloc() not touching buffer contents.=
 */
>> +	if (ret =3D=3D next_free)
>> +		return ret;
>> +
>> +	len2 =3D vsnprintf(ret, len + 1, fmt, ap);
>> +	if (len2 !=3D len)
>> +		BUG("your vsnprintf is broken (returns inconsistent lengths)");
>> +	return ret;
>> +}
>
> This is pulling heavily from strbuf_vaddf(). This might be a dumb idea,
> but... would it be reasonable to instead push a global flag that causes
> xmalloc() to use a memory pool instead of the regular heap?
>
> Then you could do something like:
>
>   push_mem_pool(pool);
>   str =3D xstrfmt("%.*s~%d^%d", ...etc...);
>   pop_mem_pool(pool);
>
> It's a little more involved at the caller, but it means that it now
> works for all allocations, not just this one string helper.

That would allow to keep track of allocations that would otherwise leak.
We can achieve that more easily by pushing the pointer to a global array
and never freeing it.  Hmm.

It would not allow the shortcut of using the vast pool as a scratch
space to format the string with a single vsnprintf call in most cases.
Or am I missing something?

Ren=C3=A9
