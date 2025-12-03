Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C5D2F1FF1
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758927; cv=none; b=VPCT9JgpnZLpXnVb3D2VjIyPlQ1XtSH/kXfsat8MTP8I96gmgcy5CNUFvJjcjuL9b7ETe0YfGbMur/DEV7BQ7ZXyULKAbh/U1Q/M1yXZm5i0mQTKOtFgSOdUBiQ5tYn9wgGvwB8yFsf3AMOqQUp9tinCe1mtoZR//f/lxCDC1FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758927; c=relaxed/simple;
	bh=NM+Nt2fBwKYA+WrUC/CwDgZbMD9VQ1w/Mj1jyR/ZIH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=quxqPGHNluePgzN6MCvPem9LW3k1hwPZBxqg75dlw55Kx7gcX0HwqGdMpp5/SAO23S9qklVJFBM/n4TiK9VU0snteAPaDSvupT+f0irQRXclwzb3hDR2WcL0ojY/Kt8J34N5+A5txM79EZStDLuQe9Ud3ZPb5C14m4JoAvQ1WnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iDaeEktL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FtQuim9V; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iDaeEktL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FtQuim9V"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 55C461400197;
	Wed,  3 Dec 2025 05:48:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 03 Dec 2025 05:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764758924;
	 x=1764845324; bh=foBuFNhB0PvSSiv+HOAmoiuHla7WQzzyXSZKkONxoDs=; b=
	iDaeEktL70XyCwmIhWUJtTLGpQWeneVjD61wnYYABKa/seN8GxxePnsHegVbB/Fp
	3YK/eHIvJCXNIPZCUvUnLKLZIczQRISuC7Ui96IQTknhAtPvEoBactk5kMjrorKU
	jXD+aSHLSys2XL3KamCzf+sYKiSnYRnLBb0rJcJ+iFDJgqtLcAagqligKF5dzn5E
	GNdud+mm34wXxz6okHhVdBG3TZm21QExcYu+eXtupQF2Qc0MABIh5kyFl01DxFmK
	3/OlV79N1cssO664r6/JmCq79XCXzoo1P/k+M21ZM2sZmvG9TjulcHV8aeYyvL/a
	633qTBM64gU/hdchYyibeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764758924; x=
	1764845324; bh=foBuFNhB0PvSSiv+HOAmoiuHla7WQzzyXSZKkONxoDs=; b=F
	tQuim9VR7YL2v1EM3HisZlTK1pEOivZalPdrTefuWATyNxI01fJmF76RL9iwGc4b
	U8gUSaOTmvZNGJkqwqfuB6+qUuHPXNl5aiP8iQUF28coKqjKYmWd0ljy5Hyl9m5F
	j/IPHSdyUEYMNmpVTWHF8heYCvcO0FF2QmqXsGgYf4mbEyfE0KFliJXZyNOrkgSj
	VrJABvaVoD9FSAd3xrgx9HboeHQlUd++/2B0UwvatekUyErPzAhvdulT7tAYtpt2
	UwJ2lBocjKvHjr+7ADUsNaqpHxg5QfAP9Pym51xilU9rk6cS/pkXDUi8TVxwoVHD
	sbN8wBdoIXGUsimOJCZVw==
X-ME-Sender: <xms:jBUwaatN6GprqaGyAQO4wT8j4WkmmJTpVbXocwb_GTZxVqwcOh6gjg>
    <xme:jBUwaSCUCFH3ukxe_PMoBEJyumehJXdvBta22YZRvj30lTibwM4eDSqQilIiMY6qY
    ILbAVLv5Z4pgTJ8riEmIaUty--zBlFOcBVONcRClqzt8kwttDx_3g>
X-ME-Received: <xmr:jBUwaZamWQoO6k6qlTfcprUHEbC9xAPn6GnsX2jXrHKQ4uo3-R_xEnBQWm3nvUghKP3n34vQ4tfki29vm2BB38-j8GirMv4d5hYbjl4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphht
    thhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinh
    hvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jBUwaVVnq6cWi2Bu4PAlM10xZ_HjfkeErbDjY9no7fzmYhXKbehZ4w>
    <xmx:jBUwaQONrdz69wGX998Gp0fWw-lYXcQR2aAkueLnu2mbilD7o7lr1Q>
    <xmx:jBUwaXZy-4ybn05Jyhlb0rEHbcnYKzsVvL7A_7ZaOp6Y1wzYuyBZqg>
    <xmx:jBUwaX-8tJEqvAV6Nr72-y6O4oXL3FhaR7qrelLA24Gfqr206vydUg>
    <xmx:jBUwaa7cBnhRTm5aOhBtgQ3adDN99fIJsD-ABrORp550jPlZqavkFGVk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 05:48:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8102877f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Dec 2025 10:48:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Dec 2025 11:48:29 +0100
Subject: [PATCH v7 02/12] replay: extract logic to pick commits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-b4-pks-history-builtin-v7-2-9e9f849bfd0e@pks.im>
References: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
In-Reply-To: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

We're about to add a new git-history(1) command that will reuse some of
the same infrastructure as git-replay(1). To prepare for this, extract
the logic to pick a commit into a new "replay.c" file so that it can be
shared between both commands.

Rename the function to have a "replay_" prefix to clearly indicate its
subsystem.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile         |   1 +
 builtin/replay.c | 110 ++--------------------------------------------------
 meson.build      |   1 +
 replay.c         | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 replay.h         |  23 +++++++++++
 5 files changed, 143 insertions(+), 107 deletions(-)

diff --git a/Makefile b/Makefile
index 237b56fc9d..809b094595 100644
--- a/Makefile
+++ b/Makefile
@@ -1274,6 +1274,7 @@ LIB_OBJS += repack-geometry.o
 LIB_OBJS += repack-midx.o
 LIB_OBJS += repack-promisor.o
 LIB_OBJS += replace-object.o
+LIB_OBJS += replay.o
 LIB_OBJS += repo-settings.o
 LIB_OBJS += repository.o
 LIB_OBJS += rerere.o
diff --git a/builtin/replay.c b/builtin/replay.c
index 1f9ffd2b3e..f974a8c963 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -2,7 +2,6 @@
  * "git replay" builtin command
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -16,6 +15,7 @@
 #include "object-name.h"
 #include "parse-options.h"
 #include "refs.h"
+#include "replay.h"
 #include "revision.h"
 #include "strmap.h"
 #include <oidset.h>
@@ -26,13 +26,6 @@ enum ref_action_mode {
 	REF_ACTION_PRINT,
 };
 
-static const char *short_commit_name(struct repository *repo,
-				     struct commit *commit)
-{
-	return repo_find_unique_abbrev(repo, &commit->object.oid,
-				       DEFAULT_ABBREV);
-}
-
 static struct commit *peel_committish(struct repository *repo, const char *name)
 {
 	struct object *obj;
@@ -45,59 +38,6 @@ static struct commit *peel_committish(struct repository *repo, const char *name)
 						  OBJ_COMMIT);
 }
 
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
 struct ref_info {
 	struct commit *onto;
 	struct strset positive_refs;
@@ -246,50 +186,6 @@ static void determine_replay_mode(struct repository *repo,
 	strset_clear(&rinfo.positive_refs);
 }
 
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
@@ -495,8 +391,8 @@ int cmd_replay(int argc,
 		if (commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
 
-		last_commit = pick_regular_commit(repo, commit, replayed_commits,
-						  onto, &merge_opt, &result);
+		last_commit = replay_pick_regular_commit(repo, commit, replayed_commits,
+							 onto, &merge_opt, &result);
 		if (!last_commit)
 			break;
 
diff --git a/meson.build b/meson.build
index f1b3615659..1878dff2b1 100644
--- a/meson.build
+++ b/meson.build
@@ -470,6 +470,7 @@ libgit_sources = [
   'repack-midx.c',
   'repack-promisor.c',
   'replace-object.c',
+  'replay.c',
   'repo-settings.c',
   'repository.c',
   'rerere.c',
diff --git a/replay.c b/replay.c
new file mode 100644
index 0000000000..fb906e9b51
--- /dev/null
+++ b/replay.c
@@ -0,0 +1,115 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "git-compat-util.h"
+#include "commit.h"
+#include "environment.h"
+#include "gettext.h"
+#include "ident.h"
+#include "object.h"
+#include "object-name.h"
+#include "replay.h"
+#include "tree.h"
+
+static const char *short_commit_name(struct repository *repo,
+				     struct commit *commit)
+{
+	return repo_find_unique_abbrev(repo, &commit->object.oid,
+				       DEFAULT_ABBREV);
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
+struct commit *replay_create_commit(struct repository *repo,
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
+struct commit *replay_pick_regular_commit(struct repository *repo,
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
+	return replay_create_commit(repo, result->tree, pickme, replayed_base);
+}
diff --git a/replay.h b/replay.h
new file mode 100644
index 0000000000..d6535ee56c
--- /dev/null
+++ b/replay.h
@@ -0,0 +1,23 @@
+#ifndef REPLAY_H
+#define REPLAY_H
+
+#include "khash.h"
+#include "merge-ort.h"
+#include "repository.h"
+
+struct commit;
+struct tree;
+
+struct commit *replay_create_commit(struct repository *repo,
+				    struct tree *tree,
+				    struct commit *based_on,
+				    struct commit *parent);
+
+struct commit *replay_pick_regular_commit(struct repository *repo,
+					  struct commit *pickme,
+					  kh_oid_map_t *replayed_commits,
+					  struct commit *onto,
+					  struct merge_options *merge_opt,
+					  struct merge_result *result);
+
+#endif

-- 
2.52.0.239.gd5f0c6e74e.dirty

