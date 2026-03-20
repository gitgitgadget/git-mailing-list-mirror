Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03653A9D95
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007305; cv=none; b=etCUXm1TsbVHeVarhwDqiTsqHqjuT8OLr30sX8oANzuNtgPJ/VM9JvoFtbOCilx2qaJZuKzkQRuIFj01kOybA8t5F+l5XHrVUvJvTaqiamzZv0v/tDQl2pJX3/BNrkPpBYllou71BsbSC98LShG3bKCeJFit5pAmj1rJZjgRLu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007305; c=relaxed/simple;
	bh=A6KXqwTt7jYmd7eYcRNdqQjqyQFI/deu46Jtmht5JUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ir4hCnSkDa6D0QblCiHd75JyUY8jFnsIi8vcak7VBNB1377xVnysMyZtGmzqeo6NeaYa9bk3iZCffNTTXMXZ/QKfoF6SjZEo/OU+G6HOXLh/AEqyVs1v9T3mD2d7e0ggmGLIkBUmsFgUlWkOGuKzWh+5K9buz9AczSvz79gczLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z9uO5V7h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CAqFQ/Ei; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z9uO5V7h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CAqFQ/Ei"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4CC98EC00E5
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:48:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 20 Mar 2026 07:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774007303;
	 x=1774093703; bh=ZHCeOLyyyrrAmxvN3p+Kygc7svE5mam3kLtSS+nEaO4=; b=
	Z9uO5V7hHzBogLwveDW3j+czLr1pPQnicnvvyR3wp5jYFBL+gM1J7x9Xej9HrJJV
	MW2BcGMbgLLfQ04iip+he8uUFXWjf2IEy8dJ+lU9JL603Zx5y42hd8UHq9Y9Rqts
	D3uwo67UWPFNMVqzsb1UTJlBhpS5xHCMNvtqjvGPRYyUKBPuPmsmAg0HlHVXifzq
	LxakrvyXAwk2/LcU4ay6GK/BmJeuSc3iiVbtdUScimMqDIB7192ne2nF8yhcBTQH
	rGOwc4mYBoO3h3CnGrZTKQgXCFtngnh3qtd2Jt++kojCEHIYw+gDU4xl4HKZu8+M
	RzxF9P3ZesWzh2B8InOOug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774007303; x=
	1774093703; bh=ZHCeOLyyyrrAmxvN3p+Kygc7svE5mam3kLtSS+nEaO4=; b=C
	AqFQ/EiDgqJWnut15Xe/T+cKQiyXRU3/kYh7HSFZplqY0GsoZE5BRy1GZBXHzpYP
	9LMA5CNQIiPmAj1JltfFSsi093XZP/KFOp2CZ0kSYeGTwwZ2ySQqsIgVWaGxdenV
	oTdXfACueiAt+Kas4HgkVVGSz5hQrX/u9o1n+nSAZmTQRTGOx1C61JhoQusYKN4W
	xvkZC1t4I4WH9icFDHt8hh9mg90wv9MGBf5vjlYVpYDVS4KDT5BG/QOfsKPVKPSk
	NTgTLMcb2nfGbrGmAN+ELQYbjuJqI32cpJOep4R7657anBKFBiGa8zfrGpPYamtG
	Cws7NTK/rBYdFSazTAdrA==
X-ME-Sender: <xms:BzS9aV7IebdV0eMK1JZ5uChmd2NF7o2c5t6C-nqOUDPJ1cJg-5bBPQ>
    <xme:BzS9aZ3YJmqJo89g403yXb5bDdTawRXFmct6EayOdnhVc5QXYGbARr2OCHwbrvP8c
    GFjcsErhko9vZTIvHSrXaawo5V7kIRgm8ouHFvKkiLO76io5bt_yw>
X-ME-Received: <xmr:BzS9aSG0BWwUKQU7tEpwPH0cWiJHVagCjkiCGX3nZnMl9ytdS6aNBgGZQpTkwZnRD-tETRHCxvxETvRNu1ud1-KZyNwGZpc2UBWWN1SevPwC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:BzS9aTTZJDNiqS934e_YKdmHey70svRdc8zjywauQv2Y1T6Df-03oA>
    <xmx:BzS9aZAo6tZgA1YCVjmWzy6-QI7qiCuZxHLHaEZAgV8jqqZe489YvA>
    <xmx:BzS9aT2Sj-gkNAU9_JwvS5CZ1guQ_a4xholIrZZtFFDMCNBX26VDbQ>
    <xmx:BzS9aXUbv8fcIq-6tuiKNkd84fCulhIaibmSEPS4V8fkBPFAYA8vKw>
    <xmx:BzS9aabdkZPwa0MuF0t_sO5gGgqcRnT4QwD81SRjFDtrCCTff3pcj3LQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Mar 2026 07:48:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3c09aa77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Mar 2026 11:48:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 12:47:19 +0100
Subject: [PATCH 14/14] builtin/fsck: stop using `the_repository` in error
 reporting
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-fsck-without-the-repository-v1-14-6594f997926b@pks.im>
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
In-Reply-To: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

In the preceding commit we have introduced the repository into `struct
fsck_object_report`. This allows us to drop remaining uses of the global
`the_repository` variable.

Drop them and remove `USE_THE_REPOSITORY_VARIABLE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index b15708d155..24d8ec6d42 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
@@ -66,13 +65,14 @@ static const char *describe_object(const struct object_id *oid)
 	return fsck_describe_object(&fsck_walk_options, oid);
 }
 
-static const char *printable_type(const struct object_id *oid,
+static const char *printable_type(struct repository *repo,
+				  const struct object_id *oid,
 				  enum object_type type)
 {
 	const char *ret;
 
 	if (type == OBJ_NONE)
-		type = odb_read_object_info(the_repository->objects,
+		type = odb_read_object_info(repo->objects,
 					    oid, NULL);
 
 	ret = type_name(type);
@@ -82,12 +82,12 @@ static const char *printable_type(const struct object_id *oid,
 	return ret;
 }
 
-static int objerror(struct object *obj, const char *err)
+static int objerror(struct repository *repo, struct object *obj, const char *err)
 {
 	errors_found |= ERROR_OBJECT;
 	/* TRANSLATORS: e.g. error in tree 01bfda: <more explanation> */
 	fprintf_ln(stderr, _("error in %s %s: %s"),
-		   printable_type(&obj->oid, obj->type),
+		   printable_type(repo, &obj->oid, obj->type),
 		   describe_object(&obj->oid), err);
 	return -1;
 }
@@ -106,13 +106,13 @@ static int fsck_objects_error_func(struct fsck_options *o UNUSED,
 	case FSCK_WARN:
 		/* TRANSLATORS: e.g. warning in tree 01bfda: <more explanation> */
 		fprintf_ln(stderr, _("warning in %s %s: %s"),
-			   printable_type(oid, object_type),
+			   printable_type(report->repo, oid, object_type),
 			   describe_object(oid), message);
 		return 0;
 	case FSCK_ERROR:
 		/* TRANSLATORS: e.g. error in tree 01bfda: <more explanation> */
 		fprintf_ln(stderr, _("error in %s %s: %s"),
-			   printable_type(oid, object_type),
+			   printable_type(report->repo, oid, object_type),
 			   describe_object(oid), message);
 		return 1;
 	default:
@@ -142,7 +142,7 @@ static int mark_object(struct object *obj, enum object_type type,
 	if (!obj) {
 		/* ... these references to parent->fld are safe here */
 		printf_ln(_("broken link from %7s %s"),
-			  printable_type(&parent->oid, parent->type),
+			  printable_type(data->repo, &parent->oid, parent->type),
 			  describe_object(&parent->oid));
 		printf_ln(_("broken link from %7s %s"),
 			  (type == OBJ_ANY ? _("unknown") : type_name(type)),
@@ -153,7 +153,7 @@ static int mark_object(struct object *obj, enum object_type type,
 
 	if (type != OBJ_ANY && obj->type != type)
 		/* ... and the reference to parent is safe here */
-		objerror(parent, _("wrong object type in link"));
+		objerror(data->repo, parent, _("wrong object type in link"));
 
 	if (obj->flags & REACHABLE)
 		return 0;
@@ -172,9 +172,9 @@ static int mark_object(struct object *obj, enum object_type type,
 					      HAS_OBJECT_RECHECK_PACKED)) {
 			printf_ln(_("broken link from %7s %s\n"
 				    "              to %7s %s"),
-				  printable_type(&parent->oid, parent->type),
+				  printable_type(data->repo, &parent->oid, parent->type),
 				  describe_object(&parent->oid),
-				  printable_type(&obj->oid, obj->type),
+				  printable_type(data->repo, &obj->oid, obj->type),
 				  describe_object(&obj->oid));
 			errors_found |= ERROR_REACHABLE;
 		}
@@ -281,7 +281,7 @@ static void check_reachable_object(struct repository *repo, struct object *obj)
 		if (has_object_pack(repo, &obj->oid))
 			return; /* it is in pack - forget about it */
 		printf_ln(_("missing %s %s"),
-			  printable_type(&obj->oid, obj->type),
+			  printable_type(repo, &obj->oid, obj->type),
 			  describe_object(&obj->oid));
 		errors_found |= ERROR_REACHABLE;
 		return;
@@ -308,7 +308,7 @@ static void check_unreachable_object(struct repository *repo, struct object *obj
 	 */
 	if (show_unreachable) {
 		printf_ln(_("unreachable %s %s"),
-			  printable_type(&obj->oid, obj->type),
+			  printable_type(repo, &obj->oid, obj->type),
 			  describe_object(&obj->oid));
 		return;
 	}
@@ -328,7 +328,7 @@ static void check_unreachable_object(struct repository *repo, struct object *obj
 	if (!(obj->flags & USED)) {
 		if (show_dangling)
 			printf_ln(_("dangling %s %s"),
-				  printable_type(&obj->oid, obj->type),
+				  printable_type(repo, &obj->oid, obj->type),
 				  describe_object(&obj->oid));
 		if (write_lost_and_found) {
 			char *filename = repo_git_path(repo, "lost-found/%s/%s",
@@ -426,11 +426,11 @@ static int fsck_obj(struct repository *repo,
 
 	if (verbose)
 		fprintf_ln(stderr, _("Checking %s %s"),
-			   printable_type(&obj->oid, obj->type),
+			   printable_type(repo, &obj->oid, obj->type),
 			   describe_object(&obj->oid));
 
 	if (fsck_walk(repo, obj, NULL, &fsck_obj_options))
-		objerror(obj, _("broken links"));
+		objerror(repo, obj, _("broken links"));
 	err = fsck_object(repo, obj, buffer, size, &fsck_obj_options);
 	if (err)
 		goto out;
@@ -448,7 +448,7 @@ static int fsck_obj(struct repository *repo,
 
 		if (show_tags && tag->tagged) {
 			printf_ln(_("tagged %s %s (%s) in %s"),
-				  printable_type(&tag->tagged->oid, tag->tagged->type),
+				  printable_type(repo, &tag->tagged->oid, tag->tagged->type),
 				  describe_object(&tag->tagged->oid),
 				  tag->tag,
 				  describe_object(&tag->object.oid));
@@ -845,7 +845,7 @@ static int fsck_cache_tree(struct repository *repo, struct cache_tree *it,
 		fsck_put_object_name(&fsck_walk_options, &it->oid, ":");
 		mark_object_reachable(repo, obj);
 		if (obj->type != OBJ_TREE)
-			err |= objerror(obj, _("non-tree in cache-tree"));
+			err |= objerror(repo, obj, _("non-tree in cache-tree"));
 	}
 	for (i = 0; i < it->subtree_nr; i++)
 		err |= fsck_cache_tree(repo, it->down[i]->cache_tree, index_path);

-- 
2.53.0.1055.ga2ffed1127.dirty

