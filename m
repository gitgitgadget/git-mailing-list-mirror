Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6183E23C4F2
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278202; cv=none; b=ZGGJzCyAGvqQSpqncP+SiK64AzuQOKswZcn5u0y8wRsUinwDSLTExJWVFe8FjejsFpbg5PvdIyJy37HqeGnuuvgB/DAfryYg4byc3TEjze+DANItKB7yWxpDPqa3k240U+Ldf4U355wjC2EuKEty3TjwSEQ1fkUisWb+h7Oj+Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278202; c=relaxed/simple;
	bh=oYlKD1lDRDVVSqjqESVmFo86lrsweOVTjBWWfvF0XJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aEBijQZt4p5vdpxBK2wkuabepfzQqw4GASEVf75ov7ml8nMAG3Sax7ygzrVWWVlPixTmhTCVK3wQxF/yXwvRGZj+BmovubYHCzhDB7QIDhwjkuHDrQdKKnnTqYteIw9YEgm6rESU2+V6T+B1aOajCA5/k0iAk5fud9rhTdouyNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QeV+SmCk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nwOQXi3n; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QeV+SmCk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nwOQXi3n"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD6197A0123;
	Mon, 23 Mar 2026 11:03:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 23 Mar 2026 11:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774278199;
	 x=1774364599; bh=isNQbxNlJwG+0moSxhYaczEivX8RENp9X3ECk9uuNds=; b=
	QeV+SmCkRRc36x5/XQGgr7+4k/v3r6fzx0Yhsoy+212RAuOgwTgr3DMF7Igno8Xe
	IOom/+XjxVV1JJxCj3QBq9RDbxX8Z4/lv1myaWJpJoy4WOM3N8hejnLkwETEdnT1
	jPZ/G+KMOlw4Su+bitOvh5s4L9ohslmoTrN5EoY3379pg1watmBjnMXn23EMWRdJ
	w3GtzdtaNDojGVUNiyMRhk46qcjV/c1KFfLP1+gOwltb3Nuq9Nw5VL7D1z/Phnu2
	vxsn0H5A5WWWkVtb7PxeEcdE7a1N0EDjFjgX8qDuwuy/7pHcky3dMLVMdDg5g4TL
	M+KzcFcAlas9QkoFpFQv+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774278199; x=
	1774364599; bh=isNQbxNlJwG+0moSxhYaczEivX8RENp9X3ECk9uuNds=; b=n
	wOQXi3niBn2T1P1lhwzjVKSoJq3LTvMw4v7pRbVegBViuoapUUN+n/KCJe1Iy9Qm
	DCVouMeVIk33VnzOD7cBHxTJoaJeUWn6eHUGILVAOmJi5Im4J7Hf75sGGgTAt+Xk
	zK2LUDnqkY6g9WqANeZDeBa//7FCrvHQy7FAW1lY3PFLEprs0LhFf6wwAosFRy4d
	9FwAH5z/Q0NnL+ylkLmaezlPMNoe2L5ZX4FJikvnA9GYOxL+MerSvYK6OUnXwXyP
	HRDdh5YHyYSQCbtkIMQaSV0CFccKo4Co0Q5YPbusH03z1wE3TJ5M6dVodU1yQbFG
	SNEwJWCsZuJTTYqYymugA==
X-ME-Sender: <xms:N1bBaSMzjVJd0wm4TjgJgtgtfVa00tBY7iwqc218cG9fvgFBh_bAGA>
    <xme:N1bBaW_X51gPxiS_g3be8p96WtFhOs2TnkLkWyLKNMVOvHXrmTSlQeEm45eSSo9XO
    r3o4OZi-azUWaDfCraKhOSMYqgZTieuWw7kdvk3jKfvfZo_20szNy8>
X-ME-Received: <xmr:N1bBaW5q4Tba5C0M85zkfP70dcdPcLRA7SHsQZRWQLc-QWW4enwwt2uJ5BayZT7df-q5IrY-4CXAegJzhrN5-wnC6o3jhOLvJFk-TEW9lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:N1bBad1t24zDgokYPHXNAj30rFU5sdhgtjujKPgPoammBUrYLkB-XQ>
    <xmx:N1bBadDSpPUbbLzEstnHvmn9TYXsT6sk0u_PrykmhL_8uowEKcnTfg>
    <xmx:N1bBaf2N7AEpuP9Y9-q4PSCgKIm0iuF2T8LMrMcoQRCqjbZS2WfLOA>
    <xmx:N1bBaXt1GoCcQ0TWObyYqAph9vyjIyUjbGtCSQJMCsLXfk2YHzs3vg>
    <xmx:N1bBadmO4TxGRJ3kukfp_dxu514OWnTUvqaqwN-fKyrbPzv9zgthG7Kj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:03:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc51b8d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Mar 2026 15:03:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Mar 2026 16:02:55 +0100
Subject: [PATCH v2 04/12] fsck: drop USE_THE_REPOSITORY
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-pks-fsck-without-the-repository-v2-4-e8dc79bca651@pks.im>
References: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
In-Reply-To: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Stop using `the_repository` in "fsck.c" in favor of the repository that
we've already got available via `struct fsck_options`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 fsck.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fsck.c b/fsck.c
index a05997703a..b72200c352 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "date.h"
 #include "dir.h"
@@ -207,7 +205,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 			if (equal == len)
 				die("skiplist requires a path");
 			oidset_parse_file(&options->skip_oids, buf + equal + 1,
-					  the_repository->hash_algo);
+					  options->repo->hash_algo);
 			buf += len + 1;
 			continue;
 		}
@@ -360,7 +358,7 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 	int res = 0;
 	const char *name;
 
-	if (repo_parse_tree(the_repository, tree))
+	if (repo_parse_tree(options->repo, tree))
 		return -1;
 
 	name = fsck_get_object_name(options, &tree->object.oid);
@@ -375,14 +373,14 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 			continue;
 
 		if (S_ISDIR(entry.mode)) {
-			obj = (struct object *)lookup_tree(the_repository, &entry.oid);
+			obj = (struct object *)lookup_tree(options->repo, &entry.oid);
 			if (name && obj)
 				fsck_put_object_name(options, &entry.oid, "%s%s/",
 						     name, entry.path);
 			result = options->walk(obj, OBJ_TREE, data, options);
 		}
 		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode)) {
-			obj = (struct object *)lookup_blob(the_repository, &entry.oid);
+			obj = (struct object *)lookup_blob(options->repo, &entry.oid);
 			if (name && obj)
 				fsck_put_object_name(options, &entry.oid, "%s%s",
 						     name, entry.path);
@@ -409,7 +407,7 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 	int result;
 	const char *name;
 
-	if (repo_parse_commit(the_repository, commit))
+	if (repo_parse_commit(options->repo, commit))
 		return -1;
 
 	name = fsck_get_object_name(options, &commit->object.oid);
@@ -417,7 +415,7 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 		fsck_put_object_name(options, get_commit_tree_oid(commit),
 				     "%s:", name);
 
-	result = options->walk((struct object *) repo_get_commit_tree(the_repository, commit),
+	result = options->walk((struct object *) repo_get_commit_tree(options->repo, commit),
 			       OBJ_TREE, data, options);
 	if (result < 0)
 		return result;
@@ -474,7 +472,7 @@ static int fsck_walk_tag(struct tag *tag, void *data, struct fsck_options *optio
 {
 	const char *name = fsck_get_object_name(options, &tag->object.oid);
 
-	if (parse_tag(the_repository, tag))
+	if (parse_tag(options->repo, tag))
 		return -1;
 	if (name)
 		fsck_put_object_name(options, &tag->tagged->oid, "%s", name);
@@ -487,7 +485,7 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options)
 		return -1;
 
 	if (obj->type == OBJ_NONE)
-		parse_object(the_repository, &obj->oid);
+		parse_object(options->repo, &obj->oid);
 
 	switch (obj->type) {
 	case OBJ_BLOB:
@@ -970,14 +968,14 @@ static int fsck_commit(const struct object_id *oid,
 
 	if (buffer >= buffer_end || !skip_prefix(buffer, "tree ", &buffer))
 		return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
-	if (parse_oid_hex(buffer, &tree_oid, &p) || *p != '\n') {
+	if (parse_oid_hex_algop(buffer, &tree_oid, &p, options->repo->hash_algo) || *p != '\n') {
 		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
 		if (err)
 			return err;
 	}
 	buffer = p + 1;
 	while (buffer < buffer_end && skip_prefix(buffer, "parent ", &buffer)) {
-		if (parse_oid_hex(buffer, &parent_oid, &p) || *p != '\n') {
+		if (parse_oid_hex_algop(buffer, &parent_oid, &p, options->repo->hash_algo) || *p != '\n') {
 			err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
 			if (err)
 				return err;
@@ -1044,7 +1042,7 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
 		goto done;
 	}
-	if (parse_oid_hex(buffer, tagged_oid, &p) || *p != '\n') {
+	if (parse_oid_hex_algop(buffer, tagged_oid, &p, options->repo->hash_algo) || *p != '\n') {
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
 		if (ret)
 			goto done;
@@ -1336,9 +1334,9 @@ static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 		if (oidset_contains(blobs_done, oid))
 			continue;
 
-		buf = odb_read_object(the_repository->objects, oid, &type, &size);
+		buf = odb_read_object(options->repo->objects, oid, &type, &size);
 		if (!buf) {
-			if (is_promisor_object(the_repository, oid))
+			if (is_promisor_object(options->repo, oid))
 				continue;
 			ret |= report(options,
 				      oid, OBJ_BLOB, msg_missing,

-- 
2.53.0.1118.gaef5881109.dirty

