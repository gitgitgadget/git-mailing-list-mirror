Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD61AC43D
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637529; cv=none; b=XGPBgZqUmXh8U89ZmSlfiwnCWmsRM+/3kceQGGknOJCHgLgUBYXbh/suP8sp5kJrHx8hQvBRRZT/xREphdKhC6yA8FDPY7zO8iv0ohWxk6bT1XqcHQseiY8a5C9NJohudU6emWUpZ0rd/XWIc8g+KuqsHEUfxFpfTvzLd1StGPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637529; c=relaxed/simple;
	bh=A9phwIWSe9mvMv4KYYGB4S16eknxlcWdfyMn7KNJwQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5OrUs1lxam2+/a5c75MSAvilVznmHqMOdKTipnVqeN3RUkjvXvSVyMTRQyxu6lSRMGY5il9Er2S6ozNUDQ5CvWhVPQDpteFboDtVRCO1iZiExmYqp6wWkLSSGed4ViyPT1UMIGE6pQ6lpaerTSOhdslZzFrOLTYn7MR01ZVtfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwrhwB2D; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwrhwB2D"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a1c7857a49so3856218a12.1
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 05:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723637526; x=1724242326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VgagUqpKHu05UBmd2HdVR1pvWAioKloKzYETSo+7iYU=;
        b=iwrhwB2DZcCd1WytkQlbYYcrNT6iIC+wtG2l5NNx7pjDe/d5eNdOdv40Wi7oOyUhpB
         4utLH+jcJqaEFQvSf3/BLQ4KcrOy+7qtcGQdZa0KFRi4j8l0MeA/SQG3gCLUpDf3tm/u
         hFF32HVce+zuoeKKMoPlbZ+FPh9hvZczNWMMcCrItnWstqFuOStTzpm3ZbcMwz88MmvW
         Ap8qGLKZO5a+ZDHjE8w5vSL45dFxdRSuhWnY2nKq+MtN8HOAARrLR+gfTl37AZMiX+3d
         E7lr0pcMYG4wuh9uqTgt8oUtFAWI7F1lJBCpwQWl7HMPkULGCOUTUj5jH99T72Y6foWh
         r8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637526; x=1724242326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgagUqpKHu05UBmd2HdVR1pvWAioKloKzYETSo+7iYU=;
        b=ATeRgM2K+tdXXBMm4MOeNjMjcDIGLo/Lw3H66a7xpt+dUtUpma4Db+OUrm6Lltj8oR
         oGf/IcTyn0lTiJfsC2QbudyNU2mz/EtpT+Ic04cWeh0XZiWEIDRga9hVsPdido/chwDf
         5E/TPsHrVZOIRKFKeEowfiIklm3c/YaJOBYrO1jiI24GgRQRdJt8srW7HDFMqPEaY4dA
         kQProuHN6LkSP43sn8Mz7bchtrczCSILfgWVz/S/reBrnmwCdfm24e/QPreSbkRRuWok
         Rvqcn8YeR8DU8gREfWE9jla9u6oET6VAIDoLI/DFY3IfTRjIdGcDaqQ4cKEzjVsOf9kq
         V45Q==
X-Gm-Message-State: AOJu0YzFmKDdM/5cG8Uh7jbGJC2J4XGRHUoDCbnvxc+vo3Cri46A/215
	QN0DEhF/sPDf+nz6fYsbmUyltJFlIwjLQ0guyiI3pa9AHIEAFtusN7259XgC5U8=
X-Google-Smtp-Source: AGHT+IHeIktFftXaqtSGZC5fn00Cpe9rZvfzoc801PDLEbDEuJEP418xPxqXZPI+QIu6gp8/P5myXw==
X-Received: by 2002:a05:6a20:c703:b0:1c4:d4b2:ffe6 with SMTP id adf61e73a8af0-1c8eae85f93mr3370358637.19.1723637525873;
        Wed, 14 Aug 2024 05:12:05 -0700 (PDT)
Received: from Ubuntu.. ([106.205.236.194])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e5875200sm7195450b3a.37.2024.08.14.05.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:12:05 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [GSoC][PATCH 00/10] t: port reftable/block_test.c to the unit testing framework
Date: Wed, 14 Aug 2024 17:33:08 +0530
Message-ID: <20240814121122.4642-1-chandrapratap3519@gmail.com>
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

Hence, port reftable/block_test.c to the unit testing framework and
improve upon the ported test. The first patch in the series moves
the test to the unit testing framework, and the rest of the patches
improve upon the ported test.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

---
CI/PR: https://github.com/gitgitgadget/git/pull/1749

Chandra Pratap(10):
t: move reftable/block_test.c to the unit testing framework
t-reftable-block: release used block reader
t-reftable-block: use reftable_record_equal() instead of check_str()
t-reftable-block: use reftable_record_key() instead of strbuf_addstr()
t-reftable-block: use block_iter_reset() instead of block_iter_close()
t-reftable-block: use xstrfmt() instead of xstrdup()
t-reftable-block: remove unnecessary variable 'j'
t-reftable-block: add tests for log blocks
t-reftable-block: add tests for obj blocks
t-reftable-block: add tests for index blocks

Makefile                        |   2 +-
reftable/block_test.c           | 123 --------------
reftable/reftable-tests.h       |   1 -
t/helper/test-reftable.c        |   1 -
t/unit-tests/t-reftable-block.c | 359 ++++++++++++++++++++++++++++++++++++++++
5 files changed, 360 insertions(+), 126 deletions(-)
