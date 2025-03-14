Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F441EB3E
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961538; cv=none; b=Dztszu19vjQ0ceS8GkL0boGI42i+fsQfwx/+nqLfr/J7YZithdah6/RycG8AfrmxBuDosacFjSF46CFDp++wTYDZpmQpOKfCABGDWSFlSU4lNJRjvaxQFPToIiGvC0rcfwV6MiPiX6pb4Wtr25K4/ZoZEAO347QjrmS/3qAyZqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961538; c=relaxed/simple;
	bh=ew4Mve1x+Xiw9D2nWUzk4RzZzZwdMXypbW228Ik/EDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTxRRVJWhLchKi9DLV5WvlfclrcCBRVyCVn8vhdvJWY0ZdueBzVlbtVS4rxME0ZZiz29vCD6ZYwmV6MacvXARL4ri6EGhChYeYQMb0tgxUmLzgymRdwKBSPTlPR5orZoN4Jf+Qz6mOMlggyyl8JHrwiFozSow/6HgWLKkjEwSsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbWDSGgV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbWDSGgV"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf680d351so20705015e9.0
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 07:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741961533; x=1742566333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1UzlamXE04mZyZKh7O3F/VryXtDBhQqzRx+cvUj4aI=;
        b=HbWDSGgVcXpW1tZcc8zg+JzQ7mJewqHycWc1jMEVOdUB8B74sYRJupxOKfAPIY+Z/d
         /RIZqWKd7SJ2gcwLwyji0MS3XldAJJsHJizxWUdpxBuTF2jD1MfyjQJIDxz0qlPJPBcg
         yASjwGnHjYbt/ReKC8Ykbk5Fy+/59Xx3A1MKjfylMc6LsJXd9mXeGblafMTkbaBUyNyq
         neyRv9tfhSI7767w1LtXO4VyxJ53vWgtBPQPCEA4ieskiB5rWY+m60icOr4bc8I26FXG
         LjUqQhAvLAjAnNzFOsR9Vf3+PW1MnpyZVr5r6qDnlal3WUbAUgMEKjhvBz80359b2lAt
         Fzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741961533; x=1742566333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1UzlamXE04mZyZKh7O3F/VryXtDBhQqzRx+cvUj4aI=;
        b=Dowk8NhiMsfXJ/NQnBLwNAJssQW3cNnbzNmf/Y2qGB6HkOgzNapW+Jqe74WvpmLWFT
         X4fgdaq0YR0185bq7RVkkNDiCbaiOh6KtybD7wiKvp7nZWoFQY6FAppv6rLtFDO6zrWz
         +b9FmIV5rtEIN5N+8Cw7Xbgk4pSCnZATv056szCmQMbu9x5YpKNyxvc/OcI9YveGC+pE
         bB8VlaSuEwdNIzxJs6pWoDQ7ylVH2Vzb1Bll+G4Z/UdjLtRTpqjY41JcChU/RwzIHOV+
         MSAZFHN5tK7LQRyQat1MQmaPiF1c9amfbLFFPncSgStM8rrRbADz7f4jo3nQicCgYt5z
         Ochw==
X-Gm-Message-State: AOJu0YwFFMhP+hCdNkke3EVfPheWplGVhKlTkeTWKQ/e9ra0dYigp2yg
	O94pE4k812eZlQONZrChRh2kMQYfPQxBe0DXN6/4HvDmM3EQ5r5J0oe/pQ==
X-Gm-Gg: ASbGnctxFjKP5u6I6VwRQiW1kn57OXuo15JR0OR+CS7pEz6I8ZpRrF8T2yMyEZgmwWo
	vnbkd9JqZay6KrKl21C1+zpFdITMTYte4H9hSK+yUvCfJ4s/EoVWTgoehZQwDogpy2L71BYKciu
	AlK0THfnu6sd/WMFo1yweChgreI7Wify1JyQM3S6+IVuXZggZcPbOkoEe/LtmyTz2I4lynTQIdy
	U9ird5iU9Qzdg0Uvst7RGZB2KNQmLg6QKQHN0fVgMf37eEEc8+6LRkXyCzZml0xSG40upNOfg7a
	nWq1LdZOAbyu7Btfn/m8BnXwygOJDrvDZRs33gAuxCchoIY8TnXHJOLiV9IO0tsWAyLX8aKMiXa
	cDmewFvr7BmI68S4LL/UlILwGpALq/2LXAeNHbg==
X-Google-Smtp-Source: AGHT+IHrk26ISfeX9h/fpayyopwiDWdX9GUptsR0/z7A91XAtinb1Gcm9xo/OTkGK8GHo/u5Ojiidw==
X-Received: by 2002:a05:600c:4f87:b0:43b:c6a7:ac60 with SMTP id 5b1f17b1804b1-43d1f235e45mr34107605e9.10.1741961533438;
        Fri, 14 Mar 2025 07:12:13 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe3a8cdsm8418255e9.2.2025.03.14.07.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:12:12 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 0/3] "promisor-remote" capability fixes
Date: Fri, 14 Mar 2025 15:12:00 +0100
Message-ID: <20250314141203.2548803-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2.36.ga8a9f9b33b
In-Reply-To: <20250313103859.817127-1-christian.couder@gmail.com>
References: <20250313103859.817127-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a number of different issues and fixes were found and discussed in
the previous iterations, I thought it made sense to split the patch
into a small 3 patch series.

There are a lot of changes again compared to the previous version, so
I don't think it makes sense to provide a range-diff.

Christian Couder (3):
  promisor-remote: fix segfault when remote URL is missing
  promisor-remote: fix possible issue when no URL is advertised
  promisor-remote: compare remote names case sensitively

 Documentation/config/promisor.adoc    |  4 +-
 promisor-remote.c                     | 27 +++++++-----
 t/t5710-promisor-remote-capability.sh | 59 +++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 13 deletions(-)

-- 
2.49.0.rc2.1.gf94452eaa2

