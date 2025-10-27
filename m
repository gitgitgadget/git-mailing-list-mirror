Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2F2F3C1A
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564850; cv=none; b=mt0Pb4XQUDnOj9w9eAKOEHtaeAcHZXe6MmHSxu9oPOpxwLn4UQfF09iHmxvKefvfgSaukf5MwSvyOZh4FrZDcoJ8eHoZTzyrmx02+gFRlrB3PYEDyll1N/VHDPhTZjIhZju3K+G2RKPsaqvh+hwVuOlTFGXE1CwzhmoklV1etEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564850; c=relaxed/simple;
	bh=h4ghItzWhQHTWBsO0yZWuL315r47yw0le5od1hUfVhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U0SqSpJf56cHmL+qZ287/vjom3lVDvErWI5GYwh+Aqtx4X37pZbo4tEYUgMW3jeM7w7ZCOzUT0Quln02v+5e9fFPGq9ffzkUfEZd3ycEzCOOZV57fOzC8sSbz1aq5DmRuhDZgmNuclTIlODmWaU/3jSuOT7oxdYsYqQX5BKQ+sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YyV74YDk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xN5zvs2B; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YyV74YDk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xN5zvs2B"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id EAE82EC0327;
	Mon, 27 Oct 2025 07:34:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 27 Oct 2025 07:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761564847;
	 x=1761651247; bh=vT+VmDUpxHr3d5brC2WzGx+vV8Ju2Xtf8nWDrtbNxiU=; b=
	YyV74YDkQ7miu/eEZi2isyt9Fu7fSmahiKustTziSrmL6G/FbjO5Yo0qjYoOgYAR
	xNmIYywYJ5onrJ0Tua5620lpwVZUYN6NOIP1WWmieHLqiw1/ZJXmqZI+BYuuzNuJ
	Uq/OzMM59YvJLZA8Ed/hoEDkSdo3nSHXq5n2JNuDMe4MpeXV0LvyLQln39DPDjUb
	ehnp+xKcxRB69nyKs4puIF0ZI1wQcahfkgqFq0zt/ogDTl8+9Xf2yr/ope0A013V
	NBIdlm20Ir4foBFwLDhapdnXY/InHN5+vLbULKpLLm8eJRfeTyIpJSQwS8mPDU7M
	KFipWx2sjTvGig+3RUoWzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761564847; x=
	1761651247; bh=vT+VmDUpxHr3d5brC2WzGx+vV8Ju2Xtf8nWDrtbNxiU=; b=x
	N5zvs2BRPKmBh4YxP2sUOsFHYrrllazQZVfGX6ZWLaB/W6k9VGetH1T/wJTrkMFn
	Rh4LJgaTOIv6yw2Ww4RyOA3TPEkEjOZwZ01aWJAqtPjFkX2+KcDskGl9RvUxWVPl
	dtyeWqTMfUuhii8CTafofrBk1GW+vd98kwu2v/loEdUu4zNB3yrmr0sdh2iaiooV
	WevbtLdrHeAP50kLEcLGv1JWQPcNdAo5JGGJxu/TP2/hb44TlhlFAG9UF5ogb/sd
	3R/CmXnoTbjP6QwOpOnzm4m8t8e4aynsn3MGT85QUbkvjw3ApMEV4/hHfxaMry/v
	mJAi67Nm94K3LiRKc5Bsg==
X-ME-Sender: <xms:r1j_aP4oKShDXts2gAnETcbvIwCwueLAJYii1wvWfnTifN-TZv_5Og>
    <xme:r1j_aHeINlXC39-4CzO39UotlI3MjSDnkmPpeNJeKI5Mr2_0opaO0WB3Rcotnb-Tg
    OVBjxKMRm1Sn6seRdXiZX28V6L2pbE2lSlmfSFpJn-q9v3tKHJdMA>
X-ME-Received: <xmr:r1j_aKHZpM07ClPt3ZzpwRPQnie_kg17kH5g4G-cMc1YDM_O9Xu3kUXCv7xXx4g30hSFWVDn7fP8krL5IPjRWJpPOcGeyjTUnW-qRRdzSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:r1j_aAQFsPavjTglweVA-4K9TiGviDuHYxaTGVsIpgMZTlPv21WqpQ>
    <xmx:r1j_aIbqo8YUzhldVDunBHXhgU7AW9MaZOk0qpmNqia6Y451MqZPbQ>
    <xmx:r1j_aD31qFFVG9OKfdLfA1AgLMSCs49VW-bTyEinmtD-FfgfS4hxzQ>
    <xmx:r1j_aDo1iFQkTuGTiezPYCLHhXMJlYm_mW1FHmbIWJ6h0k77uagsSA>
    <xmx:r1j_aN1EbbWGkCAGSPkIeaKBTGmmgRPmJqz0AEyhpntJSI3TqnenomtR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 07:34:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ec559aa4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 11:34:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Oct 2025 12:33:50 +0100
Subject: [PATCH v6 02/11] replay: extract logic to pick commits
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-b4-pks-history-builtin-v6-2-407dd3f57ad3@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
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
index bb0420dc992..e39824912cd 100644
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
 	REF_ACTION_PRINT
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
 static int handle_ref_update(enum ref_action_mode mode,
 			     struct ref_transaction *transaction,
 			     const char *refname,
@@ -483,8 +379,8 @@ int cmd_replay(int argc,
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
index 00000000000..98be33b8545
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
+	return replay_create_commit(repo, result->tree, pickme, replayed_base);
+}
diff --git a/replay.h b/replay.h
new file mode 100644
index 00000000000..d6535ee56c9
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
2.51.1.930.gacf6e81ea2.dirty

