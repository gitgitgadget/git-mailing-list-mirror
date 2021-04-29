Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC43AC433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 07:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A7EA613FF
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 07:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbhD2HnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 03:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239520AbhD2HmG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 03:42:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A3FC06138F
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 00:41:10 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gc22-20020a17090b3116b02901558435aec1so6781944pjb.4
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 00:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+GBSpLnXwrJe29/ARunD4AVGiAJjkm4vsDGliY0e1Q=;
        b=NbRM7UrQZFzFhLxaQq8YgSDKDefBxs8657xKwBCI/mSE8Rpi08Fp5sq34fVTSxw2bG
         t2rT/y6Vj+BE4AzW+MOFvJQldbnjixvlmOW00vkzr7MYYf+Wm59XTjF5fD8+V/g1ExtW
         cOP+lJxMFvL6XgS4p960+5tpTZxO6UyUQ5qTzWmdCv6W/pX4Wm8b0t1sri2mK6oSP2He
         8a23Vd3F8H5cLVIacA3o5VHNl8tqVtfTefQkrJl1kilMojzaSU3I9nNwfEl7Z+skDVMI
         soejioAzBar08NME1cW4y4YXZMskU4W1IfFXAnRVulCxL9xSwaG2dWCZaxwl2LGOBGv/
         TREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+GBSpLnXwrJe29/ARunD4AVGiAJjkm4vsDGliY0e1Q=;
        b=PcXw1D9fDkU6R0gMVnd3j+j1+BEbSCCjenA3a8kK0u6JjyL2xk0voTyXTe0Fj7vx6t
         HoAbnSCR2crSgwVG1kDAbgRtUoXJbnzXqUvqUZJJ70hR8X7DFmfMEhBHTHQrWY8B7Oyt
         7Mx1yqVdUMXWGMFABBNkzUeXtFluLUHi0g8nId/q2sX1byWAeNIHx2Dnr5nOaZ1Q79b7
         Xj3vOZJxMBjleCYn+NfU4pbxWHqca1ul6l258pRuRXuBZb9boPVO3s3wFzvlAgqEU680
         DELFWd+MzvgisMOygXR28bMkwgFP+FSTfvg7dCbEChEerYXb3CUp58GFClmiL66u8MnT
         G2sQ==
X-Gm-Message-State: AOAM530UmDuXzUtVxXmvtSxeXLkW/mVa8XRY5zjH2DxkTnVdXUKwHrPE
        Uku0Nqbvpt8JxtIbOxoVuvaqx0cy6X3PEtVj
X-Google-Smtp-Source: ABdhPJzgTCC7Bm7rj91m2ODZ5RmRE0DjAE7e8+LGbF33LF95R+DdftV5z6eL0kkhGII86AHvYCDDRA==
X-Received: by 2002:a17:902:d491:b029:ee:5aa3:7d57 with SMTP id c17-20020a170902d491b02900ee5aa37d57mr954564plg.26.1619682070267;
        Thu, 29 Apr 2021 00:41:10 -0700 (PDT)
Received: from localhost.localdomain (mobile-166-170-48-133.mycingular.net. [166.170.48.133])
        by smtp.googlemail.com with ESMTPSA id p126sm1698341pga.86.2021.04.29.00.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 00:41:09 -0700 (PDT)
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Subject: [PATCH v6] Add git-p4.fallbackEncoding
Date:   Thu, 29 Apr 2021 00:39:05 -0700
Message-Id: <20210429073905.837-1-tzadik.vanderhoof@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20210428145824.43c4t7hkjfqjyspb@tb-raspi4>
References: <20210428145824.43c4t7hkjfqjyspb@tb-raspi4>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add git-p4.fallbackEncoding config variable, to prevent git-p4 from
crashing on non UTF-8 changeset descriptions.

When git-p4 reads the output from a p4 command, it assumes it will
be 100% UTF-8. If even one character in the output of one p4 command is
not UTF-8, git-p4 crashes with:

    File "C:/Program Files/Git/bin/git-p4.py", line 774, in p4CmdList
        value = value.decode() UnicodeDecodeError: 'utf-8' codec can't
        decode byte Ox93 in position 42: invalid start byte

This is especially a problem for the "git p4 clone ... @all" command,
where git-p4 needs to read thousands of changeset descriptions, one of
which may have a stray smart quote, causing the whole clone operation
to fail.

Add a new config setting, allowing git-p4 to try a fallback encoding
(for example, "cp1252") and/or use the Unicode replacement character,
to prevent the whole program from crashing on such a minor problem.

Signed-off-by: Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
---
 Documentation/git-p4.txt                   |  9 ++
 git-p4.py                                  | 11 ++-
 t/t9836-git-p4-config-fallback-encoding.sh | 98 ++++++++++++++++++++++
 3 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100755 t/t9836-git-p4-config-fallback-encoding.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index f89e68b424..86d3ffa644 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -638,6 +638,15 @@ git-p4.pathEncoding::
 	to transcode the paths to UTF-8. As an example, Perforce on Windows
 	often uses "cp1252" to encode path names.
 
+git-p4.fallbackEncoding::
+	Perforce changeset descriptions can be stored in any encoding.
+	Git-p4 first tries to interpret each description as UTF-8. If that
+	fails, this config allows another encoding to be tried. You can specify,
+	for example, "cp1252". If git-p4.fallbackEncoding is "replace", UTF-8 will
+	be used, with invalid UTF-8 characters replaced by the Unicode replacement
+	character. The default is "none": there is no fallback, and any non UTF-8
+	character will cause git-p4 to immediately fail.
+
 git-p4.largeFileSystem::
 	Specify the system that is used for large (binary) files. Please note
 	that large file systems do not support the 'git p4 submit' command.
diff --git a/git-p4.py b/git-p4.py
index 09c9e93ac4..202fb01bdf 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -771,7 +771,16 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
                 for key, value in entry.items():
                     key = key.decode()
                     if isinstance(value, bytes) and not (key in ('data', 'path', 'clientFile') or key.startswith('depotFile')):
-                        value = value.decode()
+                        try:
+                            value = value.decode()
+                        except UnicodeDecodeError:
+                            fallbackEncoding = gitConfig("git-p4.fallbackEncoding").lower() or 'none'
+                            if fallbackEncoding == 'none':
+                                raise Exception("UTF-8 decoding failed. Consider using git config git-p4.fallbackEncoding")
+                            elif fallbackEncoding == 'replace':
+                                value = value.decode(errors='replace')
+                            else:
+                                value = value.decode(encoding=fallbackEncoding)
                     decoded_entry[key] = value
                 # Parse out data if it's an error response
                 if decoded_entry.get('code') == 'error' and 'data' in decoded_entry:
diff --git a/t/t9836-git-p4-config-fallback-encoding.sh b/t/t9836-git-p4-config-fallback-encoding.sh
new file mode 100755
index 0000000000..901bb3759d
--- /dev/null
+++ b/t/t9836-git-p4-config-fallback-encoding.sh
@@ -0,0 +1,98 @@
+#!/bin/sh
+
+test_description='test git-p4.fallbackEncoding config'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'add Unicode description' '
+	cd "$cli" &&
+	echo file1 >file1 &&
+	p4 add file1 &&
+	p4 submit -d documentación
+'
+
+# Unicode descriptions cause "git p4 clone" to crash with a UnicodeDecodeError in some
+# environments. This test determines if that is the case in our environment. If so,
+# we create a file called "clone_fails". In subsequent tests, we check whether that
+# file exists to determine what behavior to expect.
+
+clone_fails="$TRASH_DIRECTORY/clone_fails"
+
+# If clone fails with git-p4.fallbackEncoding set to "none", create the "clone_fails" file,
+# and make sure the error message is correct
+
+test_expect_success 'clone with git-p4.fallbackEncoding set to "none"' '
+	git config --global git-p4.fallbackEncoding none &&
+	test_when_finished cleanup_git && {
+		git p4 clone --dest="$git" //depot@all 2>error || (
+			>"$clone_fails" &&
+			grep "UTF-8 decoding failed. Consider using git config git-p4.fallbackEncoding" error
+		)
+	}
+'
+
+# If clone fails with git-p4.fallbackEncoding set to "none", it should also fail when it's unset,
+# also with the correct error message.  Otherwise the clone should succeed.
+
+test_expect_success 'clone with git-p4.fallbackEncoding unset' '
+	git config --global --unset git-p4.fallbackEncoding &&
+	test_when_finished cleanup_git && {
+		(
+			test -f "$clone_fails" &&
+			test_must_fail git p4 clone --dest="$git" //depot@all 2>error &&
+			grep "UTF-8 decoding failed. Consider using git config git-p4.fallbackEncoding" error
+		) ||
+		(
+			! test -f "$clone_fails" &&
+			git p4 clone --dest="$git" //depot@all 2>error
+		)
+	}
+'
+
+# Whether or not "clone_fails" exists, setting git-p4.fallbackEncoding
+# to "cp1252" should cause clone to succeed and get the right description
+
+test_expect_success 'clone with git-p4.fallbackEncoding set to "cp1252"' '
+	git config --global git-p4.fallbackEncoding cp1252 &&
+	test_when_finished cleanup_git &&
+	(
+		git p4 clone --dest="$git" //depot@all &&
+		cd "$git" &&
+		git log --oneline >log &&
+		desc=$(head -1 log | cut -d" " -f2) &&
+		test "$desc" = "documentación"
+	)
+'
+
+# Setting git-p4.fallbackEncoding to "replace" should always cause clone to succeed.
+# If "clone_fails" exists, the description should contain the Unicode replacement
+# character, otherwise the description should be correct (since we're on a system that
+# doesn't have the Unicode issue)
+
+test_expect_success 'clone with git-p4.fallbackEncoding set to "replace"' '
+	git config --global git-p4.fallbackEncoding replace &&
+	test_when_finished cleanup_git &&
+	(
+		git p4 clone --dest="$git" //depot@all &&
+		cd "$git" &&
+		git log --oneline >log &&
+		desc=$(head -1 log | cut -d" " -f2) &&
+		{
+			(test -f "$clone_fails" &&
+				test "$desc" = "documentaci�n"
+			) ||
+			(! test -f "$clone_fails" &&
+				test "$desc" = "documentación"
+			)
+		}
+	)
+'
+
+test_done
-- 
2.31.1

