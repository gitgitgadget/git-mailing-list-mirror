Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8045820248
	for <e@80x24.org>; Sat, 16 Mar 2019 01:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfCPBia (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 21:38:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46893 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfCPBia (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 21:38:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id a22so7571009pgg.13
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 18:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1qqn3LRy77vxD0232fOQ2ZHhJEYFv+LPoLGpJdYLriw=;
        b=KkkxsZN3N1p0WeK4S+VAAXd8FPRCXSQQcX1OiQCfRlPMIzl/flmE805zpJbJWzlH7U
         c/a7NLfGaKaIPD/9CWUKoMu+lk2ngjH8G77Sq4aEjfB4NxQhg5NTWI93DoOt964RAavu
         1f4GemFihvJED/eTW4zzS3sWzZOlBF3U/q3Ex4pnZHog47dB3ToT/ReNdcFTUF16fWvW
         KYi9isg6E+kOmv0mIaV0Z6r7RQeEsKfRqLVC9WUS3ybZslrBOlu1wg74mw5ihltQ9dV8
         ksHqnVUIswLZnJxdEZRjssDiNMT+rMllW3/Fi7ERf28HURvSlxScy608bt4pn131mh4G
         /BaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1qqn3LRy77vxD0232fOQ2ZHhJEYFv+LPoLGpJdYLriw=;
        b=Q6NXmWCLz8lk54RJ3JTXSXyEJ3X4edjqRzKDY3G70x7s+PZc7478hAslmz3eoMdWZ6
         bVuIr6OfbOOZcGDhubfvAfIUumXWuWgzI1rlx1kxgDCNw7B4dyoCBHkVaFb1dk+1k6JO
         SkpIMfV98mhr4Q0YcRZ0RzqYZXyEbIao/qXLjDvK5PIvxhWq8lnDuU264o+xwm+/+06k
         EsZ4so3Gznx4a7HThCRsUnWmmK9E30SkG4I5AqUh7y7wXFYgMJ7kmvfW/KcPcG+ZWn3v
         +y2v1Zy+a7KMFrlLs23mEK5CB0GBHSCyQ1jHi32WU9XY7kh9rO8wW7pyqr7ito/MBsBe
         gZ/A==
X-Gm-Message-State: APjAAAU/NPjDwP27QIRD+cNBBt/GUbG90YB+DTe3i9jziAdRE8j4+lCU
        mPabUo7PYnfVOSFoEXJ0pBn9Ajm9
X-Google-Smtp-Source: APXvYqxzSP5DOk0gJRGzp5PEVYWmOmkUZnmy2RvM82ShCaL0Og0UXMQREak8H+VI5mw7g97NkYsQxQ==
X-Received: by 2002:a63:5321:: with SMTP id h33mr6336593pgb.168.1552700308673;
        Fri, 15 Mar 2019 18:38:28 -0700 (PDT)
Received: from localhost.localdomain (173-8-128-22-SFBA.hfc.comcastbusiness.net. [173.8.128.22])
        by smtp.gmail.com with ESMTPSA id b138sm5817623pfb.48.2019.03.15.18.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Mar 2019 18:38:28 -0700 (PDT)
From:   nbelakovski@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, rafa.almas@gmail.com,
        avarab@gmail.com, Nickolai Belakovski <nbelakovski@gmail.com>
Subject: [PATCH v9 2/3] branch: update output to include worktree info
Date:   Fri, 15 Mar 2019 18:38:06 -0700
Message-Id: <20190316013807.38756-3-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20190316013807.38756-1-nbelakovski@gmail.com>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190316013807.38756-1-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

The output of git branch is modified to mark branches checked out in a
linked worktree with a "+" and color them in cyan (in contrast to the
current branch, which will still be denoted with a "*" and colored in green)

This is meant to communicate to the user that the branches that are
marked or colored will behave differently from other branches if the user
attempts to check them out or delete them, since branches checked out in
another worktree cannot be checked out or deleted.

Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
---
 Documentation/git-branch.txt |  6 ++++--
 builtin/branch.c             | 12 ++++++++----
 t/t3200-branch.sh            | 16 +++++++++++-----
 t/t3203-branch-output.sh     | 24 ++++++++++++++++++++++--
 4 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 0cd87ddeff..7d18dffc4b 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -26,8 +26,10 @@ DESCRIPTION
 -----------
 
 If `--list` is given, or if there are no non-option arguments, existing
-branches are listed; the current branch will be highlighted with an
-asterisk.  Option `-r` causes the remote-tracking branches to be listed,
+branches are listed; the current branch will be highlighted in green and
+marked with an asterisk.  Any branches checked out in linked worktrees will
+be highlighted in cyan and marked with a plus sign. Option `-r` causes the
+remote-tracking branches to be listed,
 and option `-a` shows both local and remote branches. If a `<pattern>`
 is given, it is used as a shell wildcard to restrict the output to
 matching branches. If multiple patterns are given, a branch is shown if
diff --git a/builtin/branch.c b/builtin/branch.c
index 4c83055730..350b039063 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -47,6 +47,7 @@ static char branch_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL,       /* LOCAL */
 	GIT_COLOR_GREEN,        /* CURRENT */
 	GIT_COLOR_BLUE,         /* UPSTREAM */
+	GIT_COLOR_CYAN,         /* WORKTREE */
 };
 enum color_branch {
 	BRANCH_COLOR_RESET = 0,
@@ -54,7 +55,8 @@ enum color_branch {
 	BRANCH_COLOR_REMOTE = 2,
 	BRANCH_COLOR_LOCAL = 3,
 	BRANCH_COLOR_CURRENT = 4,
-	BRANCH_COLOR_UPSTREAM = 5
+	BRANCH_COLOR_UPSTREAM = 5,
+	BRANCH_COLOR_WORKTREE = 6
 };
 
 static const char *color_branch_slots[] = {
@@ -64,6 +66,7 @@ static const char *color_branch_slots[] = {
 	[BRANCH_COLOR_LOCAL]	= "local",
 	[BRANCH_COLOR_CURRENT]	= "current",
 	[BRANCH_COLOR_UPSTREAM] = "upstream",
+	[BRANCH_COLOR_WORKTREE] = "worktree",
 };
 
 static struct string_list output = STRING_LIST_INIT_DUP;
@@ -342,9 +345,10 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 	struct strbuf local = STRBUF_INIT;
 	struct strbuf remote = STRBUF_INIT;
 
-	strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %s%%(end)",
-		    branch_get_color(BRANCH_COLOR_CURRENT),
-		    branch_get_color(BRANCH_COLOR_LOCAL));
+	strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)%%(if)%%(worktreepath)%%(then)+ %s%%(else)  %s%%(end)%%(end)",
+			branch_get_color(BRANCH_COLOR_CURRENT),
+			branch_get_color(BRANCH_COLOR_WORKTREE),
+			branch_get_color(BRANCH_COLOR_LOCAL));
 	strbuf_addf(&remote, "  %s",
 		    branch_get_color(BRANCH_COLOR_REMOTE));
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 478b82cf9b..88719cc02c 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -202,18 +202,22 @@ test_expect_success 'git branch -M baz bam should succeed when baz is checked ou
 	git worktree add -f bazdir2 baz &&
 	git branch -M baz bam &&
 	test $(git -C bazdir rev-parse --abbrev-ref HEAD) = bam &&
-	test $(git -C bazdir2 rev-parse --abbrev-ref HEAD) = bam
+	test $(git -C bazdir2 rev-parse --abbrev-ref HEAD) = bam &&
+	rm -r bazdir bazdir2 &&
+	git worktree prune
 '
 
 test_expect_success 'git branch -M baz bam should succeed within a worktree in which baz is checked out' '
 	git checkout -b baz &&
-	git worktree add -f bazdir3 baz &&
+	git worktree add -f bazdir baz &&
 	(
-		cd bazdir3 &&
+		cd bazdir &&
 		git branch -M baz bam &&
 		test $(git rev-parse --abbrev-ref HEAD) = bam
 	) &&
-	test $(git rev-parse --abbrev-ref HEAD) = bam
+	test $(git rev-parse --abbrev-ref HEAD) = bam &&
+	rm -r bazdir &&
+	git worktree prune
 '
 
 test_expect_success 'git branch -M master should work when master is checked out' '
@@ -774,7 +778,9 @@ test_expect_success 'test deleting branch without config' '
 test_expect_success 'deleting currently checked out branch fails' '
 	git worktree add -b my7 my7 &&
 	test_must_fail git -C my7 branch -d my7 &&
-	test_must_fail git branch -d my7
+	test_must_fail git branch -d my7 &&
+	rm -r my7 &&
+	git worktree prune
 '
 
 test_expect_success 'test --track without .fetch entries' '
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index be55148930..ceb74e0826 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -136,11 +136,13 @@ test_expect_success 'git branch `--show-current` works properly with worktrees'
 	branch-two
 	EOF
 	git checkout branch-one &&
-	git worktree add worktree branch-two &&
+	git worktree add worktree_dir branch-two &&
 	{
 		git branch --show-current &&
-		git -C worktree branch --show-current
+		git -C worktree_dir branch --show-current
 	} >actual &&
+	rm -r worktree_dir &&
+	git worktree prune &&
 	test_cmp expect actual
 '
 
@@ -284,6 +286,24 @@ test_expect_success 'git branch --format option' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'worktree colors correct' '
+	cat >expect <<-EOF &&
+	* <GREEN>(HEAD detached from fromtag)<RESET>
+	  ambiguous<RESET>
+	  branch-one<RESET>
+	+ <CYAN>branch-two<RESET>
+	  master<RESET>
+	  ref-to-branch<RESET> -> branch-one
+	  ref-to-remote<RESET> -> origin/branch-one
+	EOF
+	git worktree add worktree_dir branch-two &&
+	git branch --color >actual.raw &&
+	rm -r worktree_dir &&
+	git worktree prune &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success "set up color tests" '
 	echo "<RED>master<RESET>" >expect.color &&
 	echo "master" >expect.bare &&
-- 
2.14.2

