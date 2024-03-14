Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFA24A05
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 06:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710398484; cv=none; b=Lbo2vOBoYhQM4hOnaw0hM/sodUlSpPbZkm2hzhfqyV4NdxZD+fn22wvVZRVGI15ScmqpmjRhD874ptNDZPmstVzfAsRP9fYStW6o3PQyzze0eK499oJngODu4Dkx9P0H5+onuhWQUnVARS3/1ZKQTvLE2+i59xaYe6CDQg/V1Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710398484; c=relaxed/simple;
	bh=XZqrsIGUCToAvn6K6ebrmmhXIfLI3pNiB1c/mtdyIko=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=c9A7TtfTQTnIKWbueHn2f+olsAeaS6pQjeYi+NuFgV3bOwywUv3n6dcGJ4Gf/CIEeyh+FaqFeJFcvtDNbhj3+ImTCjnGEVHsGnpX7DEejXcGFFXIYgEXAsR3kT576NZVd/91qYvmOKenytNTxHAfUhpJX0si1DtPkzWd12vrCaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOxS3HRJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOxS3HRJ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-413eede49dbso3545575e9.0
        for <git@vger.kernel.org>; Wed, 13 Mar 2024 23:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710398480; x=1711003280; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uOL2Dm80Ocq4Vwy4dSZmKDmypr4x1Ft1dPOLbJTD5tE=;
        b=kOxS3HRJo5/VMMOxbU5Fei6BuFH/SvPQp4mP1FyDh5EfKFYZ7H7cb8Hv2Fy5VZXxNc
         oh+/4Dba3Lh3xKBFC+Xh9h+pw/92YDcMmx08dFF4JZbxzIrn1+nbbHfZbHluto4Wxzz7
         OSn950ib8g3k6G2iLPbvw8Xf8NudW+1kXi8taV9u7QONejd2vOZ5q2uRG3z3k2ZBVR6H
         jP9cKN4kqZcm7ua36/QNf4am5A8cdQHB+vr6nwDgBoNck3b1iSvMjEF/zmMH6UXgk7Ow
         5zcRlsMz/DPznJMXwc9kr2Po5mqwWdLOI2k5LFpgNPNMjyBHtZ1HwZEDhuB9JI3mdQiH
         ZCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710398480; x=1711003280;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOL2Dm80Ocq4Vwy4dSZmKDmypr4x1Ft1dPOLbJTD5tE=;
        b=S3L9LNI5KBCqBhFZSWVFP1lGnMElJM0WhZ2WMHp2zvIAwj2/bSZN4rd58D8zFqZ4Bq
         7e5KmGvQn0/KDfuy3saXOOrL83IgpewQTePdKgLOcLnugGs5zjsBNm1f7nIwbZ0/9Smi
         T2b099Dam2WFzeQFGDKKGc9wEth/+n6/uu9R77nnDs5/aByK2sNg9q/IkwEXg80YMH2o
         l5R7y9yJ8RljWtoUdJSULPHM1NLzqwLqv9fK4Sl1iWu62aq0ddh+E35A+U+y3Gj59k2D
         RmLCv1eeEGHrFtFwhh/BzJlJfGU+ylhZtIsA05l/R887Lb6i9m6LQBrqcfT0PR90LFXe
         wp7Q==
X-Gm-Message-State: AOJu0YwH2Rt8LxsLXK7xecrRXbVBFaSnuzwsqVOQ530LmUjWCJiMIB8W
	HlOjKLvsrNk9lvkMq51sz7SIYwM+9Y8Pu5PB14w76ynhGODBkc/o3FvvFGEu
X-Google-Smtp-Source: AGHT+IFKy2BRqZSW5dyIBNDgt0mVF5qXnkTHP/NmIiBJWtFZhtOztFlGrypv/+qeQV6nRC84sYU8wg==
X-Received: by 2002:a05:600c:1ca4:b0:412:d2dd:4bdd with SMTP id k36-20020a05600c1ca400b00412d2dd4bddmr625064wms.26.1710398479568;
        Wed, 13 Mar 2024 23:41:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c458800b00413e8df267bsm1346831wmo.48.2024.03.13.23.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 23:41:19 -0700 (PDT)
Message-ID: <pull.1692.git.1710398478718.gitgitgadget@gmail.com>
From: "Brian Tracy via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 Mar 2024 06:41:18 +0000
Subject: [PATCH] fuzz: add fuzzer for config parsing
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1692%2Fbriantracy%2Fconfig-fuzzer-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1692/briantracy/config-fuzzer-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1692

 Makefile                            |  1 +
 ci/run-build-and-minimal-fuzzers.sh |  2 +-
 oss-fuzz/.gitignore                 |  1 +
 oss-fuzz/fuzz-config.c              | 32 +++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 oss-fuzz/fuzz-config.c

diff --git a/Makefile b/Makefile
index 4e255c81f22..aa6c852548c 100644
--- a/Makefile
+++ b/Makefile
@@ -760,6 +760,7 @@ FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
 FUZZ_OBJS += oss-fuzz/fuzz-date.o
 FUZZ_OBJS += oss-fuzz/fuzz-pack-headers.o
 FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
+FUZZ_OBJS += oss-fuzz/fuzz-config.o
 .PHONY: fuzz-objs
 fuzz-objs: $(FUZZ_OBJS)
 
diff --git a/ci/run-build-and-minimal-fuzzers.sh b/ci/run-build-and-minimal-fuzzers.sh
index 8ba486f6598..29a21281f50 100755
--- a/ci/run-build-and-minimal-fuzzers.sh
+++ b/ci/run-build-and-minimal-fuzzers.sh
@@ -12,7 +12,7 @@ group "Build fuzzers" make \
 	LIB_FUZZING_ENGINE="-fsanitize=fuzzer,address" \
 	fuzz-all
 
-for fuzzer in commit-graph date pack-headers pack-idx ; do
+for fuzzer in commit-graph date pack-headers pack-idx config ; do
 	begin_group "fuzz-$fuzzer"
 	./oss-fuzz/fuzz-$fuzzer -verbosity=0 -runs=1 || exit 1
 	end_group "fuzz-$fuzzer"
diff --git a/oss-fuzz/.gitignore b/oss-fuzz/.gitignore
index 5b954088254..892fb09a95d 100644
--- a/oss-fuzz/.gitignore
+++ b/oss-fuzz/.gitignore
@@ -2,3 +2,4 @@ fuzz-commit-graph
 fuzz-date
 fuzz-pack-headers
 fuzz-pack-idx
+fuzz-config
diff --git a/oss-fuzz/fuzz-config.c b/oss-fuzz/fuzz-config.c
new file mode 100644
index 00000000000..5a1b39aa1e7
--- /dev/null
+++ b/oss-fuzz/fuzz-config.c
@@ -0,0 +1,32 @@
+#include "git-compat-util.h"
+#include "config.h"
+
+#include <stdio.h>
+#include <string.h>
+
+int LLVMFuzzerTestOneInput(const uint8_t *, size_t);
+static int config_parser_callback(const char *, const char *,
+					const struct config_context *, void *);
+
+static int config_parser_callback(const char *key, const char *value,
+					const struct config_context *ctx UNUSED,
+					void *data UNUSED)
+{
+	/* Visit every byte of memory we are given to make sure the parser
+	 * gave it to us appropriately. Ensure a return of 0 to indicate
+	 * success so the parsing continues. */
+	int c = strlen(key);
+	if (value)
+		c += strlen(value);
+	return c < 0;
+}
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, const size_t size)
+{
+	struct config_options config_opts = { 0 };
+	config_opts.error_action = CONFIG_ERROR_SILENT;
+	git_config_from_mem(config_parser_callback, CONFIG_ORIGIN_BLOB,
+				"fuzztest-config", (const char *)data, size, NULL,
+				CONFIG_SCOPE_UNKNOWN, &config_opts);
+	return 0;
+}

base-commit: 945115026aa63df4ab849ab14a04da31623abece
-- 
gitgitgadget
