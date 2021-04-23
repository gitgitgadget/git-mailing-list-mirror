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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFD1C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 06:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A65166144A
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 06:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbhDWGiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 02:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbhDWGit (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 02:38:49 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C06C061574
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 23:38:13 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso21975483otl.0
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 23:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y5HJqHgWwsn3du6q9NGPzCMgwQsojBt7+UEz91VJBE0=;
        b=sj7zi0g3Q5zeeYiGYgCqG/QjPL9Xn+eXFcsJuxDyv7oG4bE7G5zPOgWR+oc2jJdb4r
         FK8Vk4p73DA1J+6nCYo0Ce42prSA2rU4sLcYn74my+ZJ2nCrc13zjHwEt1fIMRE2bPuG
         jXzuCHcTIUpyXSxx0OXHLJ2OLWXRHTqFdFZf+ATSpsFBw/QsWb+ZosMbN65TRJhXyqwO
         0ZH5m8y/D+i72AQWqbDqe07Xxwin+u3A9Lz5q4nGJYMdniLqSLZazElY5q1mPpAMlHNK
         d+iAl8vET08zLb6tMp3GVNWWzVgFY5HVj/D98vZXMaumeQwVe5W1xLDOLgaZvRsk52X3
         Q+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5HJqHgWwsn3du6q9NGPzCMgwQsojBt7+UEz91VJBE0=;
        b=tc2KPtBEiQ3VHz7rVq1LXmh3XsJVa+3X/VeWRm57eash7JvWGhbs8FxDI3xSLZpQPE
         wHtJvUskb5hmRruZ1iqJAx6MSiEdm9c+44VywS3//isw/AKDgJgdmCUWrjBb5FMUdren
         BB6SUzEIsCSqKGQNfCRg12ka2XT8+ATCGOkudavkX3EMu9m5OrE+2cgmR5WZaQ39jvf5
         TDJMyzmsWbBLfzOPV/MhZjrG9x66rgi3E4tTaEsEKharwMfD58t0k4HR5hnXoSeO93Wh
         kHmH67msxnhqEm77GV5EDI1yxtjFpWUuoILBatkmrKNME5kiDhG0HT9JYDpmqlrhO3cd
         k4Yw==
X-Gm-Message-State: AOAM530rk+6Eiem4w3jOqOwGpBFowk4Oxs8P/aR9hs+L3300YzoZNgNW
        nVa7jEh1pG9QEIC8EetKgWo=
X-Google-Smtp-Source: ABdhPJx9tbdYnGdJkLunqFNZaT/hRAuK28RlmwvWjgFJoJjI8n39txTPnIV9mWBbo1UD0pc/Qof/kw==
X-Received: by 2002:a05:6830:4d1:: with SMTP id s17mr1974291otd.108.1619159892947;
        Thu, 22 Apr 2021 23:38:12 -0700 (PDT)
Received: from localhost.localdomain ([142.93.93.167])
        by smtp.googlemail.com with ESMTPSA id x5sm1214919ota.79.2021.04.22.23.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 23:38:11 -0700 (PDT)
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Git List <git@vger.kernel.org>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Subject: [PATCH] add git-p4.fallbackEncoding config variable, to prevent git-p4 from crashing on non UTF-8 changeset descriptions
Date:   Thu, 22 Apr 2021 23:36:32 -0700
Message-Id: <20210423063632.1973-1-tzadik.vanderhoof@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <CAPig+cQUaJq4Bu1NDSBnsQoR2HXhQ+s+4aQHeVP82DM_BuEL8Q@mail.gmail.com>
References: <CAPig+cQUaJq4Bu1NDSBnsQoR2HXhQ+s+4aQHeVP82DM_BuEL8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
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
 git-p4.py                                  | 11 +++-
 t/t9835-git-p4-config-fallback-encoding.sh | 76 ++++++++++++++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)
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
index 0000000000..ce352c826b
--- /dev/null
+++ b/t/t9835-git-p4-config-fallback-encoding.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+
+test_description='test git-p4.fallbackEncoding config'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./lib-git-p4.sh
+
+# The Windows build of p4 encodes its command-line arguments according to the
+# active code page (which defaults to "cp1252"). As a result, "p4 submit -d" causes
+# Unicode changeset descriptions to be stored in the Perforce database as cp1252,
+# and a subsequent "git p4 clone" attempting to decode these descriptions as UTF-8
+# will raise a UnicodeDecodeError, necessitating the use of the git-p4.fallbackEncoding config.
+#
+# The Linux build of p4 encodes its command-line arguments as UTF-8, so changeset descriptions
+# are stored as UTF-8, and UnicodeDecodeError is never raised by "git p4 clone".
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
+		test_must_fail git p4 clone --dest="$git" //depot@all 2>error &&
+		grep "UTF-8 decoding failed. Consider using git config git-p4.fallbackEncoding" error
+	)
+'
+test_expect_success 'clone fails with git-p4.fallbackEncoding set to "none"' '
+	git config --global git-p4.fallbackEncoding none &&
+	test_when_finished cleanup_git &&
+	(
+		test_must_fail git p4 clone --dest="$git" //depot@all 2>error &&
+		grep "UTF-8 decoding failed. Consider using git config git-p4.fallbackEncoding" error
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
+		desc=$(head -1 log | cut -d" " -f2) &&
+		test "$desc" = "documentación"
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
+		desc=$(head -1 log | cut -d" " -f2) &&
+		test "$desc" = "documentaci�n"
+	)
+'
+
+test_done
-- 
2.31.1

