Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EC321F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeCXHqP (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:46:15 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35109 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeCXHqL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:46:11 -0400
Received: by mail-lf0-f68.google.com with SMTP id t132-v6so21410589lfe.2
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LCHZM1WEnW0i3GC6iB3c/Eq81thFe9h1tJ3jF0FpU+4=;
        b=HKZufQfnsvQa4k0oxbfAyiXGx9LYfd7p4PwG2WVNTYablLF1By+lBe3NfcTUGZKJub
         n4djNvM2vcONaMVDHpAEuB0sXb9Irz7ARUsH40WLkwhb+zbqZKLIaAixQ2pupMUrf7Dm
         zP8NOhEL77M65uzzZQyikzEUFQ9woyA2lJQ6thX0iDrK4jVMmEoLSvBGeuNVbjNmkm0o
         hkdbSIT8PaxdEHCIwZVA2RY0API0OhixYfnOUHqKI3kuV+VPUZ2f8L9oAlqG07a+47ZZ
         lX1k0OLGAg1W1LM2i0zaGYB8wX972JOIDlkdp9XW0+22Hz9OQ4M9q6I3p3jnpRVZwS3a
         BeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LCHZM1WEnW0i3GC6iB3c/Eq81thFe9h1tJ3jF0FpU+4=;
        b=Ga4K26PsDWGPR6z+Y8NS4SPriirL/vyNQCq5kkhpew5KfwokumUep8OSNX9i4qCC2A
         EJelFDzZAGp750SyH7O6NbALDZRzbo46f/4ZaMnWLuVeYeflaX0owAspUXximXkGt4H/
         33ogHmbxq1dpj4S1X3aHxJLE/vZdPLu5Xqtx1UppW+wRIhZT+D3WCdZTVsOKXc+FS3Gi
         uePJvASwSplTk/8FMI+ycWwscrAHfyxyDftnGJiaNGZwlD+qtlLS0XSwD6v8vaB5aXtZ
         ziHEbmuZoe4vOqWqKoZtF3oulaqTGAN5TnXytr2d+WAbsCcUdVK/7QrTIq/oi0/86Q6p
         0Xtg==
X-Gm-Message-State: AElRT7F6QjSAFC9Hj5rr6cUPE/E8K2BTTmEljemwMmAey/Ll2uG3Hwpn
        twGvQaJ4b6AJwee1yiA+bN0=
X-Google-Smtp-Source: AG47ELv2Un1sx8FtxCri/rZ41ecGZ5FlwfBnaM4oPgS84kLitGNnWVj7+3vekwDz6Ndoqet63YgM4w==
X-Received: by 2002:a19:c6c8:: with SMTP id w191-v6mr20971088lff.40.1521877569767;
        Sat, 24 Mar 2018 00:46:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:46:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 30/36] t/helper: merge test-strcmp-offset into test-tool
Date:   Sat, 24 Mar 2018 08:44:59 +0100
Message-Id: <20180324074505.19100-31-pclouds@gmail.com>
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
 Makefile                      | 2 +-
 t/helper/test-strcmp-offset.c | 3 ++-
 t/helper/test-tool.c          | 1 +
 t/helper/test-tool.h          | 1 +
 t/t0065-strcmp-offset.sh      | 2 +-
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 51de8882d0..528a80b6a6 100644
--- a/Makefile
+++ b/Makefile
@@ -680,6 +680,7 @@ TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
 TEST_BUILTINS_OBJS += test-sha1-array.o
 TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sigchain.o
+TEST_BUILTINS_OBJS += test-strcmp-offset.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
@@ -687,7 +688,6 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-write-cache
-TEST_PROGRAMS_NEED_X += test-strcmp-offset
 TEST_PROGRAMS_NEED_X += test-string-list
 TEST_PROGRAMS_NEED_X += test-submodule-config
 TEST_PROGRAMS_NEED_X += test-subprocess
diff --git a/t/helper/test-strcmp-offset.c b/t/helper/test-strcmp-offset.c
index e159c9a127..44e4a6d143 100644
--- a/t/helper/test-strcmp-offset.c
+++ b/t/helper/test-strcmp-offset.c
@@ -1,6 +1,7 @@
+#include "test-tool.h"
 #include "cache.h"
 
-int cmd_main(int argc, const char **argv)
+int cmd__strcmp_offset(int argc, const char **argv)
 {
 	int result;
 	size_t offset;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index c1de1a3397..41b8f869ae 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -35,6 +35,7 @@ static struct test_cmd cmds[] = {
 	{ "sha1-array", cmd__sha1_array },
 	{ "sha1", cmd__sha1 },
 	{ "sigchain", cmd__sigchain },
+	{ "strcmp-offset", cmd__strcmp_offset },
 };
 
 int cmd_main(int argc, const char **argv)
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 1d366846f3..035e82ec6a 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -29,5 +29,6 @@ int cmd__scrap_cache_tree(int argc, const char **argv);
 int cmd__sha1_array(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
+int cmd__strcmp_offset(int argc, const char **argv);
 
 #endif
diff --git a/t/t0065-strcmp-offset.sh b/t/t0065-strcmp-offset.sh
index 7d6d21425f..91fa639c4a 100755
--- a/t/t0065-strcmp-offset.sh
+++ b/t/t0065-strcmp-offset.sh
@@ -8,7 +8,7 @@ while read s1 s2 expect
 do
 	test_expect_success "strcmp_offset($s1, $s2)" '
 		echo "$expect" >expect &&
-		test-strcmp-offset "$s1" "$s2" >actual &&
+		test-tool strcmp-offset "$s1" "$s2" >actual &&
 		test_cmp expect actual
 	'
 done <<-EOF
-- 
2.17.0.rc0.348.gd5a49e0b6f

