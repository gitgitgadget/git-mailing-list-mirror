Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15C691F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeCXHrb (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:47:31 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36305 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbeCXHp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:58 -0400
Received: by mail-lf0-f66.google.com with SMTP id z143-v6so21408059lff.3
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Q1V+IBuHXEbj4KETY+IkHa4qDu29FA4m2M67eR9q48=;
        b=K8WTVKTR0HTzcNVw/FY0C2rVWeFhIKWnytdEzaj0Ae+JWedDR/4U3TS4ON+Z8pWQaa
         gSUwzkY35oDRKXmBQh0/r4x1VFja1B2iv32HKUOw+G62N04/jWKpEuA7AWbaYss9R518
         IrhIFuLUsCDVcXUR7EN3Ppl3/wO/Fiaf8wsSD8HOldSYj3PCFqUyj/VLg2REjBsdmMaA
         mgwrNP7uct2/lRz5ip3T/UFlAVQjp/g+qbuMT7xIC8Ut93oTzzC18yIVwgdTJ7NgzVX+
         s6EdEAPVgbAMgi5pJsk1Z+zaSxkgFfK6VkmXKmdJ4rRf6ICi3y+AR2FOjiO/m5IvtK66
         b2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Q1V+IBuHXEbj4KETY+IkHa4qDu29FA4m2M67eR9q48=;
        b=I1uisdSUP8rpr0Hz6Fi6ICHqrt4ayWAosbAqVcbJb58LFK23eW7fJIeo4Kih+vSuIq
         LCkaKekMylF3a2Xujt8PW/CSiU+fYS7tLSSXO9q5SqJJUVW/vix4AEiYTFHX9PqxMiZK
         25rTg15lLjqDw5YytLzuNDMoYV/Ak39SXpACGU2NK133JwGJM1xxEuiJSZTbnm5itQlC
         uYVIqG9MdwUkA4N+hwP0UCN1TqTabp5yfojlDdKB/twOT81lZXFwh4TpkEUCsE3g/x1K
         bhJW24VCwruVBMxMRQ42x0DBmr24DX8ZUIzwKt3TFllTD4LDOx8ZCv0l/LYJa1lYZnHd
         VsVw==
X-Gm-Message-State: AElRT7HTsKTaoahKyCfyC6t54QI/DxrjWWvigm933N2MGq+KrdQXItYy
        6eCNW+ZDwGVEypzvqeCxWdU=
X-Google-Smtp-Source: AG47ELu17kArRlEvQHKBmpIuDwnb3fx0OAvFYv1XamlNI7n4gUBWoWD6XlEmw96W0VgfD7WSbRh/9w==
X-Received: by 2002:a19:a705:: with SMTP id q5-v6mr20657841lfe.2.1521877556731;
        Sat, 24 Mar 2018 00:45:56 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:55 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 21/36] t/helper: merge test-prio-queue into test-tool
Date:   Sat, 24 Mar 2018 08:44:50 +0100
Message-Id: <20180324074505.19100-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324074505.19100-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
 <20180324074505.19100-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile                   | 2 +-
 t/helper/test-prio-queue.c | 3 ++-
 t/helper/test-tool.c       | 1 +
 t/helper/test-tool.h       | 1 +
 t/t0009-prio-queue.sh      | 6 +++---
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 751ea6cad7..076c778494 100644
--- a/Makefile
+++ b/Makefile
@@ -670,6 +670,7 @@ TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-path-utils.o
+TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
@@ -677,7 +678,6 @@ TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
-TEST_PROGRAMS_NEED_X += test-prio-queue
 TEST_PROGRAMS_NEED_X += test-read-cache
 TEST_PROGRAMS_NEED_X += test-write-cache
 TEST_PROGRAMS_NEED_X += test-ref-store
diff --git a/t/helper/test-prio-queue.c b/t/helper/test-prio-queue.c
index ae58fff359..9807b649b1 100644
--- a/t/helper/test-prio-queue.c
+++ b/t/helper/test-prio-queue.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "prio-queue.h"
 
@@ -16,7 +17,7 @@ static void show(int *v)
 	free(v);
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd__prio_queue(int argc, const char **argv)
 {
 	struct prio_queue pq = { intcmp };
 
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 4c985074b7..be5f784865 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -25,6 +25,7 @@ static struct test_cmd cmds[] = {
 	{ "mktemp", cmd__mktemp },
 	{ "online-cpus", cmd__online_cpus },
 	{ "path-utils", cmd__path_utils },
+	{ "prio-queue", cmd__prio_queue },
 	{ "sha1", cmd__sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 3b7ced01f5..900c96dc02 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -19,6 +19,7 @@ int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
+int cmd__prio_queue(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/t0009-prio-queue.sh b/t/t0009-prio-queue.sh
index 94045c3fad..e56dfce668 100755
--- a/t/t0009-prio-queue.sh
+++ b/t/t0009-prio-queue.sh
@@ -17,7 +17,7 @@ cat >expect <<'EOF'
 10
 EOF
 test_expect_success 'basic ordering' '
-	test-prio-queue 2 6 3 10 9 5 7 4 5 8 1 dump >actual &&
+	test-tool prio-queue 2 6 3 10 9 5 7 4 5 8 1 dump >actual &&
 	test_cmp expect actual
 '
 
@@ -30,7 +30,7 @@ cat >expect <<'EOF'
 6
 EOF
 test_expect_success 'mixed put and get' '
-	test-prio-queue 6 2 4 get 5 3 get get 1 dump >actual &&
+	test-tool prio-queue 6 2 4 get 5 3 get get 1 dump >actual &&
 	test_cmp expect actual
 '
 
@@ -43,7 +43,7 @@ NULL
 NULL
 EOF
 test_expect_success 'notice empty queue' '
-	test-prio-queue 1 2 get get get 1 2 get get get >actual &&
+	test-tool prio-queue 1 2 get get get 1 2 get get get >actual &&
 	test_cmp expect actual
 '
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

