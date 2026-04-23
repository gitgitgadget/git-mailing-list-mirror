Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259EC35F5E7
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954129; cv=none; b=Vzm9FXgGnY5DqvXniJLCEi/yXVQbvXsJfXoiSXhHUVTbnpgSU898gTEkcn1ZRgOdPGABgXM8xccWTA5G8SJ7oIhg4QhrX1OWmpmYNyO7Qa7o9mZ8unVgmwaGyolUBTmVP2yvmq5lvn0jtBoT4nIKG7Ey4ntCPsuMWrNbLPrac0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954129; c=relaxed/simple;
	bh=148xvAtyc5ShkIWi6o0lhz6iQ6m2wNK3hWYtB12PzNU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Rv6VVXBTleWUgZRpIIqknwxmJz+zxbnXAcr7fPPC3fcYrpJLlLvQ/n/dv5mphraBH/ZJFgBMY4D855J7FqHVuz4DuhCCPcvu5M94bOgOXo6zI9mpvjvkfzcHjpYVO+P903uhp61mPTNu1EghwmHliHuH6AogVuk7952B8+cuI1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sxrp6qMt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oXylPvcy; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sxrp6qMt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oXylPvcy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 035091D000D1;
	Thu, 23 Apr 2026 10:22:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 23 Apr 2026 10:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776954123;
	 x=1777040523; bh=zBg0RNF9AlQy8Iqba15ZCOQDu6vmuIiBnGnPjMeIIBk=; b=
	sxrp6qMtEtEn06RuGWL1zhRBBSLIRoy2i48tV4lWwz0dmvvg4h+0EmAEZAGDmWze
	Map7OvnK/4jyc9zXvj4mefxByd9NNC7YkycGUh71IILrX5V14inNd09lUyBWw1kb
	36vUnVNV/zGh/Cm+YIcbKSBwl+hAesLAjlOBOyOjSxXStREfgKFZRC9UgsmOb2+1
	EI3fOMXV8y4VixLdIom/0okA4l8/+pKI0OhyCL8kmK1Zd/HPjAbQF5axS/U72M1X
	oDXMs0jJ2JqEKdzIUOD5H7760KWJtsYs8yLIikFm1fhK+5yD78TUsiTktrRcQddq
	6IlUIg3Q6+S9PU7wcOQvgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776954123; x=
	1777040523; bh=zBg0RNF9AlQy8Iqba15ZCOQDu6vmuIiBnGnPjMeIIBk=; b=o
	XylPvcy164D0RbejahsfRd6h3l8nZ8P5DhmBsc4vkYDJLhoUOq+sX7R/PPTrWcqf
	dc+UjEHq8IspXpYQdy2/SfUjvwBU8rdKz+z8+RbGgGlSimHWBRTcD/R+mxyKYO9/
	miGnsxyGhdBKJphGxrGKqb0rxxhDUvrxKmcXYZycF3zl58DPZFyPzibbSwQKwBvo
	EOb8FHvUq/iTZ9FmlTXZf86+/ZmZdnrIMXBB9W9Y2UPUxGSLM+MKLsuh3YUi9SUo
	JLTlNczK90fUk+RNw6u44gPzkUAxyzOTavKp61Vqam5f69oOOOgVYDmhrWGdh+Tq
	2m0CHt0atPNtKXV+IYR2g==
X-ME-Sender: <xms:CyvqaYwfZjzBxjcRkU1bARM1uBZmm6XnZtA-yNNUyJbh_OJ9iCtvVg>
    <xme:CyvqaTT3EVirWlGJeL-jell1W8z6pjqv9R2NawPMyjLFbkN1xgTvKd2jlGro82soA
    ENwWExEHoxRtb5tkj-JJhzQbXYF8UUIa-jteJZ9Ui7BS-uMMaelZA>
X-ME-Received: <xmr:CyvqafUGmQ2t6xEN1nLiCJsVjPu-YbX2mk0_1xOiqPtdNGu-LE8DNwqYW31-QtCDuppu-d5_XAidKFs1nkmNzS_W6VOB0iKhOVlmhCpl8zIX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdffkeektdefleetveegueethedtfeeugeegvddvhfdvtdetieeiueekhefgfeehnecu
    ffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhopegsvghnrdhknhhosghlvgesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:CyvqaVYiZP_8RuJ3gzDmHEgowKaXBHXLkEFl2JwoLXNP46TYBxTsRw>
    <xmx:CyvqaV0YBZ1vvUqGXyqNYRg3gpD5HPD93jU9kQuaUHwFc8lc25czYQ>
    <xmx:CyvqaXg7Ydl1yLmHHaoUIn3yPHsvkm9epkS2gAAox8wiNWvPlL1Peg>
    <xmx:CyvqaZY1X1R3iJ5LFRBBtt0DtELRceAtcEp_CZzGZmRQS9b6CIwNHA>
    <xmx:CyvqacSqEFHKGKMoM0Nhu3ySTHndJfgw0GJMPQkZKO-fk_eWk2TZaNgU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 10:22:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dca4554a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 23 Apr 2026 14:22:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/3] builtin/history: introduce "fixup" subcommand
Date: Thu, 23 Apr 2026 16:21:55 +0200
Message-Id: <20260423-b4-pks-history-fixup-v2-0-d7571c6d36eb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAQr6mkC/4WNwQ6CMBBEf4Xs2TVl2Sjx5H8YDpSushqhaYFoC
 P9uQe8eX+bNzAxRgkqEUzZDkEmj9l0C2mXQtHV3E1SXGMjQwTARWkb/iNhqHPrwxqu+Ro9W6Ci
 m4doUAqnqg6Rgm71UX46jvUszrFur8etvv1O+en8uphwNcumYSyYunJyTs9cnVMuyfACqW/Bpx
 wAAAA==
X-Change-ID: 20260422-b4-pks-history-fixup-be27e0c4a03e
In-Reply-To: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im>
References: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, 
 "D. Ben Knoble" <ben.knoble@gmail.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Hi,

this short patch series introduces a new "fixup" subcommand. This
command is the first one that I felt is missing in my day to day work,
as I end up doing fixup commits quite often.

The flow is rather simple: the user stages some changes, and then they
execute `git history fixup <commit>` to amend those changes to the given
commit. As with the other subcommands, dependent branches will then be
rebased automatically.

This is the first command that may result in merge conflicts. For now we
simply abort in such cases, but there are plans to introduce first-class
conflicts into Git. So once we have them, we'll also be able to handle
such cases more gracefully. I still think that the command is useful
even without that conflict handling.

Changes in v2:
  - Introduce "--empty=(keep|drop|abort)" to specify what happens with
    empty commits.
  - Adapt documentation a bit to hopefully clarify how changes are
    backported.
  - Link to v1: https://patch.msgid.link/20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (3):
      replay: allow callers to control what happens with empty commits
      builtin/history: generalize function to commit trees
      builtin/history: introduce "fixup" subcommand

 Documentation/git-history.adoc |  77 ++++-
 builtin/history.c              | 291 ++++++++++++++++--
 replay.c                       |  29 +-
 replay.h                       |  19 ++
 t/meson.build                  |   1 +
 t/t3453-history-fixup.sh       | 680 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1067 insertions(+), 30 deletions(-)

Range-diff versus v1:

-:  ---------- > 1:  79b53c5c27 replay: allow callers to control what happens with empty commits
1:  3bbe1f8b98 = 2:  79573cb5bf builtin/history: generalize function to commit trees
2:  44f22df21e ! 3:  afdfd49f96 builtin/history: introduce "fixup" subcommand
    @@ Documentation/git-history.adoc: git-history - EXPERIMENTAL: Rewrite history
      SYNOPSIS
      --------
      [synopsis]
    -+git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message]
    ++git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
      git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
      git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
      
    @@ Documentation/git-history.adoc: THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY C
      * linkgit:git-history[1] does not execute any linkgit:githooks[5] at the
        current point in time. This may change in the future.
      * linkgit:git-history[1] by default updates all branches that are descendants
    -@@ Documentation/git-history.adoc: COMMANDS
    +@@ Documentation/git-history.adoc: conflicts. This limitation is by design as history rewrites are not intended to
    + be stateful operations. The limitation can be lifted once (if) Git learns about
    + first-class conflicts.
    + 
    ++When using `fixup` with `--empty=drop`, dropping the root commit is not yet
    ++supported.
    ++
    + COMMANDS
    + --------
      
      The following commands are available to rewrite history in different ways:
      
     +`fixup <commit>`::
    -+	Apply the currently staged changes to the specified commit. The staged
    -+	changes are incorporated into the target commit's tree via a three-way
    -+	merge, using HEAD's tree as the merge base, which is equivalent to
    -+	linkgit:git-cherry-pick[1].
    ++	Apply the currently staged changes to the specified commit. This
    ++	is done by performing a three-way merge between the HEAD commit,
    ++	the target commit and the tree generated from staged changes.
    ++	This is using the same logic as linkgit:git-cherry-pick[1].
     ++
     +The commit message and authorship of the target commit are preserved by
     +default, unless you specify `--reedit-message`.
    @@ Documentation/git-history.adoc: OPTIONS
      
     +`--reedit-message`::
     +	Open an editor to modify the target commit's message.
    ++
    ++`--empty=(drop|keep|abort)`::
    ++	Control what happens when a commit becomes empty as a result of the
    ++	fixup. This can happen in two situations:
    +++
    ++--
    ++* The fixup target itself becomes empty because the staged changes exactly
    ++  cancel out all changes introduced by that commit.
    ++
    ++* A descendant commit becomes empty during replay because it introduced the
    ++  same change that was just fixed up into an ancestor.
    ++--
    +++
    ++With `drop` (the default), empty commits are removed from the rewritten
    ++history. Descendants of a dropped target commit are replayed directly onto
    ++the target's parent. Note that dropping the root commit is not supported;
    ++see LIMITATIONS.
    +++
    ++With `keep`, empty commits are retained in the rewritten history as-is.
    +++
    ++With `abort`, the command stops with an error if any commit would become
    ++empty.
     +
      `--update-refs=(branches|head)`::
      	Control which references will be updated by the command, if any. With
    @@ builtin/history.c
      #include "wt-status.h"
      
     +#define GIT_HISTORY_FIXUP_USAGE \
    -+	N_("git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message]")
    ++	N_("git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]")
      #define GIT_HISTORY_REWORD_USAGE \
      	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
      #define GIT_HISTORY_SPLIT_USAGE \
    +@@ builtin/history.c: static int handle_reference_updates(struct rev_info *revs,
    + 				    struct commit *original,
    + 				    struct commit *rewritten,
    + 				    const char *reflog_msg,
    +-				    int dry_run)
    ++				    int dry_run,
    ++				    enum replay_empty_commit_action empty)
    + {
    + 	const struct name_decoration *decoration;
    +-	struct replay_revisions_options opts = { 0 };
    ++	struct replay_revisions_options opts = {
    ++		.empty = empty,
    ++	};
    + 	struct replay_result result = { 0 };
    + 	struct ref_transaction *transaction = NULL;
    + 	struct strbuf err = STRBUF_INIT;
     @@ builtin/history.c: static int handle_reference_updates(struct rev_info *revs,
      	return ret;
      }
      
    ++static int commit_became_empty(struct repository *repo,
    ++			       struct commit *original,
    ++			       struct tree *result)
    ++{
    ++	struct commit *parent = original->parents ? original->parents->item : NULL;
    ++	struct object_id parent_tree_oid;
    ++
    ++	if (parent) {
    ++		if (repo_parse_commit(repo, parent))
    ++			return error(_("unable to parse parent of %s"),
    ++				     oid_to_hex(&original->object.oid));
    ++
    ++		parent_tree_oid = repo_get_commit_tree(repo, parent)->object.oid;
    ++	} else {
    ++		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
    ++	}
    ++
    ++	return oideq(&result->object.oid, &parent_tree_oid);
    ++}
    ++
    ++static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
    ++{
    ++	enum replay_empty_commit_action *value = opt->value;
    ++
    ++	BUG_ON_OPT_NEG(unset);
    ++
    ++	if (!strcmp(arg, "drop"))
    ++		*value = REPLAY_EMPTY_COMMIT_DROP;
    ++	else if (!strcmp(arg, "keep"))
    ++		*value = REPLAY_EMPTY_COMMIT_KEEP;
    ++	else if (!strcmp(arg, "abort"))
    ++		*value = REPLAY_EMPTY_COMMIT_ABORT;
    ++	else
    ++		die(_("unrecognized '--empty=' action '%s'; "
    ++		      "valid values are \"drop\", \"keep\", and \"abort\"."), arg);
    ++
    ++	return 0;
    ++}
    ++
     +static int cmd_history_fixup(int argc,
     +			     const char **argv,
     +			     const char *prefix,
    @@ builtin/history.c: static int handle_reference_updates(struct rev_info *revs,
     +		GIT_HISTORY_FIXUP_USAGE,
     +		NULL,
     +	};
    ++	enum replay_empty_commit_action empty = REPLAY_EMPTY_COMMIT_DROP;
     +	enum ref_action action = REF_ACTION_DEFAULT;
    -+	int dry_run = 0;
     +	enum commit_tree_flags flags = 0;
    ++	int dry_run = 0;
     +	struct option options[] = {
     +		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
     +			       N_("control which refs should be updated"),
    @@ builtin/history.c: static int handle_reference_updates(struct rev_info *revs,
     +		OPT_BIT(0, "reedit-message", &flags,
     +			N_("open an editor to modify the commit message"),
     +			COMMIT_TREE_EDIT_MESSAGE),
    ++		OPT_CALLBACK_F(0, "empty", &empty, "(drop|keep|abort)",
    ++			       N_("how to handle commits that become empty"),
    ++			       PARSE_OPT_NONEG, parse_opt_empty),
     +		OPT_END(),
     +	};
     +	struct merge_result merge_result = { 0 };
    @@ builtin/history.c: static int handle_reference_updates(struct rev_info *revs,
     +	struct commit *head_commit, *original, *rewritten;
     +	struct tree *head_tree, *original_tree, *index_tree;
     +	struct rev_info revs = { 0 };
    ++	bool skip_commit = false;
     +	int ret;
     +
     +	argc = parse_options(argc, argv, prefix, options, usage, 0);
    @@ builtin/history.c: static int handle_reference_updates(struct rev_info *revs,
     +		goto out;
     +	}
     +
    ++	ret = commit_became_empty(repo, original, merge_result.tree);
    ++	if (ret < 0)
    ++		goto out;
    ++	if (ret > 0) {
    ++		switch (empty) {
    ++		case REPLAY_EMPTY_COMMIT_DROP:
    ++			/*
    ++			 * Drop the target commit by replaying its descendants
    ++			 * directly onto its parent.
    ++			 */
    ++			rewritten = original->parents ? original->parents->item : NULL;
    ++
    ++			/*
    ++			 * TODO: we don't yet have the ability to drop root
    ++			 * commits, but there's ultimately no good reason for
    ++			 * this restriction to exist other than a technical
    ++			 * limitation.
    ++			 */
    ++			if (!rewritten) {
    ++				ret = error(_("cannot drop root commit %s: "
    ++					      "it has no parent to replay onto"),
    ++					    argv[0]);
    ++				goto out;
    ++			}
    ++
    ++			skip_commit = true;
    ++			break;
    ++		case REPLAY_EMPTY_COMMIT_KEEP:
    ++			/* Proceed and record the empty commit. */
    ++			break;
    ++		case REPLAY_EMPTY_COMMIT_ABORT:
    ++			ret = error(_("fixup makes commit %s empty"), argv[0]);
    ++			goto out;
    ++		}
    ++	}
    ++
     +	ret = setup_revwalk(repo, action, original, &revs);
     +	if (ret)
     +		goto out;
     +
    -+	ret = commit_tree_ext(repo, "fixup", original, original->parents,
    -+			      &original_tree->object.oid, &merge_result.tree->object.oid,
    -+			      &rewritten, flags);
    -+	if (ret < 0) {
    -+		ret = error(_("failed writing fixed-up commit"));
    -+		goto out;
    ++	if (!skip_commit) {
    ++		ret = commit_tree_ext(repo, "fixup", original, original->parents,
    ++				      &original_tree->object.oid, &merge_result.tree->object.oid,
    ++				      &rewritten, flags);
    ++		if (ret < 0) {
    ++			ret = error(_("failed writing fixed-up commit"));
    ++			goto out;
    ++		}
     +	}
     +
     +	strbuf_addf(&reflog_msg, "fixup: updating %s", argv[0]);
     +
     +	ret = handle_reference_updates(&revs, action, original, rewritten,
    -+				       reflog_msg.buf, dry_run);
    ++				       reflog_msg.buf, dry_run, empty);
     +	if (ret < 0) {
     +		ret = error(_("failed replaying descendants"));
     +		goto out;
    @@ builtin/history.c: static int handle_reference_updates(struct rev_info *revs,
      static int cmd_history_reword(int argc,
      			      const char **argv,
      			      const char *prefix,
    +@@ builtin/history.c: static int cmd_history_reword(int argc,
    + 	strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
    + 
    + 	ret = handle_reference_updates(&revs, action, original, rewritten,
    +-				       reflog_msg.buf, dry_run);
    ++				       reflog_msg.buf, dry_run, REPLAY_EMPTY_COMMIT_ABORT);
    + 	if (ret < 0) {
    + 		ret = error(_("failed replaying descendants"));
    + 		goto out;
    +@@ builtin/history.c: static int cmd_history_split(int argc,
    + 	strbuf_addf(&reflog_msg, "split: updating %s", argv[0]);
    + 
    + 	ret = handle_reference_updates(&revs, action, original, rewritten,
    +-				       reflog_msg.buf, dry_run);
    ++				       reflog_msg.buf, dry_run, REPLAY_EMPTY_COMMIT_ABORT);
    + 	if (ret < 0) {
    + 		ret = error(_("failed replaying descendants"));
    + 		goto out;
     @@ builtin/history.c: int cmd_history(int argc,
      		struct repository *repo)
      {
    @@ t/t3453-history-fixup.sh (new)
     +	test_grep "cannot run fixup in a bare repository" err
     +'
     +
    ++test_expect_success 'errors with invalid --empty= value' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	test_must_fail git -C repo history fixup --empty=bogus HEAD 2>err &&
    ++	test_grep "unrecognized.*--empty.*bogus" err
    ++'
    ++
     +test_expect_success 'can fixup the tip commit' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
    @@ t/t3453-history-fixup.sh (new)
     +	)
     +'
     +
    ++test_expect_success '--empty=drop removes target commit and replays descendants onto its parent' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo --initial-branch=main &&
    ++	(
    ++		cd repo &&
    ++
    ++		test_commit first &&
    ++		test_commit second &&
    ++		test_commit third &&
    ++
    ++		git rm second.t &&
    ++		git history fixup --empty=drop HEAD~ &&
    ++
    ++		expect_changes <<-\EOF &&
    ++		third
    ++		1	0	third.t
    ++		first
    ++		1	0	first.t
    ++		EOF
    ++		test_must_fail git show HEAD:second.t
    ++	)
    ++'
    ++
    ++test_expect_success '--empty=drop errors out when dropping the root commit' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		test_commit first &&
    ++		test_commit second &&
    ++
    ++		git rm first.t &&
    ++		test_must_fail git history fixup --empty=drop HEAD~ 2>err &&
    ++		test_grep "cannot drop root commit" err
    ++	)
    ++'
    ++
    ++test_expect_success '--empty=drop can drop the HEAD commit' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		test_commit first &&
    ++		test_commit second &&
    ++
    ++		git rm second.t &&
    ++		git history fixup --empty=drop HEAD &&
    ++
    ++		expect_changes <<-\EOF
    ++		first
    ++		1	0	first.t
    ++		EOF
    ++	)
    ++'
    ++
    ++test_expect_success '--empty=drop drops empty replayed commits' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		touch base remove-me &&
    ++		git add . &&
    ++		git commit -m "base" &&
    ++		git rm remove-me &&
    ++		git commit -m "remove" &&
    ++		touch reintroduce remove-me &&
    ++		git add . &&
    ++		git commit -m "reintroduce" &&
    ++
    ++		git rm remove-me &&
    ++		git history fixup --empty=drop HEAD~2 &&
    ++
    ++		expect_changes <<-\EOF
    ++		reintroduce
    ++		0	0	reintroduce
    ++		0	0	remove-me
    ++		base
    ++		0	0	base
    ++		EOF
    ++	)
    ++'
    ++
    ++test_expect_success '--empty=keep keeps commit when fixup target becomes empty' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		test_commit first &&
    ++		test_commit second &&
    ++		test_commit third &&
    ++
    ++		git rm second.t &&
    ++		git history fixup --empty=keep HEAD~ &&
    ++
    ++		expect_changes <<-\EOF
    ++		third
    ++		1	0	third.t
    ++		second
    ++		first
    ++		1	0	first.t
    ++		EOF
    ++	)
    ++'
    ++
    ++test_expect_success '--empty=keep keeps commit when replayed commit becomes empty' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		touch base remove-me &&
    ++		git add . &&
    ++		git commit -m "base" &&
    ++		git rm remove-me &&
    ++		git commit -m "remove" &&
    ++		touch reintroduce remove-me &&
    ++		git add . &&
    ++		git commit -m "reintroduce" &&
    ++
    ++		git rm remove-me &&
    ++		git history fixup --empty=keep HEAD~2 &&
    ++
    ++		expect_changes <<-\EOF
    ++		reintroduce
    ++		0	0	reintroduce
    ++		0	0	remove-me
    ++		remove
    ++		base
    ++		0	0	base
    ++		EOF
    ++	)
    ++'
    ++
    ++test_expect_success '--empty=abort errors out when fixup target becomes empty' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		test_commit first &&
    ++		test_commit second &&
    ++
    ++		git rm first.t &&
    ++		test_must_fail git history fixup --empty=abort HEAD~ 2>err &&
    ++		test_grep "fixup makes commit.*empty" err
    ++	)
    ++'
    ++
    ++test_expect_success '--empty=abort errors out when a descendant becomes empty during replay' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo --initial-branch=main &&
    ++	(
    ++		cd repo &&
    ++
    ++		touch base remove-me &&
    ++		git add . &&
    ++		git commit -m "base" &&
    ++		git rm remove-me &&
    ++		git commit -m "remove" &&
    ++		touch reintroduce remove-me &&
    ++		git add . &&
    ++		git commit -m "reintroduce" &&
    ++
    ++		git rm remove-me &&
    ++		test_must_fail git history fixup --empty=abort HEAD~2 2>err &&
    ++		test_grep "became empty after replay" err
    ++	)
    ++'
    ++
     +test_done

---
base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
change-id: 20260422-b4-pks-history-fixup-be27e0c4a03e

