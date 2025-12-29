Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8EC3A1E94
	for <git@vger.kernel.org>; Mon, 29 Dec 2025 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767038530; cv=none; b=WU6J0TLyiBgLHu+bKTQ8xoUYEBxvDHzDwkC9oUyJV79+Q9t9OQ+Wus4jZ7D2lLdG/RmcGOf40bk0CmEJn8Ty95URsn1xXReuiOELSmPWrJ7Za4nCe1jrKqtS1OfaRLzonYvoR9mGq4r0U2lMXYMxRy6bbF4SZRyqHRnyq1EZshM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767038530; c=relaxed/simple;
	bh=6bmUY7yk35NVaQ2tS6fNHfX1USIn24QhWT7FMzyWVH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HUh05MgD8P7iQ0Wl5/KXKz8JKuYc+NgqAtkL9UlpUaaSP7+J7ts4BiCfhpErDnfRat25+2jiaqemiBYtjsTqLB5Ud2VdxuwKv0Zbm9K8o9fi/Z4nGdM7GRNRJpA0x08xIRS9Ja3koTBaHM2kFjKUiPXxSeqEPi0aXhv2UE56nFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=HXWcnO8e; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="HXWcnO8e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767038518; x=1767643318; i=l.s.r@web.de;
	bh=nXTnUyob6vm6jwO1BXDmez67GOkqju+T9MZ5M2Ma7L0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HXWcnO8eg26zx36WjyKYNsmUjyK23X9HF3dTHEwUL7TPe8rqUZh0DSNjTy7G3PpL
	 M3a/Y+oD+uZYHZGJ6XadMwgtO4FnHQD/dTi5jftRuCmzpWt3PCltEWISDPcVCfqQI
	 RJtCd5fu8ibJsQr+t4zH+ruKIldRkoCSx301GyRTTby2ZTc40wkqOg4e21V7lWSZG
	 YMaH4ynWt4ScacpZ1f/YbCKAvxE90crAPvBkqUuLZaLKLOeEDVpjnK4AwK9zj3g+1
	 QCNIMKIia3sAZqZ5uHXZXf2vhPmzn/auCd1omt8kdq7v0KJXGGoV8ipl1ku3LNIqc
	 RyNkkUsGqaS1WnnWmg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.18.156]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpCqh-1wGniT2uf1-00p9xE; Mon, 29
 Dec 2025 21:01:58 +0100
Message-ID: <c30ebbab-e303-4301-971b-7ff619389597@web.de>
Date: Mon, 29 Dec 2025 21:01:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] show-branch: use prio_queue
To: Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>
References: <70ed751e-fc3c-4cb4-a4fd-26094a9f622e@web.de>
 <01d09293-4b60-4a47-9350-73b1ff796c9a@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <01d09293-4b60-4a47-9350-73b1ff796c9a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z3ymlh+zy8GXr0pU5gfSEfAwcsVabMs5eUCUEEI6N2J8e4s8V/1
 WQG+pFflpLazn5A3ntwF1DXlBsSRJI5rOwFxE3cCKFqc/fuagmvVXHxJTWW/2hRgeyQBVcV
 EkHgY3hVndefdLVh4hR/WVxMWNzvz+JSdpe9IM/8vc+rxyHSYDD1EA6JXJSTObFcqsSySRN
 jhgDRon9TjoMPM9UtGm7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FVVBbq+k2c8=;KXbmf60F2zJBZV9C2CZiG/e1kKE
 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

On 12/29/25 7:09 PM, Derrick Stolee wrote:
> On 12/26/2025 2:44 AM, Ren=C3=A9 Scharfe wrote:
>=20
>> That number is not limited, though, and in pathological cases like the
>> one in p6010 we see a sizable improvement:
>>
>> Test                      v2.52.0           HEAD
>> ------------------------------------------------------------------
>> 6010.4: git show-branch   2.19(2.19+0.00)   0.03(0.02+0.00) -98.6%
>=20
> I love to see improvements like this, even if the construction is
> unlikely to exist in reality. I do think it's likely to be valuable
> for some large repos with many parallel branches.
>=20
> Indeed, I tested this patch against a monorepo with lots of merges
> with hyperfine, getting this output:
>=20
> Benchmark 1: old
>   Time (mean =C2=B1 =CF=83):      3.303 s =C2=B1  0.146 s    [User: 0.05=
8 s, System: 0.069 s]
>   Range (min =E2=80=A6 max):    3.162 s =E2=80=A6  3.631 s    10 runs
>=20
> Benchmark 2: new
>   Time (mean =C2=B1 =CF=83):     141.7 ms =C2=B1   3.2 ms    [User: 30.5=
 ms, System: 93.1 ms]
>   Range (min =E2=80=A6 max):   137.5 ms =E2=80=A6 149.4 ms    19 runs
>=20
> Summary
>   new ran
>    23.31 =C2=B1 1.15 times faster than old
Woah, the perf test gets a speedup by factor 46 in a repository
purpose-built to highlight this very difference, and here you get half
of that in the wild!  Interesting to see that there are real commit
histories out there with such a taxing topology.

And thanks for your review!

Ren=C3=A9

