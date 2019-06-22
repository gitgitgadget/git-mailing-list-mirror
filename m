Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0DA71F461
	for <e@80x24.org>; Sat, 22 Jun 2019 12:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFVMYb (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jun 2019 08:24:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34852 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVMYb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jun 2019 08:24:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so4947465pfd.2
        for <git@vger.kernel.org>; Sat, 22 Jun 2019 05:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JPUaD2ntaQlcUbPQGYqgXzRa3zcmUc6g8xDi/6xA+C8=;
        b=GeEYbbAMxRXuGGOJ7EVk/YsunPgV2mW0OAj6fTBLQaSMTXKQUIgRUrF0376LJ9DG9S
         DyH+1Yw7GoaA7U1H3NG/aLsBr8IMLZRcA5Pzut5VAOTEk1PN6nXonp2jA50Yko8wvyIf
         /XU0VkYL82JK0QLGukHWMCOdGOIcP+7D2C6ncBGbz6I9Sf+GebVLV855uxAyBSa0xJWu
         TT7dcxkh5bjfCL1If2kG9wvEDs7GIEOKsct4bGOCQETfFas3rQqr1HYtHH57dzEh2bEH
         HgzWCUmm+V0693zwM/ajJBecyPgchGd96SNdvmZcOJUkutGCLO2nhS2ZA/R/YtT6gILr
         XaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JPUaD2ntaQlcUbPQGYqgXzRa3zcmUc6g8xDi/6xA+C8=;
        b=O8EmllK/fZMU+dza9jVxVVtyk8NsTHAT0wXDBoU+dDQIGhAVOV1ZtezZZfHDI4yLMt
         e6mb2yTJbiajMBFsTKdacfrMMqoK8/+5lAw8T8oRdApOTOn8vLg9XUpvGXpxZo/A73Iz
         ncII+NpPyWqnYQCw6Bdu2nahhhbLSK0Fang3czkrhH1PTu1pX1eafvGhwU6NkyBTZQOv
         dXAEoyFT2sjh62teOCm3APPLoNM8FKhWGEpQMe3iYtaqLq1E3WHr77md56C+41rLxF35
         JOkTk/rRpWEFtqFVfz6PrJjycvSCq3VzGyIgdK9bXIAXRyJfe0K4JPVSWS3qM0OgFb1g
         cK+A==
X-Gm-Message-State: APjAAAVJqCONbm4Fn8PpjP/FqJFBU8izMjmLNnN3OURSwBtzTHlwz+8N
        3tk8uxIAdTsYKqWAcpFwdWsSASro
X-Google-Smtp-Source: APXvYqz1cnAYHaDbeY4Dap4xi7w/djjCz+viadt7yN3I74Y27LRwhb2anxIieOTV7AvxzIO3bu/U9g==
X-Received: by 2002:a63:86c7:: with SMTP id x190mr17575371pgd.316.1561206270033;
        Sat, 22 Jun 2019 05:24:30 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id x25sm5661946pfm.48.2019.06.22.05.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 05:24:29 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 22 Jun 2019 19:24:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] rm: add --intent-to-add, to be used with --cached
Date:   Sat, 22 Jun 2019 19:24:17 +0700
Message-Id: <20190622122417.28178-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An index entry serves two purposes: to keep the content to be committed,
and to mark that the same path on worktree is tracked. When

    git rm --cached foo

is called and there is "foo" in worktree, its status is changed from
tracked to untracked. Which I think is not intended, at least from the
user perspective because we almost always tell people "Git is about the
content" (*).

Add --intent-to-add, which will replace the current index entry with an
intent-to-add one. "git commit -m gone" will record "foo" gone, while
"git commit -am not-gone" will ignore the index as usual and keep "foo".
Before this, "commit -am" will also remove "foo".

While I think --intent-to-add (and also the one in git-reset) should be
the default behavior, changing it flip the test suite out because it
relies on the current behavior. Let's leave that for later. At least
having the ability to just remove the staged content is the right thing
to do.

(*) From the developer perspective, keeping the tool dumb actually
    sounds good. When you tell git to remove something from the index,
    it should go do just that, no trying to be clever. But that's more
    suitable for plumbing commands like update-index than rm, in my
    opinion.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 This occurred to me while adding intent-to-add support to git-restore.
 It's not related to nd/switch-and-restore though and I originally
 wanted to make it default, so I post it separately here.

 Documentation/git-rm.txt |  6 ++++++
 builtin/rm.c             | 10 ++++++++--
 t/t3600-rm.sh            |  9 +++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index b5c46223c4..aa0aa6063f 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -60,6 +60,12 @@ OPTIONS
 	Working tree files, whether modified or not, will be
 	left alone.
 
+--intent-to-add::
+--no-intent-to-add::
+	When `--cached` is used, if the given path also exist as a
+	working tree file, the index is updated to record the fact
+	that the path will be added later, similar to `git add -N`.
+
 --ignore-unmatch::
 	Exit with a zero status even if no files matched.
 
diff --git a/builtin/rm.c b/builtin/rm.c
index be8edc6d1e..135bc4b76e 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -235,12 +235,14 @@ static int check_local_mod(struct object_id *head, int index_only)
 }
 
 static int show_only = 0, force = 0, index_only = 0, recursive = 0, quiet = 0;
-static int ignore_unmatch = 0;
+static int ignore_unmatch = 0, intent_to_add = 0;
 
 static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
 	OPT__QUIET(&quiet, N_("do not list removed files")),
 	OPT_BOOL( 0 , "cached",         &index_only, N_("only remove from the index")),
+	OPT_BOOL( 0 , "intent-to-add",  &intent_to_add,
+		  N_("record that the path will be added later if needed")),
 	OPT__FORCE(&force, N_("override the up-to-date check"), PARSE_OPT_NOCOMPLETE),
 	OPT_BOOL('r', NULL,             &recursive,  N_("allow recursive removal")),
 	OPT_BOOL( 0 , "ignore-unmatch", &ignore_unmatch,
@@ -262,7 +264,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (!argc)
 		usage_with_options(builtin_rm_usage, builtin_rm_options);
 
-	if (!index_only)
+	if (!index_only || intent_to_add)
 		setup_work_tree();
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
@@ -344,6 +346,10 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 		if (remove_file_from_cache(path))
 			die(_("git rm: unable to remove %s"), path);
+
+		if (index_only && intent_to_add && file_exists(path) &&
+		    add_file_to_index(the_repository->index, path, ADD_CACHE_INTENT))
+			error(_("failed to mark '%s' as intent-to-add"), path);
 	}
 
 	if (show_only)
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 85ae7dc1e4..04233b7dc4 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -34,6 +34,15 @@ test_expect_success 'Test that git rm foo succeeds' '
 	git rm --cached foo
 '
 
+test_expect_success 'Test that git rm --cached --intent-to-add foo succeeds' '
+	echo content >foo &&
+	git add foo &&
+	git rm --cached --intent-to-add foo &&
+	git diff --summary -- foo >actual &&
+	echo " create mode 100644 foo" >expected &&
+	test_cmp expected actual
+'
+
 test_expect_success 'Test that git rm --cached foo succeeds if the index matches the file' '
 	echo content >foo &&
 	git add foo &&
-- 
2.22.0.rc0.322.g2b0371e29a

