Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E64081F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 15:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfKSPJo (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 10:09:44 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:37377 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfKSPJn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 10:09:43 -0500
Received: by mail-wr1-f43.google.com with SMTP id t1so24260938wrv.4
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 07:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hRk7E/tmf0ROAkIG9RD7h/9myorPb00TOsiNz+1qABI=;
        b=dF9BnozJvvxPJYU5oSJPPmTzWYLGrWiv3BF+BPnBy624e+7FAdFif/pdc6EH6t8kEE
         Om+mOH/E7bAes5rJn3rSrQUW5ckd3YTPejL51FhRiTyoEa4vGYuKG0OZ3XKDKLiRqT6t
         DB8qXkYSvcsWCbNhZ2eZOaQyotnjDzYOsIJf6Q56KtG60djo5qlynvlqv3KGy6g2GA64
         CjfJ6JFuGEzLV/l0bvkeZpzG82CRUEMUQ01TUCIErlj2QsNMxs87mq8kLLvx2ATo3zet
         afA47fFCRt8H0WUAc4+D3ty9pN2key05+O06am6/MNXelxdDYDrDdU6sSlhsZR4VJgT5
         pDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hRk7E/tmf0ROAkIG9RD7h/9myorPb00TOsiNz+1qABI=;
        b=ilVPZxEBaSSRHjtZRMtVkk93FF80VpWi0LAXGOPloaoFJfbWgCSAiznqycllmDe8HN
         4E4M5qZDTWasxXzEg37au8nxmqW0T74oiHm7tuXUb+an0CvkHMn6A4SaTlenHo90NsYO
         Fdr9xt5X4iQGmm23MWWrDcRODjUAt6+2giKJykTf6kVnr/Vm5OReQJcAJymrYQShOaJs
         mxrTKxmMZ98xwHBN0uQ5DTUZd4/xFTSrpu+xdJGCDsSmlE/7HEhUtyAPPTQp0BTmBIyj
         D8TUDzUwovt04k18ZCz4Ayq6W4mrk3Z/emZFiDmlN+GKq0N+EDgYeKa0rKbe3tS3krfl
         zrQw==
X-Gm-Message-State: APjAAAXuKNl7gJ0XRyyBdB75+WxLEUXIsFYEX2dLtq9cdcDRTyeEihPO
        gRhAts4FDSF50hB/+ra5sjYgihgKcII=
X-Google-Smtp-Source: APXvYqzbHvjB3Y3/BJ5LLS4ksiwvR45lPW6u8EeuXUgVcDnsrDpUnK22Scwfx9Hr/j+kg6652tsxYA==
X-Received: by 2002:adf:ef51:: with SMTP id c17mr24926057wrp.266.1574176181229;
        Tue, 19 Nov 2019 07:09:41 -0800 (PST)
Received: from localhost (nas193-236.york.ac.uk. [144.32.193.236])
        by smtp.gmail.com with ESMTPSA id w18sm27239815wrl.2.2019.11.19.07.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 07:09:40 -0800 (PST)
From:   Josh Holland <anowlcalledjosh@gmail.com>
To:     git@vger.kernel.org
Cc:     Josh Holland <anowlcalledjosh@gmail.com>
Subject: [PATCH v2] userdiff: support Python async functions
Date:   Tue, 19 Nov 2019 15:08:10 +0000
Message-Id: <20191119150807.8206-1-anowlcalledjosh@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Python's async functions (declared with "async def" rather than "def")
were not being displayed in hunk headers. This commit teaches git about
the async function syntax, and adds tests for the Python userdiff regex.

Signed-off-by: Josh Holland <anowlcalledjosh@gmail.com>
---
This patch now includes tests for indented declarations, as well as the
unindented versions which were present before. Apologies for the delay
in preparing this patch.

 t/t4018/python-async-def          | 4 ++++
 t/t4018/python-class              | 4 ++++
 t/t4018/python-def                | 4 ++++
 t/t4018/python-indented-async-def | 7 +++++++
 t/t4018/python-indented-class     | 5 +++++
 t/t4018/python-indented-def       | 7 +++++++
 userdiff.c                        | 2 +-
 7 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/python-async-def
 create mode 100644 t/t4018/python-class
 create mode 100644 t/t4018/python-def
 create mode 100644 t/t4018/python-indented-async-def
 create mode 100644 t/t4018/python-indented-class
 create mode 100644 t/t4018/python-indented-def

diff --git a/t/t4018/python-async-def b/t/t4018/python-async-def
new file mode 100644
index 000000000..87640e03d
--- /dev/null
+++ b/t/t4018/python-async-def
@@ -0,0 +1,4 @@
+async def RIGHT(pi: int = 3.14):
+    while True:
+        break
+    return ChangeMe()
diff --git a/t/t4018/python-class b/t/t4018/python-class
new file mode 100644
index 000000000..ba9e74143
--- /dev/null
+++ b/t/t4018/python-class
@@ -0,0 +1,4 @@
+class RIGHT(int, str):
+    # comment
+    # another comment
+    # ChangeMe
diff --git a/t/t4018/python-def b/t/t4018/python-def
new file mode 100644
index 000000000..e50b31b0a
--- /dev/null
+++ b/t/t4018/python-def
@@ -0,0 +1,4 @@
+def RIGHT(pi: int = 3.14):
+    while True:
+        break
+    return ChangeMe()
diff --git a/t/t4018/python-indented-async-def b/t/t4018/python-indented-async-def
new file mode 100644
index 000000000..f5d03258a
--- /dev/null
+++ b/t/t4018/python-indented-async-def
@@ -0,0 +1,7 @@
+class Foo:
+    async def RIGHT(self, x: int):
+        return [
+            1,
+            2,
+            ChangeMe,
+        ]
diff --git a/t/t4018/python-indented-class b/t/t4018/python-indented-class
new file mode 100644
index 000000000..19b4f35c4
--- /dev/null
+++ b/t/t4018/python-indented-class
@@ -0,0 +1,5 @@
+if TYPE_CHECKING:
+    class RIGHT:
+        # comment
+        # another comment
+        # ChangeMe
diff --git a/t/t4018/python-indented-def b/t/t4018/python-indented-def
new file mode 100644
index 000000000..208fbadd2
--- /dev/null
+++ b/t/t4018/python-indented-def
@@ -0,0 +1,7 @@
+class Foo:
+    def RIGHT(self, x: int):
+        return [
+            1,
+            2,
+            ChangeMe,
+        ]
diff --git a/userdiff.c b/userdiff.c
index e187d356f..3fd324e61 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -133,7 +133,7 @@ PATTERNS("php",
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+"
 	 "|[-+*/<>%&^|=!.]=|--|\\+\\+|<<=?|>>=?|===|&&|\\|\\||::|->"),
-PATTERNS("python", "^[ \t]*((class|def)[ \t].*)$",
+PATTERNS("python", "^[ \t]*((class|(async[ \t]+)?def)[ \t].*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[jJlL]?|0[xX]?[0-9a-fA-F]+[lL]?"
-- 
2.24.0

