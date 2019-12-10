Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC3DC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B95E207FF
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKoKjdsO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfLJUAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:00:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46844 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfLJUAd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 15:00:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so21415338wrl.13
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 12:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O5bdAKERjFqZXYHkEGuYnzcy5g3lzmd91EZmqMjMLxI=;
        b=BKoKjdsOHCFdOuxzdR5NQldLoN8eR9v+zF/PXXPy28aiKoQ07QMVZY1+54IBNgYxQj
         aeDh8f1cjHzxZ952y+qiQfPIvf14IjLVK/we/3l2yJuKnSlZFrduJqev0IR/1JGy6i44
         fVyt5q1/i/tcbKfR2QjgQaJ+u+0hjl+3wKMuyZzcEDZYMc8lxWu1AmOw4G9hnfq/3WTT
         UOVGHTMhfmPlH9znmu1eMagNxnNib/rQGr75tAyrEMOnNRyyrXhKR0mlGy75cloUlAnC
         RXzfOamEedyukWYgpQyKM0LOAzqXfhUw7t5FaPvAyP7frFmhQlpLhvrMNyGIVYBmChHW
         1IEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O5bdAKERjFqZXYHkEGuYnzcy5g3lzmd91EZmqMjMLxI=;
        b=CfyLmQkaSjwpi0XUjuwvRNLCjjZ7Kz+YefexOy4g5XT/voEtCtqEj/ezkuFPJ4oYhu
         kh8iZyaF0eEp8rJEmFoaPSXPwRnHPbOfMZc3r6ecdznXBK7QRktiFAnb7UESs/DrfWcY
         wo30aR8WdGVS4EdLVRRrYHz2Cr6re4jCTpdDRFdf01DHAXUzZhvXX7rhqwjtyvPHj6Fu
         i/lQD8+W9haobtcDFVVXzADa3uj2GfUwjGxmA9rhXzCEMh0s62Me2DT/bNz2lGb7o6i8
         FyHySmV9ReDn66vEenjQWYu3YNMmVu8QgV0WIV787NaCmicVc78ChjQ7M3zHEgDEzad8
         z+bQ==
X-Gm-Message-State: APjAAAXOh4hScClHXcgFTH6VckeyhxfeM0ZVQY9hOjtDFyf0W2qziWHA
        wrXpZ4r0gCIQKccUbpoqalAdDyev
X-Google-Smtp-Source: APXvYqyZs6dGOQwFoFh7+9vZJU9UNRbuu8oTV2G9VHLjOUTNWTxR7FY770cMUh3PpZ4Kl74UpXQS9A==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr5327069wrt.367.1576008030887;
        Tue, 10 Dec 2019 12:00:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b67sm4417387wmc.38.2019.12.10.12.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:00:30 -0800 (PST)
Message-Id: <79f2b561742372234a52dc7194dd72026c6e96ec.1576008027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com>
        <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Dec 2019 20:00:21 +0000
Subject: [PATCH v2 2/8] Revert "dir.c: make 'git-status --ignored' work within
 leading directories"
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
 t/t7061-wtstatus-ignore.sh | 9 +++++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

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
index 0c394cf995..84366050da 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -43,11 +43,16 @@ test_expect_success 'status untracked directory with --ignored -u' '
 	test_cmp expected actual
 '
 cat >expected <<\EOF
-?? untracked/uncommitted
+?? untracked/
 !! untracked/ignored
 EOF
 
-test_expect_success 'status prefixed untracked directory with --ignored' '
+test_expect_failure 'status of untracked directory with --ignored works with or without prefix' '
+	git status --porcelain --ignored >tmp &&
+	grep untracked/ tmp >actual &&
+	rm tmp &&
+	test_cmp expected actual &&
+
 	git status --porcelain --ignored untracked/ >actual &&
 	test_cmp expected actual
 '
-- 
gitgitgadget

