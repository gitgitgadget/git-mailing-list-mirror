Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2612BC2BD09
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E302C206D5
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfZ//fWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfLIUrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:47:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33644 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfLIUru (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 15:47:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so17730436wrq.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 12:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SmkT8r7D+uE7MPiEHrIRsFhOlsDnFfVFWAuCwELHwTc=;
        b=HfZ//fWc1vYj1DMXlYWCX1zd0N3yRi/mVl5g9ZH4O7yZ7C1MQ9Z+BYYCLYYIwkb37b
         m/ExYI8utFqp8bHP+AfEScZY/TqmtsDu1LDYaX1L9WvJCtjbVAPAz/KzBP1QW7tPjaJV
         uIOwtbOZXP6pXJz0ztHI1TTmiavaVxGHABd9fy1usNW75hb+JYp0gai8bMfmSpSNNk4O
         LX/4YVtxL5iWdpoXhW0759hMZ+6SwHcya6JkNJLAXV7ZcW9ET2DhvcIdkpGyLH3fqgaR
         9Z/MSFmVU66AYKg1db3W8CLnGan66UDFNTzxvL8KFDY3HNzc4Sav4CcNSPbExw43H6ov
         AbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SmkT8r7D+uE7MPiEHrIRsFhOlsDnFfVFWAuCwELHwTc=;
        b=pIyqSirjJed11afcC05TGyi03bkM4K5tdSL1zlFKoaaIen0ipSfTdg/5G7eJgSoLNi
         /Smpst5vyFL8gagmNOcE5mo32kUobITnFe13ys8AOz4qa3yD9P6yFc3YFnqqg9xY4C1j
         jk6h4sJQK/QUGyD+8CeAEh39CyNyns+imZEwztS1FWoyN2/uUrvAUiQ775N6Bwr/Gm97
         65scDQ4g1EWDmBoaJyyqKzwNC+c35LL6Lg3XWVXF5S9F+LMbLPJ7T6I4iXVhiRpMnrKd
         w6XNqydjMsXTvjeNnqyRMG0//xxSx8Gguo12Fclw9Gdq45hMxnRAULWIJ0CcuTGvmYSd
         G1kA==
X-Gm-Message-State: APjAAAWk2pIFUMHxXkAQgP8oNYICXP4GLhnw9u7tipBGQ6sL1NRCQxN4
        8UKR5yNNS710AZpfdLjGE+iCClCG
X-Google-Smtp-Source: APXvYqxIUjr+h+yAbATOcrSkZ9U8H3ghGGU8AmOy3rWzgWLVCfAZCP3NaZ31qElAeCC87652BiYR3A==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr4246590wrs.213.1575924467737;
        Mon, 09 Dec 2019 12:47:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3sm742319wrn.33.2019.12.09.12.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 12:47:47 -0800 (PST)
Message-Id: <4b24ba9966d41558cc2382d81e6e76b4375b555c.1575924465.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 20:47:38 +0000
Subject: [PATCH 1/8] t3011: demonstrate directory traversal failures
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add several tests demonstrating directory traversal failures of various
sorts in dir.c (and one similar looking test that turns out to be a
git_fnmatch bug).  A lot of these tests look like near duplicates of
each other, but an optimization path in dir.c to pre-descend into a
common prefix and the specialized treatment of trailing slashes in dir.c
mean the tiny differences are sometimes important and potentially cause
different codepaths to be explored.

Of the 7 failing tests, 2 are new to git-2.24.0 (tweaked by side effects
of the en/clean-nested-with-ignored-topic); the other 5 also failed
under git-2.23.0 and earlier.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 ...common-prefixes-and-directory-traversal.sh | 193 ++++++++++++++++++
 1 file changed, 193 insertions(+)
 create mode 100755 t/t3011-common-prefixes-and-directory-traversal.sh

diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t3011-common-prefixes-and-directory-traversal.sh
new file mode 100755
index 0000000000..773d6038d1
--- /dev/null
+++ b/t/t3011-common-prefixes-and-directory-traversal.sh
@@ -0,0 +1,193 @@
+#!/bin/sh
+
+test_description='directory traversal handling, especially with common prefixes'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit hello &&
+
+	>empty &&
+	mkdir untracked_dir &&
+	>untracked_dir/empty &&
+	git init untracked_repo &&
+	>untracked_repo/empty &&
+
+	echo ignored >.gitignore &&
+	echo an_ignored_dir/ >>.gitignore &&
+	mkdir an_ignored_dir &&
+	mkdir an_untracked_dir &&
+	>an_ignored_dir/ignored &&
+	>an_ignored_dir/untracked &&
+	>an_untracked_dir/ignored &&
+	>an_untracked_dir/untracked
+'
+
+test_expect_success 'git ls-files -o shows the right entries' '
+	cat <<-EOF >expect &&
+	.gitignore
+	actual
+	an_ignored_dir/ignored
+	an_ignored_dir/untracked
+	an_untracked_dir/ignored
+	an_untracked_dir/untracked
+	empty
+	expect
+	untracked_dir/empty
+	untracked_repo/
+	EOF
+	git ls-files -o >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o --exclude-standard shows the right entries' '
+	cat <<-EOF >expect &&
+	.gitignore
+	actual
+	an_untracked_dir/untracked
+	empty
+	expect
+	untracked_dir/empty
+	untracked_repo/
+	EOF
+	git ls-files -o --exclude-standard >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o untracked_dir recurses' '
+	echo untracked_dir/empty >expect &&
+	git ls-files -o untracked_dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o untracked_dir/ recurses' '
+	echo untracked_dir/empty >expect &&
+	git ls-files -o untracked_dir/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o --directory untracked_dir does not recurse' '
+	echo untracked_dir/ >expect &&
+	git ls-files -o --directory untracked_dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'git ls-files -o --directory untracked_dir/ does not recurse' '
+	echo untracked_dir/ >expect &&
+	git ls-files -o --directory untracked_dir/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o untracked_repo does not recurse' '
+	echo untracked_repo/ >expect &&
+	git ls-files -o untracked_repo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'git ls-files -o untracked_repo/ does not recurse' '
+	echo untracked_repo/ >expect &&
+	git ls-files -o untracked_repo/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'git ls-files -o untracked_dir untracked_repo recurses into untracked_dir only' '
+	echo untracked_dir/empty >expect &&
+	echo untracked_repo/ >>expect &&
+	git ls-files -o untracked_dir untracked_repo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o untracked_dir/ untracked_repo/ recurses into untracked_dir only' '
+	echo untracked_dir/empty >expect &&
+	echo untracked_repo/ >>expect &&
+	git ls-files -o untracked_dir/ untracked_repo/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'git ls-files -o --directory untracked_dir untracked_repo does not recurse' '
+	echo untracked_dir/ >expect &&
+	echo untracked_repo/ >>expect &&
+	git ls-files -o --directory untracked_dir untracked_repo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o --directory untracked_dir/ untracked_repo/ does not recurse' '
+	echo untracked_dir/ >expect &&
+	echo untracked_repo/ >>expect &&
+	git ls-files -o --directory untracked_dir/ untracked_repo/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o .git shows nothing' '
+	>expect &&
+	git ls-files -o .git >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'git ls-files -o .git/ shows nothing' '
+	>expect &&
+	git ls-files -o .git/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success FUNNYNAMES 'git ls-files -o untracked_* recurses appropriately' '
+	mkdir "untracked_*" &&
+	>"untracked_*/empty" &&
+
+	echo "untracked_*/empty" >expect &&
+	echo untracked_dir/empty >>expect &&
+	echo untracked_repo/ >>expect &&
+	git ls-files -o "untracked_*" >actual &&
+	test_cmp expect actual
+'
+
+# It turns out fill_directory returns the right paths, but ls-files' post-call
+# filtering in show_dir_entry() via calling dir_path_match() which ends up
+# in git_fnmatch() has logic for PATHSPEC_ONESTAR that assumes the pathspec
+# must match the full path; it doesn't check it for matching a leading
+# directory.
+test_expect_failure FUNNYNAMES 'git ls-files -o untracked_*/ recurses appropriately' '
+	echo "untracked_*/empty" >expect &&
+	echo untracked_dir/empty >>expect &&
+	echo untracked_repo/ >>expect &&
+	git ls-files -o "untracked_*/" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success FUNNYNAMES 'git ls-files -o --directory untracked_* does not recurse' '
+	echo "untracked_*/" >expect &&
+	echo untracked_dir/ >>expect &&
+	echo untracked_repo/ >>expect &&
+	git ls-files -o --directory "untracked_*" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success FUNNYNAMES 'git ls-files -o --directory untracked_*/ does not recurse' '
+	echo "untracked_*/" >expect &&
+	echo untracked_dir/ >>expect &&
+	echo untracked_repo/ >>expect &&
+	git ls-files -o --directory "untracked_*/" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o consistent between one or two dirs' '
+	git ls-files -o --exclude-standard an_ignored_dir/ an_untracked_dir/ >tmp &&
+	! grep ^an_ignored_dir/ tmp >expect &&
+	git ls-files -o --exclude-standard an_ignored_dir/ >actual &&
+	test_cmp expect actual
+'
+
+# ls-files doesn't have a way to request showing both untracked and ignored
+# files at the same time, so use `git status --ignored`
+test_expect_failure 'git status --ignored shows same files under dir with or without pathspec' '
+	cat <<-EOF >expect &&
+	?? an_untracked_dir/
+	!! an_untracked_dir/ignored
+	EOF
+	git status --porcelain --ignored >output &&
+	grep an_untracked_dir output >expect &&
+	git status --porcelain --ignored an_untracked_dir/ >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
gitgitgadget

