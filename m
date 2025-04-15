Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3A44C96
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708930; cv=none; b=k7xLDpznLYwIXPEdk7/fI7j0C2SonkEpbst62j83yTS8o1FfaZVRG86Den+rCcGrHfjaFF1rZdVpMaP1MxkIhJza+hgYWHcOsvFmg0wx+GhcanUk+rebnPwRkFcoln8zSFq7QYua9YjIOGIjduzB1SjzxOmJ9ZX2W8vmZU6wB34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708930; c=relaxed/simple;
	bh=jJQ8LofTkkVWsxJtHVWZfjzmvtvsiRzrSOusivKB3uQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tQs1/SyttKxz3Pm3Mo3FNOmS0YMIx9LTmXsrsmzyKUWYuRVqVwDNabjFQC8hWu3rPhsvHP36rsELCKYSLWANrR3ltn7gl5tVWJfdpIuYzJuMM1gr9cCvRl0HVBm483sC+FEAA7AQv5wGGIQbbNYsliBHXW/l2Cj28UYdszfezxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ll803q7P; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll803q7P"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso8421109a12.0
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 02:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744708925; x=1745313725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jJQ8LofTkkVWsxJtHVWZfjzmvtvsiRzrSOusivKB3uQ=;
        b=Ll803q7PaAeNamTNP80RfzguOGjuHaMkwk/uOHajqpBex/oScW/VgIvX9C1bMkUE9E
         6DwzD2FLW54T06n921DfVUd+wjdmvAE9XXJ29SVZ0woJSsegPxHGbzXQlm4TSd/jPBPO
         aaepttMxH0IOmanpH7zi/0Mfdn2tOrWqUcRECy+ZhlWmj/RVfR/jfWHaNXxhiHE7vKIL
         GrlF/PemBl5jtPEPwMyMoNBdiUzmVpLaadZcoUreBubvqTNGuSNxAjb6Yd2DxCUsyjWo
         00zOptM7+yc6nCE8My7lVW364aY34RGIjMX6PgeMCDWXSp6vbk5Mow9AbMRyZOIWXpkL
         eBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744708925; x=1745313725;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJQ8LofTkkVWsxJtHVWZfjzmvtvsiRzrSOusivKB3uQ=;
        b=l7ZbDsgY2HtMLcxj/NkG/omlrh175BuJkT9cNHu8DZtdhZFQJCLuKzE61rRfB0rr0s
         MxRhrNJU9TFOgmki3aTo0HRC5uRPcuczk1GjqaSJkySQyfr3RViHqW8VksSCHiwzQUPf
         IJ+aXGSr0t2iPfe1VsYMmatSF5UWEutXnj3WRbBS3eo+ksNVlS9nFYo2oE26wwz5rP1n
         pc0OJNUsqO/UcxRRd4WtzPlc9VAwJUsw7M+KHKGC2Rj/DhpEkYitDSwNm/+Lo9ysxwQM
         ZMLSsw3Al+cYBCXQWWKOWFgKLM73O/mxg7vFX4zBRmUw9WGzVvG9UFeq9cvBQFlhDS7k
         b05Q==
X-Gm-Message-State: AOJu0YxmTQD6hpyyArdXyLAd0If7BEYbbIQihj8fWkTVy7lV6pculxGQ
	uOBGLK7XqHKev+RetYqlgDejffXhhV8iRgiLsVODJofTsJ1Uup+i6e4EUL7hG9PYmI7cIqNJGrJ
	7X4DTu3y08n6jfyzJDvTQ8pF3DRKgm51X
X-Gm-Gg: ASbGncs2BWos+Q2YXpFBrUU2yCT7FmiT3vEePciDpqBVbPnKBdu1eSzU1aoY+HoyQOo
	j6BOIpvNXjCMeRkGJUbNfPJDyyFhHIfwqRrTrCselgu8Q4Po/dI0OWTVcQ+iUntUNPKBXVAqVfF
	qbwFuCDtcmB5aKlqmORpKB72ADCZFznCl5lPTJFpNW617k4efYFQSQy1A=
X-Google-Smtp-Source: AGHT+IHeX58NJAhfVyFzATAwWkFyAF723N5c6vS9vR4LB26dplMoUhVdi3Z94UZF96bGAiw7e3r2elDrv9gPwKtC52s=
X-Received: by 2002:a05:6402:51cd:b0:5f3:9bd5:117f with SMTP id
 4fb4d7f45d1cf-5f39bd511d7mr10307068a12.3.1744708924804; Tue, 15 Apr 2025
 02:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 15 Apr 2025 11:21:53 +0200
X-Gm-Features: ATxdqUFus-mvph-qth8_Mq8qeFSSbBBKwLMRT2BdWSMe5NnPLcYUI0ji1Zy4wok
Message-ID: <CAP8UFD37_qsTjM97GK2EOWHteqoUKdwxjKS-SU629H2LnbTTtA@mail.gmail.com>
Subject: AI guidelines for mentoring programs (like GSoC and Outreachy)
To: git <git@vger.kernel.org>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Karthik Nayak <karthik.188@gmail.com>, Jialuo She <shejialuo@gmail.com>, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Git at SFC <git@sfconservancy.org>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

We now have a new "AI guidelines" on
https://git.github.io/General-Application-Information/ following some
discussions between GSoC 2025 potential mentors and org admins by
email and on https://github.com/git/git.github.io/pull/771.

We came up relatively quickly with these guidelines because this year
71 out of 79 proposals we received for the GSoC 2025 were spammy and
very often AI generated. This is a significant increase compared to
previous years. I remember that a few years ago there were less than a
dozen spammy proposals. We also received some AI generated spam
patches and emails to our personal email addresses.

Other organizations participating in the GSoC 2025 also received an
increasing amount of such spam, and organizations which documented
some guidelines against it said they receive less of it. A large
amount of discussion has happened on the GSoC mentors list about this.

Let us know if you have an opinion about this, or if you think that
the whole Git project should have AI guidelines.

Thanks.
