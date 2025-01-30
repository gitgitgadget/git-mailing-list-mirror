Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BFF1B4134
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738228428; cv=none; b=u/U4g7W3m7uJy+WW4O564MEeGXeo8+36rrDtFZIw4pOOKlk7c3OvD5G/WOy40S1eFVF7PX63D/hTMcd2WBjPkjnOyCN3KeKGYVbwCRdOChyaYdep5oIYypTVfradc6baxsvn8TjxdnGWTNDt7asMR0fvn348cbTdIZc4zC8/lYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738228428; c=relaxed/simple;
	bh=DHvvggC5UbwwD1yodOGB984kfW1wBg2UIiLLXHmLfsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rGyPd3B1E1JmXGmVx0nhERjwkkPJxssRLdYmeU9PykNeOZ6ntkaLJ7bbDWB/b3iJl3YES5dHoS3zuUZM1IXrGmbsC10kkpnXDIn4QngpF/mpMUQeZ4SwgVmnAcBYRsvKPs7UX3FFUaqVDWWRz6JtFXsk6MpJaTLuRxbiR6B5gSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEBRr5B1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEBRr5B1"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso968169a12.1
        for <git@vger.kernel.org>; Thu, 30 Jan 2025 01:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738228424; x=1738833224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wifvo9QCeW5catIdAVrgVIaHxY7aSAG2w5XgI1KaSgU=;
        b=dEBRr5B1x94AEh4qdrYV3Z5zpRBZT7HenENpha+JW677GaRi4KiCEx+q6IRUTf3HC0
         kz/2iMAmRtw4DuosX8M1BvyoSHXIdtBks4lxudTOk2tyEjzCDTfj9eVJ82eGg8qcWmnz
         lbz4pr20ev2UxviLTLVNP+fbvFmQmmSIFTxiFk4M2KoDl6In6UfhsiVCR25z7euJVlNR
         GYpqa8xK0EIB8Yabo+Rw9cpcRSwq5LZD+MDtz/bfouMHS3uqUk5wX+TIsP++GPvUpKYb
         kAYfw2P2Ym7ei59h9GlEZB8nFoPOwcCCY02ikP+y1aPUBC5B/EoJdOxihVSGaIXhKfVY
         6n5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738228424; x=1738833224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wifvo9QCeW5catIdAVrgVIaHxY7aSAG2w5XgI1KaSgU=;
        b=GwgCNYcMrqTKVCA3ZS9edSPmWw1T9tvg2+U2kM8AZ4fZw2dJi8D335gW/zsTF75RUz
         S8NySYysDwNKp9aLY/cP3c4pH2DS6kANPmGKVuDspcpy/ZkLLcmQzS/drEtg3qfK5yUA
         1q0fqpP2XrEoMwYt+FdVp4kYTHaEbSqzQHyt462ieareac151rdTuOidkH0Mux8Bp4Zn
         OCivEXZRtM3l7THaoU+jqTM7SQ0XEwga4gLdVolQ0Wyl9bg3rmpZfUqhmUp862PC/Wir
         vwkhShMwRsX35wRYUPlv+AjxaFjk7OGturvJcRWnLhw2In6+BZaanItUaaKGciWk5143
         xYSg==
X-Gm-Message-State: AOJu0YyBtyZA7WSucsvKuVah4qmpQMxgrATX3hoQvpP//xyiJ4Smlhh8
	+w+W1FiN0tgPhwiFJBWNzyJVafyKFe5jHA2oOVjiq+uq7jRXQpZmPISxrKZuQz0Dyg==
X-Gm-Gg: ASbGncsRKy3O2KJscYeRK0u8spsSGZdDRgsDKeDuHoUFH8fMipGKqF9m3Sy74aPxmll
	gqOKz2DoMzZ56YoYt6ryJWgqfPaeihDL7LSWOo29dOFF092erHzNz+AmgacelZ+RXvwV+C93PLs
	8sbedPRICOiiqpGZ3nRUU8CaV+GFJGJxQ7/QOZSN6mut/KCofvj6+3biHBL+ySE9CJ/bXIcRpfI
	4RRNt0BruZ7FxaKNcRHoRPo7FT//1o/sHTbayYcbRZKuaN1HAjXc57f5HUd4kBmbNLh1XGc1I5N
	5uG0sA0XR9NwdQHDILeIg5KwxLIsWg==
X-Google-Smtp-Source: AGHT+IEcJbfEINs547tOQlu/cFkhGSz0OqbfQ3ET/8Ah30TjvKTcZZKfcVVLesCQjrJtSlp1D2Edmw==
X-Received: by 2002:a05:6402:3508:b0:5dc:5d1b:810b with SMTP id 4fb4d7f45d1cf-5dc6f5b249bmr2300943a12.6.1738228424279;
        Thu, 30 Jan 2025 01:13:44 -0800 (PST)
Received: from localhost.localdomain ([154.120.90.178])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5dc723e9ee4sm742249a12.25.2025.01.30.01.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 01:13:43 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 0/4] t/unit-tests: convert unit-tests to use clar
Date: Thu, 30 Jan 2025 10:13:30 +0100
Message-ID: <20250130091334.39922-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This small patch series transitions the existing unit test files to the
Clar testing framework. This change is part of our ongoing effort to
standardize our testing framework to enhance maintainability.

Thanks
Seyi

Mentored-by: Patrick Steinhardt ps@pks.im
Signed-off-by: Seyi Kuforiji kuforiji98@gmail.com
Seyi Kuforiji (4):
  t/unit-tests: convert hashmap test to use clar test framework
  t/unit-tests: adapt example decorate test to use clar test framework
  t/unit-tests: convert strbuf test to use clar test framework
  t/unit-tests: convert strcmp-offset test to use clar test framework

 Makefile                                  |   8 +-
 t/meson.build                             |   8 +-
 t/unit-tests/t-example-decorate.c         |  74 -------
 t/unit-tests/t-strbuf.c                   | 122 ------------
 t/unit-tests/t-strcmp-offset.c            |  35 ----
 t/unit-tests/u-example-decorate.c         |  76 ++++++++
 t/unit-tests/{t-hashmap.c => u-hashmap.c} | 226 +++++++++++-----------
 t/unit-tests/u-strbuf.c                   | 121 ++++++++++++
 t/unit-tests/u-strcmp-offset.c            |  45 +++++
 9 files changed, 362 insertions(+), 353 deletions(-)
 delete mode 100644 t/unit-tests/t-example-decorate.c
 delete mode 100644 t/unit-tests/t-strbuf.c
 delete mode 100644 t/unit-tests/t-strcmp-offset.c
 create mode 100644 t/unit-tests/u-example-decorate.c
 rename t/unit-tests/{t-hashmap.c => u-hashmap.c} (60%)
 create mode 100644 t/unit-tests/u-strbuf.c
 create mode 100644 t/unit-tests/u-strcmp-offset.c

-- 
2.47.0.86.g15030f9556

