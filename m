Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374D3A5442
	for <git@vger.kernel.org>; Wed, 13 May 2026 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691352; cv=none; b=vA+kIqSRVbe6JfXYXerZl/utL9msVt5JW9vEr5yjyGV5JKNgYiec7dfMS8tjr0IUkjOPGGnb8r8suUD6sieylaEd7LsGPy3aEEh9UkB/8L3IYsq1Ar8WmXyFx+elzSNcu7NTW5dNUWILTeuCIqCvQf3LoTI3DyExicmksrkOICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691352; c=relaxed/simple;
	bh=suoXPyCcqQMbIjbxLq8OW/pAuZLWBRr7romE6yyxp3I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kfDXXYATA9vYbfJ0nnZLuEzT3q5aPju3eDXgT19FD3aWIhvh6ra2NqwbhMn7ODBzPcCRGl496NqGH4G385H0ZdsWTCbI64lFUoH1Gzme6mb5eRUwAPE2xC6e/dbZu1zszDX984H97aRHeQyBRuLRH/vQV7t3/vuClM46ZnWYals=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=mUDVgTy1; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="mUDVgTy1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778691348; x=1779296148; i=l.s.r@web.de;
	bh=g2Oh5utJQ/jjqCBbywtdUInPmibxfMIjloFofxJ3RHs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mUDVgTy180bwbhNThCjNdHZON0uURqvBZhCm4QLNhcsnRt8YNHHVdxsHwqAaEgRJ
	 IeWdzD9O5zxetToWQf2MqnKSC4LL6lFIMzLcOtG8n1rm4VYv966X/4NY1ghIhaeJV
	 0KEVSzOiaRILm9uCZXxipY0cUUNM4snUdEuO43URIenW+9HghzarhiGL8r+zw/FXP
	 IYT1aTiB2Xnrb/XRTJFroNk3gM8+zF9vREVHr3K4ArJCYVb70ImmlgxOop2TgKNZD
	 1Ujg6IuQjYHYueEx4+asukPCVe8OGA3ncy+LX1bsJD7RAeTOC+O7m+wLiKDnFFHzS
	 aYfLQ4cmgPdQjX75pA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McIga-1wxM2Z3n7k-00m8CY; Wed, 13
 May 2026 18:55:47 +0200
Message-ID: <a427dd4d-773c-45e4-87a7-3adb6f04dfb3@web.de>
Date: Wed, 13 May 2026 18:55:47 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] hex: add and use strbuf_add_oid_hex()
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>
References: <183aa0fd-d455-4ec9-9c42-d511fac8b3e4@web.de>
 <20260513160155.GA103037@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20260513160155.GA103037@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DqNrjb+PN4Sup11TjMuk4Nol8H0FWYYWnw2SGxxUDvt5s6qvdxe
 EuUe9N8oyhEH9mzvNTbWgLskZ1rLIhhQrAbnCJE9GfmD9shsbsdfsVnRvivYeSYlLovIOm1
 PpOADSFLfi5jk5hXaBjxWJd+14JHn44S+u0L5U0sp8V4SLi5Nmr7v41+CY7jyinfdbQPC8w
 EPy8xPdFVg5Wz5kertYCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y1K1UmuqUEg=;KFM4AKXS0EZ0zG9hV5PEn/Riv43
 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

On 5/13/26 6:01 PM, Jeff King wrote:
> On Wed, May 13, 2026 at 05:49:11PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>> Add a function for adding the full hexadecimal hash value of an object
>> ID to a strbuf.  It's thread-safe and slightly more efficient than usin=
g
>> strbuf_addstr() with oid_to_hex() because it doesn't have to determine
>> the length of the string or copy it from the intermediate static buffer=
.
>>
>> Add and apply a semantic patch to use it throughout the code base.
>>
>> I get a tiny speedup for git log showing a single hash per commit:
>>
>> Benchmark 1: ./git_main log --format=3D%H
>>   Time (mean =C2=B1 =CF=83):      91.2 ms =C2=B1   0.7 ms    [User: 51.=
9 ms, System: 38.6 ms]
>>   Range (min =E2=80=A6 max):    89.8 ms =E2=80=A6  92.6 ms    31 runs
>>
>> Benchmark 2: ./git log --format=3D%H
>>   Time (mean =C2=B1 =CF=83):      90.5 ms =C2=B1   0.7 ms    [User: 51.=
0 ms, System: 38.8 ms]
>>   Range (min =E2=80=A6 max):    89.2 ms =E2=80=A6  92.3 ms    32 runs
>=20
> Probably the most extreme benchmark would be:
>=20
>   git cat-file --batch-all-objects --batch-check=3D'%(objectname)'
>=20
> which is really just dumping the oids from packfiles. I got ~3% speedup,
> though like yours it's within the run-to-run noise.

Hmm, should've lead with that; on an Apple M1:

Benchmark 1: ./git_main cat-file --batch-all-objects --batch-check=3D'%(ob=
jectname)'
  Time (mean =C2=B1 =CF=83):     117.9 ms =C2=B1   0.2 ms    [User: 111.3 =
ms, System: 5.6 ms]
  Range (min =E2=80=A6 max):   117.5 ms =E2=80=A6 118.5 ms    24 runs

Benchmark 2: ./git cat-file --batch-all-objects --batch-check=3D'%(objectn=
ame)'
  Time (mean =C2=B1 =CF=83):     109.9 ms =C2=B1   0.2 ms    [User: 103.2 =
ms, System: 5.6 ms]
  Range (min =E2=80=A6 max):   109.5 ms =E2=80=A6 110.8 ms    26 runs

Summary
  ./git cat-file --batch-all-objects --batch-check=3D'%(objectname)' ran
    1.07 =C2=B1 0.00 times faster than ./git_main cat-file --batch-all-obj=
ects --batch-check=3D'%(objectname)'

... and on an M5:

Benchmark 1: ./git_main cat-file --batch-all-objects --batch-check=3D'%(ob=
jectname)'
  Time (mean =C2=B1 =CF=83):      76.8 ms =C2=B1   1.9 ms    [User: 73.0 m=
s, System: 3.2 ms]
  Range (min =E2=80=A6 max):    73.7 ms =E2=80=A6  80.7 ms    38 runs

Benchmark 2: ./git cat-file --batch-all-objects --batch-check=3D'%(objectn=
ame)'
  Time (mean =C2=B1 =CF=83):      70.8 ms =C2=B1   1.0 ms    [User: 66.9 m=
s, System: 3.3 ms]
  Range (min =E2=80=A6 max):    69.4 ms =E2=80=A6  73.7 ms    41 runs

Summary
  ./git cat-file --batch-all-objects --batch-check=3D'%(objectname)' ran
    1.08 =C2=B1 0.03 times faster than ./git_main cat-file --batch-all-obj=
ects --batch-check=3D'%(objectname)'=E2=80=9A

Ren=C3=A9

