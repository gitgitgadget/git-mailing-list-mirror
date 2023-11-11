Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB191BDE2
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI23pBfb"
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200A73879
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 09:39:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32dcd3e5f3fso1823417f8f.1
        for <git@vger.kernel.org>; Sat, 11 Nov 2023 09:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699724381; x=1700329181; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JUIHARIGmX384DY25d4ooWfrfD08WCy8c06NfomWK+o=;
        b=lI23pBfbgCsf8kYvgI261hXjE1kvYqJacJiumvK5zC0YO323Kl18N0j0NEL5q+MbN2
         t/4K3YWDNyldR33hUZcBaAvQg+GQLAafafMpgVzCtR2ZKa839QBR/DQViA2+GVFeAVjE
         SHdxCQLCozYDMVSjhxQS7vtA/MkQXgS0ocL0d5F7iOJl7sy0/0hUKClIt2t96mLOMAIC
         2/DqVBX8M/BEeBIBLwIhZGpY+w79/5I4JUROoqaF2ynu5Yyre0xaPKhww8gi8OHW512j
         vE+hWhG53Ws4cNqddkh/mmv7anFA0pMUcGtGn7F81kBVQ9VOvwqR81CI7alRbKBAW+Ra
         EZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699724381; x=1700329181;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUIHARIGmX384DY25d4ooWfrfD08WCy8c06NfomWK+o=;
        b=Uzd//p45B5VPjTtV9HMfA8EO7QmHbjdh+uERxfwfT0Cjozeyy4oHKsM3D42oG/FFXA
         u80mYVpK7YgMqMoIGcIijeEqJxzrgDbieldqPCSDFtVA4FM6sW4VO26FkFfhBAqweS3Z
         qaHyB4yLdJyKH2SXXKZlGbSwX6F5977CFfGyT6LDJRNv8hSgGiysJMUKPj02AdYQ7Ntk
         hVE6BTxUdkFYyTv4vLdBpsORqePrKeKKC0Z/4QSCiJLA8JLFsR4oJqLxPZJK01/fdn5y
         5xEFR7fNF3OGXfwPWHnmU7TAE96SBtu0RaY8Us7m/MyxaxnShCW9rYP7nv7D9tgSQZJf
         PS1A==
X-Gm-Message-State: AOJu0YzLVu580OxgTYgCJgpUwiq9VdDiuJBWsIKUt8dDVX/nPJuNRb6G
	hgbc2OhkjZ+mdKBcteBJVYmME4LEiTY=
X-Google-Smtp-Source: AGHT+IGa2HiUqrmU8i56uwSGI9JNEvhkl2E4hnyIcGuGetBhNs0m/M4f1glsVT6sfITvu7oilPnVuA==
X-Received: by 2002:a5d:698c:0:b0:32d:d756:2cc7 with SMTP id g12-20020a5d698c000000b0032dd7562cc7mr1595175wru.58.1699724380719;
        Sat, 11 Nov 2023 09:39:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1-20020a5d48c1000000b0032fdcbfb093sm1853903wrs.81.2023.11.11.09.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 09:39:40 -0800 (PST)
Message-ID: <pull.1612.git.1699724379458.gitgitgadget@gmail.com>
From: "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 11 Nov 2023 17:39:39 +0000
Subject: [PATCH] fuzz: add new oss-fuzz fuzzer for date.c / date.h
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1612%2Farthurscchan%2Fnew-fuzzer-date-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1612/arthurscchan/new-fuzzer-date-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1612

 Makefile             |  1 +
 oss-fuzz/.gitignore  |  1 +
 oss-fuzz/fuzz-date.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)
 create mode 100644 oss-fuzz/fuzz-date.c

diff --git a/Makefile b/Makefile
index 03adcb5a480..c9fe99a8c88 100644
--- a/Makefile
+++ b/Makefile
@@ -752,6 +752,7 @@ ETAGS_TARGET = TAGS
 FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
 FUZZ_OBJS += oss-fuzz/fuzz-pack-headers.o
 FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
+FUZZ_OBJS += oss-fuzz/fuzz-date.o
 .PHONY: fuzz-objs
 fuzz-objs: $(FUZZ_OBJS)
 
diff --git a/oss-fuzz/.gitignore b/oss-fuzz/.gitignore
index 9acb74412ef..2375e77b108 100644
--- a/oss-fuzz/.gitignore
+++ b/oss-fuzz/.gitignore
@@ -1,3 +1,4 @@
 fuzz-commit-graph
 fuzz-pack-headers
 fuzz-pack-idx
+fuzz-date
diff --git a/oss-fuzz/fuzz-date.c b/oss-fuzz/fuzz-date.c
new file mode 100644
index 00000000000..29bcaf595e4
--- /dev/null
+++ b/oss-fuzz/fuzz-date.c
@@ -0,0 +1,75 @@
+#include "git-compat-util.h"
+#include "date.h"
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	int type;
+	int time;
+	int num;
+	char *str;
+	timestamp_t ts;
+	enum date_mode_type dmtype;
+	struct date_mode *dm;
+
+	if (size <= 8)
+	{
+		return 0;
+	}
+
+	type = (*((int *)data)) % 8;
+	data += 4;
+	size -= 4;
+
+	time = abs(*((int *)data));
+	data += 4;
+	size -= 4;
+
+	str = (char *)malloc(size+1);
+	if (!str)
+	{
+		return 0;
+	}
+	memcpy(str, data, size);
+	str[size] = '\0';
+
+	ts = approxidate_careful(str, &num);
+	free(str);
+
+	switch(type)
+	{
+		case 0: default:
+			dmtype = DATE_NORMAL;
+			break;
+		case 1:
+			dmtype = DATE_HUMAN;
+			break;
+		case 2:
+			dmtype = DATE_SHORT;
+			break;
+		case 3:
+			dmtype = DATE_ISO8601;
+			break;
+		case 4:
+			dmtype = DATE_ISO8601_STRICT;
+			break;
+		case 5:
+			dmtype = DATE_RFC2822;
+			break;
+		case 6:
+			dmtype = DATE_RAW;
+			break;
+		case 7:
+			dmtype = DATE_UNIX;
+			break;
+	}
+
+	dm = date_mode_from_type(dmtype);
+	dm->local = 1;
+	show_date(ts, time, dm);
+
+	date_mode_release(dm);
+
+	return 0;
+}

base-commit: dadef801b365989099a9929e995589e455c51fed
-- 
gitgitgadget
