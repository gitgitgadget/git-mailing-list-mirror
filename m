Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D184330FC39
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780626; cv=none; b=T4XP9+67hXCO6gihTspJcYoPqzDAKZCkn022+ZYcdNca/GpSeaTnD+asPNEAVLwjCu5RjAfnSH3DyZZ4oRxpG7I6Sq98b+G5QpVIo+pXo/1viWSlG+VAhWDrMnFvPRyglqpaQD7tkarJTCtqCi5jMAd+zOAQjS0etfwP7yWnf4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780626; c=relaxed/simple;
	bh=/r1O/5AoTCIUmUjKj893eACjI1hKXYk/1wtfvSYskY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bc7x0HyH/pKbWNSsFTfQ+UxXkhsv7dYCBWMZDqgG0CZuoC/CFYXhm9xmTgkE7MtxecAa37alX/Zuz0X6Op9GH33kWO7/ppUxaj5ei46kXZKxlK1MlipM8WlHDiBe8TcEifX1lhMDzWaLwfpSDN3BdXGkzwysd45l/ZML4KgEpdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V+F5P/1Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cehsWSvj; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V+F5P/1Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cehsWSvj"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B2C81400170;
	Wed,  7 Jan 2026 05:10:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 07 Jan 2026 05:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767780622;
	 x=1767867022; bh=zTnMsleUkOT/SimYNU08ts8QidiFC26FspR2HpLlQrg=; b=
	V+F5P/1Y1DpeWoNMxmOFV6XSRrJHou6PYv/rbVGnDpidLxQCF4BGic+29EwsZa/0
	6ZXuqzhoa8NTB5tnQiJ5+ix0ti4SJYLKTxQYeMNKsqUl2d1VX/pVmHBxKtEtH+TO
	9dml3BpuS0pkWXqlVjxN2WoU0pvpoNZTomAYZSxTmKyzmIjVqVkW3kA21ZdOIQy/
	J5hOcZJPBc5pg1soe2NtmzstT+DK8WRbTTvKGbQkVRPfvebgOJjLRs6gOmyT0V29
	OqZQmc4uwM0slk0/dd44ZN+n4P0h7z0KCXoCDvhyU9YXpf4MsLI5Lzn4ii+iSjjg
	j+4bEnNIEhLtGk1fgnQICQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767780622; x=
	1767867022; bh=zTnMsleUkOT/SimYNU08ts8QidiFC26FspR2HpLlQrg=; b=c
	ehsWSvjeygMDjc0CgoZt8A2SQNSaKbro/49IbSVkuIK4WakTb4DQmCJU43/J8Lkh
	hloI91vCNZ0Yxu1/Iu6UyV4vIh6wsegy40ofIvaExunUevCZBGJTYKg6mpwlPIyZ
	EYN92LUsksMniXnEczs5UPDz0Osm43zfA2CrI/Fxkab6Md1ZdCljwR4/KCf7zrEA
	JCn41PuuuijxXYwDRsGGCzsdxBQcWBopmKXBjR8aie7EhKGLfg3P+5yyTlvQ/DOv
	fl+UaFdXm5I6WdOcGwaI367VA0220RiiMByxQomaS9r0TcmSDKmB+7KVZpMObzIJ
	xfuuzaPT3ZNJATgP7M8Pg==
X-ME-Sender: <xms:DTFeaZF1CX5FHK2LWFbd7k9kbn3U8OwL3YMd7MMWlmWKAam3C3sGHg>
    <xme:DTFeaaK_hAYYH6jYPr2Pfx6oIWpwAiTpLwKu-bSntEeEQ9Xp6AueVDz8wBHDp8Uwk
    sOunrGUJ34hMpfGzPTSizuILG4qgrkC5q25VwS8YEhk27d9S5zT2A>
X-ME-Received: <xmr:DTFeaWhdWvgmVKriiCQMpV8w0EJGYAkO40ry3rcIUv0Je0Mc4wk4vWiYrwZ5kyeJbemPLVw_CV_zhwJySVGe2iJ7uM66hevlE-UQzZ0DfLs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrd
    guvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtth
    hopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:DTFeaYly82y_p4fu-2wlvkJv3nBPX3WLGmNT_TowLWl-tEd2nZXOCA>
    <xmx:DTFeadVwZceCY5EjUs4azCxNoDQQmmh4IpPsHZxJRt99HuF142FOUg>
    <xmx:DTFeaVs66-6g2_rKHFOqkvt0T0J-91IqYUwh3wy243uOSnxXlFad5g>
    <xmx:DTFeaY6oEpCPNQwKhYDSIYsMOgwxmLErBFG_lXAa_Y3zAQGBt4mfZg>
    <xmx:DjFeacFP7aAH14QNdVWr3_SLhLKcnPnqMNo2Rms5CyOLgHmuR8OryReE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 05:10:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ebd0ce3a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 10:10:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 Jan 2026 11:10:10 +0100
Subject: [PATCH v8 2/7] builtin/replay: move core logic into "libgit.a"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-b4-pks-history-builtin-v8-2-18e9779e3a26@pks.im>
References: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
In-Reply-To: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Matthias Beyer <mail@beyermatthias.de>
X-Mailer: b4 0.14.3

Move the core logic used to replay commits into "libgit.a" so that it
can be easily reused by other commands. It will be used in a subsequent
commit where we're about to introduce a new git-history(1) command.

Note that with this change we have no sign-comparison warnings anymore,
and neither do we depend on `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile         |   1 +
 builtin/replay.c | 358 +------------------------------------------------------
 meson.build      |   1 +
 replay.c         | 347 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 replay.h         |  61 ++++++++++
 5 files changed, 411 insertions(+), 357 deletions(-)

diff --git a/Makefile b/Makefile
index b7eba509c6..1c64a5d2ae 100644
--- a/Makefile
+++ b/Makefile
@@ -1285,6 +1285,7 @@ LIB_OBJS += repack-geometry.o
 LIB_OBJS += repack-midx.o
 LIB_OBJS += repack-promisor.o
 LIB_OBJS += replace-object.o
+LIB_OBJS += replay.o
 LIB_OBJS += repo-settings.o
 LIB_OBJS += repository.o
 LIB_OBJS += rerere.o
diff --git a/builtin/replay.c b/builtin/replay.c
index d7523fdbc2..24f0b5f050 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -2,257 +2,22 @@
  * "git replay" builtin command
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 
 #include "builtin.h"
 #include "config.h"
-#include "environment.h"
 #include "hex.h"
-#include "lockfile.h"
-#include "merge-ort.h"
 #include "object-name.h"
 #include "parse-options.h"
 #include "refs.h"
+#include "replay.h"
 #include "revision.h"
-#include "strmap.h"
-#include <oidset.h>
-#include <tree.h>
 
 enum ref_action_mode {
 	REF_ACTION_UPDATE,
 	REF_ACTION_PRINT,
 };
 
-static const char *short_commit_name(struct repository *repo,
-				     struct commit *commit)
-{
-	return repo_find_unique_abbrev(repo, &commit->object.oid,
-				       DEFAULT_ABBREV);
-}
-
-static struct commit *peel_committish(struct repository *repo,
-				      const char *name,
-				      const char *mode)
-{
-	struct object *obj;
-	struct object_id oid;
-
-	if (repo_get_oid(repo, name, &oid))
-		die(_("'%s' is not a valid commit-ish for %s"), name, mode);
-	obj = parse_object_or_die(repo, &oid, name);
-	return (struct commit *)repo_peel_to_type(repo, name, 0, obj,
-						  OBJ_COMMIT);
-}
-
-static char *get_author(const char *message)
-{
-	size_t len;
-	const char *a;
-
-	a = find_commit_header(message, "author", &len);
-	if (a)
-		return xmemdupz(a, len);
-
-	return NULL;
-}
-
-static struct commit *create_commit(struct repository *repo,
-				    struct tree *tree,
-				    struct commit *based_on,
-				    struct commit *parent)
-{
-	struct object_id ret;
-	struct object *obj = NULL;
-	struct commit_list *parents = NULL;
-	char *author;
-	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
-	struct commit_extra_header *extra = NULL;
-	struct strbuf msg = STRBUF_INIT;
-	const char *out_enc = get_commit_output_encoding();
-	const char *message = repo_logmsg_reencode(repo, based_on,
-						   NULL, out_enc);
-	const char *orig_message = NULL;
-	const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
-
-	commit_list_insert(parent, &parents);
-	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
-	find_commit_subject(message, &orig_message);
-	strbuf_addstr(&msg, orig_message);
-	author = get_author(message);
-	reset_ident_date();
-	if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, parents,
-				 &ret, author, NULL, sign_commit, extra)) {
-		error(_("failed to write commit object"));
-		goto out;
-	}
-
-	obj = parse_object(repo, &ret);
-
-out:
-	repo_unuse_commit_buffer(the_repository, based_on, message);
-	free_commit_extra_headers(extra);
-	free_commit_list(parents);
-	strbuf_release(&msg);
-	free(author);
-	return (struct commit *)obj;
-}
-
-struct ref_info {
-	struct commit *onto;
-	struct strset positive_refs;
-	struct strset negative_refs;
-	int positive_refexprs;
-	int negative_refexprs;
-};
-
-static void get_ref_information(struct repository *repo,
-				struct rev_cmdline_info *cmd_info,
-				struct ref_info *ref_info)
-{
-	int i;
-
-	ref_info->onto = NULL;
-	strset_init(&ref_info->positive_refs);
-	strset_init(&ref_info->negative_refs);
-	ref_info->positive_refexprs = 0;
-	ref_info->negative_refexprs = 0;
-
-	/*
-	 * When the user specifies e.g.
-	 *   git replay origin/main..mybranch
-	 *   git replay ^origin/next mybranch1 mybranch2
-	 * we want to be able to determine where to replay the commits.  In
-	 * these examples, the branches are probably based on an old version
-	 * of either origin/main or origin/next, so we want to replay on the
-	 * newest version of that branch.  In contrast we would want to error
-	 * out if they ran
-	 *   git replay ^origin/master ^origin/next mybranch
-	 *   git replay mybranch~2..mybranch
-	 * the first of those because there's no unique base to choose, and
-	 * the second because they'd likely just be replaying commits on top
-	 * of the same commit and not making any difference.
-	 */
-	for (i = 0; i < cmd_info->nr; i++) {
-		struct rev_cmdline_entry *e = cmd_info->rev + i;
-		struct object_id oid;
-		const char *refexpr = e->name;
-		char *fullname = NULL;
-		int can_uniquely_dwim = 1;
-
-		if (*refexpr == '^')
-			refexpr++;
-		if (repo_dwim_ref(repo, refexpr, strlen(refexpr), &oid, &fullname, 0) != 1)
-			can_uniquely_dwim = 0;
-
-		if (e->flags & BOTTOM) {
-			if (can_uniquely_dwim)
-				strset_add(&ref_info->negative_refs, fullname);
-			if (!ref_info->negative_refexprs)
-				ref_info->onto = lookup_commit_reference_gently(repo,
-										&e->item->oid, 1);
-			ref_info->negative_refexprs++;
-		} else {
-			if (can_uniquely_dwim)
-				strset_add(&ref_info->positive_refs, fullname);
-			ref_info->positive_refexprs++;
-		}
-
-		free(fullname);
-	}
-}
-
-static void set_up_replay_mode(struct repository *repo,
-			       struct rev_cmdline_info *cmd_info,
-			       const char *onto_name,
-			       char **advance_name,
-			       struct commit **onto,
-			       struct strset **update_refs)
-{
-	struct ref_info rinfo;
-
-	get_ref_information(repo, cmd_info, &rinfo);
-	if (!rinfo.positive_refexprs)
-		die(_("need some commits to replay"));
-
-	die_for_incompatible_opt2(!!onto_name, "--onto",
-				  !!*advance_name, "--advance");
-	if (onto_name) {
-		*onto = peel_committish(repo, onto_name, "--onto");
-		if (rinfo.positive_refexprs <
-		    strset_get_size(&rinfo.positive_refs))
-			die(_("all positive revisions given must be references"));
-		*update_refs = xcalloc(1, sizeof(**update_refs));
-		**update_refs = rinfo.positive_refs;
-		memset(&rinfo.positive_refs, 0, sizeof(**update_refs));
-	} else {
-		struct object_id oid;
-		char *fullname = NULL;
-
-		if (!*advance_name)
-			BUG("expected either onto_name or *advance_name in this function");
-
-		if (repo_dwim_ref(repo, *advance_name, strlen(*advance_name),
-			     &oid, &fullname, 0) == 1) {
-			free(*advance_name);
-			*advance_name = fullname;
-		} else {
-			die(_("argument to --advance must be a reference"));
-		}
-		*onto = peel_committish(repo, *advance_name, "--advance");
-		if (rinfo.positive_refexprs > 1)
-			die(_("cannot advance target with multiple sources because ordering would be ill-defined"));
-	}
-	strset_clear(&rinfo.negative_refs);
-	strset_clear(&rinfo.positive_refs);
-}
-
-static struct commit *mapped_commit(kh_oid_map_t *replayed_commits,
-				    struct commit *commit,
-				    struct commit *fallback)
-{
-	khint_t pos = kh_get_oid_map(replayed_commits, commit->object.oid);
-	if (pos == kh_end(replayed_commits))
-		return fallback;
-	return kh_value(replayed_commits, pos);
-}
-
-static struct commit *pick_regular_commit(struct repository *repo,
-					  struct commit *pickme,
-					  kh_oid_map_t *replayed_commits,
-					  struct commit *onto,
-					  struct merge_options *merge_opt,
-					  struct merge_result *result)
-{
-	struct commit *base, *replayed_base;
-	struct tree *pickme_tree, *base_tree;
-
-	base = pickme->parents->item;
-	replayed_base = mapped_commit(replayed_commits, base, onto);
-
-	result->tree = repo_get_commit_tree(repo, replayed_base);
-	pickme_tree = repo_get_commit_tree(repo, pickme);
-	base_tree = repo_get_commit_tree(repo, base);
-
-	merge_opt->branch1 = short_commit_name(repo, replayed_base);
-	merge_opt->branch2 = short_commit_name(repo, pickme);
-	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
-
-	merge_incore_nonrecursive(merge_opt,
-				  base_tree,
-				  result->tree,
-				  pickme_tree,
-				  result);
-
-	free((char*)merge_opt->ancestor);
-	merge_opt->ancestor = NULL;
-	if (!result->clean)
-		return NULL;
-	return create_commit(repo, result->tree, pickme, replayed_base);
-}
-
 static enum ref_action_mode parse_ref_action_mode(const char *ref_action, const char *source)
 {
 	if (!ref_action || !strcmp(ref_action, "update"))
@@ -278,127 +43,6 @@ static enum ref_action_mode get_ref_action_mode(struct repository *repo, const c
 	return REF_ACTION_UPDATE;
 }
 
-struct replay_revisions_options {
-	const char *advance;
-	const char *onto;
-	int contained;
-};
-
-struct replay_ref_updates {
-	struct replay_ref_update {
-		char *refname;
-		struct object_id old_oid;
-		struct object_id new_oid;
-	} *items;
-	size_t nr, alloc;
-};
-
-static void replay_ref_updates_release(struct replay_ref_updates *updates)
-{
-	for (size_t i = 0; i < updates->nr; i++)
-		free(updates->items[i].refname);
-	free(updates->items);
-}
-
-static int replay_revisions(struct repository *repo, struct rev_info *revs,
-			    struct replay_revisions_options *opts,
-			    struct replay_ref_updates *updates)
-{
-	kh_oid_map_t *replayed_commits = NULL;
-	struct strset *update_refs = NULL;
-	struct commit *last_commit = NULL;
-	struct commit *commit;
-	struct commit *onto = NULL;
-	struct merge_options merge_opt;
-	struct merge_result result;
-	char *advance;
-	int ret;
-
-	advance = xstrdup_or_null(opts->advance);
-	set_up_replay_mode(repo, &revs->cmdline, opts->onto, &advance,
-			   &onto, &update_refs);
-
-	/* FIXME: Should allow replaying commits with the first as a root commit */
-
-	if (prepare_revision_walk(revs) < 0) {
-		ret = error(_("error preparing revisions"));
-		goto out;
-	}
-
-	init_basic_merge_options(&merge_opt, repo);
-	memset(&result, 0, sizeof(result));
-	merge_opt.show_rename_progress = 0;
-	last_commit = onto;
-	replayed_commits = kh_init_oid_map();
-	while ((commit = get_revision(revs))) {
-		const struct name_decoration *decoration;
-		khint_t pos;
-		int hr;
-
-		if (!commit->parents)
-			die(_("replaying down from root commit is not supported yet!"));
-		if (commit->parents->next)
-			die(_("replaying merge commits is not supported yet!"));
-
-		last_commit = pick_regular_commit(repo, commit, replayed_commits,
-						  onto, &merge_opt, &result);
-		if (!last_commit)
-			break;
-
-		/* Record commit -> last_commit mapping */
-		pos = kh_put_oid_map(replayed_commits, commit->object.oid, &hr);
-		if (hr == 0)
-			BUG("Duplicate rewritten commit: %s\n",
-			    oid_to_hex(&commit->object.oid));
-		kh_value(replayed_commits, pos) = last_commit;
-
-		/* Update any necessary branches */
-		if (advance)
-			continue;
-		decoration = get_name_decoration(&commit->object);
-		if (!decoration)
-			continue;
-		while (decoration) {
-			if (decoration->type == DECORATION_REF_LOCAL &&
-			    (opts->contained || strset_contains(update_refs,
-								decoration->name))) {
-				ALLOC_GROW(updates->items, updates->nr + 1, updates->alloc);
-				updates->items[updates->nr].refname = xstrdup(decoration->name);
-				updates->items[updates->nr].old_oid = commit->object.oid;
-				updates->items[updates->nr].new_oid = last_commit->object.oid;
-				updates->nr++;
-			}
-			decoration = decoration->next;
-		}
-	}
-
-	if (!result.clean) {
-		ret = -1;
-		goto out;
-	}
-
-	/* In --advance mode, advance the target ref */
-	if (advance) {
-		ALLOC_GROW(updates->items, updates->nr + 1, updates->alloc);
-		updates->items[updates->nr].refname = xstrdup(advance);
-		updates->items[updates->nr].old_oid = onto->object.oid;
-		updates->items[updates->nr].new_oid = last_commit->object.oid;
-		updates->nr++;
-	}
-
-	ret = 0;
-
-out:
-	if (update_refs) {
-		strset_clear(update_refs);
-		free(update_refs);
-	}
-	kh_destroy_oid_map(replayed_commits);
-	merge_finalize(&merge_opt, &result);
-	free(advance);
-	return ret;
-}
-
 static int handle_ref_update(enum ref_action_mode mode,
 			     struct ref_transaction *transaction,
 			     const char *refname,
diff --git a/meson.build b/meson.build
index dd52efd1c8..a5a4e99b25 100644
--- a/meson.build
+++ b/meson.build
@@ -471,6 +471,7 @@ libgit_sources = [
   'repack-midx.c',
   'repack-promisor.c',
   'replace-object.c',
+  'replay.c',
   'repo-settings.c',
   'repository.c',
   'rerere.c',
diff --git a/replay.c b/replay.c
new file mode 100644
index 0000000000..1926fca4b9
--- /dev/null
+++ b/replay.c
@@ -0,0 +1,347 @@
+#define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
+#include "git-compat-util.h"
+#include "environment.h"
+#include "hex.h"
+#include "merge-ort.h"
+#include "object-name.h"
+#include "oidset.h"
+#include "parse-options.h"
+#include "refs.h"
+#include "replay.h"
+#include "revision.h"
+#include "tree.h"
+
+static const char *short_commit_name(struct repository *repo,
+				     struct commit *commit)
+{
+	return repo_find_unique_abbrev(repo, &commit->object.oid,
+				       DEFAULT_ABBREV);
+}
+
+static struct commit *peel_committish(struct repository *repo,
+				      const char *name,
+				      const char *mode)
+{
+	struct object *obj;
+	struct object_id oid;
+
+	if (repo_get_oid(repo, name, &oid))
+		die(_("'%s' is not a valid commit-ish for %s"), name, mode);
+	obj = parse_object_or_die(repo, &oid, name);
+	return (struct commit *)repo_peel_to_type(repo, name, 0, obj,
+						  OBJ_COMMIT);
+}
+
+static char *get_author(const char *message)
+{
+	size_t len;
+	const char *a;
+
+	a = find_commit_header(message, "author", &len);
+	if (a)
+		return xmemdupz(a, len);
+
+	return NULL;
+}
+
+static struct commit *create_commit(struct repository *repo,
+				    struct tree *tree,
+				    struct commit *based_on,
+				    struct commit *parent)
+{
+	struct object_id ret;
+	struct object *obj = NULL;
+	struct commit_list *parents = NULL;
+	char *author;
+	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
+	struct commit_extra_header *extra = NULL;
+	struct strbuf msg = STRBUF_INIT;
+	const char *out_enc = get_commit_output_encoding();
+	const char *message = repo_logmsg_reencode(repo, based_on,
+						   NULL, out_enc);
+	const char *orig_message = NULL;
+	const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
+
+	commit_list_insert(parent, &parents);
+	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
+	find_commit_subject(message, &orig_message);
+	strbuf_addstr(&msg, orig_message);
+	author = get_author(message);
+	reset_ident_date();
+	if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, parents,
+				 &ret, author, NULL, sign_commit, extra)) {
+		error(_("failed to write commit object"));
+		goto out;
+	}
+
+	obj = parse_object(repo, &ret);
+
+out:
+	repo_unuse_commit_buffer(the_repository, based_on, message);
+	free_commit_extra_headers(extra);
+	free_commit_list(parents);
+	strbuf_release(&msg);
+	free(author);
+	return (struct commit *)obj;
+}
+
+struct ref_info {
+	struct commit *onto;
+	struct strset positive_refs;
+	struct strset negative_refs;
+	int positive_refexprs;
+	int negative_refexprs;
+};
+
+static void get_ref_information(struct repository *repo,
+				struct rev_cmdline_info *cmd_info,
+				struct ref_info *ref_info)
+{
+	int i;
+
+	ref_info->onto = NULL;
+	strset_init(&ref_info->positive_refs);
+	strset_init(&ref_info->negative_refs);
+	ref_info->positive_refexprs = 0;
+	ref_info->negative_refexprs = 0;
+
+	/*
+	 * When the user specifies e.g.
+	 *   git replay origin/main..mybranch
+	 *   git replay ^origin/next mybranch1 mybranch2
+	 * we want to be able to determine where to replay the commits.  In
+	 * these examples, the branches are probably based on an old version
+	 * of either origin/main or origin/next, so we want to replay on the
+	 * newest version of that branch.  In contrast we would want to error
+	 * out if they ran
+	 *   git replay ^origin/master ^origin/next mybranch
+	 *   git replay mybranch~2..mybranch
+	 * the first of those because there's no unique base to choose, and
+	 * the second because they'd likely just be replaying commits on top
+	 * of the same commit and not making any difference.
+	 */
+	for (i = 0; i < cmd_info->nr; i++) {
+		struct rev_cmdline_entry *e = cmd_info->rev + i;
+		struct object_id oid;
+		const char *refexpr = e->name;
+		char *fullname = NULL;
+		int can_uniquely_dwim = 1;
+
+		if (*refexpr == '^')
+			refexpr++;
+		if (repo_dwim_ref(repo, refexpr, strlen(refexpr), &oid, &fullname, 0) != 1)
+			can_uniquely_dwim = 0;
+
+		if (e->flags & BOTTOM) {
+			if (can_uniquely_dwim)
+				strset_add(&ref_info->negative_refs, fullname);
+			if (!ref_info->negative_refexprs)
+				ref_info->onto = lookup_commit_reference_gently(repo,
+										&e->item->oid, 1);
+			ref_info->negative_refexprs++;
+		} else {
+			if (can_uniquely_dwim)
+				strset_add(&ref_info->positive_refs, fullname);
+			ref_info->positive_refexprs++;
+		}
+
+		free(fullname);
+	}
+}
+
+static void set_up_replay_mode(struct repository *repo,
+			       struct rev_cmdline_info *cmd_info,
+			       const char *onto_name,
+			       char **advance_name,
+			       struct commit **onto,
+			       struct strset **update_refs)
+{
+	struct ref_info rinfo;
+
+	get_ref_information(repo, cmd_info, &rinfo);
+	if (!rinfo.positive_refexprs)
+		die(_("need some commits to replay"));
+
+	die_for_incompatible_opt2(!!onto_name, "--onto",
+				  !!*advance_name, "--advance");
+	if (onto_name) {
+		*onto = peel_committish(repo, onto_name, "--onto");
+		if (rinfo.positive_refexprs <
+		    strset_get_size(&rinfo.positive_refs))
+			die(_("all positive revisions given must be references"));
+		*update_refs = xcalloc(1, sizeof(**update_refs));
+		**update_refs = rinfo.positive_refs;
+		memset(&rinfo.positive_refs, 0, sizeof(**update_refs));
+	} else {
+		struct object_id oid;
+		char *fullname = NULL;
+
+		if (!*advance_name)
+			BUG("expected either onto_name or *advance_name in this function");
+
+		if (repo_dwim_ref(repo, *advance_name, strlen(*advance_name),
+			     &oid, &fullname, 0) == 1) {
+			free(*advance_name);
+			*advance_name = fullname;
+		} else {
+			die(_("argument to --advance must be a reference"));
+		}
+		*onto = peel_committish(repo, *advance_name, "--advance");
+		if (rinfo.positive_refexprs > 1)
+			die(_("cannot advance target with multiple sources because ordering would be ill-defined"));
+	}
+	strset_clear(&rinfo.negative_refs);
+	strset_clear(&rinfo.positive_refs);
+}
+
+static struct commit *mapped_commit(kh_oid_map_t *replayed_commits,
+				    struct commit *commit,
+				    struct commit *fallback)
+{
+	khint_t pos = kh_get_oid_map(replayed_commits, commit->object.oid);
+	if (pos == kh_end(replayed_commits))
+		return fallback;
+	return kh_value(replayed_commits, pos);
+}
+
+static struct commit *pick_regular_commit(struct repository *repo,
+					  struct commit *pickme,
+					  kh_oid_map_t *replayed_commits,
+					  struct commit *onto,
+					  struct merge_options *merge_opt,
+					  struct merge_result *result)
+{
+	struct commit *base, *replayed_base;
+	struct tree *pickme_tree, *base_tree;
+
+	base = pickme->parents->item;
+	replayed_base = mapped_commit(replayed_commits, base, onto);
+
+	result->tree = repo_get_commit_tree(repo, replayed_base);
+	pickme_tree = repo_get_commit_tree(repo, pickme);
+	base_tree = repo_get_commit_tree(repo, base);
+
+	merge_opt->branch1 = short_commit_name(repo, replayed_base);
+	merge_opt->branch2 = short_commit_name(repo, pickme);
+	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
+
+	merge_incore_nonrecursive(merge_opt,
+				  base_tree,
+				  result->tree,
+				  pickme_tree,
+				  result);
+
+	free((char*)merge_opt->ancestor);
+	merge_opt->ancestor = NULL;
+	if (!result->clean)
+		return NULL;
+	return create_commit(repo, result->tree, pickme, replayed_base);
+}
+
+void replay_ref_updates_release(struct replay_ref_updates *updates)
+{
+	for (size_t i = 0; i < updates->nr; i++)
+		free(updates->items[i].refname);
+	free(updates->items);
+}
+
+int replay_revisions(struct repository *repo, struct rev_info *revs,
+		     struct replay_revisions_options *opts,
+		     struct replay_ref_updates *updates)
+{
+	kh_oid_map_t *replayed_commits = NULL;
+	struct strset *update_refs = NULL;
+	struct commit *last_commit = NULL;
+	struct commit *commit;
+	struct commit *onto = NULL;
+	struct merge_options merge_opt;
+	struct merge_result result;
+	char *advance;
+	int ret;
+
+	advance = xstrdup_or_null(opts->advance);
+	set_up_replay_mode(repo, &revs->cmdline, opts->onto, &advance,
+			   &onto, &update_refs);
+
+	/* FIXME: Should allow replaying commits with the first as a root commit */
+
+	if (prepare_revision_walk(revs) < 0) {
+		ret = error(_("error preparing revisions"));
+		goto out;
+	}
+
+	init_basic_merge_options(&merge_opt, repo);
+	memset(&result, 0, sizeof(result));
+	merge_opt.show_rename_progress = 0;
+	last_commit = onto;
+	replayed_commits = kh_init_oid_map();
+	while ((commit = get_revision(revs))) {
+		const struct name_decoration *decoration;
+		khint_t pos;
+		int hr;
+
+		if (!commit->parents)
+			die(_("replaying down from root commit is not supported yet!"));
+		if (commit->parents->next)
+			die(_("replaying merge commits is not supported yet!"));
+
+		last_commit = pick_regular_commit(repo, commit, replayed_commits,
+						  onto, &merge_opt, &result);
+		if (!last_commit)
+			break;
+
+		/* Record commit -> last_commit mapping */
+		pos = kh_put_oid_map(replayed_commits, commit->object.oid, &hr);
+		if (hr == 0)
+			BUG("Duplicate rewritten commit: %s\n",
+			    oid_to_hex(&commit->object.oid));
+		kh_value(replayed_commits, pos) = last_commit;
+
+		/* Update any necessary branches */
+		if (advance)
+			continue;
+		decoration = get_name_decoration(&commit->object);
+		if (!decoration)
+			continue;
+		while (decoration) {
+			if (decoration->type == DECORATION_REF_LOCAL &&
+			    (opts->contained || strset_contains(update_refs,
+								decoration->name))) {
+				ALLOC_GROW(updates->items, updates->nr + 1, updates->alloc);
+				updates->items[updates->nr].refname = xstrdup(decoration->name);
+				updates->items[updates->nr].old_oid = commit->object.oid;
+				updates->items[updates->nr].new_oid = last_commit->object.oid;
+				updates->nr++;
+			}
+			decoration = decoration->next;
+		}
+	}
+
+	if (!result.clean) {
+		ret = -1;
+		goto out;
+	}
+
+	/* In --advance mode, advance the target ref */
+	if (advance) {
+		ALLOC_GROW(updates->items, updates->nr + 1, updates->alloc);
+		updates->items[updates->nr].refname = xstrdup(advance);
+		updates->items[updates->nr].old_oid = onto->object.oid;
+		updates->items[updates->nr].new_oid = last_commit->object.oid;
+		updates->nr++;
+	}
+
+	ret = 0;
+
+out:
+	if (update_refs) {
+		strset_clear(update_refs);
+		free(update_refs);
+	}
+	kh_destroy_oid_map(replayed_commits);
+	merge_finalize(&merge_opt, &result);
+	free(advance);
+	return ret;
+}
diff --git a/replay.h b/replay.h
new file mode 100644
index 0000000000..bc7a321a5e
--- /dev/null
+++ b/replay.h
@@ -0,0 +1,61 @@
+#ifndef REPLAY_H
+#define REPLAY_H
+
+#include "hash.h"
+
+struct repository;
+struct rev_info;
+
+/*
+ * A set of options that can be passed to `replay_revisions()`.
+ */
+struct replay_revisions_options {
+	/*
+	 * Starting point at which to create the new commits; must be a branch
+	 * name. The branch will be updated to point to the rewritten commits.
+	 * This option is mutually exclusive with `onto`.
+	 */
+	const char *advance;
+
+	/*
+	 * Starting point at which to create the new commits; must be a
+	 * committish. References pointing at decendants of `onto` will be
+	 * updated to point to the new commits.
+	 */
+	 const char *onto;
+
+	/*
+	 * Update branches that point at commits in the given revision range.
+	 * Requires `onto` to be set.
+	 */
+	int contained;
+};
+
+/* This struct is used as an out-parameter by `replay_revisions()`. */
+struct replay_ref_updates {
+	/*
+	 * The set of reference updates that are caused by replaying the
+	 * commits.
+	 */
+	struct replay_ref_update {
+		char *refname;
+		struct object_id old_oid;
+		struct object_id new_oid;
+	} *items;
+	size_t nr, alloc;
+};
+
+void replay_ref_updates_release(struct replay_ref_updates *updates);
+
+/*
+ * Replay a set of commits onto a new location. Leaves both the working tree,
+ * index and references untouched. Reference updates caused by the replay will
+ * be recorded in the `updates` out pointer.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+int replay_revisions(struct repository *repo, struct rev_info *revs,
+		     struct replay_revisions_options *opts,
+		     struct replay_ref_updates *updates);
+
+#endif

-- 
2.52.0.542.g9473a8513b.dirty

