Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2361FA272
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 05:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738818520; cv=none; b=qkwp+c40f/P+wsx7Fy043g+HyeoGrrbn/eHA8BoVkI3n32FOxAkKa9Ak13Tvn9FTCYBXKpVh1rQQzCohtuxvgTubmP1Lc0Le6WawSfNS1p3re84WH33v0GBt4vgv9DuohP9RW1Cf/NoDMZV8PZqwz02/lF3OeWRQv14X/sdl+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738818520; c=relaxed/simple;
	bh=cGJ4AYRDTSXZ9ufmIfKdDT8FQ8ivF0pz46aINfhK40Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXcp9zaAtb3IuiL96cAvSJ+j3JHz9jGrPh7X7+0J0UGtmVrndavmlny/jjQgcXZuOMZb+a4McXZhZ+oKP1PMSz6EbsyrOVHLlYVE2xBkKsGRL5LvwnTiRddC+RmVkMbB9X5zbx5gys2o4fTyP6aa4X2YljPvH971VJgrlbImT2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8rqC55e; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8rqC55e"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f9e037ee4cso643839a91.3
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 21:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738818518; x=1739423318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXUaIrL4g/bp5m5q1MKo9f30Wo0TuhV8g8gM105hTCU=;
        b=D8rqC55eYR9a1pwQts5UK85wmFlWoT+llBmyA0qfkjwK9OHTviWDSy1BGoSpQkfYMO
         44xpqv4yDUA/b3FIcaDI3z7OCd4EALfl3TWKo2h8h5+kvUuHQlG1AwWtAs6cjOWhH0J7
         mWO8op5TypFn4UUregvpQbMnpdQyWPM1hENKx/18xAp3aMTY0cqq7uuDxlIkYEwLur+f
         og58NcroMRDDPR6LVdT1rzzhVUkR1UXOAbgnGTm9xuxGEGYF/oOntCBLCdBvA35tgInf
         noYvHhaoEkKlHpl3TpxkOgsqTF/DGU80UcOrVI0VshtXudin8G4zWfzm2H/5hlPkiGhe
         KK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738818518; x=1739423318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXUaIrL4g/bp5m5q1MKo9f30Wo0TuhV8g8gM105hTCU=;
        b=a2oG+mDQX30q+SuFyMW/VE0FO/K6tD7Z9SF9koYUfaBLrqkSKYaIEixiqifPDsCIae
         77rW4+Gh/StFFftP7m2DBXEdntyvxPSUfeVWmO7wsCOgVHxIHdeDmJ2ZxqILH6LHUTr2
         rVjPxus5wDauop9b3V63zXSd1ltJkUL7DP59Nm3eePW0ppCKa+rlDunLpOgsVE5XLqCU
         R5L0v4ByLCq9tZ2ZEfXeVlpalV68cfeMZJvGf/wjqKzJOZBEF20c3rcHyCsrTmlyYU4e
         z9go3/4ZYKtgoQomSBoT6UzNcqFh0MTcrscXL5Yax060staFXHFdGmOL9LGDM0UdyCQt
         7Haw==
X-Forwarded-Encrypted: i=1; AJvYcCV9GOAeTVW7hcTwCIUG795TE4nmv+B8BloNg3mCfTE+PvF16Ts2708b5zKM3p/28wrmp7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9VQ2Et4Jk6MlMfI9QnsrdYuEFMbIzg2qzrbCg674zoqrryEPd
	Xo8ZE9QigoPPCXKx0EZf2rE24QcWShIT4Q7LPa5zzOzZW0H/sKnjGhVfeS2PXc+bcA==
X-Gm-Gg: ASbGncsZjJuYQzKIjyOODz/fo7/HgKRXv10P8MEmW7fEDPK0xa5qxSKqcJdwAZHDadk
	fHSjc9SWHeGNo6IRyWgbNUlSpPbXaTEH9nTRPTO7l9KF8ZNrvKdOwAufqggnpDtEMiw499Fhw61
	jpnaRaZ91CGj0ZnnQCr6AZyboNPxswT/6dXFdq7JN6mmYQyWm/cSNrbBtJJvUWuU8C6vSRcv1CP
	s5AmLqhFj5LvxM982dM42JJwEyOs+06F6mMPV87q2yx6gW6XnYoUGjl6dbY6oRsK7N8sfvdTA3W
	EUtsKCfmjk3oYcxpgMpvokfh/wYE3d0E
X-Google-Smtp-Source: AGHT+IF0dfEM6hDyFeSgQ3iapiaPMv9HQ6EMr4/5A7fyoB04RKyIpSjrY3rcavUgVyus9hTHJUE5CQ==
X-Received: by 2002:a05:6a00:2406:b0:727:3cd0:1167 with SMTP id d2e1a72fcca58-730351ea187mr8823195b3a.21.1738818518278;
        Wed, 05 Feb 2025 21:08:38 -0800 (PST)
Received: from bl4ze-rig.iitr.ac.in ([103.37.201.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048bf1413sm367074b3a.98.2025.02.05.21.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 21:08:37 -0800 (PST)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: gitster@pobox.com
Cc: ayu.chandekar@gmail.com,
	git@vger.kernel.org,
	sunshine@sunshineco.com
Subject: =?UTF-8?q?Re=3A=20=5BGSOC=5D=5BPATCH=20v2=5D=20t6423=3A=20avoid=20suppressing=20Git=E2=80=99s=20exit=20code=20in=20tests?=
Date: Thu,  6 Feb 2025 10:38:17 +0530
Message-ID: <20250206050819.113416-1-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.48.GIT
In-Reply-To: <xmqqh658m840.fsf@gitster.g>
References: <xmqqh658m840.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks, Junio!

Appreciate the clarification about the test script number. I’ll be more careful 
next time. 

Thanks for the review!

Regards,
Ayush
