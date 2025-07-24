Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC9E2D5C97
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363756; cv=none; b=MnK02/aW+Ea/XK3jKye+riDrYU+AbaZ2egdEr92JcWVBVZ/CSmKFBu7wkiwuieP1jCFgnUjXC732OMFgf97W0m+M2nFIXWnJGl/eSAhK+R1X6Trl1JM/82j2FiXwD16xQ/Ly7ozVZWu8MPPtTMWcQdgdWhymK5RJ0trzwNaj9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363756; c=relaxed/simple;
	bh=gE74YBs9lmAr/oovHiCyW1CnmrM0rn3U6HIdWCaXegY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ttedqvd+DsKnpG7b1yxwZYcjRr3YKxrXd88hIOdjEWN6N6g8gW/ScyQRJ8gYdJ0o2coqVegvNvxs2Q3IlbqI/y72qc3t4Gkw323yYxcqMsVaaxJ/q7sf+PEKt5JtR8ISQNWxgiFM1HCcNwiQo1LahRVzpuf8rOCGQzbrFMJHO0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJp5Rax8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJp5Rax8"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4561514c7f0so9905765e9.0
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 06:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753363753; x=1753968553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnXvikVRSZniywRTsAC9fF3KTrBfdAOcZB01E5y5ecY=;
        b=iJp5Rax8+Gv8f38d7LjQs0qUh72CYV7h6f5bybLpZ+26nk57hXnpG6zO1m/g6mi9Nh
         73kEP0XMopsHiWp498j2T4SRKT6BgAjb/68OI8Bq7CK6Jnnh4elicXKUjaRoWVstuLo6
         5jSYEPPx2XK5G86Kyi/8L0Sm6WBfYnftLm0mL+gi/O1JKqFTmwkH1aTa0iVPrZbqmfl3
         0bieAdXIrzMLDXlfwNiE76Is/KHapQa3rpiEFw1IsIlx2yn5S0Y3JDHe9qsIVadvbrl6
         7vU8h9BBJtBav4PSypkIe/CrnLuMbD0/QO0+kdduY5KeouVCZKAgFgFa5MjYfiaeBwtW
         C4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753363753; x=1753968553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnXvikVRSZniywRTsAC9fF3KTrBfdAOcZB01E5y5ecY=;
        b=bNLLSUfiWqkA2QKfilauvkg3WinKq6dVbhnI+cPUerutD2Pqmu4wEIXPWvkU8QmozU
         tR8Beq0QEn/F8fct2eTv6Of/qcc1gYGMkNtcKR+AIuhBlkd7x9Cz0VQxAEPZVFYNtGbK
         4ZI9fj9OAyPmgXZS+JYqc+zJwlFSvJCV36EdZttpBtSzgWe/RJ9q5GyI89UevTNZPDSz
         pz97tSEIQiOhMXwIhuCk9MECH2xpyjb8jAtEvtpX4SXg4j0pmH0zB9siNWIxTQB97yKy
         1OkcpzakM5gxff2V879/W4zgSLScPJpeebThVo3wRPwZI+EdFIa/+WYLmpzLaa4CgwJ2
         7dZg==
X-Gm-Message-State: AOJu0YwyfbrqI8NeDKTjbdhaV22XjcOndMjKGkr5gYwNXl3ILgq3jWnf
	voc6SaivUEwNc7fUkqDjNobWaZEOQq/24Dcfa6ZOKpW1QNsWPTooDd4kjoIri/TK5HXOT+Lw
X-Gm-Gg: ASbGnct+QB8apxsNGrBgflBkpp+k3jFEvQZDWoIqdufTHx3SFWe98PemPF2VQM9K6WU
	5j6REgpSJgObQPOQyH/VMRK7T1E3JMmGG/LxFIlyOeymaiDiP8eqMlWPH6/0urzPj8y3YszSXdb
	hIwa2j0l8ABD5FXuLuE36xvoRfmWi85XsLBIuRCL/15/XEdMdds/kXI5wj8oOnvmYaSNwez1MJc
	0Kj+TvQx0ngAOKRruBB77YF/Myk8gubECj66BBU7B4wDXDUpqFvG/KbC50OR73ZZ3+Z6DjyoZ4B
	WG8a4y/Fo+06LQZgJ9wrLB0iiQPYytHohwKdub4lZf6iFeqOzlS2YcNahExDO8hEeEUnlhz3e9i
	wqovD+OY5vmjYhimo
X-Google-Smtp-Source: AGHT+IH8z3jBAY3q3FvEHxVEV32FpZcU7SwOSB0466eWX1x+0HxcYnuiwQsaI7RvsQm1ttEoMQIN3g==
X-Received: by 2002:a05:600c:529a:b0:456:1dd9:943 with SMTP id 5b1f17b1804b1-45868c7525cmr72034425e9.3.1753363752490;
        Thu, 24 Jul 2025 06:29:12 -0700 (PDT)
Received: from localhost.localdomain ([105.113.77.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad7fdsm2232182f8f.43.2025.07.24.06.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:29:12 -0700 (PDT)
From: Seyi Kufoiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kufoiji <ibed@apolop2p.com>,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v5 0/5] t/unit-tests: convert unit-tests to use clar
Date: Thu, 24 Jul 2025 14:28:08 +0100
Message-ID: <20250724132813.59627-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250605140644.239199-1-kuforiji98@gmail.com>
References: <20250605140644.239199-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seyi Kufoiji <ibed@apolop2p.com>

Hello,

This patch series marks the final batch of our existing unit test files
transitioned to the Clar testing framework. It covers all the
reftable-related test files, and is part of our ongoing effort to
standardize our testing framework to enhance its maintainability.

Changes in v5:
 - some code refactoring and cleanup based on review.

Thanks
Seyi

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>

Seyi Kuforiji (5):
  t/unit-tests: convert reftable table test to use clar
  t/unit-tests: convert reftable readwrite test to use clar
  t/unit-tests: convert reftable record test to use clar
  t/unit-tests: convert reftable stack test to use clar
  t/unit-tests: finalize migration of reftable-related tests

 Makefile                                      |  13 +-
 t/Makefile                                    |   1 -
 t/meson.build                                 |  34 +-
 t/unit-tests/lib-reftable-clar.c              | 101 ---
 t/unit-tests/lib-reftable-clar.h              |  20 -
 t/unit-tests/lib-reftable.c                   |  35 +-
 t/unit-tests/lib-reftable.h                   |  15 +-
 t/unit-tests/u-reftable-basics.c              |   2 +-
 t/unit-tests/u-reftable-block.c               |   2 +-
 t/unit-tests/u-reftable-merged.c              |   2 +-
 t/unit-tests/u-reftable-pq.c                  |   2 +-
 ...ble-readwrite.c => u-reftable-readwrite.c} | 403 ++++-----
 ...-reftable-record.c => u-reftable-record.c} | 250 +++---
 ...{t-reftable-stack.c => u-reftable-stack.c} | 780 ++++++++----------
 ...{t-reftable-table.c => u-reftable-table.c} |  73 +-
 15 files changed, 711 insertions(+), 1022 deletions(-)
 delete mode 100644 t/unit-tests/lib-reftable-clar.c
 delete mode 100644 t/unit-tests/lib-reftable-clar.h
 rename t/unit-tests/{t-reftable-readwrite.c => u-reftable-readwrite.c} (68%)
 rename t/unit-tests/{t-reftable-record.c => u-reftable-record.c} (62%)
 rename t/unit-tests/{t-reftable-stack.c => u-reftable-stack.c} (59%)
 rename t/unit-tests/{t-reftable-table.c => u-reftable-table.c} (75%)

Range-diff against v4:
1:  cf8b0471fd ! 1:  7c159bd2fe t/unit-tests: convert reftable table test to use clar
    @@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
      UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
      UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
      UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
    +@@ Makefile: $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
    + 	$(OBJCOPY) --localize-hidden $^ $@
    + 
    + contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
    +-	$(AR) $(ARFLAGS) $@ $^
    ++	$(AR) $(ARFLAGS) $@ $^
    + \ No newline at end of file
     
      ## t/meson.build ##
     @@ t/meson.build: clar_test_suites = [
2:  cbe70c5c23 = 2:  3ae3b2cf9c t/unit-tests: convert reftable readwrite test to use clar
3:  38e2198eac ! 3:  d4303eb913 t/unit-tests: convert reftable record test to use clar
    @@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
      UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
     
      ## t/meson.build ##
    -@@ t/meson.build: clar_test_suites = [
    -   'unit-tests/u-reftable-merged.c',
    -   'unit-tests/u-reftable-pq.c',
    -   'unit-tests/u-reftable-readwrite.c',
    -+  'unit-tests/u-reftable-record.c',
    -   'unit-tests/u-reftable-table.c',
    -   'unit-tests/u-reftable-tree.c',
    -   'unit-tests/u-strbuf.c',
     @@ t/meson.build: clar_unit_tests = executable('unit-tests',
      test('unit-tests', clar_unit_tests)
      
4:  8de9dbbd3b ! 4:  df582f6e2c t/unit-tests: convert reftable stack test to use clar
    @@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
     
      ## t/meson.build ##
     @@ t/meson.build: clar_test_suites = [
    +   'unit-tests/u-reftable-merged.c',
        'unit-tests/u-reftable-pq.c',
        'unit-tests/u-reftable-readwrite.c',
    -   'unit-tests/u-reftable-record.c',
    ++  'unit-tests/u-reftable-record.c',
     +  'unit-tests/u-reftable-stack.c',
        'unit-tests/u-reftable-table.c',
        'unit-tests/u-reftable-tree.c',
5:  a69c3370ee ! 5:  9340e7ce88 t/unit-tests: finalize migration of reftable-related tests
    @@ Makefile: CLAR_TEST_SUITES += u-urlmatch-normalization
      
      # xdiff and reftable libs may in turn depend on what is in libgit.a
      GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
    +@@ Makefile: $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
    + 	$(OBJCOPY) --localize-hidden $^ $@
    + 
    + contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
    +-	$(AR) $(ARFLAGS) $@ $^
    + \ No newline at end of file
    ++	$(AR) $(ARFLAGS) $@ $^
     
      ## t/Makefile ##
     @@ t/Makefile: check-meson:
-- 
2.43.0

