Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D2329DB6C
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938670; cv=none; b=hxdK5QSrNsmYcxWq0t0hwh6PVmsT/0xMSEJbZAGk5yoSMTBKGZe31CC/miFQlldHyddrhj+G6pqVReyTuo2j8sB2JbajCnIqz8t34PAy5wkTD9NJvyXtsbE28j7YCQAjejp8ydckRwzLCoOBu6EVohuDPksnUvyiLhEO0fd09OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938670; c=relaxed/simple;
	bh=xfMjnE0yqANpMRUKBm3f1DNC04dz9g8U10ufts75Uck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bolQFT75Rz217J3dfGIoJ/ifDWQ+zXzOI3sM7I85l/OA/iO0d5qNwgphVCrUrPxy0x+CUmLtTbmROsIrepAaQNWeUNw6LBoCM69eM74t7QJUvn2oCuNWArigSLj+OqgFCke+qBA1PaYyGbnoW5KqUIAfvj0sChYXvOm4a4itiso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kcO1GeP7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qStUHTJF; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kcO1GeP7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qStUHTJF"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A387C1D0038E;
	Wed,  8 Oct 2025 11:51:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 08 Oct 2025 11:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759938667;
	 x=1760025067; bh=JXdC1vuiQRAgkRMuf+0PTU4zugjv6J3gD5lbYkB+3fw=; b=
	kcO1GeP7Lr8snC4yw925uxnzgNOJPhsPBD627H5+Y/LwCkpXA30i2tvxyX75w9Qv
	IYza9K0lcSkmNUYMAgHiOWzQamd+j7DQ1WgqZWdfiPeXhBdn492812BYVEJPqYIl
	Io1YIVWWSwmCE4yk+jNgY7oJA5ouX0GnOR6F/6w1+/iXnRCI/zNK2x4rTUYWDZXo
	ROfEwV26cv6elE8wHlCrFFoqq9PbEr8aKE7xqxd/91dJbY0BO9Ql/O7U2hFIFjSV
	vF55DgxV1FYyeB3MVwXdDFc+6x0GP5RgbSMsG0nuFhujaEnsJwIfP03tOEuOvptK
	e6bSH24ZcnP6fBGWyU07WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759938667; x=
	1760025067; bh=JXdC1vuiQRAgkRMuf+0PTU4zugjv6J3gD5lbYkB+3fw=; b=q
	StUHTJF+Hpx6to4Vk5sXwgSGYpHfHsNjjn7vImBfN04UCt2IZSoKAINnh48Qq3VK
	FWkJ8hsf8TKUD0mBAxVdx1/7iBIIr1m1gNtnG0dCy1CqoZFEiwwIfD6zKiUkIp6j
	29SVpdJ06C8dO5cV6vsJkdIQnh5oOQKMHSdbm7haW3YNaILv+cqhQm/3B5ZHbsOU
	EA6VqdM7UmTeeD3kFW1q8lULtI7Gg0gm7Wn8nzKkP+BaNY31uJtPbw6717x0CSGu
	BA5uEOp0JNfs0lvM5EQfLK5Jht3NVlUpr2RR6Kavk0Bs5WmE+ttzXDi9nqCOyGtb
	S2vn4PqPp9/BkmjAbsP4w==
X-ME-Sender: <xms:a4jmaBGKkFsuskt7zXhMNHO47fo5Az4geSaxPWbjj_0ZOlmxRR5fZA>
    <xme:a4jmaKBQs9W9R0Ldhw3Qvggd25nPty0z-rOCy34wz6zZmiBFcC79DjX5YjcBZKyf8
    8UUVEtM4MS9Sq2R0UWNSWuGn5uCzYDjoTyp8c-R2dTi_W9iMLMLLrc>
X-ME-Received: <xmr:a4jmaM9uDHQcuOk1uYEocKfXc7uI2fvQuv7PupX3PgDQFmacI7pHhuU9O1HYzhlhMQgRfYLfxhShYt6A9cmYwkyMiw38uJYUjw7VAVIP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:a4jmaOCXmiHLhKduvF2qK5cZj0V44LjMjpzV2E-rc9uONTlgESz2Zg>
    <xmx:a4jmaJS5O9wXNOVKOdVtsBk_LRZQJ6nkEhpyrLufyKVt5LBFmLx37Q>
    <xmx:a4jmaNsayWlhoTYrKtsijrx739dUMYzkyH0Xu38Vvuk0RlpldMNB2g>
    <xmx:a4jmaN2nrXIvx0xS6zIvuqcFWPHCEWP156Euvd2MqBcLnCIdiAV8eQ>
    <xmx:a4jmaDBst20bKHUXWIIUASyEjCsJP-pdhE5z3w6Bclnk0B2rX3gNJsY_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 11:51:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 104f9d33 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 15:51:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 08 Oct 2025 17:50:29 +0200
Subject: [PATCH v2 14/14] ref-filter: parse objects on demand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-14-76e30d5c9542@pks.im>
References: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
In-Reply-To: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
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
index 72cf85c8c6..537c7babac 100644
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
2.51.0.764.g787ff6f08a.dirty

