Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4E83803FA
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298087; cv=none; b=mS79BcKke/lhagxGLG1PFfqwGrOPQ7SFcgEio+3QiGR1DXi+STWB+yYSarO7RNhI2V7bey87X/48UbB1mdnag7116Qx1BT7k+7z4whTsHJGr+J5hVYBdG8OwmvR90/YHTKg93xjV1vwzrvzvkEj2Id+bcX5PJeMXV4mxqYh+w8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298087; c=relaxed/simple;
	bh=st/nqUd8Wdu02FVpeCR2RbxQRCaLJLm9ytAzwXqRXO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k2wCqQb6hVnXgF0e1IiQJif/J6F2PIkoJKvg+fzTAZq1O+yHBExG7MIT2SSqFV7/IHhlIiXKHej2vfN6OGJX5phmUHRBh2KqQWxzj4TpUg7A0Cyq8StmtW/Ly2WhsdsCcOPrmZOTK0tG2iEn5VWLTNeq/gWCEnkTvO2A+MBY464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xa24dO0u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N4WrRSrY; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xa24dO0u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N4WrRSrY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D8A4EC011F;
	Tue, 13 Jan 2026 04:54:44 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Jan 2026 04:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768298084;
	 x=1768384484; bh=JHlRMB0npQDxsMbxU4wAxjlCGbRXrWvk77cVU8yjWsI=; b=
	Xa24dO0uz+MRH48QFCw8TE/7nja6l0wKHosfdIEMZXepARJo5DqWt0vyCLoWyVVH
	nU30V0eDTYWzq2Mp7ZQ/LDXZPUzwOmXW7HqC6px9NEGH+gfdj3fu9d5Z23S81YQE
	gs0474HdIGnOyobtGvLJqjyszBCRsren/OwMaPvuEf5+qm0HdjTTMv4Z0PNoAr5L
	LK9vtGCTgrGxGjqsFgD0MA9mV/AENd34ciMRrePJAyZ5ParFyMeCO7VFHGXxU356
	KD6CwPnm0W/wbhBBXUZ6DDyD9fZYWbkGzXVQmATJ+sy/7QOvXqrDKZDfpjZWwKLm
	qS6B/gJqqduOHP0Q0sexfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768298084; x=
	1768384484; bh=JHlRMB0npQDxsMbxU4wAxjlCGbRXrWvk77cVU8yjWsI=; b=N
	4WrRSrY2zdXKAZ4b17j1Tophk8SRuFhFefY7GaRH9zXNn8U5MnhL5jsZCdY1n/ot
	KhI5vz4DiTqSwj1SXAVRtRmjuVql92tNTp6XJbbpcrXMHwn1gW1ixgStA4Xy7iWM
	YS3ea0OMZxX6vnPSGe9SGjzyggzv/4CrqmKzjfBtNGN8RCHOrcr2tfsC/Dsh8aF4
	Cxv2VO0A+qGbFn6L2y70FqXDBrSIbCrgRJbmD+jttiUaOaJQRlL+nqbYh8wTKad8
	fjJOmmx9XDTjTCnQpt3uEzEYNyPflqq+sF/xj1bJsYbUf9uWMlphEeyjEc4V2MOr
	uV/aYOB/phXPXUwux3K0Q==
X-ME-Sender: <xms:ZBZmaWudFKfnevpr7-tFQPhpONJO4fQT4qqmnADixsJv6InTxa5XgA>
    <xme:ZBZmaf1hKloa0AESc5Jkc2zKUnTi2397Q2jlUM0J6H9X-OaYOnWOpVf54e678YkUB
    RRsf5D1depyYSow6aoblUX4f0Z7uYY08wDjJ10xtFgalgzH25GpTA>
X-ME-Received: <xmr:ZBZmafpD_2Xvh2H64qzHKVFvJatp746qzUFmeR6GL5Y34J8zESzhhUt9jczdO9ATA0AhOryeZXyuGdk6-mmBoBJ606_G948xBaPUXdJFYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddttddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrihhlsegsvg
    ihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:ZBZmafIjxYGtcMLcKdV3fWp3ZsXxhthBiyredvXI7izUpjNbhRndPg>
    <xmx:ZBZmabSLUom-GBKGrX7APpE1fbVI4vZ0RqJaUizh9Ie0vMaqQfYZgQ>
    <xmx:ZBZmaXNBMk2jp9H8VFv9gZrpjTyqFjzeyh19osTbfR8Ztm-wXtkOrA>
    <xmx:ZBZmaYWuoWcPdqD2jsfh8-Rgyotve74QdAXuYbDX5HUHpbdodFVoZg>
    <xmx:ZBZmaejz6aX2CDxgiMn2f_-qulvIOmI7Zcc7jljrrPE2fTF4YvAOBtn9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 04:54:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 16372c94 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 09:54:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 13 Jan 2026 10:54:33 +0100
Subject: [PATCH v11 2/8] builtin/replay: move core logic into "libgit.a"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-b4-pks-history-builtin-v11-2-e74ebfa2652d@pks.im>
References: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
In-Reply-To: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
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
 builtin/replay.c | 366 +------------------------------------------------------
 meson.build      |   1 +
 replay.c         | 354 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 replay.h         |  61 ++++++++++
 5 files changed, 418 insertions(+), 365 deletions(-)

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
index daf907668c..2cdde830a8 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -2,386 +2,22 @@
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
-	if (!onto_name == !*advance_name)
-		BUG("one and only one of onto_name and *advance_name must be given");
-
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
-struct replay_revisions_options {
-	const char *advance;
-	const char *onto;
-	int contained;
-};
-
-struct replay_result {
-	struct replay_ref_update {
-		char *refname;
-		struct object_id old_oid;
-		struct object_id new_oid;
-	} *updates;
-	size_t updates_nr, updates_alloc;
-};
-
-static void replay_result_release(struct replay_result *result)
-{
-	for (size_t i = 0; i < result->updates_nr; i++)
-		free(result->updates[i].refname);
-	free(result->updates);
-}
-
-static void replay_result_queue_update(struct replay_result *result,
-				       const char *refname,
-				       const struct object_id *old_oid,
-				       const struct object_id *new_oid)
-{
-	ALLOC_GROW(result->updates, result->updates_nr + 1, result->updates_alloc);
-	result->updates[result->updates_nr].refname = xstrdup(refname);
-	result->updates[result->updates_nr].old_oid = *old_oid;
-	result->updates[result->updates_nr].new_oid = *new_oid;
-	result->updates_nr++;
-}
-
-static int replay_revisions(struct rev_info *revs,
-			    struct replay_revisions_options *opts,
-			    struct replay_result *out)
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
-	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto, &advance,
-			   &onto, &update_refs);
-
-	/* FIXME: Should allow replaying commits with the first as a root commit */
-
-	if (prepare_revision_walk(revs) < 0) {
-		ret = error(_("error preparing revisions"));
-		goto out;
-	}
-
-	init_basic_merge_options(&merge_opt, revs->repo);
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
-		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
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
-				replay_result_queue_update(out, decoration->name,
-							   &commit->object.oid,
-							   &last_commit->object.oid);
-			}
-			decoration = decoration->next;
-		}
-	}
-
-	if (!result.clean) {
-		ret = 1;
-		goto out;
-	}
-
-	/* In --advance mode, advance the target ref */
-	if (advance)
-		replay_result_queue_update(out, advance,
-					   &onto->object.oid,
-					   &last_commit->object.oid);
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
 static enum ref_action_mode parse_ref_action_mode(const char *ref_action, const char *source)
 {
 	if (!ref_action || !strcmp(ref_action, "update"))
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
index 0000000000..c580a9caa2
--- /dev/null
+++ b/replay.c
@@ -0,0 +1,354 @@
+#define USE_THE_REPOSITORY_VARIABLE
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
+#include "git-compat-util.h"
+#include "environment.h"
+#include "hex.h"
+#include "merge-ort.h"
+#include "object-name.h"
+#include "refs.h"
+#include "replay.h"
+#include "revision.h"
+#include "strmap.h"
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
+	if (!onto_name == !*advance_name)
+		BUG("one and only one of onto_name and *advance_name must be given");
+
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
+void replay_result_release(struct replay_result *result)
+{
+	for (size_t i = 0; i < result->updates_nr; i++)
+		free(result->updates[i].refname);
+	free(result->updates);
+}
+
+static void replay_result_queue_update(struct replay_result *result,
+				       const char *refname,
+				       const struct object_id *old_oid,
+				       const struct object_id *new_oid)
+{
+	ALLOC_GROW(result->updates, result->updates_nr + 1, result->updates_alloc);
+	result->updates[result->updates_nr].refname = xstrdup(refname);
+	result->updates[result->updates_nr].old_oid = *old_oid;
+	result->updates[result->updates_nr].new_oid = *new_oid;
+	result->updates_nr++;
+}
+
+int replay_revisions(struct rev_info *revs,
+		     struct replay_revisions_options *opts,
+		     struct replay_result *out)
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
+	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto, &advance,
+			   &onto, &update_refs);
+
+	/* FIXME: Should allow replaying commits with the first as a root commit */
+
+	if (prepare_revision_walk(revs) < 0) {
+		ret = error(_("error preparing revisions"));
+		goto out;
+	}
+
+	init_basic_merge_options(&merge_opt, revs->repo);
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
+		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
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
+				replay_result_queue_update(out, decoration->name,
+							   &commit->object.oid,
+							   &last_commit->object.oid);
+			}
+			decoration = decoration->next;
+		}
+	}
+
+	if (!result.clean) {
+		ret = 1;
+		goto out;
+	}
+
+	/* In --advance mode, advance the target ref */
+	if (advance)
+		replay_result_queue_update(out, advance,
+					   &onto->object.oid,
+					   &last_commit->object.oid);
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
index 0000000000..d8407dc7f7
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
+struct replay_result {
+	/*
+	 * The set of reference updates that are caused by replaying the
+	 * commits.
+	 */
+	struct replay_ref_update {
+		char *refname;
+		struct object_id old_oid;
+		struct object_id new_oid;
+	} *updates;
+	size_t updates_nr, updates_alloc;
+};
+
+void replay_result_release(struct replay_result *result);
+
+/*
+ * Replay a set of commits onto a new location. Leaves both the working tree,
+ * index and references untouched. Reference updates caused by the replay will
+ * be recorded in the `updates` out pointer.
+ *
+ * Returns 0 on success, 1 on conflict and a negative error code otherwise.
+ */
+int replay_revisions(struct rev_info *revs,
+		     struct replay_revisions_options *opts,
+		     struct replay_result *out);
+
+#endif

-- 
2.52.0.590.g1f87b77810.dirty

