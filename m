Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC7771F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeCXHpi (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:45:38 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46347 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbeCXHpg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:36 -0400
Received: by mail-lf0-f67.google.com with SMTP id j68-v6so21387736lfg.13
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U9XKG8qnn0zICqKVBoMLsOO12DGbSQQYMB5swzGKhdk=;
        b=kILbQ0JnEbzxNy62415BTwNwXJEuvDLjFBzb9KtWEWTeGcld0ixqxapPySlrwGCifz
         R7mstpqwoXP0oNJkSB5VscKG53Vb3jh7zipzm9sQkUg582euQf3CjyF6imshY0GE6sql
         78NUImzRXEmbikfpMhfkeYOJBJEJtiiq7cQrx/ljeEOJmgGqs5jvDjvzlGBZljzM9U2z
         azr8szZDGYTOTEtygcmrwhS82ozIhg8eFVygCG22IxGbjUt3FYz97FRjW2ts1mEOGYvg
         rxKeERfAFSvuNU/2tKiqLzukD2CHlr9lnMboAWJuNvXmJvkpWiLsEOib1XBfNBC4LGqd
         BMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U9XKG8qnn0zICqKVBoMLsOO12DGbSQQYMB5swzGKhdk=;
        b=KcNGvqqQjZ6JM+SzfQKfV1qN3tEKi6qRVh+Truln26R0mW20eZKcnscg7//p/2tonp
         yi5cSqRRYn1xPmvu3j93TnfMJ1TDlLeT2aaEziR6nfo/Ty12xTSkvLk+TxLxtJVWMZr8
         yE0bGtBurFjcHuU8tZSwLJhdCn1V7mzS8ScVM6wk3sAsAeER0RXu9i25UHDH6V6Zlu0l
         g9IUJfkNkTffwSxBaMNyd4BXEv6nIXopsX119yPIzKoUA+8eFrugY8UNNQA5Re7722bp
         EtB8nqOZ13El9AEDFbp0/OY5tlNeMQc0uTxxvp1pA8kry1pfOO529TdFzPtbr2iGW03c
         IkJA==
X-Gm-Message-State: AElRT7HqI8/9q27ep9UvyY/dbvqJ/XNzBQEJg5SflK55WERqpMyq+Ihp
        yx1oHi4z7ulN0MlwglBGDYw=
X-Google-Smtp-Source: AG47ELuv7J7HAT92OHnlmXjX0KRMKGkRaZguPsV5mEztrCfq7Fi2mD672e84j6M8IKHmu+E8w6OIRQ==
X-Received: by 10.46.99.216 with SMTP id s85mr13690911lje.105.1521877534416;
        Sat, 24 Mar 2018 00:45:34 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:33 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/36] t/helper: merge test-sha1 into test-tool
Date:   Sat, 24 Mar 2018 08:44:32 +0100
Message-Id: <20180324074505.19100-4-pclouds@gmail.com>
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
 Documentation/howto/recover-corrupted-object-harder.txt | 2 +-
 Makefile                                                | 4 ++--
 t/helper/test-sha1.c                                    | 3 ++-
 t/helper/test-sha1.sh                                   | 4 ++--
 t/helper/test-tool.c                                    | 1 +
 t/helper/test-tool.h                                    | 1 +
 t/lib-pack.sh                                           | 2 +-
 t/t0013-sha1dc.sh                                       | 2 +-
 8 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/howto/recover-corrupted-object-harder.txt b/Documentation/howto/recover-corrupted-object-harder.txt
index 9c4cd0915f..8994e2559e 100644
--- a/Documentation/howto/recover-corrupted-object-harder.txt
+++ b/Documentation/howto/recover-corrupted-object-harder.txt
@@ -80,7 +80,7 @@ valid pack like:
     # now add our object data
     cat object >>tmp.pack
     # and then append the pack trailer
-    /path/to/git.git/test-sha1 -b <tmp.pack >trailer
+    /path/to/git.git/t/helper/test-tool sha1 -b <tmp.pack >trailer
     cat trailer >>tmp.pack
 ------------
 
diff --git a/Makefile b/Makefile
index 416a8e39c1..3c0d0474af 100644
--- a/Makefile
+++ b/Makefile
@@ -653,6 +653,7 @@ X =
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
 TEST_BUILTINS_OBJS += test-chmtime.o
+TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-ctype
 TEST_PROGRAMS_NEED_X += test-config
@@ -684,7 +685,6 @@ TEST_PROGRAMS_NEED_X += test-regex
 TEST_PROGRAMS_NEED_X += test-revision-walking
 TEST_PROGRAMS_NEED_X += test-run-command
 TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
-TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sha1-array
 TEST_PROGRAMS_NEED_X += test-sigchain
 TEST_PROGRAMS_NEED_X += test-strcmp-offset
@@ -2502,7 +2502,7 @@ t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
-check-sha1:: t/helper/test-sha1$X
+check-sha1:: t/helper/test-tool$X
 	t/helper/test-sha1.sh
 
 SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
diff --git a/t/helper/test-sha1.c b/t/helper/test-sha1.c
index a1c13f54ec..1ba0675c75 100644
--- a/t/helper/test-sha1.c
+++ b/t/helper/test-sha1.c
@@ -1,6 +1,7 @@
+#include "test-tool.h"
 #include "cache.h"
 
-int cmd_main(int ac, const char **av)
+int cmd__sha1(int ac, const char **av)
 {
 	git_SHA_CTX ctx;
 	unsigned char sha1[20];
diff --git a/t/helper/test-sha1.sh b/t/helper/test-sha1.sh
index 750b95a0a1..84594885c7 100755
--- a/t/helper/test-sha1.sh
+++ b/t/helper/test-sha1.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 dd if=/dev/zero bs=1048576 count=100 2>/dev/null |
-/usr/bin/time t/helper/test-sha1 >/dev/null
+/usr/bin/time t/helper/test-tool sha1 >/dev/null
 
 while read expect cnt pfx
 do
@@ -11,7 +11,7 @@ do
 			test -z "$pfx" || echo "$pfx"
 			dd if=/dev/zero bs=1048576 count=$cnt 2>/dev/null |
 			perl -pe 'y/\000/g/'
-		} | ./t/helper/test-sha1 $cnt
+		} | ./t/helper/test-tool sha1 $cnt
 	)
 	if test "$expect" = "$actual"
 	then
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 63ec15cb56..7a9bb9f140 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -8,6 +8,7 @@ struct test_cmd {
 
 static struct test_cmd cmds[] = {
 	{ "chmtime", cmd__chmtime },
+	{ "sha1", cmd__sha1 },
 };
 
 int cmd_main(int argc, const char **argv)
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 3a35e70e79..a05b8bd14c 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -2,5 +2,6 @@
 #define __TEST_TOOL_H__
 
 int cmd__chmtime(int argc, const char **argv);
+int cmd__sha1(int argc, const char **argv);
 
 #endif
diff --git a/t/lib-pack.sh b/t/lib-pack.sh
index 7509846571..501078249d 100644
--- a/t/lib-pack.sh
+++ b/t/lib-pack.sh
@@ -85,7 +85,7 @@ pack_obj () {
 
 # Compute and append pack trailer to "$1"
 pack_trailer () {
-	test-sha1 -b <"$1" >trailer.tmp &&
+	test-tool sha1 -b <"$1" >trailer.tmp &&
 	cat trailer.tmp >>"$1" &&
 	rm -f trailer.tmp
 }
diff --git a/t/t0013-sha1dc.sh b/t/t0013-sha1dc.sh
index 6d655cb161..419f31a8f7 100755
--- a/t/t0013-sha1dc.sh
+++ b/t/t0013-sha1dc.sh
@@ -11,7 +11,7 @@ then
 fi
 
 test_expect_success 'test-sha1 detects shattered pdf' '
-	test_must_fail test-sha1 <"$TEST_DATA/shattered-1.pdf" 2>err &&
+	test_must_fail test-tool sha1 <"$TEST_DATA/shattered-1.pdf" 2>err &&
 	test_i18ngrep collision err &&
 	grep 38762cf7f55934b34d179ae6a4c80cadccbb7f0a err
 '
-- 
2.17.0.rc0.348.gd5a49e0b6f

