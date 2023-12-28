Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C8F502
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="pKopoEh9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703779534; x=1704384334; i=l.s.r@web.de;
	bh=GFYkV2XW0vx2zJCRX726ZiGURsWu+zuN5RHO0pgDiWE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=pKopoEh9TlQyMwGOacJ/3OlgR1fDnjaAm9MH0tvIHQJqPNqu8ezmIbBbWGDEACSQ
	 wrq1kNeFKeNBxhZQ+w8SupwYagqMVPbeQv18g7Sk+Ah+D+6tc8QCKkv0bkgBjYqjK
	 iFQbJvDl1ZXvy6rZUaMnEhPNRdPWZbgE+lL6H6UjNJmPZCWciNLW1eOdw3CVKU/uT
	 BlS3WMEJW0BM/wrarzg/VN4qaHTDONCJE3jxC3piLQDoD5xE1VLqK5ocGXWIKDHen
	 8rCMDj5qtFr1UEOMhfBcUpeUaTMdN5a9e5tOQJ7zFEtwQ7gXJhHa2jYOW6UgShnDr
	 UR31/EAc79Ywxd9NaA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MadzU-1qhtNE1wRW-00c3Qd; Thu, 28
 Dec 2023 17:05:34 +0100
Message-ID: <e01be0ec-a054-42a1-8abe-6891c04b59a2@web.de>
Date: Thu, 28 Dec 2023 17:05:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Port helper/test-ctype.c to unit-tests/t-ctype.c
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>,
 Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org,
 Christian Couder <chriscool@tuxfamily.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>
References: <20231221231527.8130-1-ach.lumap@gmail.com>
 <xmqqsf3ohkew.fsf@gitster.g>
 <CAP8UFD1vC6=7ESx1w7S9Q9P0Bsc+c03wgHToNBaP+ivvm9BKBg@mail.gmail.com>
 <f743b473-40f8-423d-bf5b-d42b92e5aa1b@web.de> <xmqqcyurky00.fsf@gitster.g>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqcyurky00.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tEzQI70cXRzoJ0W4POGkUaN36qYqW/cnfoilgB7qBIEZCl8s8Fp
 SghiiU5STrPxBHjBuuBG/xmrh4jd9+3HAqF27tMKy94t+MHzbZf1Kwn46K3dQHv3F9LQmIx
 z+PWi8+Itw2O32+RZvD5gQtMsNy5g4gJMZWDfL3jsusfFkn+/mXUneMjZR5d3qD+6J5d8Y1
 AaU1v33Nn0Gn+XDOjLM5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JoyU3aoMdoI=;3BWrvpr4qQdk0qj/Vz3J7wf7TOI
 E3Td5ixun3c052KL6tMKUCilUwIb7+NtVvJkR8IcY3kTdtG+4RKHz0fabn13Y2/JAwUB+la6N
 Ynrpx6+ni8TaBfJyBufLc7/SlDe8o/90gt5Re6tWnkTqkEf2xYyJpey1G5akfP2V1avlXbaab
 TLcmFY38hKQw40WyeiamnKsQyzzsqwRGfY/p0SDBfFzuknCe4/X/EhXc5jjl1QMzINNq5n6cP
 2Ta2Ybb+Ujb/kq8iD9FAg1MwoM2MBtbE+GNfUw8NzGXsitpa0VvkjF99ekfo7IJoM1JoKQ7ir
 r7YtiJvuhGGNKzW90measPrMKNOc44KRKet0tWH7YN/pHdK4lRQ+H8yjTWXR1KBol25rJM+uh
 BXqnFlif5G2FuMdC98SE7R+SOjiaPtAcXz4K6g6MADaGVMQVZ3f8NSEO5B1+jdCcOdqHPZF5Q
 DVSMcc3fk17XGG44iYSnBmEQWiKvfViwmm3zRQUF2qs9jal8pcNVqVQ/kYYaR/z2FO0hs0eBF
 AILrjXBw9IIa94PHwolj8LPqJLd0TJnOuSuK435o9CqEUinw2Ov3kL3cad703mSJR9/z+tuIz
 u/b6dGiaTd5ZIKJPioY4TG130pI8k+2pHhDGYpmZyWm3TFoxl7mTp+tZdkzsMdWE4swxHj9Zu
 Y/yBVW8EWlqVvmz9Sf41js1Rz7F2tslvmInjoSTm6zUbC47HJSQjj3K4lFiUPYkit07tFdHqT
 q4z5dVCqc30HVHKtFF1gmWf8mGR+6Aw9QQFFiZ06X3O4bB9D2jZZjWt0zln+eqF2uM5YX/8F2
 sS1HdNr58kyeSB+TftOHeafDXiUC93yOC3StBgIepMLrmJqM0VPrDZiypGuojoaydgkT8oZuN
 vW+UOPB6+03LKS4aLHYxi/ZL0XkIQLNVaLD+p8VagalnbfmTBBZL+l4I8SoXQ/cBO0hUFVYAQ
 ACmyxQsN+xSO2rUmf0kN2mZ/uAs=

Am 28.12.23 um 00:48 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>> Also it might not be a big issue here, but when the new unit test
>>> framework was proposed, I commented on the fact that "left" and
>>> "right" were perhaps a bit less explicit than "actual" and "expected".
>>
>> True.
>> ...
>> The added repetition is a bit grating.  With a bit of setup, loop
>> unrolling and stringification you can retain the property of only havin=
g
>> to mention the class name once.  Demo patch below.
>
> Nice.
>
> This (and your mempool thing) being one of the early efforts to
> adopt the unit-test framework outside the initial set of sample
> tests, it is understandable that we might find what framework offers
> is still lacking.  But at the same time, while the macro tricks
> demonstrated here are all amusing to read and admire, it feels a bit
> too much to expect that the test writers are willing to invent
> something like these every time they want to test.
>
> Being a relatively faithful conversion of the original ctype tests,
> with its thorough enumeration of test samples and expected output,
> is what makes this test program require these macro tricks, and it
> does not have much to do with the features (or lack thereof) of the
> framework, I guess.

*nod*

>
>> +struct ctype {
>> +	const char *name;
>> +	const char *expect;
>> +	int actual[256];
>> +};
>> +
>> +static void test_ctype(const struct ctype *class)
>> +{
>> +	for (int i =3D 0; i < 256; i++) {
>> +		int expect =3D is_in(class->expect, i);
>> +		int actual =3D class->actual[i];
>> +		int res =3D test_assert(TEST_LOCATION(), class->name,
>> +				      actual =3D=3D expect);
>> +		if (!res)
>> +			test_msg("%s classifies char %d (0x%02x) wrongly",
>> +				 class->name, i, i);
>> +	}
>>  }
>
> Somehow, the "test_assert" does not seem to be adding much value
> here (i.e. we can do "res =3D (actual =3D=3D expect)" there).  Is this
> because we want to be able to report success, too?
>
>     ... goes and looks at test_assert() ...
>
> Ah, is it because we want to be able to "skip" (which pretends that
> the assert() was satisified).  OK, but then the error reporting from
> it is redundant with our own test_msg().

True, the test_msg() emits the old message here, but it doesn't have to
report that the check failed anymore, because test_assert() already
covers that part.  It would only have to report the misclassified
character and perhaps the expected result.

Ren=C3=A9
