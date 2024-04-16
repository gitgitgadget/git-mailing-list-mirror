Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2F3127B53
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263022; cv=none; b=PH3/ywIkHwU+19tQUlBt9bEKhDTyCpTVeo8rw5EpPdj+N9p9hx8SfnhoCSiw1gUkMItmr//6UnPiIkJR6UUetr6Pr5WTV+qE8GYomouRcw9YhOXWHUhBiyV+d5ee9o3OmND+mljEb6pqBWGq9HT9Q9Cz8e+cSgv/3gtW46qCdlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263022; c=relaxed/simple;
	bh=GTZapwnhYCnPBcD/hNnGCg3rC8yDILt9iJHia31MYdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiFsNlujU9hnEHqzaytiJN3SNKV3KHn910SWkkljn525x5tkwU/orM4p6FmxtBQHzveDM1JHRlrHp1NsyNZtAdRSW17fRU4Aq5JdqPocCW263591r8IcOQW9VuisKM/pP/Sfu7q/OWz6Rnrxo/Ogq1705zKETVrJdz9xFGPfRCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eies5OVL; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eies5OVL"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e2c1650d8so4148288a12.0
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 03:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713263019; x=1713867819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTZapwnhYCnPBcD/hNnGCg3rC8yDILt9iJHia31MYdg=;
        b=eies5OVL2GHiRzrrmttlVvRaLK3bqC2qMxGfhArsZWUqo/JnLOV2NHZzCyE/a2map1
         7PCYTj1+Ve16LX4wzp9mtpQsfT96XVccZ41cKRZBdyM5SaWdpW76z4HwXxonKT8xrLCs
         W3QqmB137widnuM9vd1HzG/pPWxCkXkw3VUre7JqMhrecHTDjOlpFHTIIHBrKvAbAQCH
         QmJyXOdy0iaZm5KV5iV61gGuW+MXKn42PBV6jZzHaiPSRRJVURP0+21Q6uJYCzT4nvGI
         crQWHsle5Yrdv5WIx3ar71dbwJq1bO4DA6TT55sPBB/SPqYJwL6Z2z/P5ecqvye6yZ1m
         Ky9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713263019; x=1713867819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTZapwnhYCnPBcD/hNnGCg3rC8yDILt9iJHia31MYdg=;
        b=FItIyn4iB4KXB+uk2XjazvUYcuL2PQbIRobpxBnNST2EvmVYeY/dSc/5EyP5x4d6M+
         TyV4HKUZCJjRNYT8Z4aa3L4RkuoUfWU1LdM657DJs5Vt5yba/m38iTB1GQqv4xZNQJIY
         DMIkRsebf1Ts+Qhxp1WqvuMQZygMvh7M+ts94EnnqO7XRoNN6exCfetcsSLsWJ5ct6Bb
         l4GiIJNngdxs2aaVn23516Isj7K5LFEunYPEINb6YNVQersMSq4yoDFVebvt0LWuSgyU
         PApXPC15nN7RTY6BYAeMQyDQ8uTKY0w7638kelkI6jn9jhUsHUq5s9pqwcH6FM4j4iW6
         t9ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVi1PXGzbK7EvzITyQsksbWA3UwIvTf+dxa8fyCTfAp/D7jjaBBElsgZ0PRel9fPQw0kESpOTgHuRaNRlRnbEsBZqAZ
X-Gm-Message-State: AOJu0YyOHq9f+wTg4wR2lzYSgQNsqx6f/ag+TxcsGC3TR/pOU8rdHYWN
	vzl1EGxT6ay1oMbiO2mLRv64ys4e+Ixls9bJ4hob+rx67JYDzWM19g/GazrhR8FXwdAxV/ow02Z
	BtdycNvgvuM50pPCcPOGQO6QAg0U=
X-Google-Smtp-Source: AGHT+IHdmUhObLhoH4Awpe0QTCiUn8s4DW92FM9cMcED4ekVpvherZUoVtcEozq3dvF8cSGk1XSg7zBnDaZ5o/hWWbo=
X-Received: by 2002:a17:906:3b99:b0:a52:527c:ea86 with SMTP id
 u25-20020a1709063b9900b00a52527cea86mr4913691ejf.33.1713263018835; Tue, 16
 Apr 2024 03:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhcBJSP4MxX0AMFM@nand.local> <A7406B15-8DF1-4B3E-80F3-BC56A9AC4D85@gmail.com>
 <CAP2yMaLpJqZ+aC=rNPjkw2ybW7PjfbW5QuHnZ9mYs1NhJ1L5mw@mail.gmail.com>
 <a34826be-a16c-ebb4-0450-274dcf75c31f@gmx.de> <xmqqle5epn62.fsf@gitster.g>
In-Reply-To: <xmqqle5epn62.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 16 Apr 2024 12:23:26 +0200
Message-ID: <CAP8UFD21rVOep+M5MAm4JeB+=DXYrcWFaFoJ9uEVs=Nw4KCCVw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Virtual Contributor's Summit 2024
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Scott Chacon <schacon@gmail.com>, 
	John Cai <johncai86@gmail.com>, git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 7:13=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > For the record, I would _love_ to join and celebrate the 10-year
> > anniversary in Berlin.
>
> I think 10-year was held around April 9th, 2015 in Paris, France ;-)

The first Git-Merge conference was in May 2013 in Berlin. So Dscho
might be talking about the 10th anniversary of that first Git-Merge
conference. But then it should have happened last year (in 2023). Or
he might be talking about the 20th anniversary of Git which will be in
April next year (2025), or maybe the 10th anniversary of Git which was
in April 2015 in Paris.
