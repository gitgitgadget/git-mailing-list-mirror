Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEE11DF963
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417869; cv=none; b=qk5RFAF/tPCEssfKFU4dgEPpwNTlGUvfYUhvWNKep9dVV6eA5s9SeVppsXb9TJTxlmMuJP4dbiqkJtoMPLWYLqVbM/KpaAwlK7m1iSVJ6Nt6DiyE6snplsVO0xS5PIQAGkj+VXnVJDRS23TyUnqiC+Ke4hgyRPMmA8Z/T1LFYdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417869; c=relaxed/simple;
	bh=lJDx0t4MwgoIJpKzKo0qwhgA4ltY5xSJ3pPVzWIqXEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TxI/TmWOHLIMyPH6Egb9N8GyYUGlyGOKpbUNNiblQNs6pCIDR7cqyaE7cMRGVp+IsC5Mkxh4A4Ez/2jUiadQTAx2g+m/qrgXCmnH/KdqUrDBMt52ZXzQUPl1lO+BXEumPyzlHRZiQGWNE4xfmoz+MTWhAtFwlmwiXM6tm/C71j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zuj7CRXT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0MEWWLJ/; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zuj7CRXT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0MEWWLJ/"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BDD161140256
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 17 Dec 2024 01:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734417866;
	 x=1734504266; bh=vEmd7T3N/LSyhlaOMHbx/WK9wpYva8DyCvfFmsiHSWE=; b=
	zuj7CRXTI5gLiSYer71+V1vhHkWKM2Tv3HQTZ275/RwL/69RQZwA7GqTvxDu/llf
	1SF6281URMYG3K2VyJq5/9YmQ9ea1S3e44Ag8addLYipq0pCJpY82tmzj2AUko7g
	1l7FmIsqt1/D73E4y97Vnohu8lEiEL336VygTZX2oY406Iwmag8tejzgN2zlATMQ
	9mYsE+a99Xe6Zl6a5Jp3pA03f2xy9MtHarRJom1j1V0dP4Xk1pT9STlsuOTXlvbM
	8APjmVJLaIQmKeOR7UcCxJcjDsFs472LU+1v4nxhTU6JAZIU/XK2hLrswvVMyeKb
	R+91kZLpc39aSRYyu+gw+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734417866; x=
	1734504266; bh=vEmd7T3N/LSyhlaOMHbx/WK9wpYva8DyCvfFmsiHSWE=; b=0
	MEWWLJ/jVak9lHa3tDMqrcWQvIKJnIQQnOGZZx4RAM2e1cqBKrPzazGoZV/CXyRg
	X0SjZZ3HChDRmhVXlLo2EbqzeI4DFV78Y81lyZPMXTQ9hEmEr8q9HSqOwWuAJf6j
	u/rCD1u79bZC6ppgDNlXCiCLBIBfNRS4QHZbgdK6Ojwfourv8VqeVrwZ8pg8Otu9
	DsrMoBJ+oEVCDc8RwDRicKYEuJ9z+YxWtwsvGjeKIZuGLqupHIu8tRDZZlSkz29F
	G8W1j9NloI57reyT8Tj5yc5Jo/Oz/FWKKt2atFPQiYYjEPgvliP80BQArn6+FOF/
	QrAx0y1XgDnoLkv3Qs6lQ==
X-ME-Sender: <xms:yh1hZytTePDuS7QAjnYLUI6M_dLNGLTUrE_p1nhyke_Jee23_SJTiA>
    <xme:yh1hZ3cnjruD6fAIRPFzSAw6JDnd9aRZUjY4bgTPsjcK45x-uohSd2RUQBg0Fp-mI
    Pm5yL1VYyUvWD4Z8A>
X-ME-Received: <xmr:yh1hZ9wPEB4PIyIig8jnzQb3uX7iWa7q99TnmSMP0N16NnpBuv9DEAVeW_wdcl8FqwviZg4qvkEwq23wQX_zaPcroDbkYmmLjgz95S1C71RSOOY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yh1hZ9PUyeasa0AT4DFJHp_l5fGAChpzLS0Qq7RM2KtjCB2ncVYArA>
    <xmx:yh1hZy_07AEONN8-Cfu_n85uq1H_RmZbU5TXZKoDDRQuNYupJh7v0Q>
    <xmx:yh1hZ1XOgBOFbGUqZWgyHXXKDWqMrO-_8pwpGUWXrnXi5rYtci5HMg>
    <xmx:yh1hZ7fJMWYEr-kiLN0VMvItwgns1CzC0yLAzpZ9dDN6lBDAI1zFfg>
    <xmx:yh1hZ4mHCQZD1Wt1RrSmhL3LqX-AbFxeD2ExQ3TnqksV-8kPHTVm33Jo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f7fe1c3e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Dec 2024 06:42:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Dec 2024 07:44:01 +0100
Subject: [PATCH 14/14] match-trees: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-pks-use-the-repository-conversion-v1-14-0dba48bcc239@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Stop using `the_repository` in the "match-trees" subsystem by passing
down the already-available repository parameters to internal functions
as required.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 match-trees.c | 50 +++++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index a1c8b91eaef8fa7c1714e6c2b4ec78ac365ae99d..ef14ceb594c72ada250013b2b4653cfaa822bf3b 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -8,6 +7,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "object-store-ll.h"
+#include "repository.h"
 
 static int score_missing(unsigned mode)
 {
@@ -54,14 +54,15 @@ static int score_matches(unsigned mode1, unsigned mode2)
 	return score;
 }
 
-static void *fill_tree_desc_strict(struct tree_desc *desc,
+static void *fill_tree_desc_strict(struct repository *r,
+				   struct tree_desc *desc,
 				   const struct object_id *hash)
 {
 	void *buffer;
 	enum object_type type;
 	unsigned long size;
 
-	buffer = repo_read_object_file(the_repository, hash, &type, &size);
+	buffer = repo_read_object_file(r, hash, &type, &size);
 	if (!buffer)
 		die("unable to read tree (%s)", oid_to_hex(hash));
 	if (type != OBJ_TREE)
@@ -80,12 +81,13 @@ static int base_name_entries_compare(const struct name_entry *a,
 /*
  * Inspect two trees, and give a score that tells how similar they are.
  */
-static int score_trees(const struct object_id *hash1, const struct object_id *hash2)
+static int score_trees(struct repository *r,
+		       const struct object_id *hash1, const struct object_id *hash2)
 {
 	struct tree_desc one;
 	struct tree_desc two;
-	void *one_buf = fill_tree_desc_strict(&one, hash1);
-	void *two_buf = fill_tree_desc_strict(&two, hash2);
+	void *one_buf = fill_tree_desc_strict(r, &one, hash1);
+	void *two_buf = fill_tree_desc_strict(r, &two, hash2);
 	int score = 0;
 
 	for (;;) {
@@ -133,7 +135,8 @@ static int score_trees(const struct object_id *hash1, const struct object_id *ha
 /*
  * Match one itself and its subtrees with two and pick the best match.
  */
-static void match_trees(const struct object_id *hash1,
+static void match_trees(struct repository *r,
+			const struct object_id *hash1,
 			const struct object_id *hash2,
 			int *best_score,
 			char **best_match,
@@ -141,7 +144,7 @@ static void match_trees(const struct object_id *hash1,
 			int recurse_limit)
 {
 	struct tree_desc one;
-	void *one_buf = fill_tree_desc_strict(&one, hash1);
+	void *one_buf = fill_tree_desc_strict(r, &one, hash1);
 
 	while (one.size) {
 		const char *path;
@@ -152,7 +155,7 @@ static void match_trees(const struct object_id *hash1,
 		elem = tree_entry_extract(&one, &path, &mode);
 		if (!S_ISDIR(mode))
 			goto next;
-		score = score_trees(elem, hash2);
+		score = score_trees(r, elem, hash2);
 		if (*best_score < score) {
 			free(*best_match);
 			*best_match = xstrfmt("%s%s", base, path);
@@ -160,7 +163,7 @@ static void match_trees(const struct object_id *hash1,
 		}
 		if (recurse_limit) {
 			char *newbase = xstrfmt("%s%s/", base, path);
-			match_trees(elem, hash2, best_score, best_match,
+			match_trees(r, elem, hash2, best_score, best_match,
 				    newbase, recurse_limit - 1);
 			free(newbase);
 		}
@@ -175,7 +178,8 @@ static void match_trees(const struct object_id *hash1,
  * A tree "oid1" has a subdirectory at "prefix".  Come up with a tree object by
  * replacing it with another tree "oid2".
  */
-static int splice_tree(const struct object_id *oid1, const char *prefix,
+static int splice_tree(struct repository *r,
+		       const struct object_id *oid1, const char *prefix,
 		       const struct object_id *oid2, struct object_id *result)
 {
 	char *subpath;
@@ -194,7 +198,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 	if (*subpath)
 		subpath++;
 
-	buf = repo_read_object_file(the_repository, oid1, &type, &sz);
+	buf = repo_read_object_file(r, oid1, &type, &sz);
 	if (!buf)
 		die("cannot read tree %s", oid_to_hex(oid1));
 	init_tree_desc(&desc, oid1, buf, sz);
@@ -232,15 +236,15 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 		    oid_to_hex(oid1));
 	if (*subpath) {
 		struct object_id tree_oid;
-		oidread(&tree_oid, rewrite_here, the_repository->hash_algo);
-		status = splice_tree(&tree_oid, subpath, oid2, &subtree);
+		oidread(&tree_oid, rewrite_here, r->hash_algo);
+		status = splice_tree(r, &tree_oid, subpath, oid2, &subtree);
 		if (status)
 			return status;
 		rewrite_with = &subtree;
 	} else {
 		rewrite_with = oid2;
 	}
-	hashcpy(rewrite_here, rewrite_with->hash, the_repository->hash_algo);
+	hashcpy(rewrite_here, rewrite_with->hash, r->hash_algo);
 	status = write_object_file(buf, sz, OBJ_TREE, result);
 	free(buf);
 	return status;
@@ -271,7 +275,7 @@ void shift_tree(struct repository *r,
 	if (!depth_limit)
 		depth_limit = 2;
 
-	add_score = del_score = score_trees(hash1, hash2);
+	add_score = del_score = score_trees(r, hash1, hash2);
 	add_prefix = xcalloc(1, 1);
 	del_prefix = xcalloc(1, 1);
 
@@ -279,13 +283,13 @@ void shift_tree(struct repository *r,
 	 * See if one's subtree resembles two; if so we need to prefix
 	 * two with a few fake trees to match the prefix.
 	 */
-	match_trees(hash1, hash2, &add_score, &add_prefix, "", depth_limit);
+	match_trees(r, hash1, hash2, &add_score, &add_prefix, "", depth_limit);
 
 	/*
 	 * See if two's subtree resembles one; if so we need to
 	 * pick only subtree of two.
 	 */
-	match_trees(hash2, hash1, &del_score, &del_prefix, "", depth_limit);
+	match_trees(r, hash2, hash1, &del_score, &del_prefix, "", depth_limit);
 
 	/* Assume we do not have to do any shifting */
 	oidcpy(shifted, hash2);
@@ -306,7 +310,7 @@ void shift_tree(struct repository *r,
 	if (!*add_prefix)
 		goto out;
 
-	splice_tree(hash1, add_prefix, hash2, shifted);
+	splice_tree(r, hash1, add_prefix, hash2, shifted);
 
 out:
 	free(add_prefix);
@@ -340,16 +344,16 @@ void shift_tree_by(struct repository *r,
 
 	if (candidate == 3) {
 		/* Both are plausible -- we need to evaluate the score */
-		int best_score = score_trees(hash1, hash2);
+		int best_score = score_trees(r, hash1, hash2);
 		int score;
 
 		candidate = 0;
-		score = score_trees(&sub1, hash2);
+		score = score_trees(r, &sub1, hash2);
 		if (score > best_score) {
 			candidate = 1;
 			best_score = score;
 		}
-		score = score_trees(&sub2, hash1);
+		score = score_trees(r, &sub2, hash1);
 		if (score > best_score)
 			candidate = 2;
 	}
@@ -365,7 +369,7 @@ void shift_tree_by(struct repository *r,
 		 * shift tree2 down by adding shift_prefix above it
 		 * to match tree1.
 		 */
-		splice_tree(hash1, shift_prefix, hash2, shifted);
+		splice_tree(r, hash1, shift_prefix, hash2, shifted);
 	else
 		/*
 		 * shift tree2 up by removing shift_prefix from it

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

