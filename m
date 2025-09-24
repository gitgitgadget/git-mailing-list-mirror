Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F99C305E3A
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727588; cv=none; b=KnoaJo8psuxIiqM8mvQik1Rt+T1C5eT1v3meFaOPkk2+SqZ5BpT0+AoMYixlz+slWUXK/mxmuNaNFBj3udKneWZowvej0nV8h+lay+m48LyMNh0PnHsiUj3GftQ69/5Pv3wvd2fVa0SsZoqCPzThpoeEGD4YSyotUoFgKjwsiKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727588; c=relaxed/simple;
	bh=Mz0YVAHkGACdiuQeuG75iYcTslb6xWj6w2Q++DCu74E=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=SdIaQfCRyXWE9NhGPMNrolIFweRQeVDcNYY/j6J2BdS51JkiE3OE2etc0knnoJq/zBOgiNC2nshFBKwc992WLh7ujf9EJKAOso7a/JUmdXeHXY1j/zZLFNoh1BXHHk6LEmbcqadRddwn6edH20gpE0KiRJc/Yh0/gGTo7WmU8sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6vpnKTb; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6vpnKTb"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6352c8b683eso3703901d50.2
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 08:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758727585; x=1759332385; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mz0YVAHkGACdiuQeuG75iYcTslb6xWj6w2Q++DCu74E=;
        b=L6vpnKTbQqtooCWuViT4OkYi9AgNbX4cJik6JxdjFuHCHNl1yTqBvAEmOptu/J4XcN
         e6gDkfOkmGfm4gj4kMyWaseIGnYporEYCbAE8GWM5rpbL1LIMY9LKMChb4f0uHaGYiIU
         oim1n7VK12qsC8Hf0L5qKGmsUr7hRas0ge1VSzlM44Rlmrv1j6xgJGm9T4LC7XkphBAr
         g7ISZ7/aEsHf2WB7zJraBGFUuB/2HsmQM0HoQjM0vBjn0ptbWbqBvRAf1hf05Ga/bATL
         1h89nE7jfZFgShqgB8wSFBI2kqI2zc6i7sMfiTWl/iwIprArCsoUFjwMYYAs4YPYx479
         LCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727585; x=1759332385;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mz0YVAHkGACdiuQeuG75iYcTslb6xWj6w2Q++DCu74E=;
        b=HMSwAHMF7vKN/wg1CxWDGCSEdOrboNbBmi66gvkw8/If+TwL5SKZ5WcxMPZBgLUjAb
         MbQdwhwpRMJ+XzXzBjJzxEPRjQY0Hdt53TEYS3Z0NEqBO1I9u/QRVmY1cIu1Ke5ofbK4
         JzKWLRJz9phTDr003BFh4nru89gP26MCUSgjnKhbbMjeFO3ubfdmfqbNU6BRJ/T7RNWl
         j2I3m5aMaePKG6EIU4DUt+s3G3B9/W4DMF2d3+zG2s4GuaFD+ly25WKWFlt8qTppE7up
         5Hv/j1x4xewGvbOEFMJzw2cKs2+Uvegm7/OOWIijKAd0VdTGCqOpRbOXb6GBx7F6/sCL
         sGCg==
X-Gm-Message-State: AOJu0YxyDDFBEaANT9TW2VGqlEJ+19mnPgPoEIwNNQ8XL+NY5K+tvWci
	Z9gqXYz0r0Kn1IgPec5MaTtkzyQ/aedbMug0WphAE+uGUzgzzH4dKlkcT0+X438f
X-Gm-Gg: ASbGncswsfZ4y57fUcUL0fVRofbOxdg9cuiVwrnOmqPNqTqu1IZ0H/H0SXmh+lmsnEX
	BnMJKIMmWyyUiaNK7US3yxUP3Lq6za2nEY40pKWPtJNKGw+4BSpidikEWt/3XVq7z7vlrakanlZ
	zwCoxo9EFatjfa2JrAjIkGmqndWVI3nbBX8Xp8UMiaV4+OaJq8pYgDlXQJJ5hqgK7+Yy7qWr3A9
	Ms8BnNRxHlyJgV4ic86PAuOXI3GqeI+WCOI6gQxol2GLaShWwXBHge1qGjKHulRjhPVaLTqfRWB
	2UFYiIKKtMMfntSWkgnWlXACDbaAHTb2OVV9NYFBaKPSR9xsFCs/ER4tj3kQIB5DbiZkv8Q8/9u
	C0Ttm/uGalbLgtOuPJH7099OIONY0bysQRg0J3tEdw5fg3hRZJCM=
X-Google-Smtp-Source: AGHT+IHKTHgNRXGlkkLIPOEQRjpH9b+jog3AcQPdBWvSAzvV0ignIgIZfxgJWI5ZrYhYmBXC5pONhQ==
X-Received: by 2002:a05:690e:2553:b0:635:2ba3:c264 with SMTP id 956f58d0204a3-6361a76e624mr46075d50.19.1758727584807;
        Wed, 24 Sep 2025 08:26:24 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:5194:54a6:d414:9d55])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce8544b5sm5950103276.17.2025.09.24.08.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 08:26:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: 0-Based indexes for git log
Date: Wed, 24 Sep 2025 11:26:13 -0400
Message-Id: <B4B7BB74-9B69-4CDB-B4F2-FFB976A5B0CA@gmail.com>
References: <27456c8a-25f4-40f2-a791-efd35457d121@velocifyer.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
In-Reply-To: <27456c8a-25f4-40f2-a791-efd35457d121@velocifyer.com>
To: =?utf-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW?=
 =?utf-8?B?8J2Vow==?= <velocifyer@velocifyer.com>
X-Mailer: iPhone Mail (21F90)


> Le 24 sept. 2025 =C3=A0 09:46, =F0=9D=95=8D=F0=9D=95=96=F0=9D=95=9D=F0=9D=95=
=A0=F0=9D=95=94=F0=9D=95=9A=F0=9D=95=97=F0=9D=95=AA=F0=9D=95=96=F0=9D=95=A3 <=
velocifyer@velocifyer.com> a =C3=A9crit :
>=20
> =EF=BB=BF
>>=20
>> Are these date formats locale-specific? In both the US English and France=
 French locales I use commonly, the 19th of September in 2025 _is_ a Friday.=
 Showing 18 would only be confusing.
>=20
> Showing 19 confuses me because i'm used to 0-based indexes where the 19th i=
s labeld as 18. Showing 18 would not cunfuse most people.

I would need evidence of that. Everyone I interact with agrees to write =C2=AB=
 19 =C2=BB when =C2=AB 19th =C2=BB is implied.

As I asked: is this particular to an community? I=E2=80=99m genuinely curiou=
s if there are groups or cultures that communicate this way.=20

As Peff points out, you can probably make commands display your own personal=
 preference (or a locale should handle this for your community). But I don=E2=
=80=99t think this is something we can force on other people, because it wou=
ld be confusing.=20=
