Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F9D23E34C
	for <git@vger.kernel.org>; Sun,  9 Nov 2025 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762706619; cv=none; b=Gg72CqLmdelMxXNpdmWWxbIk//WAvHfFmJYf/M+9msuv58kESyniFheXqbZItvk2DdWUxN9k+a7ju1PgWK2AXjn8/+SznPTfxbCba7nyLsMAGYJXLd3/SWUKq6dlF4P5hpTclii2qXljE9OtbgepoHB7DbuPDC3qvfIjwO5AtFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762706619; c=relaxed/simple;
	bh=IsCxiY5KFUnsIczmGg0SgHOK9cKqks/+Itcay04Nymw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOVA1e+CkqifxsY7SoyH4K67rs/et+z1IBxdJtlgB4sIfl9uXZ8QYU01vwZ+8V7NndjjcYUT+cTI1DFcHjm9FLuNdWKtAKb5kp5EGS0Ep+t9RaC8qVGtgmT7Yjb8FYw8MWMKRHfjYgYIEzhO4jb5BKRlRuS9L+ddlOETiTfbx6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=eS899ljf; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="eS899ljf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762706603; x=1763311403; i=l.s.r@web.de;
	bh=RiwFaEUku55v2Mms61MFNeF42tCt4DLqzZ0FgSdkID8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eS899ljftcAPekLlL3zAJVv5YCksfbRQnDn+19YekaC34T6dZcG4N6e+XNXb46xB
	 c2A7lZPkEHuQtSOn/x8XQP0tFNnKDvm+RHFYldIrKr9/aU5ik/aZR/iEFVZBFOo/A
	 JwxxAZjwSkdK93RNn46SPMoOSc7t5gX73tuvS3t14V4mk5ZBtmHXDisXgfnX7gJWL
	 slRBMOi1+2VxCgapURy8227jR/ARuNJLk+Z4Eqmwha13Pv05bJr0dKLIDEeg+v0pZ
	 hWuvQI8Rea1H+F9m2OSN/2tUhKvYpckJ17rpiWVsobpgQeIAHmtOk7rQE81Dr/8oL
	 I41Rn9r4k3WcjvjVLg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.146.25]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNfYN-1vYJwu0T7r-00Z3kB; Sun, 09
 Nov 2025 17:43:23 +0100
Message-ID: <2f47defa-1164-437a-b81b-294c7fddabc8@web.de>
Date: Sun, 9 Nov 2025 17:43:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] diff: disabled quick optimization with
 --find-copies-harder
To: phillip.wood@dunelm.org.uk, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <CALnO6CBsj+aMvHJoUQ+LHAtXhcFhQeH8AuHyrX+rumur6MQQog@mail.gmail.com>
 <bbd1a371-b0a4-4412-b329-cb4d654a0ca8@web.de>
 <40a322a6-7fd7-4003-a23f-7672a36b5bf2@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <40a322a6-7fd7-4003-a23f-7672a36b5bf2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NIdNlbf926wSm+NaWkTUeTsFD3HSbMsWrH76dPBjtZ9QQrkk32l
 /jW84UdAaP07HzgBSx9hXWnGyVeK1Tx3ocHCScvnkfrqM14B0kCqUIhjP3qWOBhRqgIBHGP
 WztWyNgajtp/Uqboiq/tXR9dVTpe/NB4yXBdx6t8qS8KY5WCgB4BMx8QO5YGnOj3TQiNdyC
 SBrG3ZdVUzgb9L97W3+Pw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0mAa/FX23os=;iIdIi7eVmF7YFhjszbKNzLaVIQg
 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

On 11/9/25 3:18 PM, Phillip Wood wrote:
>=20
> Stepping back a bit I'm confused as to why we don't disable rename
> and copy detection when "--quiet" is given. I can't see why
> detecting copies or renames would change the exit code but maybe I'm
> missing something.

Excellent question!  I also can't think of a reason.

Ren=C3=A9

