Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77389C00454
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E362077B
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc3kXQhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLJUAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:00:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40904 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJUAc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 15:00:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so21505912wrn.7
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 12:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CFG5g7XTgaIkJvOp9rtBzFsBf7ppsHbxc/ZlReHj+HY=;
        b=Sc3kXQhkIJ4B/sJNZhu+x5zoczSpkSwYSfJVZjAUGqiYFT2yxZ5avefA/8RpH9rECK
         Wvtn5glVLdKQ4yn4CdeoRbDwLly1yi33ScsZzwiUVrD5E/0L+uHcgmqjTH5LnJC14ESE
         qyA4y+DZ0Nzofro4uLcsfG3XS5kYqW863lW+qPOcb5tdcWe0Da/5xU5i7IwgOpfKOV4+
         eu8oZtzfXNlmshwADGvm8a0LVBSS7N0Tl8mHMrW5mZ8uu/COG5yT3s8l1yPdS/bpFuX8
         ClZhc1YyWk1HV/dMKf7MPQuyeBvBj0/q9oz8vbGi7hxYYxotQR/k5x4/1GU9N1LeBuHv
         fmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CFG5g7XTgaIkJvOp9rtBzFsBf7ppsHbxc/ZlReHj+HY=;
        b=N00ajPPxMAd18xCQxoi1H3k5ljVVIkXPW5QhyfKEwa8D7gAumUEaE62IzbdXeEEDRe
         TD4U2PDD33HGZ+5afK1xZJOofob5+uO6IOJ8Yd4SguzB47OptWknJce+XjgnpNL6HJgC
         TaIsHV/Ooec18CisN5ytJANEwUM2yMquGbe0u3QwFXrOCnIvwwtstNNvsQKIQXuYgppa
         beLISUueL8UXhXv/bSVdO3MMnEhmJyoiwgUdHR4+yK1uUJYdovlbhyJbFIfoS4OdMxid
         0V+iJZxCG0HtO5IYUXeyEDC6y8cE+fOAjm99WEOScnrvUWfMMeeV6/yfVnzKODZkhgWV
         Cd9Q==
X-Gm-Message-State: APjAAAWDWot9Q/ufz40HpTF8kC5WMNZBzTxxcoG5IGhrvgfku2fT+/1N
        Zc4iTAVnFIUpNb0FH9Kdt7lHvg+T
X-Google-Smtp-Source: APXvYqzBWbTQOB0uECz7Mc6lB8pXKmmFkLR++FxG1jVvXg+y9fAclfTZPAU/37WEsS8Rzt+SZptE5w==
X-Received: by 2002:adf:df0e:: with SMTP id y14mr4867740wrl.377.1576008028933;
        Tue, 10 Dec 2019 12:00:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n67sm4496589wmb.8.2019.12.10.12.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:00:28 -0800 (PST)
Message-Id: <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Dec 2019 20:00:19 +0000
Subject: [PATCH v2 0/8] Directory traversal bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     blees@dcon.de, gitster@pobox.com, kyle@kyleam.com,
        sxlijin@gmail.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes multiple fill_directory() bugs, one of them new to 2.24.0
coming from en/clean-nested-with-ignored-topic, the rest having been around
in versions of git going back up to a decade.
See https://lore.kernel.org/git/87fti15agv.fsf@kyleam.com/ for the report
spawning this series.

Changes since v1:

 * Testcase cleanups and tweaks suggested by Denton
 * A tweak to this cover letter so that gitgitgadget will hopefully pick up
   the cc-list. (It apparently needs to be 'Cc' now, instead of 'CC')

Elijah Newren (8):
  t3011: demonstrate directory traversal failures
  Revert "dir.c: make 'git-status --ignored' work within leading
    directories"
  dir: remove stray quote character in comment
  dir: exit before wildcard fall-through if there is no wildcard
  dir: break part of read_directory_recursive() out for reuse
  dir: fix checks on common prefix directory
  dir: synchronize treat_leading_path() and read_directory_recursive()
  dir: consolidate similar code in treat_directory()

 dir.c                                         | 174 +++++++++++----
 ...common-prefixes-and-directory-traversal.sh | 209 ++++++++++++++++++
 t/t7061-wtstatus-ignore.sh                    |   9 +-
 3 files changed, 341 insertions(+), 51 deletions(-)
 create mode 100755 t/t3011-common-prefixes-and-directory-traversal.sh


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-676%2Fnewren%2Fls-files-bug-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-676/newren/ls-files-bug-v2
Pull-Request: https://github.com/git/git/pull/676

Range-diff vs v1:

 1:  4b24ba9966 ! 1:  6d659b2302 t3011: demonstrate directory traversal failures
     @@ -36,8 +36,10 @@
      +	git init untracked_repo &&
      +	>untracked_repo/empty &&
      +
     -+	echo ignored >.gitignore &&
     -+	echo an_ignored_dir/ >>.gitignore &&
     ++	cat <<-EOF >.gitignore &&
     ++	ignored
     ++	an_ignored_dir/
     ++	EOF
      +	mkdir an_ignored_dir &&
      +	mkdir an_untracked_dir &&
      +	>an_ignored_dir/ignored &&
     @@ -114,52 +116,60 @@
      +'
      +
      +test_expect_failure 'git ls-files -o untracked_dir untracked_repo recurses into untracked_dir only' '
     -+	echo untracked_dir/empty >expect &&
     -+	echo untracked_repo/ >>expect &&
     ++	cat <<-EOF >expect &&
     ++	untracked_dir/empty
     ++	untracked_repo/
     ++	EOF
      +	git ls-files -o untracked_dir untracked_repo >actual &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'git ls-files -o untracked_dir/ untracked_repo/ recurses into untracked_dir only' '
     -+	echo untracked_dir/empty >expect &&
     -+	echo untracked_repo/ >>expect &&
     ++	cat <<-EOF >expect &&
     ++	untracked_dir/empty
     ++	untracked_repo/
     ++	EOF
      +	git ls-files -o untracked_dir/ untracked_repo/ >actual &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_failure 'git ls-files -o --directory untracked_dir untracked_repo does not recurse' '
     -+	echo untracked_dir/ >expect &&
     -+	echo untracked_repo/ >>expect &&
     ++	cat <<-EOF >expect &&
     ++	untracked_dir/
     ++	untracked_repo/
     ++	EOF
      +	git ls-files -o --directory untracked_dir untracked_repo >actual &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'git ls-files -o --directory untracked_dir/ untracked_repo/ does not recurse' '
     -+	echo untracked_dir/ >expect &&
     -+	echo untracked_repo/ >>expect &&
     ++	cat <<-EOF >expect &&
     ++	untracked_dir/
     ++	untracked_repo/
     ++	EOF
      +	git ls-files -o --directory untracked_dir/ untracked_repo/ >actual &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'git ls-files -o .git shows nothing' '
     -+	>expect &&
      +	git ls-files -o .git >actual &&
     -+	test_cmp expect actual
     ++	test_must_be_empty actual
      +'
      +
      +test_expect_failure 'git ls-files -o .git/ shows nothing' '
     -+	>expect &&
      +	git ls-files -o .git/ >actual &&
     -+	test_cmp expect actual
     ++	test_must_be_empty actual
      +'
      +
      +test_expect_success FUNNYNAMES 'git ls-files -o untracked_* recurses appropriately' '
      +	mkdir "untracked_*" &&
      +	>"untracked_*/empty" &&
      +
     -+	echo "untracked_*/empty" >expect &&
     -+	echo untracked_dir/empty >>expect &&
     -+	echo untracked_repo/ >>expect &&
     ++	cat <<-EOF >expect &&
     ++	untracked_*/empty
     ++	untracked_dir/empty
     ++	untracked_repo/
     ++	EOF
      +	git ls-files -o "untracked_*" >actual &&
      +	test_cmp expect actual
      +'
     @@ -170,25 +180,31 @@
      +# must match the full path; it doesn't check it for matching a leading
      +# directory.
      +test_expect_failure FUNNYNAMES 'git ls-files -o untracked_*/ recurses appropriately' '
     -+	echo "untracked_*/empty" >expect &&
     -+	echo untracked_dir/empty >>expect &&
     -+	echo untracked_repo/ >>expect &&
     ++	cat <<-EOF >expect &&
     ++	untracked_*/empty
     ++	untracked_dir/empty
     ++	untracked_repo/
     ++	EOF
      +	git ls-files -o "untracked_*/" >actual &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success FUNNYNAMES 'git ls-files -o --directory untracked_* does not recurse' '
     -+	echo "untracked_*/" >expect &&
     -+	echo untracked_dir/ >>expect &&
     -+	echo untracked_repo/ >>expect &&
     ++	cat <<-EOF >expect &&
     ++	untracked_*/
     ++	untracked_dir/
     ++	untracked_repo/
     ++	EOF
      +	git ls-files -o --directory "untracked_*" >actual &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success FUNNYNAMES 'git ls-files -o --directory untracked_*/ does not recurse' '
     -+	echo "untracked_*/" >expect &&
     -+	echo untracked_dir/ >>expect &&
     -+	echo untracked_repo/ >>expect &&
     ++	cat <<-EOF >expect &&
     ++	untracked_*/
     ++	untracked_dir/
     ++	untracked_repo/
     ++	EOF
      +	git ls-files -o --directory "untracked_*/" >actual &&
      +	test_cmp expect actual
      +'
 2:  bfaf7592ee ! 2:  79f2b56174 Revert "dir.c: make 'git-status --ignored' work within leading directories"
     @@ -83,7 +83,9 @@
       
      -test_expect_success 'status prefixed untracked directory with --ignored' '
      +test_expect_failure 'status of untracked directory with --ignored works with or without prefix' '
     -+	git status --porcelain --ignored | grep untracked/ >actual &&
     ++	git status --porcelain --ignored >tmp &&
     ++	grep untracked/ tmp >actual &&
     ++	rm tmp &&
      +	test_cmp expected actual &&
      +
       	git status --porcelain --ignored untracked/ >actual &&
 3:  ea2588e87c = 3:  d6f858cab1 dir: remove stray quote character in comment
 4:  c3220758ab ! 4:  8d2d98eec3 dir: exit before wildcard fall-through if there is no wildcard
     @@ -37,15 +37,15 @@
       
      -test_expect_failure 'git ls-files -o untracked_dir untracked_repo recurses into untracked_dir only' '
      +test_expect_success 'git ls-files -o untracked_dir untracked_repo recurses into untracked_dir only' '
     - 	echo untracked_dir/empty >expect &&
     - 	echo untracked_repo/ >>expect &&
     - 	git ls-files -o untracked_dir untracked_repo >actual &&
     + 	cat <<-EOF >expect &&
     + 	untracked_dir/empty
     + 	untracked_repo/
      @@
       	test_cmp expect actual
       '
       
      -test_expect_failure 'git ls-files -o --directory untracked_dir untracked_repo does not recurse' '
      +test_expect_success 'git ls-files -o --directory untracked_dir untracked_repo does not recurse' '
     - 	echo untracked_dir/ >expect &&
     - 	echo untracked_repo/ >>expect &&
     - 	git ls-files -o --directory untracked_dir untracked_repo >actual &&
     + 	cat <<-EOF >expect &&
     + 	untracked_dir/
     + 	untracked_repo/
 5:  738d9ae4c9 = 5:  d2f5623bd7 dir: break part of read_directory_recursive() out for reuse
 6:  b897095136 ! 6:  9839aca00a dir: fix checks on common prefix directory
     @@ -164,11 +164,11 @@
       	git ls-files -o untracked_repo/ >actual &&
       	test_cmp expect actual
      @@
     - 	test_cmp expect actual
     + 	test_must_be_empty actual
       '
       
      -test_expect_failure 'git ls-files -o .git/ shows nothing' '
      +test_expect_success 'git ls-files -o .git/ shows nothing' '
     - 	>expect &&
       	git ls-files -o .git/ >actual &&
     - 	test_cmp expect actual
     + 	test_must_be_empty actual
     + '
 7:  4f8bf05d26 ! 7:  df7f08886a dir: synchronize treat_leading_path() and read_directory_recursive()
     @@ -104,6 +104,6 @@
       
      -test_expect_failure 'status of untracked directory with --ignored works with or without prefix' '
      +test_expect_success 'status of untracked directory with --ignored works with or without prefix' '
     - 	git status --porcelain --ignored | grep untracked/ >actual &&
     - 	test_cmp expected actual &&
     - 
     + 	git status --porcelain --ignored >tmp &&
     + 	grep untracked/ tmp >actual &&
     + 	rm tmp &&
 8:  2200bf144a = 8:  77b57e44fd dir: consolidate similar code in treat_directory()

-- 
gitgitgadget
