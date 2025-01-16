Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB7E5674D
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044172; cv=none; b=OScxQEPQwexuaz43ndwbc3sbigUXodQN6ttS/UI1Dn5MNhDsyX2RoZ7qm4w33DvbidCsN8laDGhqy2SN21/VhEePnYF2ZasVJ/n4I7wiZIJBesMfIrxkrR8wfkQrTyGvHg9k0B4pg4osvVwaqQYsdSKyIuSou8Dn8tBCh0B5gBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044172; c=relaxed/simple;
	bh=/iunXSVGnxmH0V+R7iulsBx/R0Em1lw1nm59F7ZiivU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFi3eZSLg/2n5zFCxhtGfPjeXie1j4PabYs4vbAQn+BpU64SjZ53cMV+CXaw5ubXANLjy3W5YiJSP/4t7a0zueUcCwiv0cTiOxxUk4hVynEnW5N2M+KmXu2IjzjcSA4Et0YFy1Y/DfBi/m+Pct6UMq3OSB9nVAt3hlvDDg5LHcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVy9bY+D; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVy9bY+D"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43622267b2eso10749205e9.0
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 08:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737044169; x=1737648969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w34p5UoztGcyRyk7C7J+oIEkgVXMhMaFN5sKZ50czfg=;
        b=nVy9bY+DkE4NLcnByjovw9o0UDlbYHL7RJMYr1GJmyZ2+V89SRRjuZ3H8SS4qAPS1h
         nI6pBPxAtb+WSXOxnVswYGsfVbgFFjxMbUwXiHLdKF4pb7f9p8Fkyd7ilThqXulalFBn
         vMudwMf/RyjkXfdOCIIzFoa5LBbiawF78kgtCUC6Exwk39SAwnyZXaAGoVLW4UMdvv0K
         Cux4CHU2JX6z8J+/YCHJCYsfZsnHC0qLSUD4ZVyZvGU/fWnRh5jrcQdOekm3BsnyBi59
         cSWZvtc6OGChDX/lJ9YRUtoWnoVPREuyHgZ46iqwHh5qsGi/dj7jlFZw7+QX348xX7e6
         bWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737044169; x=1737648969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w34p5UoztGcyRyk7C7J+oIEkgVXMhMaFN5sKZ50czfg=;
        b=OMSuUBKmieK073pDRnho5i1DsTS2GEQZwm6CXfZfJHuzty2QaQAXBqb0K5/VYMvyrr
         TLfg6Xs+Roz07nnYJ0DwGqEu/olg+wPMZsvUhMCKF3hr5O3dDEJ+4jK0hjndTktdd/q4
         LnLtU1AItYnMDLuvmILrdAXsrZkJQ0/uq0fUhGySVdu8vzvMRdED4DSk6DxiFXtY/SLj
         YdArtZLa8PZs7kawAMnD9Mds0Q/bOrHzMHzYNgeLoxNLPrxmS2odRr9d7rZX69YddAGI
         LEj7NAwCdVaHvaaRoZjBKihqHf1xfDD6alMq/xayhjZUxNqWT0MTxXNPChnE0Jitzaut
         zECg==
X-Gm-Message-State: AOJu0YzyTZ/+nc1o8/BURqb7wVag2AomWHzj59YNpN+LnDwavu99fCdB
	qng0iOAZ4u/RCprxAgIj5yf6BsVLECR1W4ZrTrhKxVTdA14kexdN+YA3HSXI0exr0A==
X-Gm-Gg: ASbGncsfzXWjTWqKsUlpaNyE2khNwgFtYO4HuyrRwB41xIYc/4S8tBmIC2iN9NDhP3l
	y27GraLcgFS7+WRyOt8XIrFPemgzkTOsPqb4/1e9V2kVyrfPcwFg2DHSoZIZoSg1k7Q0my8q3OG
	LVjxn/zsf8qJHfAi6QozZcWsvqGCiz80vIwgAcgQ2cUvrhgJWid42/mH4tcVGioJQ/gXGDwFHRP
	mCU43PHuPUeTeQ8hlCeMbKDs53/UdnQ1SXxBvPae6NuKa9YrUMtHD15PP5X28oXzWsjwg==
X-Google-Smtp-Source: AGHT+IGUbrWwXyBr04aMSbpKlQ9AkVbkCFhL3SNYwp8wZzKHCMBt2jbbNb5ywxKfy0Zag2rVepn/Dw==
X-Received: by 2002:a05:600c:1d03:b0:434:a0bf:98ea with SMTP id 5b1f17b1804b1-436e2699e91mr306834785e9.9.1737044168710;
        Thu, 16 Jan 2025 08:16:08 -0800 (PST)
Received: from localhost.localdomain ([154.118.34.84])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-437c752935csm63177025e9.26.2025.01.16.08.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 08:16:08 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 0/4] t/unit-tests: convert unit-tests to use clar
Date: Thu, 16 Jan 2025 17:15:55 +0100
Message-ID: <20250116161559.91038-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250116104911.77405-1-kuforiji98@gmail.com>
References: <20250116104911.77405-1-kuforiji98@gmail.com>
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

changes in v2:
- Some small fixes were made to the commit messages
- changes was made to the code format


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
 t/unit-tests/u-mem-pool.c           | 25 ++++++++
 t/unit-tests/u-prio-queue.c         | 94 +++++++++++++++++++++++++++++
 t/unit-tests/u-reftable-tree.c      | 78 ++++++++++++++++++++++++
 9 files changed, 204 insertions(+), 214 deletions(-)
 delete mode 100644 t/unit-tests/t-mem-pool.c
 delete mode 100644 t/unit-tests/t-prio-queue.c
 delete mode 100644 t/unit-tests/t-reftable-tree.c
 create mode 100644 t/unit-tests/u-mem-pool.c
 create mode 100644 t/unit-tests/u-prio-queue.c
 create mode 100644 t/unit-tests/u-reftable-tree.c

Range-diff against v1:
1:  00bb4d2880 = 1:  00bb4d2880 t/unit-tests: handle dashes in test suite filenames
2:  59abf45f08 = 2:  59abf45f08 t/unit-tests: convert mem-pool test to use clar test framework
3:  6e01da141d = 3:  6e01da141d t/unit-tests: adapt priority queue test to use clar test framework
4:  b397a5f131 = 4:  b397a5f131 t/unit-tests: convert reftable tree test to use clar test framework
-- 
2.34.1

