Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE46C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiF3Xro (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiF3Xrb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:47:31 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E025A2C9
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso538372wmq.4
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pRt482F6ryc3CM9nxl9bl1JVRQxZk8ZqwRDOr/MjJlc=;
        b=SnBmFQiR8Vlas5B0IsiZmN62Liq9XYFQTgD09DlF4hCloYw02ZTVggB2tvRWX1QyQt
         J84gZDiSxzo+gkob8LmfGyi/xKszIxWQIc4iNWqrQ0zf7ByrMCf7pl8jXIoULvQiYgIe
         g2hWfQQ5c7DmidoJclOZBAJRGCNWPIsUpy0z7ClN7Mx30h6F9XV5LZyq3h1BYUl59YA3
         hAAA4Rxz6J8niYIeJ8VydnXFNYnUfaryIHqhl6NDgjJTzgTtMrbhhly7ABWYvLYGV+oM
         wJD7kKgY7SK+3VUL4v2wW63qPwVNvNogGpnFHqlgF8JOPwioRhFZvKdJd3kkdGUgbBlI
         +CSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pRt482F6ryc3CM9nxl9bl1JVRQxZk8ZqwRDOr/MjJlc=;
        b=QXpS1DcnzBJlWfv7/MGbJUiREm80atZ6BgIqntJUmQvQ6gmnCG55u4KfFtzNC3NEHf
         OW9ynjgBWt5b3XfAwvGgoHrrESwqMhUUmPcuafL111q3bRxVxesk1+jkWh8KwHYCJns2
         wGcSAksNzIj0O4timHVItWnCo3n762UnXjyTLx3ycR7ydHJnBRCrMpaAZH+n2JwR5enq
         nj0hNH+yfF7AKts4yuCrdDNbPrd72/67C1pvQ+by5v+a3C9ZfMRUiZnS+h7scqSaEJz4
         ELGbSeBDGHsHHTWUeXABkhGUAZWB5K/72YoPrZkuN6KI2GZ3tIx5MTM6hS/ng76qdyDZ
         tdWQ==
X-Gm-Message-State: AJIora+G7jT/CPvyqtA1s60JAe8d1LDdW0EEm+GXbNN7LdtHu2ZXlZ3F
        ivValNwChj+xwJ9PB2GcRc5b01VfPzNZGQ==
X-Google-Smtp-Source: AGRyM1sB0Mzu+UusijR8u2/oU34lPAYykcr0JvDMYktmUzoP2muBtDWqjxC4BxJNXTrxLF5BqQWj+A==
X-Received: by 2002:a05:600c:1d97:b0:3a0:4c64:396c with SMTP id p23-20020a05600c1d9700b003a04c64396cmr14643860wms.122.1656632844503;
        Thu, 30 Jun 2022 16:47:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d59c3000000b00210bac248c8sm3011426wry.11.2022.06.30.16.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:47:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 9/9] test-tool delta: fix a memory leak
Date:   Fri,  1 Jul 2022 01:47:09 +0200
Message-Id: <patch-9.9-5341b413bda-20220630T180129Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak introduced in a310d434946 ([PATCH] Deltification
library work by Nicolas Pitre., 2005-05-19), as a result we can mark
another test as passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-delta.c                 | 21 ++++++++++++++-------
 t/t5303-pack-corruption-resilience.sh |  2 ++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index e749a49c88e..b15481ea596 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -20,8 +20,9 @@ int cmd__delta(int argc, const char **argv)
 {
 	int fd;
 	struct stat st;
-	void *from_buf, *data_buf, *out_buf;
+	void *from_buf = NULL, *data_buf = NULL, *out_buf = NULL;
 	unsigned long from_size, data_size, out_size;
+	int ret = 1;
 
 	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
 		fprintf(stderr, "usage: %s\n", usage_str);
@@ -38,21 +39,21 @@ int cmd__delta(int argc, const char **argv)
 	if (read_in_full(fd, from_buf, from_size) < 0) {
 		perror(argv[2]);
 		close(fd);
-		return 1;
+		goto cleanup;
 	}
 	close(fd);
 
 	fd = open(argv[3], O_RDONLY);
 	if (fd < 0 || fstat(fd, &st)) {
 		perror(argv[3]);
-		return 1;
+		goto cleanup;
 	}
 	data_size = st.st_size;
 	data_buf = xmalloc(data_size);
 	if (read_in_full(fd, data_buf, data_size) < 0) {
 		perror(argv[3]);
 		close(fd);
-		return 1;
+		goto cleanup;
 	}
 	close(fd);
 
@@ -66,14 +67,20 @@ int cmd__delta(int argc, const char **argv)
 				      &out_size);
 	if (!out_buf) {
 		fprintf(stderr, "delta operation failed (returned NULL)\n");
-		return 1;
+		goto cleanup;
 	}
 
 	fd = open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
 	if (fd < 0 || write_in_full(fd, out_buf, out_size) < 0) {
 		perror(argv[4]);
-		return 1;
+		goto cleanup;
 	}
 
-	return 0;
+	ret = 0;
+cleanup:
+	free(from_buf);
+	free(data_buf);
+	free(out_buf);
+
+	return ret;
 }
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 41e6dc4dcfc..2926e8dfc41 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='resilience to pack corruptions with redundant objects'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Note: the test objects are created with knowledge of their pack encoding
-- 
2.37.0.874.g7d3439f13c4

