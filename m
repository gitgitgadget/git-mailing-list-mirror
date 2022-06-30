Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F156C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiF3Xra (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbiF3Xr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:47:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6635D5A2C9
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o4so789304wrh.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+KqUFrFy0vttu4IT4OfYz9XrtUrLKGWRuBle3r304QE=;
        b=Nc7qWXvawh5CyrIT6B1/yucn2TO4jL4tfRloX7Sx2gQQH5n0MMTX1dGQAKa37o39lY
         3bF2jwF23vTgOYMlDkpqWL3uXqXj9ifuQE8EyGXRwfy/2E/RspLfcOt/Piz1ZCAQgVOb
         kXkMPS0l7qMS9x4hKtfsxHO/dQmgbkNArMqTaojVuKBPLJz2uoSCtqKSC9VTBqeb7+01
         PW3sTLJkOn0IeTiXt9MO2O+gNIPz2bkfjTRL1tTddjUjBkfVLZWts5hGnUf9qbV0Wuqj
         zelLYN2fhGRZ2wnhMzg/EZIwemYc2B//zYSGaxqwdt8kLcC4IJ+/yiqf9t4Mc/3NNn8U
         SbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+KqUFrFy0vttu4IT4OfYz9XrtUrLKGWRuBle3r304QE=;
        b=6OpwdJcCVJ1HiPDRspGhnrHg3DuOkYPGedmng9B6QqHAdD+3oBRfyRfM9d4Fne3exg
         ptcLy+eAguHPReTVj9rB+DZs2bDeF2zbnkMUwNDYyTzDc1G6gEaqc5+ba6rn1yWO9KDq
         ckwBwi9qWgRKZtJUvwBAkE6SIcrvCwKVVimKm3zfhfzqaqhQT3SsgMFojOkaKcWHOY1N
         kCO9dI+l+doYh7IUYZWAI6jH7FUh24J6KljH6WXUgv/qTZiXl+42IZ7LbjjrgDILRgC4
         /j5RIUDCZpcR+K6Ur4fejJB4dcf0fS0Du5IJ2Jc9cWmeQ8zG0/hsu5GcRv644X0EnnEV
         qMYQ==
X-Gm-Message-State: AJIora+SZEehJUiiOkqtne4MZfcOaMqXj82fNjq8NhST7ksWYnTStRYk
        TWtPgwklkVmFZf7JevLwMlCWLv65eo5CrQ==
X-Google-Smtp-Source: AGRyM1sXBOfAe+dtEvAn1NKL7gGxPaBZ63ZND4hlvH0RRKUQ7icgCihcQWOXo0ot5nnOw8GpgIL7yg==
X-Received: by 2002:a5d:4d10:0:b0:21b:93fc:67a9 with SMTP id z16-20020a5d4d10000000b0021b93fc67a9mr10289237wrt.505.1656632838393;
        Thu, 30 Jun 2022 16:47:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d59c3000000b00210bac248c8sm3011426wry.11.2022.06.30.16.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:47:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/9] test-tool path-utils: fix a memory leak
Date:   Fri,  1 Jul 2022 01:47:02 +0200
Message-Id: <patch-2.9-06b2dcf4f12-20220630T180129Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in "test-tool path-utils", as a result we can mark
the corresponding test as passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-path-utils.c | 10 ++++++++--
 t/t0060-path-utils.sh      |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 229ed416b0e..380437cfe02 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -294,11 +294,13 @@ static int protect_ntfs_hfs_benchmark(int argc, const char **argv)
 int cmd__path_utils(int argc, const char **argv)
 {
 	if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
-		char *buf = xmallocz(strlen(argv[2]));
+		char *to_free = NULL;
+		char *buf = to_free = xmallocz(strlen(argv[2]));
 		int rv = normalize_path_copy(buf, argv[2]);
 		if (rv)
 			buf = "++failed++";
 		puts(buf);
+		free(to_free);
 		return 0;
 	}
 
@@ -356,7 +358,10 @@ int cmd__path_utils(int argc, const char **argv)
 		int nongit_ok;
 		setup_git_directory_gently(&nongit_ok);
 		while (argc > 3) {
-			puts(prefix_path(prefix, prefix_len, argv[3]));
+			char *pfx = prefix_path(prefix, prefix_len, argv[3]);
+
+			puts(pfx);
+			free(pfx);
 			argc--;
 			argv++;
 		}
@@ -366,6 +371,7 @@ int cmd__path_utils(int argc, const char **argv)
 	if (argc == 4 && !strcmp(argv[1], "strip_path_suffix")) {
 		char *prefix = strip_path_suffix(argv[2], argv[3]);
 		printf("%s\n", prefix ? prefix : "(null)");
+		free(prefix);
 		return 0;
 	}
 
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index aa35350b6f3..1f2007e62b7 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -5,6 +5,7 @@
 
 test_description='Test various path utilities'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 norm_path() {
-- 
2.37.0.874.g7d3439f13c4

