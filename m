Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B811E155A4E
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758588227; cv=none; b=Y970ONKrkHvm+ftIGeL/ZpXZ2/l67a3HZF+RBM/fw2r2cTHTXI/AhLx84jliOGUsquxIYf01v+rcsNe3mbL3zHZ4ViI0CHHg0VZbY+LIgL2/EYUPwckSKCIhgVdt0nnI26ssHDwG2ezIxuGZruk/+zCIMdbsS8GWYOR1EWhagXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758588227; c=relaxed/simple;
	bh=H+LHf2k0NjmUAEhUkidXUKrA53D26CVtdHEIxjh7o2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEhKovfahp3XC+zgzDewi+AqSjlTd3BnCCXlkHgpyvZchmsdsrBANWkxhGE6riYcJf2dz7eE10jO+ANDC3dBw3j1eo41EjMnfusZRFk2RsQ9kVRu9BEV0eFjyuUIBTv+1pd0IDBz/kDSqxniLTzvLg1EFT9ukQpGZHIr+qeAkQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ4aypF+; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ4aypF+"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3635bd94dadso39534931fa.1
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 17:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758588224; x=1759193024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4TPg+erqmw4s8nsNvMSmqBGqur2z3mLN/i9VfW7XgE=;
        b=IQ4aypF+AekxlvuOif1MuHXo1thr5sBxOI2AEJMEsa/DMKCdD+z2OP5RCEuk68xtxI
         Re2Dr0d5VdPPkMie+dzMMLzd3WNpPKVJ9BQ/tymTyjLUfbMo+3lDnhmEklH3s/wLxnFf
         z0oIDH6R/YMdNGanBQrDBZez95Of2U3twvEIO1EOyirKTv02L8ctmGGCjfWI5PunMHRD
         3+pKS3PQfAVucU3fDOub97aD5Mtc7i2xhL1n4A6tP67Dk0HHT0Yb801yoCvJKCsyHqyn
         YvLKWtqJQo3Y9zMK2k+VQldB4DOcwiktSLB9nFPkKeQtvxIM8LD6gE0Lhin8feygSsm6
         9eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758588224; x=1759193024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4TPg+erqmw4s8nsNvMSmqBGqur2z3mLN/i9VfW7XgE=;
        b=MCkPwQn74jUfwzFb33Eq7SO45gaNWJt5D/vMT4uCY5O3OANCI1koQ27sKosbSYGlc9
         fyLV4aMW/Kyg4xLdgVKUOWHK/8d5/IIPYzna+wVqBmjzrYYIrYKPFREB7FcR6IGjUT8i
         WNpfl+WKCWoezacgn64AosRMyJYMy/4WUB5sVzYj9C32kWixUYdePbjHISJYca6k7h4h
         HV/ljbMnTfBdF16BAx45aT7fxPaU0UuN6fT5NJIM/NfnV/vg0npOs5/mS+BK/Pebjhv8
         EHYbqY7wyOU3WsXCWXS3tskWz1vOJPmjdfqtz7T3H0V4lpIdC2kYd0eJCTd5O+9WRsAZ
         463w==
X-Forwarded-Encrypted: i=1; AJvYcCUiRpUUOR4J3kCJBUyIkiZQTZuRKWdxRL3aZem40fslm2o7zhrYaJEdfOPLjgBEgRGjghQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuDaFIBJ+5BCfDd3Zb2tSqFOknAz5BNcOrE9o9Vt468xu9qZEW
	buVjOpqh8kSI95MbVLQ7Ks2VSXJ9E1HmhBkiuThm2TTn1HY74qZwd9U4lmJreF0uO+wxQLD/22X
	5Z6SwkXSEsfAzJULlXAkz9PP/ctYFoPY=
X-Gm-Gg: ASbGnctZOB+WQfMpdrStqCEvbKnuO1Porg1ws+3frqb7uAeU7rh0dR/ZzKctVHr3GGX
	DHPlhQA/+mV/RmyR4VR7Fs3qttBV7+1yvah/e8y46F4MQe1GwfPu8en14j1QX9m3k8TG2l7h74w
	jbIx1ycItQmPPzz2Q7EeOFulQTG+KxgL21d5rwQzNbYC0BU9fo1QfSi04aZnbkPzz46FON7ZRyO
	7PXPHRc
X-Google-Smtp-Source: AGHT+IG9D7GbOk9Lo5cqD4gbnUj1XfqBxoWuBK9CYb23AFik0HO3sOzicbkLh8jM1cgTzO/nW2aJAvriFBvosCg8/FA=
X-Received: by 2002:a05:651c:23c6:10b0:367:64e:f5a2 with SMTP id
 38308e7fff4ca-36d171f0e0fmr1296131fa.36.1758588223465; Mon, 22 Sep 2025
 17:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-7-dc3a32fbb216@pks.im>
 <aMsxhp6ZO2Cdz7+k@szeder.dev> <aMteF4VTq2C5sAhK@fruit.crustytoothpaste.net>
 <aNGkt/DdnbjNu3s8@szeder.dev> <xmqq348etd9n.fsf@gitster.g>
In-Reply-To: <xmqq348etd9n.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 22 Sep 2025 18:43:31 -0600
X-Gm-Features: AS18NWCg8MMGi2jDVW_6-hyb5svqiQnNOgNZ9uUjtaSwRRazoR0Hd-5WrOHfl2U
Message-ID: <CAH=ZcbCiSWSQQBEcqA9PTsrG2qgpo7a7zx_ahcUS227p0zELDw@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] BreakingChanges: announce Rust becoming mandatory
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, Ben Knoble <ben.knoble@gmail.com>, 
	Christian Brabandt <cb@256bit.org>, Collin Funk <collin.funk1@gmail.com>, 
	Eli Schwartz <eschwartz@gentoo.org>, Elijah Newren <newren@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 2:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> * By the way, I _think_ I never saw that policy document until
>   Ezekiel started his topic and sent it out as one of the component
>   patches; how did it get there from brian to Ezekiel's topic?

You'll have to ask Elijah that. I was oblivious to it until Elijah
pointed it out to me, and now I've forgotten.
