Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F6D18ED8
	for <git@vger.kernel.org>; Sat, 16 Dec 2023 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="MDz3OHT3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702723591; x=1703328391; i=l.s.r@web.de;
	bh=CJ+UEdbHeSh6f1Cr6RrGL0yyV1a8uScDS6uVqkmj3v8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=MDz3OHT3xvCYle2ibtLz1K2yS/S9BDUJ4ke4TvZhjPz1JGRmyaoXOPz1AVWDTMss
	 hroTe0oy5JOAR/AhGJRyRjStzctfc27XRy7TNcKVrjxYTgMHJwDRl08cu6epcJ2V9
	 +pu4UUMN2XJupWvyBkRasnBq64FQySP8i/kkMgI0QqrE9bgClUB0Pj+Ay+FLXG7VM
	 BpMbXu0PH5UEgOPOiPycyV6w+Q+OLhWfEV7QvzW2TnhByqQ9fhPCcD6dQfrdFG5WZ
	 CGCKxq2tvOGLBIfPLbf7lDA19rQwqqNptHlfUfYJd18WlhoO631CWTuNcBG1Y9jCo
	 55fS3LSia+ZJkOcI0A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mc1ZT-1rkVQ01q7L-00d8Bd; Sat, 16
 Dec 2023 11:46:31 +0100
Message-ID: <b3c0c52b-7e12-4068-99fd-07fe4fa3da7d@web.de>
Date: Sat, 16 Dec 2023 11:46:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Use ^=1 to toggle between 0 and 1
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: Jeff King <peff@peff.net>,
 AtariDreams via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Seija Kijin <doremylover123@gmail.com>
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
 <20231212200920.GC1127366@coredump.intra.peff.net>
 <8bea38fe-38a3-412a-b189-541a6596d623@web.de>
 <20231213080143.GA1684525@coredump.intra.peff.net>
 <4d0b2a5f-305b-4350-b164-44923cb250d8@web.de>
 <20231214220503.GA3320432@coredump.intra.peff.net>
 <99b3a727-36fd-4fa5-a6be-60ae6fc5911e@gmail.com> <xmqqo7erl7er.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo7erl7er.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lSNBmIe665Hq2FBdYxJfmg0EKg/wO4DseEj5xpot9SzP4ArWSlv
 WiW7A+sKCSscPqbMTEGu8fb776NQJ6Z+Ay6cxBZMI6JwQRwoZlOP1hJubdeIkhDLiEiZcsj
 jV8y/IXruu4qZvtStb9ZgNLZ2xJLgyIOtmlOUYoFP5/TF4vFMby8mt/AOZEnjh64opguzWs
 OfZJMBBLvt8uhsTMEuWuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kv0ZIdZynZc=;/He17rEgyz+MBt6beDl4eqjXfVx
 SNkwljFfVPpq6dEwcJ5M2SjNUTbPcSbvT2g3Q1ivb3SUp1A28hf0QYdp+IPOPrU6l/nglsBuz
 5tNVolUKYD2iMBY262RpdVNmMy6Fiz5oqMkl9k57IbTT7bRHJgsgRsyjGO8jmr8RKN4sNqdiH
 aEJHXOi+n7+DwR56mx5gyf5FHNnFHCrDvK6ylWJBJ9pmwI1VAq6k653lm1bKjXNY6tzVM3qVQ
 1KCK/XO8SyxlpSAVaMjwzQRY7BGtqOZowGP0K3qbk4HRnIk0NK8Vdik5rpEduIh9Y2KlFh9Vn
 i3ESMJWiWVSlSbe+mUIHK931J8KjxJQMxYFc7MV215zxo5YAEtzvFdeVMrFWQi+SEsj0pO1ZH
 EdGldA3cqnJxZvipuC56+ojkmQWCSqX9ETNJM/MQdWglMQTKrKwja0N4RV4fuey57aqYSKr+S
 sOqiKhnPzhXRZ3JJw93E5Z+Q6yGm4C0PhutKFsiv5cd/A1EZYzcaNWbjoqnH8F0fHjfXgkjp5
 fdKUmNaT0aHjsPQGk3xkUXlIXonqQx8O9y7OvtUlf+xFGUPlPdPUK0Gjci0o01j3UcMHRgG3U
 1MH4oB2jrWmCrQwYu5Neoap/JYlwpzWQhlyLsI5IYQGS6rrwkWCTP1MX0h64YxykUhIPN/Y8/
 dkce2bJfAuhcaWo6Wsbvo9AdoHNtjR8ey2/Vmh8/VdO9wtmkOnG94fkjnso8Yw2BM7CTrPmd+
 i85S9CNM9UkxlY8DE0wG20iH9KA6+h+XqC4N1JAEaGHrSolOSrgFKut9nWh1D5vxJM1VDmPT1
 5f0mHMiSDLsjpriZpMX9ZZwASHpptCkfJ0HOAGILzCoGh1KcNuRbHS+W+VnZCVTd3VGIocJ2T
 sQw0gSAfLtx/f5l8NJArOlhU5lZV+zQn0G0xZmviIvdzUGHmz/vIz5gUPpnqKfny78FEj2xfN
 RqYxroXQT9nqB4cAGJQ13jYzb5I=

Am 15.12.23 um 18:09 schrieb Junio C Hamano:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> Even if it unlikely that we would directly compare a boolean variable
>> to "true" or "false" it is certainly conceivable that we'd compare two
>> boolean variables directly. For the integer fallback to be safe we'd
>> need to write
>>
>> 	if (!cond_a =3D=3D !cond_b)
>>
>> rather than
>>
>> 	if (cond_a =3D=3D cond_b)
>
> Eek, it defeats the benefit of using true Boolean type if we had to
> train ourselves to write the former, doesn't it?

Indeed.

>> [1] 7bc341e21b (git-compat-util: add a test balloon for C99 support,
>> 2021-12-01)
>
> Nice to be reminded of this one.
>
> The cited commit does not start to use any specific feature from
> C99, other than that we now require that the compiler claims C99
> conformance by __STDC_VERSION__ set appropriately.  The commit log
> message says C99 "provides a variety of useful features, including
> ..., many of which we already use.", which implies that our wish was
> to officially allow any and all features in C99 to be used in our
> codebase after a successful flight of this test balloon.
>
> Now, I think we saw a successful flight of this test balloon by now.
> Is allowing all the C99 the next step we really want to take?
>
> I still personally have an aversion against decl-after-statement and
> //-comments, not due to portability reasons at all, but because I
> find that the code is easier to read without it. But in principle,
> it is powerful to be able to say "OK, as long as the feature is in
> C99 you can use it", instead of having to decide on individual
> features, and I am not fundamentally against going that route if it
> is where people want to go.

C99 added a lot of features, but we already use several of them.
Support for individual features may vary, though -- who knows?

E.g. http://www.compilers.de/vbcc.html claims to support "most of
ISO/IEC 9899:1999 (C99)", yet _Bool is not mentioned in its docs (but
__STDC_VERSION__ 199901L is).  It's not a particularly interesting
compiler for us, but still a real-world example of selective C99
support.

The table at the bottom of https://en.cppreference.com/w/c/99 would be
useful if it was filled out for more compilers.  And it also doesn't
mention _Bool and stdbool.h.

TenDRA and the M/o/Vfuscator are the only compilers without stdbool.h
support on https://godbolt.org/ as far as I can see, but that website
doesn't have a lot of commercial compilers (understandably).

So I guess in practice we still need to check each new feature, even
though in theory we should be fine after the two-year test.

Ren=C3=A9
