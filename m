Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9A1C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbiGAKiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbiGAKh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:37:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E25D796AF
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:37:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j7so1046461wmp.2
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3YVIsDOYn896NwVHRxIaJhBcgcU2neDoMaYApmBug1I=;
        b=dMfCG8x/QYZhF4BeE4fbkGRxwC3iZwtL2mNhd7nrfZtu5Ptjj8MRMX79iTmltZtzru
         8rtOmLONOKHBQVL9azaXvt50sFjiVLwTCa++yTadu8EyFiunwUmzz95zkqQPzfZkIO2v
         Wdu3RplPY+ppE/i5DwYQUNgkFjaf2cL2ScF0KSJmUjLCuLo6TdNU3ZFcfbppSy3WWlPH
         czXnD2I7BUafZpY/2SO+svbbZLu/CrhqxmbWmESchsy66VMnB6G3pl5gy2z5x3rpeb3v
         xce+vwQfrQcycpo1iY55sTR2qSLOzt+5pn5064lraj3Bp+mNY+uFOkLVonrwM640lwkS
         G6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3YVIsDOYn896NwVHRxIaJhBcgcU2neDoMaYApmBug1I=;
        b=R4o1qoWUXhlsOXkv09paPSRYCB7zGLwNbN1wqnKcnwANvu/8YIjjIrxNr9KCvELxy/
         DWiNUYsxpLMR5CKw3DLeWsVEDnh6K/B+MuIMrQMiOQDov1ZTRRnSIYhk/4Kj3IZfjmmT
         gMJPiwnT6GR1b1uqPdzju+pLBKfSgutczCzKsMHFEZ9JJLZEicR5D8//aed7BLq2V3+O
         cqKJ37LPXcLMsO7nUcKnzqJBRPRuZaHX0beOYTcefrLYp6FDNImvLqqD8wrqZAN1gdIS
         H4YgL9dDfIIm8KkYIzbFh2Owci258Gx3aHJ7Woze0bcrxUglI7c2Upp9yCdyhotFzdaL
         n4Og==
X-Gm-Message-State: AJIora9sg5M0K/l+pu8jioQUZ4l3gDcb/FsWOseoptpTi6XdLF0nF7Il
        l8YjLuM5pnprNQOKKRpuezpPEX8k/G2smg==
X-Google-Smtp-Source: AGRyM1tNL19/6Ls0tLUD+GRKNvzXRhXb7dGlca3aT0zcoYTsWwZ0wFDMh9BXW60HAHepURy5SjpSEA==
X-Received: by 2002:a1c:770b:0:b0:3a0:42d9:6f4e with SMTP id t11-20020a1c770b000000b003a042d96f4emr15633399wmi.164.1656671873406;
        Fri, 01 Jul 2022 03:37:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b00397393419e3sm6229871wmq.28.2022.07.01.03.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:37:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/9] test-tool json-writer: fix memory leaks
Date:   Fri,  1 Jul 2022 12:37:37 +0200
Message-Id: <patch-v2-6.9-24022fc2b3f-20220701T103503Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix memory leaks introduced with these tests in
75459410edd (json_writer: new routines to create JSON data,
2018-07-13), as a result we can mark a test as passing with
SANITIZE=leak using "TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-json-writer.c | 16 ++++++++++++----
 t/t0019-json-writer.sh      |  2 ++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-json-writer.c b/t/helper/test-json-writer.c
index 37c452535f8..8c3edacc000 100644
--- a/t/helper/test-json-writer.c
+++ b/t/helper/test-json-writer.c
@@ -181,12 +181,18 @@ static struct json_writer nest1 = JSON_WRITER_INIT;
 
 static void make_nest1(int pretty)
 {
+	make_obj1(0);
+	make_arr1(0);
+
 	jw_object_begin(&nest1, pretty);
 	{
 		jw_object_sub_jw(&nest1, "obj1", &obj1);
 		jw_object_sub_jw(&nest1, "arr1", &arr1);
 	}
 	jw_end(&nest1);
+
+	jw_release(&obj1);
+	jw_release(&arr1);
 }
 
 static char *expect_inline1 =
@@ -313,6 +319,9 @@ static void make_mixed1(int pretty)
 		jw_object_sub_jw(&mixed1, "arr1", &arr1);
 	}
 	jw_end(&mixed1);
+
+	jw_release(&obj1);
+	jw_release(&arr1);
 }
 
 static void cmp(const char *test, const struct json_writer *jw, const char *exp)
@@ -325,8 +334,8 @@ static void cmp(const char *test, const struct json_writer *jw, const char *exp)
 	exit(1);
 }
 
-#define t(v) do { make_##v(0); cmp(#v, &v, expect_##v); } while (0)
-#define p(v) do { make_##v(1); cmp(#v, &v, pretty_##v); } while (0)
+#define t(v) do { make_##v(0); cmp(#v, &v, expect_##v); jw_release(&v); } while (0)
+#define p(v) do { make_##v(1); cmp(#v, &v, pretty_##v); jw_release(&v); } while (0)
 
 /*
  * Run some basic regression tests with some known patterns.
@@ -381,7 +390,6 @@ static int unit_tests(void)
 
 	/* mixed forms */
 	t(mixed1);
-	jw_init(&mixed1);
 	p(mixed1);
 
 	return 0;
@@ -544,7 +552,7 @@ static int scripted(void)
 
 	printf("%s\n", jw.json.buf);
 
-	strbuf_release(&jw.json);
+	jw_release(&jw);
 	return 0;
 }
 
diff --git a/t/t0019-json-writer.sh b/t/t0019-json-writer.sh
index 3b0c336b38e..19a730c29ed 100755
--- a/t/t0019-json-writer.sh
+++ b/t/t0019-json-writer.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test json-writer JSON generation'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'unit test of json-writer routines' '
-- 
2.37.0.900.g4d0de1cceb2

