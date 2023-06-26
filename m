Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC08EB64DA
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 15:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjFZPLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 11:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjFZPKs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 11:10:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428242943
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 08:10:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f9189228bcso32211965e9.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 08:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687792200; x=1690384200;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS57SmNhuWm/NfnpXBWUS8XQUhYMepA0axNU0SPkiqU=;
        b=b4x5R6muPl+m+1lubV+21nU/ssb3Etggxfm631d3183E1689hZ81eL+oneusS859o0
         PBoJcacawRmD4Xhc9+KKQfjBfzT+Y+C7CpomGxAVGq8ibLH3uJ68Vxzjh6xnZTDIkZPp
         gYncsNDu8MVNzKTGmb3U915uAGbwvsEouRxGlNf/2pmRbyMjeZ2dx34faJ6VhZME8hEA
         uYPgluiEv7pgRXi2CD7tiiPIK+r/sqbzOavqT4yTPorLMZpYA+R3b8VlAT/wQH5qsyR5
         LyW62d6qidPgcrS42fE5QWORKk+KCMooY8PMGVvSVT/cvcODSntFo3Rcfsm0oIf0yjF+
         UVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687792200; x=1690384200;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bS57SmNhuWm/NfnpXBWUS8XQUhYMepA0axNU0SPkiqU=;
        b=LrO+QkK33CipumJRsZwsY+CFVbTYEdGtwSkF+St0mrOqUnkxajzOP7lyfSsZGMyIC4
         NaCBccHwb8N9vfpFasohJ4zKu8jOBDB76E0hlb5zgG4cYpJT6rp2l2H0MbkpmaiSRJZD
         HY+5ahsLRV1mwbPlBPZchTlEF0/NocI/PnC/G/AvjzhO5gktXRCrYBjG0ORvKs4ReUID
         jTbNXDCI70FovK8LA9DSGEADzUVoXJNtHkbhb6AU48sJmmIMFYAZp70RTVJc33UyWu+m
         +v/iSzmtRagt4fVUi+Pp+HekswOOiDyzc3aCfOdk5ZFSrO1K0TOaGRDx29mhuA3mLn/o
         teRg==
X-Gm-Message-State: AC+VfDyutxXfpo+Fi+9oWX+YwzrHVHPHa3j7tWXN4HECdYOkR7xKneQj
        TLGzj08r+QxeNIwfCOIPENhHKu0vXuc=
X-Google-Smtp-Source: ACHHUZ6/weWglZyeouJtv6bS3b69VVrdu+xaLGWcckxzPahbV1tfZGiYqLgbvxz/3u1xsfbxN27CMQ==
X-Received: by 2002:a05:6000:1a42:b0:30f:c94e:88f6 with SMTP id t2-20020a0560001a4200b0030fc94e88f6mr9325426wry.0.1687792199610;
        Mon, 26 Jun 2023 08:09:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b00307a86a4bcesm7685174wrz.35.2023.06.26.08.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:09:59 -0700 (PDT)
Message-Id: <9121e027fb9f157878a9624ce6c834b69cd38472.1687792197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1548.git.1687792197.gitgitgadget@gmail.com>
References: <pull.1548.git.1687792197.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 15:09:57 +0000
Subject: [PATCH 2/2] for-each-ref: add --count-matches option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com, me@ttaylorr.com,
        mjcheetham@outlook.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

In order to count references of different types based on their initial
prefixes, there are two current approaches:

 1. Run 'git for-each-ref' on all refs and parse the output to count
    those that match each prefix.

 2. Run 'git for-each-ref "prefix/"' and pipe that output to 'wc -l' to
    count the number of output lines.

Each of these approaches is wasteful as it requires sending the list of
matching reference names across a pipe plus the cost of parsing that
output.

Instead, it would be helpful to have a Git command that counts the
number of refs matching a list of patterns.

This change adds a new mode, '--count-matches' to 'git for-each-ref' so
we can make use of the existing infrastructure around parsing refspecs
in the correct places. '--count' is already taken as a "maximum number"
of refs to output.

An alternative approach could be to make a brand-new builtin that is
focused on counting ref matches. This would involve duplicating a bit of
code around parsing refpecs, but would not be terribly difficult. The
actual overlap of implementation here with 'git for-each-ref' is small
enough that we could instead extract this elsewhere. My gut feeling is
that this behavior doesn't merit a new builtin.

The implementation is extremely simple: iterate through all references
and compare each ref to each refspec. On a match, increment a counter
value for that refspec.

In the end, output each refspec followed by the count.

If all given refspecs were prefixes, then it is tempting to instead use
a counting behavior that we can use in things like "how many OIDs start
with this short hex string?" Navigating to the start and end of the
range of refs starting with that prefix is possible in the packed-refs
file. However, the records do not have a constant size so we cannot
infer the number of references in that range using the current format.
(Perhaps, in the future we will have a ref storage system that allows
this kind of counting to be easy to do in O(log N) time.)

A new performance test is included to check the performance of iterating
through these references and counting them appropriately. This presents
a 3x improvement over the trivial piping through to 'wc -l', and that
assumes there is a single pattern to match instead of multiple. We can
see that testing three patterns sequentially adds to the total time, but
doing a single process with --count-match continues to be as fast. (It's
difficult to tell since it _also_ matches the sum of the three for this
example repo.)

Test                                                         this tree
----------------------------------------------------------------------------
1501.2: count refs/heads/: git for-each-ref | wc -l          0.01(0.00+0.01)
1501.3: count refs/heads/: git for-each-ref --count-match    0.00(0.00+0.00)
1501.4: count refs/tags/: git for-each-ref | wc -l           0.02(0.00+0.02)
1501.5: count refs/tags/: git for-each-ref --count-match     0.00(0.00+0.00)
1501.6: count refs/remotes: git for-each-ref | wc -l         0.15(0.08+0.07)
1501.7: count refs/remotes: git for-each-ref --count-match   0.04(0.01+0.02)
1501.8: count all patterns: git for-each-ref | wc -l         0.18(0.08+0.10)
1501.9: count all patterns: git for-each-ref --count-match   0.04(0.02+0.02)

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-for-each-ref.txt |  5 ++++
 builtin/for-each-ref.c             | 26 +++++++++++++++--
 ref-filter.c                       | 47 ++++++++++++++++++++++++++++++
 ref-filter.h                       |  7 +++++
 t/perf/p1501-ref-iteration.sh      | 35 ++++++++++++++++++++++
 t/t6300-for-each-ref.sh            | 28 ++++++++++++++++++
 6 files changed, 145 insertions(+), 3 deletions(-)
 create mode 100755 t/perf/p1501-ref-iteration.sh

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 1e215d4e734..74018755ed5 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -42,6 +42,11 @@ OPTIONS
 	`<pattern>`.  This option makes it stop after showing
 	that many refs.
 
+--count-matches::
+	Instead of listing references according to the given format, output
+	the number of references that match each pattern. Incompatible with
+	`--format`, `--sort`, and `--count`.
+
 --sort=<key>::
 	A field name to sort on.  Prefix `-` to sort in
 	descending order of the value.  When unspecified,
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index ce34940e3e6..e3db719bb87 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -50,6 +50,17 @@ static void filter_and_output_refs(struct repository *r,
 	strbuf_release(&output);
 }
 
+static void count_and_output_patterns(struct ref_filter *filter)
+{
+	uint32_t *counts = count_ref_patterns(filter);
+
+	for (int i = 0; filter->name_patterns && filter->name_patterns[i]; i++)
+		fprintf(stdout, "%s %"PRIu32"\n",
+			filter->name_patterns[i], counts[i]);
+
+	free(counts);
+}
+
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
 	struct ref_sorting *sorting;
@@ -60,6 +71,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	struct ref_format format = REF_FORMAT_INIT;
 	int from_stdin = 0;
 	struct strvec vec = STRVEC_INIT;
+	const char *initial_format = "%(objectname) %(objecttype)\t%(refname)";
 
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &format.quote_style,
@@ -72,6 +84,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 			N_("quote placeholders suitably for Tcl"), QUOTE_TCL),
 		OPT_BOOL(0, "omit-empty",  &omit_empty,
 			N_("do not output a newline after empty formatted refs")),
+		OPT_BOOL(0, "count-matches", &count_matches,
+			N_("output number of references matching each pattern instead of any other output")),
 
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
@@ -93,7 +107,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	memset(&array, 0, sizeof(array));
 	memset(&filter, 0, sizeof(filter));
 
-	format.format = "%(objectname) %(objecttype)\t%(refname)";
+	format.format = initial_format;
 
 	git_config(git_default_config, NULL);
 
@@ -102,6 +116,9 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		error("invalid --count argument: `%d'", maxcount);
 		usage_with_options(for_each_ref_usage, opts);
 	}
+	if (count_matches &&
+	    (maxcount || format.format != initial_format || sorting_options.nr))
+		die("--count-matches incompatible with --count, --format, or --sort");
 	if (HAS_MULTI_BITS(format.quote_style)) {
 		error("more than one quoting style?");
 		usage_with_options(for_each_ref_usage, opts);
@@ -131,8 +148,11 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	}
 
 	filter.match_as_path = 1;
-	filter_and_output_refs(the_repository, &array, &filter, &format,
-			       sorting, maxcount, omit_empty);
+	if (count_matches)
+		count_and_output_patterns(&filter);
+	else
+		filter_and_output_refs(the_repository, &array, &filter, &format,
+				       sorting, maxcount, omit_empty);
 
 	ref_array_clear(&array);
 	free_commit_list(filter.with_commit);
diff --git a/ref-filter.c b/ref-filter.c
index 4991cd4f7a8..4e02a4ae98d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2560,6 +2560,53 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	return ret;
 }
 
+struct filter_and_counts {
+	struct ref_filter *filter;
+	uint32_t *counts;
+};
+
+static int ref_filter_counter(const char *refname,
+			      const struct object_id *oid,
+			      int flag, void *cb_data)
+{
+	struct filter_and_counts *fc = cb_data;
+	const char **pattern = fc->filter->name_patterns;
+	size_t namelen = strlen(refname);
+	unsigned flags = fc->filter->ignore_case ? WM_CASEFOLD : 0;
+
+	for (int i = 0; *pattern; i++, pattern++) {
+		const char *p = *pattern;
+		int plen = strlen(p);
+
+		if ((plen <= namelen) &&
+		    !strncmp(refname, p, plen) &&
+		    (refname[plen] == '\0' ||
+		     refname[plen] == '/' ||
+		     p[plen-1] == '/'))
+			fc->counts[i]++;
+		else if (!wildmatch(p, refname, flags))
+			fc->counts[i]++;
+	}
+	return 0;
+}
+
+uint32_t *count_ref_patterns(struct ref_filter *filter)
+{
+	int size = 0;
+	struct filter_and_counts fc = {
+		.filter = filter,
+	};
+
+	while (filter->name_patterns[size])
+		size++;
+
+	CALLOC_ARRAY(fc.counts, size);
+
+	for_each_fullref_in_pattern(filter, ref_filter_counter, &fc);
+
+	return fc.counts;
+}
+
 static int compare_detached_head(struct ref_array_item *a, struct ref_array_item *b)
 {
 	if (!(a->kind ^ b->kind))
diff --git a/ref-filter.h b/ref-filter.h
index 430701cfb76..b7e5a4f6a80 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -141,6 +141,13 @@ char *get_head_description(void);
 /*  Set up translated strings in the output. */
 void setup_ref_filter_porcelain_msg(void);
 
+/*
+ * Iterate over all references, counting how many match each filter
+ * pattern. Returns an array of the counts with the ith count matching the
+ * ith filter->name_pattern entry.
+ */
+uint32_t *count_ref_patterns(struct ref_filter *filter);
+
 /*
  * Print a single ref, outside of any ref-filter. Note that the
  * name must be a fully qualified refname.
diff --git a/t/perf/p1501-ref-iteration.sh b/t/perf/p1501-ref-iteration.sh
new file mode 100755
index 00000000000..609487d20b0
--- /dev/null
+++ b/t/perf/p1501-ref-iteration.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+test_description='Ref iteration performance tests'
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+# Optimize ref backend store
+test_expect_success 'setup' '
+	git pack-refs
+'
+
+for pattern in "refs/heads/" "refs/tags/" "refs/remotes"
+do
+	test_perf "count $pattern: git for-each-ref | wc -l" "
+		git for-each-ref $pattern | wc -l
+	"
+
+	test_perf "count $pattern: git for-each-ref --count-match" "
+		git for-each-ref --count-matches $pattern
+	"
+done
+
+test_perf "count all patterns: git for-each-ref | wc -l" "
+	git for-each-ref refs/heads/ | wc -l &&
+	git for-each-ref refs/tags/ | wc -l &&
+	git for-each-ref refs/remotes/ | wc -l
+"
+
+test_perf "count all patterns: git for-each-ref --count-match" "
+	git for-each-ref --count-matches \
+		refs/heads/ refs/tags/ refs/remotes/
+"
+
+test_done
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 5c00607608a..001382956e4 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -486,6 +486,34 @@ for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --perl"; do
 	"
 done
 
+test_expect_success '--count-matches incompatible with some options' '
+	for opt in "--format=x" "--sort=refname" "--count=10"
+	do
+		test_must_fail git for-each-ref --count-matches $opt refs/heads/ 2>err &&
+		grep "count-matches incompatible" err || return 1
+	done
+'
+
+test_expect_success '--count-matches tallies the number matching each refspec' '
+	git init multi-refs &&
+	test_commit -C multi-refs A &&
+	git -C multi-refs branch A &&
+	git -C multi-refs branch pre/A &&
+	test_commit -C multi-refs --no-tag B &&
+	git -C multi-refs branch B &&
+	git -C multi-refs for-each-ref --count-matches \
+		refs/heads/ refs/heads/pre/ refs/tags/ "*A*" >actual &&
+
+	cat >expect <<-EOF &&
+	refs/heads/ 4
+	refs/heads/pre/ 1
+	refs/tags/ 1
+	*A* 3
+	EOF
+
+	test_cmp expect actual
+'
+
 test_expect_success 'setup for upstream:track[short]' '
 	test_commit two
 '
-- 
gitgitgadget
