Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC623B615
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056165; cv=none; b=k/skwyfBsb7bJyPxgxzqiw/sv9KnVX7Vj2kR3WOoCLUl5AIcImojDavBj0IY5QdR5h8En0lZv0DhwBCAIp84mLlWQjRg+3e3bJkCRZ2OOSZ1rCrn2IYmwTfIz0ZEKs0e3ZohCgfprKnPfIcWgqx+XUcgkHjLT2Tk949P8DH++Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056165; c=relaxed/simple;
	bh=tFQSXNyq+e2lBKUN5NkynGnBKS6WhBmClsOMCltW5s4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KwySqfE8O3il8wfm3PkRKxQ7twU5G1XcgwmV1k+VZFIS+xHX4arODkXKjnp4gA3GOo6DDzX9/X6RB7OY3X4K17I+sjZzbgVo3IpIfM7ykPlWO0cYIR+PYjF42IZvID18BFdUeQdRcVv7qnvOnbs73CpHmLM6mabwh4RXJbc7CeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VadBVnsS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VPSbc6ay; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VadBVnsS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VPSbc6ay"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 05FD2EC0108;
	Tue, 21 Oct 2025 10:16:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 21 Oct 2025 10:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056163;
	 x=1761142563; bh=VHte5ZvTc+fPYkGnQzsmARvPHyQAFMmZ/5AuXHmKPQ0=; b=
	VadBVnsSjffX/6yN/BcpNFrQD+A8z39/2PcQFVKCMw9M2qshv8wsSmUg9g9j/SGI
	Xetyi7BsxNg9qoyzEPdi7t7XShF7hQNGSeQ1wxvxhzwi25ThRM7lXaTKW7q+by5W
	775SN+UJd+aosbIAqQqVWih/An8i492dftsqnRlvM+VBCvCM69y20rwE/S6T7uLZ
	89WocsSNSc4GlsmvYyAS8FFVP9993qVO1JZfvHohnUcsxbg8u4uDNXp6fs3eOdVd
	4q//sQAqVJ2GgfbskFibd5kFVpdU5vh1qrU03qGpygEbuwgseEBXIz+UKVAzB0TA
	FD9FqIxxSbhmwgiWv0AC0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056163; x=
	1761142563; bh=VHte5ZvTc+fPYkGnQzsmARvPHyQAFMmZ/5AuXHmKPQ0=; b=V
	PSbc6ayuazRTmZKpdxZq9yORUbVW7Dynhnm/NX+IqRr6Ue2PAIhTJvMd/rdNT4T/
	AOYA0Q8QtlbbpXVaQeSechoa+ajU6TiRbApc7JoUg5rkPbcAhJO+ki5BOvn9ITGS
	goJQQkzBqshOOi5TCpclneRz+zBITKl8G7GuJwU4H49K5a8+K0cChCPSa+aMfWmW
	8VdSG/t1LCmbMlrfbkw+p4KXmfiNHQMLURAw1Fws4k3uFvcbAKTWg0YStLpd/9H/
	9BQjiwa94yDIjEX+kKbBdVWdd0nYnqIfge03WMAFDecfokjhdJrQlxRPSThUbiOP
	9+Qv67I499WXcBpLHY04Q==
X-ME-Sender: <xms:opX3aIH-v-7T_7MzsBj5_oIVygOcSay5r78xRrtDDRDpUxSgbZfrtQ>
    <xme:opX3aD4jB9bACcJwQMxG-fDjmrH1oddMrnGw4gTagWZkrWKIU6626l9fYlLbjXIpo
    M0O7Z11m76J9fpQT5Bz8Y38lAoj0OKpKbBOOTub8kJ3eo8I1kp7>
X-ME-Received: <xmr:opX3aFyK-VIr9RnHE0Ix6VnSrP5g1WwcWJEwu3th-pvDyCSS_Zxl78gExvNQfYg-WcUfoMpfNWXkLlXg-qIKWfO04nvN-pIVe4VwRi38mvOxIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgv
    vgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhorhhgrghn
    ohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:opX3aKNG6-jFKduvK_DKd02ftvMJrKhEiz4QkVzTNcuiZdp4TRJ3pA>
    <xmx:opX3aDm1Z4c0UF249fAQTGg_aTriWonO9pfprJZsuWYmJfPTJe45Zg>
    <xmx:opX3aHQVJ2Tg-ZzPOrIJF0zo5YpkeFfldpF8JwPjnm1W722UOOQiNA>
    <xmx:opX3aKVW4enzciP-R6f-sE6a30ad4ZQBaIBJBk8HybIjrlWMt2PgGg>
    <xmx:opX3aPx4MKA_L-fQXu_anZNm4O4UtsSFkwBmBolayjnzKfb4w6tK-YwE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:16:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 75284256 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:16:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Oct 2025 16:15:50 +0200
Subject: [PATCH v5 02/12] replay: extract logic to pick commits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-b4-pks-history-builtin-v5-2-78d23f578fe6@pks.im>
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
index 1919d35bf3f..01c171b4f03 100644
--- a/Makefile
+++ b/Makefile
@@ -1261,6 +1261,7 @@ LIB_OBJS += reftable/tree.o
 LIB_OBJS += reftable/writer.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace-object.o
+LIB_OBJS += replay.o
 LIB_OBJS += repo-settings.o
 LIB_OBJS += repository.o
 LIB_OBJS += rerere.o
diff --git a/builtin/replay.c b/builtin/replay.c
index d0f04927908..aeb7cc88fe5 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -2,7 +2,6 @@
  * "git replay" builtin command
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -16,18 +15,12 @@
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
@@ -40,59 +33,6 @@ static struct commit *peel_committish(struct repository *repo, const char *name)
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
@@ -241,50 +181,6 @@ static void determine_replay_mode(struct repository *repo,
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
 static int handle_ref_update(const char *mode,
 			     struct ref_transaction *transaction,
 			     const char *refname,
@@ -472,8 +368,8 @@ int cmd_replay(int argc,
 		if (commit->parents->next)
 			die(_("replaying merge commits is not supported yet!"));
 
-		last_commit = pick_regular_commit(repo, commit, replayed_commits,
-						  onto, &merge_opt, &result);
+		last_commit = replay_pick_regular_commit(repo, commit, replayed_commits,
+							 onto, &merge_opt, &result);
 		if (!last_commit)
 			break;
 
diff --git a/meson.build b/meson.build
index cee94244759..ae8d4fef059 100644
--- a/meson.build
+++ b/meson.build
@@ -464,6 +464,7 @@ libgit_sources = [
   'reftable/writer.c',
   'remote.c',
   'replace-object.c',
+  'replay.c',
   'repo-settings.c',
   'repository.c',
   'rerere.c',
diff --git a/replay.c b/replay.c
new file mode 100644
index 00000000000..e22ce399406
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
index 00000000000..a461b5c2341
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
2.51.1.851.g4ebd6896fd.dirty

