Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6723C0A0B
	for <git@vger.kernel.org>; Tue, 12 May 2026 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618670; cv=none; b=UIyey4jdsQb6W4vwzf1MYyldi72+Q6oAOY+IMnutGJrcm2x98ieg3JN2BYuduoG05JNH0szDV2tSKc/PIpQXaA7mHFT8Qff0PRC/mz5Sdn/h8qGr0MqQJpnhhPfPD/nlfcelPukCKwF241me2tdMVSGtxDYy4M1hVo5jSacwdfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618670; c=relaxed/simple;
	bh=LyF1gEFdllD4CG5Nhl6iVGzFehAL8j5C+djh0pteUug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKw+whSwufgQjHhmE0odq0VSZingyUTh8gHVh7xp6v+AXZJ0nPd9N4zKrFWGWHSpTbDPGO7L5QbA5FYfheR9lj9pIjnVyRAqhaUyylKJqGVysuMfYHpvnx6bH8p5MkoqGd16cq5N03ldLvbE5nSViWVOM9fXhK/d5FFCIX/mvlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=I+xFIMNa; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="I+xFIMNa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778618662; x=1779223462; i=l.s.r@web.de;
	bh=yUdZodF65P24nBQwoWusnhUyR37DS4x0A9woHtgsL3A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=I+xFIMNa/hSQ8ahymbF6ZFlCBktk0hU8mVp3afyq5Ta2viAfyID2LxKIRgR+IAjO
	 M2CxdSvJsvVyISQ2fqwrn40xvsMO79jYjyEixvRbmLTiPR99usKApTtYkqmpG5nwo
	 GZVtsH4fnoWHI47EUlcOVlpccEzVuESku+C0Jz4kQYsR3Ox7XtQiH2aBEEWc0/YQF
	 oysP3vFf6PcHHXl8FJ9+rZg9VLlJNQxEmUb2Js+5zoEjhHtumL3K0gvifNz3ps8s/
	 MpMibEJBobpCuXxVUCazcz9sdZojkoS9VkIYP1PQpEJnfuy+Dzcgel2YEDk8JmW8Q
	 pf7norMY2UcNMYY/9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsrhK-1xFq4E1wG8-013Qua; Tue, 12
 May 2026 22:44:22 +0200
Message-ID: <2f45a33b-5945-431d-97a5-7d61e271cfba@web.de>
Date: Tue, 12 May 2026 22:44:21 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ls-files: use strbuf_add_uint()
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <20260512115603.80780-1-l.s.r@web.de>
 <20260512115603.80780-4-l.s.r@web.de>
 <20260512190105.GE70851@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260512190105.GE70851@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qP0+vd+dbzxtydm1I9186xqrLVlk9owV9ISw0OXy5DZuGsPLqH8
 lL0W8B4+BHWhP39666U8u/UJKq6MIgUBC3wJUTVSpMans2fyFaKHsBZ5P9rz7W7/Z761OQS
 5l7Rzqn58nj5IQX/uE06Qsi2V6h8T3NqGJG3oZ4dVQ83alWdcn6e+qadYT0HqQZ4uXowo7q
 Srp8LQhZFFFgOviPtKmtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9m8JJbFMNM4=;o7Lio3ycbVEw8iAUEHOJIeRzYO1
 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

On 5/12/26 9:01 PM, Jeff King wrote:
> On Tue, May 12, 2026 at 01:56:02PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>> Speed up printing of objectsize values by using the specialized functio=
n
>> strbuf_add_uint() as well as strbuf_insert() for padding instead of the
>> general-purpose function strbuf_addf().  Here are the numbers I get whe=
n
>> listing files in the Linux kernel repo:
>>
>> Benchmark 1: ./git_main -C ../linux ls-files --format=3D'%(objectsize)'
>>   Time (mean =C2=B1 =CF=83):     257.3 ms =C2=B1   0.4 ms    [User: 197=
.4 ms, System: 56.7 ms]
>>   Range (min =E2=80=A6 max):   256.7 ms =E2=80=A6 258.1 ms    11 runs
>>
>> Benchmark 2: ./git -C ../linux ls-files --format=3D'%(objectsize)'
>>   Time (mean =C2=B1 =CF=83):     253.4 ms =C2=B1   0.3 ms    [User: 193=
.6 ms, System: 56.6 ms]
>>   Range (min =E2=80=A6 max):   253.0 ms =E2=80=A6 253.8 ms    11 runs
>=20
> OK, so here the improvement is less impressive than the previous commit.
> And the code is...
>=20
>>  {
>> +	static const char padding[] =3D "       ";
>> +	size_t min_len =3D padded ? strlen(padding) : 0;
>> +	size_t orig_len =3D line->len;
>> +	size_t len;
>> +
>>  	if (type =3D=3D OBJ_BLOB) {
>>  		unsigned long size;
>>  		if (odb_read_object_info(repo->objects, oid, &size) < 0)
>>  			die(_("could not get object info about '%s'"),
>>  			    oid_to_hex(oid));
>> -		if (padded)
>> -			strbuf_addf(line, "%7"PRIuMAX, (uintmax_t)size);
>> -		else
>> -			strbuf_addf(line, "%"PRIuMAX, (uintmax_t)size);
>> -	} else if (padded) {
>> -		strbuf_addf(line, "%7s", "-");
>> +		strbuf_add_uint(line, size);
>>  	} else {
>>  		strbuf_addstr(line, "-");
>>  	}
>> +	len =3D line->len - orig_len;
>> +	if (len < min_len)
>> +		strbuf_insert(line, orig_len, padding, min_len - len);
>>  }
>=20
> ...also less nice. We are formatting into the strbuf, and then maybe
> memmove()-ing the result to accommodate padding. I wonder how much that
> affects the timing. It's extra shuffling, but memmove() etc is often
> surprisingly fast.

I gave my objectsize and objectsize:padded numbers; the difference was
1.2 ms, albeit with 1.0 ms noise in padded case.

> I wonder how bad it would be to handle the padding ahead of time.
> Obviously strbuf_add_uint() knows the size of the result right before it
> calls memcpy(), and it could insert the padding then. But adding a
> padding length parameter (let alone the space vs "0" decision) to that
> function feels kind of gross.
>=20
> In the earlier patch I raised the notion of pre-computing the output
> length. If we had a helper to do that, it would be pretty easy to do:
>=20
>   /* noop if third parameter is negative */
>   strbuf_pad(line, ' ', 7 - decimal_digits(size));
>   strbuf_add_uint(line, size);

I started with a struct numbuf for holding a number string and its
length, which helped avoid the memmove(3) call.  It's simple and
doesn't require a lot of code, but introducing that concept felt a bit
much for just two users.

> You could also imagine a world where we had some stateful formatting
> system, and you could say:
>=20
>   strbuf_pad_next(line, ' ', 7);
>   strbuf_add_uint(line, size);
>=20
> but somebody has to store that state between the calls, and I don't love
> the idea of bloating strbuf with it. So probably you have some
> "formatter" struct, and it operates on a strbuf. And now we have all of
> the OO boilerplate hassles like initializing and tearing down our
> formatter object. ;) So probably not worth it for this triviality.

Terrifying!

> Having it all in one string ("%7d") is nice and concise.

Yes, except the original code includes the 7 twice (again for the
"-" fallback).
> I have often wondered how hard it would be to implement our own
> vsnprintf(), and whether we could do better than the libc ones. It would
> be nice to be able to add shorthands for common types (instead of the
> unreadable PRIuMAX mess), as well as custom ones (e.g., hex oids).

C99 has %ju for uintmax_t and %zu for size_t.  Hmm, do we actually
still need to avoid them?  CodingGuidelines says "the C library used
by MinGW does not" support it.  82c36fa0a9 (submodule: hash the
submodule name for the gitdir path, 2026-01-12) just added a %zu,
and there are lots of them in compat/mimalloc/ in Git for Windows.

An extensible printf-like formatter would be nice indeed.  I wondered
about how something like that could be used to write structured output
like tar and zip archive entries in a terse way.  The thought faded,
I guess, when I found no compelling reason for that compactness that
would justify the required complexity of the mechanism.

Ren=C3=A9

