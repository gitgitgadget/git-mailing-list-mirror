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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B5FC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 05:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0656B611BE
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 05:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhD0Fkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 01:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhD0Fkb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 01:40:31 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C305BC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 22:39:48 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id j7so32171884pgi.3
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 22:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ld3ZoKCKX30Seof23ZaqaPiItGuA3FHjTTjcEPK1NPs=;
        b=XQtKdsUA1wdFRsaBDkKr1JJXh/x4Izw8ntADhMOAmihg5CMwighbUg74Cl80J1uHtT
         nJLx03FphmaTNuqh4IvBTfS4N/73L3cRuPLYPyJiyZUYe/gJp5d3msFvfQuE4foFEfV+
         pgiAzJ1aKkdDA54thn4hAF49ypACyEFzz4vmjsaxqK0tOqGiiMeZQMS2PidUkm2/DefI
         daEn08iCjBj0ahFHV5v8OlZ8xJcf34oIHKlWJRlh0jdSXUsiO9rvh9/sHrmTBY3aqQAM
         Fncu3E5DJOpOo598v9XTJqtVpwxqj8TKwT1j0nJpIAT7uZBPl9zVbVgCB1/Nl67WppgH
         SyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ld3ZoKCKX30Seof23ZaqaPiItGuA3FHjTTjcEPK1NPs=;
        b=IQgHE0XdtcwJvaAtgEYQ4IDGiGho//wRwet3HYZcPNwSUUvcUIRpl6lXF+GiXcue+2
         5sb4Ctv2DqGZmTgW+qcjlwFFaGqv4GuNPRzWlU5XzL2lCbZhAqidW2t6XKKukmYjNcR2
         WCld5rQvkoUq8Qb6w9HfWgavYRCD//tGEMYP7gStO0I+95b1r+E3i6ZdzO919o1wH68C
         MWfe57VcVxmZrnrg9OOq6ROYOycmUl7R7sc0tZpRtUaBs4M5ae+KSxRQhONTjFtmXXhD
         ZThFvQRBGqeW9QHPkWuZN4+leNImlOM1px/D6VfdAlkDW52zfSOjxZiBKkvO4MbWD5+2
         kzgQ==
X-Gm-Message-State: AOAM532sWGYyeG33boVjLqj+Z+rjA7XasvfQ2pcnyK2nma2ugYKC4Pmb
        v1ZTb0R+NOzUPtX+Na5ynbzXjZ248bxHJQ==
X-Google-Smtp-Source: ABdhPJyYkR0Apa232zPOhJhUOXJ0XqXH3fMCGBWn1080MNM1mf6PkCQA69zWT4OWMeBNaHdxNYCPMg==
X-Received: by 2002:aa7:8888:0:b029:278:e19f:f629 with SMTP id z8-20020aa788880000b0290278e19ff629mr4782643pfe.57.1619501988300;
        Mon, 26 Apr 2021 22:39:48 -0700 (PDT)
Received: from localhost.localdomain ([128.199.7.131])
        by smtp.googlemail.com with ESMTPSA id v123sm1292748pfb.80.2021.04.26.22.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 22:39:47 -0700 (PDT)
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Subject: [PATCH v5] add git-p4.fallbackEncoding config variable, to prevent git-p4 from crashing on non UTF-8 changeset descriptions
Date:   Mon, 26 Apr 2021 22:39:16 -0700
Message-Id: <20210427053916.1977-1-tzadik.vanderhoof@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20210424081447.uxabqbxc54k6yxrg@tb-raspi4>
References: <20210424081447.uxabqbxc54k6yxrg@tb-raspi4>
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

This is especially a problem for the "git p4 clone ... @all" command,
where git-p4 needs to read thousands of changeset descriptions, one of
which may have a stray smart quote, causing the whole clone operation
to fail.

Add a new config setting, allowing git-p4 to try a fallback encoding
(for example, "cp1252") and/or use the Unicode replacement character,
to prevent the whole program from crashing on such a minor problem.

Signed-off-by: Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
---
 Documentation/git-p4.txt                   |  9 +++
 git-p4.py                                  | 11 ++-
 t/t9835-git-p4-config-fallback-encoding.sh | 87 ++++++++++++++++++++++
 3 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100755 t/t9835-git-p4-config-fallback-encoding.sh

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
diff --git a/t/t9835-git-p4-config-fallback-encoding.sh b/t/t9835-git-p4-config-fallback-encoding.sh
new file mode 100755
index 0000000000..383507803e
--- /dev/null
+++ b/t/t9835-git-p4-config-fallback-encoding.sh
@@ -0,0 +1,87 @@
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
+# Unicode descriptions cause clone to throw in some environments. This test
+# determines if that is the case in our environment. If so we create a file called "clone_fails".
+# We check that file to in subsequent tests to determine what behavior to expect.
+
+clone_fails="$TRASH_DIRECTORY/clone_fails"
+
+test_expect_success 'clone with git-p4.fallbackEncoding unset' '
+	test_might_fail git config --global --unset git-p4.fallbackEncoding &&
+	test_when_finished cleanup_git && {
+		git p4 clone --dest="$git" //depot@all 2>error || (
+			cp /dev/null "$clone_fails" &&
+			grep "UTF-8 decoding failed. Consider using git config git-p4.fallbackEncoding" error
+		)
+	}
+'
+
+test_expect_success 'clone with git-p4.fallbackEncoding set to "none"' '
+	git config --global git-p4.fallbackEncoding none &&
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
+test_expect_success 'unset git-p4.fallbackEncoding' '
+	git config --global --unset git-p4.fallbackEncoding
+'
+
+test_done
-- 
2.31.1

