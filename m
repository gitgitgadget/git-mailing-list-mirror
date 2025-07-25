Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E598F6E
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753422325; cv=none; b=lwESL1scOsW5Exo6lVjM4GPr3AdqrlXIPmuu4qKlUUyhEVuT1uszIatMqIQra8yBJzqdaES/lzL1Or1iZi8FtgI9BpuxzVzUZo0I9NShGWiZAgpBlNKnIa+1kZhwOgSiyIkilrMUFUVL5Hmb1YIhJp6yayvhYBY8fCcevWZ95qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753422325; c=relaxed/simple;
	bh=ssxLRKwQBgd79JgPziC9m8/8aMBJMaO3bz4BWhPfBWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vBM/TXAplpNtU5mJcApbYEXI6q8opeqMAsq/dXCJsv/1/Xg7M8wBY88IpuY0CY/89alGQtjWEyiT43/gPbWoIGNeaGrwKmme+zNxYNNBm5laC+ykXo9MiQF8ucNN4Ij3wzO64fguKI8F52BWP9RQA3R9/Uu1G6oKSXDJ8RlX2s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEBTxv0q; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEBTxv0q"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b321bd36a41so1612120a12.2
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 22:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753422323; x=1754027123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rD3ujyw9uuVuJjrvXJn7koqvhKA7hqIUnaY0mfZRp9A=;
        b=AEBTxv0qAzIsou2Lyt0HA0sax7GWIXOItOdcvLZZUvEF9a/1u4TP8aGEt2MQPvV82v
         vildIuP1uJgri3aZBhVXVzPTjqXqEkqRLSA1ZZiq1pYt+hMxZGeQ4mjaLgYvZAAlh/dc
         IiLVuho8UOS1us4HrY3PLtVEzdu2iKHK/TLkOeb3i4zr+tLdsLZL3iw28SCWzKEb1B4M
         740FgW9sqMf3d9twdDfDtj5zZvddshGWyrGT1+t8z3Q8D5ejq2we7w9KBLKNUlSdMIsf
         TxFfBnx6vZ7OSIwCM35H3C84N+8CtHqn4KPKtP3J+HPleK3OQYdTgRisNZkQ0iQH3Xie
         KRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753422323; x=1754027123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rD3ujyw9uuVuJjrvXJn7koqvhKA7hqIUnaY0mfZRp9A=;
        b=mswX0nUnDyRaF+cMOojlZqaIN0aeYvveVdAYSo3czb026kQKaPd1RLbAf+UDZKHSq0
         qbDxnf+YojZ4yrt/Lqm9Ye8PRuCC2ieny3FiIib9T0HQ0mbyCOtOOA6Kjz+HDqSVANV3
         2c9J/dOKbdEXuEwEfD7BYJtHoJy0v56pagUrYvr05CKuFvIPMvr9H6+5vERjKEAoxXnM
         QiMDN7kCGsf1nRJu2hDyvQGFSA53urk063b21zsRXXl6qJrCBU5ooaYaDnKoSrSvYKIp
         q1bQg85VzNoh0A/kiLJ9rxv9hzQmEdLONyth1BO3NvvRS+nNxsEr1A/l+xDFT1yXxqtc
         tpKg==
X-Gm-Message-State: AOJu0YyoOMXvbTg29Ee71zJ3Q/VTXkkuyT3mmO2SRKp9upJRLe9s4I+j
	7ph0eVmAp+26szhE2H2d9YjC1SoO7M82ivt/YC8mxXIiSkZTwlECv0CM/3GJfw==
X-Gm-Gg: ASbGncvYz8dIHSJ7HIgzfMvzvtK2eem9T+QVoGPk0R2oC2ieZYsymcxI/YpmyKDfVh6
	Js79WENxlximhdGBKjAutNhEcnBgGFcTYLMFoVc7dzo5+PvSQ63SBwXY4HXQ+hTtPvoToj7SntB
	mMp1r3gk2osSAQV4bdGLGm3eStB7krBpvxQg0t6XywnKVdkB4fQGqrEdydq3tr28N/JBsyUAU5M
	j5IF+55t0M9iOoNMLxkXdo+4Uf+wjhA1xf3nerJ84MQH1oZj0IQCC/1SWSIt+mmQds0ONxFhulb
	GURwB5m0Og2Jd/3lmFCeZ6kcpHLkAUJTl5gLk1WmXhCo9CvvxiypKax9AWzOF9IwN64TioHxuXl
	36yD6Cj1UdYYGeBm/y4d2XWeinf69e6+r3Q==
X-Google-Smtp-Source: AGHT+IG+Iuab4o/6c7DiW/LYBn3yhUBNwngjoaNM4K8/K80RjeWMAaMoMwyHlOWCvJkMHFdSt3g5gg==
X-Received: by 2002:a05:6a20:7488:b0:215:eafc:abd9 with SMTP id adf61e73a8af0-23d700e9754mr987036637.14.1753422323252;
        Thu, 24 Jul 2025 22:45:23 -0700 (PDT)
Received: from localhost.localdomain ([211.37.148.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f6c1261e2sm2592845a12.66.2025.07.24.22.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 22:45:22 -0700 (PDT)
From: Hoyoung Lee <lhywkd22@gmail.com>
To: git@vger.kernel.org
Cc: Hoyoung Lee <lhywkd22@gmail.com>
Subject: [PATCH v5 1/1] test-delta: fix indentation style 
Date: Fri, 25 Jul 2025 05:45:07 +0000
Message-Id: <20250725054507.3130497-1-lhywkd22@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Hoyoung Lee <lhywkd22@gmail.com>
---
 t/helper/test-delta.c | 78 ++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 53 deletions(-)

diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 6bc787a474..4977ee4eaf 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -11,6 +11,7 @@
 #include "test-tool.h"
 #include "git-compat-util.h"
 #include "delta.h"
+#include "strbuf.h"
 
 static const char usage_str[] =
 	"test-tool delta (-d|-p) <from_file> <data_file> <out_file>";
@@ -18,68 +19,39 @@ static const char usage_str[] =
 int cmd__delta(int argc, const char **argv)
 {
 	int fd;
-	struct stat st;
-	void *from_buf = NULL, *data_buf = NULL, *out_buf = NULL;
-	unsigned long from_size, data_size, out_size;
-	int ret = 1;
+	struct strbuf from = STRBUF_INIT, data = STRBUF_INIT;
+	char *out_buf;
+	unsigned long out_size;
 
-	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
-		fprintf(stderr, "usage: %s\n", usage_str);
-		return 1;
-	}
+	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p")))
+        	usage(usage_str);
 
-	fd = open(argv[2], O_RDONLY);
-	if (fd < 0 || fstat(fd, &st)) {
-		perror(argv[2]);
-		return 1;
-	}
-	from_size = st.st_size;
-	from_buf = xmalloc(from_size);
-	if (read_in_full(fd, from_buf, from_size) < 0) {
-		perror(argv[2]);
-		close(fd);
-		goto cleanup;
-	}
-	close(fd);
-
-	fd = open(argv[3], O_RDONLY);
-	if (fd < 0 || fstat(fd, &st)) {
-		perror(argv[3]);
-		goto cleanup;
-	}
-	data_size = st.st_size;
-	data_buf = xmalloc(data_size);
-	if (read_in_full(fd, data_buf, data_size) < 0) {
-		perror(argv[3]);
-		close(fd);
-		goto cleanup;
-	}
-	close(fd);
+	if (strbuf_read_file(&from, argv[2], 0) < 0)
+        	die_errno("unable to read '%s'", argv[2]);
+	if (strbuf_read_file(&data, argv[3], 0) < 0)
+        	die_errno("unable to read '%s'", argv[3]);
 
 	if (argv[1][1] == 'd')
-		out_buf = diff_delta(from_buf, from_size,
-				     data_buf, data_size,
+        	out_buf = diff_delta(from.buf, from.len,
+				     data.buf, data.len,
 				     &out_size, 0);
 	else
-		out_buf = patch_delta(from_buf, from_size,
-				      data_buf, data_size,
+        	out_buf = patch_delta(from.buf, from.len,
+				      data.buf, data.len,
 				      &out_size);
-	if (!out_buf) {
-		fprintf(stderr, "delta operation failed (returned NULL)\n");
-		goto cleanup;
-	}
 
-	fd = open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
-	if (fd < 0 || write_in_full(fd, out_buf, out_size) < 0) {
-		perror(argv[4]);
-		goto cleanup;
-	}
+	if (!out_buf)
+        	die("delta operation failed (returned NULL)");
+
+	fd = xopen(argv[4], O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	if (write_in_full(fd, out_buf, out_size) < 0)
+        	die_errno("write(%s)", argv[4]);
+	if (close(fd) < 0)
+        	die_errno("close(%s)", argv[4]);
 
-	ret = 0;
-cleanup:
-	free(from_buf);
-	free(data_buf);
+	strbuf_release(&from);
+	strbuf_release(&data);
 	free(out_buf);
 
-	return ret;
+	return 0;
 }
-- 
2.34.1

