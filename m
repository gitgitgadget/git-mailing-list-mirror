Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CCD2517AF
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278222; cv=none; b=ryKcr/B1rECFigLzZWyImnetLlW2ljcd/29oEqXrrtSNzkn+v2oUFnJ+mohdYpJCSuU21n3ggXx+GFx+ICVvpjS8/VSbYCSVrMf5Ap7b5aya4SVEcRJSp13EfgzrlkuDQMDTGMOrAI+fwWiasOxuDTsBBirZJ/JssYGLD0g3xDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278222; c=relaxed/simple;
	bh=8k5q81kHmcsc5CCpw9si8j2VmAfE/CCYcvXNaPFjFTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hI4HOtTnLfCaD6qdIT2KjI3MwFst6hnmrka/wIGO6vy2QnElBC21UKTiLkEcn5GXPPW5TkhrFjTdcPe8UQ0NiXadhgTopZ7I4c6sffRi0cd14Nhkt5cccHZSLCmGVGuwpeXQw0MoGDJNtzNDmmB9ZzAz4wl5Zmr4jgEw9uRLNc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IkqNzZEV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3K398zKI; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IkqNzZEV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3K398zKI"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D7C741D00199;
	Mon, 23 Mar 2026 11:03:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 23 Mar 2026 11:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774278220;
	 x=1774364620; bh=Sz+BW9wnz04mPkwf21LN5ZxvgxXEoffmrAqxwiRRvZk=; b=
	IkqNzZEVfE1xcggrMfRwMnwIVZPQmygXKs86fFchcEjtzH0yXNp7+TykZd9i5f/z
	62dkxKvp8FgA+U79LCAjV3YzTMjr/NTLqpw1YqPEOuzchGf08SFAMZGk0db2a8uP
	PWgzXUfvJSijxh5o1RXOcl/+IF48+1gndbnHMH9JpY3R5BbCobuJ4eL/pHwr/KPc
	ev/m31C5noZve3YD+CaR4HSujpaJ57WjKwIp0yJ1d6JQAPWFPU9dyALNEIY/8LzZ
	pjKPU018ocNOqRCKcI2lqpv7+oR2JlPi0RyD/m5dKPjmEtauxi57spiR8/qvY6A1
	NSNI0oQBNftBgHcBSm9Psw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774278220; x=
	1774364620; bh=Sz+BW9wnz04mPkwf21LN5ZxvgxXEoffmrAqxwiRRvZk=; b=3
	K398zKIeTttlmi1Sl05LdFi8LXB5R8/WIScT8pCv19z5dAlvRG9C34lj23/Y7XtQ
	mkmbZMqWzqbd+h2ApD0mupjNU3f5ZZ9FhgwxgauU5gDNwAp8/FSGswvYbzZTvkeQ
	Kdr5L/WV5+l1mUd0VTHDlsGjwHHc9N0VVJvSygxcIGG+qw/bOGJrolK8ByefY2RP
	UJ8ZQO4RyvLtSm9seuhTGssMcZPhEeKG8hpKuyHnADY6DSqHdefEkAJVxJMIS24P
	qPJ/mH2ycYopZUasIuLzhJrolXjfm9uVrElXoUsxSaHi4phegO2yXyAE1p06l2hC
	inSznIic9OsmxBpanl6AQ==
X-ME-Sender: <xms:TFbBaWDtokLQQJ5hgXD80aiPVsJRVHdJggaqvWA3JMlRjSb9htQX-g>
    <xme:TFbBaWjxtq07jXiGXqa3PpAOYQetUJeCCCYvLHJ2H4iQW9CX24mWEzBpdYfWIUHCq
    _eJ0E_xRDhWT_f0ReJOscbldWMTSI8BrE6d3-SAIBPZCiiQOG9iIg>
X-ME-Received: <xmr:TFbBaXMv8UMpw5cYWUfbiDKovZVTDX-CudHkaGx-HzlFulZcbExbES39VyH-zpCJn9dSDXpM3Ypr5LA8muoPkduPwMBByH1L2WXAXvNnhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TFbBaf7OMD4kJRMcck5t06NatBGmvGOq7rVefroYbd6gdmhhuNfSBA>
    <xmx:TFbBad3TrlRdlkc8rTX9FQgSS9MmRo3LGuDYjpYA_X9TkhCdPxE1TQ>
    <xmx:TFbBaYauHLSFeOEKUwqwbGsSB3Mtf5UEGZCoMB0mk0KLtUK5QdUVZg>
    <xmx:TFbBadBlH2hovDLZ2OecaM2lDsRm14aSJg0ZYhzurUx3No-oSUOpKg>
    <xmx:TFbBaZYr2nZlHtEsq5dTtgvHJKLkMSnvsCQAQmv7FKBUyamzfsJYPafm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 11:03:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ebd70c50 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Mar 2026 15:03:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Mar 2026 16:03:03 +0100
Subject: [PATCH v2 12/12] builtin/fsck: stop using `the_repository` in
 error reporting
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-pks-fsck-without-the-repository-v2-12-e8dc79bca651@pks.im>
References: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
In-Reply-To: <20260323-b4-pks-fsck-without-the-repository-v2-0-e8dc79bca651@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

In the preceding commit we have introduced the repository into `struct
fsck_object_report`. This allows us to drop remaining uses of the global
`the_repository` variable.

Drop them and remove `USE_THE_REPOSITORY_VARIABLE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index e37f708480..99696604b8 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
@@ -66,14 +65,14 @@ static const char *describe_object(const struct object_id *oid)
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
-					    oid, NULL);
+		type = odb_read_object_info(repo->objects, oid, NULL);
 
 	ret = type_name(type);
 	if (!ret)
@@ -82,17 +81,17 @@ static const char *printable_type(const struct object_id *oid,
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
 
-static int fsck_objects_error_func(struct fsck_options *o UNUSED,
+static int fsck_objects_error_func(struct fsck_options *o,
 				   void *fsck_report,
 				   enum fsck_msg_type msg_type,
 				   enum fsck_msg_id msg_id UNUSED,
@@ -106,13 +105,13 @@ static int fsck_objects_error_func(struct fsck_options *o UNUSED,
 	case FSCK_WARN:
 		/* TRANSLATORS: e.g. warning in tree 01bfda: <more explanation> */
 		fprintf_ln(stderr, _("warning in %s %s: %s"),
-			   printable_type(oid, object_type),
+			   printable_type(o->repo, oid, object_type),
 			   describe_object(oid), message);
 		return 0;
 	case FSCK_ERROR:
 		/* TRANSLATORS: e.g. error in tree 01bfda: <more explanation> */
 		fprintf_ln(stderr, _("error in %s %s: %s"),
-			   printable_type(oid, object_type),
+			   printable_type(o->repo, oid, object_type),
 			   describe_object(oid), message);
 		return 1;
 	default:
@@ -136,7 +135,7 @@ static int mark_object(struct object *obj, enum object_type type,
 	if (!obj) {
 		/* ... these references to parent->fld are safe here */
 		printf_ln(_("broken link from %7s %s"),
-			  printable_type(&parent->oid, parent->type),
+			  printable_type(options->repo, &parent->oid, parent->type),
 			  describe_object(&parent->oid));
 		printf_ln(_("broken link from %7s %s"),
 			  (type == OBJ_ANY ? _("unknown") : type_name(type)),
@@ -147,7 +146,7 @@ static int mark_object(struct object *obj, enum object_type type,
 
 	if (type != OBJ_ANY && obj->type != type)
 		/* ... and the reference to parent is safe here */
-		objerror(parent, _("wrong object type in link"));
+		objerror(options->repo, parent, _("wrong object type in link"));
 
 	if (obj->flags & REACHABLE)
 		return 0;
@@ -166,9 +165,9 @@ static int mark_object(struct object *obj, enum object_type type,
 					      HAS_OBJECT_RECHECK_PACKED)) {
 			printf_ln(_("broken link from %7s %s\n"
 				    "              to %7s %s"),
-				  printable_type(&parent->oid, parent->type),
+				  printable_type(options->repo, &parent->oid, parent->type),
 				  describe_object(&parent->oid),
-				  printable_type(&obj->oid, obj->type),
+				  printable_type(options->repo, &obj->oid, obj->type),
 				  describe_object(&obj->oid));
 			errors_found |= ERROR_REACHABLE;
 		}
@@ -269,7 +268,7 @@ static void check_reachable_object(struct repository *repo, struct object *obj)
 		if (has_object_pack(repo, &obj->oid))
 			return; /* it is in pack - forget about it */
 		printf_ln(_("missing %s %s"),
-			  printable_type(&obj->oid, obj->type),
+			  printable_type(repo, &obj->oid, obj->type),
 			  describe_object(&obj->oid));
 		errors_found |= ERROR_REACHABLE;
 		return;
@@ -296,7 +295,7 @@ static void check_unreachable_object(struct repository *repo, struct object *obj
 	 */
 	if (show_unreachable) {
 		printf_ln(_("unreachable %s %s"),
-			  printable_type(&obj->oid, obj->type),
+			  printable_type(repo, &obj->oid, obj->type),
 			  describe_object(&obj->oid));
 		return;
 	}
@@ -316,7 +315,7 @@ static void check_unreachable_object(struct repository *repo, struct object *obj
 	if (!(obj->flags & USED)) {
 		if (show_dangling)
 			printf_ln(_("dangling %s %s"),
-				  printable_type(&obj->oid, obj->type),
+				  printable_type(repo, &obj->oid, obj->type),
 				  describe_object(&obj->oid));
 		if (write_lost_and_found) {
 			char *filename = repo_git_path(repo, "lost-found/%s/%s",
@@ -402,7 +401,8 @@ static void check_connectivity(struct repository *repo)
 	}
 }
 
-static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
+static int fsck_obj(struct repository *repo,
+		    struct object *obj, void *buffer, unsigned long size)
 {
 	int err;
 
@@ -412,11 +412,11 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 
 	if (verbose)
 		fprintf_ln(stderr, _("Checking %s %s"),
-			   printable_type(&obj->oid, obj->type),
+			   printable_type(repo, &obj->oid, obj->type),
 			   describe_object(&obj->oid));
 
 	if (fsck_walk(obj, NULL, &fsck_obj_options))
-		objerror(obj, _("broken links"));
+		objerror(repo, obj, _("broken links"));
 	err = fsck_object(obj, buffer, size, &fsck_obj_options);
 	if (err)
 		goto out;
@@ -434,7 +434,7 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 
 		if (show_tags && tag->tagged) {
 			printf_ln(_("tagged %s %s (%s) in %s"),
-				  printable_type(&tag->tagged->oid, tag->tagged->type),
+				  printable_type(repo, &tag->tagged->oid, tag->tagged->type),
 				  describe_object(&tag->tagged->oid),
 				  tag->tag,
 				  describe_object(&tag->object.oid));
@@ -465,7 +465,7 @@ static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
 	}
 	obj->flags &= ~(REACHABLE | SEEN);
 	obj->flags |= HAS_OBJ;
-	return fsck_obj(obj, buffer, size);
+	return fsck_obj(repo, obj, buffer, size);
 }
 
 static int default_refs;
@@ -765,7 +765,7 @@ static int fsck_loose(const struct object_id *oid, const char *path,
 
 	obj->flags &= ~(REACHABLE | SEEN);
 	obj->flags |= HAS_OBJ;
-	if (fsck_obj(obj, contents, size))
+	if (fsck_obj(data->repo, obj, contents, size))
 		errors_found |= ERROR_OBJECT;
 
 	if (!eaten)
@@ -830,7 +830,7 @@ static int fsck_cache_tree(struct repository *repo, struct cache_tree *it, const
 		fsck_put_object_name(&fsck_walk_options, &it->oid, ":");
 		mark_object_reachable(obj);
 		if (obj->type != OBJ_TREE)
-			err |= objerror(obj, _("non-tree in cache-tree"));
+			err |= objerror(repo, obj, _("non-tree in cache-tree"));
 	}
 	for (i = 0; i < it->subtree_nr; i++)
 		err |= fsck_cache_tree(repo, it->down[i]->cache_tree, index_path);

-- 
2.53.0.1118.gaef5881109.dirty

