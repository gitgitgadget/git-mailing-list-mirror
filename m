Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF88C433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 05:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FFD613ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 05:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhDVFJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 01:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhDVFJo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 01:09:44 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E39C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 22:09:09 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f29so31980064pgm.8
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 22:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFtrF0VwGNOheGWP0//zn0sfZzUwf3jyHVluK9A+7pI=;
        b=do/WNroDPYJ3ZIc3I2CYi9f1cI10I77UDaDuSHWpNIfcPHgLelFvTt0T9qNBgXcmi0
         WLxCfFJfCBwKW/mfrcKN+LtnTI8IznIwQwXQNyZvmvT0UUbo6xIKOYuTjcg95Rf6jbHW
         8mSk/LNInhBueUpm9rJu6TfvxvY/UH0tOjvAkLMffP2cvnTMM0pGu77vhp7LG0Mc+g8q
         AbMsSVAmZS/pMooyb3nSbBXv1VUFvLUPDJO1aHkr5h15+q6Ugm6PwgrUEIFh6ZpDqsPe
         4fngGxiXv2FE+/+5KIlGLGgVmYFaS2ZXbHKTtIzSVPvUUy0DzRRhMuYYS4Ki46noyqs8
         yTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFtrF0VwGNOheGWP0//zn0sfZzUwf3jyHVluK9A+7pI=;
        b=YSBYBxP9oQVthCY2WUP/nxjnkZnaHD4n4ORwcJ3bA0Kt7ErHmrADxKfqXNBU6Todf3
         DHweg3QpWnC/jeL7dbE098NZ54i9CCttMT2hs/5h9xOR8f0PuLnX3zw5ynv33pZk4eT9
         8gCzuLHJpt3UVXwrXst/6e2lT4M7Cd0tJAg9X6rDh4OpoBe9no+XEoCFXHmcW8litS43
         +do9V2EwDIyXXTPxgbrNGAYJns/WZatxBM6Byx4Gf4a1QZeICNMpnmnx84nGQoyZQ48A
         N9HizdnghWBLVTe/EO2nIEFStmTQAfpx6m/RB+KAfYdOFoVBNgr8GhHbyNDfYeImEsKl
         z0wA==
X-Gm-Message-State: AOAM531jbxGZmjxbB1IHf+ip6HVmN/EK76Qcll6ibKGLLDcQDtbuccxn
        gMwZzgKtXVlrRTNNnV7yiCZfKTzRxEcDNP9e
X-Google-Smtp-Source: ABdhPJzUKXqtClm70Vp/R0XcUXHKsD8X/ewv5dfKrDrQbsmRCy+EueR3xz6owWd0MCP9xyiizZndsQ==
X-Received: by 2002:aa7:8c50:0:b029:263:2069:a336 with SMTP id e16-20020aa78c500000b02902632069a336mr1614628pfd.47.1619068149033;
        Wed, 21 Apr 2021 22:09:09 -0700 (PDT)
Received: from localhost.localdomain ([142.93.93.167])
        by smtp.googlemail.com with ESMTPSA id u18sm808153pfm.4.2021.04.21.22.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 22:09:08 -0700 (PDT)
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
To:     git@vger.kernel.org, tboegi@web.de
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Subject: [PATCH v3] add git-p4.fallbackEncoding config setting, to prevent git-p4 from crashing on non UTF-8 changeset descriptions
Date:   Wed, 21 Apr 2021 22:05:04 -0700
Message-Id: <20210422050504.441-1-tzadik.vanderhoof@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <CAKu1iLWfaAaKH4Uui4wfa0STFEaXqqtc304b5V0ZNtmBg78J+w@mail.gmail.com>
References: <CAKu1iLWfaAaKH4Uui4wfa0STFEaXqqtc304b5V0ZNtmBg78J+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git-p4 reads the output from a p4 command, it assumes it will be
100% UTF-8. If even one character in the output of one p4 command is
not UTF-8, git-p4 crashes with:

File "C:/Program Files/Git/bin/git-p4.py", line 774, in p4CmdList
    value = value.decode() UnicodeDecodeError: 'utf-8' codec can't
decode byte Ox93 in position 42: invalid start byte

This is especially a problem on the "git p4 clone ... @all" command,
where git-p4 needs to read thousands of changeset descriptions, one of
which may have a stray smart quote, causing the whole clone operation
to fail.

This pull request adds a new config setting, allowing git-p4 to try
another encoding (for example, "cp1252") and/or use the Unicode replacement
character, to prevent the whole program from crashing on such a minor problem.

See the documentation included in the patch for more details of how
the new config setting works.

Signed-off-by: Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
---
 Documentation/git-p4.txt                   | 10 ++++
 git-p4.py                                  | 11 +++-
 t/t9835-git-p4-config-fallback-encoding.sh | 65 ++++++++++++++++++++++
 3 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100755 t/t9835-git-p4-config-fallback-encoding.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index f89e68b..e0131a9 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -638,6 +638,16 @@ git-p4.pathEncoding::
 	to transcode the paths to UTF-8. As an example, Perforce on Windows
 	often uses "cp1252" to encode path names.
 
+git-p4.fallbackEncoding::
+	Perforce changeset descriptions can be in a mixture of encodings.
+	Git-p4 first tries to interpret each description as UTF-8. If that
+	fails, this config allows another encoding to be tried. You
+	can specify, for example, "cp1252". If instead of an encoding,
+	you specify "replace", UTF-8 will be used, with invalid UTF-8
+	characters replaced by the Unicode replacement character. If you
+	specify "none" (the default), there is no fallback, and any non
+	UTF-8 character will cause git-p4 to immediately fail.
+
 git-p4.largeFileSystem::
 	Specify the system that is used for large (binary) files. Please note
 	that large file systems do not support the 'git p4 submit' command.
diff --git a/git-p4.py b/git-p4.py
index 09c9e93..3364287 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -771,7 +771,16 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
                 for key, value in entry.items():
                     key = key.decode()
                     if isinstance(value, bytes) and not (key in ('data', 'path', 'clientFile') or key.startswith('depotFile')):
-                        value = value.decode()
+                        try:
+                            value = value.decode()
+                        except UnicodeDecodeError as ex:
+                            fallbackEncoding = gitConfig("git-p4.fallbackEncoding").lower() or 'none'
+                            if fallbackEncoding == 'none':
+                                raise Exception("UTF8 decoding failed. Consider using git config git-p4.fallbackEncoding")
+                            elif fallbackEncoding == 'replace':
+                                value = value.decode(errors='replace')
+                            else:
+                                value = value.decode(encoding=fallbackEncoding)
                     decoded_entry[key] = value
                 # Parse out data if it's an error response
                 if decoded_entry.get('code') == 'error' and 'data' in decoded_entry:
diff --git a/t/t9835-git-p4-config-fallback-encoding.sh b/t/t9835-git-p4-config-fallback-encoding.sh
new file mode 100755
index 0000000..56a245e
--- /dev/null
+++ b/t/t9835-git-p4-config-fallback-encoding.sh
@@ -0,0 +1,65 @@
+#!/bin/sh
+
+test_description='test git-p4.fallbackEncoding config'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./lib-git-p4.sh
+
+if test_have_prereq !MINGW,!CYGWIN; then
+	skip_all='This system is not subject to encoding failures in "git p4 clone"'
+	test_done
+fi
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'add cp1252 description' '
+	cd "$cli" &&
+	echo file1 >file1 &&
+	p4 add file1 &&
+	p4 submit -d documentación
+'
+
+test_expect_success 'clone fails with git-p4.fallbackEncoding unset' '
+	test_might_fail git config --global --unset git-p4.fallbackEncoding &&
+	test_when_finished cleanup_git &&
+	(
+		test_must_fail git p4 clone --dest="$git" //depot@all 2>> actual &&
+		grep "UTF8 decoding failed. Consider using git config git-p4.fallbackEncoding" actual
+	)
+'
+test_expect_success 'clone fails with git-p4.fallbackEncoding set to "none"' '
+	git config --global git-p4.fallbackEncoding none &&
+	test_when_finished cleanup_git &&
+	(
+		test_must_fail git p4 clone --dest="$git" //depot@all 2>> actual &&
+		grep "UTF8 decoding failed. Consider using git config git-p4.fallbackEncoding" actual
+	)
+'
+
+test_expect_success 'clone succeeds with git-p4.fallbackEncoding set to "cp1252"' '
+	git config --global git-p4.fallbackEncoding cp1252 &&
+	test_when_finished cleanup_git &&
+	(
+		git p4 clone --dest="$git" //depot@all &&
+		cd "$git" &&
+		git log --oneline >log &&
+		desc=$(head -1 log | awk '\''{print $2}'\'') &&	[ "$desc" = "documentación" ]
+	)
+'
+
+test_expect_success 'clone succeeds with git-p4.fallbackEncoding set to "replace"' '
+	git config --global git-p4.fallbackEncoding replace &&
+	test_when_finished cleanup_git &&
+	(
+		git p4 clone --dest="$git" //depot@all &&
+		cd "$git" &&
+		git log --oneline >log &&
+		desc=$(head -1 log | awk '\''{print $2}'\'') &&	[ "$desc" = "documentaci�n" ]
+	)
+'
+
+test_done
-- 
2.31.1.windows.1

