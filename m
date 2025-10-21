Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30402236FA
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056179; cv=none; b=B3R3obbL63nv53H7jEHBzdic39uQpsYHSMbtbz/hzZ/JeeBHv+qgxMrD/pTWJwA6e7PllhP77IbzU7PaJOPD0OX+o9sm/tk62T0EaX1pLaebOz/MyUc2p+OeW7z4Q8E22qxKNJHaJo0UVPSxwCuu7rg3dUwRiLQFyvg4B97pLGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056179; c=relaxed/simple;
	bh=K2ICbls6TMv07lnXj2rZNpzb/6emeVLYLhdOlOlDE1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ouIDbSKEHMJ4V2lwLFQ4+hd/BR7XR7FBC6sBwOWGYbkoimcv+1zByu/H0gyUeegpoFzls1wDmzYCE1dCk5XTx99ARKUrDEQx25Nw/rYIfkgSQDMhsMDR8Wxh2JkNTQdQKgwK7RHy9W5WZdQ/sWiuuUZYe2aqPKfAtsi4RFdQPGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IimS3amv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vtOGm0Fa; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IimS3amv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vtOGm0Fa"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 05E2B14000E2;
	Tue, 21 Oct 2025 10:16:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 21 Oct 2025 10:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056175;
	 x=1761142575; bh=acHNXGvYlEGkmfY5jmRQxl7pgHab4KJyfCvdkhNR3lo=; b=
	IimS3amvexGQanVUttTm4arG0zXNQjS3nJ+CY81zKzca9ba0KRI+0gAQe2lsBx17
	PvjH5wrW+JWGVSXdxPjqz+wz0zQHm8sJ6uiKMmJSgwgCj7kyXyZYWOhis1e8j4dz
	4wjchpl2rY/h/tjdgzGuEEhoAMSuAH/o+lBq9zUoeV8ItZx7ZqvURfJV7z+3B+ps
	yQW93XjGTdCqSGElKGQdj0Ax901ctO3YpLINY7xdp8RYa8wOq8kE00WNat1eim4r
	QtF3KZYLYJOFCN9HCK4PtnSNuHsQUMj0RAgSXebtMM8/8rJGIv8oNw7p3bjgIyvJ
	ZaEl8B+EjjQJh2i/4AFEDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056175; x=
	1761142575; bh=acHNXGvYlEGkmfY5jmRQxl7pgHab4KJyfCvdkhNR3lo=; b=v
	tOGm0FabOu8cMEpFC42yNda+m31IryRMp1oRu4mCg4VVMYg7WAuCjA7l8YHeZmRu
	LU1EYbsWzK8IyAZByHLcpadtkLZx7/uXcK2PP2ms9fRltb4Y/+Y1aibY8eZ0C0TX
	J2xFyx8UMTSRBuCSkNa4+snb2j9YKsJpPLL8pGOVkIhZb/wZaH3Q1q+Rx0HXKan1
	pD5TSFtQ5ktQh5koJdA74bD8rEz0eNZw5DoOhH9lIEvPyPFYEUe1fr1M2/Rmgrh4
	fU8EnKFcMPJfFxwN1+TvSBOzjCnwsuAohwosYiMkLXaL+Nrocr8pH9khGyONbbHx
	KfY98Fb2fjNpYPFY9l74g==
X-ME-Sender: <xms:rpX3aMrI-LEuEtGJ6TiloC5hQqEo9AQzT0D4KDSj28GpfsdB-xk8aA>
    <xme:rpX3aFPaPsR6Is5tUp-8ku_oyPqh6_iKJYNdSCO1ANFR2SlCHTI8hiv5w09LMGVvO
    gJX-3djtP8GPDuCdTA24eapdqen8QJIdA3zamM-XN-IBTUBgo5-0A>
X-ME-Received: <xmr:rpX3aE1ci8zzPR0UseVJ2puYA9lJMtP9EUMuMF2VxVNiacE8g3UKn_jWOTUbIyDst_xS2U7M3IZw2cMH7ycwskiyUSosj_4WQ_ezYpkAbNr-0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhorhhg
    rghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:rpX3aEAwzDbcys1dPnOSEcBV_vxE9SRw33UH9nzcY0PJDpdNMI6JGA>
    <xmx:rpX3aBI7ykSPG_vEafkqgRdZ6bvOgsNu11kZVhVJT0SXsrZ-GYWi3w>
    <xmx:rpX3aNkIZx1IQO93KMx3GmccXqf7A7ZKjmc0RiG1kQ-5eeTKa9gqLQ>
    <xmx:rpX3aKa25DVUqJstIX05I9-AGwtOsvS1vrpa_aLEvkw3gV-oE2TQ1g>
    <xmx:rpX3aBlazZCK-Litg7rHyAYYfLYa0XmZCCaxMZTFnxxKL4jzmtstERZJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:16:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4bcc34d8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:16:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Oct 2025 16:15:54 +0200
Subject: [PATCH v5 06/12] builtin/history: implement "reword" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-b4-pks-history-builtin-v5-6-78d23f578fe6@pks.im>
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
In-Reply-To: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Implement a new "reword" subcommand for git-history(1). This subcommand
is essentially the same as if a user performed an interactive rebase
with a single commit changed to use the "reword" verb.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc |   7 +
 builtin/history.c              | 364 ++++++++++++++++++++++++++++++++++++++++-
 t/meson.build                  |   1 +
 t/t3450-history.sh             |   6 +-
 t/t3451-history-reword.sh      | 217 ++++++++++++++++++++++++
 5 files changed, 588 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 57560525a70..6f016801936 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git history [<options>]
+git history reword [<options>] <commit>
 
 DESCRIPTION
 -----------
@@ -33,6 +34,12 @@ COMMANDS
 This command requires a subcommand. Several subcommands are available to
 rewrite history in different ways:
 
+`reword <commit> [--message=<message>]`::
+	Rewrite the commit message of the specified commit. All the other
+	details of this commit remain unchanged. If no commit message is
+	provided, then this command will spawn an editor with the current
+	message of that commit.
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/history.c b/builtin/history.c
index f6fe32610b0..f14e88c9bf4 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1,22 +1,378 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
+#include "commit-reach.h"
+#include "commit.h"
+#include "config.h"
+#include "editor.h"
+#include "environment.h"
 #include "gettext.h"
+#include "hex.h"
 #include "parse-options.h"
+#include "refs.h"
+#include "replay.h"
+#include "reset.h"
+#include "revision.h"
+#include "sequencer.h"
+#include "strvec.h"
+#include "tree.h"
+#include "wt-status.h"
+
+#define GIT_HISTORY_REWORD_USAGE N_("git history reword [<options>] <commit>")
+
+static int collect_commits(struct repository *repo,
+			   struct commit *old_commit,
+			   struct commit *new_commit,
+			   struct strvec *out)
+{
+	struct setup_revision_opt revision_opts = {
+		.assume_dashdash = 1,
+	};
+	struct strvec revisions = STRVEC_INIT;
+	struct commit *child;
+	struct rev_info rev = { 0 };
+	int ret;
+
+	repo_init_revisions(repo, &rev, NULL);
+	strvec_push(&revisions, "");
+	strvec_push(&revisions, oid_to_hex(&new_commit->object.oid));
+	if (old_commit)
+		strvec_pushf(&revisions, "^%s", oid_to_hex(&old_commit->object.oid));
+
+	setup_revisions_from_strvec(&revisions, &rev, &revision_opts);
+	if (revisions.nr != 1 || prepare_revision_walk(&rev)) {
+		ret = error(_("revision walk setup failed"));
+		goto out;
+	}
+
+	while ((child = get_revision(&rev))) {
+		if (old_commit && !child->parents)
+			BUG("revision walk did not find child commit");
+		if (child->parents && child->parents->next) {
+			ret = error(_("cannot rearrange commit history with merges"));
+			goto out;
+		}
+
+		strvec_push(out, oid_to_hex(&child->object.oid));
+
+		if (child->parents && old_commit &&
+		    commit_list_contains(old_commit, child->parents))
+			break;
+	}
+
+	/*
+	 * Revisions are in newest-order-first. We have to reverse the
+	 * array though so that we pick the oldest commits first.
+	 */
+	for (size_t i = 0, j = out->nr - 1; i < j; i++, j--)
+		SWAP(out->v[i], out->v[j]);
+
+	ret = 0;
+
+out:
+	strvec_clear(&revisions);
+	release_revisions(&rev);
+	reset_revision_walk();
+	return ret;
+}
+
+static void replace_commits(struct strvec *commits,
+			    const struct object_id *commit_to_replace,
+			    const struct object_id *replacements,
+			    size_t replacements_nr)
+{
+	char commit_to_replace_oid[GIT_MAX_HEXSZ + 1];
+	struct strvec replacement_oids = STRVEC_INIT;
+	bool found = false;
+
+	oid_to_hex_r(commit_to_replace_oid, commit_to_replace);
+	for (size_t i = 0; i < replacements_nr; i++)
+		strvec_push(&replacement_oids, oid_to_hex(&replacements[i]));
+
+	for (size_t i = 0; i < commits->nr; i++) {
+		if (strcmp(commits->v[i], commit_to_replace_oid))
+			continue;
+		strvec_splice(commits, i, 1, replacement_oids.v, replacement_oids.nr);
+		found = true;
+		break;
+	}
+	if (!found)
+		BUG("could not find commit to replace");
+
+	strvec_clear(&replacement_oids);
+}
+
+static int apply_commits(struct repository *repo,
+			 const struct strvec *commits,
+			 struct commit *onto,
+			 struct commit *orig_head,
+			 const char *action)
+{
+	struct reset_head_opts reset_opts = { 0 };
+	struct merge_options merge_opts = { 0 };
+	struct merge_result result = { 0 };
+	struct strbuf buf = STRBUF_INIT;
+	kh_oid_map_t *replayed_commits;
+	int ret;
+
+	replayed_commits = kh_init_oid_map();
+
+	init_basic_merge_options(&merge_opts, repo);
+	merge_opts.show_rename_progress = 0;
+
+	for (size_t i = 0; i < commits->nr; i++) {
+		struct object_id commit_id;
+		struct commit *commit;
+		const char *end;
+		int hash_result;
+		khint_t pos;
+
+		if (parse_oid_hex_algop(commits->v[i], &commit_id, &end,
+					repo->hash_algo)) {
+			ret = error(_("invalid object ID: %s"), commits->v[i]);
+			goto out;
+		}
+
+		commit = lookup_commit(repo, &commit_id);
+		if (!commit || repo_parse_commit(repo, commit)) {
+			ret = error(_("failed to look up commit: %s"), oid_to_hex(&commit_id));
+			goto out;
+		}
+
+		if (!onto) {
+			onto = commit;
+			result.clean = 1;
+			result.tree = repo_get_commit_tree(repo, commit);
+		} else {
+			onto = replay_pick_regular_commit(repo, commit, replayed_commits,
+							  onto, &merge_opts, &result);
+			if (!onto)
+				break;
+		}
+
+		pos = kh_put_oid_map(replayed_commits, commit->object.oid, &hash_result);
+		if (hash_result == 0) {
+			ret = error(_("duplicate rewritten commit: %s\n"),
+				    oid_to_hex(&commit->object.oid));
+			goto out;
+		}
+		kh_value(replayed_commits, pos) = onto;
+	}
+
+	if (!result.clean) {
+		ret = error(_("could not merge"));
+		goto out;
+	}
+
+	reset_opts.oid = &onto->object.oid;
+	strbuf_addf(&buf, "%s: switch to rewritten %s", action, oid_to_hex(reset_opts.oid));
+	reset_opts.flags = RESET_HEAD_REFS_ONLY | RESET_ORIG_HEAD;
+	reset_opts.orig_head = &orig_head->object.oid;
+	reset_opts.default_reflog_action = action;
+	if (reset_head(repo, &reset_opts) < 0) {
+		ret = error(_("could not switch to %s"), oid_to_hex(reset_opts.oid));
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	kh_destroy_oid_map(replayed_commits);
+	merge_finalize(&merge_opts, &result);
+	strbuf_release(&buf);
+	return ret;
+}
+
+static void change_data_free(void *util, const char *str UNUSED)
+{
+	struct wt_status_change_data *d = util;
+	free(d->rename_source);
+	free(d);
+}
+
+static int fill_commit_message(struct repository *repo,
+			       const struct object_id *old_tree,
+			       const struct object_id *new_tree,
+			       const char *default_message,
+			       const char *provided_message,
+			       const char *action,
+			       struct strbuf *out)
+{
+	if (!provided_message) {
+		const char *path = git_path_commit_editmsg();
+		const char *hint =
+			_("Please enter the commit message for the %s changes."
+			  " Lines starting\nwith '%s' will be ignored.\n");
+		struct wt_status s;
+
+		strbuf_addstr(out, default_message);
+		strbuf_addch(out, '\n');
+		strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
+		write_file_buf(path, out->buf, out->len);
+
+		wt_status_prepare(repo, &s);
+		FREE_AND_NULL(s.branch);
+		s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
+		s.commit_template = 1;
+		s.colopts = 0;
+		s.display_comment_prefix = 1;
+		s.hints = 0;
+		s.use_color = 0;
+		s.whence = FROM_COMMIT;
+		s.committable = 1;
+
+		s.fp = fopen(git_path_commit_editmsg(), "a");
+		if (!s.fp)
+			return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
+
+		wt_status_collect_changes_trees(&s, old_tree, new_tree);
+		wt_status_print(&s);
+		wt_status_collect_free_buffers(&s);
+		string_list_clear_func(&s.change, change_data_free);
+
+		strbuf_reset(out);
+		if (launch_editor(path, out, NULL)) {
+			fprintf(stderr, _("Please supply the message using the -m option.\n"));
+			return -1;
+		}
+		strbuf_stripspace(out, comment_line_str);
+	} else {
+		strbuf_addstr(out, provided_message);
+	}
+
+	cleanup_message(out, COMMIT_MSG_CLEANUP_ALL, 0);
+
+	if (!out->len) {
+		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int cmd_history_reword(int argc,
+			      const char **argv,
+			      const char *prefix,
+			      struct repository *repo)
+{
+	const char * const usage[] = {
+		GIT_HISTORY_REWORD_USAGE,
+		NULL,
+	};
+	const char *commit_message = NULL;
+	struct option options[] = {
+		OPT_STRING('m', "message", &commit_message, N_("message"), N_("commit message")),
+		OPT_END(),
+	};
+	struct strbuf final_message = STRBUF_INIT;
+	struct commit *original_commit, *parent, *head;
+	struct strvec commits = STRVEC_INIT;
+	struct object_id parent_tree_oid, original_commit_tree_oid;
+	struct object_id rewritten_commit;
+	struct commit_list *from_list = NULL;
+	const char *original_message, *original_body, *ptr;
+	char *original_author = NULL;
+	size_t len;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc != 1) {
+		ret = error(_("command expects a single revision"));
+		goto out;
+	}
+	repo_config(repo, git_default_config, NULL);
+
+	original_commit = lookup_commit_reference_by_name(argv[0]);
+	if (!original_commit) {
+		ret = error(_("commit to be reworded cannot be found: %s"), argv[0]);
+		goto out;
+	}
+	original_commit_tree_oid = repo_get_commit_tree(repo, original_commit)->object.oid;
+
+	parent = original_commit->parents ? original_commit->parents->item : NULL;
+	if (parent) {
+		if (repo_parse_commit(repo, parent)) {
+			ret = error(_("unable to parse commit %s"),
+				    oid_to_hex(&parent->object.oid));
+			goto out;
+		}
+		parent_tree_oid = repo_get_commit_tree(repo, parent)->object.oid;
+	} else {
+		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
+	}
+
+	head = lookup_commit_reference_by_name("HEAD");
+	if (!head) {
+		ret = error(_("could not resolve HEAD to a commit"));
+		goto out;
+	}
+
+	commit_list_append(original_commit, &from_list);
+	if (!repo_is_descendant_of(repo, head, from_list)) {
+		ret = error (_("split commit must be reachable from current HEAD commit"));
+		goto out;
+	}
+
+	/*
+	 * Collect the list of commits that we'll have to reapply now already.
+	 * This ensures that we'll abort early on in case the range of commits
+	 * contains merges, which we do not yet handle.
+	 */
+	ret = collect_commits(repo, parent, head, &commits);
+	if (ret < 0)
+		goto out;
+
+	/* We retain authorship of the original commit. */
+	original_message = repo_logmsg_reencode(repo, original_commit, NULL, NULL);
+	ptr = find_commit_header(original_message, "author", &len);
+	if (ptr)
+		original_author = xmemdupz(ptr, len);
+	find_commit_subject(original_message, &original_body);
+
+	ret = fill_commit_message(repo, &parent_tree_oid, &original_commit_tree_oid,
+				  original_body, commit_message, "reworded", &final_message);
+	if (ret < 0)
+		goto out;
+
+	ret = commit_tree(final_message.buf, final_message.len, &original_commit_tree_oid,
+			  original_commit->parents, &rewritten_commit, original_author, NULL);
+	if (ret < 0) {
+		ret = error(_("failed writing reworded commit"));
+		goto out;
+	}
+
+	replace_commits(&commits, &original_commit->object.oid, &rewritten_commit, 1);
+
+	ret = apply_commits(repo, &commits, parent, head, "reword");
+	if (ret < 0)
+		goto out;
+
+	ret = 0;
+
+out:
+	strbuf_release(&final_message);
+	free_commit_list(from_list);
+	strvec_clear(&commits);
+	free(original_author);
+	return ret;
+}
 
 int cmd_history(int argc,
 		const char **argv,
 		const char *prefix,
-		struct repository *repo UNUSED)
+		struct repository *repo)
 {
 	const char * const usage[] = {
 		N_("git history [<options>]"),
+		GIT_HISTORY_REWORD_USAGE,
 		NULL,
 	};
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
+		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
 		OPT_END(),
 	};
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
-	if (argc)
-		usagef("unrecognized argument: %s", argv[0]);
-	return 0;
+	return fn(argc, argv, prefix, repo);
 }
diff --git a/t/meson.build b/t/meson.build
index 019435918fa..a3ec9199947 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -385,6 +385,7 @@ integration_tests = [
   't3437-rebase-fixup-options.sh',
   't3438-rebase-broken-files.sh',
   't3450-history.sh',
+  't3451-history-reword.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3450-history.sh b/t/t3450-history.sh
index 417c343d43b..f513463b92b 100755
--- a/t/t3450-history.sh
+++ b/t/t3450-history.sh
@@ -5,13 +5,13 @@ test_description='tests for git-history command'
 . ./test-lib.sh
 
 test_expect_success 'does nothing without any arguments' '
-	git history >out 2>&1 &&
-	test_must_be_empty out
+	test_must_fail git history 2>err &&
+	test_grep "need a subcommand" err
 '
 
 test_expect_success 'raises an error with unknown argument' '
 	test_must_fail git history garbage 2>err &&
-	test_grep "unrecognized argument: garbage" err
+	test_grep "unknown subcommand: .garbage." err
 '
 
 test_done
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
new file mode 100755
index 00000000000..b73371fb51c
--- /dev/null
+++ b/t/t3451-history-reword.sh
@@ -0,0 +1,217 @@
+#!/bin/sh
+
+test_description='tests for git-history reword subcommand'
+
+. ./test-lib.sh
+
+test_expect_success 'refuses to work with merge commits' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch branch &&
+		test_commit ours &&
+		git switch branch &&
+		test_commit theirs &&
+		git switch - &&
+		git merge theirs &&
+		test_must_fail git history reword HEAD~ 2>err &&
+		test_grep "cannot rearrange commit history with merges" err &&
+		test_must_fail git history reword HEAD 2>err &&
+		test_grep "cannot rearrange commit history with merges" err
+	)
+'
+
+test_expect_success 'refuses to work with unrelated commits' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch branch &&
+		test_commit ours &&
+		git switch branch &&
+		test_commit theirs &&
+		test_must_fail git history reword ours 2>err &&
+		test_grep "split commit must be reachable from current HEAD commit" err
+	)
+'
+
+test_expect_success 'can reword tip of a branch' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		git symbolic-ref HEAD >expect &&
+		git history reword -m "third reworded" HEAD &&
+		git symbolic-ref HEAD >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-EOF &&
+		third reworded
+		second
+		first
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'can reword commit in the middle' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		git symbolic-ref HEAD >expect &&
+		git history reword -m "second reworded" HEAD~ &&
+		git symbolic-ref HEAD >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-EOF &&
+		third
+		second reworded
+		first
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'can reword root commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		git history reword -m "first reworded" HEAD~2 &&
+
+		cat >expect <<-EOF &&
+		third
+		second
+		first reworded
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'can use editor to rewrite commit message' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+
+		write_script fake-editor.sh <<-\EOF &&
+		cp "$1" . &&
+		printf "\namend a comment\n" >>"$1"
+		EOF
+		test_set_editor "$(pwd)"/fake-editor.sh &&
+		git history reword HEAD &&
+
+		cat >expect <<-EOF &&
+		first
+
+		# Please enter the commit message for the reworded changes. Lines starting
+		# with ${SQ}#${SQ} will be ignored.
+		# Changes to be committed:
+		#	new file:   first.t
+		#
+		EOF
+		test_cmp expect COMMIT_EDITMSG &&
+
+		cat >expect <<-EOF &&
+		first
+
+		amend a comment
+
+		EOF
+		git log --format=%B >actual &&
+		test_cmp expect actual
+	)
+'
+
+# For now, git-history(1) does not yet execute any hooks. This is subject to
+# change in the future, and if it does this test here is expected to start
+# failing. In other words, this test is not an endorsement of the current
+# status quo.
+test_expect_success 'hooks are executed for rewritten commits' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		write_script .git/hooks/prepare-commit-msg <<-EOF &&
+		touch "$(pwd)/hooks.log
+		EOF
+		write_script .git/hooks/post-commit <<-EOF &&
+		touch "$(pwd)/hooks.log
+		EOF
+		write_script .git/hooks/post-rewrite <<-EOF &&
+		touch "$(pwd)/hooks.log
+		EOF
+
+		git history reword -m "second reworded" HEAD~ &&
+
+		cat >expect <<-EOF &&
+		third
+		second reworded
+		first
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual &&
+
+		test_path_is_missing hooks.log
+	)
+'
+
+test_expect_success 'aborts with empty commit message' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+
+		test_must_fail git history reword -m "" HEAD 2>err &&
+		test_grep "Aborting commit due to empty commit message." err
+	)
+'
+
+test_expect_success 'retains changes in the worktree and index' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		touch a b &&
+		git add . &&
+		git commit -m "initial commit" &&
+		echo foo >a &&
+		echo bar >b &&
+		git add b &&
+		git history reword HEAD -m message &&
+		cat >expect <<-\EOF &&
+		 M a
+		M  b
+		?? actual
+		?? expect
+		EOF
+		git status --porcelain >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_done

-- 
2.51.1.851.g4ebd6896fd.dirty

