Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3394336DA18
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790447278; cv=none; b=YbNoBWVAgHpOQsww9Ulv7PO2x3ZSWbyVGvO875Pt6oKSKj/StkrwZXyVNFQgsXvgttTeUxNjT+wN3FPOR8OeyUjhMSLRSNIfIRyB+oYfV0YEBjqeqGyrBsh70sawkDizjQgPS3I6gM1wFl/HNBz0myIeykoIc1Hl35NH+I543yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790447278; c=relaxed/simple;
	bh=XFtCSbWlJozmknXaxYnRBqYTPsEjVt7PIyHGJh/h1g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=udxfv39gXMuM3ZSZxNT3BcLpQbQF8scmBxYbqyCaidcDVSfuY/XbGHRpMvLH+GdLndrEkxND9BHGjzsnfnRaKckwOhDPg5cLre268Nuch0/Q+vnLzpJ2o0KZ+wRcCqymHiHX9GClFqYOTHarWv/PXLgzMOLSFvNa4Y71u/hk3hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=C5K6fjux; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ua9XDqTR; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="C5K6fjux";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ua9XDqTR"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 442921400077;
	Sat, 26 Sep 2026 14:27:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sat, 26 Sep 2026 14:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790447274;
	 x=1790533674; bh=13g1aPDV2kcM0OG5cUgB8g1OzD1U9QQOuSw3M5hL7XM=; b=
	C5K6fjuxiQ3VF240d0avvt1IoZkd7pMJHFNxCabUT+xFqLutAVua3q8FFS/TQrlw
	5zJaBehnyJuRm5Lx/BmrA3iHmBfivDwEBt9k2Ph70RxiPehAq9mNpzZ6ETFwUjuY
	06NMypi/AhMqQUNUt3Adj3k/NxftyL6m0gYzzbAv1H4dXctC8LpD2q3BCOG+8x2S
	HWRbCj9ycLtXqNSeibHRYCiTRNUsiXuJNaAv9LBTk7DeDTDlwKukbIGuif7xMvHU
	ZvSzJN7c6ZvhigjlW+L1Tci2ttG3qTvLG81I9xepFdx5samO3meIGGkluOesigP1
	nWi6S0uYeBjkak3pT9h/6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790447274; x=
	1790533674; bh=13g1aPDV2kcM0OG5cUgB8g1OzD1U9QQOuSw3M5hL7XM=; b=U
	a9XDqTR6et6e0nDMMjOCCJ3T6nsV5NI4yIi2Pve4FaX2FbRkJIiUbf2I70tt/2nu
	bBpteJqc79D4XqIe5Srdongfwsbff0o6CThUXhLr65HeBB4Mk4kjz2YDIEHWA8p2
	miTxjMGSgDY3kW5n7mpeS3bJmBX5sPFLGTpkZcYEuSKXgPjgeMd3Ab4dKOHxFbBu
	a6IdG+x+MsABQsFFxVXXxQExGEeJXQNCxmBdhB9Hc4XJLIyrRCd0511KPA4JNsmr
	MTNO2RVoxNzyuhaZdbWoSo1wg5tG+C45pNFW8RFqXZCBmgApiDw4AwvyYRygx2R5
	4Odf2LAYLCONS0S9IiX3g==
X-ME-Sender: <xms:qg64aoDJGv_oCktZbHeVs1HsbFXKZ7d6dKcxRzgpl0S2iG2bBke10CM>
    <xme:qg64ahiMn9SYwi8x_4Z4ahGPK_NjHd2d1FiFJqMHGUnKxz27iWYeujbLbwHAcd1do
    n15mFs4fGfGN9MKcSiQYV_HueInbcw3-Tb0gopzZOLZm6SmhJcivw>
X-ME-Received: <xmr:qg64aglE1kPflzXXpBcv2YTdenpwWbNE-5ZXrpyYtuPLYmLozo1CjYEUawiCBCOPQH54rNsmNXvZeqTJzJ54M62IxwMHcLrUvj9hgnnNwzUk0iQY8oXcXT4>
X-ME-Proxy-Cause: dmFkZTFyUo30xQn3OmCMRSy1OF8qqyixS8PGjQ9Ncy39rdpRwIjUyz0WqtGOE/01d+2edI
    9kjkWkRM/X36RtC6qG8X40RE6MyJb97S31PdibsYKhMDuRixSKxZaDJvOkWeP1eMrOSd71
    q7C2pfAsKHW62CfuY39Y7Ovq38+JgZVXdnfT4VncS+pIbLP4JDJ5eVoV/CD6iaj30kSm4I
    WPia8dnlt82gKCaVW+fnFPkPeSXMt4VGKLDpTFLGWJdG8MEqnb8PbzM3EAtIMnYIQ4kQJp
    u0nqJA7W39epU9+7VAPUTk7LXBqjfCCmJfXKGVvjCt0Qr0bqDZ3pLTHMZH310LqpetY3CO
    Ynbr6i9b530pd7EaluMYErtthcxSbr/pvUX+C7vgWn12eCFh8IRkxjK+Cl8BkyMR9xFpGi
    CLuwVEFDbgZFcMoKUNEqAcffwTbyqxIu+6YCfnSRUvUEE9FppH0RmnVfl5ynvJOncOXygA
    kcRyebIJV2LgIzL/QzhJexKY6+9j3lBpVusbxhXcstHquh42Znb7GsaAO4YGMezTvHuEhi
    pKkzGiJyjfGzfVf+iqROXqgVs93GPyVjQBUbjoqgkYTDBfVJTEGfasfqgi48DrWU0mRehR
    8pyMcJ+2SJTlkUkCuChkoYsSyQnhTxRzs0Fujz+AOamVYuswyVSP/4FIS8+w
X-ME-Proxy: <xmx:qg64atobx8LA5tn4jZmIzD6QBxYBtY0cqyTjW1W9wKpFXoXbzg-Zpw>
    <xmx:qg64apHtBTjGO39IvI4uyIHUGo2f_lrXdr0yHLSHw80ItukwDXPXgw>
    <xmx:qg64apy6ODx5LAMbv1yqd6QPCVCEgGnROxiTvItOAsHFs9XvrWRmmA>
    <xmx:qg64auqvinN7bS7AK6CEaPEWF-1ufnPRS3Xedz7QXDHDHt0IjleAuA>
    <xmx:qg64aoFvyjOekbF4D7eNSocuOgauXin6O7IflmxwkDxuCXQnQK8OI-Wm>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Sep 2026 14:27:53 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] format-patch: learn --[no-]range-diff-notes
Date: Sat, 26 Sep 2026 20:27:44 +0200
Message-ID: <V2_CV_format-patch_learn_--range-diff-notes.cdb@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name (applied): kh/format-patch-range-diff-notes

Topic summary: Teach 'format-patch' options to tweak notes output in the
range diff independent of what notes are output in the patches.

Hey, sorry if someone got duplicate emails right now! I tried to send out
about ten minutes ago but it didn’t hit the list. It turned out that there
was no `To` header.

Well I don’t know if emails without `To` are sent to the `Cc` addresses.

***

See patch 2/2 for details.

This is motivated by wanting to turn off range diff notes, but the goal
here is to implement it in full generality.

(How many of us `git format-patch --notes` users are there out there? More
than a dozen? Maybe just D. Ben Knoble and me?)

I have implemented this behavior for myself and used it for many
months. But that was hacky and only suitable for one person’s use.
So this is a completely new implementation. In other words: this is
new code, *not* tested for months.

§ Changes in v2

This version drops the whole functionality around being able to *go
back* (and forth) to using `--notes` for the range diff.[1] The behavior
was too complex to explain and motivate compared to the utility (little).

🔗 1: https://lore.kernel.org/git/8f0a076b-4822-44e2-a842-cc1e39ae1c1d@app.fastmail.com/#t

This also means that the implementation is quite different. Now it just
uses a parse-options callback instead of adding if/else to
`revision.c:handle_revision_opt`.

See patch 2/2 for details.

Version 1 patch 2/3 is dropped. It was a rename motivated by the changes to
`struct rev_info` in version 1 patch 3/3, which is now gone. The v1 3/3
change needed the struct member to stay notes-only, but that is no longer
required.

[1/2] format-patch: simplify get_notes_arg parameters
[2/2] format-patch: learn --[no-]range-diff-notes

 Documentation/git-format-patch.adoc | 15 +++++
 builtin/log.c                       | 62 ++++++++++++++++++--
 t/t3206-range-diff.sh               | 87 +++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+), 6 deletions(-)

Interdiff against v1:
diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index e0ba435dfcf..5907f299a8d 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -378,22 +378,20 @@ case is to show comparison with an older iteration of the same
 topic and the tool should find more correspondence between the two
 sets of patches.
 
-`--range-diff-notes[=<ref>]`::
+`--range-diff-notes=<ref>`::
 `--no-range-diff-notes`::
 	Used with `--range-diff`, tweak what notes to display in the
-	range diff. For example, you can use `--no-range-diff-notes` to
-	turn off all notes in the range diff. The default behavior is
-	to display the same notes in the range diff as on the patches
-	(see `--notes`).
+	range diff.
 +
-You may want to turn off this notes override after it has been
-activated. Use this sequence to do that:
-+
-----
---no-range-diff-notes --range-diff-notes
-----
-+
-Now the range diff is back to displaying the same notes as the patches.
+The default behavior is to display the same notes in the range diff as
+on the patches; see `--notes`. But you can use these options to use a
+different list of notes. For example, say you have given three notes
+refs to `--notes`. At this point those same three notes will be
+displayed in the range diff. But then you pass
+`--range-diff-notes=<ref>`. Now the range diff will only display
+_<ref>_. You can of course pass more refs to this option, just like
+`--notes`. And you can also turn off all range diff notes with
+`--no-range-diff-notes`.
 
 `--notes[=<ref>]`::
 `--no-notes`::
diff --git a/builtin/log.c b/builtin/log.c
index de997bc9ab0..d70101f0755 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1327,27 +1327,65 @@ static void prepare_cover_text(struct pretty_print_context *pp,
 	strbuf_release(&subject_sb);
 }
 
+struct rdiff_notes {
+	/*
+	 * True if we want to override the notes behavior
+	 * of 'format-patch'
+	 */
+	bool override;
+	struct string_list notes;
+};
+
+static int rdiff_notes_cb(const struct option *option,
+		       const char *arg,
+		       int unset)
+{
+	struct rdiff_notes *rdiff_notes = option->value;
+
+	rdiff_notes->override = 1;
+
+	/*
+	 * The rest is the same as
+	 * parse-options-cb.c:parse_opt_string_list
+	 */
+	if (unset) {
+		string_list_clear(&rdiff_notes->notes, 0);
+		return 0;
+	}
+
+	if (!arg)
+		return -1;
+
+	string_list_append(&rdiff_notes->notes, arg);
+	return 0;
+}
+
 static int get_notes_refs(struct string_list_item *item, void *arg)
 {
 	strvec_pushf(arg, "--notes=%s", item->string);
 	return 0;
 }
 
-static void get_notes_args(struct rev_info *rev)
+static void get_notes_args(struct rdiff_notes *rdiff_notes,
+			   struct rev_info *rev)
 {
-	if (rev->rdiff_override_notes) {
-		if (!rev->rdiff_notes_arg.nr)
-			strvec_push(&rev->rdiff_notes_arg, "--no-notes");
+	if (rdiff_notes->override) {
+		if (rdiff_notes->notes.nr)
+			for_each_string_list(&rdiff_notes->notes,
+					     get_notes_refs,
+					     &rev->rdiff_log_arg);
+		else
+			strvec_push(&rev->rdiff_log_arg, "--no-notes");
 	} else if (!rev->show_notes) {
-		strvec_push(&rev->rdiff_notes_arg, "--no-notes");
+		strvec_push(&rev->rdiff_log_arg, "--no-notes");
 	} else if (rev->notes_opt.use_default_notes > 0 ||
 		   (rev->notes_opt.use_default_notes == -1 &&
 		    !rev->notes_opt.extra_notes_refs.nr)) {
-		strvec_push(&rev->rdiff_notes_arg, "--notes");
+		strvec_push(&rev->rdiff_log_arg, "--notes");
 	} else {
 		for_each_string_list(&rev->notes_opt.extra_notes_refs,
 				     get_notes_refs,
-				     &rev->rdiff_notes_arg);
+				     &rev->rdiff_log_arg);
 	}
 }
 
@@ -1478,7 +1516,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			.dual_color = 1,
 			.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
 			.diffopt = &opts,
-			.log_arg = &rev->rdiff_notes_arg
+			.log_arg = &rev->rdiff_log_arg
 		};
 
 		repo_diff_setup(the_repository, &opts);
@@ -1998,6 +2036,9 @@ int cmd_format_patch(int argc,
 	struct strbuf rdiff1 = STRBUF_INIT;
 	struct strbuf rdiff2 = STRBUF_INIT;
 	struct strbuf rdiff_title = STRBUF_INIT;
+	struct rdiff_notes rdiff_notes = {
+		.notes = STRING_LIST_INIT_NODUP,
+	};
 	const char *rfc = NULL;
 	int creation_factor = -1;
 	const char *signature = git_version_string;
@@ -2094,6 +2135,9 @@ int cmd_format_patch(int argc,
 			     parse_opt_object_name),
 		OPT_STRING(0, "range-diff", &rdiff_prev, N_("refspec"),
 			   N_("show changes against <refspec> in cover letter or single patch")),
+		OPT_CALLBACK_F(0, "range-diff-notes", &rdiff_notes, N_("note"),
+			       N_("override notes behavior for the range diff"),
+			       0, rdiff_notes_cb),
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("percentage by which creation is weighted")),
 		OPT_BOOL(0, "force-in-body-from", &force_in_body_from,
@@ -2409,7 +2453,7 @@ int cmd_format_patch(int argc,
 		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
 					     _("Range-diff:"),
 					     _("Range-diff against v%d:"));
-		get_notes_args(&rev);
+		get_notes_args(&rdiff_notes, &rev);
 	}
 
 	/*
@@ -2572,7 +2616,8 @@ int cmd_format_patch(int argc,
 	rev.diffopt.no_free = 0;
 	release_revisions(&rev);
 	format_config_release(&cfg);
-	strvec_clear(&rev.rdiff_notes_arg);
+	strvec_clear(&rev.rdiff_log_arg);
+	string_list_clear(&rdiff_notes.notes, 0);
 	return 0;
 }
 
diff --git a/log-tree.c b/log-tree.c
index fd6ddf32af4..83a3c4bf9b1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -718,7 +718,7 @@ static void show_diff_of_diff(struct rev_info *opt)
 			.dual_color = 1,
 			.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
 			.diffopt = &opts,
-			.log_arg = &opt->rdiff_notes_arg
+			.log_arg = &opt->rdiff_log_arg
 		};
 
 		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
diff --git a/revision.c b/revision.c
index 1e21f2861cc..50dc8b19913 100644
--- a/revision.c
+++ b/revision.c
@@ -2625,19 +2625,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->notes_opt.use_default_notes = 1;
 	} else if (!strcmp(arg, "--no-standard-notes")) {
 		revs->notes_opt.use_default_notes = 0;
-	} else if (!strcmp(arg, "--no-range-diff-notes")) {
-		strvec_clear(&revs->rdiff_notes_arg);
-		revs->rdiff_override_notes = 1;
-	} else if (!strcmp(arg, "--range-diff-notes")) {
-		/*
-		 * Allow the user to use '--no-range-diff-notes
-		 * --range-diff-notes' in order to go back to
-		 * using the 'format-patch' notes behavior
-		 */
-		revs->rdiff_override_notes = revs->rdiff_notes_arg.nr;
-	} else if (skip_prefix(arg, "--range-diff-notes=", &optarg)) {
-		strvec_pushf(&revs->rdiff_notes_arg, "--notes=%s", optarg);
-		revs->rdiff_override_notes = 1;
 	} else if (!strcmp(arg, "--oneline")) {
 		revs->verbose_header = 1;
 		get_commit_format("oneline", revs);
diff --git a/revision.h b/revision.h
index e8dbf774b00..acf6d06b241 100644
--- a/revision.h
+++ b/revision.h
@@ -351,12 +351,7 @@ struct rev_info {
 	/* range-diff */
 	const char *rdiff1;
 	const char *rdiff2;
-	/*
-	 * whether to use 'rdiff_notes_arg' or inherited
-	 * notes behavior
-	 */
-	bool rdiff_override_notes;
-	struct strvec rdiff_notes_arg;
+	struct strvec rdiff_log_arg;
 	int creation_factor;
 	const char *rdiff_title;
 
@@ -437,7 +432,7 @@ struct rev_info {
 	.expand_tabs_in_log = -1, \
 	.commit_format = CMIT_FMT_DEFAULT, \
 	.expand_tabs_in_log_default = 8, \
-	.rdiff_notes_arg = STRVEC_INIT, \
+	.rdiff_log_arg = STRVEC_INIT, \
 }
 
 /**
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index db238d0a5a1..640c5dec52e 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -845,28 +845,49 @@ test_expect_success 'format-patch --range-diff with multiple notes' '
 	test_cmp expect actual
 '
 
+# Unlike '--notes', '--range-diff-notes' requires a value
+test_expect_success 'format-patch --range-diff-notes requires a value' '
+	cat >expect <<-EOF &&
+	error: option \`range-diff-notes${SQ} requires a value
+	EOF
+	test_must_fail git format-patch --range-diff=main..topic \
+		--cover-letter --range-diff-notes 2>actual &&
+	test_cmp expect actual
+'
+
+# The '--range-diff-notes' has no effect but is allowed
+test_expect_success 'format-patch --range-diff-notes=not-a-note (no --range-diff)' '
+	test_when_finished "rm -f 000?-*" &&
+	git format-patch --range-diff-notes=not-a-note --cover-letter \
+		main..unmodified &&
+	test_when_finished "rm -f 000?-*" &&
+	test_file_not_empty 0000-cover-letter* &&
+	test_grep ! "^Range-diff:" 0000-cover-letter* &&
+	test_grep ! "## Notes " 0000-cover-letter*
+'
+
 test_expect_success 'format-patch --range-diff --notes=custom --no-range-diff-notes' '
 	test_when_finished "git notes --ref=custom remove topic unmodified || :" &&
 	git notes --ref=custom add -m "topic note1" topic &&
 	git notes --ref=custom add -m "unmodified note1" unmodified &&
 	test_when_finished "rm -f 000?-*" &&
-	git format-patch --range-diff=$prev --notes=custom \
+	git format-patch --range-diff=main..topic --notes=custom \
 		--no-range-diff-notes --cover-letter \
-		main..unmodified >actual &&
+		main..unmodified &&
 	test_grep "^Notes (custom):" 0004-* &&
 	test_grep "^Range-diff:" 0000-cover-letter* &&
 	test_grep ! "## Notes (custom) ##" 0000-cover-letter*
 '
 
-test_expect_success 'format-patch --range-diff --range-diff-notes uses --notes behavior' '
+test_expect_success 'format-patch --range-diff --no-notes --range-diff-notes=custom' '
 	test_when_finished "git notes --ref=custom remove topic unmodified || :" &&
 	git notes --ref=custom add -m "topic note1" topic &&
 	git notes --ref=custom add -m "unmodified note1" unmodified &&
 	test_when_finished "rm -f 000?-*" &&
-	git format-patch --range-diff=$prev --notes=custom \
-		--range-diff-notes --cover-letter \
-		main..unmodified >actual &&
-	test_grep "^Notes (custom):" 0004-* &&
+	git format-patch --range-diff=main..topic --no-notes \
+		--range-diff-notes=custom --cover-letter \
+		main..unmodified &&
+	test_grep ! "^Notes (custom):" 0004-* &&
 	test_grep "^Range-diff:" 0000-cover-letter* &&
 	test_grep "## Notes (custom) ##" 0000-cover-letter*
 '
@@ -879,9 +900,9 @@ test_expect_success 'format-patch --range-diff --notes=patch --range-diff-notes=
 	git notes --ref=rdiff add -m "only for range diff 1" topic &&
 	git notes --ref=rdiff add -m "only for range diff 2" unmodified &&
 	test_when_finished "rm -f 000?-*" &&
-	git format-patch --range-diff=$prev --notes=patch \
+	git format-patch --range-diff=main..topic --notes=patch \
 		--range-diff-notes=rdiff --cover-letter \
-		main..unmodified >actual &&
+		main..unmodified &&
 	test_grep "^Notes (patch):" 0004-* &&
 	test_grep ! "^Notes (rdiff):" 0004-* &&
 	test_grep "^Range-diff:" 0000-cover-letter* &&
@@ -889,50 +910,11 @@ test_expect_success 'format-patch --range-diff --notes=patch --range-diff-notes=
 	test_grep ! "## Notes (patch) ##" 0000-cover-letter*
 '
 
-test_expect_success 'format-patch --range-diff --no-range-diff-notes --range-diff-notes uses --notes behavior' '
-	test_when_finished "git notes --ref=custom remove topic unmodified || :" &&
-	git notes --ref=custom add -m "topic note1" topic &&
-	git notes --ref=custom add -m "unmodified note1" unmodified &&
-	test_when_finished "rm -f 000?-*" &&
-	git format-patch --range-diff=$prev --notes=custom \
-		--no-range-diff-notes --range-diff-notes --cover-letter \
-		main..unmodified >actual &&
-	test_grep "^Notes (custom):" 0004-* &&
-	test_grep "^Range-diff:" 0000-cover-letter* &&
-	test_grep "## Notes (custom) ##" 0000-cover-letter*
-'
-
-test_expect_success 'format-patch --range-diff --range-diff-notes uses --notes behavior' '
-	test_when_finished "git notes --ref=custom remove topic unmodified || :" &&
-	git notes --ref=custom add -m "topic note1" topic &&
-	git notes --ref=custom add -m "unmodified note1" unmodified &&
-	test_when_finished "rm -f 000?-*" &&
-	git format-patch --range-diff=$prev --notes=custom \
-		--range-diff-notes --cover-letter \
-		main..unmodified >actual &&
-	test_grep "^Notes (custom):" 0004-* &&
-	test_grep "^Range-diff:" 0000-cover-letter* &&
-	test_grep "## Notes (custom) ##" 0000-cover-letter*
-'
-
-test_expect_success 'format-patch --range-diff --no-range-diff-notes does not use default notes' '
-	test_when_finished "git notes remove topic unmodified || :" &&
-	git notes add -m "topic note1" topic &&
-	git notes add -m "unmodified note1" unmodified &&
-	test_when_finished "rm -f 000?-*" &&
-	git format-patch --range-diff=$prev \
-		--no-range-diff-notes --cover-letter \
-		main..unmodified >actual &&
-	test_grep ! "^Notes:" 0004-* &&
-	test_grep "^Range-diff:" 0000-cover-letter* &&
-	test_grep ! "## Notes ##" 0000-cover-letter*
-'
-
 test_expect_success 'format-patch --range-diff --no-range-diff-notes on single patch' '
 	test_when_finished "git notes --ref=custom remove HEAD unmodified || :" &&
 	git notes --ref=custom add -m "topic note (custom)" HEAD &&
 	git notes --ref=custom add -m "unmodified note (custom)" unmodified &&
-	git format-patch --notes=custom --range-diff=$prev \
+	git format-patch --notes=custom --range-diff=main..topic \
 		--no-range-diff-notes -1 --stdout >actual &&
 	test_grep "Notes (custom):" actual &&
 	test_grep "^Range-diff:" actual &&
@@ -943,7 +925,7 @@ test_expect_success 'format-patch --range-diff --range-diff-notes=custom on sing
 	test_when_finished "git notes --ref=custom remove HEAD unmodified || :" &&
 	git notes --ref=custom add -m "topic note (custom)" HEAD &&
 	git notes --ref=custom add -m "unmodified note (custom)" unmodified &&
-	git format-patch --no-notes --range-diff=$prev \
+	git format-patch --range-diff=main..topic \
 		--range-diff-notes=custom -1 --stdout >actual &&
 	test_grep ! "Notes (custom):" actual &&
 	test_grep "^Range-diff:" actual &&
Range-diff against v1:
1:  977f9c2e97a = 1:  977f9c2e97a format-patch: simplify get_notes_arg parameters
2:  2a555d40ced < -:  ----------- revision.h: rename struct member to reflect notes role
3:  058f5fdc8da ! 2:  bf66e94e376 format-patch: learn --[no-]range-diff-notes
    @@ Commit message
         • No such options given
         • `--no-range-diff-notes`
     
    -    Well, we can’t. Therefore we need `rdiff_override_notes` to set whenever
    +    Well, we can’t. Therefore we need `rdiff_notes.override` to set whenever
         any of these options are given.
     
    -    However, we may also want to turn *off* this override. Just like how we
    -    can countermand any notes ref we pass in:
    -
    -        --notes=custom --no-notes
    -
    -    To that end, let’s make `--range-diff-notes` when the list of options is
    -    empty special. Then it means: go back to using whatever git-format-
    -    patch(1) wants to use.
    -
    -    Now, `--notes` is a bit special in that it has an optional
    -    argument. Implementing this with a parse-options callback is not
    -    user-friendly; the following does *not* mean what it looks like:
    -
    -        --parse-option --another-option
    -
    -    Namely, it is not a bare `--parse-option` followed by another
    -    option. Rather, it’s one option:
    -
    -        --parse-option=--another-option
    -
    -    And we need the bare `--range-diff-notes` form in order to turn off
    -    notes overriding. For that reason, let’s implement these new options in
    -    `revision.c:handle_revision_opt`, just like the `--notes` options are.
    -
         † 1: For example, let say we have two notes ref that are used for a
              patch series:
     
    @@ Commit message
     
         Note that using `--creation-factor` without `--range-diff` will cause
         the command to die. But this is not the case for `--[no-]range-diff-
    -    notes`. Yes, we could introduce struct member `rdiff_notes_arg_used` or
    -    something in order to detect the same condition. Or turn `rdiff_notes_
    -    override` into a tri-state `int`. But the extra code is not worth that
    -    in my opinion.
    +    notes`; we would have to check `rdiff_notes.override`, which is a sticky
    +    value (cannot be turned off). The reason is that it is potentially
    +    inconvenient to error out since it would not let you turn off
    +    `--range-diff` in, say, some alias that uses `--no-range-diff-
    +    notes`. Granted, it is difficult for me to come up with a concrete use
    +    case since `--range-diff` requires a value, specifically a value which
    +    is probably not that reusable (revision range), and yet you have
    +    something like an alias set up with it. But why spend code closing
    +    that door? There is no usability upside to erroring out.
    +
    +    ***
    +
    +    Add two tests here for the single-patch case, i.e. the case where the
    +    range diff is on the patch and not in the cover letter. These are meant
    +    as regression tests based on my encounter with single-patch range diff
    +    notes handling bug.[2]
    +
    +    † 2: 155986b4 (format-patch: handle range-diff on notes correctly for
    +         single patches, 2025-09-25)
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (testing) ##
    -    CI: https://github.com/LemmingAvalanche/git/actions/runs/32762207178
    +    CI: https://github.com/LemmingAvalanche/git/actions/runs/36231842902
    +
    +    This run is on a previous iteration where v1 patch/commit 2/3 was still
    +    there. But that is just a rename. So I compiled and tested
    +    `t/t3206-range-diff.sh` and took that as proof that the full CI/build run
    +    is still valid.
     
      ## Documentation/git-format-patch.adoc ##
     @@ Documentation/git-format-patch.adoc: case is to show comparison with an older iteration of the same
      topic and the tool should find more correspondence between the two
      sets of patches.
      
    -+`--range-diff-notes[=<ref>]`::
    ++`--range-diff-notes=<ref>`::
     +`--no-range-diff-notes`::
     +	Used with `--range-diff`, tweak what notes to display in the
    -+	range diff. For example, you can use `--no-range-diff-notes` to
    -+	turn off all notes in the range diff. The default behavior is
    -+	to display the same notes in the range diff as on the patches
    -+	(see `--notes`).
    -++
    -+You may want to turn off this notes override after it has been
    -+activated. Use this sequence to do that:
    ++	range diff.
     ++
    -+----
    -+--no-range-diff-notes --range-diff-notes
    -+----
    -++
    -+Now the range diff is back to displaying the same notes as the patches.
    ++The default behavior is to display the same notes in the range diff as
    ++on the patches; see `--notes`. But you can use these options to use a
    ++different list of notes. For example, say you have given three notes
    ++refs to `--notes`. At this point those same three notes will be
    ++displayed in the range diff. But then you pass
    ++`--range-diff-notes=<ref>`. Now the range diff will only display
    ++_<ref>_. You can of course pass more refs to this option, just like
    ++`--notes`. And you can also turn off all range diff notes with
    ++`--no-range-diff-notes`.
     +
      `--notes[=<ref>]`::
      `--no-notes`::
      	Append the notes (see linkgit:git-notes[1]) for the commit
     
      ## builtin/log.c ##
    -@@ builtin/log.c: static int get_notes_refs(struct string_list_item *item, void *arg)
    +@@ builtin/log.c: static void prepare_cover_text(struct pretty_print_context *pp,
    + 	strbuf_release(&subject_sb);
    + }
    + 
    ++struct rdiff_notes {
    ++	/*
    ++	 * True if we want to override the notes behavior
    ++	 * of 'format-patch'
    ++	 */
    ++	bool override;
    ++	struct string_list notes;
    ++};
    ++
    ++static int rdiff_notes_cb(const struct option *option,
    ++		       const char *arg,
    ++		       int unset)
    ++{
    ++	struct rdiff_notes *rdiff_notes = option->value;
    ++
    ++	rdiff_notes->override = 1;
    ++
    ++	/*
    ++	 * The rest is the same as
    ++	 * parse-options-cb.c:parse_opt_string_list
    ++	 */
    ++	if (unset) {
    ++		string_list_clear(&rdiff_notes->notes, 0);
    ++		return 0;
    ++	}
    ++
    ++	if (!arg)
    ++		return -1;
    ++
    ++	string_list_append(&rdiff_notes->notes, arg);
    ++	return 0;
    ++}
    ++
    + static int get_notes_refs(struct string_list_item *item, void *arg)
    + {
    + 	strvec_pushf(arg, "--notes=%s", item->string);
    + 	return 0;
    + }
      
    - static void get_notes_args(struct rev_info *rev)
    +-static void get_notes_args(struct rev_info *rev)
    ++static void get_notes_args(struct rdiff_notes *rdiff_notes,
    ++			   struct rev_info *rev)
      {
     -	if (!rev->show_notes) {
    -+	if (rev->rdiff_override_notes) {
    -+		if (!rev->rdiff_notes_arg.nr)
    -+			strvec_push(&rev->rdiff_notes_arg, "--no-notes");
    ++	if (rdiff_notes->override) {
    ++		if (rdiff_notes->notes.nr)
    ++			for_each_string_list(&rdiff_notes->notes,
    ++					     get_notes_refs,
    ++					     &rev->rdiff_log_arg);
    ++		else
    ++			strvec_push(&rev->rdiff_log_arg, "--no-notes");
     +	} else if (!rev->show_notes) {
    - 		strvec_push(&rev->rdiff_notes_arg, "--no-notes");
    + 		strvec_push(&rev->rdiff_log_arg, "--no-notes");
      	} else if (rev->notes_opt.use_default_notes > 0 ||
      		   (rev->notes_opt.use_default_notes == -1 &&
    -
    - ## revision.c ##
    -@@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
    - 		revs->notes_opt.use_default_notes = 1;
    - 	} else if (!strcmp(arg, "--no-standard-notes")) {
    - 		revs->notes_opt.use_default_notes = 0;
    -+	} else if (!strcmp(arg, "--no-range-diff-notes")) {
    -+		strvec_clear(&revs->rdiff_notes_arg);
    -+		revs->rdiff_override_notes = 1;
    -+	} else if (!strcmp(arg, "--range-diff-notes")) {
    -+		/*
    -+		 * Allow the user to use '--no-range-diff-notes
    -+		 * --range-diff-notes' in order to go back to
    -+		 * using the 'format-patch' notes behavior
    -+		 */
    -+		revs->rdiff_override_notes = revs->rdiff_notes_arg.nr;
    -+	} else if (skip_prefix(arg, "--range-diff-notes=", &optarg)) {
    -+		strvec_pushf(&revs->rdiff_notes_arg, "--notes=%s", optarg);
    -+		revs->rdiff_override_notes = 1;
    - 	} else if (!strcmp(arg, "--oneline")) {
    - 		revs->verbose_header = 1;
    - 		get_commit_format("oneline", revs);
    -
    - ## revision.h ##
    -@@ revision.h: struct rev_info {
    - 	/* range-diff */
    - 	const char *rdiff1;
    - 	const char *rdiff2;
    -+	/*
    -+	 * whether to use 'rdiff_notes_arg' or inherited
    -+	 * notes behavior
    -+	 */
    -+	bool rdiff_override_notes;
    - 	struct strvec rdiff_notes_arg;
    - 	int creation_factor;
    - 	const char *rdiff_title;
    +@@ builtin/log.c: int cmd_format_patch(int argc,
    + 	struct strbuf rdiff1 = STRBUF_INIT;
    + 	struct strbuf rdiff2 = STRBUF_INIT;
    + 	struct strbuf rdiff_title = STRBUF_INIT;
    ++	struct rdiff_notes rdiff_notes = {
    ++		.notes = STRING_LIST_INIT_NODUP,
    ++	};
    + 	const char *rfc = NULL;
    + 	int creation_factor = -1;
    + 	const char *signature = git_version_string;
    +@@ builtin/log.c: int cmd_format_patch(int argc,
    + 			     parse_opt_object_name),
    + 		OPT_STRING(0, "range-diff", &rdiff_prev, N_("refspec"),
    + 			   N_("show changes against <refspec> in cover letter or single patch")),
    ++		OPT_CALLBACK_F(0, "range-diff-notes", &rdiff_notes, N_("note"),
    ++			       N_("override notes behavior for the range diff"),
    ++			       0, rdiff_notes_cb),
    + 		OPT_INTEGER(0, "creation-factor", &creation_factor,
    + 			    N_("percentage by which creation is weighted")),
    + 		OPT_BOOL(0, "force-in-body-from", &force_in_body_from,
    +@@ builtin/log.c: int cmd_format_patch(int argc,
    + 		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
    + 					     _("Range-diff:"),
    + 					     _("Range-diff against v%d:"));
    +-		get_notes_args(&rev);
    ++		get_notes_args(&rdiff_notes, &rev);
    + 	}
    + 
    + 	/*
    +@@ builtin/log.c: int cmd_format_patch(int argc,
    + 	release_revisions(&rev);
    + 	format_config_release(&cfg);
    + 	strvec_clear(&rev.rdiff_log_arg);
    ++	string_list_clear(&rdiff_notes.notes, 0);
    + 	return 0;
    + }
    + 
     
      ## t/t3206-range-diff.sh ##
     @@ t/t3206-range-diff.sh: test_expect_success 'format-patch --range-diff with multiple notes' '
      	test_cmp expect actual
      '
      
    ++# Unlike '--notes', '--range-diff-notes' requires a value
    ++test_expect_success 'format-patch --range-diff-notes requires a value' '
    ++	cat >expect <<-EOF &&
    ++	error: option \`range-diff-notes${SQ} requires a value
    ++	EOF
    ++	test_must_fail git format-patch --range-diff=main..topic \
    ++		--cover-letter --range-diff-notes 2>actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++# The '--range-diff-notes' has no effect but is allowed
    ++test_expect_success 'format-patch --range-diff-notes=not-a-note (no --range-diff)' '
    ++	test_when_finished "rm -f 000?-*" &&
    ++	git format-patch --range-diff-notes=not-a-note --cover-letter \
    ++		main..unmodified &&
    ++	test_when_finished "rm -f 000?-*" &&
    ++	test_file_not_empty 0000-cover-letter* &&
    ++	test_grep ! "^Range-diff:" 0000-cover-letter* &&
    ++	test_grep ! "## Notes " 0000-cover-letter*
    ++'
    ++
     +test_expect_success 'format-patch --range-diff --notes=custom --no-range-diff-notes' '
     +	test_when_finished "git notes --ref=custom remove topic unmodified || :" &&
     +	git notes --ref=custom add -m "topic note1" topic &&
     +	git notes --ref=custom add -m "unmodified note1" unmodified &&
     +	test_when_finished "rm -f 000?-*" &&
    -+	git format-patch --range-diff=$prev --notes=custom \
    ++	git format-patch --range-diff=main..topic --notes=custom \
     +		--no-range-diff-notes --cover-letter \
    -+		main..unmodified >actual &&
    ++		main..unmodified &&
     +	test_grep "^Notes (custom):" 0004-* &&
     +	test_grep "^Range-diff:" 0000-cover-letter* &&
     +	test_grep ! "## Notes (custom) ##" 0000-cover-letter*
     +'
     +
    -+test_expect_success 'format-patch --range-diff --range-diff-notes uses --notes behavior' '
    ++test_expect_success 'format-patch --range-diff --no-notes --range-diff-notes=custom' '
     +	test_when_finished "git notes --ref=custom remove topic unmodified || :" &&
     +	git notes --ref=custom add -m "topic note1" topic &&
     +	git notes --ref=custom add -m "unmodified note1" unmodified &&
     +	test_when_finished "rm -f 000?-*" &&
    -+	git format-patch --range-diff=$prev --notes=custom \
    -+		--range-diff-notes --cover-letter \
    -+		main..unmodified >actual &&
    -+	test_grep "^Notes (custom):" 0004-* &&
    ++	git format-patch --range-diff=main..topic --no-notes \
    ++		--range-diff-notes=custom --cover-letter \
    ++		main..unmodified &&
    ++	test_grep ! "^Notes (custom):" 0004-* &&
     +	test_grep "^Range-diff:" 0000-cover-letter* &&
     +	test_grep "## Notes (custom) ##" 0000-cover-letter*
     +'
    @@ t/t3206-range-diff.sh: test_expect_success 'format-patch --range-diff with multi
     +	git notes --ref=rdiff add -m "only for range diff 1" topic &&
     +	git notes --ref=rdiff add -m "only for range diff 2" unmodified &&
     +	test_when_finished "rm -f 000?-*" &&
    -+	git format-patch --range-diff=$prev --notes=patch \
    ++	git format-patch --range-diff=main..topic --notes=patch \
     +		--range-diff-notes=rdiff --cover-letter \
    -+		main..unmodified >actual &&
    ++		main..unmodified &&
     +	test_grep "^Notes (patch):" 0004-* &&
     +	test_grep ! "^Notes (rdiff):" 0004-* &&
     +	test_grep "^Range-diff:" 0000-cover-letter* &&
    @@ t/t3206-range-diff.sh: test_expect_success 'format-patch --range-diff with multi
     +	test_grep ! "## Notes (patch) ##" 0000-cover-letter*
     +'
     +
    -+test_expect_success 'format-patch --range-diff --no-range-diff-notes --range-diff-notes uses --notes behavior' '
    -+	test_when_finished "git notes --ref=custom remove topic unmodified || :" &&
    -+	git notes --ref=custom add -m "topic note1" topic &&
    -+	git notes --ref=custom add -m "unmodified note1" unmodified &&
    -+	test_when_finished "rm -f 000?-*" &&
    -+	git format-patch --range-diff=$prev --notes=custom \
    -+		--no-range-diff-notes --range-diff-notes --cover-letter \
    -+		main..unmodified >actual &&
    -+	test_grep "^Notes (custom):" 0004-* &&
    -+	test_grep "^Range-diff:" 0000-cover-letter* &&
    -+	test_grep "## Notes (custom) ##" 0000-cover-letter*
    -+'
    -+
    -+test_expect_success 'format-patch --range-diff --range-diff-notes uses --notes behavior' '
    -+	test_when_finished "git notes --ref=custom remove topic unmodified || :" &&
    -+	git notes --ref=custom add -m "topic note1" topic &&
    -+	git notes --ref=custom add -m "unmodified note1" unmodified &&
    -+	test_when_finished "rm -f 000?-*" &&
    -+	git format-patch --range-diff=$prev --notes=custom \
    -+		--range-diff-notes --cover-letter \
    -+		main..unmodified >actual &&
    -+	test_grep "^Notes (custom):" 0004-* &&
    -+	test_grep "^Range-diff:" 0000-cover-letter* &&
    -+	test_grep "## Notes (custom) ##" 0000-cover-letter*
    -+'
    -+
    -+test_expect_success 'format-patch --range-diff --no-range-diff-notes does not use default notes' '
    -+	test_when_finished "git notes remove topic unmodified || :" &&
    -+	git notes add -m "topic note1" topic &&
    -+	git notes add -m "unmodified note1" unmodified &&
    -+	test_when_finished "rm -f 000?-*" &&
    -+	git format-patch --range-diff=$prev \
    -+		--no-range-diff-notes --cover-letter \
    -+		main..unmodified >actual &&
    -+	test_grep ! "^Notes:" 0004-* &&
    -+	test_grep "^Range-diff:" 0000-cover-letter* &&
    -+	test_grep ! "## Notes ##" 0000-cover-letter*
    -+'
    -+
     +test_expect_success 'format-patch --range-diff --no-range-diff-notes on single patch' '
     +	test_when_finished "git notes --ref=custom remove HEAD unmodified || :" &&
     +	git notes --ref=custom add -m "topic note (custom)" HEAD &&
     +	git notes --ref=custom add -m "unmodified note (custom)" unmodified &&
    -+	git format-patch --notes=custom --range-diff=$prev \
    ++	git format-patch --notes=custom --range-diff=main..topic \
     +		--no-range-diff-notes -1 --stdout >actual &&
     +	test_grep "Notes (custom):" actual &&
     +	test_grep "^Range-diff:" actual &&
    @@ t/t3206-range-diff.sh: test_expect_success 'format-patch --range-diff with multi
     +	test_when_finished "git notes --ref=custom remove HEAD unmodified || :" &&
     +	git notes --ref=custom add -m "topic note (custom)" HEAD &&
     +	git notes --ref=custom add -m "unmodified note (custom)" unmodified &&
    -+	git format-patch --no-notes --range-diff=$prev \
    ++	git format-patch --range-diff=main..topic \
     +		--range-diff-notes=custom -1 --stdout >actual &&
     +	test_grep ! "Notes (custom):" actual &&
     +	test_grep "^Range-diff:" actual &&

base-commit: 1a3e64c6c4a623626ff0687008732a8e007e2a1c
-- 
2.55.0.793.gc667de3f2c5

