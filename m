Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9053BC77B7A
	for <git@archiver.kernel.org>; Sat, 20 May 2023 16:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjETQOQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 12:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjETQOH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 12:14:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF64DB
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30a4ebbda56so375650f8f.1
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684599245; x=1687191245;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzsGqgsevrUhodzdFAxQK9whsckAIVJLXwzvdwvULrk=;
        b=D7tnqNWGWiffWmYmoitRWGUf2vNY1WaPBj7moCcc33f8jAnens0dRI9s2h6P9G+yLc
         E5BIo0W3KT2an+5HwZ5jPJUwKD0zk3+fzduo2dvO5X9eazUOfcYV/GNfITUq/PH7qruy
         VbZ63tK0TONLZpPxtv5oreYjYKGQE/uYgDY9JmP+VfZSCkSfdH7WROFW/VXizT9gUKnK
         dy5H+YJB5J7nYY5Q2+GwiC2RC0R9q+VdBq1JDivw8XSk7nv30iPQ54BbzB0e8HmA+NkI
         gNb/DcTE1iNDl3rMXh79lvpmSm4DSsFiagZCin4MPeESrrqzSe/X0Fr4oV9AI3sd2zzP
         /ctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684599245; x=1687191245;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzsGqgsevrUhodzdFAxQK9whsckAIVJLXwzvdwvULrk=;
        b=JrodFxu3irlqcpwQGE/ri2slHQJXYt0Tk23o/apQ5eH0A5bwPGes4rx2L7x0U+rHH9
         XBVTtX5rw6MG+OZB4AFXsc8Ii9wn/XHgH4+EMs9ROu/3QWjdVcOB45hNkLXcrXFld6AS
         9DV+gjzcrpH0Gn0jK1KrGZYekzgM8xprUetiaIVNRpqiHZJPevgXNrR/UNNcPfkw3eAE
         K8ZwgcdWZmCZ/g9RkH6cS1wv9OBaO3R2U+gfGwDvZgCB6PVLk/JQDngq2FYI2edYjoPt
         CB+K4QY6pKDtpwrc3AQ1quCeIqnw3YVZzg10IcizIMVe2qeiCaXoVMQqqA0gsBwD2rgc
         0w7w==
X-Gm-Message-State: AC+VfDyLdjpxKjnvEgYzGVTKGTssMOwsmgzU/zKVerVq+iwGObQIyiKL
        XKbXk35/blJqU+6MjAnCC6BDueCKyZk=
X-Google-Smtp-Source: ACHHUZ78Pg3BkGzGPmSYHX4p0o8GsvauVawqnM2MvLYVMlbjfMHzff/M0dLbGy3T6UMVvwPsFR+XUA==
X-Received: by 2002:a05:6000:1052:b0:301:2452:e4d with SMTP id c18-20020a056000105200b0030124520e4dmr4112978wrx.46.1684599244918;
        Sat, 20 May 2023 09:14:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d62c5000000b003068f5cca8csm2307573wrv.94.2023.05.20.09.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 09:14:04 -0700 (PDT)
Message-Id: <86b3b91d94ec7bb8f296d69ee226cc8bb37c9300.1684599239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
References: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 May 2023 16:13:55 +0000
Subject: [PATCH 07/10] t9100-git-svn-basic: modernize test format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Some tests still use the old format with four spaces indentation.
Standardize the tests to the new format with tab indentation.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t9100-git-svn-basic.sh | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index fea41b3c360..af28b01fefa 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -21,7 +21,7 @@ test_expect_success 'git svn help works anywhere' '
 '
 
 test_expect_success \
-    'initialize git svn' '
+	'initialize git svn' '
 	mkdir import &&
 	(
 		cd import &&
@@ -38,9 +38,9 @@ test_expect_success \
 	rm -rf import &&
 	git svn init "$svnrepo"'
 
-test_expect_success \
-    'import an SVN revision into git' \
-    'git svn fetch'
+test_expect_success 'import an SVN revision into git' '
+	git svn fetch
+'
 
 test_expect_success "checkout from svn" 'svn co "$svnrepo" "$SVN_TREE"'
 
@@ -233,27 +233,26 @@ test_expect_success POSIXPERM,SYMLINKS "$name" '
 '
 
 test_expect_success 'exit if remote refs are ambigious' '
-        git config --add svn-remote.svn.fetch \
+	git config --add svn-remote.svn.fetch \
 		bar:refs/remotes/git-svn &&
 	test_must_fail git svn migrate
 '
 
 test_expect_success 'exit if init-ing a would clobber a URL' '
-        svnadmin create "${PWD}/svnrepo2" &&
-        svn mkdir -m "mkdir bar" "${svnrepo}2/bar" &&
-        git config --unset svn-remote.svn.fetch \
+	svnadmin create "${PWD}/svnrepo2" &&
+	svn mkdir -m "mkdir bar" "${svnrepo}2/bar" &&
+	git config --unset svn-remote.svn.fetch \
 		"^bar:refs/remotes/git-svn$" &&
 	test_must_fail git svn init "${svnrepo}2/bar"
         '
 
-test_expect_success \
-  'init allows us to connect to another directory in the same repo' '
-        git svn init --minimize-url -i bar "$svnrepo/bar" &&
-        git config --get svn-remote.svn.fetch \
-                              "^bar:refs/remotes/bar$" &&
-        git config --get svn-remote.svn.fetch \
-			      "^:refs/remotes/git-svn$"
-        '
+test_expect_success 'init allows us to connect to another directory in the same repo' '
+	git svn init --minimize-url -i bar "$svnrepo/bar" &&
+	git config --get svn-remote.svn.fetch \
+		"^bar:refs/remotes/bar$" &&
+	git config --get svn-remote.svn.fetch \
+		"^:refs/remotes/git-svn$"
+'
 
 test_expect_success 'dcommit $rev does not clobber current branch' '
 	git svn fetch -i bar &&
-- 
gitgitgadget

