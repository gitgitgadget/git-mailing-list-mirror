Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472C02230A
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjEt32L9"
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199DD10EC
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 08:22:52 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32f737deedfso2821210f8f.3
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 08:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699892570; x=1700497370; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbVDZua0qScDsSuG/p5ZRV7NoGmIJtS76hwOY++mTgc=;
        b=HjEt32L9RMFsw27bUhNJUyg18mH4GoWaNgL91NpTme9Lb5NIYAzJMe/m51riSO+idH
         nr751w2Gwffu0vT0twOX5Zo/AF026vMV1/RAVhL7I12wD8ILTi1zweZtQQTiCYkTqN+A
         4hKOZlMjor2YiUzJECmWhvHWvDh2PmRQxqear803aQwON1HESH35O/cUpXHxSdS2nYvm
         dZs729vSVIvDHqA7cUrqeA4IfWM/QeKIZD9+NONJeBp7Z2gt4/sB0demrrckTLpXkXTj
         Edaq/exp8L1wsNxiCTtAkGtorvRgWFomiIU5m/ci7EAHXLnBSg9Jrmt0T1ZmGaXTViH2
         jwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699892570; x=1700497370;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbVDZua0qScDsSuG/p5ZRV7NoGmIJtS76hwOY++mTgc=;
        b=b7s8eAcFwmdUyDwWLg2Y47W6ulEtB/8pYar7ZD/GVLV69G1pS2vIx5DZItWrDf2p1Q
         iYhA9XWUn6IvPmfsnSCuSb8ycxbfr+k6VSIs5HF3KmKwR+cYTY5vQR2+bCNvpPcXv0Sf
         lHYEcy1rOeSFpzdu4MIMJehMiayyiI5fWCDn0NGFS5afWaPHtLinhesoTULWGCvWc0Pr
         fhuqUM8qBPuy5+uMbw8jfxX1uas+/u9wPAgws0v1VVtigd4JenyIfg2XMz5j19k/wy3W
         6xHqxWAQgC6b4c+ZP1ALWp9KHNz7sb4Royhvvew8n+hR618Q9hS9YmeUod/M2BwmT8Tk
         9Yeg==
X-Gm-Message-State: AOJu0Yy0uIrd66i1B5JJpnPtDhSKJbkH57wUgXpHBPWL6fxp79f6s4lB
	RLM6/b2KLVGshhxt/nHOL1gytxK2dRY=
X-Google-Smtp-Source: AGHT+IFNTeNzZs5/14oV+CRHJjjLlkDvAW+EhhrCqaEBRvUytlaNNt20aSs6lCzRJAQROi+fm1gvHw==
X-Received: by 2002:a5d:5984:0:b0:32d:8c6d:cda4 with SMTP id n4-20020a5d5984000000b0032d8c6dcda4mr5906734wri.43.1699892569572;
        Mon, 13 Nov 2023 08:22:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m14-20020adfa3ce000000b003313e4dddecsm5817008wrb.108.2023.11.13.08.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 08:22:49 -0800 (PST)
Message-ID: <pull.1612.v2.git.1699892568344.gitgitgadget@gmail.com>
In-Reply-To: <pull.1612.git.1699724379458.gitgitgadget@gmail.com>
References: <pull.1612.git.1699724379458.gitgitgadget@gmail.com>
From: "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Nov 2023 16:22:48 +0000
Subject: [PATCH v2] fuzz: add new oss-fuzz fuzzer for date.c / date.h
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
Cc: Arthur Chan <arthur.chan@adalogics.com>,
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1612%2Farthurscchan%2Fnew-fuzzer-date-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1612/arthurscchan/new-fuzzer-date-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1612

Range-diff vs v1:

 1:  d43724c19d0 ! 1:  2928e2b858d fuzz: add new oss-fuzz fuzzer for date.c / date.h
     @@ Commit message
          Signed-off-by: Arthur Chan <arthur.chan@adalogics.com>
      
       ## Makefile ##
     -@@ Makefile: ETAGS_TARGET = TAGS
     +@@ Makefile: SCRIPTS = $(SCRIPT_SH_GEN) \
     + ETAGS_TARGET = TAGS
     + 
       FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
     ++FUZZ_OBJS += oss-fuzz/fuzz-date.o
       FUZZ_OBJS += oss-fuzz/fuzz-pack-headers.o
       FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
     -+FUZZ_OBJS += oss-fuzz/fuzz-date.o
       .PHONY: fuzz-objs
     - fuzz-objs: $(FUZZ_OBJS)
     - 
      
       ## oss-fuzz/.gitignore ##
      @@
       fuzz-commit-graph
     ++fuzz-date
       fuzz-pack-headers
       fuzz-pack-idx
     -+fuzz-date
      
       ## oss-fuzz/fuzz-date.c (new) ##
      @@
     @@ oss-fuzz/fuzz-date.c (new)
      +
      +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
      +{
     -+	int type;
     -+	int time;
     ++	int local;
      +	int num;
     ++	uint16_t tz;
      +	char *str;
      +	timestamp_t ts;
      +	enum date_mode_type dmtype;
      +	struct date_mode *dm;
      +
     -+	if (size <= 8)
     -+	{
     ++	if (size <= 4)
     ++		/*
     ++		 * we use the first byte to fuzz dmtype and local,
     ++		 * then the next three bytes to fuzz tz	offset,
     ++		 * and the remainder (at least one byte) is fed
     ++		 * as end-user input to approxidate_careful().
     ++		 */
      +		return 0;
     -+	}
      +
     -+	type = (*((int *)data)) % 8;
     -+	data += 4;
     -+	size -= 4;
     ++	local = !!(*data & 0x10);
     ++	dmtype = (enum date_mode_type)(*data % DATE_UNIX);
     ++	if (dmtype == DATE_STRFTIME)
     ++		/*
     ++		 * Currently DATE_STRFTIME is not supported.
     ++		 */
     ++		return 0;
     ++	data++;
     ++	size--;
      +
     -+	time = abs(*((int *)data));
     -+	data += 4;
     -+	size -= 4;
     ++	tz = *data++;
     ++	tz = (tz << 8) | *data++;
     ++	tz = (tz << 8) | *data++;
     ++	size -= 3;
      +
     -+	str = (char *)malloc(size+1);
     ++	str = (char *)malloc(size + 1);
      +	if (!str)
     -+	{
      +		return 0;
     -+	}
      +	memcpy(str, data, size);
      +	str[size] = '\0';
      +
      +	ts = approxidate_careful(str, &num);
      +	free(str);
      +
     -+	switch(type)
     -+	{
     -+		case 0: default:
     -+			dmtype = DATE_NORMAL;
     -+			break;
     -+		case 1:
     -+			dmtype = DATE_HUMAN;
     -+			break;
     -+		case 2:
     -+			dmtype = DATE_SHORT;
     -+			break;
     -+		case 3:
     -+			dmtype = DATE_ISO8601;
     -+			break;
     -+		case 4:
     -+			dmtype = DATE_ISO8601_STRICT;
     -+			break;
     -+		case 5:
     -+			dmtype = DATE_RFC2822;
     -+			break;
     -+		case 6:
     -+			dmtype = DATE_RAW;
     -+			break;
     -+		case 7:
     -+			dmtype = DATE_UNIX;
     -+			break;
     -+	}
     -+
      +	dm = date_mode_from_type(dmtype);
     -+	dm->local = 1;
     -+	show_date(ts, time, dm);
     ++	dm->local = local;
     ++	show_date(ts, (int16_t)tz, dm);
      +
      +	date_mode_release(dm);
      +


 Makefile             |  1 +
 oss-fuzz/.gitignore  |  1 +
 oss-fuzz/fuzz-date.c | 56 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)
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
index 00000000000..a5c887bf11c
--- /dev/null
+++ b/oss-fuzz/fuzz-date.c
@@ -0,0 +1,56 @@
+#include "git-compat-util.h"
+#include "date.h"
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	int local;
+	int num;
+	uint16_t tz;
+	char *str;
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
+	dmtype = (enum date_mode_type)(*data % DATE_UNIX);
+	if (dmtype == DATE_STRFTIME)
+		/*
+		 * Currently DATE_STRFTIME is not supported.
+		 */
+		return 0;
+	data++;
+	size--;
+
+	tz = *data++;
+	tz = (tz << 8) | *data++;
+	tz = (tz << 8) | *data++;
+	size -= 3;
+
+	str = (char *)malloc(size + 1);
+	if (!str)
+		return 0;
+	memcpy(str, data, size);
+	str[size] = '\0';
+
+	ts = approxidate_careful(str, &num);
+	free(str);
+
+	dm = date_mode_from_type(dmtype);
+	dm->local = local;
+	show_date(ts, (int16_t)tz, dm);
+
+	date_mode_release(dm);
+
+	return 0;
+}

base-commit: dadef801b365989099a9929e995589e455c51fed
-- 
gitgitgadget
