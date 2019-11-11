Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 991B91F454
	for <e@80x24.org>; Mon, 11 Nov 2019 01:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfKKBB7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 20:01:59 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:34151 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfKKBB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 20:01:59 -0500
Received: by mail-wm1-f42.google.com with SMTP id j18so2005201wmk.1
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 17:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jd+QezGXbQrwhlVIMwWvb2dXo3MHTv5AXF+x27PwpJQ=;
        b=QzR8bHlQ6JVJ/qduE6HooK0gXZKnpXxT7RX5c5PdmcIMqNmQoZOMMar9nxtbyX3EAD
         MuM634paL02Y0fAZAtk3D4eOKGMmhUXc81HhEFXonRkjCa22EGczVrKkyvyvHtVlOlkx
         2cAV/ycWA4SM1I2ACP4b591MKrJERtc2XqnhWVMlrQhvA4/bHeaD5Z1bQxSjxViIeL2t
         V9Q+bCNV4KESp5e0uva7W7wGAip/ohsm3lsuvqkYRWyVIBiDRAd+gsnSjlYh/0aiQOTn
         pKlGGkBwM1Lr5j2IU2+CLAAYg4Sh/KuKrIUKIbsnCOTbGOgA04YM32wjKim5ZRmNTR3f
         1i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jd+QezGXbQrwhlVIMwWvb2dXo3MHTv5AXF+x27PwpJQ=;
        b=VufLdW4ZUodSKhjgdmd6NMp+ZfmIe09+rJsBjRs73/e1d6ELGlCvuiR14FfxQCaTpV
         K0VQC6JVm82d/E+bedjqvjIA0hJgklY5UfTNsRL4+XgBiikoRmrF5a5vwCQf2LjKK9fG
         dHy7ujV7SdoroemXHb1dkyqBuRwIG0V01qLNKUpULCRgDxQeiVcrSodJ/l7C0IUtg0ju
         zN0oVHjQIvETGTO5u+iRbBE3XGWh+oQzTgYfI4kkP+a/xZ8q4PkjXPFCU8j0Q+o26ec+
         +ik2zSLVlmJ0v4e8grXvKuOxi74xAVV020YB3nUiifnsV2xwErLqoDRKgc7045EM+8Dj
         B60A==
X-Gm-Message-State: APjAAAXov/VHSBbaLg4niav/BUhxqesaH0D1l0NrGDsRIVT9B0Tc+dsX
        enUjZpM/aLaQfeMForYK0F7UmLssQa4=
X-Google-Smtp-Source: APXvYqyGlhCQv9VbOzyBmU6S8DAdZo29AM+gJ5alWhKaeGcgfneJRjg3oz2EEL803Im0XLTonid0Zg==
X-Received: by 2002:a1c:46:: with SMTP id 67mr19307544wma.51.1573434116667;
        Sun, 10 Nov 2019 17:01:56 -0800 (PST)
Received: from localhost (nas193-236.york.ac.uk. [144.32.193.236])
        by smtp.gmail.com with ESMTPSA id t14sm2137664wrw.87.2019.11.10.17.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Nov 2019 17:01:56 -0800 (PST)
From:   Josh Holland <anowlcalledjosh@gmail.com>
To:     git@vger.kernel.org
Cc:     Josh Holland <anowlcalledjosh@gmail.com>
Subject: [PATCH] userdiff: support Python async functions
Date:   Mon, 11 Nov 2019 01:01:48 +0000
Message-Id: <20191111010148.2812-1-anowlcalledjosh@gmail.com>
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
 t/t4018/python-async-def | 4 ++++
 t/t4018/python-class     | 4 ++++
 t/t4018/python-def       | 4 ++++
 userdiff.c               | 2 +-
 4 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/python-async-def
 create mode 100644 t/t4018/python-class
 create mode 100644 t/t4018/python-def

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
diff --git a/userdiff.c b/userdiff.c
index e74a6d402..057fdcc55 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -124,7 +124,7 @@ PATTERNS("php",
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

