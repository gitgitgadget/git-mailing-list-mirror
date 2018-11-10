Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC99A1F453
	for <e@80x24.org>; Sat, 10 Nov 2018 12:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbeKJVwD (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 16:52:03 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35737 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbeKJVwC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 16:52:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so3809810ljb.2
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 04:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aEFpChSGxHd6/XbtC9LU4HBGR0yhaCmB9n7cwZXdUAg=;
        b=NPsmR08a8rZRFuL6/aMoEZSYQ2JE2esdjGaxrd09HoQN87d4YxP7NZEpoG4bfQk5Z6
         /nu1PNFK4OciUd3nVObOiH8ShzPrFtNrnlSHTMb3VGVob+bJ9kBzvP/zj5luRrfuCr4u
         PteUd3bTUZWJVfnypPRJmgsuUg7mFWNLfW6IKob+Cy+TmozxzP0t7RITgWgzk2codxWK
         +Jgv0cyeUIIfbzfg2XAfof5Fnlf7WoyGlnvxveBfzMa1L4EbWgzTclEqxO/MI3t3LPSI
         BpJqy9/53KToR/aRhXEjDO8NaAKrcpER49Xap6fzcVsxNP5Yr22uaNeCXwXNWW6Ra1xG
         f8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aEFpChSGxHd6/XbtC9LU4HBGR0yhaCmB9n7cwZXdUAg=;
        b=nF6IGrU6dJIIAQ5JvP8JGrf7cxEClIXz89fbAPzLZhASlq06n4xEQdR2EB81n7Tfwf
         j/lECsc4ydCuMv8iobhcl3vmPoP9Ut6s4qqdSIClYi4sezC6jDbSJdsxc8MMu6wOMiBA
         R5SXzcthY0+1VQDzNc60TrHL6xIV4Xh87SxFDXZSB9P+fJRU1VE4ugd70FufokitkeHv
         tq3KJGT6jLEfdc/h1MXpROIRaWtUBwjnPaRx436qDobL5NVJNbXPxb9MIwqBK+7qJkS3
         rgzEyNcOb19e96Y/Whf7kokzH/Tl4bv4vnOLKqoFtD7IEVBAOC8IDbdainNkSElWCFsO
         okPw==
X-Gm-Message-State: AGRZ1gJ4ZLGzt3mHPCCyLxBj8RE7T1zrL99Ek+OAEQG6Hk7qN5P8RiCG
        jBu4ccnSe0wyJXUOjZEM3mYIUlcc
X-Google-Smtp-Source: AJdET5fsQ16T5CYwtjhhPDSi431/U//CQkzE9Il+YmdrVHcwbZzFHIcTyXT6HbpPalIvFFB+9WHKlg==
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr7514712ljh.59.1541851631862;
        Sat, 10 Nov 2018 04:07:11 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r27-v6sm2023047lja.65.2018.11.10.04.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 04:07:10 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] checkout: disambiguate dwim tracking branches and local files
Date:   Sat, 10 Nov 2018 13:07:07 +0100
Message-Id: <20181110120707.25846-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When checkout dwim is added in [1], it is restricted to only dwim when
certain conditions are met and fall back to default checkout behavior
otherwise. It turns out falling back could be confusing. One of the
conditions to turn

    git checkout frotz

to

    git checkout -b frotz origin/frotz

is that frotz must not exist as a file. But when the user comes to
expect "git checkout frotz" to create the branch "frotz" and there
happens to be a file named "frotz", git's silently reverting "frotz"
file content is not helping. This is reported in Git mailing list [2]
and even used as an example of "Git is bad" elsewhere [3].

We normally try to do the right thing, but when there are multiple
"right things" to do, it's best to leave it to the user to decide.
Check this case, ask the user to use "--" to disambiguate.

[1] 70c9ac2f19 (DWIM "git checkout frotz" to "git checkout -b frotz
    origin/frotz" - 2009-10-18)
[2] https://public-inbox.org/git/CACsJy8B2TVr1g+k+eSQ=pBEO3WN4_LtgLo9gpur8X7Z9GOFL_A@mail.gmail.com/
[3] https://news.ycombinator.com/item?id=18230655

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c       | 15 ++++++++++++---
 t/t2024-checkout-dwim.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index acdafc6e4c..17d48166d1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1079,9 +1079,15 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 */
 		int recover_with_dwim = dwim_new_local_branch_ok;
 
-		if (!has_dash_dash &&
-		    (check_filename(opts->prefix, arg) || !no_wildcard(arg)))
-			recover_with_dwim = 0;
+		/*
+		 * If both refs/remotes/origin/master and the file
+		 * 'master'. Don't blindly go for 'master' file
+		 * because it's ambiguous. Leave it for the user to
+		 * decide.
+		 */
+		int disambi_local_file = !has_dash_dash &&
+			(check_filename(opts->prefix, arg) || !no_wildcard(arg));
+
 		/*
 		 * Accept "git checkout foo" and "git checkout foo --"
 		 * as candidates for dwim.
@@ -1094,6 +1100,9 @@ static int parse_branchname_arg(int argc, const char **argv,
 			const char *remote = unique_tracking_name(arg, rev,
 								  dwim_remotes_matched);
 			if (remote) {
+				if (disambi_local_file)
+					die(_("'%s' could be both a local file and a tracking branch.\n"
+					      "Please use -- to disambiguate"), arg);
 				*new_branch = arg;
 				arg = remote;
 				/* DWIMmed to create local branch, case (3).(b) */
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 69b6774d10..fa0718c730 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -278,4 +278,35 @@ test_expect_success 'loosely defined local base branch is reported correctly' '
 	test_cmp expect actual
 '
 
+test_expect_success 'reject when arg could be part of dwim branch' '
+	git remote add foo file://non-existent-place &&
+	git update-ref refs/remotes/foo/dwim-arg HEAD &&
+	echo foo >dwim-arg &&
+	git add dwim-arg &&
+	echo bar >dwim-arg &&
+	test_must_fail git checkout dwim-arg &&
+	test_must_fail git rev-parse refs/heads/dwim-arg -- &&
+	grep bar dwim-arg
+'
+
+test_expect_success 'disambiguate dwim branch and checkout path (1)' '
+	git update-ref refs/remotes/foo/dwim-arg1 HEAD &&
+	echo foo >dwim-arg1 &&
+	git add dwim-arg1 &&
+	echo bar >dwim-arg1 &&
+	git checkout -- dwim-arg1 &&
+	test_must_fail git rev-parse refs/heads/dwim-arg1 -- &&
+	grep foo dwim-arg1
+'
+
+test_expect_success 'disambiguate dwim branch and checkout path (2)' '
+	git update-ref refs/remotes/foo/dwim-arg2 HEAD &&
+	echo foo >dwim-arg2 &&
+	git add dwim-arg2 &&
+	echo bar >dwim-arg2 &&
+	git checkout dwim-arg2 -- &&
+	git rev-parse refs/heads/dwim-arg2 -- &&
+	grep bar dwim-arg2
+'
+
 test_done
-- 
2.19.1.1231.g84aef82467

