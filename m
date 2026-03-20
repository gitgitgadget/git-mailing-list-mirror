Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B13A3AA515
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774012207; cv=none; b=DIwoHMaGc2tyJ9VOJztipFpVL79pINdyzRYQNxcvmjZEdAq13bJin3v7ulWsCvPtsKeJ7vClzMKUh8zZU3vEVkbwQB9zJ1WUgPXgq5GmMYxIDMoWF+GvYPOmcos51UkkFbgnN/v2mE7vopdPQWqjXobYdbuToKZ0n5f+iuB22Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774012207; c=relaxed/simple;
	bh=hzXh820wFseSOXw89hgGL24Djnduz70+mv3d4NPnj4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwQf8LKegigbRLs+BGVk3xBwTGmlZc8W19FaVrghtqIAEQKSHc8f7mi/gkj98biFcndxk7DnQxdsADWz7H2vuZOj8Qgd7w15BVaTCXFptyApJzZ/Lp4eiKCbS1p8rzTKRgg+jJeODs1ro24sUgXaIBq0Sbc3jCfyHuJJuFp12OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Uk3cGOGo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d82yTFzz; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Uk3cGOGo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d82yTFzz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA37714001B8;
	Fri, 20 Mar 2026 09:10:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 09:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774012203;
	 x=1774098603; bh=l6ySgTRZNuF+qFe1zw7W3IUZabOumIsB9FLuhngX+Ew=; b=
	Uk3cGOGoi08JsSokoKwKc+fnq4k6uLSarf4FmfjHyqQjqcDspa7/8w2moqxPwn3L
	ww2JkVO0YcuARAqNU+jFWITOtAfYtWSYC5E7YU8dOSUuFjfGlxjaQcqbW1fW27+N
	XgghVCy7mPVCTAWpImG8ztqO7uyUJMeuAAPF1io/wA/v5c9Fqe4zba1UKmM0Zkgw
	8iSUSGGwgquPl9DKe1RgFxzJ+OzkMC4+ECkyer28hPqfQt4Uq83DUTSn9LvbjsZP
	OK+Wy5umWFF6UeijKN01tmloErWb5qgP6IwPgU9tQYiHgjedYjdiUBJl9GwYX9Vn
	Xb18EJFtotNsV9xYYsI0EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774012203; x=
	1774098603; bh=l6ySgTRZNuF+qFe1zw7W3IUZabOumIsB9FLuhngX+Ew=; b=d
	82yTFzz1knnuFMZ3lceUHE/uhYV118JoqvMTOJJ/e+1WLFTqxjMzkVTk1nCIhve3
	bvJ70PZvrJFHJAU+CeV9KaCPaC5LQXGtCNflm2DKg6bkvdppaqNBwrUnfpiHqsWn
	OP02/JPqlaxstb11K/oGAcowbrKB31WG900PmbztJR77bNq/eputqqoG+uq4+4dg
	GY7yp72dHk6UFrIVjS0AG0VW1iPrDelTuFm2W6NvahDK3z9B1uG12XDcfvDMJyCC
	0N/mKme/T+CF6VfLWwizs6iUggZD18dwYI0gywkg0/p12zuLRSioprWh6GlzbIeh
	BCaq9keTf9mDl73OyukrA==
X-ME-Sender: <xms:K0e9aYxDX0Mh-T9W0UR0SxJpmxR7k8RblCVo28pRjXe6UYdXJBQwknU>
    <xme:K0e9aSQq48uQTyu1BLm6JZ5SvzoMBK2YNlK7wg9TIZRRimu49uCNCi6waDvu4V04K
    ogOETvpc2Wb8H9gL3WcSL2ayuPBF1E64Q0sA04i0z1kE3obp9i2>
X-ME-Received: <xmr:K0e9aX8_Di1T0njL69qB0-4VFvQzRI7kPARgkvsYFFAYxssU2ZtSo4eiUrSudWCbogrH-IiY2uDyNwnSEkd0RRqsBfvX3yN_TxQmJdo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepteethe
    eviedvleevtdejffelteegieevledtveehvdeuledtiedthfdukeefgedvnecuffhomhgr
    ihhnpegtthigrdgurghtvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:K0e9aRpsC8_zQ7GRBSRRGf6aD4YOMLwK2Co3k8QDCk0hUYUZfQ1hzw>
    <xmx:K0e9acnguohciobZX7CMDgtRwsrgioGsBR6mGigDupJuFy6VGfJczQ>
    <xmx:K0e9aQI3akKepCLNnFQtFljTRkl30FYfL20oo-sce3H1PctilD1bvQ>
    <xmx:K0e9aZzqEQIZmvuegmAac_hWYbPhIc5cT-kMhhzQVah6s81AOv2RJw>
    <xmx:K0e9acIHOQv80HxYr3nhk_OsISyL3sPArAy6QstQXA99H4ogb-eTimD_>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 09:10:00 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v2 0/2] name-rev: learn --format=<pretty>
Date: Fri, 20 Mar 2026 14:09:33 +0100
Message-ID: <V2_CV_name-rev_--format.51b@msgid.xyz>
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

Topic name (applied): kh/name-rev-custom-format

Topic summary: Teach git-name-rev(1) a mode to pretty format revisions
instead of outputting symbolic names.

(See the second patch for details.)

The first patch is just for `CodingGuidelines`. Unrelated.

(See the previous cover letter for a slightly different introduction.)

This started because I had a faint wish in the back of my head (that I was
probably not going to act on) to implement a third-party git-format-rev(1)
command which does what `git name-rev --format=<pretty>` does with this
series applied. I thought I could just use one invocation of some git(1)
command to feed to stdin and read from stdout. Like git-log(1), or
git-rev-list(1). But due to apparent limitations (see patch [2/2] message)
there didn’t seem to be anything better than invoking a git(1) command per
revision/hash that was encountered in the text. I wanted something more
efficient. (I had no need for something more efficient. I just wanted it.)

I then picked git-name-rev(1) since that was the easiest thing to implement
for me. Add an option to an existing command.

Right now this is just version 2 and I don’t know if this is a good
approach or not. If it ever is accepted (in whatever form) I don’t expect
it to be soon.

git(1) already has a lot of commands. This doesn’t expand the footprint. On
the other hand, I might be naive about what a proper formatter needs in
terms of command options. Right now there is the helper `--notes`. But is
more needed?

• --abbrev ?
• --date ?

I don’t know. Maybe at some point this would be too much, too crowded, for
git-name-rev(1). Then it might make sense to split it out to a separate
builtin?

These are some thoughts and context.

§ Changes in v2

Implement `--notes` and respond to reviewer feedback. Details on the second
patch.

The first patch now just formats what it intends to (there was stray
clang-formatting).

[1/2] name-rev: wrap both blocks in braces
[2/2] name-rev: learn --format=<pretty>

 Documentation/git-name-rev.adoc |  10 ++-
 builtin/name-rev.c              | 108 ++++++++++++++++++++++++++++----
 t/t6120-describe.sh             |  96 ++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+), 12 deletions(-)

Interdiff against v1:
diff --git a/Documentation/git-name-rev.adoc b/Documentation/git-name-rev.adoc
index 8f050cd4763..65348690c8c 100644
--- a/Documentation/git-name-rev.adoc
+++ b/Documentation/git-name-rev.adoc
@@ -26,7 +26,8 @@ OPTIONS
 	Format revisions instead of outputting symbolic names. The
 	default is `--no-format`.
 +
-Implies `--name-only`.
+Implies `--name-only`. The negation `--no-format` implies
+`--no-name-only` (the default for the command).
 
 --tags::
 	Do not use branch names, but only tags to name the commits
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 30d981104c6..9a008d8b7a8 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -41,6 +41,11 @@ struct pretty_format {
 	struct userformat_want want;
 };
 
+struct format_cb_data {
+    const char *format;
+    int *name_only;
+};
+
 define_commit_slab(commit_rev_name, struct rev_name);
 
 static timestamp_t generation_cutoff = GENERATION_NUMBER_INFINITY;
@@ -486,7 +491,7 @@ static const char *get_rev_name(const struct object *o,
 		}
 
 		pretty_print_commit(&format_ctx->ctx, c, buf);
-		free(format_ctx->ctx.notes_message);
+		FREE_AND_NULL(format_ctx->ctx.notes_message);
 
 		return buf->buf;
 	}
@@ -551,7 +556,7 @@ static void name_rev_line(char *p,
 		if (!ishex(*p)) {
 			counter = 0;
 		} else if (++counter == hexsz &&
-			   !ishex(*(p + 1))) {
+			 !ishex(*(p+1))) {
 			struct object_id oid;
 			const char *name = NULL;
 			char c = *(p+1);
@@ -586,6 +591,16 @@ static void name_rev_line(char *p,
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
@@ -599,10 +614,12 @@ int cmd_name_rev(int argc,
 #endif
 	int all = 0, annotate_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
 	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
-	const char *format = NULL;
+	static struct format_cb_data format_cb_data = { 0 };
+	struct display_notes_opt format_notes_opt;
 	struct rev_info format_rev = REV_INFO_INIT;
 	struct pretty_format *format_ctx = NULL;
-	struct pretty_format format_pp = {0};
+	struct pretty_format format_pp = { 0 };
+	struct string_list notes = STRING_LIST_INIT_NODUP;
 	struct option opts[] = {
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
 		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
@@ -620,8 +637,10 @@ int cmd_name_rev(int argc,
 			   PARSE_OPT_HIDDEN),
 #endif /* WITH_BREAKING_CHANGES */
 		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
-		OPT_STRING(0, "format", &format, N_("format"),
-			   "pretty-print output instead"),
+		OPT_CALLBACK(0, "format", &format_cb_data, N_("format"),
+			     N_("pretty-print output instead"), format_cb),
+		OPT_STRING_LIST(0, "notes", &notes, N_("notes"),
+				N_("display notes for --format")),
 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
 		OPT_BOOL(0, "always",     &always,
 			   N_("show abbreviated commit object as fallback")),
@@ -630,6 +649,8 @@ int cmd_name_rev(int argc,
 		OPT_END(),
 	};
 
+	init_display_notes(&format_notes_opt);
+	format_cb_data.name_only = &data.name_only;
 	mem_pool_init(&string_pool, 0);
 	init_commit_rev_name(&rev_names);
 	repo_config(the_repository, git_default_config, NULL);
@@ -644,27 +665,29 @@ int cmd_name_rev(int argc,
 	}
 #endif
 
-	if (format) {
-		struct pretty_print_context ctx = {0};
-		struct userformat_want want = {0};
-
-		get_commit_format(format, &format_rev);
-		ctx.rev = &format_rev;
-		ctx.fmt = format_rev.commit_format;
-		ctx.abbrev = format_rev.abbrev;
-		ctx.date_mode_explicit = format_rev.date_mode_explicit;
-		ctx.date_mode = format_rev.date_mode;
-		ctx.color = GIT_COLOR_AUTO;
-		format_pp.ctx = ctx;
-
-		userformat_find_requirements(format, &want);
-		if (want.notes)
-			load_display_notes(NULL);
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
 
-		format_pp.want = want;
 		format_ctx = &format_pp;
-
-		data.name_only = true;
 	}
 
 	if (all + annotate_stdin + !!argc > 1) {
@@ -747,6 +770,8 @@ int cmd_name_rev(int argc,
 
 	string_list_clear(&data.ref_filters, 0);
 	string_list_clear(&data.exclude_filters, 0);
+	string_list_clear(&notes, 0);
+	release_display_notes(&format_notes_opt);
 	mem_pool_discard(&string_pool, 0);
 	object_array_clear(&revs);
 	return 0;
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 6dba392d343..0b7e9fe396d 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -671,6 +671,25 @@ test_expect_success 'name-rev --format setup' '
 	test_commit -C repo-format eighth
 '
 
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
 test_expect_success 'name-rev --format=%s for argument revs' '
 	cat >expect <<-\EOF &&
 	eighth
@@ -682,7 +701,7 @@ test_expect_success 'name-rev --format=%s for argument revs' '
 	test_cmp expect actual
 '
 
-test_expect_success '--name-rev --format=<pretty> --annotate-stdin from rev-list same as log' '
+test_expect_success '--name-rev --format=reference --annotate-stdin from rev-list same as log' '
 	git -C repo-format log --format=reference >expect &&
 	test_file_not_empty expect &&
 	git -C repo-format rev-list HEAD >list &&
@@ -707,7 +726,7 @@ test_expect_success '--name-rev --format=<pretty> --annotate-stdin with running
 	test_cmp expect actual
 '
 
-test_expect_success '--name-rev --format=<pretty> with a note' '
+test_expect_success 'name-rev --format=<pretty> with %N (note)' '
 	test_when_finished "git -C repo-format notes remove" &&
 	git -C repo-format notes add -m"Make a note" &&
 	printf "Make a note\n\n\n" >expect &&
@@ -716,6 +735,25 @@ test_expect_success '--name-rev --format=<pretty> with a note' '
 	test_cmp expect actual
 '
 
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
Range-diff against v1:
1:  6f88b4c96a9 ! 1:  9cb5cfd1ec3 name-rev: wrap both blocks in braces
    @@ builtin/name-rev.c: static void name_rev_line(char *p, struct name_ref_data *dat
     +		if (!ishex(*p)) {
      			counter = 0;
     -		else if (++counter == hexsz &&
    --			 !ishex(*(p+1))) {
     +		} else if (++counter == hexsz &&
    -+			   !ishex(*(p + 1))) {
    + 			 !ishex(*(p+1))) {
      			struct object_id oid;
      			const char *name = NULL;
    - 			char c = *(p+1);
2:  6430627e611 ! 2:  52a52060776 name-rev: learn --format=<pretty>
    @@ Documentation/git-name-rev.adoc: format parsable by 'git rev-parse'.
     +	Format revisions instead of outputting symbolic names. The
     +	default is `--no-format`.
     ++
    -+Implies `--name-only`.
    ++Implies `--name-only`. The negation `--no-format` implies
    ++`--no-name-only` (the default for the command).
     +
      --tags::
      	Do not use branch names, but only tags to name the commits
    @@ builtin/name-rev.c: struct rev_name {
     +	struct pretty_print_context ctx;
     +	struct userformat_want want;
     +};
    ++
    ++struct format_cb_data {
    ++    const char *format;
    ++    int *name_only;
    ++};
     +
      define_commit_slab(commit_rev_name, struct rev_name);
      
    @@ builtin/name-rev.c: static const char *get_rev_name(const struct object *o, stru
     +		}
     +
     +		pretty_print_commit(&format_ctx->ctx, c, buf);
    -+		free(format_ctx->ctx.notes_message);
    ++		FREE_AND_NULL(format_ctx->ctx.notes_message);
     +
     +		return buf->buf;
     +	}
    @@ builtin/name-rev.c: static void name_rev_line(char *p, struct name_ref_data *dat
      			}
      			*(p+1) = c;
      
    +@@ builtin/name-rev.c: static void name_rev_line(char *p, struct name_ref_data *data)
    + 	strbuf_release(&buf);
    + }
    + 
    ++static int format_cb(const struct option *option,
    ++		     const char *arg,
    ++		     int unset)
    ++{
    ++	struct format_cb_data *data = option->value;
    ++	data->format = arg;
    ++	*data->name_only = !unset;
    ++	return 0;
    ++}
    ++
    + int cmd_name_rev(int argc,
    + 		 const char **argv,
    + 		 const char *prefix,
     @@ builtin/name-rev.c: int cmd_name_rev(int argc,
      #endif
      	int all = 0, annotate_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
      	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
    -+	const char *format = NULL;
    ++	static struct format_cb_data format_cb_data = { 0 };
    ++	struct display_notes_opt format_notes_opt;
     +	struct rev_info format_rev = REV_INFO_INIT;
     +	struct pretty_format *format_ctx = NULL;
    -+	struct pretty_format format_pp = {0};
    ++	struct pretty_format format_pp = { 0 };
    ++	struct string_list notes = STRING_LIST_INIT_NODUP;
      	struct option opts[] = {
      		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
      		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
    @@ builtin/name-rev.c: int cmd_name_rev(int argc,
      			   PARSE_OPT_HIDDEN),
      #endif /* WITH_BREAKING_CHANGES */
      		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
    -+		OPT_STRING(0, "format", &format, N_("format"),
    -+			   "pretty-print output instead"),
    ++		OPT_CALLBACK(0, "format", &format_cb_data, N_("format"),
    ++			     N_("pretty-print output instead"), format_cb),
    ++		OPT_STRING_LIST(0, "notes", &notes, N_("notes"),
    ++				N_("display notes for --format")),
      		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
      		OPT_BOOL(0, "always",     &always,
      			   N_("show abbreviated commit object as fallback")),
    +@@ builtin/name-rev.c: int cmd_name_rev(int argc,
    + 		OPT_END(),
    + 	};
    + 
    ++	init_display_notes(&format_notes_opt);
    ++	format_cb_data.name_only = &data.name_only;
    + 	mem_pool_init(&string_pool, 0);
    + 	init_commit_rev_name(&rev_names);
    + 	repo_config(the_repository, git_default_config, NULL);
     @@ builtin/name-rev.c: int cmd_name_rev(int argc,
      	}
      #endif
      
    -+	if (format) {
    -+		struct pretty_print_context ctx = {0};
    -+		struct userformat_want want = {0};
    ++	if (format_cb_data.format) {
    ++		get_commit_format(format_cb_data.format, &format_rev);
    ++		format_pp.ctx.rev = &format_rev;
    ++		format_pp.ctx.fmt = format_rev.commit_format;
    ++		format_pp.ctx.abbrev = format_rev.abbrev;
    ++		format_pp.ctx.date_mode_explicit = format_rev.date_mode_explicit;
    ++		format_pp.ctx.date_mode = format_rev.date_mode;
    ++		format_pp.ctx.color = GIT_COLOR_AUTO;
     +
    -+		get_commit_format(format, &format_rev);
    -+		ctx.rev = &format_rev;
    -+		ctx.fmt = format_rev.commit_format;
    -+		ctx.abbrev = format_rev.abbrev;
    -+		ctx.date_mode_explicit = format_rev.date_mode_explicit;
    -+		ctx.date_mode = format_rev.date_mode;
    -+		ctx.color = GIT_COLOR_AUTO;
    -+		format_pp.ctx = ctx;
    ++		userformat_find_requirements(format_cb_data.format,
    ++					     &format_pp.want);
    ++		if (format_pp.want.notes) {
    ++			int ignore_show_notes = 0;
    ++			struct string_list_item *n;
     +
    -+		userformat_find_requirements(format, &want);
    -+		if (want.notes)
    -+			load_display_notes(NULL);
    ++			for_each_string_list_item(n, &notes)
    ++				enable_ref_display_notes(&format_notes_opt,
    ++							 &ignore_show_notes,
    ++							 n->string);
    ++			load_display_notes(&format_notes_opt);
    ++		}
     +
    -+		format_pp.want = want;
     +		format_ctx = &format_pp;
    -+
    -+		data.name_only = true;
     +	}
     +
      	if (all + annotate_stdin + !!argc > 1) {
    @@ builtin/name-rev.c: int cmd_name_rev(int argc,
      				  always, allow_undefined, data.name_only);
      	}
      
    + 	string_list_clear(&data.ref_filters, 0);
    + 	string_list_clear(&data.exclude_filters, 0);
    ++	string_list_clear(&notes, 0);
    ++	release_display_notes(&format_notes_opt);
    + 	mem_pool_discard(&string_pool, 0);
    + 	object_array_clear(&revs);
    + 	return 0;
     
      ## t/t6120-describe.sh ##
     @@ t/t6120-describe.sh: test_expect_success 'name-rev --annotate-stdin works with commitGraph' '
    @@ t/t6120-describe.sh: test_expect_success 'name-rev --annotate-stdin works with c
     +	test_commit -C repo-format eighth
     +'
     +
    ++test_expect_success 'name-rev --format --no-name-only' '
    ++	cat >expect <<-\EOF &&
    ++	HEAD~3 [fifth]
    ++	HEAD [eighth]
    ++	HEAD~5 [third]
    ++	EOF
    ++	git -C repo-format name-rev --format="[%s]" \
    ++		--no-name-only HEAD~3 HEAD HEAD~5 >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'name-rev --format --no-format is the same as regular name-rev' '
    ++	git -C repo-format name-rev HEAD~2 HEAD~3 >expect &&
    ++	test_file_not_empty expect &&
    ++	git -C repo-format name-rev --format="huh?" \
    ++		--no-format HEAD~2 HEAD~3 >actual &&
    ++	test_cmp expect actual
    ++'
    ++
     +test_expect_success 'name-rev --format=%s for argument revs' '
     +	cat >expect <<-\EOF &&
     +	eighth
    @@ t/t6120-describe.sh: test_expect_success 'name-rev --annotate-stdin works with c
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success '--name-rev --format=<pretty> --annotate-stdin from rev-list same as log' '
    ++test_expect_success '--name-rev --format=reference --annotate-stdin from rev-list same as log' '
     +	git -C repo-format log --format=reference >expect &&
     +	test_file_not_empty expect &&
     +	git -C repo-format rev-list HEAD >list &&
    @@ t/t6120-describe.sh: test_expect_success 'name-rev --annotate-stdin works with c
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success '--name-rev --format=<pretty> with a note' '
    ++test_expect_success 'name-rev --format=<pretty> with %N (note)' '
     +	test_when_finished "git -C repo-format notes remove" &&
     +	git -C repo-format notes add -m"Make a note" &&
     +	printf "Make a note\n\n\n" >expect &&
    @@ t/t6120-describe.sh: test_expect_success 'name-rev --annotate-stdin works with c
     +		HEAD HEAD~ >actual &&
     +	test_cmp expect actual
     +'
    ++
    ++test_expect_success 'name-rev --format=<pretty> --notes<ref>' '
    ++	# One custom notes ref
    ++	test_when_finished "git -C repo-format notes remove" &&
    ++	test_when_finished "git -C repo-format notes --ref=word remove" &&
    ++	git -C repo-format notes add -m"default" &&
    ++	git -C repo-format notes --ref=word add -m"custom" &&
    ++	printf "custom\n\n" >expect &&
    ++	git -C repo-format name-rev --format="tformat:%N" \
    ++		--notes=word \
    ++		HEAD >actual &&
    ++	test_cmp expect actual &&
    ++	# Glob all
    ++	printf "default\ncustom\n\n" >expect &&
    ++	git -C repo-format name-rev --format="tformat:%N" \
    ++		--notes=* \
    ++		HEAD >actual &&
    ++	test_cmp expect actual
    ++'
     +
      #               B
      #               o

base-commit: 67006b9db8b772423ad0706029286096307d2567
-- 
2.53.0.32.gf6228eaf9cc

