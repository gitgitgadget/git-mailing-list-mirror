Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178BC2EFD89
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 06:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115312; cv=none; b=UoWpJ6Z6g8lWXyJnjR211rwGOG5LYAEPszpWC450uxvmSF7NNyVKsLw3906P2PbZkpl4jjL49s1+ubcMShOGdNuhj1FCPO9ThV6yRBRk9hFadHAhKuPsT7SCU2Kb6cheq1fex1zzjZYtKpXTJcB8CHgnapm55KyHtLKJwt3jtUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115312; c=relaxed/simple;
	bh=YOF2SRmkfoXCZV64QWHg+laqprYa9g/At7nwRnLKG8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X0hNF7wnvVrjaRwgCRvtXehyZ9zDJtmCkpc5dl3nUJftq0Xia8conC4o7mDdYyqMHq3cwCrQlW1t1NL41TUCQAhAkeZLcTxeo6pvStFwLlkbHo44PXVDyPiusOuxx2zLjK4Y9ZKigw3UucTxZI8+LRp2MKlxtGROc9HZ1ONpfwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E21leucR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fcQQaC+A; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E21leucR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fcQQaC+A"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C1377A0083;
	Wed, 22 Oct 2025 02:41:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 22 Oct 2025 02:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761115309;
	 x=1761201709; bh=eQ6lyixCb1pb2nn4FNiEU0u1ZR0QziC6RYV7xrZwxOc=; b=
	E21leucRA6KkZZ5UrKq/EF+dDmC5BiqxrhSJLuPeoelT+qOKm7jVNzEjKQgT4VvG
	4qV6qNz8nE9IDE9P7/UdUi8u6sJIS+q36PiHsUvKvZnEx5DFCTVa9A9IVb14CWBu
	/rZUvcL/kXO0KiW0anCA7OJkfcUa1uMdeRynKXZMWYnonVyZdvCAe/6GpjCuO0aD
	CChste1BGvtgge0UW2g9dm/Y+vkJJjzOL2UZ3gHZ5UR9HGILR9C4xBtsv6oZvWOP
	k711/rM1mripVDf56T9PjNJ/pTbqkyZ7/ybJ0kWLgY9P77svOG6XojjXEwq4RF/l
	OOUYQOgTvCTY9sWYlLw1kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761115309; x=
	1761201709; bh=eQ6lyixCb1pb2nn4FNiEU0u1ZR0QziC6RYV7xrZwxOc=; b=f
	cQQaC+AVtdb/Y9NYyIgM4BpvNlgYQAqW//LkpDX2O3H/oq+aGha6bMxyqcoDAgk3
	W96aTjBOnud5+Ker7pSVi5Qt2DObmXSVMGsyALbU2RJ07b5ao6VlytRJAMF50dBx
	7D+Dyrco7awetjHKkhEhKD7VovnxbK6mM7CtbB2zIMm759Kd+5NDcWEd8621vdzM
	KDuTMWCrb3L4d1SbE/gvUlTlIwf2ZThs9wt1tAQ0faZNsQnV1cpT3fRQTTBL6i7K
	u1eZfM3I2qZbZkxi4migwJLSXgIQc/9rJnVcP/yBkZu6ssiKhlRjT9CXN3+wjr3w
	FnGcrCK86cUbcofjI2vyw==
X-ME-Sender: <xms:rXz4aDa7K7yCSimLLQMDOiRExZIW95sM8XgO6v-n0eSVRCOnotO2Gg>
    <xme:rXz4aGF7Csq1xEslKUsSfYc6XP1SfPcvkhpDrnKk1DgREgQBQpbtopjEP3jGPl99X
    6OdFUTSg72BfDp1ZvLNfeLAnkzLPERLJAGzz9HbQLxW4hHDOebP_Q>
X-ME-Received: <xmr:rXz4aPwIf5VQ1tHDuVi182nU6zs9nfRgBQSxrDG6xy9WsRvQ6JNBidJnpKsq7WmaZx1hqBDAOQAdTpumTZk_EO6PtQbrKRQdDUAG2mzAUK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:rXz4aAmrZn1ziDILhALrNXkts4pqgdscwTIXiuBoA3NtyPCY6GiQmg>
    <xmx:rXz4aAm4IoM9rjrOzWc6HOyE5tUGhAjqfIYsPaQfHwl_Yr3feuBRzw>
    <xmx:rXz4aKyQnAwvf6sDRWMw-ax8yh1KWa0fxotbQoCE4mruTdN6rVSM3g>
    <xmx:rXz4aNqXPJ0hot37IQBn3bqDTbOxFHkOql-CdfgmPHolJGi1kjVWig>
    <xmx:rXz4aAW_RWI2-O5wdPJzB4SRKQSxZQr49At40k4ciLJAyeBnJcq5qWwT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 02:41:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e314ac23 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 22 Oct 2025 06:41:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Oct 2025 08:41:14 +0200
Subject: [PATCH v3 14/14] ref-filter: parse objects on demand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-14-eb9f71985ef0@pks.im>
References: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
In-Reply-To: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
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
 ref-filter.c | 156 ++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 117 insertions(+), 39 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index c54025d6b4..ca58870aed 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -91,6 +91,7 @@ static struct expand_data {
 	struct object_id delta_base_oid;
 	void *content;
 
+	struct object *maybe_object;
 	struct object_info info;
 } oi, oi_deref;
 
@@ -1475,11 +1476,28 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 	}
 }
 
+static int get_or_parse_object(struct expand_data *data, const char *refname,
+			       struct object **object, struct strbuf *err, int *eaten)
+{
+	if (!data->maybe_object) {
+		data->maybe_object = parse_object_buffer(the_repository, &data->oid, data->type,
+							 data->size, data->content, eaten);
+		if (!data->maybe_object)
+			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
+					       oid_to_hex(&data->oid), refname);
+	}
+
+	*object = data->maybe_object;
+	return 0;
+}
+
 /* See grab_values */
-static void grab_tag_values(struct atom_value *val, int deref, struct object *obj)
+static int grab_tag_values(struct atom_value *val, int deref,
+			   struct expand_data *data, const char *refname,
+			   struct strbuf *err, int *eaten)
 {
-	int i;
-	struct tag *tag = (struct tag *) obj;
+	struct tag *tag = NULL;
+	int i, ret;
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		const char *name = used_atom[i].name;
@@ -1487,6 +1505,17 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
+
+		if (!tag) {
+			struct object *object;
+
+			ret = get_or_parse_object(data, refname, &object, err, eaten);
+			if (ret < 0)
+				return ret;
+
+			tag = (struct tag *) object;
+		}
+
 		if (deref)
 			name++;
 		if (atom_type == ATOM_TAG)
@@ -1496,22 +1525,38 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
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
-	int i;
-	struct commit *commit = (struct commit *) obj;
+	int i, ret;
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
+			struct object *object;
+
+			ret = get_or_parse_object(data, refname, &object, err, eaten);
+			if (ret < 0)
+				return ret;
+
+			commit = (struct commit *) object;
+		}
+
 		if (atom_type == ATOM_TREE &&
 		    grab_oid(name, "tree", get_commit_tree_oid(commit), v, &used_atom[i]))
 			continue;
@@ -1531,6 +1576,8 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 			v->s = strbuf_detach(&s, NULL);
 		}
 	}
+
+	return 0;
 }
 
 static const char *find_wholine(const char *who, int wholen, const char *buf)
@@ -1759,10 +1806,12 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 	}
 }
 
-static void grab_signature(struct atom_value *val, int deref, struct object *obj)
+static int grab_signature(struct atom_value *val, int deref,
+			  struct expand_data *data, const char *refname,
+			  struct strbuf *err, int *eaten)
 {
-	int i;
-	struct commit *commit = (struct commit *) obj;
+	int i, ret;
+	struct commit *commit = NULL;
 	struct signature_check sigc = { 0 };
 	int signature_checked = 0;
 
@@ -1790,6 +1839,16 @@ static void grab_signature(struct atom_value *val, int deref, struct object *obj
 			continue;
 
 		if (!signature_checked) {
+			if (!commit) {
+				struct object *object;
+
+				ret = get_or_parse_object(data, refname, &object, err, eaten);
+				if (ret < 0)
+					return ret;
+
+				commit = (struct commit *) object;
+			}
+
 			check_commit_signature(commit, &sigc);
 			signature_checked = 1;
 		}
@@ -1843,6 +1902,8 @@ static void grab_signature(struct atom_value *val, int deref, struct object *obj
 
 	if (signature_checked)
 		signature_check_clear(&sigc);
+
+	return 0;
 }
 
 static void find_subpos(const char *buf,
@@ -1920,9 +1981,8 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 }
 
 static void grab_describe_values(struct atom_value *val, int deref,
-				 struct object *obj)
+				 struct expand_data *data)
 {
-	struct commit *commit = (struct commit *)obj;
 	int i;
 
 	for (i = 0; i < used_atom_cnt; i++) {
@@ -1944,7 +2004,7 @@ static void grab_describe_values(struct atom_value *val, int deref,
 		cmd.git_cmd = 1;
 		strvec_push(&cmd.args, "describe");
 		strvec_pushv(&cmd.args, atom->u.describe_args.v);
-		strvec_push(&cmd.args, oid_to_hex(&commit->object.oid));
+		strvec_push(&cmd.args, oid_to_hex(&data->oid));
 		if (pipe_command(&cmd, NULL, 0, &out, 0, &err, 0) < 0) {
 			error(_("failed to run 'describe'"));
 			v->s = xstrdup("");
@@ -2066,24 +2126,36 @@ static void fill_missing_values(struct atom_value *val)
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
@@ -2094,8 +2166,12 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
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
@@ -2292,38 +2368,41 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
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
@@ -2376,7 +2455,6 @@ static char *get_worktree_path(const struct ref_array_item *ref)
  */
 static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 {
-	struct object *obj;
 	int i;
 	struct object_info empty = OBJECT_INFO_INIT;
 	int ahead_behind_atoms = 0;
@@ -2564,14 +2642,14 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 
 
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
@@ -2589,7 +2667,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		}
 	}
 
-	return get_object(ref, 1, &obj, &oi_deref, err);
+	return get_object(ref, 1, &oi_deref, err);
 }
 
 /*

-- 
2.51.1.851.g4ebd6896fd.dirty

