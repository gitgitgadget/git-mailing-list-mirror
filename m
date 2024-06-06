Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D847374FB
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662516; cv=none; b=omVFBwF5LPEeFOgG2x5ysnGg2dmYzuhlr7bXWkHZth9CxhKNrNWwaLqZ1tS3c2cqP+X/pHxgZpkype6SFFEq+GRKe51S+CbRzmQkM3qV4FlbFnwiouZ6d1mlFQdps71OwI+imzIi7hJoMKhM2iYd6DxGXNRTcmb/CaBrJKt6Rp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662516; c=relaxed/simple;
	bh=EeqFRVhRVqMXIe0CFlq/SYs/r0D55b+pXPml855HEgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2k5MJkYJUNCubHrN76SYP2IKwFJBRKZIjfxAxSsubP1T6okw6e1891RW+zExtppRSbfXgfRliKPtwD4k5GGCeOCHf3oWz2CW+sf22Rx5PtwauZMj4wQ7cGaOK8oovpcjjAlzYQv6r2kHPJhQUpc7izd+1or3Ec5ifja3zk277I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=aXp9/17M; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="aXp9/17M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717662505; x=1718267305; i=l.s.r@web.de;
	bh=1Np4gL3Y7esI/jm6s92o0Dbv2LuVKfOJsfJSkaSHZh4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aXp9/17MMjGqNBqJWu0i2rFI6ccxWCBEN9V6H9o1gsNGzgdLaiicp0ikI94lytH0
	 RvDNSWKc7h9b+RcEmb3wEWmkroVTIyOXpnKvG+PBUdeJ2tQdiuBJ68T1wVgndxfAO
	 vWMSdF5Fy1OS6kwv/s7uCns+6FpQOUnifjxWNHMaZTCuLtDYx1/vFxnr+6Jdf1Z6z
	 aFYq4WXMH9gG4U89zaL1/htxDElxofI2kRWqQHCiNZRUqdETMdwcjrq1YbWXPKvsz
	 YP6YT8iv6oy2BWgX4jH2EMztzubKyB8MnDscozbd+53qWrEvCxwOgslpaS9QyKSle
	 jwld4l8zIpDrV8Fk9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7Nii-1sMpaX1z4u-00FwuH; Thu, 06
 Jun 2024 10:28:25 +0200
Message-ID: <55389f35-5762-4b86-81bf-b9fe956815d2@web.de>
Date: Thu, 6 Jun 2024 10:28:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] diff: let external diffs report that changes are
 uninteresting
To: Johannes Sixt <j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>,
 German Lashevich <german.lashevich@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
 <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
 <6fa51a62-5dc1-4865-9f79-eaf7d65189ab@web.de>
 <99a99e5c-4fe4-413a-9281-363e280716b8@web.de>
 <1c055e96-76b0-4174-a8e2-cb6df041fabf@kdbg.org>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <1c055e96-76b0-4174-a8e2-cb6df041fabf@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gohe+1PyPDaxYYhwms3P5IplJ5/dttk9WtbH1Le+KYHw93BdglY
 OwHjE7+4E8UGpZkYlPsTUjvf+33imAqcvLbr20i9vPX59QU92ma4NatVQrLF0/fmp9XbBxa
 UqJ3zq8yPjt0RsGR2JmNe0U4CpGXncMLstJFZL5WiXQdyp9f11F7W+1OGneZpsev9NCsWvT
 /SVjG4seTPGB306iFKViQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rmqxFZ+wT84=;xUuVaLDz1YfU5b+DkHWChQk7HNC
 yVf8L9rWYzZWdfZt7ri2I7l1v+1oUWNKmd/rAVBN/1eVjGN6ys5x4P7UBEvXSg12DQDFt6XXC
 FJdsKKnr3UAos6CpBUnC7YB5+Dc1kj0YGv8gg3Xg9/zz/MsmZErMvwOMjQqoIJsPIkxyPxipU
 eEbCEAyYCltiQnTTTNBgfVpgq/BBVN5CiTp4R+6l2Rmnxtkm7MvIDQU1XW2Gcujs5XYK4t4V9
 m16yinJyoqPYXhsqUcbizfuAnprvlTZm/aRoZz5n8e/d9W5tYUAH//ieZsp/3e/YcbuuEHSbW
 SsASRECn/crWK8DS5I6q0cMWNEkZetKt3I9A8Np5d1SQzB7Ij8pY5i5sA3yCPdVphAYDn0ahs
 TfXPeV/K+qDJOuvzV0DgDFVwAVDVzZ+6Rumta6XRBV0lPmHZ/yQkeGUeiCHi7pyltbhjooyuX
 G6oq2JgKp7yblOB3S7EsWgOXe+GSNY2ko2NaPwhbEPXtFo0TSr7AqTfvNhNnIB3IuMrMx5g9H
 4nB6qGAYakYzctLo7ANTdnVa1JDZy+lnbiM26SNFERyVN2vnelIdTC/Xjq5+XKzec7Zde9pi2
 evlFM48gSM2YD4x4Z77spWqZ6w6kxXEV0P7EgiKvWkS1VT79V3ESfpqmQsi8RyVF1sQsXZN4t
 dN2R3lq2AXZje1QGVK4c+Ulqjrp92vSrkzhwYglMSZMfShhrtzTo+gYx/JqUXvWFy+IRkz4ft
 cLcehdaQpHsulTzrknHXVsBBnHyycuuUcWnlMdtSjfXWZtDDmhO5Ye5IKMK5DXBRt+eiUrE9k
 YTb1eAZz4dO8EIVC3ggheAAw+MtHs/4x5nnaGjKRKMvWs=

Am 06.06.24 um 08:39 schrieb Johannes Sixt:
> Am 05.06.24 um 10:38 schrieb Ren=C3=A9 Scharfe:
>> +diff.trustExitCode::
>> +	If this boolean value is set to true then the `diff.external`
>> +	command is expected to return exit code 1 if it finds
>> +	significant changes and 0 if it doesn't, like diff(1).  If it's
>> +	false then the `diff.external` command is expected to always
>> +	return exit code 0.  Defaults to false.
>
> I find this somewhat unclear. What are the consequences when this value
> is set to false, but the command exits with code other than 0? Is it
>
>     If it's false then any exit code other than 0 of the `diff.external`
>     command is treated as an error.

Yes, unexpected exit codes are reported as errors.

If trustExitCode is false and --quiet is given then the execution of
external diffs is skipped, so in that situation there is no exit code to
expect, though.  Not sure how to express it concisely, though.  This
attempt looks a bit bloated:

=2D-quiet::
        Disable all output of the program. Implies `--exit-code`.
        Disables execution of external diff helpers whose exit code
        is not trusted, i.e. their respective configuration option
	`diff.trustExitCode` or `diff.<driver>.trustExitCode` or
	environment variable `GIT_EXTERNAL_DIFF_TRUST_EXIT_CODE` is
	false.

Might be worth documenting this original behavior somehow, anyway.  It
makes sense in hindsight, but surprised me a bit when I wrote the tests.

Ren=C3=A9
