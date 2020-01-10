Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70560C32771
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 03:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EF12072E
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 03:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVtlMKg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbgAJDKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 22:10:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34863 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbgAJDKN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 22:10:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so445639wmb.0
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 19:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=/v6tzLguNGRI/2UqI7CBMqWP2ZTwTLU3ZZYufi8vgNI=;
        b=KVtlMKg/eT4WLlO9U1cXsLs9Bb6fcfmDBVj6YFISgjf2j83lMLs1u2velsp036gc/R
         2R1XmSciEIquw3ul5YlGHlWkCzvTnDd/G/8pijTgVCSUULTeeaHzC3pSIIS+fp/qI8uy
         n7AWi+8MqALVDzP0pAboqmw7Chr+9+tW4/UehgkjEYgvyrgWuoXvgdp6eCaaZZUNEl2Y
         tfhcj/K4BISyxIa768N4VXvOWcRkVxlECV7BQvCxYPO0XFuB0teDsOFxODuJbAZ5a8bF
         3Ltbv5AiRB1PfJC+xKR4BC4X8rRT3m86a8F6RtIk0O1XfD/J9ZC0LNx2ERm+Dl3ZZN4z
         oZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/v6tzLguNGRI/2UqI7CBMqWP2ZTwTLU3ZZYufi8vgNI=;
        b=bwHLunC83gIiwhzHnOVcatzHZXgZOpLp1iy6aNoT4bSMIBA9zFlzEPPAUpCAtN+HV1
         DeMx51Nfur5KW1M/hfFXmmlqfWEwY1JGGugD5YN3wq0gGZTTgUXljtM0jHdoPMGm+seT
         e9oTarPwNyXDVzzYLgAk4MG2Y6MpB9qAkG/vHAcJ7zeRJpxIjLwC/xRTXtHW1TxLtTlW
         Wf157odhBs6Aea4ZHsIIfw0gzEtCVE/lPRfxwLZAwNhGWrrImixErh8RgMV8/dcHUD1m
         coxcqiDcga4UoL4Sau9WlyD+o4PcuKNzhJ3kvPKZtDrsDv52J3J3BUO9GzZ8HlL2+fOz
         TA0Q==
X-Gm-Message-State: APjAAAWfGPkcjVkOqkSrLYRRtBYX6SSU/H8ffG/EkWc/NZahGt33ZsMH
        9Hjrf+VH07tY6mbIPOuOtQMlecnG
X-Google-Smtp-Source: APXvYqydBoDT2B063l4CoCMPe4On3tWoTAQ9cK3pFcEIcFqJ+vlh12WBF5E2EXLU/KkiPFYRT1Sv5Q==
X-Received: by 2002:a7b:c946:: with SMTP id i6mr1257437wml.28.1578625811269;
        Thu, 09 Jan 2020 19:10:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm574473wrw.52.2020.01.09.19.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 19:10:10 -0800 (PST)
Message-Id: <pull.521.git.1578625810098.gitgitgadget@gmail.com>
From:   "Ryan Zoeller via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jan 2020 03:10:09 +0000
Subject: [PATCH] userdiff: add Julia to supported userdiff languages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ryan Zoeller <rtzoeller@rtzoeller.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add xfuncname and word_regex patterns for Julia[1],
which is a language used in numerical analysis and
computational science.

The default behavior for xfuncname did not allow
functions to be indented, nor functions to have a
macro applied, such as @inline or @generated.

[1]: https://julialang.org

Signed-off-by: Ryan Zoeller <rtzoeller@rtzoeller.com>
---
    userdiff: add Julia to supported userdiff languages
    
    Add xfuncname and word_regex patterns for Julia1 [https://julialang.org]
    , which is a language used in numerical analysis and computational
    science.
    
    The default behavior for xfuncname did not allow functions to be
    indented, nor functions to have a macro applied, such as @inline or
    @generated.
    
    Signed-off-by: Ryan Zoeller rtzoeller@rtzoeller.com
    [rtzoeller@rtzoeller.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-521%2Frtzoeller%2Fjulia_userdiff-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-521/rtzoeller/julia_userdiff-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/521

 Documentation/gitattributes.txt |  2 ++
 t/t4018-diff-funcname.sh        |  1 +
 t/t4018/julia-function          |  5 +++++
 t/t4018/julia-indented-function |  8 ++++++++
 t/t4018/julia-inline-function   |  5 +++++
 t/t4018/julia-macro             |  5 +++++
 t/t4018/julia-mutable-struct    |  5 +++++
 t/t4018/julia-struct            |  5 +++++
 userdiff.c                      | 15 +++++++++++++++
 9 files changed, 51 insertions(+)
 create mode 100644 t/t4018/julia-function
 create mode 100644 t/t4018/julia-indented-function
 create mode 100644 t/t4018/julia-inline-function
 create mode 100644 t/t4018/julia-macro
 create mode 100644 t/t4018/julia-mutable-struct
 create mode 100644 t/t4018/julia-struct

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 508fe713c4..d39dc727e3 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -824,6 +824,8 @@ patterns are available:
 
 - `java` suitable for source code in the Java language.
 
+- `julia` suitable for source code in the Julia language.
+
 - `matlab` suitable for source code in the MATLAB and Octave languages.
 
 - `objc` suitable for source code in the Objective-C language.
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index c0f4839543..d4613eb7d2 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -38,6 +38,7 @@ diffpatterns="
 	golang
 	html
 	java
+	julia
 	matlab
 	objc
 	pascal
diff --git a/t/t4018/julia-function b/t/t4018/julia-function
new file mode 100644
index 0000000000..a2eab83c27
--- /dev/null
+++ b/t/t4018/julia-function
@@ -0,0 +1,5 @@
+function RIGHT()
+    # A comment
+    # Another comment
+    return ChangeMe
+end
diff --git a/t/t4018/julia-indented-function b/t/t4018/julia-indented-function
new file mode 100644
index 0000000000..2d48aabcdb
--- /dev/null
+++ b/t/t4018/julia-indented-function
@@ -0,0 +1,8 @@
+function outer_function()
+    function RIGHT()
+        for i = 1:10
+            print(i)
+        end
+        # ChangeMe
+    end
+end
diff --git a/t/t4018/julia-inline-function b/t/t4018/julia-inline-function
new file mode 100644
index 0000000000..5806f224fb
--- /dev/null
+++ b/t/t4018/julia-inline-function
@@ -0,0 +1,5 @@
+@inline function RIGHT()
+    # Prints Hello, then something else.
+    println("Hello")
+    println("ChangeMe")
+end
diff --git a/t/t4018/julia-macro b/t/t4018/julia-macro
new file mode 100644
index 0000000000..1d18bc2750
--- /dev/null
+++ b/t/t4018/julia-macro
@@ -0,0 +1,5 @@
+macro RIGHT()
+    # First comment
+    # Second comment
+    return :( println("ChangeMe") )
+end
diff --git a/t/t4018/julia-mutable-struct b/t/t4018/julia-mutable-struct
new file mode 100644
index 0000000000..db82017ba0
--- /dev/null
+++ b/t/t4018/julia-mutable-struct
@@ -0,0 +1,5 @@
+mutable struct RIGHT
+    x
+    y::Int
+    ChangeMe
+end
diff --git a/t/t4018/julia-struct b/t/t4018/julia-struct
new file mode 100644
index 0000000000..d3d2bda8cb
--- /dev/null
+++ b/t/t4018/julia-struct
@@ -0,0 +1,5 @@
+struct RIGHT
+    x
+    y::Int
+    ChangeMe
+end
diff --git a/userdiff.c b/userdiff.c
index efbe05e5a5..b5e938b1c2 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -79,6 +79,21 @@ PATTERNS("java",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
+PATTERNS("julia",
+	 "^[ \t]*(((mutable[ \t]+)?struct|(@.+[ \t])?function|macro)[ \t].*)$",
+	 /* -- */
+	 /* Binary literals */
+	 "[-+]?0b[01]+"
+	 /* Hexadecimal literals */
+	 "|[-+]?0x[0-9a-fA-F]+"
+	 /* Real and complex literals */
+	 "|[-+0-9.e_(im)]+"
+	 /* Should theoretically allow Unicode characters as part of
+	  * a word, such as U+2211. However, Julia reserves most of the
+	  * U+2200-U+22FF range (as well as others) as user-defined operators,
+	  * therefore they are not handled in this regex. */
+	 "|[a-zA-Z_][a-zA-Z0-9_!]*"
+	 "|--|\\+\\+|<<=?|>>>=?|>>=?|\\\\\\\\=?|//=?|&&|\\|\\||::|->|[-+*/<>%^&|=!$]=?"),
 PATTERNS("matlab",
 	 /*
 	  * Octave pattern is mostly the same as matlab, except that '%%%' and

base-commit: 042ed3e048af08014487d19196984347e3be7d1c
-- 
gitgitgadget
