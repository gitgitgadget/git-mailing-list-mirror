Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176A826B777
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759659780; cv=none; b=pURGNdvTnDd7llCqMdUFP0XqoolPtUvoKQynoxmtjT4z3OH8FQJiOQl7ufGLOLMogS2dxtG5SAjYexNoDnDhK2VSd5MdibGbSot7pohyZwmhZqNCrHpLcl74zwttaLSmn+r6r+ynMm4C+UqJvPRMbE6k8rjYyIBk/GAlhuRPgQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759659780; c=relaxed/simple;
	bh=iY96iUIoy3ujTZhPVnqj9S5Zoi4YRnVXWhLoU/4CWCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUZNckGU8iCHhrnDJmNBKVHciDf/E6O1K5+RuVD1JmJUD4qhgYpmZIrF6hzan4DnBAp5i7U4SY482s53GYCix3aP8puNhseDrbSG0cGx7S6lf3BUaphwqYh+AV4HL8Iwp/E+XgTG7/dJyaKOTY8h4BBUdWhkxKVii6fcX+KTB0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKrz46Mi; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKrz46Mi"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so53720965ad.2
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 03:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759659778; x=1760264578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rByQ4GjoXROMlBTXV7cGOJ6wqxW8YDyEELONA887IJw=;
        b=TKrz46Mi6dESuny1q4loko9I1Rveszb3R4a6ugVr/dbL2V4PZsLIuGUxxITFIsIAjs
         b5s0xvojHhSn/jFIq+upfzmcmCbbZB2iVgmnuYkU9Mkaizrvgms5C+/tuT5OsRbx/4nC
         aT738UhbOMP2/Sni+5/QO7fKrlVBgvfmiD5zSwKhj/Sw+Lzf8VBKefZV3RBYk9meySyD
         6WVHdz3Ti9t3A592/upLpRYVd3NbE/VAl8NnGkZQ+8etFQ+qYKYRHBJT2nf9NCH5LP+h
         kssQaTI6YIlzKjZhH6KrOtJYLmCJckuAA7LODb1JYztLfflmkANK2FVgKZGP1McO6tuS
         93ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759659778; x=1760264578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rByQ4GjoXROMlBTXV7cGOJ6wqxW8YDyEELONA887IJw=;
        b=jZez6+/zZbumwfTIn6ZjV+gVdii4noLkJputGV0V2RQj7I++fj/6m5M/OrjsNFDzrZ
         KaVadF9rDQGCoGaVN1xXDPDSmKiQwNkus2susWH3VK//LClI2thczsq0UiBcHWvwkiUg
         SBxDtHzFlPkwTC7NlGIHzwnoEIQ0gm8a8cx+BbtMhHp0bDyr1erL2vClmvqICAfsNB24
         aafzjYGCvcHlAP4pGX74Gd6tX0uW767Ci9+MkXgKS8QGKPTtGuSqh3V3qCEy3t8bsvxE
         0KFnI2SRtBwGQ01Nx5Y69jY/NjM44YOB1tY1nvgBG4p9CYpQ1jA59/hPqOmS2C52bsls
         WspA==
X-Gm-Message-State: AOJu0Yz93/wlWrPN2X5SAOL0dLAxI6xMNLRVDuJH4Cl49skUtVVK6U0l
	ISdMk77UyMtPcALP6RPOMEz5/4bO9JI3Vgjhid+MoL8n8xbxOZJ2IDTA1hENY2RgZ9rpfSGY6mG
	cO28S2ZoE5L5hSn99rIHL9C24aT369Vc=
X-Gm-Gg: ASbGncu6pthnsSWSEUSA3AkOSdfgVfEjU5IlHdl39zVWxXJxJT9pZEtD0JLRhpzZpwv
	dROzR8+8KvNCJ562Ls19iGpA9MHhgl8+kIH2cTdYtr3rT+l1MNNT6g9mJAZKXsUMI4rzRXfabV6
	HrkAG7tUgt7g5bOdcQwFm+gW5ulpKUgpJbGqd1sj/9BvUvFn5p2RfjXrsLiqOL+rTe3QTrwgU62
	ySRpSPIVDI3pDSGmdCvIeBfNfmloFwLv8pGDoevYyuaOJB1er5uhQHkqjWXaQ==
X-Google-Smtp-Source: AGHT+IHTw0nM8QJMc5xRoyDU8ah7WqgzILMF6Eoa+wNouxO1oukNX5gP/EcmvGwZQLFbG/Iftf8VPZ61lj7BVw2apBQ=
X-Received: by 2002:a17:903:178e:b0:24c:cae9:77bd with SMTP id
 d9443c01a7336-28e9a6936b1mr109819175ad.54.1759659778308; Sun, 05 Oct 2025
 03:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMWvevK2CrA_2mJC-O2HDKag4EaDVrB-0LiqQk0_gKrRaSR_ew@mail.gmail.com>
 <CAPSxiM-hkh=X4rf6QvGP2JnHvP-UJQ9mcmMon91avv9AaLB3Bw@mail.gmail.com>
 <CAMWvev+ZumUqF1hW9qfJ7o=_t-qwB=wko7oL8r3UFC2xmr0WgQ@mail.gmail.com>
 <CAPSxiM_N9LSryKf7jks0tqk=d5abaKEAmfnLACFM4Cqx18GN-A@mail.gmail.com> <CAMWvevJYFT5u_DgqYj7ZWx+eg1Qv6FXzYFMTPGGuXLa_4y+LuA@mail.gmail.com>
In-Reply-To: <CAMWvevJYFT5u_DgqYj7ZWx+eg1Qv6FXzYFMTPGGuXLa_4y+LuA@mail.gmail.com>
From: Vedansh singh <vedh2o2@gmail.com>
Date: Sun, 5 Oct 2025 15:52:47 +0530
X-Gm-Features: AS18NWAQSsZJsYxgtYLHuiZ9PprCxEP8vKlxtoyWxKRabalsO0UdnllDRAdkJoY
Message-ID: <CAMWvevJBoThEhqHWpLUmkP1F6NHrxOnd1n56fLdq2Qg=5G_7Ww@mail.gmail.com>
Subject: Re: Interested in contributing to Git
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>  I think you are on the right path. One very important thing at Git when =
replying
>  to email is that we do not do top-posting to email, we only do inline re=
plies.
>  It is very important to keep in mind.

 Sure Usman,I'll be make sure to follow the trend
Regards,
Vedansh


On Sun, Oct 5, 2025 at 3:37=E2=80=AFPM Vedansh singh <vedh2o2@gmail.com> wr=
ote:
>>
>> > I think you are on the right path. One very important thing at Git whe=
n replying
>> > to email is that we do not do top-posting to email, we only do inline =
replies.
>> > It is very important to keep in mind.
>
> Sure Usman,I'll be make sure to follow the trend
> Regards,
> Vedansh
>
>
