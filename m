Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE3366DA5
	for <git@vger.kernel.org>; Wed, 13 May 2026 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694380; cv=none; b=sDzOnmpdTtqsFBjLJeNEUujqoqti1H52ZiD9OHRhFGeLM1n1GqNKFHhxA716Tkr/gyFzO3eywjSZU4HimgGHEOVAuCidjYrKXGwS1kNp2LbdfpGpzmKdyLZnN3u/bJHyHT4jIU52iHWogwO8ZyoXsDcOqDNvfHlpjN/veVdysUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694380; c=relaxed/simple;
	bh=rP7JTjlHhwZEa0P4t/EZQa0Xd+FjWint0ju4HepdjIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHwGvVEMaFbS62dEkhxyX9av2JAabG0rhCH0LzmzhjUK1Cyu+FnB2lJpaiKVeVY7jfMCi2SQBwt6p+8iQL3ZZrmGUpBUoEgL+Mh4dP5X12EEAarXYhmZ5rabGamsUVxMa/Y7GdpzVIkXFFIL/yAszQ0dQl7fHzvofxnlhyXFlZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=AG+zsKTf; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="AG+zsKTf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778694372; x=1779299172; i=l.s.r@web.de;
	bh=y9G5Hc+X0kkLVSZLlX6ZTKnefFyt88A3NkPwXNSDDjc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AG+zsKTf7bgsBnpW/h193M+JSW95wRD/KLoJLI2dIQ9ejEdR3U8c2ri1FSpS2UZB
	 9AqWqDTBrk+5ZCcnTLaW+YXMI+O7REtG6PZoeHnNOB39dJuBZPKeN+/ITH3pI3U0k
	 UTcksgicJCIL+dSHF1OiFM9nZWzDR0X/qN+s2gFj6E+vGw7oTWYF49BQQmRce/wOh
	 yfXn+gU3AdNAVDIa0Lvb4XZziA8FFBEPKmjX9HCkncAbx+DUDAuGIQtahnvpmlvpR
	 xrTHfH1WYNXQjSY57qDfN6tPaKM84pPYTOuLswPBwED2+lRQyFmO7tB+WzksZIkuw
	 0IcCoTPLLptwatnjMQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mcpqo-1wwpao0KTi-00iHLc; Wed, 13
 May 2026 19:46:12 +0200
Message-ID: <9e0b4f9f-ffcb-4dad-bd4f-295bbc011a1e@web.de>
Date: Wed, 13 May 2026 19:46:11 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] strbuf: add strbuf_add_uint()
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <20260512115603.80780-1-l.s.r@web.de>
 <20260512115603.80780-2-l.s.r@web.de>
 <20260512184238.GC70851@coredump.intra.peff.net>
 <60b1ef2a-3b12-449e-be0b-cb206425c80c@web.de>
 <20260513162232.GB103037@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260513162232.GB103037@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J5nDlcT+/oEG/UlNxrPkKprEsvtg7nrJSKbfQyzNf8t4DD62iDF
 yyXaRl2kXl+Q8mrZueMXeLne3fHYAul0ui3foH83PE0O/7jS3c/6UsFxm5F1mzfPlJOA9zU
 1CiiL9UuI3E/v44unVa3ROSlkLFD1xegBBC1WutGuHmdPCqe70zbJoHJ1zsnmcxUH0efYTK
 FMiW5wAW9yvHwLa7/6nuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1p72htDuz9g=;uxww107PT6kaSXDdNhByLJR3Vb0
 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
 LQWWTFNRX6RFDbs9W9e0MvSw==

On 5/13/26 6:22 PM, Jeff King wrote:
> On Tue, May 12, 2026 at 09:32:09PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>> The three variants were close in my tests, the no-copy variant slightly
>> winning on Apple silicon, but losing slightly more on an AMD Ryzen
>> laptop CPU.  So I went with the solid choice of using an on-stack
>> buffer, same as in printf(3) (at least on BSD).  Buffering at the end o=
f
>> the strbuf was not really faster; perhaps memmove(3) is just that much
>> slower than memcpy(3).
>=20
> I'm not sure if you did these tests initially, or if I nerd-sniped you
> into it. Either way, I am happy to be able to hear the results. ;)

Did them before I sent the series.

>> Perhaps an optimized decimal_width() could change the picture somewhat,
>> but I don't expect a big win.  On the other hand I just told you how
>> unreliable my expectations are, so there might be treasure after all. :=
)
>=20
> I got identical times for cat-file's %(objectsize:disk) running your
> version against the one below.

Similar here (git_stack is this series, git_clz is your patch on top,
git_dec uses pager.c::decimal_width()):

Benchmark 1: ./git_stack cat-file --batch-all-objects --batch-check=3D'%(o=
bjectsize:disk)'
  Time (mean =C2=B1 =CF=83):     383.5 ms =C2=B1   0.8 ms    [User: 374.7 =
ms, System: 7.6 ms]
  Range (min =E2=80=A6 max):   382.2 ms =E2=80=A6 384.7 ms    10 runs

Benchmark 2: ./git_dec cat-file --batch-all-objects --batch-check=3D'%(obj=
ectsize:disk)'
  Time (mean =C2=B1 =CF=83):     382.5 ms =C2=B1   1.0 ms    [User: 373.9 =
ms, System: 7.5 ms]
  Range (min =E2=80=A6 max):   381.2 ms =E2=80=A6 384.7 ms    10 runs

Benchmark 3: ./git_clz cat-file --batch-all-objects --batch-check=3D'%(obj=
ectsize:disk)'
  Time (mean =C2=B1 =CF=83):     382.5 ms =C2=B1   0.5 ms    [User: 373.7 =
ms, System: 7.7 ms]
  Range (min =E2=80=A6 max):   381.9 ms =E2=80=A6 383.6 ms    10 runs

> Not wanting to figure out all of the
> off-by-one corner cases myself, I checked stack overflow for an easy
> recipe but couldn't find one. The version below was generated by
> chatgpt, which looks plausibly correct to me.
>=20
> -Peff
>=20
> diff --git a/strbuf.c b/strbuf.c
> index 9731ecdc1f..c26614a698 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -361,16 +361,52 @@ void strbuf_addf(struct strbuf *sb, const char *fm=
t, ...)
>  	va_end(ap);
>  }
> =20
> +static const uint64_t powers_of_10[] =3D {
> +    1ULL,
> +    10ULL,
> +    100ULL,
> +    1000ULL,
> +    10000ULL,
> +    100000ULL,
> +    1000000ULL,
> +    10000000ULL,
> +    100000000ULL,
> +    1000000000ULL,
> +    10000000000ULL,
> +    100000000000ULL,
> +    1000000000000ULL,
> +    10000000000000ULL,
> +    100000000000000ULL,
> +    1000000000000000ULL,
> +    10000000000000000ULL,
> +    100000000000000000ULL,
> +    1000000000000000000ULL,
> +    10000000000000000000ULL,
> +};
> +
> +unsigned decimal_length_u64(uint64_t n)
> +{
> +    if (n =3D=3D 0)
> +        return 1;
> +
> +    unsigned b =3D 63 - __builtin_clzll(n);
> +    /* approximate floor(log10(n)) */
> +    unsigned t =3D (b * 1233) >> 12;
> +    /* correct if estimate was low */
> +    return t + 1 + (n >=3D powers_of_10[t + 1]);
> +}

Clever.  But it seems for smallish object size numbers at least dividing
by ten repeatedly is not causing a bottleneck.

Ren=C3=A9

