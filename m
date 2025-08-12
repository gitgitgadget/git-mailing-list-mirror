Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156222DEA7D
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014402; cv=none; b=nwRNNdFuVv69ZYoAHaIkIKRJ/zl80jrc/Vw7YMgxHe37mCjtTEev6+kqtMKw/I4M5l5kM9rdVXWQfvPZXUyl8uqeQH4myOqzIZRtGaxV/XnBmvqL/BbG40YNr7wflC6RRmtce93CSqVu6pgXS5F/Susut0HiOiFpNFTu7jcnRZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014402; c=relaxed/simple;
	bh=hK2yiX0IeOZbrlhyxdeS8PqYQRmw4yfZh8V9+7y7dU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvzE/lvIW5nx4/feukBtZoDDZWmBn+CrJGHvz6qP3FCKxN9adJygH/bFYZOXGRL4OfhGkZQw0Yulkz3l/zCQxPvcrOCIOhu2br2dj8wchMNaySl9iDHzlKa/nRAg+jS6ax+LtpRdThCklAvh03mvTT4JksRsNAs8yCUws66U/kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Ti0voEdC; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Ti0voEdC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755014397; x=1755619197; i=l.s.r@web.de;
	bh=Wvt/XpQlbaRoYZV7ZSTUrb1IC+IEIMTmZ6o9EOReyvY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ti0voEdCFFT+ED/nApqjHi8IbJ1tYe59nEiQr8AgYrPIsyuAe7rwSnMGLVuNhVtm
	 AJkcDTYHOxo9hTKha4DTc1ZSesLbU3AniY+VqgqWZT9SB4hc/YUsph4pH9io1PgMu
	 k734JBFP99GoMvUO2f6aTBfsj3psGSf5PJTEcya8n2boLIIbShEr08aICbvleKU9l
	 efCMSBDuay1Qzpvs+vM6kTuE3PkBf2w+DJt49hEQCOD0u7ch4pRTC2NhJu+xbGfm+
	 ZVh3hzFsR6f2pqOXbFhJdTZhUHvWkI/FR4qgPd1blQAHy6+KQj7+4aWTlZC7kMTBj
	 P3FoemLY1eFAQLFP4g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.152.110]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MAtwr-1us9zw1Zhx-00DjDI; Tue, 12
 Aug 2025 17:59:57 +0200
Message-ID: <6d0631ed-9a28-4107-8c07-298a9424769b@web.de>
Date: Tue, 12 Aug 2025 17:59:56 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] abbrev: allow extending beyond 20 chars to
 disambiguate
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jon Forrest <nobozo@gmail.com>,
 Derrick Stolee <stolee@gmail.com>
References: <xmqqfrdx517b.fsf@gitster.g> <xmqqzfc51xvk.fsf@gitster.g>
 <9ae4a718-b00d-4435-8739-cf87b2c9df7d@web.de> <xmqqwm78vaah.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqwm78vaah.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KXLQhMXV3v8lsjj7J3mQudqWxICz5oJdmUwsaIPfki7aaD3GK0S
 7xKmhN58vQKw4lNoah+jfm1WWC+ACSf/QZ2yD4ujKRBq7PLIiI0mTatqSoEU6uBMW8YPWRe
 3aKgIzLUiAffQspXnNr4B8iXu+6hMz5sUalZT9vYt9hy18Xc0V8gec9Q+rBqeFdTmnIn/0k
 WMS0DbYnEwYhfirGz8FZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZkZpzKXi5Fo=;OCw42GdehPDz7yH1hnDgWJhafXs
 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
 6KZUS+NpMWQ==



On 8/12/25 5:17 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>>>  	while (mad->hex[i] && mad->hex[i] =3D=3D get_hex_char_from_oid(oid, =
i))
>>>  		i++;
>>> =20
>>> -	if (i < GIT_MAX_RAWSZ && i >=3D mad->cur_len)
>>> +	if (mad->cur_len <=3D i && i < mad->max_len)
>>>  		mad->cur_len =3D i + 1;
>>
>> This combines two checks: Whether we can increment and whether the new
>> length is greater than the old one.  Only if both are true we take the
>> new length.  Shouldn't they be separate, though?  Why reject a new
>> length that happens to be the maximum?  And max_len is not explicitly
>> needed for the first check:
>>
>> 	/* One more to disambiguate, if possible. */
>> 	if (mad->hex[i])
>> 		i++;
>>
>> 	/* New record? */
>> 	if (i > mad->cur_len)
>> 		mad->cur_len =3D i;
>>
>> Ren=C3=A9
>=20
> Great.
>=20
> Your observation resolves my puzzlement about the first while() loop
> that has been bugging me ever since I started looking at this code.
> The mad->hex[] array is NUL terminated, and the loop can terminate
> correctly without being told about hexsz at all, and we ought to be
> able to use the same information to make sure we stop incrementing
> the .cur_len member without running beyond the end of the string.
>=20
> In other words, wouldn't this be what we want, without any of the
> max_len crap?
>=20
> diff --git c/object-name.c w/object-name.c
> index 11aa0e6afc..4cd1d38778 100644
> --- c/object-name.c
> +++ w/object-name.c
> @@ -704,7 +704,7 @@ static int extend_abbrev_len(const struct object_id =
*oid, void *cb_data)
>  	while (mad->hex[i] && mad->hex[i] =3D=3D get_hex_char_from_oid(oid, i)=
)
>  		i++;
> =20
> -	if (i < GIT_MAX_RAWSZ && i >=3D mad->cur_len)
> +	if (mad->hex[i] && i >=3D mad->cur_len)
>  		mad->cur_len =3D i + 1;
> =20
>  	return 0;

This combines the two checks and I don't see why.  Why not update
cur_len when oid and mad->oid are the same (mad->hex[i] =3D=3D '\0')?  Ah,
to _ignore_ duplicates on purpose, when we have the same object loose
and packed or in multiple packs, right?  We wouldn't want to let that
affect abbreviations, makes sense.

Ren=C3=A9

