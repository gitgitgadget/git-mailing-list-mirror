Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1781339B1
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 00:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967595; cv=none; b=Sub8k4Lfqt8ML+R72S7yvKMMjwM7banPfbM6ZzIuukjcQ4I29IbYeDSmsT2OfFf12Ry6/LCAHALk0owpn7QFRa8b+KNJa6G2yJqWXt/Rm6nh87yW4iknRdovmxq3Oa99FiV6aYn2IrOtv+by+rwaBO8rfRxSIVeRSM19FMpM0IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967595; c=relaxed/simple;
	bh=J5groIrykAwZU3WVJRUTACBpmn0be70LYNj+jsvhiFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpte6O16vYzi6Qu0/UG/mLfVfj/5QgICOwwKx3z7nsK3UGTgXXwFhWo4wt4j1/6YdS1LFSkyH6GYXFLMhOE46Z1fTmYq1Zb5M5sDSqdRvwNKhNQRu652ffC1Hp1XXqM+2o3yfZKkGXRr5ztVHyTSAFB8hMhUigYfMunFvlQfAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ZbuSvtRi; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ZbuSvtRi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773967582; x=1774572382; i=l.s.r@web.de;
	bh=9X9OjSsA1gVzE7Hw9VfF7Pdm771UmeaZzh7UwvtZf5Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZbuSvtRiGt9BMZHdrEicx3z9L+Z74gbhbNvYmkZRwERRsccVr6JOXuUFfEdcIlJI
	 xP6h7r/AWXMZPg4q2ynrJXrFbFzdLPiEmSrqQcuUrt8o7bWyoziKjundnOzcMS438
	 GVZRZyLM73gSaNMV2rPyvDBaxwFhAOImdGQ9+8A0AWUTGCpIDYLURDWeKCPmW5aTp
	 uuJ3PCiu4ya6N0CeVUpveV8SfOJdLXVGkG4vOC5w4CkUmxwO6DcvPaD30nrkgv0/u
	 1M2d+2y7lP+Aj8ff/on1ZfE+2dvCLnmfSZFXHXxd65/KOpO3w3vi7RzNrk16GsHpl
	 2kuUBmCBWbaKyECHLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MC0LJ-1vraq0480j-002nr1; Fri, 20
 Mar 2026 01:46:22 +0100
Message-ID: <6c16da38-654d-4959-b0d9-3fff3d96d036@web.de>
Date: Fri, 20 Mar 2026 01:46:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] use strvec_pushv() to add another strvec
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <ad46f86f-2ac0-4802-8e63-d854d594932d@web.de>
 <xmqqwlz7iks3.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqwlz7iks3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dHSJ/SNNJUTxzhlDUZEdU8VQzYYTI+CI3m64iOsxp/fk6r/jhj+
 AAwiUlUF4sHQpVtCUhy3Amfw1jUVDvGHNM9kfG4VYGJ+/4N8x9haugy7DeoDUitvhH3UY7j
 4FdqBsXzdrlR1KP4ej0MxMNK+CPLPmKeSt3cJfO97WeVNbgIyKjktQh48oF0iae46UP0BFk
 s9P+z1GAFzKkcsK7PLnmA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t34hgOQlTCg=;QBl8EYM5uQUDy8PmVChU36aNi+h
 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

On 3/19/26 10:14 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> Simplify the code by letting strvec_pushv() add the items of a second
>> strvec instead of pushing them one by one.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  fetch-pack.c | 8 ++------
>>  git.c        | 3 +--
>>  submodule.c  | 4 +---
>>  3 files changed, 4 insertions(+), 11 deletions(-)
>=20
> Nice.  Is this something we can make a coccinelle rule for?
>=20
> Something like
>=20
> @@
> struct strvec SRC;
> struct strvec DST;
> size_t I;
> @@
> -	for (size_t I =3D 0; I < SRC.nr; I++)
> -		strvec_push(&DST, SRC.v[I]);
> +	strvec_pushv(&DST, SRC.v);
>=20
> perhaps?
We can.  Should we?  It does find a fourth case from the 18th batch that
has landed a few hours ago, at least.  Will send as v2.

Ren=C3=A9

