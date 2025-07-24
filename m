Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10382E11C9
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367391; cv=none; b=WDhRvfKfMdg6aKhWvHezcU6G7glg/F37RW6m/WcE5IQBr98CP+vQ14ZLYQYppFf7T5Uws2qbPZzzGZH6STNsxGhR8eus0i7E4mtyCWyvmiJMOxsQNtWVqx9mfpuTVnWSxozJK5ujZ3RYoCUfcC2Q5sviKZFdT0QGa05/crdmM1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367391; c=relaxed/simple;
	bh=biEbPdDpVJIoq7mJY4zxclaog6/ombpS5qkEl9yopeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=En6V5wSw579gmKJqJXWazv1uv3kPS0WBXs7MH19hxX9HJHI1QeXA1cM3fUJYUxlFpYmkQtqbrtzlEJEH/sB86FFSYgcFBio93NvxF7E9vcyDwq95Ug6XTtPxpKCT5MglkH3gtYNAwAmo1oYjI97fgGruzSZIXu1HuPDJIkEiKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWu0FWJ6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWu0FWJ6"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45634205adaso5310405e9.2
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753367388; x=1753972188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKa2i3WUYSg3yTWevXCe/4jDvllqbyLR0qjgE6rHZm4=;
        b=KWu0FWJ6/xa4bw2+xI//IufSW6Xl9ZWZiNV+PTT/Na5LMFfFRtQtwt2cKAwqAtg685
         PCFP/ugWnY7muOcDLjh/AlcQhZQWJr480Nx22PYdHT8abhCrx2emkQEvR/oQ9cKTOlwc
         n4MwFMvw3F90sp7ySWrHx8/7b5kx4K03mg7k2n+C/WLDuEWKtWbia+TCOmgVod3/EkFN
         YTDmSXF9SYKIioymxPXTRnXmW2WlfjQi4NHnd/zd3d2En1NyQR4mu7A59Ck71DZ0dXeU
         igyo6Skmswxl1ykWFXDEua0TG0Y9sUUFiUjU6BOYnJ+nAt8TmDDDsVbQLCnjC2Un/lRG
         7R9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367388; x=1753972188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKa2i3WUYSg3yTWevXCe/4jDvllqbyLR0qjgE6rHZm4=;
        b=BZrSEY3YAH273zyy4E0Yt692YyQBtdP9o6uH5yFI4tGn0HGkpvybAIlmWdO+PR0jQP
         0aS52x4rcQBvz1du9sEnS/8sfuX3fEMXlk/vaFNulgVmLF6GJclawCBidrd6avGuZwn8
         r+vIvVDRi4h7jlTGMO359lljtY/WQyJ73yEjYn5l5ZOB/21vNvjhKEdwSpi6R+SjjxYv
         +mFwef1jTKm2hreRu5qLu7KSAas7kSJ0D+zCZsYSY9asdxGlhkaSjgL/y32Gj2aDpZPd
         b/hK+prHm5CimyKYLLcyG2K/oEtNuUbBFHVjKYJW1URuurxMWSklokCXZVISr1FYI31H
         oHlQ==
X-Gm-Message-State: AOJu0Yz5OEgqNdnz74MtSrC7PsjOhSDyajMpTcB/VG/OJ46ho7Dntbnc
	toLNFOA9BNbZGaE/6IiDFPCoQAUc+8ugEFSOVIrIJLqMh0nqxtfO5h4n9zYDyRzUPhIZuA==
X-Gm-Gg: ASbGncuM6/9+GlQ0l/bTcMdF1bq4JTiYEl5XTiOv8jJDx9ckxod3EvUWnOdeeihqgI7
	f7qCbgjufTlNDJpQ77uD/VH5rkBKWDxz72vfAEf/PPndLkWFTnzvuaQ3wBUstb8eolso+WlQI8R
	SdO4Lpp81BdLncHKi5Bs5PpCD1bWb8K7rASQ+xTlFf8vee0CRDwrG4wnmpKn0JJsLkcvWNFZyBe
	cskUMMW9VT3M61Z+ZETpG3GsrWGGMAFH9XrCYDHLEWNQEO0dvvNaSH+sde3KleM+hVKGscEnJ5+
	GRQvhEGKKTtM8cPHzUZi4ZCnlFfX7GpOyRsWXPZVaFrSj3qdkGT0ezALikPpKCMrGA5l5pI7yiO
	MMoXp5EQmgrPw8Znt
X-Google-Smtp-Source: AGHT+IHxJPrvb6gjzmJBdSvMIky4kOVCnJntBtADxWNmIB13nDxH6ZCcd46fjVdlk5QTxlu+dFMriA==
X-Received: by 2002:a05:600c:1d22:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-45872668487mr4083215e9.30.1753367387613;
        Thu, 24 Jul 2025 07:29:47 -0700 (PDT)
Received: from localhost.localdomain ([105.113.77.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586ec63d29sm22792135e9.1.2025.07.24.07.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:29:47 -0700 (PDT)
From: Seyi Kufoiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kufoiji <kuforiji98@gmail.com>
Subject: [PATCH v5 00/10] t/unit-tests: convert unit-tests to use clar
Date: Thu, 24 Jul 2025 15:28:27 +0100
Message-ID: <20250724142837.67149-1-kuforiji98@gmail.com>
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

Seyi Kuforiji (10):
  t/unit-tests: implement clar specific reftable test helper functions
  t/unit-tests: convert reftable basics test to use clar test framework
  t/unit-tests: convert reftable block test to use clar
  t/unit-tests: convert reftable merged test to use clar
  t/unit-tests: convert reftable pq test to use clar
  t/unit-tests: convert reftable table test to use clar
  t/unit-tests: convert reftable readwrite test to use clar
  t/unit-tests: convert reftable record test to use clar
  t/unit-tests: convert reftable stack test to use clar
  t/unit-tests: finalize migration of reftable-related tests

 Makefile                                      |  20 +-
 t/Makefile                                    |   1 -
 t/meson.build                                 |  42 +-
 t/unit-tests/lib-reftable.c                   |  35 +-
 t/unit-tests/lib-reftable.h                   |  15 +-
 t/unit-tests/t-reftable-basics.c              | 219 -----
 t/unit-tests/u-reftable-basics.c              | 227 +++++
 ...{t-reftable-block.c => u-reftable-block.c} | 164 ++--
 ...-reftable-merged.c => u-reftable-merged.c} | 160 ++--
 .../{t-reftable-pq.c => u-reftable-pq.c}      |  59 +-
 ...ble-readwrite.c => u-reftable-readwrite.c} | 403 ++++-----
 ...-reftable-record.c => u-reftable-record.c} | 250 +++---
 ...{t-reftable-stack.c => u-reftable-stack.c} | 780 ++++++++----------
 ...{t-reftable-table.c => u-reftable-table.c} |  73 +-
 14 files changed, 1117 insertions(+), 1331 deletions(-)
 delete mode 100644 t/unit-tests/t-reftable-basics.c
 create mode 100644 t/unit-tests/u-reftable-basics.c
 rename t/unit-tests/{t-reftable-block.c => u-reftable-block.c} (74%)
 rename t/unit-tests/{t-reftable-merged.c => u-reftable-merged.c} (77%)
 rename t/unit-tests/{t-reftable-pq.c => u-reftable-pq.c} (64%)
 rename t/unit-tests/{t-reftable-readwrite.c => u-reftable-readwrite.c} (68%)
 rename t/unit-tests/{t-reftable-record.c => u-reftable-record.c} (62%)
 rename t/unit-tests/{t-reftable-stack.c => u-reftable-stack.c} (59%)
 rename t/unit-tests/{t-reftable-table.c => u-reftable-table.c} (75%)

Range-diff against v4:
 -:  ---------- >  1:  4a04557ae3 t/unit-tests: implement clar specific reftable test helper functions
 -:  ---------- >  2:  2c576ddd11 t/unit-tests: convert reftable basics test to use clar test framework
 -:  ---------- >  3:  04d54fef89 t/unit-tests: convert reftable block test to use clar
 -:  ---------- >  4:  06eba27f8e t/unit-tests: convert reftable merged test to use clar
 -:  ---------- >  5:  eaa8b8d636 t/unit-tests: convert reftable pq test to use clar
 1:  7c159bd2fe !  6:  cf8b0471fd t/unit-tests: convert reftable table test to use clar
    @@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
      UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
      UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
      UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
    -@@ Makefile: $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
    - 	$(OBJCOPY) --localize-hidden $^ $@
    - 
    - contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
    --	$(AR) $(ARFLAGS) $@ $^
    -+	$(AR) $(ARFLAGS) $@ $^
    - \ No newline at end of file
     
      ## t/meson.build ##
     @@ t/meson.build: clar_test_suites = [
 2:  3ae3b2cf9c =  7:  cbe70c5c23 t/unit-tests: convert reftable readwrite test to use clar
 3:  d4303eb913 !  8:  38e2198eac t/unit-tests: convert reftable record test to use clar
    @@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
      UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
     
      ## t/meson.build ##
    +@@ t/meson.build: clar_test_suites = [
    +   'unit-tests/u-reftable-merged.c',
    +   'unit-tests/u-reftable-pq.c',
    +   'unit-tests/u-reftable-readwrite.c',
    ++  'unit-tests/u-reftable-record.c',
    +   'unit-tests/u-reftable-table.c',
    +   'unit-tests/u-reftable-tree.c',
    +   'unit-tests/u-strbuf.c',
     @@ t/meson.build: clar_unit_tests = executable('unit-tests',
      test('unit-tests', clar_unit_tests)
      
 4:  df582f6e2c !  9:  8de9dbbd3b t/unit-tests: convert reftable stack test to use clar
    @@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
     
      ## t/meson.build ##
     @@ t/meson.build: clar_test_suites = [
    -   'unit-tests/u-reftable-merged.c',
        'unit-tests/u-reftable-pq.c',
        'unit-tests/u-reftable-readwrite.c',
    -+  'unit-tests/u-reftable-record.c',
    +   'unit-tests/u-reftable-record.c',
     +  'unit-tests/u-reftable-stack.c',
        'unit-tests/u-reftable-table.c',
        'unit-tests/u-reftable-tree.c',
 5:  9340e7ce88 ! 10:  a69c3370ee t/unit-tests: finalize migration of reftable-related tests
    @@ Makefile: CLAR_TEST_SUITES += u-urlmatch-normalization
      
      # xdiff and reftable libs may in turn depend on what is in libgit.a
      GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
    -@@ Makefile: $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
    - 	$(OBJCOPY) --localize-hidden $^ $@
    - 
    - contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
    --	$(AR) $(ARFLAGS) $@ $^
    - \ No newline at end of file
    -+	$(AR) $(ARFLAGS) $@ $^
     
      ## t/Makefile ##
     @@ t/Makefile: check-meson:
-- 
2.43.0

