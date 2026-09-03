Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604034C77CA
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448084; cv=none; b=ZE3tQd5S70FQ6zgUk0ThaB1MXfgqq6EKk2eYqavvlF8/SZN7OvgiPUTuzW4I2dhM05P32iKaYjX3q77GJaLNFxWGaQMl670Z4CbF9WSZHUFpI9Xu3mReYYbUg908JdNcy60pP0JB0lnnKioMGXJZERIBemo7+zX0XvvbWV1+M3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448084; c=relaxed/simple;
	bh=PRKDIgUgx/OLv331QcHVbQicBUyT5powFYZuu0Am+Oc=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=MsvoHEb5ICpyt3LOaV3BlfZobv3uaWxkCDelTzO9KU6NvUvUxhKFDl5iJPCjl5zNh/12YIIzUFbGMt5q05hgeatQ5zWBP3xZ0IoO4lwIrWcEwKNEhFGoZ/w0vw923M6Xk2y9uQQuwxvrF8rm1yqGvsQOCKudYGY8jWsDwDeXhlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tD64CUc9; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tD64CUc9"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66c744a00edso2332466d50.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788448082; x=1789052882; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=06unbZ0NU5NQWGd5myX/FeqxVauBfXzewSnC/zn8Znc=;
        b=tD64CUc9cQUH6x1UgELFNItaMS/Uzq7N56zUBehDDHn6Vr1E5F7n7Xe86yWPq3NQhd
         Ed1esWa3S0rM0xN2jqzWRUA6ZlsCzbiRi1l5FtUeS5lpDiSJkdiAWjpEXX6FV5gC8vOB
         06T3uGQ4FfgVa+yLD8zgIuWNolRxeWA856jyZw7bGJK8JYfQvXWrxkQDRN1cjNesD5wC
         JMvQ9Kv2W+ngCclmGkuyvEhchC1aLzmc7z+A+2YYc7XxZMcGTMRd5Nps+4Fw5VkoGniE
         lf78l4uuHGreBhysjkXZCgl1j69mnYkeMP6dfvo11gSWQrIUTnO3X+Jj0SQdaj/aPp2a
         TnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448082; x=1789052882;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=06unbZ0NU5NQWGd5myX/FeqxVauBfXzewSnC/zn8Znc=;
        b=jj+KZJEXsHd9owOn8qVppyiRAp5A7rn6g6MorhoXAJPo/L6jiiwKDq5nm+TXkmGob2
         6kFwXegh76XT0N6VD2rKfghh6lauHyujT5yC1UkxzkGsw0haLcEj8BljyV8y33Scom9F
         n66+OrKo0TS3vnFLiA5ryvHZDcX7ZYD6VOHmLS14rlD0c/qIh6JuUxHTIOoN5ZZwl5YR
         tvXQ3gVa8BkHmnotuu1Nvi5u5M5Inz89sttsH0GzO2ecdYDcD5FfT+7F/BRjT80MoBe+
         oq683MbYT2sxYFxm24NTNPI/KbJgPFy4eOAfJV6JEQXchSq974BtkYPiigq49CT2WdVb
         vv+g==
X-Gm-Message-State: AFuF++lLmoEx/ZpBsgfKUfZv8+YsHomdJ7COnraXbuIjWn43D9VUTMka
	bOCjSqk3Jpf+1zf3TaRnV+gzwV8r5UtBCUA73X55c2Q/PPotn72whBpfcH1wjtHI
X-Gm-Gg: AYBFou3FbV5U6o4FZsW1cxDc0inMfvLzhHOmhgVeIbSVGG6grr4pAQREAiBqlhy9NyD
	srkyt0W93HsUW94yRZGOxSGHrqNwQyTVH5CZnLktCq2rc0ul0ASMCRRDhVIoQpHsKSX9zBCzYmu
	zBdzgw9QwRXxnY/Aw1Z83f4BwCfom1pAcCfKxsKbZLJqWPjodxfhHiqrNX9Z9+1JbMrBZV1vZPv
	tdDdzcXwgc/9PwII3Raj7VXp67iPnHs7Vx4mCIoKtO1QhIdrkeMHgDOMl3fIefTzlQ33CBzS7YT
	9f880mbXqvk+qkBTXdklvsCgeX8BzvhSY7eRC+Lk3oMGUjYRyAf0+TGdCkLqgU2BZekPCnUVtam
	NVxGxIPLjFdLDnxY9stOavIB6BhJ1kMe25Ag5d7rCRcsMu3XVzIXx+uxk6aAOAKdQnIavyiUhUr
	5NFSk8wDS4DYCQOue5u5QZ2Xc4vBGLpnALMoHze86YQht1qwdJUpb53WuVBpP4fEjQLcXxCUaXI
	ij36jErnYxuQikSYOXFjKVBfC9Uiq1K5rNAzDqJUmTNqTdYIJeImYdahfciu3rMi3O8Zr3NeEiD
	hamGMHtYqqJr2qjb4Mn8K9JPXd3cl7yxDfYaNg==
X-Received: by 2002:a05:690e:bcc:b0:66e:6002:3672 with SMTP id 956f58d0204a3-66fb3fd03a6mr264136d50.39.1788448081899;
        Thu, 03 Sep 2026 08:08:01 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:494e:2119:a9dd:edd9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb4939b30sm59828d50.15.2026.09.03.08.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:08:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/5] format-rev: add --abbrev, --color, and --date
Date: Thu, 3 Sep 2026 11:07:50 -0400
Message-Id: <EBCF44E8-9952-454F-A164-0B7CF273FB30@gmail.com>
References: <xmqqse40ei5f.fsf@gitster.g>
Cc: git@vger.kernel.org, kristofferhaugsbakk@fastmail.com,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
In-Reply-To: <xmqqse40ei5f.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 26 ao=C3=BBt 2026 =C3=A0 16:33, Junio C Hamano <gitster@pobox.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFkristofferhaugsbakk@fastmail.com writes:
>=20
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>=20
>> Topic name (applied): kh/format-rev-more-options
>>=20
>> Topic summary: Add three more options for controlling the formatting. Als=
o
>> do some minor refactoring and text fixes as preparatory steps.
>>=20
>> =C2=A7 Changes in v2
>>=20
>> See the patch notes for details.
>>=20
>> =E2=80=A2 Use designated initializer syntax. That=E2=80=99s more readable=
 since you pair
>>  the field with the value and you can omit zero-value fields.
>>=20
>>  https://lore.kernel.org/git/xmqqfr0hswxm.fsf@gitster.g/
>> =E2=80=A2 Fix useless `BUG` placements https://lore.kernel.org/git/xmqqfr=
0hswxm.fsf@gitster.g/
>> =E2=80=A2 Add preliminary patch =E2=80=9Cplace BUG calls first in callbac=
k=E2=80=9D for existing
>>  `BUG` statement placement
>>  =E2=80=A2 Based on the previous point
>> =E2=80=A2 Patch =E2=80=9Clearn --abbrev, --color, and --date=E2=80=9D: te=
st a few more options
>=20
> Nobody is interested in reviewing these patches?  They looked more
> or less OKish to me, but I am not the best person to review this
> series, as I do not see much point in this experimental command.
> It would be nice to see reviews from those who are more invested
> in seeing the command work better than I am.
>=20
> Thanks.

Reviewing these are on my list. They=E2=80=99ve been there for a while,=20
now, though, and no promises on timing :/ my personal priorities
shifted rather quickly for the weekend with the recent 1Password
announcement ://

PS hopefully this wrapping is better from my mobile device,
I=E2=80=99m guessing at the width to hard-break as roughly 1.3 screen lines :=
)=
