Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D3CC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 00:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3138661BFB
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 00:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhKQBAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 20:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhKQBAG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 20:00:06 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8B5C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 16:57:09 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id lt10-20020a17090b354a00b001a649326aedso2151161pjb.5
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 16:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DfCP7FsPguIce0YnHHzzqxlq868zO7M1fd9aVh/VHdk=;
        b=CmGrqqVlSbR59wEFAOeGY2iXTIp5stKA+uBVnmnFcxHOA1dQRih31bd5JCRb3irCWW
         gQNx23sbH7ot2umwGL/8B5jBWsFQvosJ/cO1pDVvqiV+7GQgThBmN1J9G1uo70Q4YdAA
         oybzLpFZrjvY6PNMRE6OFnpLPqWtP6rT3Zf0USYCwAhG6ct/0A4daMAv8Azg0WVmDw5x
         RquPhUIXFTxQYSASZ2fw+l7GLnRisr5NyiQb6R7DTqkIMedJaCoA2/Uh4jpz7L/yt6uD
         EdGgE7r75JT1IPWWMnI2HSw9Wpmmzdj/R1DxfpfRgy8SXrTbkWZFhA/G2wvz6lfYZjLF
         zE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DfCP7FsPguIce0YnHHzzqxlq868zO7M1fd9aVh/VHdk=;
        b=N4721QgShkdoAGpXhnlB4YYNQUzFnbrGo967LAC/ueNfYISzfzQ0862MORNVBzwUj8
         qpphYT05piouTt1bHMh4Sa+bMYNdz4rRm7xkpJrgwmCYdH6Fd6jBx6dXg8fnTEUNdeE/
         oY6ROcYH9gwQ2RY3Jqo2BGuLV9VY/QDWkGSg0T/jhOqV7sseNzgMU6vEhy/+ltVaL+G+
         VK4Tqbj8tSyesU5YDWKyCPU7PF43rfn2zDzU/l6/3LM3ldYZv+1TqIZ+IqA8qlMEGiXE
         pJ8xEkYwHtJv0D3v9QgxxvHNVJJEvv5WYu1ksMDYrbVmHof3qREocoiG+HMMLW7xaHcB
         GKeA==
X-Gm-Message-State: AOAM5312TqndPiHBCOvAQ7oh6pMCpbkaZBD8vRNKVYG5b0b3OsbLzmG1
        ajdOvjtj6HjZT4JEzFuxh46NIfRD0FoePv/6H5zVbTD35gak0sDqw4BR21GC/ITH+hugUn2ZjVh
        G4/kLMMGLtHKCShhjuM48bNEXaB48mNjUkaREu4T6gIRYqCpebaU3CULvrZoDVloTgyaeN8zSYw
        ==
X-Google-Smtp-Source: ABdhPJwy7Clv9O9RUUCcI24FkVN7JHkc8J3XQwFF1rUOlq/GnNt4vd/wnal4vj1OspYvlef32+i0E5WqWlY32UTIQVw=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:205d:7edd:a3da:3608])
 (user=emilyshaffer job=sendgmr) by 2002:a17:90a:390c:: with SMTP id
 y12mr165293pjb.0.1637110628371; Tue, 16 Nov 2021 16:57:08 -0800 (PST)
Date:   Tue, 16 Nov 2021 16:56:57 -0800
In-Reply-To: <20211117005701.371808-1-emilyshaffer@google.com>
Message-Id: <20211117005701.371808-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20211117005701.371808-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v6 1/5] t7400-submodule-basic: modernize inspect() helper
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the inspect() helper in the submodule-basic test suite was
written, 'git -C <dir>' was added. By using -C, we no longer need a
reference to the base directory for the test. This simplifies callsites,
and will make the addition of other arguments in later patches more
readable.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 t/t7400-submodule-basic.sh | 40 +++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index cb1b8e35db..d69a5c0032 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -107,23 +107,15 @@ test_expect_success 'setup - repository to add submodules to' '
 # generates, which will expand symbolic links.
 submodurl=$(pwd -P)
 
-listbranches() {
-	git for-each-ref --format='%(refname)' 'refs/heads/*'
-}
-
 inspect() {
-	dir=$1 &&
-	dotdot="${2:-..}" &&
-
-	(
-		cd "$dir" &&
-		listbranches >"$dotdot/heads" &&
-		{ git symbolic-ref HEAD || :; } >"$dotdot/head" &&
-		git rev-parse HEAD >"$dotdot/head-sha1" &&
-		git update-index --refresh &&
-		git diff-files --exit-code &&
-		git clean -n -d -x >"$dotdot/untracked"
-	)
+	sub_dir=$1 &&
+
+	git -C "$sub_dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
+	{ git -C "$sub_dir" symbolic-ref HEAD || :; } >head &&
+	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
+	git -C "$sub_dir" update-index --refresh &&
+	git -C "$sub_dir" diff-files --exit-code &&
+	git -C "$sub_dir" clean -n -d -x >untracked
 }
 
 test_expect_success 'submodule add' '
@@ -146,7 +138,7 @@ test_expect_success 'submodule add' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod ../.. &&
+	inspect addtest/submod &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -248,7 +240,7 @@ test_expect_success 'submodule add --branch' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod-branch ../.. &&
+	inspect addtest/submod-branch &&
 	test_cmp expect-heads heads &&
 	test_cmp expect-head head &&
 	test_must_be_empty untracked
@@ -264,7 +256,7 @@ test_expect_success 'submodule add with ./ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotsubmod/frotz ../../.. &&
+	inspect addtest/dotsubmod/frotz &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -280,7 +272,7 @@ test_expect_success 'submodule add with /././ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotslashdotsubmod/frotz ../../.. &&
+	inspect addtest/dotslashdotsubmod/frotz &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -296,7 +288,7 @@ test_expect_success 'submodule add with // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/slashslashsubmod/frotz ../../.. &&
+	inspect addtest/slashslashsubmod/frotz &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -312,7 +304,7 @@ test_expect_success 'submodule add with /.. in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod ../.. &&
+	inspect addtest/realsubmod &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -328,7 +320,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod2 ../.. &&
+	inspect addtest/realsubmod2 &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -359,7 +351,7 @@ test_expect_success 'submodule add in subdirectory' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod3 ../.. &&
+	inspect addtest/realsubmod3 &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
-- 
2.34.0.rc1.387.gb447b232ab-goog

