Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E58B1F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 23:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbeKLJtJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 04:49:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34114 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732407AbeKLJtI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 04:49:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id y18-v6so3400125pfn.1
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 15:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bp+uiPF7u6e8zrE/l+0ycOjn0Uo7hoBpUBpNOrLQYdo=;
        b=pyl+PqH3GTrOemwr54aUEZ0xTcjCggDoh7VfukBrXBGshHtWKWdMe+XAy+oCqf02Ji
         cv74m8tqmwTy3sb1WEOI3858lBiyF/4X0H0AtBfF92nXwbLdUxbDikskCJ7i6djx+Kq9
         +vbzbUNO7Ns2aYg0zBiDBLGwT2T6I4D8biZEIHvjy4GGa/Cw7VqLTpmUZyhxMFiTmRcd
         WhtHStF49GWLNzPmHiBapwzb12jdB75mg+ojX4o6ctkpVCQpENPbIDh38LSrj0V5KP7K
         o1eRXln5uaa9ij2V5jhVi5Tp67ZO2I4uCm/nS1XD4OwAowD40DX6nbKA3zhjXOYZovg0
         pADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bp+uiPF7u6e8zrE/l+0ycOjn0Uo7hoBpUBpNOrLQYdo=;
        b=MQRvrp8LCz/0pvLXJiXgCJVcMETO+LMvgKKvBmWJUmgIXwTDCJ5da6XCnIqjv5pqSv
         b7snNxcb+4+Q+ClZT6Pw6t3rhPPBtg2JrXMFsOvOeokdUynhbpbCh0M2EelbVBjkOgvK
         CETMsQ7JUVT7iy4D5vEAyeCbFI6woy1L5jzYAvpKp8BQoHuWw5kjRVdxCD4hUtAaliHF
         l9JgmsAaDrrSJFkwh1ffqRRDkZiCd3cWh2GNtMu4OI8jB0wqLzzKhE3vw0BSKe9F8jRF
         RrZGBhOFNvXP7/vyjtQXzYmn4JDp25DHZHOIKeVbx4S94sz4KZItWgFQDjnmnsIHfQV/
         yDRw==
X-Gm-Message-State: AGRZ1gKO9WfS52GqCE0ZvY9YhnJTGv+L1a+3j4J2z705AJZS4YNrCoZT
        sabb7SAnXqoZ1V+xIy3ytxs=
X-Google-Smtp-Source: AJdET5cKiF9J0M22bDnqcLIDsM6tGu6JntMpLCp/DlXfiRmBNO04LWucKNOAsM/L3cRpmQr9vhz84w==
X-Received: by 2002:a62:9a09:: with SMTP id o9-v6mr2054634pfe.229.1541980724459;
        Sun, 11 Nov 2018 15:58:44 -0800 (PST)
Received: from localhost.localdomain (143.sub-174-211-23.myvzw.com. [174.211.23.143])
        by smtp.gmail.com with ESMTPSA id v5sm16954798pgn.5.2018.11.11.15.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Nov 2018 15:58:44 -0800 (PST)
From:   nbelakovski@gmail.com
To:     rafa.almas@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, nbelakovski@gmail.com,
        peff@peff.net
Subject: [PATCH v2 2/2] branch: Mark and colorize a branch differently if it is checked out in a linked worktree
Date:   Sun, 11 Nov 2018 15:58:31 -0800
Message-Id: <20181111235831.44824-3-nbelakovski@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20181111235831.44824-1-nbelakovski@gmail.com>
References: <20180927204049.GA2628@rigel>
 <20181111235831.44824-1-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nickolai Belakovski <nbelakovski@gmail.com>

In order to more clearly display which branches are active, the output
of git branch is modified to mark branches checkout out in a linked
worktree with a "+" and color them in a faint light green (in contrast
to the current branch, which will still be denoted with a "*" and
colored in green)

This is meant to simplify workflows related to worktree, particularly
due to the limitations of not being able to check out the same branch in
two worktrees and the inability to delete a branch checked out in a
worktree. When performing branch operations like checkout and delete, it
would be useful to know more readily if the branches in which the user
is interested are already checked out in a worktree.

The git worktree list command contains the relevant information, however
this is a much less frquently used command than git branch.

Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
---
 builtin/branch.c         | 22 +++++++++++++---------
 color.h                  | 18 ++++++++++++++++++
 t/t3200-branch.sh        |  8 ++++----
 t/t3203-branch-output.sh | 21 +++++++++++++++++++++
 t/test-lib-functions.sh  |  6 ++++++
 5 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0c55f7f065..34f44c82d7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -42,11 +42,12 @@ static struct object_id head_oid;
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
-	GIT_COLOR_NORMAL,       /* PLAIN */
-	GIT_COLOR_RED,          /* REMOTE */
-	GIT_COLOR_NORMAL,       /* LOCAL */
-	GIT_COLOR_GREEN,        /* CURRENT */
-	GIT_COLOR_BLUE,         /* UPSTREAM */
+	GIT_COLOR_NORMAL,             /* PLAIN */
+	GIT_COLOR_RED,                /* REMOTE */
+	GIT_COLOR_NORMAL,             /* LOCAL */
+	GIT_COLOR_GREEN,              /* CURRENT */
+	GIT_COLOR_BLUE,               /* UPSTREAM */
+	GIT_COLOR_FAINT_LIGHT_GREEN,  /* WORKTREE */
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
+	strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)%%(if)%%(worktree)%%(then)+ %s%%(else)  %s%%(end)%%(end)",
+			branch_get_color(BRANCH_COLOR_CURRENT),
+			branch_get_color(BRANCH_COLOR_WORKTREE),
+			branch_get_color(BRANCH_COLOR_LOCAL));
 	strbuf_addf(&remote, "  %s",
 		    branch_get_color(BRANCH_COLOR_REMOTE));
 
diff --git a/color.h b/color.h
index 98894d6a17..857653df73 100644
--- a/color.h
+++ b/color.h
@@ -42,6 +42,24 @@ struct strbuf;
 #define GIT_COLOR_FAINT_BLUE	"\033[2;34m"
 #define GIT_COLOR_FAINT_MAGENTA	"\033[2;35m"
 #define GIT_COLOR_FAINT_CYAN	"\033[2;36m"
+#define GIT_COLOR_LIGHT_RED	"\033[91m"
+#define GIT_COLOR_LIGHT_GREEN	"\033[92m"
+#define GIT_COLOR_LIGHT_YELLOW	"\033[93m"
+#define GIT_COLOR_LIGHT_BLUE	"\033[94m"
+#define GIT_COLOR_LIGHT_MAGENTA	"\033[95m"
+#define GIT_COLOR_LIGHT_CYAN	"\033[96m"
+#define GIT_COLOR_BOLD_LIGHT_RED	"\033[1;91m"
+#define GIT_COLOR_BOLD_LIGHT_GREEN	"\033[1;92m"
+#define GIT_COLOR_BOLD_LIGHT_YELLOW	"\033[1;93m"
+#define GIT_COLOR_BOLD_LIGHT_BLUE	"\033[1;94m"
+#define GIT_COLOR_BOLD_LIGHT_MAGENTA	"\033[1;95m"
+#define GIT_COLOR_BOLD_LIGHT_CYAN	"\033[1;96m"
+#define GIT_COLOR_FAINT_LIGHT_RED	"\033[2;91m"
+#define GIT_COLOR_FAINT_LIGHT_GREEN	"\033[2;92m"
+#define GIT_COLOR_FAINT_LIGHT_YELLOW	"\033[2;93m"
+#define GIT_COLOR_FAINT_LIGHT_BLUE	"\033[2;94m"
+#define GIT_COLOR_FAINT_LIGHT_MAGENTA	"\033[2;95m"
+#define GIT_COLOR_FAINT_LIGHT_CYAN	"\033[2;96m"
 #define GIT_COLOR_BG_RED	"\033[41m"
 #define GIT_COLOR_BG_GREEN	"\033[42m"
 #define GIT_COLOR_BG_YELLOW	"\033[43m"
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 478b82cf9b..e404f6e23c 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -292,7 +292,7 @@ test_expect_success 'git branch --list -v with --abbrev' '
 test_expect_success 'git branch --column' '
 	COLUMNS=81 git branch --column=column >actual &&
 	cat >expected <<\EOF &&
-  a/b/c     bam       foo       l       * master    n         o/p       r
+  a/b/c   + bam       foo       l       * master    n         o/p       r
   abc       bar       j/k       m/m       master2   o/o       q
 EOF
 	test_cmp expected actual
@@ -307,7 +307,7 @@ test_expect_success 'git branch --column with an extremely long branch name' '
 	cat >expected <<EOF &&
   a/b/c
   abc
-  bam
++ bam
   bar
   foo
   j/k
@@ -332,7 +332,7 @@ test_expect_success 'git branch with column.*' '
 	git config --unset column.branch &&
 	git config --unset column.ui &&
 	cat >expected <<\EOF &&
-  a/b/c   bam   foo   l   * master    n     o/p   r
+  a/b/c + bam   foo   l   * master    n     o/p   r
   abc     bar   j/k   m/m   master2   o/o   q
 EOF
 	test_cmp expected actual
@@ -349,7 +349,7 @@ test_expect_success 'git branch -v with column.ui ignored' '
 	cat >expected <<\EOF &&
   a/b/c
   abc
-  bam
++ bam
   bar
   foo
   j/k
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index ee6787614c..06771fac64 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -240,6 +240,27 @@ test_expect_success 'git branch --format option' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success '"add" a worktree' '
+	mkdir worktree_dir &&
+	git worktree add -b master_worktree worktree_dir master
+'
+
+cat >expect <<'EOF'
+* <GREEN>(HEAD detached from fromtag)<RESET>
+  ambiguous<RESET>
+  branch-one<RESET>
+  branch-two<RESET>
+  master<RESET>
++ <FAINT;LGREEN>master_worktree<RESET>
+  ref-to-branch<RESET> -> branch-one
+  ref-to-remote<RESET> -> origin/branch-one
+EOF
+test_expect_success TTY 'worktree colors correct' '
+	test_terminal git branch >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success "set up color tests" '
 	echo "<RED>master<RESET>" >expect.color &&
 	echo "master" >expect.bare &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 78d8c3783b..2831a42a88 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -61,6 +61,12 @@ test_decode_color () {
 			if (n == 45) return "BMAGENTA";
 			if (n == 46) return "BCYAN";
 			if (n == 47) return "BWHITE";
+			if (n == 91) return "LRED";
+			if (n == 92) return "LGREEN";
+			if (n == 93) return "LYELLOW";
+			if (n == 94) return "LBLUE";
+			if (n == 95) return "LMAGENTA";
+			if (n == 96) return "LCYAN";
 		}
 		{
 			while (match($0, /\033\[[0-9;]*m/) != 0) {
-- 
2.14.2

