Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E58B11FF40
	for <e@80x24.org>; Sun,  4 Dec 2016 02:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbcLDCx2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 21:53:28 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34308 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbcLDCx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 21:53:27 -0500
Received: by mail-pg0-f66.google.com with SMTP id e9so12181448pgc.1
        for <git@vger.kernel.org>; Sat, 03 Dec 2016 18:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qaoqjg0w5zn1xN3vq5VlwLolRoA/rX3iZmYd8Oosuhg=;
        b=mpoo3tCGoeWIiAuUHkP19Q8a1B+xynrklMNjhjXUBDqMgJXf1HgBDzrJZGYtOhWiDg
         nYR14zBlRQfHkkx4PGi10xqfktpxE3vyiw2kxSO83O/xoRqQxAPnz2S+znhlBSiFbFNu
         b2EliGbGnBsgcNhTDjof99ruP/obTcYzxAQ9FV0yIdOuvqe2rSVEFj0iJ5EGLCgohjn3
         CsnpeAp0jpmVkt5awMc8tuqAAIo+oZsAol5naXbeRD6D24aHBvSi0pmT1YRccd0GtYGC
         aME0kzhYJne+fS2gayqdqlvFcxBz7Julmk5mmIyKbCsKgaB6HsT/qPA/o/zERPL3+Arl
         f4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qaoqjg0w5zn1xN3vq5VlwLolRoA/rX3iZmYd8Oosuhg=;
        b=ZmI9RWhW9yJaqnv2QPVX00tSre5rHaBf0MRr1Po0X1BtygmAQjjoaasGOBOlLFanxC
         bnOoVy7gyy2mPIzhhhVjCmZk8akwxNlzdAUXee3bi0h1FMDrD2yCEAOmOykxMQFBtUbk
         FfGmJZ7MDd8Z3K9mfMqzfrV94sZHA5o+i8ny4+oWSuZ4Xd8LKCiqd2PprGp5zdk+jDTe
         Ec/YX/ggt0J7s5c9bqYFytCrQWxFquO5gP60fOp+j720332s8sUihAzLXv8x1haSLkra
         4AHWkkRsZmYz8LXrD0HlktaLlUUO3HWJwjzl0n2twq2J+zJ6L9eC3uqv/K2vQWL4YU/g
         q6rA==
X-Gm-Message-State: AKaTC03EE8AaNDFXcxEqUniWMraipDK480iEwGgFb8QYAs+Kcs9XEwh1MOH1IkITEqyWPg==
X-Received: by 10.84.217.216 with SMTP id d24mr112161073plj.10.1480819956705;
        Sat, 03 Dec 2016 18:52:36 -0800 (PST)
Received: from ash ([115.73.166.29])
        by smtp.gmail.com with ESMTPSA id 71sm17619417pft.25.2016.12.03.18.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Dec 2016 18:52:35 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 04 Dec 2016 09:52:31 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, karthik.188@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2] tag, branch, for-each-ref: add --ignore-case for sorting and filtering
Date:   Sun,  4 Dec 2016 09:52:25 +0700
Message-Id: <20161204025225.11158-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161130123502.12973-1-pclouds@gmail.com>
References: <20161130123502.12973-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This options makes sorting ignore case, which is great when you have
branches named bug-12-do-something, Bug-12-do-some-more and
BUG-12-do-what and want to group them together. Sorting externally may
not be an option because we lose coloring and column layout from
git-branch and git-tag.

The same could be said for filtering, but it's probably less important
because you can always go with the ugly pattern [bB][uU][gG]-* if you're
desperate.

You can't have case-sensitive filtering and case-insensitive sorting (or
the other way around) with this though. For branch and tag, that should
be no problem. for-each-ref, as a plumbing, might want finer control.
But we can always add --{filter,sort}-ignore-case when there is a need
for it.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Changes are in tests only:

    diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
    index fad79e8..52283df 100755
    --- a/t/t3203-branch-output.sh
    +++ b/t/t3203-branch-output.sh
    @@ -208,6 +208,13 @@ test_expect_success 'sort branches, ignore case' '
     		test_commit initial &&
     		git branch branch-one &&
     		git branch BRANCH-two &&
    +		git branch --list | awk "{print \$NF}" >actual &&
    +		cat >expected <<-\EOF &&
    +		BRANCH-two
    +		branch-one
    +		master
    +		EOF
    +		test_cmp expected actual &&
     		git branch --list -i | awk "{print \$NF}" >actual &&
     		cat >expected <<-\EOF &&
     		branch-one
    diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
    index 2d9cae3..07869b0 100755
    --- a/t/t7004-tag.sh
    +++ b/t/t7004-tag.sh
    @@ -34,6 +34,13 @@ test_expect_success 'sort tags, ignore case' '
     		test_commit initial &&
     		git tag tag-one &&
     		git tag TAG-two &&
    +		git tag -l >actual &&
    +		cat >expected <<-\EOF &&
    +		TAG-two
    +		initial
    +		tag-one
    +		EOF
    +		test_cmp expected actual &&
     		git tag -l -i >actual &&
     		cat >expected <<-\EOF &&
     		initial
    @@ -98,8 +105,8 @@ test_expect_success 'listing all tags if one exists should output that tag' '
     test_expect_success 'listing a tag using a matching pattern should succeed' \
     	'git tag -l mytag'
     
    -test_expect_success 'listing a tag using a matching pattern should succeed' \
    -	'git tag -l --ignore-case MYTAG'
    +test_expect_success 'listing a tag with --ignore-case' \
    +	'test $(git tag -l --ignore-case MYTAG) = mytag'
     
     test_expect_success \
     	'listing a tag using a matching pattern should output that tag' \

 Documentation/git-branch.txt       |  4 ++++
 Documentation/git-for-each-ref.txt |  3 +++
 Documentation/git-tag.txt          |  4 ++++
 builtin/branch.c                   | 23 ++++++++++++++---------
 builtin/for-each-ref.c             |  5 ++++-
 builtin/tag.c                      |  4 ++++
 ref-filter.c                       | 28 +++++++++++++++++++++-------
 ref-filter.h                       |  2 ++
 t/t3203-branch-output.sh           | 29 +++++++++++++++++++++++++++++
 t/t7004-tag.sh                     | 27 +++++++++++++++++++++++++++
 10 files changed, 112 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 1fe7344..5516a47 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -118,6 +118,10 @@ OPTIONS
 	default to color output.
 	Same as `--color=never`.
 
+-i::
+--ignore-case::
+	Sorting and filtering branches are case insensitive.
+
 --column[=<options>]::
 --no-column::
 	Display branch listing in columns. See configuration variable
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f57e69b..6d22974 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -79,6 +79,9 @@ OPTIONS
 	Only list refs which contain the specified commit (HEAD if not
 	specified).
 
+--ignore-case::
+	Sorting and filtering refs are case insensitive.
+
 FIELD NAMES
 -----------
 
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 80019c5..76cfe40 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -108,6 +108,10 @@ OPTIONS
 	variable if it exists, or lexicographic order otherwise. See
 	linkgit:git-config[1].
 
+-i::
+--ignore-case::
+	Sorting and filtering tags are case insensitive.
+
 --column[=<options>]::
 --no-column::
 	Display tag listing in columns. See configuration variable
diff --git a/builtin/branch.c b/builtin/branch.c
index 60cc5c8..36e0a21 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -512,15 +512,6 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
 
-	/*
-	 * If no sorting parameter is given then we default to sorting
-	 * by 'refname'. This would give us an alphabetically sorted
-	 * array with the 'HEAD' ref at the beginning followed by
-	 * local branches 'refs/heads/...' and finally remote-tacking
-	 * branches 'refs/remotes/...'.
-	 */
-	if (!sorting)
-		sorting = ref_default_sorting();
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++)
@@ -645,6 +636,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	const char *new_upstream = NULL;
 	enum branch_track track;
 	struct ref_filter filter;
+	int icase = 0;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 
 	struct option options[] = {
@@ -686,6 +678,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
 			N_("print only branches of the object"), 0, parse_opt_object_name
 		},
+		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_END(),
 	};
 
@@ -723,6 +716,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	if (filter.abbrev == -1)
 		filter.abbrev = DEFAULT_ABBREV;
+	filter.ignore_case = icase;
+
 	finalize_colopts(&colopts, -1);
 	if (filter.verbose) {
 		if (explicitly_enable_column(colopts))
@@ -744,6 +739,16 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
 			filter.kind |= FILTER_REFS_DETACHED_HEAD;
 		filter.name_patterns = argv;
+		/*
+		 * If no sorting parameter is given then we default to sorting
+		 * by 'refname'. This would give us an alphabetically sorted
+		 * array with the 'HEAD' ref at the beginning followed by
+		 * local branches 'refs/heads/...' and finally remote-tacking
+		 * branches 'refs/remotes/...'.
+		 */
+		if (!sorting)
+			sorting = ref_default_sorting();
+		sorting->ignore_case = icase;
 		print_ref_list(&filter, sorting);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 4e9f6c2..df41fa0 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -18,7 +18,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	int i;
 	const char *format = "%(objectname) %(objecttype)\t%(refname)";
 	struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
-	int maxcount = 0, quote_style = 0;
+	int maxcount = 0, quote_style = 0, icase = 0;
 	struct ref_array array;
 	struct ref_filter filter;
 
@@ -43,6 +43,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_MERGED(&filter, N_("print only refs that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only refs that are not merged")),
 		OPT_CONTAINS(&filter.with_commit, N_("print only refs which contain the commit")),
+		OPT_BOOL(0, "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_END(),
 	};
 
@@ -63,6 +64,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	if (!sorting)
 		sorting = ref_default_sorting();
+	sorting->ignore_case = icase;
+	filter.ignore_case = icase;
 
 	/* for warn_ambiguous_refs */
 	git_config(git_default_config, NULL);
diff --git a/builtin/tag.c b/builtin/tag.c
index 50e4ae5..73df728 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -335,6 +335,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct ref_filter filter;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 	const char *format = NULL;
+	int icase = 0;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
@@ -370,6 +371,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			N_("print only tags of the object"), 0, parse_opt_object_name
 		},
 		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
+		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_END()
 	};
 
@@ -401,6 +403,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	}
 	if (!sorting)
 		sorting = ref_default_sorting();
+	sorting->ignore_case = icase;
+	filter.ignore_case = icase;
 	if (cmdmode == 'l') {
 		int ret;
 		if (column_active(colopts)) {
diff --git a/ref-filter.c b/ref-filter.c
index f5f7a70..bd98010 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1231,8 +1231,14 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
  * matches a pattern "refs/heads/mas") or a wildcard (e.g. the same ref
  * matches "refs/heads/mas*", too).
  */
-static int match_pattern(const char **patterns, const char *refname)
+static int match_pattern(const struct ref_filter *filter, const char *refname)
 {
+	const char **patterns = filter->name_patterns;
+	unsigned flags = 0;
+
+	if (filter->ignore_case)
+		flags |= WM_CASEFOLD;
+
 	/*
 	 * When no '--format' option is given we need to skip the prefix
 	 * for matching refs of tags and branches.
@@ -1243,7 +1249,7 @@ static int match_pattern(const char **patterns, const char *refname)
 	       skip_prefix(refname, "refs/", &refname));
 
 	for (; *patterns; patterns++) {
-		if (!wildmatch(*patterns, refname, 0, NULL))
+		if (!wildmatch(*patterns, refname, flags, NULL))
 			return 1;
 	}
 	return 0;
@@ -1255,9 +1261,15 @@ static int match_pattern(const char **patterns, const char *refname)
  * matches a pattern "refs/heads/" but not "refs/heads/m") or a
  * wildcard (e.g. the same ref matches "refs/heads/m*", too).
  */
-static int match_name_as_path(const char **pattern, const char *refname)
+static int match_name_as_path(const struct ref_filter *filter, const char *refname)
 {
+	const char **pattern = filter->name_patterns;
 	int namelen = strlen(refname);
+	unsigned flags = WM_PATHNAME;
+
+	if (filter->ignore_case)
+		flags |= WM_CASEFOLD;
+
 	for (; *pattern; pattern++) {
 		const char *p = *pattern;
 		int plen = strlen(p);
@@ -1280,8 +1292,8 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
 	if (!*filter->name_patterns)
 		return 1; /* No pattern always matches */
 	if (filter->match_as_path)
-		return match_name_as_path(filter->name_patterns, refname);
-	return match_pattern(filter->name_patterns, refname);
+		return match_name_as_path(filter, refname);
+	return match_pattern(filter, refname);
 }
 
 /*
@@ -1536,18 +1548,20 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	struct atom_value *va, *vb;
 	int cmp;
 	cmp_type cmp_type = used_atom[s->atom].type;
+	int (*cmp_fn)(const char *, const char *);
 
 	get_ref_atom_value(a, s->atom, &va);
 	get_ref_atom_value(b, s->atom, &vb);
+	cmp_fn = s->ignore_case ? strcasecmp : strcmp;
 	if (s->version)
 		cmp = versioncmp(va->s, vb->s);
 	else if (cmp_type == FIELD_STR)
-		cmp = strcmp(va->s, vb->s);
+		cmp = cmp_fn(va->s, vb->s);
 	else {
 		if (va->ul < vb->ul)
 			cmp = -1;
 		else if (va->ul == vb->ul)
-			cmp = strcmp(a->refname, b->refname);
+			cmp = cmp_fn(a->refname, b->refname);
 		else
 			cmp = 1;
 	}
diff --git a/ref-filter.h b/ref-filter.h
index 14d435e..fc55fa3 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -29,6 +29,7 @@ struct ref_sorting {
 	struct ref_sorting *next;
 	int atom; /* index into used_atom array (internal) */
 	unsigned reverse : 1,
+		ignore_case : 1,
 		version : 1;
 };
 
@@ -62,6 +63,7 @@ struct ref_filter {
 
 	unsigned int with_commit_tag_algo : 1,
 		match_as_path : 1,
+		ignore_case : 1,
 		detached : 1;
 	unsigned int kind,
 		lines;
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index c6a3ccb..52283df 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -89,6 +89,11 @@ test_expect_success 'git branch --list -v pattern shows branch summaries' '
 	awk "{print \$NF}" <tmp >actual &&
 	test_cmp expect actual
 '
+test_expect_success 'git branch --ignore-case --list -v pattern shows branch summaries' '
+	git branch --list --ignore-case -v BRANCH* >tmp &&
+	awk "{print \$NF}" <tmp >actual &&
+	test_cmp expect actual
+'
 
 test_expect_success 'git branch -v pattern does not show branch summaries' '
 	test_must_fail git branch -v branch*
@@ -196,4 +201,28 @@ test_expect_success 'local-branch symrefs shortened properly' '
 	test_cmp expect actual
 '
 
+test_expect_success 'sort branches, ignore case' '
+	(
+		git init sort-icase &&
+		cd sort-icase &&
+		test_commit initial &&
+		git branch branch-one &&
+		git branch BRANCH-two &&
+		git branch --list | awk "{print \$NF}" >actual &&
+		cat >expected <<-\EOF &&
+		BRANCH-two
+		branch-one
+		master
+		EOF
+		test_cmp expected actual &&
+		git branch --list -i | awk "{print \$NF}" >actual &&
+		cat >expected <<-\EOF &&
+		branch-one
+		BRANCH-two
+		master
+		EOF
+		test_cmp expected actual
+	)
+'
+
 test_done
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 8b0f71a..07869b0 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -27,6 +27,30 @@ test_expect_success 'listing all tags in an empty tree should output nothing' '
 	test $(git tag | wc -l) -eq 0
 '
 
+test_expect_success 'sort tags, ignore case' '
+	(
+		git init sort &&
+		cd sort &&
+		test_commit initial &&
+		git tag tag-one &&
+		git tag TAG-two &&
+		git tag -l >actual &&
+		cat >expected <<-\EOF &&
+		TAG-two
+		initial
+		tag-one
+		EOF
+		test_cmp expected actual &&
+		git tag -l -i >actual &&
+		cat >expected <<-\EOF &&
+		initial
+		tag-one
+		TAG-two
+		EOF
+		test_cmp expected actual
+	)
+'
+
 test_expect_success 'looking for a tag in an empty tree should fail' \
 	'! (tag_exists mytag)'
 
@@ -81,6 +105,9 @@ test_expect_success 'listing all tags if one exists should output that tag' '
 test_expect_success 'listing a tag using a matching pattern should succeed' \
 	'git tag -l mytag'
 
+test_expect_success 'listing a tag with --ignore-case' \
+	'test $(git tag -l --ignore-case MYTAG) = mytag'
+
 test_expect_success \
 	'listing a tag using a matching pattern should output that tag' \
 	'test $(git tag -l mytag) = mytag'
-- 
2.8.2.524.g6ff3d78

