Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5753B47E0
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774012241; cv=none; b=n5XX8N03NFGHNDMFw+A5jqjdmW3Q8oxfgRvSIDz12C9mr0SfYW3H/vBuixzLZ9EDnsDBDYCQn2yIw7zZWaRputgPGr2ADtWyZZAhHewrf3ahhifKhqItQub7g7kGWFLynyQasN7MGk5I8QQGvdDVRDxgt+xw0L6IfMfFZwy+vQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774012241; c=relaxed/simple;
	bh=Vc3Py/sDDzRx99eXXeC4XKFftNXUw3XCBrWaCj3T/hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuKjyb/z/7Z4AHyQFg7MDOF8JLLTsWA+42IlGODCVfL7YjCt3R0KpQDowJiuknJjF3qcEMoiCt/BwzJjpceYiKE0tUxQARjkmrVzf0dBuWKmnDwpXkwBKajmNxHq+JITD5Zs9p5TKR85fvREQs2o+g5GgH5VRqfd/tIrjLEQHVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ju7jMicV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=plPn7kn2; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ju7jMicV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="plPn7kn2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D1E01400204;
	Fri, 20 Mar 2026 09:10:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 20 Mar 2026 09:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774012238;
	 x=1774098638; bh=bDkst2uG/uy4hmhFISullKQ3/NsGVIjjYzeNfql7y1Y=; b=
	ju7jMicVML61ZP+G1+9vCGqCkE8y2dwavzmpVenDgDtLiEgu/a5mK5ry2E3JG2K7
	7PY2BLv31pTvBfUhlzrB+trNLZtdTX65nX8aId6QlhkCES4sjdUp5YuPCWEGyO8O
	Q3Jovfs0TdrFHGDJ7aqKYr937UJ/Ug6nUOAiNsmAx2Ix/Y67WIATeN83FB/vHfPY
	VXJyzJU3DmvOqI37QePClc2dScueIN3Dij0flHSvLId4YIeNOiQ43KNMoic8SW3S
	9NDAVU79B68/FgXAl3BY1IBycPqcxh6SHJ1iydV1sStfMridf9o4oAvhtIhL0uK0
	BsVV+tWduPD0RL6Iu/zHpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774012238; x=
	1774098638; bh=bDkst2uG/uy4hmhFISullKQ3/NsGVIjjYzeNfql7y1Y=; b=p
	lPn7kn2WPAk8TmdE316xPWi8eV1cB30/gpe/NXh4qedCrKXYlGYzz/R0K+96ZjIx
	WYgrLeWB9/2QcIfGLf80DvlGBV+hdAVaBZC/1J5RrZRCfMUCky73Fu+jlxKfGXXK
	OAPvpaoMD0PSU5fvHbvT0wNw4a572enPZQkBLpuzMHbTHCIwWxhmJEPLkcqf/uR9
	oycVCVWfe2I/8pY3jcPhVGLshRVJcb1tuFwB4z0kkZKVhBnequtrBgcyAP+9wnKx
	3z3wrL85M5uKvyqBlhTvdvF3arDf4uZ+wootTj0gzIylf4TijvlWPeNRDKoCFdn2
	YDlvzM8a2oL2OEhcA9HvQ==
X-ME-Sender: <xms:Tke9aYmP2ChtRx-edx123Gk2NbpeBah_mn-UVqJxeABKSAelrPxbdzg>
    <xme:Tke9ad3SCe7dsL2M2RfkRBd3iE560Tki0j4OjUbceopSNvkc6qMFFQyuG62m6SOTy
    W8Cngvn51HeTIukRlkYQjOSFrhA162q8NRUeTMJ4_fXFHcajfnIBg>
X-ME-Received: <xmr:Tke9aURMpmtDR4D6k0c8Rs3X4H93Hve7soNKnbQXP0dJcjCP_WAfpVW43HCctqGM323C8FvUWdmjnK9WTXQ6aApd0PLhfGewKyUOix0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephfekke
    euieefffdugeeuleegteejffegvedtlefhudetgeejhfefleekudegudetnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghdptghtgidruggrthgvnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:Tke9afvZ3ayrWfArN3QoxX1mIcWdw497ncSXILX0sehg-T7V5D0i5w>
    <xmx:Tke9aZbPd3MD0dER8ZQlAQwh1bbqqCDASpTMiRXsnWTCle0Qf3faXg>
    <xmx:Tke9aUsSZN4aig7mk5b2M-cZufvxHgG06CSmZM-YDyOoJO97twUKsA>
    <xmx:Tke9abHew1s9v7Pi3CzmLJrTrXxjbj3HvAuhZodBgz_GdCWc2rkH5g>
    <xmx:Tke9aT8WgSJzN3CDzYeN2a3-DK2X7FiYg9TaM5nPm9Pw1Ui0eKp_VBGV>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 09:10:37 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 2/2] name-rev: learn --format=<pretty>
Date: Fri, 20 Mar 2026 14:09:35 +0100
Message-ID: <V2_name-rev_--format.51d@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <V2_CV_name-rev_--format.51b@msgid.xyz>
References: <CV_name-rev_--format.4ad@msgid.xyz> <V2_CV_name-rev_--format.51b@msgid.xyz>
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

Notes (series):
    v2:
    • Propely implement “--format implies --name-only”
    • Don’t use a needless intermediary struct
    • Add a new member to `name_rev_usage[]`
    • FREE_AND_NULL notes string. There is no use-after-free but we have no
      reason to leave a freed pointer just laying there
    • Implement `--notes` for `%N` atom use (not just restrict to the default
      notes ref)
    • Previous review pointed out `init_revisions()` but this still just uses
      `REV_INFO_INIT` since it seemed enough. But I have no problem with
      changing it whatsoever. (This series is still very work-in-progress in
      any case.)
    • Tweak test name to mention the specific pretty format (reference); it
      doesn’t generalize to e.g. `oneline` because you get different output in
      that case
    
    Mostly from: https://lore.kernel.org/git/xmqq8qbvz2dm.fsf@gitster.g/

 Documentation/git-name-rev.adoc |  10 +++-
 builtin/name-rev.c              | 100 +++++++++++++++++++++++++++++---
 t/t6120-describe.sh             |  96 ++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-name-rev.adoc b/Documentation/git-name-rev.adoc
index d4f1c4d5945..65348690c8c 100644
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
@@ -21,6 +21,14 @@ format parsable by 'git rev-parse'.
 OPTIONS
 -------
 
+--format=<pretty>::
+--no-format::
+	Format revisions instead of outputting symbolic names. The
+	default is `--no-format`.
++
+Implies `--name-only`. The negation `--no-format` implies
+`--no-name-only` (the default for the command).
+
 --tags::
 	Do not use branch names, but only tags to name the commits
 
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 171e7bd0e98..9a008d8b7a8 100644
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
@@ -33,6 +36,16 @@ struct rev_name {
 	int from_tag;
 };
 
+struct pretty_format {
+	struct pretty_print_context ctx;
+	struct userformat_want want;
+};
+
+struct format_cb_data {
+    const char *format;
+    int *name_only;
+};
+
 define_commit_slab(commit_rev_name, struct rev_name);
 
 static timestamp_t generation_cutoff = GENERATION_NUMBER_INFINITY;
@@ -454,7 +467,9 @@ static const char *get_exact_ref_match(const struct object *o)
 }
 
 /* may return a constant string or use "buf" as scratch space */
-static const char *get_rev_name(const struct object *o, struct strbuf *buf)
+static const char *get_rev_name(const struct object *o,
+				struct pretty_format *format_ctx,
+				struct strbuf *buf)
 {
 	struct rev_name *n;
 	const struct commit *c;
@@ -462,6 +477,25 @@ static const char *get_rev_name(const struct object *o, struct strbuf *buf)
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
+		FREE_AND_NULL(format_ctx->ctx.notes_message);
+
+		return buf->buf;
+	}
+
 	n = get_commit_rev_name(c);
 	if (!n)
 		return NULL;
@@ -479,6 +513,7 @@ static const char *get_rev_name(const struct object *o, struct strbuf *buf)
 
 static void show_name(const struct object *obj,
 		      const char *caller_name,
+		      struct pretty_format *format_ctx,
 		      int always, int allow_undefined, int name_only)
 {
 	const char *name;
@@ -487,7 +522,7 @@ static void show_name(const struct object *obj,
 
 	if (!name_only)
 		printf("%s ", caller_name ? caller_name : oid_to_hex(oid));
-	name = get_rev_name(obj, &buf);
+	name = get_rev_name(obj, format_ctx, &buf);
 	if (name)
 		printf("%s\n", name);
 	else if (allow_undefined)
@@ -507,7 +542,9 @@ static char const * const name_rev_usage[] = {
 	NULL
 };
 
-static void name_rev_line(char *p, struct name_ref_data *data)
+static void name_rev_line(char *p,
+			  struct name_ref_data *data,
+			  struct pretty_format *format_ctx)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int counter = 0;
@@ -532,7 +569,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 				struct object *o =
 					lookup_object(the_repository, &oid);
 				if (o)
-					name = get_rev_name(o, &buf);
+					name = get_rev_name(o, format_ctx, &buf);
 			}
 			*(p+1) = c;
 
@@ -554,6 +591,16 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 	strbuf_release(&buf);
 }
 
+static int format_cb(const struct option *option,
+		     const char *arg,
+		     int unset)
+{
+	struct format_cb_data *data = option->value;
+	data->format = arg;
+	*data->name_only = !unset;
+	return 0;
+}
+
 int cmd_name_rev(int argc,
 		 const char **argv,
 		 const char *prefix,
@@ -567,6 +614,12 @@ int cmd_name_rev(int argc,
 #endif
 	int all = 0, annotate_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
 	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
+	static struct format_cb_data format_cb_data = { 0 };
+	struct display_notes_opt format_notes_opt;
+	struct rev_info format_rev = REV_INFO_INIT;
+	struct pretty_format *format_ctx = NULL;
+	struct pretty_format format_pp = { 0 };
+	struct string_list notes = STRING_LIST_INIT_NODUP;
 	struct option opts[] = {
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
 		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
@@ -584,6 +637,10 @@ int cmd_name_rev(int argc,
 			   PARSE_OPT_HIDDEN),
 #endif /* WITH_BREAKING_CHANGES */
 		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
+		OPT_CALLBACK(0, "format", &format_cb_data, N_("format"),
+			     N_("pretty-print output instead"), format_cb),
+		OPT_STRING_LIST(0, "notes", &notes, N_("notes"),
+				N_("display notes for --format")),
 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
 		OPT_BOOL(0, "always",     &always,
 			   N_("show abbreviated commit object as fallback")),
@@ -592,6 +649,8 @@ int cmd_name_rev(int argc,
 		OPT_END(),
 	};
 
+	init_display_notes(&format_notes_opt);
+	format_cb_data.name_only = &data.name_only;
 	mem_pool_init(&string_pool, 0);
 	init_commit_rev_name(&rev_names);
 	repo_config(the_repository, git_default_config, NULL);
@@ -606,6 +665,31 @@ int cmd_name_rev(int argc,
 	}
 #endif
 
+	if (format_cb_data.format) {
+		get_commit_format(format_cb_data.format, &format_rev);
+		format_pp.ctx.rev = &format_rev;
+		format_pp.ctx.fmt = format_rev.commit_format;
+		format_pp.ctx.abbrev = format_rev.abbrev;
+		format_pp.ctx.date_mode_explicit = format_rev.date_mode_explicit;
+		format_pp.ctx.date_mode = format_rev.date_mode;
+		format_pp.ctx.color = GIT_COLOR_AUTO;
+
+		userformat_find_requirements(format_cb_data.format,
+					     &format_pp.want);
+		if (format_pp.want.notes) {
+			int ignore_show_notes = 0;
+			struct string_list_item *n;
+
+			for_each_string_list_item(n, &notes)
+				enable_ref_display_notes(&format_notes_opt,
+							 &ignore_show_notes,
+							 n->string);
+			load_display_notes(&format_notes_opt);
+		}
+
+		format_ctx = &format_pp;
+	}
+
 	if (all + annotate_stdin + !!argc > 1) {
 		error("Specify either a list, or --all, not both!");
 		usage_with_options(name_rev_usage, opts);
@@ -663,7 +747,7 @@ int cmd_name_rev(int argc,
 
 		while (strbuf_getline(&sb, stdin) != EOF) {
 			strbuf_addch(&sb, '\n');
-			name_rev_line(sb.buf, &data);
+			name_rev_line(sb.buf, &data, format_ctx);
 		}
 		strbuf_release(&sb);
 	} else if (all) {
@@ -674,18 +758,20 @@ int cmd_name_rev(int argc,
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
 
 	string_list_clear(&data.ref_filters, 0);
 	string_list_clear(&data.exclude_filters, 0);
+	string_list_clear(&notes, 0);
+	release_display_notes(&format_notes_opt);
 	mem_pool_discard(&string_pool, 0);
 	object_array_clear(&revs);
 	return 0;
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 2c70cc561ad..0b7e9fe396d 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -658,6 +658,102 @@ test_expect_success 'name-rev --annotate-stdin works with commitGraph' '
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
+test_expect_success 'name-rev --format --no-name-only' '
+	cat >expect <<-\EOF &&
+	HEAD~3 [fifth]
+	HEAD [eighth]
+	HEAD~5 [third]
+	EOF
+	git -C repo-format name-rev --format="[%s]" \
+		--no-name-only HEAD~3 HEAD HEAD~5 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'name-rev --format --no-format is the same as regular name-rev' '
+	git -C repo-format name-rev HEAD~2 HEAD~3 >expect &&
+	test_file_not_empty expect &&
+	git -C repo-format name-rev --format="huh?" \
+		--no-format HEAD~2 HEAD~3 >actual &&
+	test_cmp expect actual
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
+test_expect_success '--name-rev --format=reference --annotate-stdin from rev-list same as log' '
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
+test_expect_success 'name-rev --format=<pretty> with %N (note)' '
+	test_when_finished "git -C repo-format notes remove" &&
+	git -C repo-format notes add -m"Make a note" &&
+	printf "Make a note\n\n\n" >expect &&
+	git -C repo-format name-rev --format="tformat:%N" \
+		HEAD HEAD~ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'name-rev --format=<pretty> --notes<ref>' '
+	# One custom notes ref
+	test_when_finished "git -C repo-format notes remove" &&
+	test_when_finished "git -C repo-format notes --ref=word remove" &&
+	git -C repo-format notes add -m"default" &&
+	git -C repo-format notes --ref=word add -m"custom" &&
+	printf "custom\n\n" >expect &&
+	git -C repo-format name-rev --format="tformat:%N" \
+		--notes=word \
+		HEAD >actual &&
+	test_cmp expect actual &&
+	# Glob all
+	printf "default\ncustom\n\n" >expect &&
+	git -C repo-format name-rev --format="tformat:%N" \
+		--notes=* \
+		HEAD >actual &&
+	test_cmp expect actual
+'
+
 #               B
 #               o
 #  H             \
-- 
2.53.0.32.gf6228eaf9cc

