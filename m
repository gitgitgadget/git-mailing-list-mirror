Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AE5B200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932946AbcL0QYL (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:24:11 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33362 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932814AbcL0QYB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:24:01 -0500
Received: by mail-pg0-f67.google.com with SMTP id g1so12849110pgn.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=grDnVNddfZ7ReXtHUMAop962DCkGwPQdx0f3c2A2JJw=;
        b=Hn239rZA9t6w0qUi30EO38leDD80emZrFsRt1fLlRgXsggNUnOp4NW8jLVARALxG8a
         6EPVxBHuTnJXsZ7Elad5hkXKGwbMPo0vPi1YH9lMmHMoJSVZp3XufThO0ySAZhz9IcUm
         YHHQEArRPGZoBhU/5iS1MO2et9OOg2sVRissJ+SULhTd+2ShNpV4pFGSEgZWjr9yZOCH
         CR4IBGfO1SHf5DgYI7jgtTuM2SRDdqd8itr5SndrYokRDXOCioc9kGfMsTTQ0+YGVFLM
         A2ChE/3ma1hK2cU9yUkH7HGM4A2Ji8oCVYu5i8GmeyFta/9xp7LYW+uR6z33RXCFgERe
         gifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=grDnVNddfZ7ReXtHUMAop962DCkGwPQdx0f3c2A2JJw=;
        b=epUh5VTGn6Slhqu/bUoUTgjChFTUtHkWHBiqKWQKnAGMzYIY3UzXxliUcG96QPpALS
         JtfT8SMHfBPnJYgv7h9d08CinSuZsIbjcbTMvbweiLax6c6wtjmp3ULiJwTvaWO8lkhb
         hHnT4vFHh4OwgkaBdkwVbA5Sl0PEdd8KM41P1C865BuwnrG9oDjKLrqm+aLcKcg4hHR6
         e17EYfvQgh6ZS/uyLxCthDTYNPGQvY39LAEUm6zEe1uUTM2am2fKtHJrlsEE6kQGQEot
         W6gv/AwKGTPQ7my4apTOQLVYJyQJhA8MUYTfhEnHBGlcstCb3Bvh8kBD/MZpWZq7zb/4
         Z3UQ==
X-Gm-Message-State: AIkVDXKMb1pQgSDOfaWlmH92+QGhm/v+jjTL/+JI8nh6EOp/g7z3XQCrG+pyQfk0XNsm3w==
X-Received: by 10.98.211.143 with SMTP id z15mr19899545pfk.36.1482855840186;
        Tue, 27 Dec 2016 08:24:00 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:59 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 19/20] branch: use ref-filter printing APIs
Date:   Tue, 27 Dec 2016 21:53:56 +0530
Message-Id: <20161227162357.28212-20-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Port branch.c to use ref-filter APIs for printing. This clears out
most of the code used in branch.c for printing and replaces them with
calls made to the ref-filter library.

Introduce build_format() which gets the format required for printing
of refs. Make amendments to print_ref_list() to reflect these changes.

The strings included in build_format() may not be safely quoted for
inclusion (i.e. it might contain '%' which needs to be escaped with an
additional '%'). Introduce quote_literal_for_format() as a helper
function which takes a string and returns a version of the string that
is safely quoted to be used in the for-each-ref format which is built
in build_format().

Change calc_maxwidth() to also account for the length of HEAD ref, by
calling ref-filter:get_head_discription().

Also change the test in t6040 to reflect the changes.

Before this patch, all cross-prefix symrefs weren't shortened. Since
we're using ref-filter APIs, we shorten all symrefs by default. We also
allow the user to change the format if needed with the introduction of
the '--format' option in the next patch.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c         | 249 ++++++++++++++++-------------------------------
 t/t3203-branch-output.sh |   2 +-
 t/t6040-tracking-info.sh |   2 +-
 3 files changed, 88 insertions(+), 165 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 34cd61c..2887545 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -36,12 +36,12 @@ static unsigned char head_sha1[20];
 
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
-	GIT_COLOR_RESET,
-	GIT_COLOR_NORMAL,	/* PLAIN */
-	GIT_COLOR_RED,		/* REMOTE */
-	GIT_COLOR_NORMAL,	/* LOCAL */
-	GIT_COLOR_GREEN,	/* CURRENT */
-	GIT_COLOR_BLUE,		/* UPSTREAM */
+	"%(color:reset)",
+	"%(color:reset)",	/* PLAIN */
+	"%(color:red)",		/* REMOTE */
+	"%(color:reset)",	/* LOCAL */
+	"%(color:green)",	/* CURRENT */
+	"%(color:blue)",	/* UPSTREAM */
 };
 enum color_branch {
 	BRANCH_COLOR_RESET = 0,
@@ -280,180 +280,88 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	return(ret);
 }
 
-static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
-		int show_upstream_ref)
+static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 {
-	int ours, theirs;
-	char *ref = NULL;
-	struct branch *branch = branch_get(branch_name);
-	const char *upstream;
-	struct strbuf fancy = STRBUF_INIT;
-	int upstream_is_gone = 0;
-	int added_decoration = 1;
-
-	if (stat_tracking_info(branch, &ours, &theirs, &upstream) < 0) {
-		if (!upstream)
-			return;
-		upstream_is_gone = 1;
-	}
-
-	if (show_upstream_ref) {
-		ref = shorten_unambiguous_ref(upstream, 0);
-		if (want_color(branch_use_color))
-			strbuf_addf(&fancy, "%s%s%s",
-					branch_get_color(BRANCH_COLOR_UPSTREAM),
-					ref, branch_get_color(BRANCH_COLOR_RESET));
-		else
-			strbuf_addstr(&fancy, ref);
-	}
+	int i, max = 0;
+	for (i = 0; i < refs->nr; i++) {
+		struct ref_array_item *it = refs->items[i];
+		const char *desc = it->refname;
+		int w;
 
-	if (upstream_is_gone) {
-		if (show_upstream_ref)
-			strbuf_addf(stat, _("[%s: gone]"), fancy.buf);
-		else
-			added_decoration = 0;
-	} else if (!ours && !theirs) {
-		if (show_upstream_ref)
-			strbuf_addf(stat, _("[%s]"), fancy.buf);
-		else
-			added_decoration = 0;
-	} else if (!ours) {
-		if (show_upstream_ref)
-			strbuf_addf(stat, _("[%s: behind %d]"), fancy.buf, theirs);
-		else
-			strbuf_addf(stat, _("[behind %d]"), theirs);
+		skip_prefix(it->refname, "refs/heads/", &desc);
+		skip_prefix(it->refname, "refs/remotes/", &desc);
+		if (it->kind == FILTER_REFS_DETACHED_HEAD) {
+			char *head_desc = get_head_description();
+			w = utf8_strwidth(head_desc);
+			free(head_desc);
+		} else
+			w = utf8_strwidth(desc);
 
-	} else if (!theirs) {
-		if (show_upstream_ref)
-			strbuf_addf(stat, _("[%s: ahead %d]"), fancy.buf, ours);
-		else
-			strbuf_addf(stat, _("[ahead %d]"), ours);
-	} else {
-		if (show_upstream_ref)
-			strbuf_addf(stat, _("[%s: ahead %d, behind %d]"),
-				    fancy.buf, ours, theirs);
-		else
-			strbuf_addf(stat, _("[ahead %d, behind %d]"),
-				    ours, theirs);
+		if (it->kind == FILTER_REFS_REMOTES)
+			w += remote_bonus;
+		if (w > max)
+			max = w;
 	}
-	strbuf_release(&fancy);
-	if (added_decoration)
-		strbuf_addch(stat, ' ');
-	free(ref);
+	return max;
 }
 
-static void add_verbose_info(struct strbuf *out, struct ref_array_item *item,
-			     struct ref_filter *filter, const char *refname)
+static const char *quote_literal_for_format(const char *s)
 {
-	struct strbuf subject = STRBUF_INIT, stat = STRBUF_INIT;
-	const char *sub = _(" **** invalid ref ****");
-	struct commit *commit = item->commit;
+	static struct strbuf buf = STRBUF_INIT;
 
-	if (!parse_commit(commit)) {
-		pp_commit_easy(CMIT_FMT_ONELINE, commit, &subject);
-		sub = subject.buf;
+	strbuf_reset(&buf);
+	while (*s) {
+		const char *ep = strchrnul(s, '%');
+		if (s < ep)
+			strbuf_add(&buf, s, ep - s);
+		if (*ep == '%') {
+			strbuf_addstr(&buf, "%%");
+			s = ep + 1;
+		} else {
+			s = ep;
+		}
 	}
-
-	if (item->kind == FILTER_REFS_BRANCHES)
-		fill_tracking_info(&stat, refname, filter->verbose > 1);
-
-	strbuf_addf(out, " %s %s%s",
-		find_unique_abbrev(item->commit->object.oid.hash, filter->abbrev),
-		stat.buf, sub);
-	strbuf_release(&stat);
-	strbuf_release(&subject);
+	return buf.buf;
 }
 
-static void format_and_print_ref_item(struct ref_array_item *item, int maxwidth,
-				      struct ref_filter *filter, const char *remote_prefix)
+static char *build_format(struct ref_filter *filter, int maxwidth, const char *remote_prefix)
 {
-	char c;
-	int current = 0;
-	int color;
-	struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
-	const char *prefix_to_show = "";
-	const char *prefix_to_skip = NULL;
-	const char *desc = item->refname;
-	char *to_free = NULL;
-
-	switch (item->kind) {
-	case FILTER_REFS_BRANCHES:
-		prefix_to_skip = "refs/heads/";
-		skip_prefix(desc, prefix_to_skip, &desc);
-		if (!filter->detached && !strcmp(desc, head))
-			current = 1;
-		else
-			color = BRANCH_COLOR_LOCAL;
-		break;
-	case FILTER_REFS_REMOTES:
-		prefix_to_skip = "refs/remotes/";
-		skip_prefix(desc, prefix_to_skip, &desc);
-		color = BRANCH_COLOR_REMOTE;
-		prefix_to_show = remote_prefix;
-		break;
-	case FILTER_REFS_DETACHED_HEAD:
-		desc = to_free = get_head_description();
-		current = 1;
-		break;
-	default:
-		color = BRANCH_COLOR_PLAIN;
-		break;
-	}
+	struct strbuf fmt = STRBUF_INIT;
+	struct strbuf local = STRBUF_INIT;
+	struct strbuf remote = STRBUF_INIT;
 
-	c = ' ';
-	if (current) {
-		c = '*';
-		color = BRANCH_COLOR_CURRENT;
-	}
+	strbuf_addf(&fmt, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)",
+		    branch_get_color(BRANCH_COLOR_CURRENT));
 
-	strbuf_addf(&name, "%s%s", prefix_to_show, desc);
 	if (filter->verbose) {
-		int utf8_compensation = strlen(name.buf) - utf8_strwidth(name.buf);
-		strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
-			    maxwidth + utf8_compensation, name.buf,
+		strbuf_addf(&local, "%%(align:%d,left)%%(refname:lstrip=2)%%(end)", maxwidth);
+		strbuf_addf(&local, "%s", branch_get_color(BRANCH_COLOR_RESET));
+		strbuf_addf(&local, " %%(objectname:short=7) ");
+
+		if (filter->verbose > 1)
+			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
+				    "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
+				    branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
+		else
+			strbuf_addf(&local, "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)");
+
+		strbuf_addf(&remote, "%s%%(align:%d,left)%s%%(refname:lstrip=2)%%(end)%s%%(if)%%(symref)%%(then) -> %%(symref:short)"
+			    "%%(else) %%(objectname:short=7) %%(contents:subject)%%(end)",
+			    branch_get_color(BRANCH_COLOR_REMOTE), maxwidth, quote_literal_for_format(remote_prefix),
 			    branch_get_color(BRANCH_COLOR_RESET));
-	} else
-		strbuf_addf(&out, "%c %s%s%s", c, branch_get_color(color),
-			    name.buf, branch_get_color(BRANCH_COLOR_RESET));
-
-	if (item->symref) {
-		const char *symref = item->symref;
-		if (prefix_to_skip)
-			skip_prefix(symref, prefix_to_skip, &symref);
-		strbuf_addf(&out, " -> %s", symref);
-	}
-	else if (filter->verbose)
-		/* " f7c0c00 [ahead 58, behind 197] vcs-svn: drop obj_pool.h" */
-		add_verbose_info(&out, item, filter, desc);
-	if (column_active(colopts)) {
-		assert(!filter->verbose && "--column and --verbose are incompatible");
-		string_list_append(&output, out.buf);
 	} else {
-		printf("%s\n", out.buf);
+		strbuf_addf(&local, "%%(refname:lstrip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
+			    branch_get_color(BRANCH_COLOR_RESET));
+		strbuf_addf(&remote, "%s%s%%(refname:lstrip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
+			    branch_get_color(BRANCH_COLOR_REMOTE), quote_literal_for_format(remote_prefix),
+			    branch_get_color(BRANCH_COLOR_RESET));
 	}
-	strbuf_release(&name);
-	strbuf_release(&out);
-	free(to_free);
-}
-
-static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
-{
-	int i, max = 0;
-	for (i = 0; i < refs->nr; i++) {
-		struct ref_array_item *it = refs->items[i];
-		const char *desc = it->refname;
-		int w;
 
-		skip_prefix(it->refname, "refs/heads/", &desc);
-		skip_prefix(it->refname, "refs/remotes/", &desc);
-		w = utf8_strwidth(desc);
+	strbuf_addf(&fmt, "%%(if:notequals=refs/remotes)%%(refname:rstrip=-2)%%(then)%s%%(else)%s%%(end)", local.buf, remote.buf);
 
-		if (it->kind == FILTER_REFS_REMOTES)
-			w += remote_bonus;
-		if (w > max)
-			max = w;
-	}
-	return max;
+	strbuf_release(&local);
+	strbuf_release(&remote);
+	return strbuf_detach(&fmt, NULL);
 }
 
 static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting)
@@ -462,6 +370,8 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	struct ref_array array;
 	int maxwidth = 0;
 	const char *remote_prefix = "";
+	struct strbuf out = STRBUF_INIT;
+	char *format;
 
 	/*
 	 * If we are listing more than just remote branches,
@@ -473,18 +383,31 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 
 	memset(&array, 0, sizeof(array));
 
-	verify_ref_format("%(refname)%(symref)");
 	filter_refs(&array, filter, filter->kind | FILTER_REFS_INCLUDE_BROKEN);
 
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
 
+	format = build_format(filter, maxwidth, remote_prefix);
+	verify_ref_format(format);
+
 	ref_array_sort(sorting, &array);
 
-	for (i = 0; i < array.nr; i++)
-		format_and_print_ref_item(array.items[i], maxwidth, filter, remote_prefix);
+	for (i = 0; i < array.nr; i++) {
+		format_ref_array_item(array.items[i], format, 0, &out);
+		if (column_active(colopts)) {
+			assert(!filter->verbose && "--column and --verbose are incompatible");
+			 /* format to a string_list to let print_columns() do its job */
+			string_list_append(&output, out.buf);
+		} else {
+			fwrite(out.buf, 1, out.len, stdout);
+			putchar('\n');
+		}
+		strbuf_release(&out);
+	}
 
 	ref_array_clear(&array);
+	free(format);
 }
 
 static void reject_rebase_or_bisect_branch(const char *target)
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 52283df..4521328 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -194,7 +194,7 @@ test_expect_success 'local-branch symrefs shortened properly' '
 	git symbolic-ref refs/heads/ref-to-remote refs/remotes/origin/branch-one &&
 	cat >expect <<-\EOF &&
 	  ref-to-branch -> branch-one
-	  ref-to-remote -> refs/remotes/origin/branch-one
+	  ref-to-remote -> origin/branch-one
 	EOF
 	git branch >actual.raw &&
 	grep ref-to <actual.raw >actual &&
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 3d5c238..97a0765 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -44,7 +44,7 @@ b1 [ahead 1, behind 1] d
 b2 [ahead 1, behind 1] d
 b3 [behind 1] b
 b4 [ahead 2] f
-b5 g
+b5 [gone] g
 b6 c
 EOF
 
-- 
2.10.2

