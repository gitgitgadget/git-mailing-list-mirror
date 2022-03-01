Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E454C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 07:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiCAHD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 02:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiCAHD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 02:03:57 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4DC45AD3
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 23:03:17 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so1434521pjb.0
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 23:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NmBFL09K4zr0IvgwDtOa/4vBme7vokBof3yvdIlrw+A=;
        b=f5IsgyTgxYyFF0Z2GOzHMRcMfaoB/bD32DwsPWV43LEYtiSvyQQuTuNTcblHAdHc5H
         F5pz+wqEIWQblA5CJTBmf2qXLTuwpngBaF6wM+5/st+u7U7DVh+T1+SbYdJNYH+el+DU
         fKk1vG0I1m0+ejKEJi9+U8sQoN41iIhdP34ZHrBi2pYqg2OpVoClt0Ytvfm0u3IFjWyX
         Ls01XL1omA824gg8gyOnV6UKMXERoLTNMg9ItvDABUkcMozRGyI7Vt2lDEBRZgIZuBOU
         ND2RC/Z1iENYRRXHvBtzaOtUraGG+TxKpERzJAXxe1T7/uhZtx08qrd2OtbHvJSUHc9C
         jvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NmBFL09K4zr0IvgwDtOa/4vBme7vokBof3yvdIlrw+A=;
        b=DTnP8wg8qu4ZPGFaWsO3D8dmxQwfcUSIWPzZwjSb/WA5suQs6YIu08k85Gia5Xdf+3
         pz45N5zFt5WqURuXY7g7lMYGXVSZ3NZSqJOtFZ1kudIlrJ8iKFeBWSy18v2RDq8F1+W/
         j9lRYXtna0edL7sdJ4h+vdTn2StOUlteETH60vJBOFXPLpmOQN7gTKfh4jJmgxtbAhVC
         u4AtwqK2Q6Agx+1eInbG1CRdapBVXR+QTLT39hEsH0+iUoBy/HZxMl/Tp2rRJeEYcUxq
         U13Dxp+CzBf/NhYnmIQD05QB2++MbQeEffkgAve9LmQOIMVIkpzhhfyqzZsI7MulEMd7
         7yWg==
X-Gm-Message-State: AOAM531YCtZxic7ScLU8DWkwDYvVxfm1C+aOSDOl79r11E4F7oDAay/4
        1xIo2hG213iFiEUHXJ0VZORJuzFfnCthoUY8Gkg=
X-Google-Smtp-Source: ABdhPJwhSdjpeMnVlhleacUlOLzWzmpKbd53fiFFBgll81rr2I8ySfui2LNbEqn0/Uo+JB4Uda2CsA==
X-Received: by 2002:a17:90a:d816:b0:1bd:3194:70fc with SMTP id a22-20020a17090ad81600b001bd319470fcmr11859716pjv.136.1646118196911;
        Mon, 28 Feb 2022 23:03:16 -0800 (PST)
Received: from localhost.localdomain ([2405:201:a800:4df9:6560:dadc:f905:6d19])
        by smtp.gmail.com with ESMTPSA id q2-20020a056a00084200b004f0fea7d3c8sm16171833pfk.26.2022.02.28.23.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 23:03:16 -0800 (PST)
From:   Jaydeep P Das <jaydeepjd.8914@gmail.com>
To:     git@vger.kernel.org
Cc:     Jaydeep P Das <jaydeepjd.8914@gmail.com>
Subject: [PATCH] userdiff: Add diff driver for Kotlin lang and tests
Date:   Tue,  1 Mar 2022 12:32:26 +0530
Message-Id: <20220301070226.2477769-2-jaydeepjd.8914@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The xfuncname pattern finds func/class declarations
in diffs to display as a hunk header.

This patch adds xfuncname regex and some respective
tests for Kotlin language.

Also modifies `Documentation./gitattributes.txt` to state
the same.

Signed-off-by: Jaydeep P Das <jaydeepjd.8914@gmail.com>
---
 Documentation/gitattributes.txt | 2 ++
 t/t4018/kotlin-class            | 5 +++++
 t/t4018/kotlin-enum-class       | 5 +++++
 t/t4018/kotlin-fun              | 5 +++++
 t/t4018/kotlin-inheritace-class | 5 +++++
 t/t4018/kotlin-inline-class     | 5 +++++
 t/t4018/kotlin-interface        | 5 +++++
 t/t4018/kotlin-nested-fun       | 9 +++++++++
 t/t4018/kotlin-public-class     | 5 +++++
 t/t4018/kotlin-sealed-class     | 5 +++++
 userdiff.c                      | 8 ++++++++
 11 files changed, 59 insertions(+)
 create mode 100644 t/t4018/kotlin-class
 create mode 100644 t/t4018/kotlin-enum-class
 create mode 100644 t/t4018/kotlin-fun
 create mode 100644 t/t4018/kotlin-inheritace-class
 create mode 100644 t/t4018/kotlin-inline-class
 create mode 100644 t/t4018/kotlin-interface
 create mode 100644 t/t4018/kotlin-nested-fun
 create mode 100644 t/t4018/kotlin-public-class
 create mode 100644 t/t4018/kotlin-sealed-class

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index a71dad2674..94d06dc337 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -829,6 +829,8 @@ patterns are available:
 
 - `java` suitable for source code in the Java language.
 
+- `kotlin` suitable for source code in the Kotlin language
+
 - `markdown` suitable for Markdown documents.
 
 - `matlab` suitable for source code in the MATLAB and Octave languages.
diff --git a/t/t4018/kotlin-class b/t/t4018/kotlin-class
new file mode 100644
index 0000000000..bb864f22e6
--- /dev/null
+++ b/t/t4018/kotlin-class
@@ -0,0 +1,5 @@
+class RIGHT {
+	//comment
+	//comment
+	return ChangeMe
+}
diff --git a/t/t4018/kotlin-enum-class b/t/t4018/kotlin-enum-class
new file mode 100644
index 0000000000..8885f908fd
--- /dev/null
+++ b/t/t4018/kotlin-enum-class
@@ -0,0 +1,5 @@
+enum class RIGHT{
+	// Left
+	// a comment
+	ChangeMe
+}
diff --git a/t/t4018/kotlin-fun b/t/t4018/kotlin-fun
new file mode 100644
index 0000000000..2a60280256
--- /dev/null
+++ b/t/t4018/kotlin-fun
@@ -0,0 +1,5 @@
+fun RIGHT(){
+	//a comment
+	//b comment
+    return ChangeMe()
+}
diff --git a/t/t4018/kotlin-inheritace-class b/t/t4018/kotlin-inheritace-class
new file mode 100644
index 0000000000..77376c1f05
--- /dev/null
+++ b/t/t4018/kotlin-inheritace-class
@@ -0,0 +1,5 @@
+open class RIGHT{
+	// a comment
+	// b comment
+	// ChangeMe
+}
diff --git a/t/t4018/kotlin-inline-class b/t/t4018/kotlin-inline-class
new file mode 100644
index 0000000000..7bf46dd8d4
--- /dev/null
+++ b/t/t4018/kotlin-inline-class
@@ -0,0 +1,5 @@
+value class RIGHT(Args){
+	// a comment
+	// b comment
+	ChangeMe
+}
diff --git a/t/t4018/kotlin-interface b/t/t4018/kotlin-interface
new file mode 100644
index 0000000000..f686ba7770
--- /dev/null
+++ b/t/t4018/kotlin-interface
@@ -0,0 +1,5 @@
+interface RIGHT{
+	//another comment
+	//another comment
+	//ChangeMe
+}
diff --git a/t/t4018/kotlin-nested-fun b/t/t4018/kotlin-nested-fun
new file mode 100644
index 0000000000..12186858cb
--- /dev/null
+++ b/t/t4018/kotlin-nested-fun
@@ -0,0 +1,9 @@
+class LEFT{
+	class CENTER{
+		fun RIGHT(  a:Int){
+			//comment
+			//comment
+			ChangeMe
+		}
+	}
+}
diff --git a/t/t4018/kotlin-public-class b/t/t4018/kotlin-public-class
new file mode 100644
index 0000000000..9433fcc226
--- /dev/null
+++ b/t/t4018/kotlin-public-class
@@ -0,0 +1,5 @@
+public class RIGHT{
+	//comment1
+	//comment2
+	ChangeMe
+}
diff --git a/t/t4018/kotlin-sealed-class b/t/t4018/kotlin-sealed-class
new file mode 100644
index 0000000000..0efa4a4eaf
--- /dev/null
+++ b/t/t4018/kotlin-sealed-class
@@ -0,0 +1,5 @@
+sealed class RIGHT {
+	// a comment
+	// b comment
+	ChangeMe
+}
diff --git a/userdiff.c b/userdiff.c
index 8578cb0d12..a6cc6dc3b7 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -168,6 +168,14 @@ PATTERNS("java",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
+PATTERNS("kotlin",
+	 /* fun, class, interface, declarations */
+  	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*[ \t]*)$",
+	 /* -- */
+	 "[a-zA-Z_][a-zA-Z0-9_]*"
+	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
+	 "|[-+*/<>%&^|=!]="
+	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
 PATTERNS("markdown",
 	 "^ {0,3}#{1,6}[ \t].*",
 	 /* -- */
-- 
2.35.1

