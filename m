Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34932836B5
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334276; cv=none; b=CUvf3IUepNFL4sN4iC3MP+kFnuMIiqYAJE7zRvla05YCZVyLybTZ7zwapx6hLybP2XWER/s8io4RrFzOBDSby6ej//g+/jIjSJ849pAywP5be1cXbRvWq6tMQ9iMeSKal7nhycHeMJjoYwK59NUPTws7k8ngvvpxp1QwJfjN6Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334276; c=relaxed/simple;
	bh=qCXAQvurxqJtS2yjlZ6LwZlzdPTsZ/BDvVU015OMrqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cb0j5BvhplfJT73TRph91Qxcre17QTbQ9j0znn7xlF3kWXKfOK13m9ulKkNh/ROW80usBenGJ3Pit+coOvldEEwBCCNHdLmEYGBBpjKQiZC7+ZAcFQbZdzDDRyr3ex0bmBxx22cycRKBm2bz1kQSn4uKYs5D2VKfyCgZneuEKzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nK9XGOeJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qM2176qz; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nK9XGOeJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qM2176qz"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BA8B51D00308;
	Wed,  1 Oct 2025 11:57:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 01 Oct 2025 11:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759334272;
	 x=1759420672; bh=Z10lVTgO4rHzdHvZQwE0BbjCzxiSMrpDim63rBsA7QI=; b=
	nK9XGOeJLyMQCCh6+BlusFHUcVB69xiqCQNL84xZ3ZU7gbssMI84mlVZEDCysxvX
	pvpVHcFmPoYyDbtfpP4eIpG6qSWc/gDkS7BSbD2fzjZPZ1/FnDZYBj9FKHBPptVu
	1EovjFhc/3AvdYqxBcpAA+6fwoEXQP/9paQ4kNdyuK7v/WP6ceXaZwCEubmu7Mct
	zlzHQna2yH3351c1K1i6FlOKz2FbkERV5Ja/+i6mOTtHSrIvzrVf6pA/SsJRPcK1
	h2l1UEaGDFZ8+Ie2PDdGgh1HCums/iAeiyGOc0k0XUvfqCa9i9FWwIglNA5ASEAv
	OeJWcvewlglT99b2MptotA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759334272; x=
	1759420672; bh=Z10lVTgO4rHzdHvZQwE0BbjCzxiSMrpDim63rBsA7QI=; b=q
	M2176qzV7au5dydX4ATsUoSI7gL6LYkbjOJRj4CbJP299jm+k+c3/6B+0jk0E0bb
	dlBA2IMv3rhEVyKPs+rhCf0bJVTgXbQXIK3we3hOJmAzeWDVyGzHM4jNHC/94sYo
	/3R411qO7zwLVt+hUk/G4cLS78iohhFaOAoHWiyNMTngTEK1M7ZCqOuNuQbUnXX8
	uHzMfudiUXBT2Ch7DaRetvNCCqz5FdSv8orqaMibIBBq5ONt2YcRwgOiTuttqL1F
	CklLDk+xMaqrI3znIzE9cYEjEBA2nUGWOV5/g0xyuAM7HMN2Rz4KgAzfEfd3dWJY
	25S2UGrQDf+5tVo7km+3Q==
X-ME-Sender: <xms:gE_daDTc3ItqwkOc5L8AL8w3aLSr3LHWRmnRqEAfi7cv1jDVQSOQLQ>
    <xme:gE_daBs4XaYp2PKs9fau1LnoeR3UXNXlQJKsSXvomQ7G5VxMCQPPCwCmlZZB4IguZ
    ZIkaSCQlubgJOhRiA1pHWA8zmqQFfUcjjQD-iz98HTFVDuRWOxj>
X-ME-Received: <xmr:gE_daEdD5i2GzWrEtw6dDsuz-PlTmN-xQd-k5DpRDdzvy2OmwDK1PlhrsdaOSZRGvYhnkv3g7jO2io6uY3u4Mmxq1ABx-gA7ZcmOcGMm0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgt
    phhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinh
    hvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:gE_daLb9LivTG9Wty75QyH6wzF7WobvRuVv2SMA-9lWK2Gl1dE5-Ng>
    <xmx:gE_daGaIczMq4NIl42LHr_MFA4KStig1ika_rmLGzc7JHccybxBGQg>
    <xmx:gE_daAIIiGm7QiCaWXNQNQvx0rwO22LX1wKgCruYAW8psieJXlawmA>
    <xmx:gE_daCsVqXZUQr9NVg88IuZbjoxjLvNTDBdm3NG7qDJgPyE-tJC8rg>
    <xmx:gE_daJTSlCptvHTgt2XIRta16PTmmLI1xRgD7vpBavuSJytEJZGHwH6b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 11:57:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bbf2788f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 1 Oct 2025 15:57:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Oct 2025 17:57:28 +0200
Subject: [PATCH v4 02/12] replay: extract logic to pick commits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-b4-pks-history-builtin-v4-2-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.2

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
 replay.h         |  18 +++++++++
 5 files changed, 138 insertions(+), 107 deletions(-)

diff --git a/Makefile b/Makefile
index 4c95affadb..5960c80736 100644
--- a/Makefile
+++ b/Makefile
@@ -1137,6 +1137,7 @@ LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += refspec.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace-object.o
+LIB_OBJS += replay.o
 LIB_OBJS += repo-settings.o
 LIB_OBJS += repository.o
 LIB_OBJS += rerere.o
diff --git a/builtin/replay.c b/builtin/replay.c
index b6f9d53560..e9d6559b47 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -2,7 +2,6 @@
  * "git replay" builtin command
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -15,18 +14,12 @@
 #include "object-name.h"
 #include "parse-options.h"
 #include "refs.h"
+#include "replay.h"
 #include "revision.h"
 #include "strmap.h"
 #include <oidset.h>
 #include <tree.h>
 
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
@@ -39,59 +32,6 @@ static struct commit *peel_committish(struct repository *repo, const char *name)
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
-	const char *exclude_gpgsig[] = { "gpgsig", NULL };
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
@@ -240,50 +180,6 @@ static void determine_replay_mode(struct repository *repo,
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
 static int add_ref_to_transaction(struct ref_transaction *transaction,
 				  const char *refname,
 				  const struct object_id *new_oid,
@@ -459,8 +355,8 @@ int cmd_replay(int argc,
 		if (commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
 
-		last_commit = pick_regular_commit(repo, commit, replayed_commits,
-						  onto, &merge_opt, &result);
+		last_commit = replay_pick_regular_commit(repo, commit, replayed_commits,
+							 onto, &merge_opt, &result);
 		if (!last_commit)
 			break;
 
diff --git a/meson.build b/meson.build
index b3dfcc0497..c320bdba9f 100644
--- a/meson.build
+++ b/meson.build
@@ -463,6 +463,7 @@ libgit_sources = [
   'reftable/writer.c',
   'remote.c',
   'replace-object.c',
+  'replay.c',
   'repo-settings.c',
   'repository.c',
   'rerere.c',
diff --git a/replay.c b/replay.c
new file mode 100644
index 0000000000..e22ce39940
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
+	const char *exclude_gpgsig[] = { "gpgsig", NULL };
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
+	return create_commit(repo, result->tree, pickme, replayed_base);
+}
diff --git a/replay.h b/replay.h
new file mode 100644
index 0000000000..a461b5c234
--- /dev/null
+++ b/replay.h
@@ -0,0 +1,18 @@
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
+struct commit *replay_pick_regular_commit(struct repository *repo,
+					  struct commit *pickme,
+					  kh_oid_map_t *replayed_commits,
+					  struct commit *onto,
+					  struct merge_options *merge_opt,
+					  struct merge_result *result);
+
+#endif

-- 
2.51.0.700.g236ee7b076.dirty

