Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFD328399
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753322187; cv=none; b=Cvf7y+VqGEvDPNHkHaNmk/DrkPGzeZBQkFp2jz+t0+OSSXpCrEjouHuWdSY92wRDZVQWcL9/tzZFcZZQtC+K2N6cGYsV/KdsLuuHcCBGzYYeCkAFcazQ6CRD1PRQaQdnKb9iSI9BQI7ZUamxlw4Bqe/SEA0PcCxG22LkKJ+jdek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753322187; c=relaxed/simple;
	bh=5p4Mbj0GBQZX/5eDbo63vjuHdEj7n8P6Wj4k1OPkh9k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=th9AIaJZK3PA5pPOG3xNLliTBFvVtJF21DIKQQA9aGzAUU16ZjKaqD/j6naltU5ZigFACjISGGgDuoEr0QLxzdtgGrKAq1KRIFAqrpKu19w2Km1W/K/YXUN/88j/+1x7B906esK27eQ4uju/oJ/6Qb1vyi2RYSGgSLdWiFKKdM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmGxfN3h; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmGxfN3h"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-23dea2e01e4so5907825ad.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 18:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753322185; x=1753926985; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnxJMZ/Jy8eOxdGwJX/Xy81m3Zyx96+mr5CSuXWQv1I=;
        b=GmGxfN3haKrX/soh3widfnO4DkcFtToRtGPJQxMK89Q9xLVN6pOIBj27Htu1SLpEgy
         OOwfGs7177oM+ckKMY/hPJApcbCiHce5PGKi9M3jF07RHcorjDik1gdiP4JXquSQszbs
         1RHPUCVmnIPJDFpY1noZJlYa34qLlnIKdMHx6f/zDHQtUnekTL/R7YLHfwSbfyFpGQNl
         z15NpsDFjEmqxhiNJVpZH68Nd94nnrwNd9UsQvJjzsApjxheF5+kZx0zRwT5t0AMno5/
         iKY6xq8Gig9Bmrbwh92puAvnQPPnms265p6tBvICLTPIys+VOanv701cYUoCUBznUv44
         /oJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753322185; x=1753926985;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnxJMZ/Jy8eOxdGwJX/Xy81m3Zyx96+mr5CSuXWQv1I=;
        b=mZTN2KOwBNeNBJNVdIAQEsFeuJS2OKSRwG9rnZEjq7Me+PO4gWTVWUZgJebNY0hlAn
         3stJwSUOMTIwJW5KoiKnLn9vUNV/T1dGItRAdit9SvGnXHw7aBVAOp828VUgk1eIaTbY
         Zbmg1tBOAHcr6TFmuamwnCjmPP/fxZe7c8KRThrxfSCS3pvsLrSgKWSKpuUNn/NzuqHO
         D4KmllCucoxuovnwWgJJoALxE/h4STntK/z14/smuAZ6A0GTfVNZ7MfI+ua2RdALimDx
         bBcMbxy5CuICWZTQN05x40XlIaYjNjz/wstK22icNbEq5/PCfsiztzjsDHd97jegFojx
         c9aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS5hoxqwZdzjxl0WIbd6m88fRFOTAYIVoxKNgyqVW+jcKkY8mWV4zpGW5PcZ1on+gowns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVeNjJeJcFr38Il7QBrj4rNo9+r8u3GcliliyQLH7JhnaVQCsN
	hCjaoCEqNTguHPva3MR+HFR5YNY9mzk73QOnxPTQT/ZwIQQ2XaExrTmJEl+v0w+wTLA=
X-Gm-Gg: ASbGncu4y1YnmcY+QdEWYC5KfheGXnBIh4WeHtRLbCyNKvtpTOy17BMD8htgWkWUr6V
	TEmNJfvtEaruOsgBirMH67bnR3Ar7yi9TM/F/OnX4b6Jm8ia5xmB29uBT1I1e4JW1jPXLGqFBSM
	yH01bcay78yafcxx4aNcvXM83peJdrrlmuISe7riVwCCwb2tk1XU20QRwhdu2DbsLoZxv7E19Y6
	qga1RGpg+RdnqMFLNL/cmdefco/1Bhkjx6XbJ1z05rN8LTGpkKoG62pHWskI+BhCqgdYcO5T9dw
	v06TOQTh9Fl4iNqjFJiXMCzOgMG/oWFXFm29qtx8lpvIQ/yImkmkmK/MsgL3PvxW7nWHkbVJp2s
	f51qE8zsoNUZNPq5IJPiWkqhczXQGhwud/MywhPpFXeMyr/k7kXJx7UYo4cAbcxl629fmwAxo8y
	c5WiEPV2zHONZKmwTDEOv6ae8=
X-Google-Smtp-Source: AGHT+IF1yk4jljDMgzzd4BfVx0Rf1kjp6pMYJ/G0yWe4YRoovrzBS9KmXYKsOrngZ8YdEBSLHRisFQ==
X-Received: by 2002:a17:903:946:b0:235:27b6:a891 with SMTP id d9443c01a7336-23f981a83c9mr64549875ad.28.1753322184761;
        Wed, 23 Jul 2025 18:56:24 -0700 (PDT)
Received: from smtpclient.apple (awork062145.netvigator.com. [203.198.28.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc711sm2855945ad.116.2025.07.23.18.56.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jul 2025 18:56:24 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: git-diff: --ignore-matching-lines has no effect on the output
 when --name-only is used
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqqzy6omul.fsf@gitster.g>
Date: Thu, 24 Jul 2025 09:56:14 +0800
Cc: hi@arnes.space,
 git@vger.kernel.org,
 =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <23DF2497-D379-4EAD-9271-D01D7D8F3E8B@gmail.com>
References: <87a54v8nmz.fsf@arnes.space>
 <12095AC3-BC38-48DB-95B4-394F9F7DE054@gmail.com> <xmqqqzy6omul.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Junio C Hamano <gitster@pobox.com> write:
>=20
> Lidong Yan <yldhome2d2@gmail.com> writes:
>=20
>> The `=E2=80=94ignore-matching-lines` options is introduced in =
296d4a94e72
>> (Micha=C5=82 K=C4=99pie=C5=84 2020-10-20 08:48:09 +0200 5803) Since =
the Git documentation
>=20
> WTH is that reference format?

Sorry. I should use `git log --format=3D"%h (%s, %ad)" --date=3Dshort -n =
1 296d4a`.

>=20
> It is just --raw, --name-only, --name-status, and --checkdiff output
> formats that deliberately ignore content based ignore mechanisms.
>=20
> And I do not think it would be a good change to have them follow
> "ignore" bits.  When asked "has this path been modified?"  "what are
> the before and after blob object names?" etc., it does not make sense
> for the answer to be different depending on the presense of -w or
> --ignore-matching options.
>=20

So the meaning of --ignore-matching-lines is: although the file has =
changed,
I don't want to see its diff content =E2=80=94 it's not that we consider =
the file unchanged
just because the changes match the regular expression.

Thanks,
Lidong=
