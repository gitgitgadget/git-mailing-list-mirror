Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F4E30C620
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996089; cv=none; b=EuKlK3DA9MEcahBhW4uN+bAF7qEQtBiwv46TJuduYAV+rSAKJ4kzH8TOUeWlShbSjtKcZ3/bR+hk5Ql+4LzQW+Jxumc7OuXCkmksN3uAvr6ZT52r7WOZLSLGLo67LwimLoDersq6Yn2abGMwgrvT9JPz85bJLkvrtpV5UIizvwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996089; c=relaxed/simple;
	bh=VzLX1GkpGTi37sLfrEYpkPUok1dODFEKem1N5BBHlZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pQl9qDJX0QkkArs30Ktp50P1it4MSDtQIf1fythgJGw/2Tk3zAXB7S5iuQMpp/0Tc8sz3BIO0HK+lgMZZtRNw4V25p7cm5grDLDZeAAT5AyNr6nffeuN70J+Aa3b5WrisVIMIrmnOR0A5X3xydv5vYJNTGJ4ljSl8koxj+jy/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i/Uof2Qy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WuQGBiYg; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i/Uof2Qy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WuQGBiYg"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 12A847A035E;
	Thu,  4 Sep 2025 10:28:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 04 Sep 2025 10:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996085;
	 x=1757082485; bh=lRUUCZyoJew2WwpinPvIKmcAMDnfNTzXPcQxwitJjqA=; b=
	i/Uof2QykVZZsvViI9zgede/R+GWgJMu+k94bDwDeTe2DqhRxwlManjm5tzZDugS
	bebDQYzVAv/JCp88Zm+HTGmLjVULTgSzeE++N2YJEo+lu5Mdoar8thZnl1cVTGk9
	YhOrcBa3j5AFawXIuUEWQjeckpJTcY6SmAMD+2dcQIHysMnySOuP3u7H6K/nqcok
	z4IJXyziUZ21q2/RVad2rkNsihsENfWszNhrJmSzyKrkrhlgeeKe5hG7ak0XwITs
	IJ+bCePRs0SyYfVzVQ7Ymc79SSePs59zGHuZjHwka8MqOt+nQB5I87iLZ1JrVCyd
	Z549Vbb0ZKB3jEl4S/Hagw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996085; x=
	1757082485; bh=lRUUCZyoJew2WwpinPvIKmcAMDnfNTzXPcQxwitJjqA=; b=W
	uQGBiYgQlWRqFMtyxuxS1JLBiBuwhzyQ/bYsshWCjrnxPQRdJ8fRUeJBrD97CIOc
	ceduPJu/3MBLzIIhjXO0HMJBamDjjkzR9VTwCdb9Vm9IWUBZhejtdsG83P8asCuJ
	9X7dcClRY/g1VdDW7+KRriKcwrmvPEk65Ei860UF4ekpNl2tc1/0PivoevkOaXwh
	8DZ8ie24mwD1iljnDhRjtFliU0pq3QZO6Y8OE8+xlmAFfga4UEt2BjcbTVQCcfq5
	/nIEn+rq56sLL9sNVTOS0IK8SMD0BJLO7ddyuCFISbyz2i8/oQ3EpVT2qYu3ffTC
	MIV8p5t8tnfSjusaSKA4A==
X-ME-Sender: <xms:9aG5aB7pIkF_xy-_TXRyE4GY2OvdkuyOkdDUZG3xXPvNq7RmCgqyAg>
    <xme:9aG5aMcROvAbO6ZUhmpN94NYNe74EmvnlrSdHrdUSBARl6TDW7oR_vlDzYc5dqg55
    Ug8peC-CuIWyYl_jQ>
X-ME-Received: <xmr:9aG5aO7J1fhgp6t-JpFI_QhXWQ9ABtxj0j0SghDR1J-t047850DhQU4OPPKFDSQs8qG2vVIPJQnpX7x9OBv8HlK1f8fXwul6Oq7cLgjxZbjVUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsoh
    hrghgrnhhovhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:9aG5aLuij9n34xKpJH1GS0mF_VtnZzToZiCrp1Lv3wplRqj4hU2JhA>
    <xmx:9aG5aGirDS9paZDaWdba55YlLe5_udl9OhdGcoy4K1PuZNSF0jGeKA>
    <xmx:9aG5aOrGi_gMh8RS1eNm09Nk8Fb1jHJ-9G7zCHgYohsGh_8lzmc4OQ>
    <xmx:9aG5aLvoWkJmZSGbZG1YqYB5gI01UgnKOR5CIWIHfdFe-buwOQ7aOQ>
    <xmx:9aG5aCWlVG__JE7Lm4Z9kroz-vv95VSyimNg4pyE9tMsvf4sCfAhgX3a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:28:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 19c54e80 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:28:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:27:39 +0200
Subject: [PATCH RFC v3 09/18] builtin/history: implement "drop" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-history-builtin-v3-9-509053514755@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

It is a fairly common operation to perform an interactive rebase so that
one of the commits can be dropped from history. Doing this is not very
hard in general, but still requires the user to perform multiple steps:

  1. Identify the commit in question that is to be dropped.

  2. Perform an interactive rebase on top of that commit's parent.

  3. Edit the instruction sheet to drop that commit.

This is needlessly complex for such a supposedly-trivial operation.
Furthermore, the second step doesn't account for certain edge cases like
for example dropping the root commit.

Introduce a new "drop" subcommand to make this use case significantly
simpler: all the user needs to do is to say `git history drop $COMMIT`
and they're done.

Note that for now, this command only allows users to drop a single
commit at once. It should be easy enough though to expand the command at
a later point in time to support dropping whole commit ranges.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc |  27 ++++
 builtin/history.c              | 287 +++++++++++++++++++++++++++++++++++++++++
 t/meson.build                  |   1 +
 t/t3451-history-drop.sh        | 207 +++++++++++++++++++++++++++++
 4 files changed, 522 insertions(+)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 3e9a789b83..39c9f1e25e 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -11,6 +11,7 @@ SYNOPSIS
 git history abort
 git history continue
 git history quit
+git history drop <commit>
 
 DESCRIPTION
 -----------
@@ -35,6 +36,15 @@ COMMANDS
 This command requires a subcommand. Several subcommands are available to
 rewrite history in different ways:
 
+`drop <commit>`::
+	Drop a commit from the history and reapply all children of that
+	commit on top of the commit's parent. The commit that is to be
+	dropped must be reachable from the currently checked-out commit.
++
+Dropping the root commit converts the child of that commit into the new
+root commit. It is invalid to drop a root commit that does not have any
+child commits, as that would lead to an empty branch.
+
 The following commands are used to manage an interrupted history-rewriting
 operation:
 
@@ -51,6 +61,23 @@ operation:
 	the original branch. The index and working tree are also left unchanged
 	as a result.
 
+EXAMPLES
+--------
+
+Drop a commit from history
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+----------
+$ git log --oneline
+2d4cd6d third
+125a0f3 second
+e098c27 first
+$ git history drop HEAD~
+$ git log
+b1bc1bd third
+e098c27 first
+----------
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/history.c b/builtin/history.c
index 0ad45dbfef..2132b6a441 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1,7 +1,16 @@
 #include "builtin.h"
 #include "branch.h"
+#include "commit.h"
+#include "commit-reach.h"
+#include "config.h"
+#include "environment.h"
 #include "gettext.h"
+#include "hex.h"
+#include "object-name.h"
 #include "parse-options.h"
+#include "refs.h"
+#include "reset.h"
+#include "revision.h"
 #include "sequencer.h"
 
 static int cmd_history_abort(int argc,
@@ -104,6 +113,282 @@ static int cmd_history_quit(int argc,
 	return ret;
 }
 
+static int collect_commits(struct repository *repo,
+			   struct commit *old_commit,
+			   struct commit *new_commit,
+			   struct strvec *out)
+{
+	struct setup_revision_opt revision_opts = {
+		.assume_dashdash = 1,
+	};
+	struct strvec revisions = STRVEC_INIT;
+	struct commit_list *from_list = NULL;
+	struct commit *child;
+	struct rev_info rev = { 0 };
+	int ret;
+
+	/*
+	 * Check that the old commit actually is an ancestor of HEAD. If not
+	 * the whole request becomes nonsensical.
+	*/
+	if (old_commit) {
+		commit_list_insert(old_commit, &from_list);
+		if (!repo_is_descendant_of(repo, new_commit, from_list)) {
+			ret = error(_("commit must be reachable from current HEAD commit"));
+			goto out;
+		}
+	}
+
+	repo_init_revisions(repo, &rev, NULL);
+	strvec_push(&revisions, "");
+	strvec_push(&revisions, oid_to_hex(&new_commit->object.oid));
+	if (old_commit)
+		strvec_pushf(&revisions, "^%s", oid_to_hex(&old_commit->object.oid));
+	if (setup_revisions(revisions.nr, revisions.v, &rev, &revision_opts) != 1 ||
+	    prepare_revision_walk(&rev)) {
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
+	free_commit_list(from_list);
+	strvec_clear(&revisions);
+	release_revisions(&rev);
+	reset_revision_walk();
+	return ret;
+}
+
+static int apply_commits(struct repository *repo,
+			 const struct strvec *commits,
+			 struct commit *head,
+			 struct commit *base,
+			 const char *action)
+{
+	struct setup_revision_opt revision_opts = {
+		.assume_dashdash = 1,
+	};
+	struct replay_opts replay_opts = REPLAY_OPTS_INIT;
+	struct reset_head_opts reset_opts = { 0 };
+	struct object_id root_commit;
+	struct strvec args = STRVEC_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	char hex[GIT_MAX_HEXSZ + 1];
+	int ref_flags, ret;
+
+	/*
+	 * We have performed all safety checks, so we now prepare
+	 * replaying the commits.
+	*/
+	replay_opts.action = REPLAY_HISTORY_EDIT;
+	sequencer_init_config(&replay_opts);
+	replay_opts.quiet = 1;
+	replay_opts.skip_commit_summary = 1;
+	if (!replay_opts.strategy && replay_opts.default_strategy) {
+		replay_opts.strategy = replay_opts.default_strategy;
+		replay_opts.default_strategy = NULL;
+	}
+
+	strvec_push(&args, "");
+	strvec_pushv(&args, commits->v);
+
+	replay_opts.revs = xmalloc(sizeof(*replay_opts.revs));
+	repo_init_revisions(repo, replay_opts.revs, NULL);
+	replay_opts.revs->no_walk = 1;
+	replay_opts.revs->unsorted_input = 1;
+	if (setup_revisions(args.nr, args.v, replay_opts.revs,
+			    &revision_opts) != 1) {
+		ret = error(_("setting up revisions failed"));
+		goto out;
+	}
+
+	/*
+	 * If we're dropping the root commit we first need to create
+	 * a new empty root. We then instruct the seqencer machinery to
+	 * squash that root commit with the first commit we're picking
+	 * onto it.
+	 */
+	if (!base->parents) {
+		if (commit_tree("", 0, repo->hash_algo->empty_tree, NULL,
+				&root_commit, NULL, NULL) < 0) {
+			ret = error(_("Could not create new root commit"));
+			goto out;
+		}
+
+		replay_opts.squash_onto = root_commit;
+		replay_opts.have_squash_onto = 1;
+		reset_opts.oid = &root_commit;
+	} else {
+		reset_opts.oid = &base->parents->item->object.oid;
+	}
+
+	replay_opts.restore_head_target =
+		xstrdup_or_null(refs_resolve_ref_unsafe(get_main_ref_store(repo),
+							"HEAD", 0, NULL, &ref_flags));
+	if (!(ref_flags & REF_ISSYMREF))
+		FREE_AND_NULL(replay_opts.restore_head_target);
+
+	/*
+	 * Perform a hard-reset to the parent of our commit that is to
+	 * be dropped. This is the new base onto which we'll pick all
+	 * the descendants.
+	 */
+	strbuf_addf(&buf, "%s (start): checkout %s", action,
+		    oid_to_hex_r(hex, reset_opts.oid));
+	reset_opts.orig_head = &head->object.oid;
+	reset_opts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD;
+	reset_opts.head_msg = buf.buf;
+	reset_opts.default_reflog_action = action;
+	if (reset_head(repo, &reset_opts) < 0) {
+		ret = error(_("could not switch to %s"), oid_to_hex(reset_opts.oid));
+		goto out;
+	}
+
+	ret = sequencer_pick_revisions(repo, &replay_opts);
+	if (ret < 0) {
+		ret = error(_("could not pick commits"));
+		goto out;
+	} else if (ret > 0) {
+		/*
+		 * A positive return value indicates we've got a merge
+		 * conflict. Bail out, but don't print a message as
+		 * `sequencer_pick_revisions()` already printed enough
+		 * information.
+		 */
+		ret = -1;
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	replay_opts_release(&replay_opts);
+	strbuf_release(&buf);
+	strvec_clear(&args);
+	return ret;
+}
+
+static int cmd_history_drop(int argc,
+			    const char **argv,
+			    const char *prefix,
+			    struct repository *repo)
+{
+	const char * const usage[] = {
+		N_("git history drop <commit>"),
+		NULL,
+	};
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct commit *commit_to_drop, *head;
+	struct strvec commits = STRVEC_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc != 1) {
+		ret = error(_("command expects a single revision"));
+		goto out;
+	}
+	repo_config(repo, git_default_config, NULL);
+
+	commit_to_drop = lookup_commit_reference_by_name(argv[0]);
+	if (!commit_to_drop) {
+		ret = error(_("commit to be dropped cannot be found: %s"), argv[0]);
+		goto out;
+	}
+	if (commit_to_drop->parents && commit_to_drop->parents->next) {
+		ret = error(_("commit to be dropped must not be a merge commit"));
+		goto out;
+	}
+
+	head = lookup_commit_reference_by_name("HEAD");
+	if (!head) {
+		ret = error(_("could not resolve HEAD to a commit"));
+		goto out;
+	}
+
+	if (oideq(&commit_to_drop->object.oid, &head->object.oid)) {
+		/*
+		 * If we want to drop the tip of the current branch we don't
+		 * have to perform any rebase at all. Instead, we simply
+		 * perform a hard reset to the parent commit.
+		 */
+		struct reset_head_opts reset_opts = {
+			.orig_head = &head->object.oid,
+			.flags = RESET_ORIG_HEAD,
+			.default_reflog_action = "drop",
+		};
+		char hex[GIT_MAX_HEXSZ + 1];
+
+		if (!commit_to_drop->parents) {
+			ret = error(_("cannot drop the only commit on this branch"));
+			goto out;
+		}
+
+		oid_to_hex_r(hex, &commit_to_drop->parents->item->object.oid);
+		strbuf_addf(&buf, "drop (start): checkout %s", hex);
+		reset_opts.oid = &commit_to_drop->parents->item->object.oid;
+		reset_opts.head_msg = buf.buf;
+
+		if (reset_head(repo, &reset_opts) < 0) {
+			ret = error(_("could not switch to %s"), hex);
+			goto out;
+		}
+	} else {
+		/*
+		 * Prepare a revision walk from old commit to the commit that is
+		 * about to be dropped. This serves three purposes:
+		 *
+		 *   - We verify that the history doesn't contain any merges.
+		 *     For now, merges aren't yet handled by us.
+		 *
+		 *   - We need to find the child of the commit-to-be-dropped.
+		 *     This child is what will be adopted by the parent of the
+		 *     commit that we are about to drop.
+		 *
+		 *   - We compute the list of commits-to-be-picked.
+		 */
+		ret = collect_commits(repo, commit_to_drop, head, &commits);
+		if (ret < 0)
+			goto out;
+
+		ret = apply_commits(repo, &commits, head, commit_to_drop, "drop");
+		if (ret < 0)
+			goto out;
+	}
+
+	ret = 0;
+
+out:
+	strvec_clear(&commits);
+	strbuf_release(&buf);
+	return ret;
+}
+
 int cmd_history(int argc,
 		const char **argv,
 		const char *prefix,
@@ -113,6 +398,7 @@ int cmd_history(int argc,
 		N_("git history abort"),
 		N_("git history continue"),
 		N_("git history quit"),
+		N_("git history drop <commit>"),
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -120,6 +406,7 @@ int cmd_history(int argc,
 		OPT_SUBCOMMAND("abort", &fn, cmd_history_abort),
 		OPT_SUBCOMMAND("continue", &fn, cmd_history_continue),
 		OPT_SUBCOMMAND("quit", &fn, cmd_history_quit),
+		OPT_SUBCOMMAND("drop", &fn, cmd_history_drop),
 		OPT_END(),
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 966d7c14f4..8189c6c561 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -377,6 +377,7 @@ integration_tests = [
   't3437-rebase-fixup-options.sh',
   't3438-rebase-broken-files.sh',
   't3450-history.sh',
+  't3451-history-drop.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3451-history-drop.sh b/t/t3451-history-drop.sh
new file mode 100755
index 0000000000..4fc295ef21
--- /dev/null
+++ b/t/t3451-history-drop.sh
@@ -0,0 +1,207 @@
+#!/bin/sh
+
+test_description='tests for git-history drop subcommand'
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
+		test_must_fail git history drop HEAD 2>err &&
+		test_grep "commit to be dropped must not be a merge commit" err &&
+		test_must_fail git history drop HEAD~ 2>err &&
+		test_grep "cannot rearrange commit history with merges" err
+	)
+'
+
+test_expect_success 'refuses to work when history becomes empty' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		test_must_fail git history drop HEAD 2>err &&
+		test_grep "cannot drop the only commit on this branch" err
+	)
+'
+
+test_expect_success 'refuses to work with changes in the worktree or index' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		test_commit file file &&
+		echo foo >file &&
+		test_must_fail git history drop HEAD 2>err &&
+		test_grep "Your local changes to the following files would be overwritten" err &&
+		git add file &&
+		test_must_fail git history drop HEAD 2>err &&
+		test_grep "Your local changes to the following files would be overwritten" err
+	)
+'
+
+test_expect_success 'can drop tip of a branch' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		git symbolic-ref HEAD >expect &&
+		git history drop HEAD &&
+		git symbolic-ref HEAD >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-EOF &&
+		second
+		first
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'can drop commit in the middle' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		test_commit fourth &&
+		test_commit fifth &&
+
+		git symbolic-ref HEAD >expect &&
+		git history drop HEAD~2 &&
+		git symbolic-ref HEAD >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-EOF &&
+		fifth
+		fourth
+		second
+		first
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'correct order is retained' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		test_commit fourth &&
+		test_commit fifth &&
+		git history drop HEAD~3 &&
+		cat >expect <<-EOF &&
+		fifth
+		fourth
+		third
+		first
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
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
+		echo "prepare-commit-msg: \$@" >>"$(pwd)/hooks.log"
+		EOF
+		write_script .git/hooks/post-commit <<-EOF &&
+		echo "post-commit" >>"$(pwd)/hooks.log"
+		EOF
+		write_script .git/hooks/post-rewrite <<-EOF &&
+		{
+			echo "post-rewrite: \$@"
+			cat
+		} >>"$(pwd)/hooks.log"
+		EOF
+
+		git history drop HEAD~ &&
+		cat >expect <<-EOF &&
+		prepare-commit-msg: .git/COMMIT_EDITMSG message
+		post-commit
+		post-rewrite: history
+		$(git rev-parse third) $(git rev-parse HEAD)
+		EOF
+		test_cmp expect hooks.log
+	)
+'
+
+test_expect_success 'can drop root commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		git history drop HEAD~2 &&
+		cat >expect <<-EOF &&
+		third
+		second
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'conflicts are detected' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		echo original >file &&
+		git add . &&
+		git commit -m original &&
+		echo modified >file &&
+		git commit -am modified &&
+
+		test_must_fail git history drop HEAD~ >err 2>&1 &&
+		test_grep CONFLICT err &&
+		test_grep "git history continue" err &&
+		echo resolved >file &&
+		git add file &&
+		git history continue &&
+
+		cat >expect <<-EOF &&
+		modified
+		base
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual &&
+		echo resolved >expect &&
+		git cat-file -p HEAD:file >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_done

-- 
2.51.0.417.g1ba7204a04.dirty

