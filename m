Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E8A2E11BC
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203823; cv=none; b=CcTFmWFWsbWd+JQCaK7tRUtV4HTw4fxRlwXILy6xi1FJJhQqof3aQLy16OxvXcozRW4Ngy/joS9gemjoMA8dsbICG/JUGvlzTUqCZIOu3og/+8u7DpasF4xovx0670VdImxRBSr4NKxSPrl2FTxk+f80G541cE9iKlyqjMb25IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203823; c=relaxed/simple;
	bh=EpCOMU7chRW6bs/jF0Lj6UwfX8/0RuYqt1rRX8hEVP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OYFWmm0rI1zdJbyo9hhAcNHlJVd/AgdYOQ7fWR2VtB6fp/RPXi64NFfhaBbySvqU+7vWRUcvf9fHuoRDkEHEfM+70J8CaWTW7DyidKQKW4H+ytbbJ1c6sGCG09H3dFrZVpO+mkmOpO1te9YYdMXw7HAsyK4VM0HZJiUg/bclxIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SHXI6SE3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hGKxeXQA; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SHXI6SE3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hGKxeXQA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 384BEEC0129;
	Thu, 23 Oct 2025 03:17:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 23 Oct 2025 03:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761203821;
	 x=1761290221; bh=zvemT+wUdcD+f9kc4sSOYr1ViW8LshhYQB9OEBPuwHI=; b=
	SHXI6SE3T0OQDOgESn3IVGcux0BkZA3LCdX88Fd1n8Rz+iKPMTMgWBOtCx+mXBp7
	+fb3qEPPki30PtEYiR9wUYegqORIiTIDYl2W4uVZKwO+RZHJd3MN08COYM1+tVAS
	2wYlMiQmo5duJHPNT137Bpt8vxaUqest3tZpcdHdG6gUTCkfKGzPpV0Xwpke0orP
	GEGbTvd4ge/6FzYGJZgbOAJmDiKHbgF4vH78ViAfZ3z1GMvQ6PCS6tUT+KqPpv+C
	x1A0xlS4wanRsIXloZiY3mQ+bDWTgLkSSHBHbG3VZebj68B/8E6lTaDt0mPkdwK/
	8Mhx/rZ9sVOcCAB6TWnvxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761203821; x=
	1761290221; bh=zvemT+wUdcD+f9kc4sSOYr1ViW8LshhYQB9OEBPuwHI=; b=h
	GKxeXQA0/sUsLjJoLGKTHIi1RuUvcyDz+DOH+TIp98LLjqBdmKH+mXSULiL0Zf1n
	aBBKenYMV1t3HCMFPVzXsfRFkMWk4ev01eLgVDQbc/lk9EAeyqLrBk/0B4uj0yfT
	rE4wzzEua7BO31fby/AIFTePALMHR7uBLU/yOif2h8iU4BzgWyoun4IeJno5JnaF
	Zd1rRSTx3o0QsMtEwr0LcEp/2Ib6cx6oJC52VFlkCGQQcFtLZdW0H+Unyu0IJEhr
	0f2UJKcJr6iD8WOJ3wMr0Cjd5mU9AViMeBvQM1vu/fNiVTOnRmUqdGAuOmRRNXA1
	mqoaaCV2Gwul5rlNW/Ypg==
X-ME-Sender: <xms:bdb5aMkxbNofn6VN36AmgZRNKV4qyd_tE1v8DqVcYB-PolT15-bXOw>
    <xme:bdb5aEQj27ADQKNSm9VlEC5tBJw2mwuC4BA2EXhg7qq2vpZNAkZPSWQVE7YzVTSRt
    B2iNRuAkVc-q88m7O-wSTOaIC5Ltux4U53gSdDCujDeDrWKcu-xdQ>
X-ME-Received: <xmr:bdb5aLGLmo0XG3sBszprEtQH56uDnUqdOrJOxf1TB_n2ZJ2q3XR9a2CjwJJe-2MUTsd1QHrRWpcmhMuZrCwVmL97Aj8VKylV7qBjIi8FF4qcTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:bdb5aJFP8M-kFrCfYdBEb-CbsWCKNSXmnZqm2dIfWtZQHDoFYjVeaw>
    <xmx:bdb5aJRFqhdKzQ-fmF58pX1aYoAcIizR-XuD9m23ZI8RAB4ejhfq2A>
    <xmx:bdb5aKIOe5iDHLjGKcSqnSOtW67W1NJGMbzYvL2CUvec9jEfb1kcuA>
    <xmx:bdb5aEbLsHMRL-iODSwjHrMhhd0rKBVoIw3voFtdvX3kBkdamxDR4Q>
    <xmx:bdb5aMK4cNrKjEkanIwt7YPFOsXtG8O8YxWAZWKzbYpwrdiKemLZlnD4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:16:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e951839e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:16:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Oct 2025 09:16:23 +0200
Subject: [PATCH v4 14/14] ref-filter: parse objects on demand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-14-2be68ce82c9a@pks.im>
References: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
In-Reply-To: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

When formatting an arbitrary object we parse that object regardless of
whether or not we actually need any parsed data. In fact, many of the
atoms we have don't require any.

Refactor the code so that we parse the data on demand when we see an
atom that wants to access the objects. This leads to a small speedup,
for example in the Chromium repository with around 40000 refs:

    Benchmark 1: for-each-ref --format='%(raw)' (HEAD~)
      Time (mean ± σ):     388.7 ms ±   1.1 ms    [User: 322.2 ms, System: 65.0 ms]
      Range (min … max):   387.3 ms … 390.8 ms    10 runs

    Benchmark 2: for-each-ref --format='%(raw)' (HEAD)
      Time (mean ± σ):     344.7 ms ±   0.7 ms    [User: 287.8 ms, System: 55.1 ms]
      Range (min … max):   343.9 ms … 345.7 ms    10 runs

    Summary
      for-each-ref --format='%(raw)' (HEAD) ran
        1.13 ± 0.00 times faster than for-each-ref --format='%(raw)' (HEAD~)

With this change, we now spend ~90% of the time decompressing objects,
which is almost as good as it gets regarding git-for-each-ref(1)'s own
infrastructure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ref-filter.c | 142 ++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 106 insertions(+), 36 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index c54025d6b4c..7cfcd5c3554 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -91,6 +91,7 @@ static struct expand_data {
 	struct object_id delta_base_oid;
 	void *content;
 
+	struct object *maybe_object;
 	struct object_info info;
 } oi, oi_deref;
 
@@ -1475,11 +1476,29 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 	}
 }
 
+static struct object *get_or_parse_object(struct expand_data *data, const char *refname,
+					  struct strbuf *err, int *eaten)
+{
+	if (!data->maybe_object) {
+		data->maybe_object = parse_object_buffer(the_repository, &data->oid, data->type,
+							 data->size, data->content, eaten);
+		if (!data->maybe_object) {
+			strbuf_addf(err, _("parse_object_buffer failed on %s for %s"),
+				    oid_to_hex(&data->oid), refname);
+			return NULL;
+		}
+	}
+
+	return data->maybe_object;
+}
+
 /* See grab_values */
-static void grab_tag_values(struct atom_value *val, int deref, struct object *obj)
+static int grab_tag_values(struct atom_value *val, int deref,
+			   struct expand_data *data, const char *refname,
+			   struct strbuf *err, int *eaten)
 {
+	struct tag *tag = NULL;
 	int i;
-	struct tag *tag = (struct tag *) obj;
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i].name;
@@ -1487,6 +1506,14 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
+
+		if (!tag) {
+			tag = (struct tag *) get_or_parse_object(data, refname,
+								 err, eaten);
+			if (!tag)
+				return -1;
+		}
+
 		if (deref)
 			name++;
 		if (atom_type == ATOM_TAG)
@@ -1496,22 +1523,35 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 		else if (atom_type == ATOM_OBJECT && tag->tagged)
 			v->s = xstrdup(oid_to_hex(&tag->tagged->oid));
 	}
+
+	return 0;
 }
 
 /* See grab_values */
-static void grab_commit_values(struct atom_value *val, int deref, struct object *obj)
+static int grab_commit_values(struct atom_value *val, int deref,
+			      struct expand_data *data, const char *refname,
+			      struct strbuf *err, int *eaten)
 {
 	int i;
-	struct commit *commit = (struct commit *) obj;
+	struct commit *commit = NULL;
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i].name;
 		enum atom_type atom_type = used_atom[i].atom_type;
 		struct atom_value *v = &val[i];
+
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
 			name++;
+
+		if (!commit) {
+			commit = (struct commit *) get_or_parse_object(data, refname,
+								       err, eaten);
+			if (!commit)
+				return -1;
+		}
+
 		if (atom_type == ATOM_TREE &&
 		    grab_oid(name, "tree", get_commit_tree_oid(commit), v, &used_atom[i]))
 			continue;
@@ -1531,6 +1571,8 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 			v->s = strbuf_detach(&s, NULL);
 		}
 	}
+
+	return 0;
 }
 
 static const char *find_wholine(const char *who, int wholen, const char *buf)
@@ -1759,10 +1801,12 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 	}
 }
 
-static void grab_signature(struct atom_value *val, int deref, struct object *obj)
+static int grab_signature(struct atom_value *val, int deref,
+			  struct expand_data *data, const char *refname,
+			  struct strbuf *err, int *eaten)
 {
 	int i;
-	struct commit *commit = (struct commit *) obj;
+	struct commit *commit = NULL;
 	struct signature_check sigc = { 0 };
 	int signature_checked = 0;
 
@@ -1790,6 +1834,13 @@ static void grab_signature(struct atom_value *val, int deref, struct object *obj
 			continue;
 
 		if (!signature_checked) {
+			if (!commit) {
+				commit = (struct commit *) get_or_parse_object(data, refname,
+									       err, eaten);
+				if (!commit)
+					return -1;
+			}
+
 			check_commit_signature(commit, &sigc);
 			signature_checked = 1;
 		}
@@ -1843,6 +1894,8 @@ static void grab_signature(struct atom_value *val, int deref, struct object *obj
 
 	if (signature_checked)
 		signature_check_clear(&sigc);
+
+	return 0;
 }
 
 static void find_subpos(const char *buf,
@@ -1920,9 +1973,8 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 }
 
 static void grab_describe_values(struct atom_value *val, int deref,
-				 struct object *obj)
+				 struct expand_data *data)
 {
-	struct commit *commit = (struct commit *)obj;
 	int i;
 
 	for (i = 0; i < used_atom_cnt; i++) {
@@ -1944,7 +1996,7 @@ static void grab_describe_values(struct atom_value *val, int deref,
 		cmd.git_cmd = 1;
 		strvec_push(&cmd.args, "describe");
 		strvec_pushv(&cmd.args, atom->u.describe_args.v);
-		strvec_push(&cmd.args, oid_to_hex(&commit->object.oid));
+		strvec_push(&cmd.args, oid_to_hex(&data->oid));
 		if (pipe_command(&cmd, NULL, 0, &out, 0, &err, 0) < 0) {
 			error(_("failed to run 'describe'"));
 			v->s = xstrdup("");
@@ -2066,24 +2118,36 @@ static void fill_missing_values(struct atom_value *val)
  * pointed at by the ref itself; otherwise it is the object the
  * ref (which is a tag) refers to.
  */
-static void grab_values(struct atom_value *val, int deref, struct object *obj, struct expand_data *data)
+static int grab_values(struct atom_value *val, int deref, struct expand_data *data,
+		       const char *refname, struct strbuf *err, int *eaten)
 {
 	void *buf = data->content;
+	int ret;
 
-	switch (obj->type) {
+	switch (data->type) {
 	case OBJ_TAG:
-		grab_tag_values(val, deref, obj);
+		ret = grab_tag_values(val, deref, data, refname, err, eaten);
+		if (ret < 0)
+			goto out;
+
 		grab_sub_body_contents(val, deref, data);
 		grab_person("tagger", val, deref, buf);
-		grab_describe_values(val, deref, obj);
+		grab_describe_values(val, deref, data);
 		break;
 	case OBJ_COMMIT:
-		grab_commit_values(val, deref, obj);
+		ret = grab_commit_values(val, deref, data, refname, err, eaten);
+		if (ret < 0)
+			goto out;
+
 		grab_sub_body_contents(val, deref, data);
 		grab_person("author", val, deref, buf);
 		grab_person("committer", val, deref, buf);
-		grab_signature(val, deref, obj);
-		grab_describe_values(val, deref, obj);
+
+		ret = grab_signature(val, deref, data, refname, err, eaten);
+		if (ret < 0)
+			goto out;
+
+		grab_describe_values(val, deref, data);
 		break;
 	case OBJ_TREE:
 		/* grab_tree_values(val, deref, obj, buf, sz); */
@@ -2094,8 +2158,12 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
 		grab_sub_body_contents(val, deref, data);
 		break;
 	default:
-		die("Eh?  Object of type %d?", obj->type);
+		die("Eh?  Object of type %d?", data->type);
 	}
+
+	ret = 0;
+out:
+	return ret;
 }
 
 static inline char *copy_advance(char *dst, const char *src)
@@ -2292,38 +2360,41 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
 	return show_ref(&atom->u.refname, ref->refname);
 }
 
-static int get_object(struct ref_array_item *ref, int deref, struct object **obj,
+static int get_object(struct ref_array_item *ref, int deref,
 		      struct expand_data *oi, struct strbuf *err)
 {
-	/* parse_object_buffer() will set eaten to 0 if free() will be needed */
-	int eaten = 1;
+	/* parse_object_buffer() will set eaten to 1 if free() will be needed */
+	int eaten = 0;
+	int ret;
+
 	if (oi->info.contentp) {
 		/* We need to know that to use parse_object_buffer properly */
 		oi->info.sizep = &oi->size;
 		oi->info.typep = &oi->type;
 	}
+
 	if (odb_read_object_info_extended(the_repository->objects, &oi->oid, &oi->info,
-					  OBJECT_INFO_LOOKUP_REPLACE))
-		return strbuf_addf_ret(err, -1, _("missing object %s for %s"),
-				       oid_to_hex(&oi->oid), ref->refname);
+					  OBJECT_INFO_LOOKUP_REPLACE)) {
+		ret = strbuf_addf_ret(err, -1, _("missing object %s for %s"),
+				      oid_to_hex(&oi->oid), ref->refname);
+		goto out;
+	}
 	if (oi->info.disk_sizep && oi->disk_size < 0)
 		BUG("Object size is less than zero.");
 
 	if (oi->info.contentp) {
-		*obj = parse_object_buffer(the_repository, &oi->oid, oi->type, oi->size, oi->content, &eaten);
-		if (!*obj) {
-			if (!eaten)
-				free(oi->content);
-			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
-					       oid_to_hex(&oi->oid), ref->refname);
-		}
-		grab_values(ref->value, deref, *obj, oi);
+		ret = grab_values(ref->value, deref, oi, ref->refname, err, &eaten);
+		if (ret < 0)
+			goto out;
 	}
 
 	grab_common_values(ref->value, deref, oi);
+	ret = 0;
+
+out:
 	if (!eaten)
 		free(oi->content);
-	return 0;
+	return ret;
 }
 
 static void populate_worktree_map(struct hashmap *map, struct worktree **worktrees)
@@ -2376,7 +2447,6 @@ static char *get_worktree_path(const struct ref_array_item *ref)
  */
 static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 {
-	struct object *obj;
 	int i;
 	struct object_info empty = OBJECT_INFO_INIT;
 	int ahead_behind_atoms = 0;
@@ -2564,14 +2634,14 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 
 	oi.oid = ref->objectname;
-	if (get_object(ref, 0, &obj, &oi, err))
+	if (get_object(ref, 0, &oi, err))
 		return -1;
 
 	/*
 	 * If there is no atom that wants to know about tagged
 	 * object, we are done.
 	 */
-	if (!need_tagged || (obj->type != OBJ_TAG))
+	if (!need_tagged || (oi.type != OBJ_TAG))
 		return 0;
 
 	/*
@@ -2589,7 +2659,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		}
 	}
 
-	return get_object(ref, 1, &obj, &oi_deref, err);
+	return get_object(ref, 1, &oi_deref, err);
 }
 
 /*

-- 
2.51.1.930.gacf6e81ea2.dirty

