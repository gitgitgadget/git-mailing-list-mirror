Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D6F81F462
	for <e@80x24.org>; Wed, 22 May 2019 00:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfEVAWa (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 20:22:30 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:43630 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfEVAWa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 20:22:30 -0400
Received: by mail-qk1-f202.google.com with SMTP id p190so716216qke.10
        for <git@vger.kernel.org>; Tue, 21 May 2019 17:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sQaME9Q86Ia4lRkeUz2RWTcxX6g9FO7z0lOHX9WVDFU=;
        b=T/QsuouiTHHydGaxi5t2SJ0B/3tahpFmeQKeqFkT4WMKjxmfMwSSWC4sA9BrOEhiRy
         mY8nHb1xHY24WICAyZpDHj3hM41Ms1vVaZVSr9jbxpCHSQ+bYt0CigjNncSv2SfCLvgc
         PcH7AZCphbYz/J77p8QvwM6bZ5SQp5My2u3EHzJW1Zh2WBp5ferIYT9NePiJYiIfbGHB
         oAgmizdouxGrzdiHoew7Sikck/rszioW3U/mjHe+JWIOk5s6YCNDxffm+XAbNHSgt91/
         +GGRcy/0tzPoUOiPLDc/uKNljwocDiXzbGZoPmyYzrF9mSxxj65ffirVjsKzt3MCeurL
         9rdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sQaME9Q86Ia4lRkeUz2RWTcxX6g9FO7z0lOHX9WVDFU=;
        b=GudfhOVMb5pN1PZqVOhoWxqU/SvMtpdcuCm8NqbDLF+LcP7e0Zg2+dzTf2bpBrZ3Rd
         LKv1PqhekQduHjpQn/F+vpPzG+8LTFBLVJR6/6Np3G2UeTamYY3wSpogj759mmjaXSZi
         XiEtwLANthQFUrZHoPL48wpmDSyIrG34jrxg4H/LmDMsIOt1mK0FjvGbU5DhXd9CXrIH
         dribxjgaMpoG3qf3iyMYoeMLmDLfTxB1F6c72VFfVuoxpewIU5JWEWPOlKS4Q6QsE6rH
         Hl48nQV/r0SzruaQH+rbxCQUCo8fFumj74iP8hPpTI4R/0uA+ie3cmiEZLSxeeC+Lpxu
         hhkQ==
X-Gm-Message-State: APjAAAUart/hUEbb6tkRICqjj8LtQLOjhvmORFa3wpEUv+yb3wk9E+sg
        0lj6tw3Wnj6ByzMWXZ6lsKamRlt7QSU=
X-Google-Smtp-Source: APXvYqxqpv0yRVZGOMLsyG0vKIO1X83QJ1cUqoH31Ry1HJfbc5VFblU17fLhqWzMZvMyk6Cg+IsOSW2vdxPt
X-Received: by 2002:ac8:3128:: with SMTP id g37mr73184376qtb.65.1558484548748;
 Tue, 21 May 2019 17:22:28 -0700 (PDT)
Date:   Tue, 21 May 2019 17:21:54 -0700
In-Reply-To: <cover.1558484115.git.matvore@google.com>
Message-Id: <490519da8013a49b27040804c6ef50e42fd8754d.1558484115.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1558484115.git.matvore@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v1 5/5] list-objects-filter-options: allow mult. --filter
From:   Matthew DeVore <matvore@google.com>
To:     jonathantanmy@google.com, jrn@google.com, git@vger.kernel.org,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow combining of multiple filters by simply repeating the --filter
flag. Before this patch, the user had to combine them in a single flag
somewhat awkwardly (e.g. --filter=combine:FOO+BAR), including
URL-encoding the individual filters.

To make this work, in the --filter flag parsing callback, rather than
error out when we detect that the filter_options struct is already
populated, we modify it in-place to contain the added sub-filter. The
existing sub-filter becomes the lhs of the combined filter, and the
next sub-filter becomes the rhs. We also have to URL-encode the LHS and
RHS sub-filters.

We can simplify the operation if the LHS is already a combine: filter.
In that case, we just append the URL-encoded RHS sub-filter to the LHS
spec to get the new spec.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 Documentation/rev-list-options.txt  | 16 +++---
 builtin/fetch-pack.c                |  5 +-
 builtin/rev-list.c                  |  5 +-
 fetch-pack.c                        |  5 +-
 list-objects-filter-options.c       | 83 +++++++++++++++++++++++++----
 list-objects-filter-options.h       |  3 +-
 t/t5616-partial-clone.sh            | 19 +++++++
 t/t6112-rev-list-filters-objects.sh | 38 ++++++++++++-
 transport.c                         |  5 +-
 upload-pack.c                       | 10 +++-
 10 files changed, 164 insertions(+), 25 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 4fb0c4fbb0..2be5f3a6d1 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -731,27 +731,29 @@ specification contained in <path>.
 The form '--filter=tree:<depth>' omits all blobs and trees whose depth
 from the root tree is >= <depth> (minimum depth if an object is located
 at multiple depths in the commits traversed). <depth>=0 will not include
 any trees or blobs unless included explicitly in the command-line (or
 standard input when --stdin is used). <depth>=1 will include only the
 tree and blobs which are referenced directly by a commit reachable from
 <commit> or an explicitly-given object. <depth>=2 is like <depth>=1
 while also including trees and blobs one more level removed from an
 explicitly-given commit or tree.
 +
-The form '--filter=combine:<filter1>+<filter2>+...<filterN>' combines
-several filters. Only objects which are accepted by every filter are
-included. Filters are joined by '{plus}' and individual filters are %-encoded
-(i.e. URL-encoded). Besides the '{plus}' and '%' characters, the following
-characters are reserved and also must be encoded:
-`~!@#$^&*()[]{}\;",<>?`+&#39;&#96;+ as well as all characters with ASCII code
-&lt;= `0x20`, which includes space and newline.
+Multiple '--filter=' flags can be specified to combine filters. Only
+objects which are accepted by every filter are included.
++
+The form '--filter=combine:<filter1>+<filter2>+...<filterN>' can also be
+used to combine filters. Filters are joined by '{plus}' and individual
+filters are %-encoded (i.e. URL-encoded). Besides the '{plus}' and '%'
+characters, the following characters are reserved and also must be
+encoded: `~!@#$^&*()[]{}\;",<>?`+&#39;&#96;+ as well as all characters
+with ASCII code &lt;= `0x20`, which includes space and newline.
 +
 Other arbitrary characters can also be encoded. For instance,
 'combine:tree:3+blob:none' and 'combine:tree%3A2+blob%3Anone' are
 equivalent.
 
 --no-filter::
 	Turn off any previous `--filter=` argument.
 
 --filter-print-omitted::
 	Only useful with `--filter=`; prints a list of the objects omitted
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index dc1485c8aa..cadcb2b915 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -151,21 +151,24 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		}
 		if (!strcmp("--from-promisor", arg)) {
 			args.from_promisor = 1;
 			continue;
 		}
 		if (!strcmp("--no-dependents", arg)) {
 			args.no_dependents = 1;
 			continue;
 		}
 		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
-			parse_list_objects_filter(&args.filter_options, arg);
+			parse_list_objects_filter(
+				&args.filter_options,
+				arg,
+				/*allow_implicit_combine=*/1);
 			continue;
 		}
 		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
 			list_objects_filter_set_no_filter(&args.filter_options);
 			continue;
 		}
 		usage(fetch_pack_usage);
 	}
 	if (deepen_not.nr)
 		args.deepen_not = &deepen_not;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 9f31837d30..e584e7d1ac 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -454,21 +454,24 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		if (!strcmp(arg, "--test-bitmap")) {
 			test_bitmap_walk(&revs);
 			return 0;
 		}
 		if (skip_prefix(arg, "--progress=", &arg)) {
 			show_progress = arg;
 			continue;
 		}
 
 		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
-			parse_list_objects_filter(&filter_options, arg);
+			parse_list_objects_filter(
+				&filter_options,
+				arg,
+				/*allow_implicit_combine=*/1);
 			if (filter_options.choice && !revs.blob_objects)
 				die(_("object filtering requires --objects"));
 			if (filter_options.choice == LOFC_SPARSE_OID &&
 			    !filter_options.sparse_oid_value)
 				die(_("invalid sparse value '%s'"),
 				    filter_options.filter_spec);
 			continue;
 		}
 		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
 			list_objects_filter_set_no_filter(&filter_options);
diff --git a/fetch-pack.c b/fetch-pack.c
index 3f24d0c8a6..c58fd9148a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1661,21 +1661,24 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		/*
 		 * The protocol does not support requesting that only the
 		 * wanted objects be sent, so approximate this by setting a
 		 * "blob:none" filter if no filter is already set. This works
 		 * for all object types: note that wanted blobs will still be
 		 * sent because they are directly specified as a "want".
 		 *
 		 * NEEDSWORK: Add an option in the protocol to request that
 		 * only the wanted objects be sent, and implement it.
 		 */
-		parse_list_objects_filter(&args->filter_options, "blob:none");
+		parse_list_objects_filter(
+			&args->filter_options,
+			"blob:none",
+			/*allow_implicit_combine=*/0);
 	}
 
 	if (version != protocol_v2 && !ref) {
 		packet_flush(fd[1]);
 		die(_("no matching remote head"));
 	}
 	if (version == protocol_v2) {
 		if (shallow->nr)
 			BUG("Protocol V2 does not provide shallows at this point in the fetch");
 		memset(&si, 0, sizeof(si));
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 647b2b220e..a0cc87c62b 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -1,18 +1,19 @@
 #include "cache.h"
 #include "commit.h"
 #include "config.h"
 #include "revision.h"
 #include "argv-array.h"
 #include "list-objects.h"
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
+#include "trace.h"
 
 static int parse_combine_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg,
 	struct strbuf *errbuf);
 
 /*
  * Parse value of the argument to the "filter" keyword.
  * On the command line this looks like:
  *       --filter=<arg>
@@ -229,43 +230,107 @@ static int parse_combine_filter(
 
 cleanup:
 	strbuf_list_free(sub_specs);
 	if (result) {
 		list_objects_filter_release(filter_options);
 		memset(filter_options, 0, sizeof(*filter_options));
 	}
 	return result;
 }
 
-int parse_list_objects_filter(struct list_objects_filter_options *filter_options,
-			      const char *arg)
+static void add_url_encoded(struct strbuf *dest, const char *s)
 {
-	struct strbuf buf = STRBUF_INIT;
-	if (filter_options->choice)
-		die(_("multiple filter-specs cannot be combined"));
-	filter_options->filter_spec = strdup(arg);
-	if (gently_parse_list_objects_filter(filter_options, arg, &buf))
-		die("%s", buf.buf);
+	while (*s) {
+		if (*s <= ' ' || strchr(RESERVED_NON_WS, *s) ||
+			*s == '%' || *s == '+')
+			strbuf_addf(dest, "%%%02X", (int)*s);
+		else
+			strbuf_addf(dest, "%c", *s);
+		s++;
+	}
+}
+
+/*
+ * Returns a new filter-spec string by combining (with combine:) the two
+ * sub-specs. The caller gains ownership of a new string, and lhs and rhs are
+ * not freed.
+ */
+static char *combine_specs(const char *lhs, const char *rhs)
+{
+	struct strbuf combined = STRBUF_INIT;
+	if (starts_with(lhs, "combine:")) {
+		strbuf_addf(&combined, "%s", lhs);
+	} else {
+		strbuf_addf(&combined, "combine:");
+		add_url_encoded(&combined, lhs);
+	}
+	strbuf_addf(&combined, "+");
+
+	add_url_encoded(&combined, rhs);
+	trace_printf("Generated composite filter-spec: %s\n", combined.buf);
+	return strbuf_detach(&combined, NULL);
+}
+
+int parse_list_objects_filter(
+	struct list_objects_filter_options *filter_options,
+	const char *arg,
+	int allow_implicit_combine)
+{
+	struct strbuf errbuf = STRBUF_INIT;
+	if (filter_options->choice) {
+		struct list_objects_filter_options *lhs;
+
+		if (!allow_implicit_combine)
+			die(_("multiple filter-specs cannot be combined"));
+
+		lhs = xcalloc(1, sizeof(*lhs));
+		*lhs = *filter_options;
+		memset(filter_options, 0, sizeof(*filter_options));
+
+		filter_options->lhs = lhs;
+		filter_options->rhs = xcalloc(1, sizeof(*filter_options->rhs));
+		filter_options->choice = LOFC_COMBINE;
+
+		/*
+		 * Build up the filter-spec string using the already-parsed
+		 * portion (the lhs) and the to-be-parsed portion (the rhs).
+		 */
+		filter_options->filter_spec = combine_specs(
+			lhs->filter_spec, arg);
+		FREE_AND_NULL(lhs->filter_spec);
+
+		/*
+		 * The gentle parse function below will populate the rhs of the
+		 * combined filter. But the caller of *this* function sees
+		 * filter_options as the combined filter.
+		 */
+		filter_options = filter_options->rhs;
+	} else {
+		filter_options->filter_spec = strdup(arg);
+	}
+	if (gently_parse_list_objects_filter(filter_options, arg, &errbuf))
+		die("%s", errbuf.buf);
 	return 0;
 }
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset)
 {
 	struct list_objects_filter_options *filter_options = opt->value;
 
 	if (unset || !arg) {
 		list_objects_filter_set_no_filter(filter_options);
 		return 0;
 	}
 
-	return parse_list_objects_filter(filter_options, arg);
+	return parse_list_objects_filter(
+		filter_options, arg, /*allow_implicit_combine=*/1);
 }
 
 void expand_list_objects_filter_spec(
 	const struct list_objects_filter_options *filter,
 	struct strbuf *expanded_spec)
 {
 	strbuf_init(expanded_spec, strlen(filter->filter_spec));
 	if (filter->choice == LOFC_BLOB_LIMIT)
 		strbuf_addf(expanded_spec, "blob:limit=%lu",
 			    filter->blob_limit_value);
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 6c0f0ecd08..a3ad00fde2 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -55,21 +55,22 @@ struct list_objects_filter_options {
 	/*
 	 * END choice-specific parsed values.
 	 */
 };
 
 /* Normalized command line arguments */
 #define CL_ARG__FILTER "filter"
 
 int parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
-	const char *arg);
+	const char *arg,
+	int allow_implicit_combine);
 
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset);
 
 #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
 	{ OPTION_CALLBACK, 0, CL_ARG__FILTER, fo, N_("args"), \
 	  N_("object filtering"), 0, \
 	  opt_parse_list_objects_filter }
 
 /*
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 9a8f9886b3..11536f4028 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -201,20 +201,39 @@ test_expect_success 'use fsck before and after manually fetching a missing subtr
 	test_line_count = 70 fetched_objects &&
 
 	awk -f print_1.awk fetched_objects |
 	xargs -n1 git -C dst cat-file -t >fetched_types &&
 
 	sort -u fetched_types >unique_types.observed &&
 	test_write_lines blob commit tree >unique_types.expected &&
 	test_cmp unique_types.expected unique_types.observed
 '
 
+test_expect_success 'implicitly construct combine: filter with repeated flags' '
+	GIT_TRACE=$(pwd)/trace git clone --bare \
+		--filter=blob:none --filter=tree:1 \
+		"file://$(pwd)/srv.bare" pc2 &&
+	grep "trace:.* git pack-objects .*--filter=combine:blob:none+tree:1" \
+		trace &&
+	git -C pc2 rev-list --objects --missing=allow-any HEAD >objects &&
+
+	# We should have gotten some root trees.
+	grep " $" objects &&
+	# Should not have gotten any non-root trees or blobs.
+	! grep " ." objects &&
+
+	xargs -n 1 git -C pc2 cat-file -t <objects >types &&
+	sort -u types >unique_types.actual &&
+	test_write_lines commit tree >unique_types.expected &&
+	test_cmp unique_types.expected unique_types.actual
+'
+
 test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
 	rm -rf src dst &&
 	git init src &&
 	test_commit -C src x &&
 	test_config -C src uploadpack.allowfilter 1 &&
 	test_config -C src uploadpack.allowanysha1inwant 1 &&
 
 	# Create a tag pointing to a blob.
 	BLOB=$(echo blob-contents | git -C src hash-object --stdin -w) &&
 	git -C src tag myblob "$BLOB" &&
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index ddfacb1a1a..104248c73d 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -357,21 +357,30 @@ test_expect_success 'verify tree:3 includes everything expected' '
 
 test_expect_success 'combine:... for a simple combination' '
 	git -C r3 rev-list --objects --filter=combine:tree:2+blob:none HEAD \
 		>actual &&
 
 	expect_has HEAD "" &&
 	expect_has HEAD~1 "" &&
 	expect_has HEAD dir1 &&
 
 	# There are also 2 commit objects
-	test_line_count = 5 actual
+	test_line_count = 5 actual &&
+
+	cp actual expected &&
+
+	# Try again using repeated --filter - this is equivalent to a manual
+	# combine with "combine:...+..."
+	git -C r3 rev-list --objects --filter=combine:tree:2 \
+		--filter=blob:none HEAD >actual &&
+
+	test_cmp expected actual
 '
 
 test_expect_success 'combine:... with URL encoding' '
 	git -C r3 rev-list --objects \
 		--filter=combine:tree%3a2+blob:%6Eon%65 HEAD >actual &&
 
 	expect_has HEAD "" &&
 	expect_has HEAD~1 "" &&
 	expect_has HEAD dir1 &&
 
@@ -459,21 +468,46 @@ test_expect_success 'combine:... with more than two sub-filters' '
 	test_line_count = 7 actual &&
 
 	# Try again, this time making sure the last sub-filter is only
 	# URL-decoded once.
 	cp pattern1 pattern1+renamed% &&
 	cp actual expect &&
 
 	git -C r3 rev-list --objects \
 		--filter=combine:tree:3+blob:limit=40+sparse:path=../pattern1%2brenamed%25 \
 		HEAD >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+
+	# Use the same composite filter again, but with a pattern file name that
+	# requires encoding multiple characters, and use implicit filter
+	# combining.
+	cp pattern1 "p;at%ter+n" &&
+	GIT_TRACE=$(pwd)/trace git -C r3 rev-list --objects \
+		--filter=tree:3 --filter=blob:limit=40 \
+		--filter=sparse:path="../p;at%ter+n" \
+		HEAD >actual &&
+
+	test_cmp expect actual &&
+	grep "Generated composite filter-spec: combine:tree:3+blob:limit=40+sparse:path=../p%3Bat%25ter%2B" \
+		trace &&
+
+	# Repeat the above test, but this time, the characters to encode are in
+	# the LHS of the combined filter.
+	cp pattern1 "^~pattern" &&
+	GIT_TRACE=$(pwd)/trace git -C r3 rev-list --objects \
+		--filter=sparse:path="../^~pattern" \
+		--filter=tree:3 --filter=blob:limit=40 \
+		HEAD >actual &&
+
+	test_cmp expect actual &&
+	grep "Generated composite filter-spec: combine:sparse:path=../%5E%7Epattern+tree:3+blob:limit=40" \
+		trace
 '
 
 # Test provisional omit collection logic with a repo that has objects appearing
 # at multiple depths - first deeper than the filter's threshold, then shallow.
 
 test_expect_success 'setup r4' '
 	git init r4 &&
 
 	echo foo > r4/foo &&
 	mkdir r4/subdir &&
diff --git a/transport.c b/transport.c
index f1fcd2c4b0..63100da143 100644
--- a/transport.c
+++ b/transport.c
@@ -217,21 +217,24 @@ static int set_git_option(struct git_transport_options *opts,
 	} else if (!strcmp(name, TRANS_OPT_DEEPEN_RELATIVE)) {
 		opts->deepen_relative = !!value;
 		return 0;
 	} else if (!strcmp(name, TRANS_OPT_FROM_PROMISOR)) {
 		opts->from_promisor = !!value;
 		return 0;
 	} else if (!strcmp(name, TRANS_OPT_NO_DEPENDENTS)) {
 		opts->no_dependents = !!value;
 		return 0;
 	} else if (!strcmp(name, TRANS_OPT_LIST_OBJECTS_FILTER)) {
-		parse_list_objects_filter(&opts->filter_options, value);
+		parse_list_objects_filter(
+			&opts->filter_options,
+			value,
+			/*allow_implicit_combine=*/0);
 		return 0;
 	}
 	return 1;
 }
 
 static int connect_setup(struct transport *transport, int for_push)
 {
 	struct git_transport_data *data = transport->data;
 	int flags = transport->verbose > 0 ? CONNECT_VERBOSE : 0;
 
diff --git a/upload-pack.c b/upload-pack.c
index d2ea5eb20d..e3f2618600 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -877,21 +877,24 @@ static void receive_needs(struct packet_reader *reader, struct object_array *wan
 		if (process_deepen(reader->line, &depth))
 			continue;
 		if (process_deepen_since(reader->line, &deepen_since, &deepen_rev_list))
 			continue;
 		if (process_deepen_not(reader->line, &deepen_not, &deepen_rev_list))
 			continue;
 
 		if (skip_prefix(reader->line, "filter ", &arg)) {
 			if (!filter_capability_requested)
 				die("git upload-pack: filtering capability not negotiated");
-			parse_list_objects_filter(&filter_options, arg);
+			parse_list_objects_filter(
+				&filter_options,
+				arg,
+				/*allow_implicit_combine=*/0);
 			continue;
 		}
 
 		if (!skip_prefix(reader->line, "want ", &arg) ||
 		    parse_oid_hex(arg, &oid_buf, &features))
 			die("git upload-pack: protocol error, "
 			    "expected to get object ID, not '%s'", reader->line);
 
 		if (parse_feature_request(features, "deepen-relative"))
 			deepen_relative = 1;
@@ -1296,21 +1299,24 @@ static void process_args(struct packet_reader *request,
 			continue;
 		if (process_deepen_not(arg, &data->deepen_not,
 				       &data->deepen_rev_list))
 			continue;
 		if (!strcmp(arg, "deepen-relative")) {
 			data->deepen_relative = 1;
 			continue;
 		}
 
 		if (allow_filter && skip_prefix(arg, "filter ", &p)) {
-			parse_list_objects_filter(&filter_options, p);
+			parse_list_objects_filter(
+				&filter_options,
+				p,
+				/*allow_implicit_combine=*/0);
 			continue;
 		}
 
 		if ((git_env_bool("GIT_TEST_SIDEBAND_ALL", 0) ||
 		     allow_sideband_all) &&
 		    !strcmp(arg, "sideband-all")) {
 			data->writer.use_sideband = 1;
 			continue;
 		}
 
-- 
2.21.0

