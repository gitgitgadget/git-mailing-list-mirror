Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96E528C864
	for <git@vger.kernel.org>; Sun, 12 Oct 2025 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760294474; cv=none; b=EXfRRH2tOOHV/uGT70pB7rRtwCh/K4STlbWdtIiWXyZy4URU80yfJms3bBBocmZHAyb/xR1Qe7NWNPFHI2UeFiJYJFrrdZNOgDAZB0MthQ1qnBLUpXKxNWw/udF877m0/F8JsrQd4p3jBHqaADjjE9Skm4RgTMw4ceKuJehQDb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760294474; c=relaxed/simple;
	bh=fmRMScDAznbi5L34yUFyVgUYb2Yxx8HzpqA0O6le42I=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=KsjI5fyg7oghbXDU4GJ9z5kr64L7kdJdDRdLb1Ts92VxlngAeu3MT8UhcmZytmresSHybOPYeB+poFKcEZt18ORAnOw4ttgECl1G2b42LuZu4lIxfnqsmKxfZWewpDg0iFvP8IapNjQqbkFIyZIeGYj0G2KpAtiP7KraydYQ5dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKtJUrF4; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKtJUrF4"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-74f6974175dso36107687b3.3
        for <git@vger.kernel.org>; Sun, 12 Oct 2025 11:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760294469; x=1760899269; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFAlFVIH+LgVsyP7yAI1WD8lOBSb2pbr4W9MhpMUQXU=;
        b=RKtJUrF4I5+j3gKFMwWQSl9OvDGTmcOU/bbWlXSppMadxpIhxZxVinsd9hWIKJiLg7
         aFJ5Y1SnQcOCFMEggTxvdEXzfHXGznIOCqPGrkZu+MgePmjwskDgujFlLiz2VD6VI2JG
         /xK3+WISctrTEhR3B9ZYKrCfOTM/RPAkvzJjQFAFKI0R+MsrVZ6jHzC9sRbBvoN2+G2E
         Eg/oqXerzl1LBTQJZJnOnnFcgZbClyiPjp4dkZyRtBVMzGNL2GyylZybGzTGsA/JN+21
         R019gGK0rwoewpk3GDYn6np0AX76NuETeh5//kD38lplY0hfGFAwU5r7EwzG3mGWy2HJ
         burQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760294469; x=1760899269;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFAlFVIH+LgVsyP7yAI1WD8lOBSb2pbr4W9MhpMUQXU=;
        b=bfOkvAII3qPcDQVcmq2R60dB2oMuVkbHCTN67nEussUZ+gDbJhTnXe0C0fsxvDfb+O
         H0UEfOOhQ+HfxlOSJofS1lJ0+T7hr2DZcMKDtkbwWmjg90m2S3bDPreRwmEoXipMa3RO
         Ge29ZUdW8rLfyvUCEHCprjldasy1n54DJr35ivAlMyxtK5J2Jmc/Mk7U40MebuqA9W+I
         95m+lc99j76Z4BKEa1xtA93JXebfHN4Yj0MSTevlFgGBlqNdwKXUdjMD2607Yahsbmur
         TCASu6oVeo8vPbQNyEjGSo6WftK2RVrc4yPjjyGcMjpHKVX+L3SVBsI++A6T9FvOaLTs
         NBSA==
X-Forwarded-Encrypted: i=1; AJvYcCXCAPkZaDMwLg55f0a2p0PghCdC+k9cRRVwjF4y7ihcHXs2aCpr7ovwRhvJ888LRqd51u8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmhIlqSRNIS4EATx+iiSyWHpzKCO7KzevmFyqm2dEPlbjUUV91
	jm6XUknZN/RZdP8OERc+P033B4mdB9KGY33kGPb2GtAnFtmh8l6xmeeb
X-Gm-Gg: ASbGncs61yRc6mmjU2g3yIp+40aR2otL9/+pRYaxvR20CprRa9mhw3xRayawh+N83zY
	E54ZvZSTNkGVuhvt92z+qfRLrWv2/Umu6FX0NL4OEKwVrz8k/Snn1EIrpQycu/BTtZT1R9H1iUm
	m005D5A1gJhAWtkKAXqsxLSj118EfGLBz4hEeVUuCxPSNh+iFvoGqm6SC259wtcx7TYN5lXhRWT
	Ve/aGw1eXvgDfOVXDpYtl8jLSS/hZwklcC5By5Szq2YEDlryt3AvPcKOqnmSpiHvqBHXU+3b6cm
	paZoMOcrOHP9wAC+rqqFoxSZRbqAtlPNq0Loz5zvlK6yEFYefyvzHUJmee3it4Xewm3cP1r7ZUG
	rzJmt3yHomsbLxrHgnDIflCPwqjk6jE0Dmk7R2tR2W0zr9mTc24COq1d6O01SFubadyP7uVIFRd
	8WehqScAq57A==
X-Google-Smtp-Source: AGHT+IGYCLm7QZYx2xG9zm+dxT92AWKqMaHX3WHirlBgjMNjpy56SjO7d+ckmHg8e4aq1g2L89sKyA==
X-Received: by 2002:a05:690c:6b11:b0:780:d22d:754e with SMTP id 00721157ae682-780e141bc6amr181294297b3.0.1760294469559;
        Sun, 12 Oct 2025 11:41:09 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:2564:71f1:92af:6548])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78106e1e4b8sm21032177b3.17.2025.10.12.11.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 11:41:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] doc: explain the impact of stash.index on --autostash options
Date: Sun, 12 Oct 2025 14:04:22 -0400
Message-Id: <B78CD1B1-67C1-4EA1-94A7-13AD40C43585@gmail.com>
References: <xmqqy0ph5ov8.fsf@gitster.g>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
 Phillip Wood <phillip.wood123@gmail.com>,
 =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 Glen Choo <glencbz@gmail.com>, Karthik Nayak <karthik.188@gmail.com>,
 Denton Liu <liu.denton@gmail.com>, motisd8@gmail.com,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>
In-Reply-To: <xmqqy0ph5ov8.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


>=20
> Le 11 oct. 2025 =C3=A0 13:29, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BF"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>=20
>>> On Thu, Oct 9, 2025 at 6:55=E2=80=AFPM Kristoffer Haugsbakk
>>> <code@khaugsbakk.name> wrote:
>>>=20
>>> This is over-specified IMO. Like mentioned this patch could be applied
>>> on top of commit 9842c0c749. Then that merge commit will not be
>>> reachable from this resulting commit.
>>>=20
>>> I also don=E2=80=99t see the point of mentioning when things were merged=
 in in
>>> the commit message.
>=20
> Yeah, that is less useful to me (there is a tool, given a commit
> object, to figure out at which merge it got merged to the mainline);
> I didn't think of a way the information can be useful to general
> readers.  If the mainline merge was a release or more ago, then it
> may make sense to say "commit X, which appeared in version Y, was
> broken in such and such way, and here is to fix its breakage"

It=E2=80=99s not clear to me if you=E2=80=99d like to see a v2 or not, but g=
iven you were already happy to merge in the latest what=E2=80=99s cooking, I=
 don=E2=80=99t mind not sending one ;)=
