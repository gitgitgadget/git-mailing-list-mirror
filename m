Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7298B1CC179
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034165; cv=none; b=lTjHw9pDw717bQjGlU+GUmsWD0tbD2iBg0xGYL9NspQD3yqVciRfce+oOlnc32JWHzSa30PiVdF107AWct469ZZ8PVKPRXNwRwIGjRxPdDfWJ4R17Ci+ybcLo0ciqMJy5Z2CzggXevVeeDvM23xPnoRA2z2IUcitYVDZEcbXrAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034165; c=relaxed/simple;
	bh=4R3q2D2dnD6vjZA/e6qi1uA7Phh0dKWCXEnIMhnalRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKe3jTzQod4Hlkn1NgujV3nftEPfis53XDuLjdcxNYkGYJCfg44oxmXVzOZnkG7E0lyl6EBzi7Wje46Gsc37zAx/iR4fuz5DHbUsCc64lQJFLIvIGuE5IpW3OXzCj3QJigBwfwn/FphZ2wIwUnby6rLcmarELz7cZxD04IPdJDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcO5BWFY; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcO5BWFY"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6eebae6f013so1053297b3.0
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 08:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732034162; x=1732638962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4R3q2D2dnD6vjZA/e6qi1uA7Phh0dKWCXEnIMhnalRE=;
        b=hcO5BWFYoTw5OfUBtrbyj8tCJygbBRWpcgdzhuyxTVhuJ1cskIz+FfXh/6r/OlY/GP
         mNV1OPmxdBriFpiEmMBp3vaoVNELQrKymcaGGdifQBME1DorgnlWnaQ3BD2PIIGMrDY2
         kGRcTYWStqdyoEIr+xfl85MrAarqzi0pbZSAtKa3se6bvVf6Pm/6RXB2m5X/yEos2iMN
         X/jVIvRxdAkpvKEup54xDxXGpCH9FiP0jSw2yw+gahOk9cM1JdbHCzALJSlUjOse+5cl
         BYPsSk/qxsGREhVUD+ijVh17x2tQlJhZHCYAT12KwvfYwGze9/E9X/8IJ4zsLqoLFPyI
         UKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732034162; x=1732638962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4R3q2D2dnD6vjZA/e6qi1uA7Phh0dKWCXEnIMhnalRE=;
        b=iEU/toFQ85VuZBalRjPciWZl6Rmqs4d+aWoaKtZaHX8dXJ/SnwuVh6tFBXnoEyURH6
         T+WcKG7YWTYLA4/W1s4cLfDCwjw2szBwcOhqKpakxsc1SZYM6pQoyLeF7tqMQFzhPmv1
         QJPFu0+SZnWGj2MdZAgdUABTaVMvVuG4I3RbAb5vIDYaTO8Zauq4vKfElqHPtM20uyQu
         yJMNfvoKk3sT1xcSB9JxmLARgAM2VMl2sxbT6TeA4KO6qImPtw5c1xNMSlgCbPtCqSoY
         nkISXjc2EYBac1pXB34O4xPVPv2Ov1KTwio1Amei6nozvwsdE5YWsxBzxEkS5LVT8efW
         +B1w==
X-Forwarded-Encrypted: i=1; AJvYcCVMhbN1xoOe1hi/Wo0HKFZrAffZGaUiiQtXLu6rtKOvrMu1Mm/0GKA5CquYAbcN/eB1Cx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx93/rWB6jsLaueWOCicJXLuIO2mxOF/uAR4NnCrSeZbBj1lgTC
	J1voOXvl1XNK7XJjDLAiu+tQR5XETau1UQtQVjKPVEfCHxVFv+97bF9kn3uX9Y/wcRiE7xTq5gQ
	v9cr/TejRgHo2WD35gAghObpkizc=
X-Google-Smtp-Source: AGHT+IEeBkNZ/BphZRZDkVNgMEOjffnu1NWN/v5wk9HukZnM+6Upnx5MD0ypUVKaGZ6dEeXEmYcIMX0tV02XnAqRCFc=
X-Received: by 2002:a05:690c:6108:b0:6ee:781a:a29 with SMTP id
 00721157ae682-6ee781a0b72mr120872847b3.35.1732034162390; Tue, 19 Nov 2024
 08:36:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241108162441.50736-1-eric.peijian@gmail.com> <xmqq4j4egza6.fsf@gitster.g>
 <CAN2LT1Cmsw3RB1kbRBvoeLs8WaQeZWqrG96EQfMkMe_jdKaO4g@mail.gmail.com>
 <xmqqplmshybx.fsf@gitster.g> <ZzwwuU2MifISW5BJ@pks.im> <xmqqy11fd8i3.fsf@gitster.g>
In-Reply-To: <xmqqy11fd8i3.fsf@gitster.g>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Tue, 19 Nov 2024 11:35:49 -0500
Message-ID: <CAN2LT1Dm17-mmoMQr457fb5ta-TxG6Fj3Ma-gPh4YRJV9rRDrw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] cat-file: add remote-object-info to batch-command
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, calvinwan@google.com, 
	jonathantanmy@google.com, chriscool@tuxfamily.org, karthik.188@gmail.com, 
	toon@iotcl.com, jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 1:48=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > While having a quarantine directory would help with the case where you
> > have differing end user behaviour depending on the protocol, it of
> > course wouldn't help with the implied performance hit when using the
> > fallback logic.
> >
> > So maybe not having the fallback is the best solution after all, and
> > when users have a good use case for why they need it we could implement
> > it in a future iteration.
>
> And I would strongly suspect that we won't have to implement any
> fallback---hopefully folks upgrade their server side to be capable
> of whatever capability is needed fast enough ;-).
>
> Thanks.

Thank you, sir, and also Patrick and Christian, for helping clarify
this for me. That makes sense. I will remove the "fetch and inspect"
approach in the next series.
