Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CC9B1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeCXHrM (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:47:12 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39680 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbeCXHp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:59 -0400
Received: by mail-lf0-f67.google.com with SMTP id p142-v6so21403969lfd.6
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XofWyMXcHoGekmXCirssn9coM2uNC5VQ+0aiIGBov80=;
        b=pbGVYIqEShaqjYrptGGfmvcw9Us1CiIk9gJoGWiVT7mebw/6XurDbBOxQIdyG0qrD6
         x8CMSV9Kq9L09lr2iXnC6V+Mj6bKcnaWtNO4dvzRfKvYH84taCpPzbQLaBb+tAJmpy/7
         3LkGnOx1w3n38rjwIT0/r8/tvv08e77AYD4TQzgATlvXi5DfyXXjPtQusoNwWgZCQRo0
         w53vaOqWZX2T39h6/Nmz00EJeaASVBA+7gkR6qUaVTesSrHayfnFSdrEqcRibbtq8/x7
         kMKeTluz4rN5xH0oRaZe98pl7XcxhZtnbQgTOlxwlJU7b2WJs9FssA9AeCDFhTGAOwFY
         K4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XofWyMXcHoGekmXCirssn9coM2uNC5VQ+0aiIGBov80=;
        b=dLA/vg5T21z2QUj87iznevnd/lcROR1dJf7WIs3CgH85e2TQwO+D2La+2e02GF21q+
         22PvTriSSJMCpHxSxiJ6HrpnlBpo3MonS4VwVcFP+ou9A2F0xjMLFLcFudDEoFNtNUco
         hwQem9WAtdAJqpo3NhokQ8EPKFORJtV/Sb8hkPcETvee/OKlDiiMH8ohleycnpdsCiqY
         +I931GItRUovNPh2NTf4X0xmwqO8MDtCPv//WBytaYPGRjDFJjg3eVDtXmV6ifwq7tvh
         +h8C1F52gTSkbFaEuugRb7OlMqo0FbPSQcOsFDMzFsKRDUA2Lyde2Ad66f5qqiYegJOZ
         OLpw==
X-Gm-Message-State: AElRT7H0WOnWN8W9k82cIwtWoy0YyZt6+/IHCiz36hvRwfNvVSgRk7HW
        RAsqZ5tyDkg6cxQbal2Jo08=
X-Google-Smtp-Source: AG47ELsQ+DPV+Myxl9Tm3o2DTu4xaVEPA/GuHvKr97i/S7fdNil8dEHBna0Ln4b0WneV6XgzFH1taw==
X-Received: by 2002:a19:d3d4:: with SMTP id k203-v6mr22845761lfg.146.1521877558154;
        Sat, 24 Mar 2018 00:45:58 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:57 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 22/36] t/helper: merge test-read-cache into test-tool
Date:   Sat, 24 Mar 2018 08:44:51 +0100
Message-Id: <20180324074505.19100-23-pclouds@gmail.com>
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
 t/helper/test-read-cache.c | 3 ++-
 t/helper/test-tool.c       | 1 +
 t/helper/test-tool.h       | 1 +
 t/perf/p0002-read-cache.sh | 2 +-
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 076c778494..393fb9aca4 100644
--- a/Makefile
+++ b/Makefile
@@ -671,6 +671,7 @@ TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
+TEST_BUILTINS_OBJS += test-read-cache.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
@@ -678,7 +679,6 @@ TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
-TEST_PROGRAMS_NEED_X += test-read-cache
 TEST_PROGRAMS_NEED_X += test-write-cache
 TEST_PROGRAMS_NEED_X += test-ref-store
 TEST_PROGRAMS_NEED_X += test-regex
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 48255eef31..d674c88ba0 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -1,6 +1,7 @@
+#include "test-tool.h"
 #include "cache.h"
 
-int cmd_main(int argc, const char **argv)
+int cmd__read_cache(int argc, const char **argv)
 {
 	int i, cnt = 1;
 	if (argc == 2)
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index be5f784865..f64355c25c 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -26,6 +26,7 @@ static struct test_cmd cmds[] = {
 	{ "online-cpus", cmd__online_cpus },
 	{ "path-utils", cmd__path_utils },
 	{ "prio-queue", cmd__prio_queue },
+	{ "read-cache", cmd__read_cache },
 	{ "sha1", cmd__sha1 },
 };
 
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 900c96dc02..4d51c17f5a 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -20,6 +20,7 @@ int cmd__mktemp(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
+int cmd__read_cache(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/perf/p0002-read-cache.sh b/t/perf/p0002-read-cache.sh
index 9180ae9343..cdd105a594 100755
--- a/t/perf/p0002-read-cache.sh
+++ b/t/perf/p0002-read-cache.sh
@@ -8,7 +8,7 @@ test_perf_default_repo
 
 count=1000
 test_perf "read_cache/discard_cache $count times" "
-	test-read-cache $count
+	test-tool read-cache $count
 "
 
 test_done
-- 
2.17.0.rc0.348.gd5a49e0b6f

