Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A85C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00852077B
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW+t/up6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLJUAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:00:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42163 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfLJUAd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 15:00:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so32248wro.9
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 12:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RjUWfqMLtbjNIPA16XEQPNcw4ayZ9uv9uVm9KQNo/JQ=;
        b=QW+t/up6z+MzyKhFXszBmJKNN8czTsN13+8mBu5pShpAqHX+Fe04JMFmWr4dbI2pmO
         go9esoKCfZzFKG1aDQc99tf2JKONuFeBPAJzTrGsqAc1zVVdgWFkcgyCM2xJvuFAM8Jb
         i1y04mgpgQrl3mzT4wFILdSeJuJSo67msnUVscjjf1bRL6B+ZFFo8YidasPiK09cr8ul
         9k2m69fSdYW/WEF6HoJDWYIs9JBS9u5OC8r+OZ9++BqJkAHlhvXoFJDaTuuDO69Z+quR
         qZPWjpVDCJ3PRoGhLDhZWsDKHFbEoVWCH6po60ihSDqKw4R7jD3itwKnuaj3BsC/gmnz
         lX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RjUWfqMLtbjNIPA16XEQPNcw4ayZ9uv9uVm9KQNo/JQ=;
        b=b+5VkJj295p3iIyyNyILgqB3HYInj6XZr7MkQXY92VA2wtqF44eC3+YzhNTJqk190G
         //+niFECEAQxljGXm8HNkhLwD8ZAAH5f5Y+knefkRDFWLvGdBThsBEO/LbsJujt7yWhh
         x0J/K7fdyjuEYkD/KNCtHyRQieLQWgV9DCRNw+4OFpbMkkUVktobrcUFotiMAdudZkxP
         BOMyzfA1o3XA3n6A/6NWb7FyXHjrUiCR8SN02hzisARbhSYEGTKlac84VPC3TzrZoJZU
         Jt3vestxPHJqhcTXNKK2hGgUwvFPb84ipgN3m9JN5AuxEp/z4dvaNqKayjV5ZPtD2QiB
         ZkSQ==
X-Gm-Message-State: APjAAAVB8p+EvsE5JIWaDErmDPw45B73LbVtA5u4hmJjadEKCoCaEkTe
        mXpsapdm/x7g/IIpQmAEqaiuvrO4
X-Google-Smtp-Source: APXvYqz8n1DKvmhyfr4XkVSTcMDY+FANI46sUVTGZpiUZqg0oFLXnZbabJzTEpi8FXBOIjKABHRxCw==
X-Received: by 2002:a05:6000:12ce:: with SMTP id l14mr5557114wrx.342.1576008029945;
        Tue, 10 Dec 2019 12:00:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z189sm4559181wmc.2.2019.12.10.12.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:00:29 -0800 (PST)
Message-Id: <6d659b230239b530c90fbcc15c9a869f8d5dd5c5.1576008027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
        <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Dec 2019 20:00:20 +0000
Subject: [PATCH v2 1/8] t3011: demonstrate directory traversal failures
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>,
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
 ...common-prefixes-and-directory-traversal.sh | 209 ++++++++++++++++++
 1 file changed, 209 insertions(+)
 create mode 100755 t/t3011-common-prefixes-and-directory-traversal.sh

diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t3011-common-prefixes-and-directory-traversal.sh
new file mode 100755
index 0000000000..54f80c62b8
--- /dev/null
+++ b/t/t3011-common-prefixes-and-directory-traversal.sh
@@ -0,0 +1,209 @@
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
+	cat <<-EOF >.gitignore &&
+	ignored
+	an_ignored_dir/
+	EOF
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
+	cat <<-EOF >expect &&
+	untracked_dir/empty
+	untracked_repo/
+	EOF
+	git ls-files -o untracked_dir untracked_repo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o untracked_dir/ untracked_repo/ recurses into untracked_dir only' '
+	cat <<-EOF >expect &&
+	untracked_dir/empty
+	untracked_repo/
+	EOF
+	git ls-files -o untracked_dir/ untracked_repo/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'git ls-files -o --directory untracked_dir untracked_repo does not recurse' '
+	cat <<-EOF >expect &&
+	untracked_dir/
+	untracked_repo/
+	EOF
+	git ls-files -o --directory untracked_dir untracked_repo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o --directory untracked_dir/ untracked_repo/ does not recurse' '
+	cat <<-EOF >expect &&
+	untracked_dir/
+	untracked_repo/
+	EOF
+	git ls-files -o --directory untracked_dir/ untracked_repo/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files -o .git shows nothing' '
+	git ls-files -o .git >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_failure 'git ls-files -o .git/ shows nothing' '
+	git ls-files -o .git/ >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success FUNNYNAMES 'git ls-files -o untracked_* recurses appropriately' '
+	mkdir "untracked_*" &&
+	>"untracked_*/empty" &&
+
+	cat <<-EOF >expect &&
+	untracked_*/empty
+	untracked_dir/empty
+	untracked_repo/
+	EOF
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
+	cat <<-EOF >expect &&
+	untracked_*/empty
+	untracked_dir/empty
+	untracked_repo/
+	EOF
+	git ls-files -o "untracked_*/" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success FUNNYNAMES 'git ls-files -o --directory untracked_* does not recurse' '
+	cat <<-EOF >expect &&
+	untracked_*/
+	untracked_dir/
+	untracked_repo/
+	EOF
+	git ls-files -o --directory "untracked_*" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success FUNNYNAMES 'git ls-files -o --directory untracked_*/ does not recurse' '
+	cat <<-EOF >expect &&
+	untracked_*/
+	untracked_dir/
+	untracked_repo/
+	EOF
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

