Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A6E8F70
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 05:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710481657; cv=none; b=ENLO9sjUAJkmfPPk5JWgdJz2THR4GIJJzzkXoVkamHhOpQpSbrCeXAFgcT00f4OQ8CYvbI1RI5NaliUIlmDjNrgsS9VqUXWQxeoPPPs4mpNgvM7DJ7fwo9vtw6LNH+PyjkMEr6SSGQpkjyOUIRKKSiWWyOPv/dKDDwtWJBFrLBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710481657; c=relaxed/simple;
	bh=rzl4L+vzwFk3DyfkdxRuGxDiLb8w0JKIoE5taz2vLF8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FiLxzBdqS8pMM6l0U/aTGihqqEuZ3v26/pHI6zHxVsrZC3+iAw1A0zSUGTEtAnjxUFziHCQ9TfRGfANPL7hOGsxlUd63AOIHlzSex+Et45ndw3ZySSdFKUqlAo7U15NCQWFO9kGgYPI0wwiKOQxsbQvUGRgCOfMMqme2zsDBVd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy1tSBvJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy1tSBvJ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33e99b62e01so1422156f8f.0
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 22:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710481653; x=1711086453; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJvOmPxBfU+2HvE9gu+Jesm/xE+xWMk+65pSLCyw1W0=;
        b=Oy1tSBvJolQ/mXP9WHUbvOlSkcnvcC+4XCFQesHDpQsOjz0Rhx5ZVQpfN0c7p0l21v
         sKsu03pxLexxYAtuXoM+MdwYvmDfV33b2ScYTy1niRKSqcPnySWvQQW4rPJrLsOHYdq7
         3+O1Hsjv47rpfUdVFV3aL6tB9NgKDoLm3ZOsT15U4gulsA4/H24gb2Pyo7FORBzKONE0
         r60wxFpDNgdaV8cszg1C4aXdCMdGMA/6Uafl+vfJMDRAYWOP3ffqI5r4ChHoj80m5oTF
         h0OXbpvKzVT595Jf+1BqJjtV1sI9qqCiHPtCmzo5JUxwLXRoxd5m9fKH3m3XU1BMbRiQ
         oU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710481653; x=1711086453;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJvOmPxBfU+2HvE9gu+Jesm/xE+xWMk+65pSLCyw1W0=;
        b=trvKdb7Gs/Li1v2O1pNIUAWr0nZGu2QFiveBVG+GFkzP/WH86aZzNy+jgN3IryAKVg
         kixCsdtP2RZt48EU/RJGkG0rJbkOmGXn4xTgYaOtlP9m5YIHDp+pqsKzp6zF54IC6i1l
         VakBfjUQb6DXRhQ47ydIRgBALleMiXnQvekRXGElYBzRGkPEDwP1JIA8t8o+9Ghv59z5
         /zAASLMAW+m2U6MGwOftol/1Z2RQASabXquONUehRNfytinWyX7sCEq9tt2O1F0wOqzK
         5og1x751pHX6Wfy9IEQ66OHXAADm9v5xGLlL5rfM7lOcB0eQWJK3mnfrLepKPob+mCTX
         yLpQ==
X-Gm-Message-State: AOJu0YxY+PpeRYB0RfOD8BPgk7zHIrGuSUiw/iMK7Kakij6rtuDfx4Ra
	sW5j5gTqHDoznz0cqekPyjNphDvJGY7P+MIHTjN/ageZUyRU/vjzGgFAbT4l
X-Google-Smtp-Source: AGHT+IFTbawJ9PtWJR4yUMYzoNsllhxM9WbE1SvkKnrOaNB64efFSbYsEWzAW85TEqi9A7gm/sNOpw==
X-Received: by 2002:a05:6000:1e83:b0:33d:44d8:eacc with SMTP id dd3-20020a0560001e8300b0033d44d8eaccmr2480785wrb.39.1710481653328;
        Thu, 14 Mar 2024 22:47:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10-20020adffe4a000000b0033de10c9efcsm2279953wrs.114.2024.03.14.22.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 22:47:32 -0700 (PDT)
Message-ID: <pull.1692.v2.git.1710481652130.gitgitgadget@gmail.com>
In-Reply-To: <pull.1692.git.1710398478718.gitgitgadget@gmail.com>
References: <pull.1692.git.1710398478718.gitgitgadget@gmail.com>
From: "Brian Tracy via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Mar 2024 05:47:31 +0000
Subject: [PATCH v2] fuzz: add fuzzer for config parsing
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Josh Steadmon <steadmon@google.com>,
    Arthur Chan <arthur.chan@adalogics.com>,
    Brian Tracy <brian.tracy33@gmail.com>,
    Brian C Tracy <brian.tracy33@gmail.com>

From: Brian C Tracy <brian.tracy33@gmail.com>

Add a new fuzz target that exercises the parsing of git configs.
The existing git_config_from_mem function is a perfect entry point
for fuzzing as it exercises the same code paths as the rest of the
config parsing functions and offers an easily fuzzable interface.

Config parsing is a useful thing to fuzz because it operates on user
controlled data and is a central component of many git operations.

Signed-off-by: Brian C Tracy <brian.tracy33@gmail.com>
---
    fuzz: add fuzzer for config parsing

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1692%2Fbriantracy%2Fconfig-fuzzer-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1692/briantracy/config-fuzzer-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1692

Range-diff vs v1:

 1:  a43a2e3a07c ! 1:  be6aa5efb1c fuzz: add fuzzer for config parsing
     @@ Commit message
          Signed-off-by: Brian C Tracy <brian.tracy33@gmail.com>
      
       ## Makefile ##
     -@@ Makefile: FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
     +@@ Makefile: ETAGS_TARGET = TAGS
     + # runs in the future.
     + FUZZ_OBJS += oss-fuzz/dummy-cmd-main.o
     + FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
     ++FUZZ_OBJS += oss-fuzz/fuzz-config.o
       FUZZ_OBJS += oss-fuzz/fuzz-date.o
       FUZZ_OBJS += oss-fuzz/fuzz-pack-headers.o
       FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
     -+FUZZ_OBJS += oss-fuzz/fuzz-config.o
     - .PHONY: fuzz-objs
     - fuzz-objs: $(FUZZ_OBJS)
     - 
      
       ## ci/run-build-and-minimal-fuzzers.sh ##
      @@ ci/run-build-and-minimal-fuzzers.sh: group "Build fuzzers" make \
     @@ ci/run-build-and-minimal-fuzzers.sh: group "Build fuzzers" make \
       	fuzz-all
       
      -for fuzzer in commit-graph date pack-headers pack-idx ; do
     -+for fuzzer in commit-graph date pack-headers pack-idx config ; do
     ++for fuzzer in commit-graph config date pack-headers pack-idx ; do
       	begin_group "fuzz-$fuzzer"
       	./oss-fuzz/fuzz-$fuzzer -verbosity=0 -runs=1 || exit 1
       	end_group "fuzz-$fuzzer"
      
       ## oss-fuzz/.gitignore ##
     -@@ oss-fuzz/.gitignore: fuzz-commit-graph
     +@@
     + fuzz-commit-graph
     ++fuzz-config
       fuzz-date
       fuzz-pack-headers
       fuzz-pack-idx
     -+fuzz-config
      
       ## oss-fuzz/fuzz-config.c (new) ##
      @@
      +#include "git-compat-util.h"
      +#include "config.h"
      +
     -+#include <stdio.h>
     -+#include <string.h>
     -+
      +int LLVMFuzzerTestOneInput(const uint8_t *, size_t);
      +static int config_parser_callback(const char *, const char *,
      +					const struct config_context *, void *);
     @@ oss-fuzz/fuzz-config.c (new)
      +					const struct config_context *ctx UNUSED,
      +					void *data UNUSED)
      +{
     -+	/* Visit every byte of memory we are given to make sure the parser
     -+	 * gave it to us appropriately. Ensure a return of 0 to indicate
     -+	 * success so the parsing continues. */
     -+	int c = strlen(key);
     ++	/*
     ++	 * Visit every byte of memory we are given to make sure the parser
     ++	 * gave it to us appropriately. We need to unconditionally return 0,
     ++	 * but we also want to prevent the strlen from being optimized away.
     ++	 */
     ++	size_t c = strlen(key);
     ++
      +	if (value)
      +		c += strlen(value);
     -+	return c < 0;
     ++	return c == SIZE_MAX;
      +}
      +
      +int LLVMFuzzerTestOneInput(const uint8_t *data, const size_t size)
      +{
      +	struct config_options config_opts = { 0 };
     ++
      +	config_opts.error_action = CONFIG_ERROR_SILENT;
      +	git_config_from_mem(config_parser_callback, CONFIG_ORIGIN_BLOB,
      +				"fuzztest-config", (const char *)data, size, NULL,


 Makefile                            |  1 +
 ci/run-build-and-minimal-fuzzers.sh |  2 +-
 oss-fuzz/.gitignore                 |  1 +
 oss-fuzz/fuzz-config.c              | 33 +++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 oss-fuzz/fuzz-config.c

diff --git a/Makefile b/Makefile
index 4e255c81f22..af32028b18f 100644
--- a/Makefile
+++ b/Makefile
@@ -757,6 +757,7 @@ ETAGS_TARGET = TAGS
 # runs in the future.
 FUZZ_OBJS += oss-fuzz/dummy-cmd-main.o
 FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
+FUZZ_OBJS += oss-fuzz/fuzz-config.o
 FUZZ_OBJS += oss-fuzz/fuzz-date.o
 FUZZ_OBJS += oss-fuzz/fuzz-pack-headers.o
 FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
diff --git a/ci/run-build-and-minimal-fuzzers.sh b/ci/run-build-and-minimal-fuzzers.sh
index 8ba486f6598..a51076d18df 100755
--- a/ci/run-build-and-minimal-fuzzers.sh
+++ b/ci/run-build-and-minimal-fuzzers.sh
@@ -12,7 +12,7 @@ group "Build fuzzers" make \
 	LIB_FUZZING_ENGINE="-fsanitize=fuzzer,address" \
 	fuzz-all
 
-for fuzzer in commit-graph date pack-headers pack-idx ; do
+for fuzzer in commit-graph config date pack-headers pack-idx ; do
 	begin_group "fuzz-$fuzzer"
 	./oss-fuzz/fuzz-$fuzzer -verbosity=0 -runs=1 || exit 1
 	end_group "fuzz-$fuzzer"
diff --git a/oss-fuzz/.gitignore b/oss-fuzz/.gitignore
index 5b954088254..a877c11f42b 100644
--- a/oss-fuzz/.gitignore
+++ b/oss-fuzz/.gitignore
@@ -1,4 +1,5 @@
 fuzz-commit-graph
+fuzz-config
 fuzz-date
 fuzz-pack-headers
 fuzz-pack-idx
diff --git a/oss-fuzz/fuzz-config.c b/oss-fuzz/fuzz-config.c
new file mode 100644
index 00000000000..94027f5b97e
--- /dev/null
+++ b/oss-fuzz/fuzz-config.c
@@ -0,0 +1,33 @@
+#include "git-compat-util.h"
+#include "config.h"
+
+int LLVMFuzzerTestOneInput(const uint8_t *, size_t);
+static int config_parser_callback(const char *, const char *,
+					const struct config_context *, void *);
+
+static int config_parser_callback(const char *key, const char *value,
+					const struct config_context *ctx UNUSED,
+					void *data UNUSED)
+{
+	/*
+	 * Visit every byte of memory we are given to make sure the parser
+	 * gave it to us appropriately. We need to unconditionally return 0,
+	 * but we also want to prevent the strlen from being optimized away.
+	 */
+	size_t c = strlen(key);
+
+	if (value)
+		c += strlen(value);
+	return c == SIZE_MAX;
+}
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, const size_t size)
+{
+	struct config_options config_opts = { 0 };
+
+	config_opts.error_action = CONFIG_ERROR_SILENT;
+	git_config_from_mem(config_parser_callback, CONFIG_ORIGIN_BLOB,
+				"fuzztest-config", (const char *)data, size, NULL,
+				CONFIG_SCOPE_UNKNOWN, &config_opts);
+	return 0;
+}

base-commit: 945115026aa63df4ab849ab14a04da31623abece
-- 
gitgitgadget
