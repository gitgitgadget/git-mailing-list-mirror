Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88063955DB
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816324; cv=none; b=sWU4U61r/rNB0AM7xFMyzyzz7CmjqUiWvDUlF+eW+6vUqQy/R0ppoda8QpzsPUfhiUdR7RtW8ptmO8nsojf512U7sgVDlHpN0yfJRG6Ic/D56fzhtIdi3nTy5JHunmpYxXjTvdCoBYC5Rafuovv4nn6+Qwk4DEoD2pcXvzL1FPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816324; c=relaxed/simple;
	bh=sTo1ruDzDp76jXcCp9riS23zWGzPS6AXkANtZzivHOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUB64BFXStd0yN/Eqdo5MQF/ZuBZM73VHlb7tDQHYobs/P5LvVKlZ/d2bwvGbsywFRL7cd+1+BYnGMoUezacz48+SjE+7sr6uXrQMJR0gVGfX/cTE7lo/VldbIaMqWR9b1g13QCBQPT/cZKjBoYjZEsNaHj3Ep+CBkclQBO0CN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=S+kW/EMb; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="S+kW/EMb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1791816312; x=1792421112; i=l.s.r@web.de;
	bh=cHSe8qkjvEETtLDgvdEQRLilDLxUmhDYPY0u7T6nvEs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=S+kW/EMbpQDUMb9JDNk2CnzOxpm+8lEq9u909AXJFLnZfk3SSSLxxzwJekFAxf7W
	 uFRHRIFDhI81z/gPuyU0VjGjnpCIyWmSv0zI7zN18VY+FNheFlsf+nCjDBiLD23eo
	 EoscuJT75hkDPGyHLzT8FeJRRJ5CSYeBsXE+PsM1IqCP3KicniKUz/hNjLKfkTxUi
	 +kdd4tH3KdOyleKDfThyw+1oPFzxPckSEOw+wwrNUKwQfWXOpR/AwBS7go6DXFtka
	 1LUsIKhxJmx92Q7kN8h1vxecZfvALFkX/OkC+ddH83yDY4pDCenzHjRBOQV/yJI4m
	 9HprdeuZrPFycMFnXQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXoYQ-1x8TDQ3ILs-00Yr40; Mon, 12
 Oct 2026 16:45:12 +0200
Message-ID: <0334c031-56e3-4c8d-8adc-52051d2e26aa@web.de>
Date: Mon, 12 Oct 2026 16:45:12 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] archive-zip: omit UT extra field if mtime is out of range
To: m@sph3r3.com
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <CA+h9NxRT-9QzLGihdL_Bp-yyt1AdXJ79YYgpK-OaegUz8e+HcA@mail.gmail.com>
 <595dafac-33c7-4c45-9cac-c868cf1f8bb0@web.de>
 <CA+h9NxRQLP=20kfmSm6B2WtkkmHDCfdRDZEawOpzFF1LoghTEA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CA+h9NxRQLP=20kfmSm6B2WtkkmHDCfdRDZEawOpzFF1LoghTEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fbq2d8oZ9dEhcPx4POSlaUYQkZlzX6qn3pvzwAlByjPTt7BvC8s
 LGV7ZjoB/6y3aSdwGbUuzq9nxrRNvsimrVMTk/2p0RPfruikjQRHaX7kCQIN7Vd+D3c7Tm3
 JJ8ZgRFLfgm/pgMS7RXpeV49/LKSoKM/TgxeUfKHuI4B2Or7Edo5wxkGn+sHKiTBpQH1ERY
 KPTSwpdAqWR3K/LZrJJuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ri847eJBlA8=;TKBlnnqLmKRw0nV2eSFBRYvZu3p
 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
 t1uRf6+9typQ7iIbM0Ew5/Q2VZDw8=

On 10/12/26 2:56 PM, m@sph3r3.com wrote:
> Thanks for the patch. I confirmed that it fixes the 2106 case: before
> the change, UT wrapped to zero and unzip -u retained the existing 2025
> file; afterward, UT is omitted and the file is replaced correctly.

Thanks for checking!

> For the i386 failure Junio reported, the beyond-2038 archive test and
> its dependent omission check should use TIME_T_IS_64BIT. TIME_IS_64BIT
> checks Git's timestamp_t, which can be 64-bit while time_t is 32-bit.
>=20
> With that two-line adjustment, all 18 t5004 tests pass on x86-64
> Linux. Forcing TIME_T_IS_64BIT off skips only those two tests; the
> other 16 pass, including both INT32_MAX checks. I haven't run a native
> 32-bit build.
That would be an easy way out, nice!  I suspect git archive should not
even use time_t in this context, though.

Ren=C3=A9

