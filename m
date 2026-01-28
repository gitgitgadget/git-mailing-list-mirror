Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB93D515
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 00:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769558713; cv=none; b=RLvCxYNHxLduzrtB9MSs3kSknJQ7arjRbhwnABOEuyTSzovMER8oOwm2ivb+/r/b4tJSABr+WOyUQSRTnhF5A2o22wrVe181ztq3hOl8DRzn5mo67yj6NXd7SdOLmiUgNU3c5+0sM27sy1TPgSyWQs6mQYysnkkigH1FMWa/hOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769558713; c=relaxed/simple;
	bh=joFYrXp498W+C+iM9v0EDlQGnGnr8EN5gMCwOYTytiU=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=f/D6UFDv6RsHM8iHVrg/LY/GN1r954llPVARLBs4g1AoaqKSVXSZqdZrERRMuwS2iWwdk9ZKCSQG6lc0bF7DNcqau7j8Z6mgvm8AN/pDm/cTHZOUToyOfI7sDkbgA0XfMfZbgtguHYnByJ1khQKrk+eRlJOejvsfdR4J44u0u9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEBp44gc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEBp44gc"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-432d256c2e6so5973603f8f.3
        for <git@vger.kernel.org>; Tue, 27 Jan 2026 16:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769558710; x=1770163510; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=joFYrXp498W+C+iM9v0EDlQGnGnr8EN5gMCwOYTytiU=;
        b=ZEBp44gctGzfpzcY8ti+yHLurQyCrA+iS2B84s50SRxu1p8gRBkXdrgFi1dY50UZnN
         Ok1vuSMjuPM1274qwbCRIEQguSe1VqO82WmmraUBn1T54Cg1rzZla0275bIEwNUr6Ma/
         1+jCo2QbTsI1Z+Dn4rJX1Ik7iJHZxtGcni2xVFYAI6Kh9WjY2jgR5v9BwX8/J8Mx5/tm
         muDmS3xUwKXGhOPlZGdQhdS3dPHDHTqZ/HRVH8nbIsDK0H25rbsSoYn4cVWsNuObey3v
         6v732ZYsA4W/09U1KLN5bE1EmqJuf2x8WMmSMpnWaTCpT464IYEL0Jiiygm1MsLqXu+U
         ebQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769558710; x=1770163510;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joFYrXp498W+C+iM9v0EDlQGnGnr8EN5gMCwOYTytiU=;
        b=cTHQrC27c+XjgnUgtr5tjVGHomM4fJHS+sgZAIUXNzfFzrqrasoapj3mQiq/t0TRH8
         P46Tn8I4agYxa7VrBlFatlIdNhI17UwTIcl1KgdFz2vMPHAwNLnMXHndrKIL+CIfYZCy
         +LWgMlq9N6K59mFCCNS1JRu/8L/ZTodUFO6vUDYXV/fvzZaV/xUwaTK/pUbIZstQb46g
         DU3ugOTCm67h0hGCqVT7mPvI+Sl6bOyVun0m06x11/Zfvda13iYEaEqeek82evQt5BmV
         R9qbThox7JwuEY0A/8PBJWWmD71RV33Jaes1Mbvle9TBg4yi5CLw5897CY23fm07w4Uq
         Q++g==
X-Forwarded-Encrypted: i=1; AJvYcCVlwp4SD/xtVvEBNTJDB/Xo9fXHLc44fkLYFz/dngk46lK/L/Xf0+FhcHhYIChOJDXpQbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbel5b8BRAJKKbMHgGMob0KfTDf5WrpGCkVwiycOktylvrvhP7
	ripQbnPisVs3CFoHFVLDm7UhZabGOyM5MQbfUyYrwc1tLB3bKLa8KNIS
X-Gm-Gg: AZuq6aI1kOyiylP7upeCCms3Ta4agd7CxV/KPN4ylXmQzeFUEoAPvBPZ5Za/zF8ooK6
	JGk5HoaDQ/4DFLWpdNorxFI5MmjpFJQB1rhg0lxDvLt4X74Rk9wdg/bS1EaaAKjb3m3Cy/6azHM
	l3Uz38Xl+1KauqNDB7inqsxoVFJQ6SArLOMZad5e0zYBX8858VBlmv6MzExaYoduew8j0igNj6o
	baU6bF51GkSqNTvToN9aDwQjsovr7Xa8V+k0aoDZgEFR3hTzOZpAM2cng3UGIwPkgAPYNgqy1p5
	lsq77sYGpu74j7+J5lHhQgqbwfyYfqg9NPKz8jffeIT+W/gNMSyyidSpiXwjTclKOaxzWPvBzNN
	3YVe1Eh+pv2/P5iCGsD3kR9GeUgs7hQBUDdV33wH/nWQj0QyavdBUPsBQ9sH/OkJmPPAQpP6urX
	TpRKKawNSy0S/2N+ktzeEA8kMWzDggWxxI82ZUX/sq1A==
X-Received: by 2002:a05:6000:3110:b0:430:fd0f:2910 with SMTP id ffacd0b85a97d-435dd0841e0mr5537054f8f.26.1769558710319;
        Tue, 27 Jan 2026 16:05:10 -0800 (PST)
Received: from smtpclient.apple ([41.44.69.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1354d43sm2389532f8f.43.2026.01.27.16.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 16:05:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Hassan <hassanmahmoude1986@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: [PATCH v2 1/5] replay: remove dead code and rearrange
Message-Id: <90E952B0-7012-40F1-ADC4-EE3F9C88E518@gmail.com>
Date: Wed, 28 Jan 2026 02:04:58 +0200
Cc: christian.couder@gmail.com, code@khaugsbakk.name, git@vger.kernel.org,
 kristofferhaugsbakk@fastmail.com, newren@gmail.com,
 phillip.wood@dunelm.org.uk, siddharthasthana31@gmail.com
To: gitster@pobox.com
X-Mailer: iPhone Mail (20H365)

=EF=BB=BFVodafone cash=20

Sent from my iPhone
