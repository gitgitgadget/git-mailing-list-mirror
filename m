Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A5453804
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040214; cv=none; b=ersS6A49ZuDxyb7kAba0TzsgUh4dLpSjjRucgzF0qM4Mef7lb2LGcUgQmpKb+/KFdQbRxefTOQNvhZgTYZtxx3Dwl+U6shJJ+XZLZJjaXK9Px4hEGzN7cstGitklnKli5NNgbtsTd+FJ0DnzdZEbOyuBQ0wiXSnNnRpy07OicBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040214; c=relaxed/simple;
	bh=M3oUvKSLE09m9CPVzxXGFuaNc/FHmWL6NKTHUHY+H4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SFrI9DyLaEjKhQ5/jwRtPmW6ljdPjcKO+YPOhqnHIP3cJTvSs5YP+GJ20Q0rmbhkedpgeUt3RGE2jeB7yKVslmvBln3shOU9O1ySyuqBI049umsBzeVr09tvocp0K7YEZA29wYeafAMkM1zN6eJJdYVbjYCBswIH980dDlHRHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCSgvccx; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCSgvccx"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7a1843b4cdbso1442783a12.2
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 07:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723040212; x=1723645012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V7G2QAQaZjgn5FQdYKQt0sIr0FXJU02IE9kA4NAXbLg=;
        b=jCSgvccxsnXa7+P164KFd3hKpyqsJ6nXGQmTQT+W39S5qnFBWhbs+YbJX0ojRja3VH
         D+0qDrYYrh+SGS/r8/R7xnoiC5CMR1S/yV48ptTIU19Y0MC4NoBdAESfIjC1apYtes/K
         uspwsB7NwJqa0FgXXPAwraE6S3YX062ZlVm3uU2+EGqBfL/vDZgyXe+nSj7AL94rHVNL
         JdxeY/8ww+6TlMgCapIJA6ZukaAKyC9ew/SXt6vSL0mXE2pHNQvbh0rR5tuTOevTTmdg
         QX5FrNkRzM3yUr9t5XaMCzozPFhc0Y8g107axx+cmCX7h+6DrpXsWR3GJ+OhdsX7hg1D
         0mYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723040212; x=1723645012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7G2QAQaZjgn5FQdYKQt0sIr0FXJU02IE9kA4NAXbLg=;
        b=CTJvk9FhFX9hB4thof9x6yofsSZjbCE17KBLogrGODJHQ/ARponlLrLganMHm7xxBx
         g+KAQODxE2wx5Ay554mFZNfBEj3CkLxz4rjampfWi8k5heU6mSnoCDNX8BI6Mw5hZWy5
         /R5jqenFuijsMn4P47XjLMeAruddGEY9FTmJkFq3NYiPmv9eepMgPlQexekEbyFjHG5S
         E5jpvDYBDC/za2eyefpgzRpEyNC7Hyv/EGB52Oq98Gh0kFLUUuHtzvcyiQ9kO2iRLkk7
         UUAzxrPLenfhdvuzl5pcXnlEyhWz2/0LLTLjv6uRJ65qWRhYYBS/SdQ0aQSTX65gRwq0
         9MuA==
X-Gm-Message-State: AOJu0YxuOwTogarAU0Lbgj5s7bRyC694DEW00g2CFbpBmoM+Xb9o1T2S
	il6q3T3nX3J6Ygre0hcKef5nX5XAo2/552CxJles9AGohm5GLemdSa0o6SGw
X-Google-Smtp-Source: AGHT+IHgqn4po91f8PEOlvmTqrMRCl5x1h6MTOSGENM3apEOffxs6kIf+fmx3bhADb/QiaSMcm2Ekw==
X-Received: by 2002:a17:90a:7c08:b0:2c9:7e9c:9637 with SMTP id 98e67ed59e1d1-2cff940e45emr19104633a91.13.1723040211823;
        Wed, 07 Aug 2024 07:16:51 -0700 (PDT)
Received: from Ubuntu.. ([106.205.252.196])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d1b374b3cesm1635059a91.48.2024.08.07.07.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:16:51 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH 0/5] t: port reftable/readwrite_test.c to the unit testing framework
Date: Wed,  7 Aug 2024 19:41:56 +0530
Message-ID: <20240807141608.4524-1-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reftable library comes with self tests, which are exercised
as part of the usual end-to-end tests and are designed to
observe the end-user visible effects of Git commands. What it
exercises, however, is a better match for the unit-testing
framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
2023-12-09), which is designed to observe how low level
implementation details, at the level of sequences of individual
function calls, behave.

Hence, port reftable/readwrite_test.c to the unit testing framework
and improve upon the ported test. The first patch in the series moves
the test to the unit testing framework, and the rest of the patches
improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
CI/PR: https://github.com/gitgitgadget/git/pull/1770

Chandra Pratap(5):
t: move reftable/readwrite_test.c to the unit testing framework
t-reftable-readwrite: use free_names() instead of a for loop
t-reftable-readwrite: use 'for' in place of infinite 'while' loops
t-reftable-readwrite: add test for known error
t-reftable-readwrite: add tests for print functions

Makefile                                                         |   2 +-
reftable/reftable-tests.h                                        |   1 -
t/helper/test-reftable.c                                         |   1 -
reftable/readwrite_test.c => t/unit-tests/t-reftable-readwrite.c | 517 +++++++++++++++++++++++-----------------
4 files changed, 294 insertions(+), 227 deletions(-)
