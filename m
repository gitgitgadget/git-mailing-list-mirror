Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ADD13C9C2
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712739125; cv=none; b=Unw2Bs3C28fnxXmxfHl8XN0qNholVLo/fV1eStrNvy0D2I/j1zzBsKGzg08vjj0vLf7mV7e6YCIbvdL3i5wNC1l+xQ1jPFX7KyFgLkZIeQCWGFHKbqkJEVFCBJB7O1iBYe5YLkFs8u4wtf2JqDXOS3Vo1UebmLjRd8MkKGc54Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712739125; c=relaxed/simple;
	bh=QSyZIj4Y9gkiYJu8jHoTAj9DbDrsz9sbhOvacoquxj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLQzDK0aR9TqoSKfDQvqnM/TSULuDAZqESq0Gxltvo1UV932b6IPHN3gpnrjfdsxDWtPWjkxOvDy+scAub5ol8cXVzhSYCkli9tzVg1R8tGzhzq1/74Ak2hOA/NeuOkzkzzin4Az4WczThgbsLRHWa1p5l1mVPXJ0WTxqN/+0Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3LjyMtg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3LjyMtg"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46a7208eedso933010566b.0
        for <git@vger.kernel.org>; Wed, 10 Apr 2024 01:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712739122; x=1713343922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSyZIj4Y9gkiYJu8jHoTAj9DbDrsz9sbhOvacoquxj8=;
        b=W3LjyMtgAINnfvt6kyiR5m/uF5mL9DS3xfRYniXbiluxZLXkL+GKn6kW9UsdS9JbhK
         JmikJ0WigI/+7zjBus2tPzyiy2UIs+Q91RZnZA2ucLOwelIvsQzf7JoLCx3yrS2jxrXB
         EVYGBj7Jja2pcbPWfc8hVwP2wz2b2bkMtnLHEdvgS37v2srLFoIRTr1mtFB8Aj6FAuV5
         rZYjNKqG0dD0BUI0P4tId/4E10716mCYWlRTqqM4YXWBv8oXPgSqpkdzGVe+ZG6gNoFR
         2VmMguNaczXn6FTZ6VlvyPIt95SFiwN2k5+2NJ6v4LT/1NskjErBhZ2mnO4HeRFGzevA
         rFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712739122; x=1713343922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSyZIj4Y9gkiYJu8jHoTAj9DbDrsz9sbhOvacoquxj8=;
        b=R0bJi7lxe1cwqHqI0GBmBRs+5NM+g0XB7pvDpBDShcrqOybnt0YEevTVpLuF9LnnAn
         2umz00HPOObH/g87CRv9fSk4qcyAg/aohJh0BAtGdXdtXezH3G9y/kOkiE/K3AooVw+s
         uEltxV1qYjkUvPJpnKRnCAayfv8GB7zY1HSHMqxBrBaW0vnkC4I5dnRAAC6kUpkLnj2A
         /Yw3DlAfkqFJu9OG3f0sOFraJJBgKTmaSyJJGzS6c+hLdmyPXtg8VdtScPNxDdWrIBZb
         6V6n8Lu3G4we4tUAM7FfRofmODoNixktdyV1PHK/TjJprhBC5LeqzJiL7wzdoaZ061yH
         i/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmFIIBtlqJ18t/3xRkEBIF6FObskfBoXIHtCjeNRc0Uai8SdtmqCN4S/RbGiVQQvZ/Vog4er+9/HatZrjqiXJJQWc9
X-Gm-Message-State: AOJu0YwYInZRSqSrDczTORXq1wwFoapU5E/TrznPsAv4e3YtK3HpI6b5
	xKvABwdF+Nqn6txUd9npAo5FUp7mE/LBNoCTaHupFmw+xZHZnVj4vKcnjKzwVYRZKbV+t8INGsP
	G3ELP/ODCK0HNJv4d3AuiU7OoBCEfyhJI
X-Google-Smtp-Source: AGHT+IFax0k+CdMOw5OV9q8pURepdL4Ax4Sr36rP5Fa/PujjzbrC/ocM3epTFsfc+ECi8opzSnEJOHKvncUmPTGfKYI=
X-Received: by 2002:a17:906:a90:b0:a51:bd13:96ce with SMTP id
 y16-20020a1709060a9000b00a51bd1396cemr1035398ejf.3.1712739122501; Wed, 10 Apr
 2024 01:52:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev>
 <e790bdf714bb4c2a67708c016a97cf4f9e79ac48.1711960552.git.thalia@archibald.dev>
 <ZhYxNYR33ftEfcPk@tanuki> <CAPx1GvfgC46n_5fk3dHxg7dn393UVMi0CtHKqQ_GAaqnV_ECCQ@mail.gmail.com>
 <784B5318-F155-4D93-8085-62ACA63432E5@archibald.dev>
In-Reply-To: <784B5318-F155-4D93-8085-62ACA63432E5@archibald.dev>
From: Chris Torek <chris.torek@gmail.com>
Date: Wed, 10 Apr 2024 01:51:51 -0700
Message-ID: <CAPx1GvfUs-dR_RbqnBT3YhDJPMB7b=+fzyow8qjJgJQnJwg0Pw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] fast-import: tighten path unquoting
To: Thalia Archibald <thalia@archibald.dev>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 1:47=E2=80=AFAM Thalia Archibald <thalia@archibald.=
dev> wrote:
> strchrnul does what I want here and I=E2=80=99ve replaced it with that.

`strchrnul` is a GNU extension (found on a lot of systems, but not
part of C90 or C99).

Chris
