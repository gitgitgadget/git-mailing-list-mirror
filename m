Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C24832470B
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866461; cv=none; b=CGJxS0yw5oelp2fvO0g/HhoGofWeKua+JMsRUQwrsR98qHrkZytU7RREFByhLL4BCk8O+oKLCa7pse/OOO9sQlGDKrD6tBHwI5yzO2S8ApB+gYGAKYey8/jh+mzc4qENvHVAW7LPC6fRBLgZi6yNtTxjRmQUGdIo88Qp63t5ENg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866461; c=relaxed/simple;
	bh=FOCoV6UnWEBE9PoxD+jO6A+pcjBuQx2Ipd9H7rbEjlw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=dBxVfW+j+FbTZQ3Qk82suYA9bEjGyNWzsOz8bMNs3tZmJC+2GhIsaqmqys+P/gw23mgfefl2iDAaONHHGUmS1rUYqH5s8NozjivMqgamNh4Vck6u3bU98I0Tet0vF5VV7scxJqLAZs/tIo3Nr16Bal78Cz97/RwyWods/P1I2Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMIr+/kp; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMIr+/kp"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63fc6115d65so4042705d50.0
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 05:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762866458; x=1763471258; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOCoV6UnWEBE9PoxD+jO6A+pcjBuQx2Ipd9H7rbEjlw=;
        b=aMIr+/kpoqifdXi2g9YjLMDBVRRtnxZ7veb3kyZhWeO87UsI/O1cPtU9Y3dZ1iOFNB
         3a28DHv9h8ULkGPqVIlrHArS/O3XRUo/nN7wwRRXiKmXNEK+P2cg1SWyYB7t0dymo6/b
         3pbjgQOzXzKbjSdKOVhn1EwfO9p4ierli/OAlBERUXQ4wGtk5hbMyL2GBd8YnnmNw4lQ
         s4L7Ha8QWglp7Ye4MjSFc2kJba5Vd77gg+QE9/oTIYXrQ4eg1QpJ6Oq/54U1sO5wyE0u
         YCBtBwCVzQgQOJ2yxBRNip/wSQxm0GObAepg/Zu296ZaaJsDrOwunoqXxzuWau+Eldk9
         kd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762866458; x=1763471258;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FOCoV6UnWEBE9PoxD+jO6A+pcjBuQx2Ipd9H7rbEjlw=;
        b=QNNRsX2K4nfgPGetiOFzpwxBWizfI4oL2tQTX/YrWMjRwtDIf6KmKcuXCm9X/lMa09
         FHygPTKqRTz9hRFQkd2ZFSzVbFxGr6EGjPmvMo0Rw+wYXNX4PgcyJsa1wZayrUiUCPiE
         4BMrAAybn4uTF09QuTFT9qFXZFi478CdR8yQwrg5taCgvmA6khXJL+MHCMTFz9K2rzzw
         TgD8i2ZljkxjaHh1qwHpHVDGL8qb8ww17ySCre8XQ5aXd0ZQj6Kl/Z4YidnRsV4o97sJ
         HoUlgdyrD3aBJf4mT3dP5k2ttOi0zcgFU8TcaWqjabF51fv/suMsGnT9MrOO7zszN7i1
         5eYg==
X-Forwarded-Encrypted: i=1; AJvYcCXWjrW035pLv3yw9dshIDalEYAMP3e+w96IR1RQDL0b+PffqNcUI9lCRdHrcVE5lhEGZvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHM9Ae2k5tKPD9nSV05RTg4ijsUf/vIUHr5xmrF4JXoB7DRGWf
	RTFsgs4S9OET96Bho/olHwzO0ALE6kz0DR5XtgAkGDXbez0iRUlUtNuX
X-Gm-Gg: ASbGncuv5wYvNu4JxVk7R3iS2Gktu2dVkGdSSmF4wcEnobNPjY+f1e9tRHR7eurQxNq
	dEhoO7LmPIrBvZc4/5ks7riMyQrn9rbb2BF6+QiIlFrBIThEhy203E63TCG2hXNo5va2HIEaWw9
	QtEMDEBPYSbsYHUfZUSelUZVPUAa6kw6WrM8inogq3o+M7fX1NBB2mP9gpMx+6kK4hV0JIjVrkE
	4A2R8BDCpR9ebxUIjtHlqjiAnw1qGPU5Y0MlI3zVY4S+EAAHZuU7zZuIpriZqdBw8khvTLU3jpQ
	cNsnjAOOaS9OcwvMaB/2fqfP5UnJt96MtVjt5iPDw9dCUbO/5YYonU4YRZSrBavC1dYUgv9XLJo
	ngA1b8gqshZXs1SagU3yw5WWYKtogtqMzQLZywUAWzzzTz0fcePHF5hhj2WNBg/wfRZ3VsIqNhk
	zj5M+IS4JO/M1HYDnk9m22vJ+sik09
X-Google-Smtp-Source: AGHT+IG5fPSwANKTVY6alcTXJlkwQOmKQhGoSqjfSJY7RBcNupuUTrnS6fcrJAb2SYRlh1lUcAGm9w==
X-Received: by 2002:a0d:c245:0:b0:787:f755:5b06 with SMTP id 00721157ae682-787f75566f6mr41892797b3.50.1762866458316;
        Tue, 11 Nov 2025 05:07:38 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:4d0c:3f82:cef8:9dc3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d69ba6fbsm32306757b3.31.2025.11.11.05.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 05:07:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6] doc: add an explanation of Git's data model
Date: Tue, 11 Nov 2025 08:07:27 -0500
Message-Id: <1348B322-2DE0-4D5A-9B87-888884555FD2@gmail.com>
References: <xmqqfrakyj0w.fsf@gitster.g>
Cc: Julia Evans <julia@jvns.ca>, Julia Evans <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>
In-Reply-To: <xmqqfrakyj0w.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 11 nov. 2025 =C3=A0 05:13, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> By the way, Ben used a word "unwelcome", but the words that are more
> appropriate to describe my reaction were "frustrated" (for not being
> able to explain what I know to be true clearly to make others
> understand) and "disappointed".

While that isn=E2=80=99t precisely my phrasing, I certainly had a similar im=
pact. Either way, thanks for clarifying: my intent (not always the same as i=
mpact; see prior) was to point out the way such things may be perceived.=20

I deeply appreciate, by way of having been in similar situations, that you w=
ere frustrated/disappointed with the conversation or yourself=E2=80=94langua=
ge is hard! I=E2=80=99m glad that frustration was not directed at any contri=
butor, and I am also hopeful that future contributors will see a maintainer w=
ho cares about contributors and clear communication and decide they should s=
pend time on this project. That is the source of my use of the word =E2=80=9C=
welcome.=E2=80=9D :)=
