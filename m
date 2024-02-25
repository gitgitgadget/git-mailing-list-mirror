Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB94156C2
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708885714; cv=none; b=bJgc9DubIlv4sAauraZ0C83Ir0AzOeVQpX/JNa2iMR4jzDjy+emoZuQ1BtUgSQC92CFPuhkcnGqNCj4wd9l0yMhtSnv2vpmU6WirxfV1Y2uQrhCX8tN4G2VvcmhkN70Nfvvl5HGifN40EJ7qSyATFTrn3RHjc/gQLxzWlm/GqBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708885714; c=relaxed/simple;
	bh=tZ2HSnCHxN/sWRoVVup1DD/gAxAGRb73Q+eNef4FRPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5T79m0hTwQfUiWfq9u8ZUm5x6+OIk/DYOqGX00y/K9A/2+S2yTNrKitI7p8n00hmsyiZZX1VfVmHywWrjRprG3E6tpDXK6y0fXk0boc1utuB6MhjZfzlJsudqawPQnSCNi93Tmg3WGg4uM75aU4WbTxhgkl3s5YdFpJ12ljFoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=UStYAkSi; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="UStYAkSi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708885707; x=1709490507; i=l.s.r@web.de;
	bh=tZ2HSnCHxN/sWRoVVup1DD/gAxAGRb73Q+eNef4FRPQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=UStYAkSiAN0b8ZegpTKH1uXl23EdtepukKU95mwI3ssTR0Tdf/7zqNRWHLZbO/BP
	 fAnx/hGKJJG3MUrXOoKZdpF//fJXUljLrWfR5x74I0yRCDyQmqAx37iIg0CgRhi3s
	 TnmBjttnd+7Sjyg68XIog8zn9NomiHn8f1jJzWIK0CtyQi3eV6cwHdHEqNE4BbZYM
	 uNrAcf/wF+q87EcNKvEnbzkc5FCj/XNxBQ60GqZN5kXHZkTTZtdfWbylxnTIAg/00
	 vglfZIl0PmtX2Z11nJnMz0dOpzsK/acKvPe0mSyt5Or+JdX0lhL+UP1J4u7eognAK
	 Wahe92EY56DgDBxgbA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Md6tt-1r49Ci2AYl-00Zpmp; Sun, 25
 Feb 2024 19:28:27 +0100
Message-ID: <5dea0535-4b21-483a-a10a-bfa8e9e85650@web.de>
Date: Sun, 25 Feb 2024 19:28:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] t-ctype: allow NUL anywhere in the specification
 string
Content-Language: en-US
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
 Josh Steadmon <steadmon@google.com>, Achu Luma <ach.lumap@gmail.com>,
 Christian Couder <christian.couder@gmail.com>
References: <20240225112722.89221-1-l.s.r@web.de>
 <20240225112722.89221-2-l.s.r@web.de>
 <CAPig+cTvs7Ckg=k1T+N3N=yT840xM2DYf3LV9NZhii8+c1nkbw@mail.gmail.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAPig+cTvs7Ckg=k1T+N3N=yT840xM2DYf3LV9NZhii8+c1nkbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J5Pm814SmN8ZgPGHyXFaou0iXJM8NsiYdAkUoalWB8CqzelCwkM
 Jrfu3HGRg45FeRI4x27+M33h6sBvV1vRE2raravsHBVOXAdrCQNBYVNIRRaxgfis19S72/R
 dQj+W5pVEh8+7oZq1tMYgjzVhRbpOIZkiz7wZd1GyAExw2tcuQwE3yu6Y5jtzcBSU4bUcKc
 deWrMC8ev0zOAne/R7dIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IoAoHCiUXO0=;gFIgNeYrVXxk+fELKlDP6PjE/Nt
 kLVJ81HaZxkTj9seVrCnQIKOKjGPxlVZZh9jNctYQBjAXHs9ZHs5N5Z9wB6bpfwnCaq647hfy
 JapzAWXGwNMPvFPpze36AB81qBWTXusqNMf07++azv7NSKDHwaKe5L4us5d9Q3PdLr73NB9nM
 w8FMsFTEXN6wOs3WUlp/dJajYzXpj43DB2CZp8s4OFTtThPXZt8Jy4bzaoDkRbHIjwOZGdrng
 b4dSx0WF1Wq/J8NToaqxN3wRqutGNP1kdUXFBOtQd/YJO5ua4/DmfkcGD3Jnn7V+circT3+u8
 OdBDwjWKHHcXtAZonkEUFE+6zBBqINiOpwEcIinFDgZ4FrGBeU/XvcIfI56gCujErj1YK+C6a
 sWPCQGyHpyPaeu7QmlrNm6Tai6j50gblqEbFQoKxrNPDrj0QBjDTA+1OPBXP9YaUU6WhzBUFY
 5lysmtsEXfi4tI8pUQRwgLf8pUdmjEBl5wrZ9j9Bs5L30DRnOqYt2s+HVsD24oSd+D6DwpNSd
 +IuGAlIOvA5Y+aztJ4c7MJoDtyGHERpI5X/v+hBnleiFyaxbwzMDulwfPfTSSyhrvL2XlP1e3
 IeLqS60WJkt7PCJVol8bjNPlNgR70GEhvq16BpYxsrEk1H3az3vt5M/Ee31ch91/t1L/nJcZ+
 PU8BL7ba6psv6CfVzA41sCoNA38kPu3JS1GsS2Xd/fYAg9ZtIGzNp94e1xI07JQGGWtC0mp+N
 MfrKgaJCN2Or5DhOCXbx1O+/Nz9KhyJ71/fLoCtEX7A2S+1lxe5XX8uyUiWYVMuEzQy0vTpCR
 X2CJO2meMx56pV5QxQrAFQA3l/y7HJBxa7uObpP1/1o/E=

Am 25.02.24 um 19:05 schrieb Eric Sunshine:
> On Sun, Feb 25, 2024 at 6:27=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de>=
 wrote:
>> Replace the custom function is_in() for looking up a character in the
>> specification string with memchr(3) and sizeof.  This is shorter,
>> simpler and allows NUL anywhere in the string, which may come in handy
>> if we ever want to support more character classes that contain it.
>>
>> Getting the string size using sizeof only works in a macro and with a
>> string constant, but that's exactly what we have and I don't see it
>> changing anytime soon.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
>> @@ -1,23 +1,11 @@
>>  /* Macro to test a character type */
>>  #define TEST_CTYPE_FUNC(func, string) \
>
> Taking into consideration the commit message warning about string
> constants, would it make sense to update the comment to mention that
> limitation?

I think the temptation to pass a string pointer is low -- if only
because there aren't any in this file.  But adding such a warning
can't hurt, so yeah, why not?

>
>     /* Test a character type. (Only use with string constants.) */
>     #define TEST_CTYPE_FUNC(func, string) \
>
>>  static void test_ctype_##func(void) { \
>>         for (int i =3D 0; i < 256; i++) { \
>> -               if (!check_int(func(i), =3D=3D, is_in(string, i))) \
>> +               int expect =3D !!memchr(string, i, sizeof(string) - 1);=
 \
>> +               if (!check_int(func(i), =3D=3D, expect)) \
>>                         test_msg("       i: 0x%02x", i); \
>>         } \
>>         if (!check(!func(EOF))) \
