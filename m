Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612771F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfEHLOf (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:14:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36008 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfEHLOe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:14:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id d21so2287292plr.3
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AsmIzKsEHIVz6P7ye1wAFFd42stgcYhE9fALBWycPlU=;
        b=JK/OLACsoA8QXHJmrkh5Gwr491a0zAGqe45NoAlDVK9sUjUYv6+dlO85V6sh7SKSOh
         WBP+WjDOfnmV+YJ1yPTLntfSuY9NY3yrKs4iD9ZWGxMrSim4fNBCFt3P9N+0qmVYJZmd
         qD5pyge16IPBlSwATI13a6AqoQFb67lNvGJmL0QvYj5sPsQbCEVzsKi5Rz0fKOtliFbQ
         eNJgS+aLSjsYnTQ+MUMKa4U5GO2h9YVgYJ6ytyF9maq6Kc8EsmbjMifhx5wk/+JDMs/7
         1obCQIE3yB/q8f1L+AdzF9vvu+ik7Lc0D215Zv6JD6UokDPOlW1DVuD02zfMGPfBx9k7
         ez+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AsmIzKsEHIVz6P7ye1wAFFd42stgcYhE9fALBWycPlU=;
        b=iBaM7w/We0nG5YiL0HIkjs87N+0VcZ0EDAUsDUEH1ySMN1dSu79KzkZyz6ifNhMVgg
         OFxWu7LvMRAKzKE/dd0Ji0Y8lpxjmi/djMn+j1HbVKGstELLlB10+Hr2hHqkJPvU6Crd
         leXgWp/xscbWhCNbElMcUDL9oL1B0uSf7UtHhn66so5nGYFpNOPc4XW130EE2YrBuuGA
         6vqsX1qn8Z8j8GEtLaWheOFETDbHSo/kQibHYh3BBB4UeBb1W5cxMVEyPSDO7ZngzG7T
         55PDOYKFII4VsU0dzD586PI47Nln3yb8Lj4d5JD4Y69baDjZO6KZAaWSAxr2nbocKZ9r
         TJWA==
X-Gm-Message-State: APjAAAVZLQD94umy3La5TsPOPzQ4IubXb+7kcJYywRa1rWtpOscseydj
        Rqr3m7iAkhoPdQ2/AFMlKx/SIU2C
X-Google-Smtp-Source: APXvYqwIFZKIjM1QfxNc1/1Hc9JgL5vt6OrRDAeZ0aLN3oCKbCUNjFlvqwrrD/quvNSHYc49tRuNYg==
X-Received: by 2002:a17:902:9a03:: with SMTP id v3mr47978876plp.27.1557314073144;
        Wed, 08 May 2019 04:14:33 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id s9sm21320641pfe.183.2019.05.08.04.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:14:32 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:14:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 16/19] rev-parseopt: prepare to convert handle_revision_opt()
Date:   Wed,  8 May 2019 18:12:46 +0700
Message-Id: <20190508111249.15262-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
In-Reply-To: <20190508111249.15262-1-pclouds@gmail.com>
References: <20190508111249.15262-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Besides preparing an empty option table to be added in. The table is
also concatenated with diff option table so we don't need
diff_opt_parse() anymore. Merging with pseudo-opt table though will
not happen until we kill parse_revision_opt().

--abbrev has to be converted right away to override the same one from
the diff option parser (which runs first now, if not overriden)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/technical/api-diff.txt |  6 +--
 diff.c                               | 16 -------
 diff.h                               |  1 -
 revision.c                           | 64 +++++++++++++++++++++-------
 revision.h                           |  1 +
 5 files changed, 53 insertions(+), 35 deletions(-)

diff --git a/Documentation/technical/api-diff.txt b/Documentation/technical/api-diff.txt
index 30fc0e9c93..1e4e6968f4 100644
--- a/Documentation/technical/api-diff.txt
+++ b/Documentation/technical/api-diff.txt
@@ -22,9 +22,9 @@ Calling sequence
   sets up the vanilla default.
 
 * Fill in the options structure to specify desired output format, rename
-  detection, etc.  `diff_opt_parse()` can be used to parse options given
-  from the command line in a way consistent with existing git-diff
-  family of programs.
+  detection, etc. `parseopts[]` can be used with parse_options() to
+  parse options from the command line in a way consistent with
+  existing git-diff family of programs.
 
 * Call `diff_setup_done()`; this inspects the options set up so far for
   internal consistency and make necessary tweaking to it (e.g. if
diff --git a/diff.c b/diff.c
index 4d3cf83a27..ef0eb2a160 100644
--- a/diff.c
+++ b/diff.c
@@ -5522,22 +5522,6 @@ static void prep_parse_options(struct diff_options *options)
 	memcpy(options->parseopts, parseopts, sizeof(parseopts));
 }
 
-int diff_opt_parse(struct diff_options *options,
-		   const char **av, int ac, const char *prefix)
-{
-	if (!prefix)
-		prefix = "";
-
-	ac = parse_options(ac, av, prefix, options->parseopts, NULL,
-			   PARSE_OPT_KEEP_DASHDASH |
-			   PARSE_OPT_KEEP_UNKNOWN |
-			   PARSE_OPT_NO_INTERNAL_HELP |
-			   PARSE_OPT_ONE_SHOT |
-			   PARSE_OPT_STOP_AT_NON_OPTION);
-
-	return ac;
-}
-
 int parse_rename_score(const char **cp_p)
 {
 	unsigned long num, scale;
diff --git a/diff.h b/diff.h
index b20cbcc091..c75480a998 100644
--- a/diff.h
+++ b/diff.h
@@ -351,7 +351,6 @@ int git_diff_ui_config(const char *var, const char *value, void *cb);
 #define diff_setup(diffopts) repo_diff_setup(the_repository, diffopts)
 #endif
 void repo_diff_setup(struct repository *, struct diff_options *);
-int diff_opt_parse(struct diff_options *, const char **, int, const char *);
 void diff_setup_done(struct diff_options *);
 int git_config_rename(const char *var, const char *value);
 
diff --git a/revision.c b/revision.c
index dd22ac5c39..f15aa3e62d 100644
--- a/revision.c
+++ b/revision.c
@@ -1611,6 +1611,7 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 }
 
 static void make_pseudo_options(struct rev_info *revs);
+static void make_rev_options(struct rev_info *revs);
 
 void repo_init_revisions(struct repository *r,
 			 struct rev_info *revs,
@@ -1653,6 +1654,7 @@ void repo_init_revisions(struct repository *r,
 
 	revs->notes_opt.use_default_notes = -1;
 	make_pseudo_options(revs);
+	make_rev_options(revs);
 }
 
 static void add_pending_commit_list(struct rev_info *revs,
@@ -1953,6 +1955,38 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
 	add_grep(revs, pattern, GREP_PATTERN_BODY);
 }
 
+static int rev_opt_abbrev(const struct option *opt,
+			  const char *optarg, int unset)
+{
+	struct rev_info *revs = opt->value;
+
+	if (unset) {
+		revs->abbrev = 0;
+	} else if (!optarg) {
+		revs->abbrev = DEFAULT_ABBREV;
+	} else {
+		const unsigned hexsz = the_hash_algo->hexsz;
+
+		revs->abbrev = strtoul(optarg, NULL, 10);
+		if (revs->abbrev < MINIMUM_ABBREV)
+			revs->abbrev = MINIMUM_ABBREV;
+		else if (revs->abbrev > hexsz)
+			revs->abbrev = hexsz;
+	}
+	return 0;
+}
+
+static void make_rev_options(struct rev_info *revs)
+{
+	struct option options[] = {
+		OPT_CALLBACK_F(0, "abbrev", revs, N_("n"),
+			       N_("show the given source prefix instead of \"a/\""),
+			       PARSE_OPT_OPTARG, rev_opt_abbrev),
+		OPT_END(),
+	};
+	revs->options = parse_options_concat(options, revs->diffopt.parseopts);
+}
+
 static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
 			       int *unkc, const char **unkv,
 			       const struct setup_revision_opt* opt)
@@ -1960,7 +1994,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	const char *arg = argv[0];
 	const char *optarg;
 	int argcount;
-	const unsigned hexsz = the_hash_algo->hexsz;
 
 	/* pseudo revision arguments */
 	if (!strcmp(arg, "--all") || !strcmp(arg, "--branches") ||
@@ -1977,6 +2010,18 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		return 1;
 	}
 
+	revs->pseudo_flags = NULL;
+	revs->pseudo_refs = NULL;
+	argc = parse_options(argc, argv, revs->prefix,
+			     revs->options, NULL,
+			     PARSE_OPT_KEEP_DASHDASH |
+			     PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_NO_INTERNAL_HELP |
+			     PARSE_OPT_ONE_SHOT |
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (argc)
+		return argc;
+
 	if ((argcount = parse_long_opt("max-count", argv, &optarg))) {
 		revs->max_count = atoi(optarg);
 		revs->no_walk = 0;
@@ -2243,16 +2288,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->no_commit_id = 1;
 	} else if (!strcmp(arg, "--always")) {
 		revs->always_show_header = 1;
-	} else if (!strcmp(arg, "--no-abbrev")) {
-		revs->abbrev = 0;
-	} else if (!strcmp(arg, "--abbrev")) {
-		revs->abbrev = DEFAULT_ABBREV;
-	} else if (skip_prefix(arg, "--abbrev=", &optarg)) {
-		revs->abbrev = strtoul(optarg, NULL, 10);
-		if (revs->abbrev < MINIMUM_ABBREV)
-			revs->abbrev = MINIMUM_ABBREV;
-		else if (revs->abbrev > hexsz)
-			revs->abbrev = hexsz;
 	} else if (!strcmp(arg, "--abbrev-commit")) {
 		revs->abbrev_commit = 1;
 		revs->abbrev_commit_given = 1;
@@ -2324,10 +2359,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 			BUG("exclude_promisor_objects can only be used when fetch_if_missing is 0");
 		revs->exclude_promisor_objects = 1;
 	} else {
-		int opts = diff_opt_parse(&revs->diffopt, argv, argc, revs->prefix);
-		if (!opts)
-			unkv[(*unkc)++] = arg;
-		return opts;
+		unkv[(*unkc)++] = arg;
+		return 0;
 	}
 	if (revs->graph && revs->track_linear)
 		die("--show-linear-break and --graph are incompatible");
@@ -2861,6 +2894,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
 
 	FREE_AND_NULL(revs->pseudo_options);
+	FREE_AND_NULL(revs->options);
 	return left;
 }
 
diff --git a/revision.h b/revision.h
index cec5215c04..4e840c8eb1 100644
--- a/revision.h
+++ b/revision.h
@@ -283,6 +283,7 @@ struct rev_info {
 	struct option *pseudo_options;
 	int *pseudo_flags;
 	struct ref_store *pseudo_refs;
+	struct option *options;
 };
 
 int ref_excluded(struct string_list *, const char *path);
-- 
2.21.0.1141.gd54ac2cb17

