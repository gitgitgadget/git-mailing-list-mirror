Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7921DB154
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754843681; cv=none; b=Airhz/R6Q1wDQf1u+82jqgmSNMO2RRJJpPUc7tbIhaVRtvDiYz+yBqfuo0xUrTh0j5oEjHxm6HF73LSXCeP5/d1R72pLMxzZAFj+y8fEoQp6Z+V74vs3aUFwmTyneZl3zEi1d/sZjBmAP2b+MPKqnKNznWvs/k9qd6FWUJ7BZKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754843681; c=relaxed/simple;
	bh=cXZpyipYFWQzkDWV3jwGkwQYWX+Jvvk9ifPkjIx0IH8=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=nPBm+Z6GeVsjlyPxeBrgt+MCxBGKGnSeG4rcnRsj4EhjG3d+1mYlLDJC1090/wmuF1Pu5ed9Pihp7romnFyqHAZmRURKZgJirEvAwHpeNRT4JpdrAokzCVkMXSzC9xOWUtsNS741T8ag2UwIwnc3+RAJ+IPYDoJxM3DhOkO9jHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSO0O4Ct; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSO0O4Ct"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e90941d1675so232474276.1
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 09:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754843679; x=1755448479; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ChRyWFLixiqRCHa89bvmIOd8TzUyRM1CNh01qAWVrA=;
        b=JSO0O4CtSSRklGuu42h39U6UflgzSzJPCWTl7psh9Ah37tCq7fO+WG2mFW6rPPz11q
         t483gVWi8Fu3BDQLreze5aEuYxtmJymYNXzQ2xRM/b6uUQgNWDdMvtONLTmM+lqWY7/B
         jwskuXQqx5xuXppXMUFW4/CHSJ9ESL6bTGh7sBp7nvDp4r2kdvZPrkDGLqg+V0bWXCdZ
         XBZROC+HRubf7uZK/V2yGmFkbOWd3rkHygDn3sxYLU4FGpGEwHfqKRZQbmjADz8HF/9g
         bT4B+S05QkCmajgoX8R81ituLencLjm7UNkfdYeJK3GACzIxPR3Xkw1nKbcjfMFI4lTH
         hgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754843679; x=1755448479;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ChRyWFLixiqRCHa89bvmIOd8TzUyRM1CNh01qAWVrA=;
        b=dFhz8gsXJId8u81gQ3dVaVldvfiyxSsdC9Fz19ltDxQjhTDm7ogAceHbrNmygDZFEB
         sN9BHOylFCeY0y7lqQpQdj4+lkBI1GWbc4D9FuZgRvYmqa6o6CvF7KKdR8vWd0/ldMEm
         truKxDz1tI9XNhnzYGRixE3D5SAPDn7B8LVTYCO1DNFVSNzAsf7Y1eKZ85XwV4KvY9by
         cYwCWeUpclKUOQ2Ov9CphWottezxQoqUOQkcozeBzk7Zcgjx5P5Mwi39zYubPiuCS89Z
         6G82/7UCkyVfksQ/djRsMf0PL6ldfgzRCRJC90YlkNh+3C9FIieSJvcstOKOqo67Cc3y
         0zsw==
X-Gm-Message-State: AOJu0YwXA/R7bow8HFY+8G1I7agmISZ/BT1nQDdILoy/C4tGI3esY1dJ
	SiuYRmGjwCWj16F5it9CyYtDhRshxKW89wKIg/na5LvnwarSLnA9UYkt
X-Gm-Gg: ASbGnctz+HCGsfCKuIawiceVL17+5IBRXOU52YyYlhqt6XgQeGOq5Nio8NAVWniL3Eq
	dtoMzT5gZZ2X3yozG5olN/2MkT+pWX/BIBDN0HBtBrO8HKH4fVF8x7QRO9s5F6KPAKwGouzC8oC
	LYVWimISST2XUlFFtjhovAr1F8EuhzeaP8t62m4ovl+0AVzQG6OEJMAnGe0LJaFyQblBe7MqgAN
	x98FpazvzrcIqnnRoWPYzUcuSAVsvwwOR29sE5siDPOYAFs8MBUCk5/9T6qhENdGB+YttG6GyT1
	R8t3gle5LJ1++a5S7gU5rKCQ8LQVawEUG93OKxedMh2Pqu2u/c/aM6IXXwLhVUCf01VK/Nkz8Zb
	VF1bkHSSgBDZX6YBRwUYknL/uusl1n+NClEhmnuDR7W9QH+RsULQoacFHu4Shmw==
X-Google-Smtp-Source: AGHT+IHwnuAMK8a+i5Rl8QQemBd7M7qNis6fryBmmdGogyfntC/4MUpU9uYSj3n4Kny5Je84FhL60Q==
X-Received: by 2002:a05:6902:1003:b0:e90:4d6e:f9f8 with SMTP id 3f1490d57ef6-e904d6efbe5mr11222875276.46.1754843679111;
        Sun, 10 Aug 2025 09:34:39 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:dd3c:fd52:990a:67b8])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd3860a91sm9057920276.23.2025.08.10.09.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 09:34:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/3] clean up some code around editors
Date: Sun, 10 Aug 2025 12:34:27 -0400
Message-Id: <7A0DC0BD-E0DB-4A07-B4E4-1474D58B5E75@gmail.com>
References: <CALnO6CAQNF2gD5BWvm50LN2D6mAHNRxdzeZ7ZQhvt-Gr3oHumg@mail.gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CALnO6CAQNF2gD5BWvm50LN2D6mAHNRxdzeZ7ZQhvt-Gr3oHumg@mail.gmail.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 10 ao=C3=BBt 2025 =C3=A0 12:06, D. Ben Knoble <ben.knoble+github@gmail.=
com> a =C3=A9crit :
>=20
> =EF=BB=BFOn Sun, Aug 10, 2025 at 12:03=E2=80=AFPM D. Ben Knoble
> <ben.knoble+github@gmail.com> wrote:
>>=20
>> Changes from v1:
>> - add a prep patch with style fixes to t7005
>> - rework the environment munging to use subshells, per Phillip Wood's
>>  suggestion
>=20
> Apologies; this should have had the "v2" subject.

GitHub CI caught an issue from my rebase, so I=E2=80=99ll send a proper v2 l=
ater.=20=
