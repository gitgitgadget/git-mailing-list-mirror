Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA4288C97
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171774; cv=none; b=JvNrCPql4byzduc4+24NhAbEG8oZBZw1tkf/RXvWQXPgMxGmY3bo1yOL/Wl/iWKjnm368xg9MheAd6vD90UW9OpYeIE9f3f7kPPxI96uR8yB+rjfOd/8jSevK6nG73/hZfAOsCw78+T7mJTWrB0zT44MVr1XlCdNtNFbHa+1cgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171774; c=relaxed/simple;
	bh=h+cUB8bFngf9oIv3yYYIUmNEO/PTBjLx+FvdExl4jp4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHNtYeDpbQ61Pl/3hmLd/Hz7b0zwaLFzjzWsL9Rvovy19RxvtFKVLqtLAUuWVrd8zw+Hnw3YzY73LsPETQzsjvmZ5C7iie1xzaLOqAfhpxSS9d+4cURuuMVerSqQhlmDEnmgM42UU2IfSqw0igA+r4pJMqJC5AFHfbrnBzo4Evg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iahGW+mI; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iahGW+mI"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-87ec5e1cd4aso3127316241.0
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 01:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753171772; x=1753776572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=h+cUB8bFngf9oIv3yYYIUmNEO/PTBjLx+FvdExl4jp4=;
        b=iahGW+mIoxOOPyk8GZ9ewb3ksPJlLBADWna1EUAF6XIe+H6ZD3QjLGMQEc2AMuvq0k
         Bu1sMAN0AitD3SKQobAPHJ1oPMOslUjl8XCfal26bMshGB+8v2beog5TO2plgd/o4ytz
         viy3QnPINceoW09so9imsDMR+Q7SdnVAS9+l9eRWr2QQ4PU8gb+r/cM1igDkZbiblClj
         4l45mQB33wLYMNfRnFV9gHPHwsYXiE97Z9MUIGusyfkXHh66i6emr5C+1DO3PhOGrYvz
         jMFo6IYpXuHu4kuFc15KtIoD9RBKwapgiVkid6IouHGqTMS/FUO074+OEjLXWzwzIJz3
         ZlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753171772; x=1753776572;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+cUB8bFngf9oIv3yYYIUmNEO/PTBjLx+FvdExl4jp4=;
        b=LGOsoyrtdUcjqbHuqTf1hFeNSH0QH3q9JTTHb9b3/2XUY15TrqhFMZPoVUp7MbeWDn
         9SW4NKRhqYYXNCIAUAgYb/aI31EfvpfSGrkp5w1ciOUu/4e1cu20GMCpjsgqoK3xWxYc
         y6Bxo6o8CT+MMjV1FVBEgpM4WARfOOfdlXBp1IUOXfyzUXNToj3Ra3x75wUiV7UslVWq
         x0yIrkVBOnqmrI9GdfaZEkaVygwv/eplsxVXCG2AeufyRAZpb0FikXIYzI980Y0QH53R
         fulDyX+CaAU2Sa83jIhb7r1ygc3H+uKS3P5Jq1OSy2K5hOfpDe4orYmdTzO/bPfSxxDV
         52QQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2f2DMvWTjF3Jci+Vct+ICChMshJpaCpzIB+N09IgOvucMZ3MkSO/dAdWfGb/iWe7VJdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLCtOiwmfrwDYZ/YWoLaJz396HgRDHsepI7QgTZ61B6uGbJWYq
	WA42wVlSV42sBq4AeaqOvyTKw4xn9ldXtrfi1U2SyjAjW3uZaeCUlXDDbsY0m2Gs1u61VoOGoXp
	LPA9sqvJyE6DyGuvSwQTRu26aZqyxjFI=
X-Gm-Gg: ASbGncuZ1bzM1KuApfxVqKpVGPdsxbQTFAyijczsE40BSnB/2zBVcsf3o+igY1a4Vun
	adMOm8hlVVcVVlINWMU0SP1cQyHCYAJesaluj9+YijfoA6Nq7y7iPXZll7hLzzDEzhyh2dR/0DU
	aCIXea4w334233HJ/WSJADte2EJRwIK2xZAIX2JVwNbVryRdw7UIP/UfsQnr+CPje4yAu0wWixm
	PHHVw==
X-Google-Smtp-Source: AGHT+IEeNVVRha+roB216rdq5+gfdXDz1KO8aZDVXJ5/gKWsBujOWiu+elt9hx0fBkdXXS6hBNqFy5yAyT8FCJSK2Vk=
X-Received: by 2002:a05:6102:3f52:b0:4e9:b0d4:1133 with SMTP id
 ada2fe7eead31-4f95f410c3cmr12163578137.20.1753171771852; Tue, 22 Jul 2025
 01:09:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Jul 2025 01:09:31 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Jul 2025 01:09:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <3e799a41-fa68-4d22-8e8e-930fcab807f8@gmail.com>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
 <cover.1752658700.git.phillip.wood@dunelm.org.uk> <CAOLa=ZSk5O0sQRN5Yf+i6Jh2Dk_pafQhLYNY5eBp_S5y-HoC3w@mail.gmail.com>
 <3e799a41-fa68-4d22-8e8e-930fcab807f8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Jul 2025 01:09:31 -0700
X-Gm-Features: Ac12FXz8V0vzDBcb84NyqTmDvJOziv1GiTe6ljI6Mb7tg0vEZ9UWdY-n61EGOQA
Message-ID: <CAOLa=ZQZ_UX1YquMiJgSGN0u9+LiUAK9HijaLY5DUN1y_j6+tg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] C99: declare bool experiment a success
To: Phillip Wood <phillip.wood123@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	"Brian M . Carlson" <sandals@crustytoothpaste.net>, Elijah Newren <newren@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="000000000000b12f09063a801cfc"

--000000000000b12f09063a801cfc
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 16/07/2025 11:29, Karthik Nayak wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> We've had a test balloon for C99's bool type since 8277dbe987
>>> (git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool,
>>> 2023-12-16). As it has been over 18 months since this was added and
>>> there have been no complaints let's declare it a success and convert
>>> the return type our other string predicates to match.
>>>
>>
>> Neat, I didn't even know we were running such an experiment. Thanks for
>> getting around to it, I think the patches look great, added some
>> complaints from 'clang-format', feel free to ignore.
>
> Thanks for taking a look. I would have fixed the formatting but this is
> in next already so I'll leave it as it is if that's ok with you.
>

Of course :) These are small nits. I'm mostly interested in getting
clang-format to work without any/many false positives, so I'm trying to
test it with different patches that I read and report back!

> Thanks
>
> Phillip

--000000000000b12f09063a801cfc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b9bfa37bbe9fefaa_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oL1J6Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOFBpQy80b1hWTEhmZ0xjOTNJdENzNEVIQjE1WjIxTApKTnRqVnFkUVIx
bGVjc3d0cXJPbG9STVhwTWc1aWtsN3BWalRhV25UN2hVVWM2UndSQVJoaUx5WUhEVjc5WlFqCmNl
MW1zVVNyNVhheUFkZitvYURpb0JUT1JYUnVINko5bUdqcmRma1crMFgyNGkwYnVvdjZNenNidEZ5
Y3JKS0gKN05kV1diSHRvbTN6c1dtVHUwbFIrcGxlSXVncWZFQ1FScGpPL3NobXBkOU9jdHFCVG9x
Y24vZk5QM1I2Wjk4MwpqdEdoYStQckpjUFJIYlpDeFY2TlVRejF5aTZxK0NLTUEwK3BCcGtWeW04
aHRBSm5IenBJNEhqckRyMzh5VzVpCjFhTFZkSGNxekZqdjNiQ0pCUHNvcWVtSXVaSjBBMTB1ZTdR
Q1piTFJlL2prK2xEbGR4cFJjbVdSR3o4bWhzN24KSmp5MHN0dlFvOUNPd2Z1ZHJhRTQ0Sjk3Vm9S
cGxlSGhBWGh6aTZUWmRjU2llaG8vcUpLd01jNDdQWjhacmxMTwo1akhYeU5hc3Awci9oam9zWnZY
T2JFMkgxUHFXalRzUGRxeDNrS1hsTHRNbmRyZVlOVVJLNldmTStjeHZDMDhtCk1yQkt3c1BwdDc3
VU1jaUI4aHpKRTdZMit1Rmduc2ZqVTVObUdpZz0KPWdEV0cKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b12f09063a801cfc--
