Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0308A30B52D
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820099; cv=none; b=ICrlW4LU0sk6swWiwSlVsEOeITDUUqBtm2NawjbLkoBhJ0kxN/Cd6AN3DW9BQYFlBrQ6iBFfG26sXeKd9qK2/fucnImpowRJhY5Fa/d7hgHJ2FZXJPnXOKJE3QAnldAx1uZY4IIbsMJeOtAnRAk1qCoD3oqbEvjSMrVLE4KH1zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820099; c=relaxed/simple;
	bh=xQKbcVqlbnpj9/DcRAA1LLT/dwOl7OKUWaHA9GF26XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeFnVkv/o/hDJkCc/K31wmtk0MtCX3Bg8ZMdtCX40+I7/RZ41ayNKxZ2i2/k4aPfpHhUZZ8/cIHe4K984OQX5iFB0M69EUUuHeHI0ku5ac53J3NfI/vzTxe+AQL6CNvR5kXdJLXMtZH61L+Xsvzly9dMeenAMGbDoSk4+HszVBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ox+HINxN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q/fKGYqt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ox+HINxN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q/fKGYqt"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 19BE2EC01CA;
	Thu, 25 Sep 2025 13:08:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 25 Sep 2025 13:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758820095;
	 x=1758906495; bh=PbBMjjoWvzU8yL9MR7Yta9ADXD6venRZ/P1B+wHn0J0=; b=
	Ox+HINxNcdKjB1fewEy0ytlDMUS8cl+SvLT+MD/K+kj79dr8CXrAt0/e6/QUmKKX
	JsQUG3gGGJsN8xQT67WYX1CebgnAn2ZjFKk+R9ni3Pq7GIwWyokUxUnxi2RFCIuY
	tPXtiXwrgNpFN7y2SCuEHfnomWupwrlLAq95ZRKzwTKO7NufPmXedsaA6aE+4GGs
	sFDcUM/kuKpn4rU0CsOAyK5bNMTm5aeskJIdnIeiCz4BfJouQiMwvbJ0FzpdYAty
	KcuaM0H7ytvq126qf3WcFqdvm50bFgJTK6Ey6JCX8mp9jIIbZNSnjIrS93X5DnJk
	KBnkAUuh3XEi4JGzHEG2jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758820095; x=
	1758906495; bh=PbBMjjoWvzU8yL9MR7Yta9ADXD6venRZ/P1B+wHn0J0=; b=Q
	/fKGYqtGCyDENv1ue2p9ElvMzASTpHy9WKc7F/m6L4UcIq9G6QPQemrxytuyo7u9
	VWYYSMQ6M9NphocCde+K7EKkR6OXiBWnxWQlYLTHs59/9PxWDbBX07s6VS/6E3gc
	8XS28NONl3XD79CgdLY8GKMC4FWFVxJH7e2D3SSn/a22QSnT0jgrXDALX+JT+7xs
	bGTHA+HtGu9JOzNAhSV5Jk416serg+V2S9Tl6iGdpCkG+D5HmjIfMOKwcjP3URA4
	vTBg/5gV3W88cxHjBeFHZYv9m/PodDdgc48EuCRXAsSyJ+4rKb/Ru1zwuobYptsS
	uAKYTwEQSUGcBY2Eihljg==
X-ME-Sender: <xms:_nbVaOaCtu7FCFJECsDhZeTdY8zBupLzLT6aKa6WqYgpcS2P80rjmR8>
    <xme:_nbVaI1XKm_kucYdv0bKxgPEoIIP9D24CfMJ4jMslxSGtOQK2w0ff2P1Ltxw4ciUI
    xS8cvFaEC_-5eZkdCQFQUgzPlnTc2VfIsNIMABUaF3lkwN6RVeMJw>
X-ME-Received: <xmr:_nbVaGX9KZD6nXHumYsbSglaXIPiI2bgRa_f_PU8InGj6JZ42y4e3WwyYuY3WObCHvGTRZDJSTFxvTObD9X2IXx89d1N1xmw5S1vWLI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhephfffudefgeelueehkeelgffhhfejgfdtffdvhedttefggffggeffffefudelveek
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpughifhhfohhpthdrnhhonecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhope
    efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpd
    hrtghpthhtoheplhhiuhdruggvnhhtohhnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_nbVaKUlcDMBkx7lTPugvrfXzr-ZdnciNQGad24RY-zUgP-KNYfT-g>
    <xmx:_nbVaNfAD92X-FW-pf5LPfRKQ3yelYKOrXGLd21-CF6io7mtTFdMWw>
    <xmx:_nbVaLXGu4mKA_zsl1u-xqwM9rEcpmwp5FV2b9I8oNmwJ6b0GTneHg>
    <xmx:_nbVaOdCKew94pnNfHtutXAWJFOkQ7Po0RPG9J07kJMatVzN67zOHw>
    <xmx:_3bVaA0UL_NHALM9RYYl6HdZKCOf58HK6Dvv-aV5YqtRBRD1ZNpNd0QX>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 13:08:14 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v2 0/3] format-patch: handle range-diff on notes correctly for single patches
Date: Thu, 25 Sep 2025 19:07:33 +0200
Message-ID: <v2-cover.1758819879.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.311.g9b2318464ce
In-Reply-To: <cover.1758574974.git.code@khaugsbakk.name>
References: <cover.1758574974.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

git-format-patch(1) does not handle Git notes correctly in the
range-diff output for single-commit series.  It reverts to the
default behavior of git-range-diff(1), which is to act like git-log(1).

Git notes can be added to patches where they go beneath the commit
message (similar to git-log(1)).  You can of course use any set of notes
ref names.  And the range-diff is supposed to use the same ref names.
This works for the case when you have a cover letter (for more than one
commit) but not when you have a single commit.

See patch 2/3 for a full explanation of the problem.

Fix that notes handling to always output the same notes (ref names) in
the two positions:

• beneath the commit message; and
• in the range diff.

Patch-by-patch:

1. Rename `other_arg` to `log_arg`
2. Refactor to use a new `rev_info` struct member
3. Use that in `log-tree.c` in order to solve the problem

§ Changes in v2

Mostly better commit messages.  Fix a mistake in the `rev_info` struct
handling.

Patch-by-patch (see notes on them for details):

1. (new) Better variable name
2. Rewrite commit message and fix mistake
3. Rewrite commit message by mostly stealing from patch 2/3

About the commit messages: the first one just jumped into the problem
without a proper introduction (see the note on patch 2/3).  Not clear
enough.  But I didn’t act on this review feedback:[1]

  “ Would this also mean "range-diff --no-notes" would not have any
    effect in squelching the note output in such a mode?  If so, perhaps
    we should say not just "can get different Git notes" but "can get
    notes even when you asked not to"?

🔗 1: https://lore.kernel.org/git/xmqqecryrvt6.fsf@gitster.g/

Since both commits in v1 already said `--[no-]notes`.

§ CC

Denton Liu wrote a commit mentioned in patch 1/3.  It’s been more years
than the recommended cutoff, but he has been active recently.

§ Link to the previous version

https://lore.kernel.org/git/cover.1758574974.git.code@khaugsbakk.name/

❦ ❦ ❦ ❦ ❦

(this means you can skip to the diffs)

§ How I Present Patch Series

Version: 1

The cover letter:

• Problem statement and solution
• (optional) Summary of what each commit/patch does
• Changes compared to the previous version
  • Note that all versions are not included
• (optional) “CC”/“Cc” which explains all or parts of the CC list
  • But some things are not noteworthy, like the standard practice of
    including previous-round respondents
• Link to the previous version
  • This is new.  I thought it was redundant but some people (like me!)
    use webapp email clients which are not that great for navigating
    among tree-like email threads.  So I was inspired by this practice
    which many others already use.
• I like including an interdiff in addition to the range diff if I can.
  They are just so convenient and complementary to the range diff.

Then each commit/patch might have Git notes with a `series` namespace
(ref name) These contain:

• Comments/questions to reviewers about my approach or statements made
  in the commit message.
• Lines starting with `v<version>:` which introduce a changelog for that
  version.  Lately (Sep 2025) these have been written in the “imperative
  mood”, like what is done for a commit message in this (Git) project.
  A bit strange, given that most others seem to use the more immediately
  natural past-tense.  But on the other hand: how many new contributors
  to this project use the wrong tense/mood in their commit messages?
  The Git project rule is not “natural”.  But I think it’s better
  nonetheless and worth the effort.

  (And it might be worth the effort in this context, too.  We will see.)
• ... But this kind of changelog might also be conducive to a bullet
  list of changes.  So I might either skip the previous point, do only a
  bullet point, or do both: a presentation and then the bullet points
  summarizing the presentation.
• Note that all `v<version>:` are kept between versions, which is not
  consistent with how I only have the “Changes” part for the previous
  version.
• `v<version>:` are ordered newest-to-oldest.

Kristoffer Haugsbakk (3):
  range-diff: rename other_arg to log_arg
  revision: add rdiff_log_arg to rev_info
  format-patch: handle range-diff on notes correctly for single patches

 builtin/log.c         |  7 +++----
 builtin/range-diff.c  | 16 ++++++++--------
 log-tree.c            |  3 ++-
 range-diff.c          | 10 +++++-----
 range-diff.h          |  2 +-
 revision.h            |  2 ++
 t/t3206-range-diff.sh | 16 +++++++++++++++-
 7 files changed, 36 insertions(+), 20 deletions(-)

Interdiff against v1:
diff --git a/builtin/log.c b/builtin/log.c
index 56dd9fbc057..9eff62ce111 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1405,7 +1405,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			.dual_color = 1,
 			.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
 			.diffopt = &opts,
-			.other_arg = &rev->rdiff_other_arg
+			.log_arg = &rev->rdiff_log_arg
 		};
 
 		repo_diff_setup(the_repository, &opts);
@@ -2325,7 +2325,7 @@ int cmd_format_patch(int argc,
 		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
 					     _("Range-diff:"),
 					     _("Range-diff against v%d:"));
-		get_notes_args(&(rev.rdiff_other_arg), &rev);
+		get_notes_args(&(rev.rdiff_log_arg), &rev);
 	}
 
 	/*
@@ -2485,7 +2485,7 @@ int cmd_format_patch(int argc,
 	rev.diffopt.no_free = 0;
 	release_revisions(&rev);
 	format_config_release(&cfg);
-	strvec_clear(&rev.rdiff_other_arg);
+	strvec_clear(&rev.rdiff_log_arg);
 	return 0;
 }
 
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index aafcc99b962..f88b40e3607 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -37,13 +37,13 @@ int cmd_range_diff(int argc,
 		   struct repository *repo UNUSED)
 {
 	struct diff_options diffopt = { NULL };
-	struct strvec other_arg = STRVEC_INIT;
+	struct strvec log_arg = STRVEC_INIT;
 	struct strvec diff_merges_arg = STRVEC_INIT;
 	struct range_diff_options range_diff_opts = {
 		.creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT,
 		.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
 		.diffopt = &diffopt,
-		.other_arg = &other_arg
+		.log_arg = &log_arg
 	};
 	int simple_color = -1, left_only = 0, right_only = 0;
 	struct option range_diff_options[] = {
@@ -52,7 +52,7 @@ int cmd_range_diff(int argc,
 			    N_("percentage by which creation is weighted")),
 		OPT_BOOL(0, "no-dual-color", &simple_color,
 			    N_("use simple diff colors")),
-		OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
+		OPT_PASSTHRU_ARGV(0, "notes", &log_arg,
 				  N_("notes"), N_("passed to 'git log'"),
 				  PARSE_OPT_OPTARG),
 		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
@@ -92,7 +92,7 @@ int cmd_range_diff(int argc,
 	/* If `--diff-merges` was specified, imply `--merges` */
 	if (diff_merges_arg.nr) {
 		range_diff_opts.include_merges = 1;
-		strvec_pushv(&other_arg, diff_merges_arg.v);
+		strvec_pushv(&log_arg, diff_merges_arg.v);
 	}
 
 	for (i = 0; i < argc; i++)
@@ -124,7 +124,7 @@ int cmd_range_diff(int argc,
 		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
 		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
 
-		strvec_pushv(&other_arg, argv +
+		strvec_pushv(&log_arg, argv +
 			     (dash_dash < 0 ? 3 : dash_dash));
 	} else if (dash_dash == 2 ||
 		   (dash_dash < 0 && argc > 1 &&
@@ -144,7 +144,7 @@ int cmd_range_diff(int argc,
 		strbuf_addstr(&range1, argv[0]);
 		strbuf_addstr(&range2, argv[1]);
 
-		strvec_pushv(&other_arg, argv +
+		strvec_pushv(&log_arg, argv +
 			     (dash_dash < 0 ? 2 : dash_dash));
 	} else if (dash_dash == 1 ||
 		   (dash_dash < 0 && argc > 0 &&
@@ -175,7 +175,7 @@ int cmd_range_diff(int argc,
 		strbuf_addf(&range1, "%s..%.*s", b, a_len, a);
 		strbuf_addf(&range2, "%.*s..%s", a_len, a, b);
 
-		strvec_pushv(&other_arg, argv +
+		strvec_pushv(&log_arg, argv +
 			     (dash_dash < 0 ? 1 : dash_dash));
 	} else
 		usage_msg_opt(_("need two commit ranges"),
@@ -187,7 +187,7 @@ int cmd_range_diff(int argc,
 	range_diff_opts.right_only = right_only;
 	res = show_range_diff(range1.buf, range2.buf, &range_diff_opts);
 
-	strvec_clear(&other_arg);
+	strvec_clear(&log_arg);
 	strvec_clear(&diff_merges_arg);
 	strbuf_release(&range1);
 	strbuf_release(&range2);
diff --git a/log-tree.c b/log-tree.c
index 831284288f9..3d38c748e45 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -719,7 +719,7 @@ static void show_diff_of_diff(struct rev_info *opt)
 			.dual_color = 1,
 			.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
 			.diffopt = &opts,
-			.other_arg = &opt->rdiff_other_arg
+			.log_arg = &opt->rdiff_log_arg
 		};
 
 		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
diff --git a/range-diff.c b/range-diff.c
index ca449a07693..57edff40a85 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -39,7 +39,7 @@ struct patch_util {
  * as struct object_id (will need to be free()d).
  */
 static int read_patches(const char *range, struct string_list *list,
-			const struct strvec *other_arg,
+			const struct strvec *log_arg,
 			unsigned int include_merges)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -69,8 +69,8 @@ static int read_patches(const char *range, struct string_list *list,
 	if (!include_merges)
 		strvec_push(&cp.args, "--no-merges");
 	strvec_push(&cp.args, range);
-	if (other_arg)
-		strvec_pushv(&cp.args, other_arg->v);
+	if (log_arg)
+		strvec_pushv(&cp.args, log_arg->v);
 	cp.out = -1;
 	cp.no_stdin = 1;
 	cp.git_cmd = 1;
@@ -594,9 +594,9 @@ int show_range_diff(const char *range1, const char *range2,
 	if (range_diff_opts->left_only && range_diff_opts->right_only)
 		res = error(_("options '%s' and '%s' cannot be used together"), "--left-only", "--right-only");
 
-	if (!res && read_patches(range1, &branch1, range_diff_opts->other_arg, include_merges))
+	if (!res && read_patches(range1, &branch1, range_diff_opts->log_arg, include_merges))
 		res = error(_("could not parse log for '%s'"), range1);
-	if (!res && read_patches(range2, &branch2, range_diff_opts->other_arg, include_merges))
+	if (!res && read_patches(range2, &branch2, range_diff_opts->log_arg, include_merges))
 		res = error(_("could not parse log for '%s'"), range2);
 
 	if (!res) {
diff --git a/range-diff.h b/range-diff.h
index 9d39818e349..9b70a80009e 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -23,7 +23,7 @@ struct range_diff_options {
 	unsigned include_merges:1;
 	size_t max_memory;
 	const struct diff_options *diffopt; /* may be NULL */
-	const struct strvec *other_arg; /* may be NULL */
+	const struct strvec *log_arg; /* may be NULL */
 };
 
 /*
diff --git a/revision.h b/revision.h
index 26c18a0934b..ce30570d86a 100644
--- a/revision.h
+++ b/revision.h
@@ -334,7 +334,7 @@ struct rev_info {
 	/* range-diff */
 	const char *rdiff1;
 	const char *rdiff2;
-	struct strvec rdiff_other_arg;
+	struct strvec rdiff_log_arg;
 	int creation_factor;
 	const char *rdiff_title;
 
@@ -411,6 +411,7 @@ struct rev_info {
 	.expand_tabs_in_log = -1, \
 	.commit_format = CMIT_FMT_DEFAULT, \
 	.expand_tabs_in_log_default = 8, \
+	.rdiff_log_arg = STRVEC_INIT, \
 }
 
 /**
Range-diff against v1:
-:  ----------- > 1:  bd037df14f5 range-diff: rename other_arg to log_arg
1:  bb065767336 ! 2:  d9419743773 revision: add rdiff_other_arg to rev_info
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    revision: add rdiff_other_arg to rev_info
    -
    -    git-format-patch(1) needs to pass `--[no-]notes` options on to the
    -    range-diff subprocess in `range-diff.c`.  This is handled in `builtin/
    -    log.c` by the local variable `other_arg` in the case of multiple
    -    commits, but not in the single commit case where there is no cover
    -    letter and the range-diff is on that single resulting patch; the
    -    range-diff is then made in `log-tree.c`, whither `other_arg` has not
    -    been propagated.
    -
    -    git-format-patch(1) is supposed to treat Git notes the same between
    -    notes output beneath the commit message and the notes output for the
    -    range-diff.  But this lack of notes handling in `log-tree.c` breaks
    -    that expected behavior; range-diff notes handling for a single patch
    -    acts like a normal git-range-diff(1) invocation with regards to notes.
    -    You can, for example, end up with a patch where the note beneath the
    -    commit message has the correct notes namespace, but the range-diff has
    -    all the notes that are configured to be displayed by git-log(1).[1]
    -
    -    We need to fix this.  But first lay the groundwork by converting
    -    `other_arg` to a struct member; next we can simply use that member
    +    revision: add rdiff_log_arg to rev_info
    +
    +    git-format-patch(1) supports Git notes by showing them beneath the
    +    patch/commit message, similar to git-log(1). The command also supports
    +    showing those same notes ref names in the range diff output.
    +
    +    Note *the same* ref names; any Git notes options or configuration
    +    variables need to be handed off to the range-diff machinery. This works
    +    correctly in the case when the range diff is on the cover letter. But it
    +    does not work correctly when the output is a single patch with an
    +    embedded range diff.
    +
    +    Concretely, git-format-patch(1) needs to pass `--[no-]notes` options
    +    on to the range-diff subprocess in `range-diff.c`. This is handled in
    +    `builtin/log.c` by the local variable `log_arg` in the case of mul-
    +    tiple commits, but not in the single commit case where there is no
    +    cover letter and the range diff is embedded in the patch output; the
    +    range diff is then made in `log-tree.c`, whither `log_arg` has not
    +    been propagated. This means that the range-diff subprocess reverts
    +    to its default behavior, which is to act like git-log(1) w.r.t. notes.
    +
    +    We need to fix this. But first lay the groundwork by converting
    +    `log_arg` to a struct member; next we can simply use that member
         in `log-tree.c` without having to thread it from `builtin/log.c`.
     
         No functional changes.
     
    -    † 1: See the configuration variable `format.notes` for git-format-
    -         patch(1); c.f. `notes.displayRef` for git-log(1).  These two
    -         have nothing to do with each other.
    -
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    +    v2:
    +
    +    Rewrite the commit message.  The message jumps into the problem without
    +    setting the stage.  I think the problem should be presented for a future
    +    reader with only some basic prerequisite knowledge of this area; they
    +    might use git-format-patch(1), but they might not use Git notes *with*
    +    format-patch.[1]  For that reason, start with two paragraphs that pre-
    +    sent how notes are handled.  Then continue with the story in a format
    +    similar to v1.
    +
    +    Note that the different “range diff” and “range-diff” spellings are
    +    intentional.  “Range diff” here refers to the diff output while
    +    “range-diff” refers to the machinery that creates that output.
    +
    +    † 1: I don’t really see much Git notes use on patches on this mailing
    +         list.  And even less with non-default namespaces.  But in any case:
    +         the stage should be set properly even if regulars here *did* use
    +         format-patch notes a lot.
    +
    +    Also fix handling of struct-in-struct (helped by Junio).
    +
    +    • Rewrite the commit message
    +    • Fix struct-in-struct
    +    • (And) Reset author date.  I started this in June but the time
    +      investment is mostly from these last days.
    +
    +    v1:
    +
         There is also `other_arg` in `builtin/range-diff.c` but `rev_info` does
         not seem to be involved.
     
    @@ builtin/log.c: static void make_cover_letter(struct rev_info *rev, int use_separ
      		 * can be added later if deemed desirable.
      		 */
      		struct diff_options opts;
    --		struct strvec other_arg = STRVEC_INIT;
    +-		struct strvec log_arg = STRVEC_INIT;
      		struct range_diff_options range_diff_opts = {
      			.creation_factor = rev->creation_factor,
      			.dual_color = 1,
      			.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
      			.diffopt = &opts,
    --			.other_arg = &other_arg
    -+			.other_arg = &rev->rdiff_other_arg
    +-			.log_arg = &log_arg
    ++			.log_arg = &rev->rdiff_log_arg
      		};
      
      		repo_diff_setup(the_repository, &opts);
    @@ builtin/log.c: static void make_cover_letter(struct rev_info *rev, int use_separ
      		opts.use_color = rev->diffopt.use_color;
      		diff_setup_done(&opts);
      		fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
    --		get_notes_args(&other_arg, rev);
    +-		get_notes_args(&log_arg, rev);
      		show_range_diff(rev->rdiff1, rev->rdiff2, &range_diff_opts);
    --		strvec_clear(&other_arg);
    +-		strvec_clear(&log_arg);
      	}
      }
      
    @@ builtin/log.c: int cmd_format_patch(int argc,
      		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
      					     _("Range-diff:"),
      					     _("Range-diff against v%d:"));
    -+		get_notes_args(&(rev.rdiff_other_arg), &rev);
    ++		get_notes_args(&(rev.rdiff_log_arg), &rev);
      	}
      
      	/*
    @@ builtin/log.c: int cmd_format_patch(int argc,
      	rev.diffopt.no_free = 0;
      	release_revisions(&rev);
      	format_config_release(&cfg);
    -+	strvec_clear(&rev.rdiff_other_arg);
    ++	strvec_clear(&rev.rdiff_log_arg);
      	return 0;
      }
      
    @@ revision.h: struct rev_info {
      	/* range-diff */
      	const char *rdiff1;
      	const char *rdiff2;
    -+	struct strvec rdiff_other_arg;
    ++	struct strvec rdiff_log_arg;
      	int creation_factor;
      	const char *rdiff_title;
      
    +@@ revision.h: struct rev_info {
    + 	.expand_tabs_in_log = -1, \
    + 	.commit_format = CMIT_FMT_DEFAULT, \
    + 	.expand_tabs_in_log_default = 8, \
    ++	.rdiff_log_arg = STRVEC_INIT, \
    + }
    + 
    + /**
2:  7f2487af433 ! 3:  2be637081d4 format-patch: handle range-diff on notes correctly for single patches
    @@ Metadata
      ## Commit message ##
         format-patch: handle range-diff on notes correctly for single patches
     
    -    No `--[no-]notes` options are sent to the range-diff subprocess in
    -    `range-diff.c` when making a single patch.  This means that you can get
    -    different Git notes below the commit message and in the range-diff
    -    part.  (See the previous commit for elaboration.)
    +    (The two next paragraphs are taken from the previous commit.)
     
    -    Use the struct member that we introduced and populated in the
    +    git-format-patch(1) supports Git notes by showing them beneath the
    +    patch/commit message, similar to git-log(1). The command also supports
    +    showing those same notes ref names in the range diff output.
    +
    +    Note *the same* ref names; any Git notes options or configuration
    +    variables need to be handed off to the range-diff machinery. This works
    +    correctly in the case when the range diff is on the cover letter. But it
    +    does not work correctly when the output is a single patch with an
    +    embedded range diff.
    +
    +    Concretely, git-format-patch(1) needs to pass `--[no-]notes` options on
    +    to the range-diff subprocess in `range-diff.c`. Range diffs for single-
    +    commit series are handled in `log-tree.c`. But `log-tree.c` had no
    +    access to any `log_arg` variable before we added it to `rev_info` in the
         previous commit.
     
    +    Use that new struct member to fix this inconsistency.
    +
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    +    v1:
    +
         I’ve tried to conform to 6caa96c2 (t3206: test_when_finished before
         dirtying operations, not after, 2024-08-06) in the test here.
     
    @@ log-tree.c: static void show_diff_of_diff(struct rev_info *opt)
      			.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
     -			.diffopt = &opts
     +			.diffopt = &opts,
    -+			.other_arg = &opt->rdiff_other_arg
    ++			.log_arg = &opt->rdiff_log_arg
      		};
      
      		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));

base-commit: ca2559c1d630eb4f04cdee2328aaf1c768907a9e
-- 
2.51.0.311.g9b2318464ce

