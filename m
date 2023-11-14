Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8781A582
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO4LH+T7"
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B63187
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 02:53:09 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32ded3eb835so3756730f8f.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 02:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699959187; x=1700563987; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQTR4ViD9cxtfgDrcFgwVJp9V7IgLMohSh22MKlZpt4=;
        b=kO4LH+T7Q9MvIYJMH8iaAwoZSTd/ALTZy728YhgUhhfdvSLJa0S+ZCc1jcQ6JFsP/X
         Xv/fDVUiw1ywkLMaNGfFUcsrP/ipmhDNWNCL/qtcKb/KGJsUgfyu3CgQTJnCk4wR8xIb
         J5ONc8tSKoADBHJlI8EVSqc7bQYNy53v975YEi7npBW0CjeMD8uhvIwQ46duq/QoMwPU
         R2Q5vjKVK/09lFJ9eAtN6X2CmB6thkYBHIjDgX851B2HkK92ZdQkano6MrhVLThHu9Dg
         Ukf/mupH0lYW8McrWnGWYHxX4F5NZ/vF5Mx83fwBI4xEU1xIY/l1CnHuygLyslwjBYkp
         KZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699959187; x=1700563987;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQTR4ViD9cxtfgDrcFgwVJp9V7IgLMohSh22MKlZpt4=;
        b=MlNd2qlUxKb2hKdD76d3NYraco2+NvVhQ5SrzBekpgYSEGUk25lqisXDQ9ftVDRclF
         MeCmKOgLYnpPwNhX1ZxCywcas2PUaLgaGyBl8JlXEsSXcuinKMVpODM7+VcRUOQHRaRm
         Gf1fxzr+YhCDsHscfEP1hVK72KkEiDHv0Erk+6LdIHwsSxa6epHHtL2qNEYEBN28yGF3
         9qAvPh2GscnRtyt3wjBwsGQb5cIDzE+QdkWEpT3AWytTa6lHi7ignHpHTriOzFBEJGuJ
         reilVPFfOOG975rIc2tDRl4EMlhUPDqMm0syyhR9/tr9bQhGGZSGpY8gb29cDhTyDLuG
         3d9Q==
X-Gm-Message-State: AOJu0Yxu4v8DpvZ9LJh+RiG8RC27pDG8yrqjtW6kU8zpnSukEPGPzTG+
	UwI6M25AXAP8GxFf9GK6JQ3WQS9CABI=
X-Google-Smtp-Source: AGHT+IHKjpBTrAXK/+KduTqUgsYNFeWfQQ+0DAKsdA78nDCfKKEq9PU4SF3hDQfkE5iQDaTPdduYfg==
X-Received: by 2002:a5d:47a8:0:b0:323:1d6a:3952 with SMTP id 8-20020a5d47a8000000b003231d6a3952mr7298895wrb.4.1699959187266;
        Tue, 14 Nov 2023 02:53:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7-20020a5d5487000000b0032f7cc56509sm7454697wrv.98.2023.11.14.02.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 02:53:06 -0800 (PST)
Message-ID: <pull.1612.v3.git.1699959186146.gitgitgadget@gmail.com>
In-Reply-To: <pull.1612.v2.git.1699892568344.gitgitgadget@gmail.com>
References: <pull.1612.v2.git.1699892568344.gitgitgadget@gmail.com>
From: "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Nov 2023 10:53:05 +0000
Subject: [PATCH v3] fuzz: add new oss-fuzz fuzzer for date.c / date.h
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
Cc: Jeff King <peff@peff.net>,
    Arthur Chan <arthur.chan@adalogics.com>,
    Arthur Chan <arthur.chan@adalogics.com>

From: Arthur Chan <arthur.chan@adalogics.com>

Signed-off-by: Arthur Chan <arthur.chan@adalogics.com>
---
    fuzz: add new oss-fuzz fuzzer for date.c / date.h
    
    This patch is aimed to add a new oss-fuzz fuzzer to the oss-fuzz
    directory for fuzzing date.c / date.h in the base directory.
    
    The .gitignore of the oss-fuzz directory and the Makefile have been
    modified to accommodate the new fuzzer fuzz-date.c.
    
    Fixed the objects order in .gitignore and Makefiles and fixed some of
    the logic and formatting for the fuzz-date.c fuzzer in v2.
    
    Fixed the creation and memory allocation of the fuzzing str in v3. Also
    fixed the tz type and sign-extended the data before passing to the tz
    variable.
    
    Comment: Yes, indeed. It is quite annoying to have that twice. Yes, the
    tz should be considered as attacker controllable and thus negative
    values should be considered. But it is tricky to fuzz it because the
    date.c::gm_time_t() will call die() if the value is invalid and that
    exit the fuzzer directly. OSS-Fuzz may consider it as an issue (or bug)
    because the fuzzer exit "unexpectedly". I agree that if we consider the
    tz as "attacker controllable, we should include negative values, but
    since it will cause the fuzzer exit, I am not sure if it is the right
    approach from the fuzzing perspective. Also, it is something that date.c
    already take care of with the conditional checking, thus it may also be
    worth to do some checking and exclude some invalid values before calling
    date.c::show_date() but this may result in copying some conditional
    checking code from date.c.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1612%2Farthurscchan%2Fnew-fuzzer-date-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1612/arthurscchan/new-fuzzer-date-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1612

Range-diff vs v2:

 1:  2928e2b858d ! 1:  046bca32889 fuzz: add new oss-fuzz fuzzer for date.c / date.h
     @@ oss-fuzz/fuzz-date.c (new)
      +{
      +	int local;
      +	int num;
     -+	uint16_t tz;
     ++	int tz;
      +	char *str;
     ++	int8_t *tmp_data;
      +	timestamp_t ts;
      +	enum date_mode_type dmtype;
      +	struct date_mode *dm;
     @@ oss-fuzz/fuzz-date.c (new)
      +		return 0;
      +
      +	local = !!(*data & 0x10);
     -+	dmtype = (enum date_mode_type)(*data % DATE_UNIX);
     -+	if (dmtype == DATE_STRFTIME)
     -+		/*
     -+		 * Currently DATE_STRFTIME is not supported.
     -+		 */
     -+		return 0;
     ++	num = *data % DATE_UNIX;
     ++	if (num >= DATE_STRFTIME)
     ++		num++;
     ++	dmtype = (enum date_mode_type)num;
      +	data++;
      +	size--;
      +
     -+	tz = *data++;
     -+	tz = (tz << 8) | *data++;
     -+	tz = (tz << 8) | *data++;
     ++	tmp_data = (int8_t*)data;
     ++	tz = *tmp_data++;
     ++	tz = (tz << 8) | *tmp_data++;
     ++	tz = (tz << 8) | *tmp_data++;
     ++	data += 3;
      +	size -= 3;
      +
     -+	str = (char *)malloc(size + 1);
     -+	if (!str)
     -+		return 0;
     -+	memcpy(str, data, size);
     -+	str[size] = '\0';
     ++	str = xmemdupz(data, size);
      +
      +	ts = approxidate_careful(str, &num);
      +	free(str);
      +
      +	dm = date_mode_from_type(dmtype);
      +	dm->local = local;
     -+	show_date(ts, (int16_t)tz, dm);
     ++	show_date(ts, tz, dm);
      +
      +	date_mode_release(dm);
      +


 Makefile             |  1 +
 oss-fuzz/.gitignore  |  1 +
 oss-fuzz/fuzz-date.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 oss-fuzz/fuzz-date.c

diff --git a/Makefile b/Makefile
index 03adcb5a480..4b875ef6ce1 100644
--- a/Makefile
+++ b/Makefile
@@ -750,6 +750,7 @@ SCRIPTS = $(SCRIPT_SH_GEN) \
 ETAGS_TARGET = TAGS
 
 FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
+FUZZ_OBJS += oss-fuzz/fuzz-date.o
 FUZZ_OBJS += oss-fuzz/fuzz-pack-headers.o
 FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
 .PHONY: fuzz-objs
diff --git a/oss-fuzz/.gitignore b/oss-fuzz/.gitignore
index 9acb74412ef..5b954088254 100644
--- a/oss-fuzz/.gitignore
+++ b/oss-fuzz/.gitignore
@@ -1,3 +1,4 @@
 fuzz-commit-graph
+fuzz-date
 fuzz-pack-headers
 fuzz-pack-idx
diff --git a/oss-fuzz/fuzz-date.c b/oss-fuzz/fuzz-date.c
new file mode 100644
index 00000000000..52bea5553a1
--- /dev/null
+++ b/oss-fuzz/fuzz-date.c
@@ -0,0 +1,53 @@
+#include "git-compat-util.h"
+#include "date.h"
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	int local;
+	int num;
+	int tz;
+	char *str;
+	int8_t *tmp_data;
+	timestamp_t ts;
+	enum date_mode_type dmtype;
+	struct date_mode *dm;
+
+	if (size <= 4)
+		/*
+		 * we use the first byte to fuzz dmtype and local,
+		 * then the next three bytes to fuzz tz	offset,
+		 * and the remainder (at least one byte) is fed
+		 * as end-user input to approxidate_careful().
+		 */
+		return 0;
+
+	local = !!(*data & 0x10);
+	num = *data % DATE_UNIX;
+	if (num >= DATE_STRFTIME)
+		num++;
+	dmtype = (enum date_mode_type)num;
+	data++;
+	size--;
+
+	tmp_data = (int8_t*)data;
+	tz = *tmp_data++;
+	tz = (tz << 8) | *tmp_data++;
+	tz = (tz << 8) | *tmp_data++;
+	data += 3;
+	size -= 3;
+
+	str = xmemdupz(data, size);
+
+	ts = approxidate_careful(str, &num);
+	free(str);
+
+	dm = date_mode_from_type(dmtype);
+	dm->local = local;
+	show_date(ts, tz, dm);
+
+	date_mode_release(dm);
+
+	return 0;
+}

base-commit: dadef801b365989099a9929e995589e455c51fed
-- 
gitgitgadget
