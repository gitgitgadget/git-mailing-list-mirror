Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91332528F3
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455698; cv=pass; b=fpu5OK6l2J8PJ2eW/S8Y/HYpws6S1Gc9im74P3IN+vWiY8kBZSJCdSWWij72Iu9nmPG5Phd2hzN6JlAJgPLGI1IaGYrrGBDzCyRZmis7Pc2hOWLn/OCuXGngMF3Xe3ApDX10QiSZZiC3QHpiWy8WFnzG6zaLbyhYQ72Yi1tQxtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455698; c=relaxed/simple;
	bh=+fsWZyeHZ+OyEBRC0vOqquE17wAdK6oW1ywgc6BJkIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifxMlllZxHTGQAbcpSWqxPENfB2hkOp13Uo6dGhMaggP4qKppHEZv91TNbqEFbREBOXlD/EihNQII40rKVnKm2l/sIPkgmCJvck92ZdC1U+qLAiUDEoNLM/KyTU1ApWARhW4ZqRODmt1RXGdZi6jI14zNb9YbSIE006eygmagKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=IsEogt9h; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="IsEogt9h"
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R10" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4bXHhF3J5cz3Gfj;
	Wed, 02 Jul 2025 11:28:13 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "smtp.freebsd.org", Issuer "R11" (verified OK))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4bXHhF2CZrz3btR;
	Wed, 02 Jul 2025 11:28:13 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1751455693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zNxNGxSxFZUYyXzyFNG5WrT+h87lBM1A3Mye/3fN8QU=;
	b=IsEogt9hVEt3wP7BVRfaFfrBJAQsp0GmkuVyipqQ64xcfNavq8EKZdMFU8QCq85olO8ZlP
	atd3eukWIVFeweeQM0rovZPIsGhMJSYi2pkzRk59BTUqNuvN0joTJpIpQeIuCisPauHi8b
	uluDUCv4SbSsM7HqEFiuYKcwjwx66toswZn/1fiJr9KUUyTpLUYr3L4vSGU7xlIRNjwOsZ
	Q35gCvvsbTFVa97eUHKX4fQuYR+Xvwevi+ySEgw5OMaATecPm5EWKPU1ViW/5Jj6TJOWPv
	ClRJ7eaQ+bfBCZFDYjRd7ONnllUKwae9ucfGx12HuICKZVgI15cGZUpTWLdJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1751455693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zNxNGxSxFZUYyXzyFNG5WrT+h87lBM1A3Mye/3fN8QU=;
	b=DMAjY4x0MAzrmn55h9S9or+zsQY6D9u1DgSr7+bH33WOB8xEQWQbHXYm/OGUXQLt8dF0WT
	FRNbjvXy+KyLozhKTWoGDCYMH0Lr+4xhbHFUT3CqE/zHRHJt4hHMdV9EFPC6GhGTYjVs9G
	ZpcSeEHafFTp04DlKCzDkTWPEolohdtOK+woqr3HaZcoUAzwbIoaoGKmMnX1a3sv7LGu08
	UJcxTxQut9IZsO162R07jbbL9k4TTOPZ/P/jCYGabQHz9Cr3yDNQhmxQQrLXNqPikyCKEv
	pMl5IvpqaKL2BI0nEYyjDh7RD+0oSTRQAKQg1ruXpobVtOLyYFafc0EG0QMe2Q==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1751455693; a=rsa-sha256; cv=none;
	b=qqw7Ec9vT9rg0uPw6MP3MSkoVg41cXigLrqVPxyK0u3X1LvmJAhZN3MMQhDZ0MYjEw9wKw
	8joGm/07osj0gExjIf91ZTOoO6aMuhke8OP8RUNgBCd5CQ7h+OzFUMQrF+r+wwIxi9xsNM
	x7TqSzBtnjoDWsmUBJ7wZIp8wqr/BocHRMcd8EVCzEQiN6pGkIuU1m1u+VbrMAjtWMcCvJ
	0pMVwSeY0U0RrxZo2f1kUlsKfDylLgDNvpVCruSfjJUq7Wy2dORSwjJx/TVZ0vc5na0m3E
	eIlMOumc0ITVX6GB5DJJr83hkHDpfIdQIxmniNofIeKlQPIzznAaBkoXk9FPkw==
Received: from [IPV6:2804:f1c:851:ac01:8109:c30d:783c:bf9e] (unknown [IPv6:2804:f1c:851:ac01:8109:c30d:783c:bf9e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: garga)
	by smtp.freebsd.org (Postfix) with ESMTPSA id 4bXHhD3gfqzZLV;
	Wed, 02 Jul 2025 11:28:12 +0000 (UTC)
	(envelope-from garga@FreeBSD.org)
Message-ID: <818958f6-7387-48f8-a0a8-c050af212069@FreeBSD.org>
Date: Wed, 2 Jul 2025 08:28:10 -0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: build is broken on FreeBSD if libsysinfo is installed
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 GIT Mailing-list <git@vger.kernel.org>
References: <f32292e0-4c99-47d0-8eac-21dbc5aca302@FreeBSD.org>
 <9dce7213-0b8c-4636-ab37-4c26081aedf4@FreeBSD.org>
 <d3b912ca-ba5a-4b56-81d1-0e8a10055d83@ramsayjones.plus.com>
Content-Language: en-US
From: Renato Botelho <garga@FreeBSD.org>
Autocrypt: addr=garga@FreeBSD.org; keydata=
 xsBNBGStavwBCACjNlp/9+Y+VFe9ieR2h/WWbdvjz4Mb2z/f22bGoaskzCfvVNbo/v3i34I9
 H6OdgZkGqheQEAD2jNfRbmPr4z40xDMUpYGLds+1Mvg7G3Hms3j5Ef8KaLSWUNWIfwKdfSVR
 Qs35ccSJxAdRW5YdI6J3xZgika+3Bc4eJ05YE/nWW+PNTYevt5rqD50N3zybVYIcLoqVPpBi
 AZE/sf5SLiLACIJb1t/s4x+pi8vgWevxVVT9u8V1f8zYErmHSLSqjxii0B3eRZphX9NCJOv9
 +tfFZhnENInhn9gT7H4e2YumUltEy3jacONHJF3CC1pvvWEa6lEyypclMOkHQwNON7DLABEB
 AAHNLFJlbmF0byBCb3RlbGhvIChGcmVlQlNEKSA8Z2FyZ2FARnJlZUJTRC5vcmc+wsCXBBMB
 CgBBAhsDBQkFo5qABQsJCAcDBRUKCQgLBRYDAgEAAh4FAheAFiEERL7Dxegbnh7xTiQ5Ob6P
 xxJcZXoFAmSta78CGQEACgkQOb6PxxJcZXrYlggAgaZmr6c1yIWzN8VksHrHpwt/uxONEP+h
 ljy3yfrMsgfS5wx5Uzgfih1xYZUFC6jiI63CetqBqJpp3g1klRS1UWYKx2NeXphDMYZEdPm/
 a6sXh4bKZbk6IE8Yn0/YiRT57d9DtbvswC7Gn7Igj/MSbhl49TvTGyvuB6juaffVoYZViomx
 5zMoee8Ml2o2qj3MrCJ+/K8GU54RlpOGqGRsqdwVdr9XEWub6fF2YFwR46cjmbiU3P5urFHH
 nkJlBGPIwKxHimTW0lZsdx9aCKRDd/D80/WOEzXmk3k8B9lv/GsvOluHmveLhJG1R1tIJ31I
 f2q8dfTvqsQXnu8CcWRcgc7ATQRkrWr8AQgA1DufoxScA+CWQbUR6zExIu8wXQKrhuRt4DG2
 BgynT7EMUvEBadcbQRZXsBpemNfncc9Axyut/+rWiyKJf9BLQuo/9QYmSRvW1U6+0LJUYmdg
 kMyBeYaPk+vnssv/u9jLuvV7FVgyE0yk1iaWIKOVDD+XrQCOvGw9uSceBrQyCyo3A/eRM/+p
 vnDCaywR63PKE+3axk6lfNdGK3TnaWmS30/ZDCZlNsXuqprqR4JdT5wXids5o36dsuJ5EZ20
 s5hNMD34s4Yr1Y1R9elH6qBsFCpozs0+jwrArxq+UJJCR6hH5W8ZEwJtRC8tzR8mRE1WywzX
 BXYj0YhfGztQIxZckQARAQABwsB8BBgBCgAmFiEERL7Dxegbnh7xTiQ5Ob6PxxJcZXoFAmSt
 avwCGwwFCQWjmoAACgkQOb6PxxJcZXr1vgf/SKXhoZcUU5I7TqcbHg0lJz9tICTupCGHWr/s
 SQgjh9oEM5j1wqW7FlCGP90Tl9K0g3ow9YdbhU7VK470o6pymX9V9eLHzGgkZO/KMEtGBeK1
 u+5ePjCJ/MK5B21KODLSU7WrIL1VN5ceXfQPLYt02LMLtPri+oduHD6RNBeA7US1DUzleq5F
 9NHGbvV2U7BdDUezpiO8NaFjFZVB11I5d99FxUM5XGVstI3VhsRKZxjY0KnqJzaQgTFsPGmv
 AUfZVIN1pXgXiedhPXpr8+Y64jP+pHVwpVmh1zYWL6+q3kqFOUVP6c5iiMeoEXZvgJz7x/AC
 ek3X5gvu8Hpcv+MZIg==
In-Reply-To: <d3b912ca-ba5a-4b56-81d1-0e8a10055d83@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/07/25 17:03, Ramsay Jones wrote:
> 
> 
> On 01/07/2025 17:05, Renato Botelho wrote:
>> On 23/06/25 11:09, Renato Botelho wrote:
>>> FreeBSD has a libsysinfo package which contains GNU libc's sysinfo port.   Some users reported git 2.50.0 was failing to build when this port is installed and it happened because configure script detected libsysinfo but -lsysinfo was not added to LDFLAGS, ending up with following error:
>>>
>>> scalar.o common-main.o libgit.a xdiff/lib.a reftable/libreftable.a libgit.a -lz -pthread
>>> ld: error: undefined symbol: sysinfo
>>>
>>> This patch [1] was added to git port adding a user option to enable/ disable libsysinfo dependency and fix LDFLAGS when it's enabled.
>>>
>>> I'm not sure about what is best approach for git project in this case.
>>>
>>> [1] https://github.com/freebsd/freebsd-ports/blob/main/devel/git/files/ patch-configure.ac
>>
>> If someone let me know what would be the desired approach here I can work on a patch.  Would you like to make that option conditional as the patch did?  Or detect if OS is FreeBSD and do something different?
>>
> 
> Ah, Sorry for the late reply, but I was away ... :)
> 
> Hmm, I can think of several approaches we could take, but I can't test any
> of them (since I don't have access to a FreeBSD system).
> 
> - it would not be difficult to add a 'library-check' to the configure.ac
>    file, so that '-lsysinfo' would be added to the link. (We would also
>    have to make a similar change to meson.build). However, I don't think
>    this is the right solution; I'm guessing that the compat sysinfo library
>    is implemented in terms of sysctl() anyway, so ...
> 
> - we could simply change the order of the preprocessor conditionals in
>    'builtin/gc.c' L530-541 so that the 'HAVE_SYSINFO' block comes after
>    the 'HAVE_BSD_SYSCTL' block. (BTW, I assume that the HW_ symbols are
>    defined whenever the 'sysinfo compat library' is installed; i.e. old
>    versions of FreeBSD which don't define them are also too old to support
>    the compat library).
> 
> - we could suppress the setting of HAVE_SYSINFO if HAVE_BSD_SYSCTL has
>    been defined (in both configure.ac and meson.build).
> 
> I very quickly knocked up a patch to do the last option above (I moved
> the setting of HAVE_SYSINFO down the file rather that HAVE_BSD_SYSCTL
> up. I guess it doesn't matter, but I gave it *no* thought!).
> 
> The patch is below. (I didn't write a commit message ;) ).
> 
> Does this work for you?

Your patch works just fine for FreeBSD.  I tried it with libsysinfo 
installed and it just ignored it, as expected.

I didn't test meson build since FreeBSD ports is based on autotools yet.

BTW, should I start moving the port to meson?  Is it the default build 
method now?  Is there a plan to remove autotools?

Thank you!
-- 
Renato Botelho

