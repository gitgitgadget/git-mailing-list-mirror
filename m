Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61026C3A2
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 03:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076042; cv=none; b=lxg+KTmA9ZjHKX5ETQMBE5IS0OmD0kCh95IHMXRScCUAZWfkvy/mWfGYcCnH6Am61qXEaq5EpsU7CqTdw2QYirvV1gIV8ITC8oQc2pof41HgVO29fS2uAvumz6THLASx3gjAWD5QhBSjJLLYV7OzPXXub0/r7xXX1r/rj+U3c9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076042; c=relaxed/simple;
	bh=AAqBsrJ1wqTTPLLfY1cFo9hd+sHABuCpnPNlRoHnLJI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=SEONeeLawLrne7TU0oPtnAsoNGnxM4/jlPNY7tM49KZqq3LruoGIsvJ0tu6DzdwtW3jm/qkANNRxVkC6liNVB0JA43TRnRgO+9VtAmCbWyJ4IWcdGDSPceklborkwRRBFJY+IGv4SbI8ph5LgnLLNdQjt1p24dE08Lx/PkA683w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XK1aDMgr; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK1aDMgr"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8cb39647a70so31094385a.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 19:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772076039; x=1772680839; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rC3EetYQZt2L4MZXeJiwS87mRCgaFf384QPE2DnehaU=;
        b=XK1aDMgrOwldwcZ8z6BogCnGVYPcEOn/BrGCAT7xqWml/gL023IS0j0cCCNGOa3hXJ
         +9u+f4CoX/sYoi/D8G+CThGv3CJxuBqSD/B/58dkSEIJczB4B2TOKgdbVpOutldNzTaB
         Q/WW3I49vdVgBViUuulDFtK5AJ8Mq8t2FB+IlvPO+FYShBS7kACng/6NDSvVd0Ob8YBa
         3fBlreEv8M38lheqm/0BqV2sZWf19ZNP1dP6a31kGm0zK5h5R1CAnNIAmwOc3cc2PIig
         RxQSPZYbXH81nXNrXBElJlovGrj6fgZqCMcvlW8a+fgEvWq4/3qxgWvaShxLSfcDEuIL
         qJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772076039; x=1772680839;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rC3EetYQZt2L4MZXeJiwS87mRCgaFf384QPE2DnehaU=;
        b=Z+ROpwfs6nEkv9o2ola+bvWRBkEajZboB1Krxr4C6gK4lOCtFpaB8wDjebzpq3va6f
         dfil+BxWcc9HOlHDwqzmeQ7fx5k8h51FKaomWOnTDIIzRUb04Vr5Nq/+yM9JpAGmrWAo
         or0BvUQhBkCSpvQOXj5Dqjhn+WoxCgbflCIwDvOHxmhRhDVzKg36KgjfLxn0FLIFcS2x
         7VoAiev39kS4PB17n1tqdVKxdsZ7LMMvuMVM1Qc0cAzl6HxD8CPLoQXB13Q+7BIE3lpH
         DOUei8RxKkQ7bjrvL6jG67Aj381npwWoMtQHb6lIm2wFi9cg5j3rPu+u3x47VW3PhOKF
         138g==
X-Forwarded-Encrypted: i=1; AJvYcCV4TbCgftfnZAyXSRkjToTFdOXoHX9PnDTq+3kBM9J4lrCKmElFB9N15YSpmLjc3sDh41c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS0lbJF5q9HOqAoGvaU4sNRUl/XZdmekQhygM/bNndWTyMKFk2
	IL4yPJm4eYW3qr55V58umPhx4ABNcgUF3kWkITT2S1klrs+W7G4xgNBu
X-Gm-Gg: ATEYQzxfJG/AVw32oWItK1o6OipxmFXUYdSOFb21asVGN5YLr8/v5S0+pRx1iHvFhOc
	JFLJc9VUMrBIx3luq3Si8+hEtOUBCyRFhDUug7pSDLVZDCMCsdbdeRbR0YPCPMqPjHkbATQUUGW
	Gv3DjdgN6cK+CaII3cybtqicT25u/jcNeR1AVISAVfr25lHKS2Tad6PxEa3LchBdI9PQFu882pm
	e6/Jg2hhOT/EveuQJPum9Gtfh/yCYVmlDnFa7CskRiLu2+ivF/A90AyHx6QY6EpL+013+S/5AnH
	rg+dGIAXIku1r1EHEvvaQCqwMWyepAc+T1m91knoAQt5BR6iZjArLEwds/E30NnmVqghmzcerHl
	JGo7BV5TUqxydPDMZihmJVrsLNEzUAFIGFexdvEEH6V2kv9oJhx+UH3yVkzn77mbqX4CzHogL6C
	NMNzzUU4Ftc8rDOoffwk3X/qvpMLFSpvXqyFaz6N9sqxdHMcDCLEUy03pgWsJvY3BYy8aQ/D64z
	PnjDijC1jUMHvU2MVMxmtvrIf3tOBcsgDsZID8x
X-Received: by 2002:a05:620a:4490:b0:8ba:2b0e:fa36 with SMTP id af79cd13be357-8cbbcf598abmr380220485a.24.1772076039413;
        Wed, 25 Feb 2026 19:20:39 -0800 (PST)
Received: from smtpclient.apple ([2600:1004:b25e:bf13:9481:64cd:a223:a8a9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf746fc5sm92454285a.51.2026.02.25.19.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 19:20:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7] build: regenerate config-list.h when Documentation changes
Date: Wed, 25 Feb 2026 22:20:28 -0500
Message-Id: <046864AD-F37F-4DE5-B692-167B8B570DFC@gmail.com>
References: <xmqqv7fkachw.fsf@gitster.g>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>,
 Marc Branchaud <marcnarc@xiplink.com>,
 =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 Evan Martin <evan.martin@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
In-Reply-To: <xmqqv7fkachw.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 25 f=C3=A9vr. 2026 =C3=A0 13:45, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>=20
> =EF=BB=BF"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>=20
>> The Meson-based build doesn't know when to rebuild config-list.h, so the
>> header is sometimes stale.
>> ...
>> Helped-by: Patrick Steinhardt <ps@pks.im>
>> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
>> ---
>>=20
>> Notes (benknoble/commits):
>>    Changes from v6 (<5dcd4e9308100a25603c50fecb36447c0ee4df62.1771682788.=
git.ben.knoble+github@gmail.com>):
>>=20
>>    =E2=80=A2 Fix Make-based builds when a dependency is removed by genera=
ting the
>>      expected empty targets. (Thanks to a report from Szeder G=C3=A1bor.)=

>=20
> OK, now we are pretty much completed and ready to merge it down to
> 'next'?  Let me mark it as such.
>=20
> Thanks.

I certainly hope so. Thanks.

Family are in town and new kittens come home Saturday, so replies may come s=
lowly. But of course I will be responsive to lingering issues uncovered.=20=
