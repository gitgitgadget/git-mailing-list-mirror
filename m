Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 408211F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbeKJPdU (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:20 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43324 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbeKJPdT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:19 -0500
Received: by mail-lj1-f194.google.com with SMTP id g26-v6so3360195lja.10
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3U/VHgu1m1UZ2HvkycLdKlyeEQ/MvjTZk00QnKL6EUI=;
        b=Q2lTOleD89hjUOx44ggmwIFIR9YxJPZzYWqSA5bfLoYDpFzxb6NI3Xk750YqbVHGX8
         8A9nuEU8vDhC+3ypo4UetrRz+Qeo76ruBLorkT7RXe1J28dE7iCyFWcOyshpZdTGhkWl
         FUz8p0sP8EQpJIpVDQRMQAm66dZv7rlheo36AmSlc/lQvsKSebRnOQrJPARRzdMoSfhh
         MGRrVy4H4HJJPRzIfChUGMb9r+VnNFMHMlgsOWzVLOLOeKvDDQ5npCDSa4gBGIOm2MyZ
         MHY/afq4+cCPr8KukBDlPA1sI3DlQdgDUrH3TTpJ8Rs/Uexk0f3gQIWFvdCu3SZGiqdT
         ilXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3U/VHgu1m1UZ2HvkycLdKlyeEQ/MvjTZk00QnKL6EUI=;
        b=HDG/G+Y7dgBdyJPAEn3ZOALnoKrMw4laA/A8jFZs47yTRW+kpDakwlgLAnYipAHI1b
         DzbyjDPJuTpKa5OLdP88fZdM5Iv+K1T/liCoxOOPbBECbgQo/l29sv3BsWwBq3cYZhsZ
         ESduQbYSZZYhEwlWahgItF/REVQ12iC9UR/y6IafjsT2YtaX7WsUJXeuBOPLcVX3O5GG
         84OGy++KeS679OPzPGoc8av0xv8sxyeWJgqcPdln2/MtXPGKyqv8rygxGX7VotGZXP9c
         qYJzG7miAdBdcpJ4t8QTRFXwUqFDNxV/acJKl/YgeKJJecDU3nlBUDIM0RbCvwIW+QDA
         AO6A==
X-Gm-Message-State: AGRZ1gJD2ur1BzgP4Awsf9Jil084QO7PV8h446Mm7dRV99I84b8KAvYb
        DAFvdXDbWf6gdlBNAMMo5oRefLsu
X-Google-Smtp-Source: AJdET5fIHzmrrx0ifTZbhejjvw46hacg+KdZIpExdInZA0lniR/Th0aFvPu0ZPuCo7wjwg6h1SIDGA==
X-Received: by 2002:a2e:9d05:: with SMTP id t5-v6mr7273211lji.57.1541828970922;
        Fri, 09 Nov 2018 21:49:30 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:30 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 11/22] bisect.c: remove the_repository reference
Date:   Sat, 10 Nov 2018 06:48:59 +0100
Message-Id: <20181110054910.10568-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com>
References: <20181110054910.10568-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 bisect.c                 | 48 +++++++++++++++++++++++-----------------
 bisect.h                 |  5 ++++-
 builtin/bisect--helper.c |  2 +-
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/bisect.c b/bisect.c
index 487675c672..4c1b80bff6 100644
--- a/bisect.c
+++ b/bisect.c
@@ -626,14 +626,15 @@ static struct commit_list *managed_skipped(struct commit_list *list,
 	return skip_away(list, count);
 }
 
-static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
+static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
+			     const char *prefix,
 			     const char *bad_format, const char *good_format,
 			     int read_paths)
 {
 	struct argv_array rev_argv = ARGV_ARRAY_INIT;
 	int i;
 
-	repo_init_revisions(the_repository, revs, prefix);
+	repo_init_revisions(r, revs, prefix);
 	revs->abbrev = 0;
 	revs->commit_format = CMIT_FMT_UNSPECIFIED;
 
@@ -723,23 +724,25 @@ static int bisect_checkout(const struct object_id *bisect_rev, int no_checkout)
 	return run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
 }
 
-static struct commit *get_commit_reference(const struct object_id *oid)
+static struct commit *get_commit_reference(struct repository *r,
+					   const struct object_id *oid)
 {
-	struct commit *r = lookup_commit_reference(the_repository, oid);
-	if (!r)
+	struct commit *c = lookup_commit_reference(r, oid);
+	if (!c)
 		die(_("Not a valid commit name %s"), oid_to_hex(oid));
-	return r;
+	return c;
 }
 
-static struct commit **get_bad_and_good_commits(int *rev_nr)
+static struct commit **get_bad_and_good_commits(struct repository *r,
+						int *rev_nr)
 {
 	struct commit **rev;
 	int i, n = 0;
 
 	ALLOC_ARRAY(rev, 1 + good_revs.nr);
-	rev[n++] = get_commit_reference(current_bad_oid);
+	rev[n++] = get_commit_reference(r, current_bad_oid);
 	for (i = 0; i < good_revs.nr; i++)
-		rev[n++] = get_commit_reference(good_revs.oid + i);
+		rev[n++] = get_commit_reference(r, good_revs.oid + i);
 	*rev_nr = n;
 
 	return rev;
@@ -823,12 +826,13 @@ static void check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
 	free_commit_list(result);
 }
 
-static int check_ancestors(int rev_nr, struct commit **rev, const char *prefix)
+static int check_ancestors(struct repository *r, int rev_nr,
+			   struct commit **rev, const char *prefix)
 {
 	struct rev_info revs;
 	int res;
 
-	bisect_rev_setup(&revs, prefix, "^%s", "%s", 0);
+	bisect_rev_setup(r, &revs, prefix, "^%s", "%s", 0);
 
 	bisect_common(&revs);
 	res = (revs.commits != NULL);
@@ -847,7 +851,9 @@ static int check_ancestors(int rev_nr, struct commit **rev, const char *prefix)
  * If a merge base must be tested by the user, its source code will be
  * checked out to be tested by the user and we will exit.
  */
-static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
+static void check_good_are_ancestors_of_bad(struct repository *r,
+					    const char *prefix,
+					    int no_checkout)
 {
 	char *filename = git_pathdup("BISECT_ANCESTORS_OK");
 	struct stat st;
@@ -866,8 +872,8 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 		goto done;
 
 	/* Check if all good revs are ancestor of the bad rev. */
-	rev = get_bad_and_good_commits(&rev_nr);
-	if (check_ancestors(rev_nr, rev, prefix))
+	rev = get_bad_and_good_commits(r, &rev_nr);
+	if (check_ancestors(r, rev_nr, rev, prefix))
 		check_merge_bases(rev_nr, rev, no_checkout);
 	free(rev);
 
@@ -885,12 +891,14 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 /*
  * This does "git diff-tree --pretty COMMIT" without one fork+exec.
  */
-static void show_diff_tree(const char *prefix, struct commit *commit)
+static void show_diff_tree(struct repository *r,
+			   const char *prefix,
+			   struct commit *commit)
 {
 	struct rev_info opt;
 
 	/* diff-tree init */
-	repo_init_revisions(the_repository, &opt, prefix);
+	repo_init_revisions(r, &opt, prefix);
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	opt.abbrev = 0;
 	opt.diff = 1;
@@ -945,7 +953,7 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
  * If no_checkout is non-zero, the bisection process does not
  * checkout the trial commit but instead simply updates BISECT_HEAD.
  */
-int bisect_next_all(const char *prefix, int no_checkout)
+int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
@@ -957,9 +965,9 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	if (read_bisect_refs())
 		die(_("reading bisect refs failed"));
 
-	check_good_are_ancestors_of_bad(prefix, no_checkout);
+	check_good_are_ancestors_of_bad(r, prefix, no_checkout);
 
-	bisect_rev_setup(&revs, prefix, "%s", "^%s", 1);
+	bisect_rev_setup(r, &revs, prefix, "%s", "^%s", 1);
 	revs.limited = 1;
 
 	bisect_common(&revs);
@@ -993,7 +1001,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 		exit_if_skipped_commits(tried, current_bad_oid);
 		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
 			term_bad);
-		show_diff_tree(prefix, revs.commits->item);
+		show_diff_tree(r, prefix, revs.commits->item);
 		/* This means the bisection process succeeded. */
 		exit(10);
 	}
diff --git a/bisect.h b/bisect.h
index 34df209351..821d16e4dd 100644
--- a/bisect.h
+++ b/bisect.h
@@ -2,6 +2,7 @@
 #define BISECT_H
 
 struct commit_list;
+struct repository;
 
 /*
  * Find bisection. If something is found, `reaches` will be the number of
@@ -30,7 +31,9 @@ struct rev_list_info {
 	const char *header_prefix;
 };
 
-extern int bisect_next_all(const char *prefix, int no_checkout);
+extern int bisect_next_all(struct repository *r,
+			   const char *prefix,
+			   int no_checkout);
 
 extern int estimate_bisect_steps(int all);
 
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4b5fadcbe1..417d141c09 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -137,7 +137,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 
 	switch (cmdmode) {
 	case NEXT_ALL:
-		return bisect_next_all(prefix, no_checkout);
+		return bisect_next_all(the_repository, prefix, no_checkout);
 	case WRITE_TERMS:
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
-- 
2.19.1.1231.g84aef82467

