Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7221362128
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417906; cv=none; b=i3AHfmBifYmSPVDdg6KYDa+okZ+thoI/zqmWtQ1MZXnrZL/tKvZlFbWr8rorxtsCd6G3CGBzNqpM9J0I2OgjPnASgmJxKUY7nUo3Syr0ScfofBkAhgzxclOwheEU5Tukawg1Wo0aoE2r/aY3LxmRGZ3Dk4EHOl65H0iQsUPV1vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417906; c=relaxed/simple;
	bh=P3ze3vxHSApjCKtRaNFX1Ke0HVpUE4Cs84wHmwQ42xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnloXwVjsa3A035fXaY5VqVQgKKR/HFt1rjs5RE20nMX+dZ/0FFlgBzLM7nGH6Z5hNgNEw0jbLu09lKz4Bev9vPxFYLhFxupcUWsIqoofcLIB1+pPvFHdKeemA3biA4vO5yI64nlkOBzLFjypl8c5Xk2SrjYaHR1GW0esiJkAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VjF/XGmk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mb1GTOOv; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VjF/XGmk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mb1GTOOv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F1F97A01AB;
	Fri, 13 Mar 2026 12:05:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 13 Mar 2026 12:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773417903;
	 x=1773504303; bh=eIkvAGDVrwJ6M2KJcHui7NZey2zHdfJbk/4BE8pgA4Q=; b=
	VjF/XGmkrdpGvXX5wEi4Z6Zaf3oLhbv7C3decaQhNUnbgBkKWxvI6dCLFmtY5f0j
	mTCyzNZ8HmTzCZRgGowzJVM0dx7L77XfOPgz0ipPta11WoVoBMR2WMVU3r5uj9th
	eWIcA+zi5rcvNrin4hCP373BegpZ17qsojUAeZ45mbJ8vjIBMAHnpD6JndqnUVfI
	QdhrzQv+WoTz1uZC/TCS37UXmo7oDB1VkdiRcQX/tFspdppbm3CokQbofn7EI0W7
	kRSfpOWm6CrZWsYTnse/i5sz5PetJfvMg1rICUT5eRik0061pNHEju4b+sI1ZmIr
	ZlaDLSAI59H2SH4ovv5shA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773417903; x=
	1773504303; bh=eIkvAGDVrwJ6M2KJcHui7NZey2zHdfJbk/4BE8pgA4Q=; b=M
	b1GTOOvDBUg9K5QZFUTZVFOott9xgVlIlFBcgFbhD8b0muwkC5J1xKhWkUC7+c+y
	YDHNgWT4tvR9NBlsPVAa5ayEbykBIMURmWNeYVNIfS9YACEN73bSi/SJEbRUWYGz
	gP47yrBcgypIOar/UZEPauDajQ7qe48STKdQbpqVFAaIC7cYB4XBovXhJjD1IKUu
	x0RBP7nD5MG4W0jLrqE1FmXdX+j74Nfsoc99/YvJ7fkXa5pT4o4lc8tB+FtOLT0d
	4/JMMPGsbrHedp2UDYJ8b3YAweuXhFXFLbU74eyMKA9nXsWa/wgIEnqEIMX9BpWs
	fx/cUa8jDZ+RJAq7Cl93Q==
X-ME-Sender: <xms:rzW0ad3MlFjzb9M69omvqMCHBEg0oRZhOO8RC5rhfgXHNmI6e-nWzJE>
    <xme:rzW0aaFnucGWhsdMziMYhROisS_XqMT5QJnPkYfvbZT6mgsb2RKiKu5awwLiPgOrl
    fLa6pOtpby3NzO9HRDi8tC0nUkzDlNElqtGumbxKnrL9RZ3dOuAug>
X-ME-Received: <xmr:rzW0abi7wGmTnnJjj2GymkOV-ee2PPgbqXrrkrtuQMpskvJBP2otD21f9mPwZbzOqWdNRaUHwQ8-EoAItiF6FEtzNoMtpLFkMDJXboo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledttdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffgge
    elhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:rzW0aV-GMfVpWArkYCJAzvWPMeN4wJmltlC0M7-Uo8r6q1lYV9OEbA>
    <xmx:rzW0aSoOKhApIQPw7lokM7ViEQFzRhUD56NXaJD_I-Zs5chm-JV-nQ>
    <xmx:rzW0aU-v8cIdmX6rGIMvnwdBGNEA5Ygnf7VoSyeiPgOv9PvL6wYlpQ>
    <xmx:rzW0aWVR0R5Ois16xGSAPTRUJNIQmYbkJxfNhR56OoM0GxSDEqIRJw>
    <xmx:rzW0aZON6vMgY43HVa6lAc49a7x435BFEZaGlVqQlSl41Atv5bE00652>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 12:05:02 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 2/2] name-rev: learn --format=<pretty>
Date: Fri, 13 Mar 2026 17:03:38 +0100
Message-ID: <name-rev_--format.4af@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <CV_name-rev_--format.4ad@msgid.xyz>
References: <CV_name-rev_--format.4ad@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Teach git-name-rev(1) to format the given revisions instead of creating
symbolic names.

Sometimes you want to format commits. Most of the time you’re walking
the graph, e.g. getting a range of commits like `master..topic`. That’s
a job for git-log(1).

But sometimes you might want to format commits that you encounter
on demand:

• Full hashes in running text that you might want to pretty-print
• git-last-modified(1) outputs full hashes that you can do the same with
• git-cherry(1) has `-v` for commit subject, but maybe you want
  something else?

But now you can’t use git-log(1), git-show(1), or git-rev-list(1):

• You can’t feed commits piecemeal to these commands, one input for one
  output; they block until standard in is closed
• You can’t feed a list of possibly duplicate commits, like the output
  of git-last-modified(1); they effectively deduplicate the output

Beyond these two points there’s also the input massage problem: you
cannot feed mixed input (revisions mixed with arbitrary text).

One might hope that git-cat-file(1) can save us. But it doesn’t support
pretty formats.

But there is one command that already both handles revisions as
arguments, revisions on standard input, and even revisions mixed
in with arbitrary text. Namely git-name-rev(1).

Teach it to work in a format mode where the output for each revision is
the pretty output (implies `--name-only`). This can be used to format
any revision expression when given as arguments, and all full commit
hashes in running text on stdin.

Just bring the hashes (to the pipeline). We will pretty print them.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-name-rev.adoc |  9 +++-
 builtin/name-rev.c              | 75 ++++++++++++++++++++++++++++++---
 t/t6120-describe.sh             | 58 +++++++++++++++++++++++++
 3 files changed, 134 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-name-rev.adoc b/Documentation/git-name-rev.adoc
index d4f1c4d5945..8f050cd4763 100644
--- a/Documentation/git-name-rev.adoc
+++ b/Documentation/git-name-rev.adoc
@@ -9,7 +9,7 @@ git-name-rev - Find symbolic names for given revs
 SYNOPSIS
 --------
 [verse]
-'git name-rev' [--tags] [--refs=<pattern>]
+'git name-rev' [--tags] [--refs=<pattern>] [--format=<pretty>]
 	       ( --all | --annotate-stdin | <commit-ish>... )
 
 DESCRIPTION
@@ -21,6 +21,13 @@ format parsable by 'git rev-parse'.
 OPTIONS
 -------
 
+--format=<pretty>::
+--no-format::
+	Format revisions instead of outputting symbolic names. The
+	default is `--no-format`.
++
+Implies `--name-only`.
+
 --tags::
 	Do not use branch names, but only tags to name the commits
 
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 9d2774f3723..30d981104c6 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -18,6 +18,9 @@
 #include "commit-graph.h"
 #include "wildmatch.h"
 #include "mem-pool.h"
+#include "pretty.h"
+#include "revision.h"
+#include "notes.h"
 
 /*
  * One day.  See the 'name a rev shortly after epoch' test in t6120 when
@@ -33,6 +36,11 @@ struct rev_name {
 	int from_tag;
 };
 
+struct pretty_format {
+	struct pretty_print_context ctx;
+	struct userformat_want want;
+};
+
 define_commit_slab(commit_rev_name, struct rev_name);
 
 static timestamp_t generation_cutoff = GENERATION_NUMBER_INFINITY;
@@ -454,7 +462,9 @@ static const char *get_exact_ref_match(const struct object *o)
 }
 
 /* may return a constant string or use "buf" as scratch space */
-static const char *get_rev_name(const struct object *o, struct strbuf *buf)
+static const char *get_rev_name(const struct object *o,
+				struct pretty_format *format_ctx,
+				struct strbuf *buf)
 {
 	struct rev_name *n;
 	const struct commit *c;
@@ -462,6 +472,25 @@ static const char *get_rev_name(const struct object *o, struct strbuf *buf)
 	if (o->type != OBJ_COMMIT)
 		return get_exact_ref_match(o);
 	c = (const struct commit *) o;
+
+	if (format_ctx) {
+		strbuf_reset(buf);
+
+		if (format_ctx->want.notes) {
+			struct strbuf notebuf = STRBUF_INIT;
+
+			format_display_notes(&c->object.oid, &notebuf,
+					     get_log_output_encoding(),
+					     format_ctx->ctx.fmt == CMIT_FMT_USERFORMAT);
+			format_ctx->ctx.notes_message = strbuf_detach(&notebuf, NULL);
+		}
+
+		pretty_print_commit(&format_ctx->ctx, c, buf);
+		free(format_ctx->ctx.notes_message);
+
+		return buf->buf;
+	}
+
 	n = get_commit_rev_name(c);
 	if (!n)
 		return NULL;
@@ -479,6 +508,7 @@ static const char *get_rev_name(const struct object *o, struct strbuf *buf)
 
 static void show_name(const struct object *obj,
 		      const char *caller_name,
+		      struct pretty_format *format_ctx,
 		      int always, int allow_undefined, int name_only)
 {
 	const char *name;
@@ -487,7 +517,7 @@ static void show_name(const struct object *obj,
 
 	if (!name_only)
 		printf("%s ", caller_name ? caller_name : oid_to_hex(oid));
-	name = get_rev_name(obj, &buf);
+	name = get_rev_name(obj, format_ctx, &buf);
 	if (name)
 		printf("%s\n", name);
 	else if (allow_undefined)
@@ -507,7 +537,9 @@ static char const * const name_rev_usage[] = {
 	NULL
 };
 
-static void name_rev_line(char *p, struct name_ref_data *data)
+static void name_rev_line(char *p,
+			  struct name_ref_data *data,
+			  struct pretty_format *format_ctx)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int counter = 0;
@@ -532,7 +564,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 				struct object *o =
 					lookup_object(the_repository, &oid);
 				if (o)
-					name = get_rev_name(o, &buf);
+					name = get_rev_name(o, format_ctx, &buf);
 			}
 			*(p+1) = c;
 
@@ -567,6 +599,10 @@ int cmd_name_rev(int argc,
 #endif
 	int all = 0, annotate_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
 	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
+	const char *format = NULL;
+	struct rev_info format_rev = REV_INFO_INIT;
+	struct pretty_format *format_ctx = NULL;
+	struct pretty_format format_pp = {0};
 	struct option opts[] = {
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
 		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
@@ -584,6 +620,8 @@ int cmd_name_rev(int argc,
 			   PARSE_OPT_HIDDEN),
 #endif /* WITH_BREAKING_CHANGES */
 		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
+		OPT_STRING(0, "format", &format, N_("format"),
+			   "pretty-print output instead"),
 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
 		OPT_BOOL(0, "always",     &always,
 			   N_("show abbreviated commit object as fallback")),
@@ -606,6 +644,29 @@ int cmd_name_rev(int argc,
 	}
 #endif
 
+	if (format) {
+		struct pretty_print_context ctx = {0};
+		struct userformat_want want = {0};
+
+		get_commit_format(format, &format_rev);
+		ctx.rev = &format_rev;
+		ctx.fmt = format_rev.commit_format;
+		ctx.abbrev = format_rev.abbrev;
+		ctx.date_mode_explicit = format_rev.date_mode_explicit;
+		ctx.date_mode = format_rev.date_mode;
+		ctx.color = GIT_COLOR_AUTO;
+		format_pp.ctx = ctx;
+
+		userformat_find_requirements(format, &want);
+		if (want.notes)
+			load_display_notes(NULL);
+
+		format_pp.want = want;
+		format_ctx = &format_pp;
+
+		data.name_only = true;
+	}
+
 	if (all + annotate_stdin + !!argc > 1) {
 		error("Specify either a list, or --all, not both!");
 		usage_with_options(name_rev_usage, opts);
@@ -663,7 +724,7 @@ int cmd_name_rev(int argc,
 
 		while (strbuf_getline(&sb, stdin) != EOF) {
 			strbuf_addch(&sb, '\n');
-			name_rev_line(sb.buf, &data);
+			name_rev_line(sb.buf, &data, format_ctx);
 		}
 		strbuf_release(&sb);
 	} else if (all) {
@@ -674,13 +735,13 @@ int cmd_name_rev(int argc,
 			struct object *obj = get_indexed_object(the_repository, i);
 			if (!obj || obj->type != OBJ_COMMIT)
 				continue;
-			show_name(obj, NULL,
+			show_name(obj, NULL, format_ctx,
 				  always, allow_undefined, data.name_only);
 		}
 	} else {
 		int i;
 		for (i = 0; i < revs.nr; i++)
-			show_name(revs.objects[i].item, revs.objects[i].name,
+			show_name(revs.objects[i].item, revs.objects[i].name, format_ctx,
 				  always, allow_undefined, data.name_only);
 	}
 
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 2c70cc561ad..6dba392d343 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -658,6 +658,64 @@ test_expect_success 'name-rev --annotate-stdin works with commitGraph' '
 	)
 '
 
+test_expect_success 'name-rev --format setup' '
+	mkdir repo-format &&
+	git -C repo-format init &&
+	test_commit -C repo-format first &&
+	test_commit -C repo-format second &&
+	test_commit -C repo-format third &&
+	test_commit -C repo-format fourth &&
+	test_commit -C repo-format fifth &&
+	test_commit -C repo-format sixth &&
+	test_commit -C repo-format seventh &&
+	test_commit -C repo-format eighth
+'
+
+test_expect_success 'name-rev --format=%s for argument revs' '
+	cat >expect <<-\EOF &&
+	eighth
+	seventh
+	fifth
+	EOF
+	git -C repo-format name-rev --format=%s \
+		HEAD HEAD~ HEAD~3 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--name-rev --format=<pretty> --annotate-stdin from rev-list same as log' '
+	git -C repo-format log --format=reference >expect &&
+	test_file_not_empty expect &&
+	git -C repo-format rev-list HEAD >list &&
+	git -C repo-format name-rev --format=reference \
+		--annotate-stdin <list >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--name-rev --format=<pretty> --annotate-stdin with running text and tree oid' '
+	cmit_oid=$(git -C repo-format rev-parse :/fifth) &&
+	reference=$(git -C repo-format log -n1 --format=reference :/fifth) &&
+	tree=$(git -C repo-format rev-parse HEAD^{tree}) &&
+	cat >expect <<-EOF &&
+	We thought we fixed this in ${reference}.
+	But look at this tree: ${tree}.
+	EOF
+	git -C repo-format name-rev --format=reference --annotate-stdin \
+		>actual <<-EOF &&
+	We thought we fixed this in ${cmit_oid}.
+	But look at this tree: ${tree}.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--name-rev --format=<pretty> with a note' '
+	test_when_finished "git -C repo-format notes remove" &&
+	git -C repo-format notes add -m"Make a note" &&
+	printf "Make a note\n\n\n" >expect &&
+	git -C repo-format name-rev --format="tformat:%N" \
+		HEAD HEAD~ >actual &&
+	test_cmp expect actual
+'
+
 #               B
 #               o
 #  H             \
-- 
2.53.0.32.gf6228eaf9cc

