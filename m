Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2311DE2A6
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024562; cv=none; b=lDPGqE+7XFxyr4/1CjwPyc3H0I7j8CFSjHz6WGUENRJ9JiN+8+3Gud4yGb6Y4LZVzY8XTKa/0yA/3Wd4FzQraXwnYCZA88vlwCVnImjtaMA7RhH14zmwpspLQ/XnWojiW7DItf3DEWsPDN2KyZw5Jz2ABvuRrG9FnqdsPKmMyH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024562; c=relaxed/simple;
	bh=lzF29ot6WeZKDxRhXhkwlChmB1cSYP2InZyQsk086No=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BBUF3iEFNZn15O0V04KTBL1B/lXosYLjqU/7pezW3J8D0pZejKFhR1xJQTqidd143oVVqJ0O4fwVmHyOpofLsLyQWyXuXKWjezD+Sc8kRjhPIIYiIEYjnokba99wq6Qya17x9ZVDla0N8vjQ7OZXIgYwnfqs6gaHX8OeglbMOAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBIHAOqt; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBIHAOqt"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so1366437a12.0
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 02:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737024559; x=1737629359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vxO3xi7jEIzQGPtMeLXz3WlwmrefZ5H2UcWjubriHeI=;
        b=GBIHAOqtDOVYdRqTVRnFwCxo4789xq9kscpzL5t9Y1O4fAYm2Bibm4qE/L7oJenXqe
         bf8SuYJ3CjUoZJcOA8+utkUGDmrrALioq3cx0259nt1KcOS5kDx2TYjrY6llOV/GJkVs
         ItC9pP+Bv50SWNoM+IhILPEw0IFc6ErB0inAAYGDZqTB5dYnJ6UHWnDi6jV0ii1oX1NY
         Ck0CFfusaya9+7nylAJ+viJgrLGXTC3OY2yZG4rKAzPzUBU8kcw1OgbZ9XEiXCLH9vry
         0EKl+T8Q+OmpxFEAfvPykSsiiaz3cfLrSCMFfnd3gSH+Q9uqYp3ZOTe26/QOGoa42yj9
         eDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737024559; x=1737629359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxO3xi7jEIzQGPtMeLXz3WlwmrefZ5H2UcWjubriHeI=;
        b=wrdQ7ce6hc/t4RaQ3SXwV4GUV9S25H5qJ12aWed1Y8jU1UUFTevsXvJ8UgMUcPwrl2
         hgrYZPFtYli1P/I/GKCf7rnvUL2/pwMEyslXcYRylNhrSDdknxUY1f9kSW+iD9kpnU95
         DyckMOnVLjsvG2aUDdCjc8cEBiRy+JdxuSejjD+iMr9GfMoWkZLeAqCTmbE56SRLP07K
         4JAn9oUR3EubshC5cI+ahvtNUE1l76sX4DWR1tA9gIUDUQb14eMY/cWOCDMmfa/I5dRA
         QAiJbsTxQ1pAx4kpaA2DOTIwtUU7gcDt1b2dYMvPCXoLOToSWsS5YH7VSpJbmhEBdaS1
         WjWA==
X-Gm-Message-State: AOJu0YwIRkJJ0K4C3Lcn3pqZfC5A1hZOoKW4ZO+KFyEnTJ+5ouflaT9E
	rWsuP57XCE3O/GWxdYb9hZaLCzKNHU1j7lBog5BAiOgMAPjlcCtnxSPOyI4u/r2sgA==
X-Gm-Gg: ASbGnctvjHoXLleHuqz8QxwN9oBIIMqxJJEelo9egc0bz9mFzrZBv2O9YZdOLd8cKft
	yM7+zCo9jwsgB6KO5JgvPafxJZP18/QYR0g/s+51r/zjZDnj5JnytqhuehdCbHwF3/JMb0bryQK
	iZl6jilHPcAyqmFePcStfXWqSgdaxdPdQcEzbf0f3ubXki0ARo00KLNRo2XAc27n2cvJl36dTLA
	5W1mW1HVWpcnqXQKSjiTuyDUdxdEic9qDURMHs1y7zaoN8Fs10BRIYhtelNMs4oMfe1hg==
X-Google-Smtp-Source: AGHT+IGQkI3YFvAJ1fM6GB98t8O5CKZVRtx9C7dQBqid2iwYGUw5fRbhyKCYvqyBtV9lY6Rot7BZOw==
X-Received: by 2002:a17:907:8689:b0:ab2:c0b9:68d with SMTP id a640c23a62f3a-ab2c0b9084dmr2909747666b.1.1737024558315;
        Thu, 16 Jan 2025 02:49:18 -0800 (PST)
Received: from localhost.localdomain ([154.118.34.84])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c9646be5sm901203966b.174.2025.01.16.02.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 02:49:17 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 0/4] t/unit-tests: convert unit-tests to use clar
Date: Thu, 16 Jan 2025 11:49:07 +0100
Message-ID: <20250116104911.77405-1-kuforiji98@gmail.com>
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
standardize our testing approach and enhance maintainability.

Thanks
Seyi

Mentored-by: Patrick Steinhardt ps@pks.im
Signed-off-by: Seyi Kuforiji kuforiji98@gmail.com

Seyi Kuforiji (4):
  t/unit-tests: handle dashes in test suite filenames
  t/unit-tests: convert mem-pool test to use clar test framework
  t/unit-tests: adapt priority queue test to use clar test framework
  t/unit-tests: convert reftable tree test to use clar test framework

 Makefile                            |  6 +-
 t/meson.build                       |  6 +-
 t/unit-tests/generate-clar-decls.sh |  1 +
 t/unit-tests/t-mem-pool.c           | 31 ----------
 t/unit-tests/t-prio-queue.c         | 91 ----------------------------
 t/unit-tests/t-reftable-tree.c      | 86 --------------------------
 t/unit-tests/u-mem-pool.c           | 26 ++++++++
 t/unit-tests/u-prio-queue.c         | 94 +++++++++++++++++++++++++++++
 t/unit-tests/u-reftable-tree.c      | 78 ++++++++++++++++++++++++
 9 files changed, 205 insertions(+), 214 deletions(-)
 delete mode 100644 t/unit-tests/t-mem-pool.c
 delete mode 100644 t/unit-tests/t-prio-queue.c
 delete mode 100644 t/unit-tests/t-reftable-tree.c
 create mode 100644 t/unit-tests/u-mem-pool.c
 create mode 100644 t/unit-tests/u-prio-queue.c
 create mode 100644 t/unit-tests/u-reftable-tree.c

-- 
2.34.1

