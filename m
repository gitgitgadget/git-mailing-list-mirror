Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBBAC3F68F
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBD420637
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 20:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8YCWngw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLIUru (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:47:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36270 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLIUrt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 15:47:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so780462wma.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 12:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sv8Z1Qvh2PY479+74oo+SraQ5J/zsk70nUicKx+77sg=;
        b=h8YCWngwTRdLDFi72TIXSlpQFFEvz/eelTHpEmQCGmUqeBT1CdT8sprcxfAH/kICjE
         Iu/36PLdx2XfTOup328tVis+sO+mzGT4KTRanx3ynl1oWsag1ikV1xEmWwFhVJXbiB3q
         KEH6nXyO6vpn3casBE1zLb40AyyiBms8WEZAITR7L8sCLgtN6uvzw13+b58QFp1Tgy2N
         sy8ySj0t8C4QJ8+t1AYefXjnCnqFdqTJ7/o42PDg4Tccu4ylZzjnd6QAnFtS3DsgbRbA
         vsmXOTVB+uRApKSTh57TqYzrIej80FzD1wVnNkZ0jGJA1O1jhsQsD5L8KgbJuf7MByjc
         1hZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sv8Z1Qvh2PY479+74oo+SraQ5J/zsk70nUicKx+77sg=;
        b=ilQLfwueT76/g58pYpcJyGNc8n2wJ7ALudjsQYSrEhdyAOw4FADpMCu2h38D6a84eg
         Nt9f2dFAOXN2JlQDiZLcK9tEiJsm3V9qKHwu9H4yuAHduSLjGZ2mdHDgVeAYfTbM9ELw
         SsnxstskwljwHQRu/3RqEcHg7sNXe4ERbT+HCslioodqSRiS7ANtjOkiepbCjSUSZpE9
         +SLrpyap8BpqIPDZw6E5MLUdRqlDBVZNZSrT4GGtle0Jxp8qGl6rH21nvqabQtr9tGrX
         NNTXOPZfU6fkAuqkHVfL8BmaeqJAdVXfB5BnlcHd3meQ8JOAkKE6g5d8hZSlwbHXmMln
         JMtw==
X-Gm-Message-State: APjAAAXAIZD1EQFLuTxxn+k/F2JFsYmGf660YqT9L8SRD5OfxYyMRUIZ
        0hPCQPcteZy8/tmDULm36e8ps5h7
X-Google-Smtp-Source: APXvYqwa2DfQHnHYP0DKdu2BNeqMPkJWVmqx/4FfZNZWVm3GoLbaSoXDQkX52ufP6e1RVtjepo+USg==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr949578wmj.105.1575924468506;
        Mon, 09 Dec 2019 12:47:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v14sm704793wrm.28.2019.12.09.12.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 12:47:48 -0800 (PST)
Message-Id: <bfaf7592ee611f7e9f6fbcf7b1e4ae32f8307548.1575924465.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 20:47:39 +0000
Subject: [PATCH 2/8] Revert "dir.c: make 'git-status --ignored' work within
 leading directories"
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

Commit be8a84c52669 ("dir.c: make 'git-status --ignored' work within
leading directories", 2013-04-15) noted that
   git status --ignored <SOMEPATH>
would not list ignored files and directories within <SOMEPATH> if
<SOMEPATH> was untracked, and modified the behavior to make it show
them.  However, it did so via a hack that broke consistency; it would
show paths under <SOMEPATH> differently than a simple
   git status --ignored | grep <SOMEPATH>
would show them.  A correct fix is slightly more involved, and
complicated slightly by this hack, so we revert this commit (but keep
corrected versions of the testcases) and will later fix the original
bug with a subsequent patch.

Some history may be helpful:

A very, very similar case to the commit we are reverting was raised in
commit 48ffef966c76 ("ls-files: fix overeager pathspec optimization",
2010-01-08); but it actually went in somewhat the opposite direction.  In
that commit, it mentioned how
   git ls-files -o --exclude-standard t/
used to show untracked files under t/ even when t/ was ignored, and then
changed the behavior to stop showing untracked files under an ignored
directory.  More importantly, this commit considered keeping this
behavior but noted that it would be inconsistent with the behavior when
multiple pathspecs were specified and thus rejected it.

The reason for this whole inconsistency when one pathspec is specified
versus zero or two is because common prefixes of pathspecs are sent
through a different set of checks (in treat_leading_path()) than normal
file/directory traversal (those go through read_directory_recursive()
and treat_path()).  As such, for consistency, one needs to check that
both codepaths produce the same result.

Revert commit be8a84c526691667fc04a8241d93a3de1de298ab, except instead
of removing the testcase it added, modify it to check for correct and
consistent behavior.  A subsequent patch in this series will fix the
testcase.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                      | 3 ---
 t/t7061-wtstatus-ignore.sh | 7 +++++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index 61f559f980..0dd5266629 100644
--- a/dir.c
+++ b/dir.c
@@ -2083,14 +2083,12 @@ static int treat_leading_path(struct dir_struct *dir,
 	struct strbuf sb = STRBUF_INIT;
 	int baselen, rc = 0;
 	const char *cp;
-	int old_flags = dir->flags;
 
 	while (len && path[len - 1] == '/')
 		len--;
 	if (!len)
 		return 1;
 	baselen = 0;
-	dir->flags &= ~DIR_SHOW_OTHER_DIRECTORIES;
 	while (1) {
 		cp = path + baselen + !!baselen;
 		cp = memchr(cp, '/', path + len - cp);
@@ -2113,7 +2111,6 @@ static int treat_leading_path(struct dir_struct *dir,
 		}
 	}
 	strbuf_release(&sb);
-	dir->flags = old_flags;
 	return rc;
 }
 
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 0c394cf995..ded7f97181 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -43,11 +43,14 @@ test_expect_success 'status untracked directory with --ignored -u' '
 	test_cmp expected actual
 '
 cat >expected <<\EOF
-?? untracked/uncommitted
+?? untracked/
 !! untracked/ignored
 EOF
 
-test_expect_success 'status prefixed untracked directory with --ignored' '
+test_expect_failure 'status of untracked directory with --ignored works with or without prefix' '
+	git status --porcelain --ignored | grep untracked/ >actual &&
+	test_cmp expected actual &&
+
 	git status --porcelain --ignored untracked/ >actual &&
 	test_cmp expected actual
 '
-- 
gitgitgadget

