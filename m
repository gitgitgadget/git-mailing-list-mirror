Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA9E3AA4F1
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007279; cv=none; b=IC5ATPOAjY/MW9bRjVKy90r7MTkNomEo6j4ZleEFpDIDSCZpa8nLh4HYqUlk2tDNqChveuPrLndMqrpNOO7KGmtebjoeOmCWeVbqrWjXz0O8Js4Do/6IeI+TlWW5RCLArA8YIZbgOHSYs9SuHCmr47qdN1QVJHNuIsXWoGwspN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007279; c=relaxed/simple;
	bh=P8JiH+n9QdOaVFTU7Odih/1XKUqtZ1XkDeJgUhMg8Us=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mPXEqXzJ6uDJyxeXG2UDm7SFhFpVIwn6RbGYJzsrWGyCyA9hz57bscPQmzE6ROdfdx8qHsdL39UNLs+425EiKOYPEERmXd64TLsC0IO6yH2ioZsnQYRUzd6mHZLjy+EhvcTiOwfIEMPpQ8cksbYvo69hoNUulzP6UDst8sg9T78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A9XJYFYi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4uz+aWiN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A9XJYFYi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4uz+aWiN"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F49E14001E9
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:47:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 07:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774007277;
	 x=1774093677; bh=qhb1jYNPdRqlpNMGgCcqCJRx7CNuC5yBuPx9PDbNbsI=; b=
	A9XJYFYiUjif6ewPijLVSP2a46cCgggzZTiOki4hFIW2+1XIcq5lIDKHPuFS9IA6
	oeFTBiRVWrDrT3cyCQ3mFauTIWmy3pvcRX3huOcoBZt65tj0QzFzsU4HpvcZgwrm
	YxjVrotEWY+L4WUreSr0CJmmjnJ27O3dmiDPhRJDhA5MCJuR8mDcnEcQkpTB4H9n
	pE4zr8ReFat1Mw7WZji8VZgq5MONZv3H+WDY3wl3BYQwX26koaqP8klCYM7jlmfl
	U61Ot9Xtj1BAhOlS5ARetxzVJc4aG4vIRHZgh2/clNXX10vZPZMhNZHgqltEtb8l
	IT3FpegD4BUKVT5mXcCChQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774007277; x=
	1774093677; bh=qhb1jYNPdRqlpNMGgCcqCJRx7CNuC5yBuPx9PDbNbsI=; b=4
	uz+aWiNpcyu6DXqyMdvsGmdjwQhNs/YsWIiZEP6opxsbxbi1LjYChvpONlYVzfaV
	cuZytI3UPMP7yx1fFh00RbC+8MV2cQOAUOWIOD3zoSyc/BSz/NAsVVKr9G2q7947
	u7uiOPxiROX1/I4khBAnn8935ZzoFK+GCwu/2UavzdP3BsXUqJ9sMYAAL2hR0uW7
	xy1E8OiwpdgZzBlwWJdxtcECzytaklX+13eo124pQb5FAkkcG/3aFvWVlaQM3XBq
	6N9H0OpwTA8hDehH0qL1QqhL/80L2oaFAp62fyvBYeki8JgNl646GONOHc1vRf9s
	2tlussbK7mK2kzTRarnEg==
X-ME-Sender: <xms:7TO9aST5oT4kPFp2n4ac2Ou3CnuJ1AU0Rf91bn01Fwx0a3jT-aWZNQ>
    <xme:7TO9aeuAnbwwYFe-bmhC0NvTHp4dIBMv3otLAb_ZKfsxExsHzns85OVHoU4_wF3nM
    U0G6O78lhwlc9J9l6psF0ywzaXUJwdPg9aoTlC_GlYonIcapsbg>
X-ME-Received: <xmr:7TO9aVdxqe9OVgiEOUlHB9rbud79dUfppGtBbszWIGeGRo4Iiw-3jmMNaZtpp72Xmg0r9_7jvtsSFqs9_OIFkSyR4LJikKaYVd6sEk3ahed7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:7TO9aTLtop3Oa1PycGBIQ2HgWLpKys-Ah0vv8QLFJ-MpAB9pUzQ7eg>
    <xmx:7TO9abbftiZ86onB_2hZArNLKa7OtVRiAcFLDm4i6Bn2vPOCxfucPQ>
    <xmx:7TO9aWuxTZphZpXaxsJB4XPX8rU34eEI6NIZGmrCfRsieKo9LzXkGA>
    <xmx:7TO9aQu2HegPO250WMzF2RP3IUIZs5hqdBvKD0Eibsw2hLqknYo4Rw>
    <xmx:7TO9aSTt1OgYJ2WHj-AyesEcND29Bj97M4N0FhkzssSjO3C6OXvvLD98>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Mar 2026 07:47:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 930d8ce5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Mar 2026 11:47:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 12:47:10 +0100
Subject: [PATCH 05/14] fsck: stop relying on global state via
 `parse_oid_hex()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-fsck-without-the-repository-v1-5-6594f997926b@pks.im>
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
In-Reply-To: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The function `parse_oid_hex()` implicitly relies on global state, as it
uses the hash algorithm of `the_repository` to parse the input string.
Refactor "fsck.c" to use `parse_oid_hex_algop()` instead and make the
repository available via parameters as required.

This was the last dependency on `the_repository` in "fsck.c", so we can
now drop `USE_THE_REPOSITORY_VARIABLE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c           |  2 +-
 builtin/index-pack.c     |  5 +++--
 builtin/mktag.c          |  4 ++--
 builtin/unpack-objects.c |  2 +-
 fsck.c                   | 33 ++++++++++++++++++---------------
 fsck.h                   | 11 +++++++----
 object-file.c            |  3 ++-
 7 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index fd689a1e14..ff9951c10c 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -415,7 +415,7 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 
 	if (fsck_walk(the_repository, obj, NULL, &fsck_obj_options))
 		objerror(obj, _("broken links"));
-	err = fsck_object(obj, buffer, size, &fsck_obj_options);
+	err = fsck_object(the_repository, obj, buffer, size, &fsck_obj_options);
 	if (err)
 		goto out;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c4117e5970..031e4697d9 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -933,7 +933,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			else
 				die(_("invalid blob object %s"), oid_to_hex(oid));
 			if (do_fsck_object &&
-			    fsck_object(&blob->object, (void *)data, size, &fsck_options))
+			    fsck_object(the_repository, &blob->object, (void *)data,
+					size, &fsck_options))
 				die(_("fsck error in packed object"));
 		} else {
 			struct object *obj;
@@ -952,7 +953,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			if (!obj)
 				die(_("invalid %s"), type_name(type));
 			if (do_fsck_object &&
-			    fsck_object(obj, buf, size, &fsck_options))
+			    fsck_object(the_repository, obj, buf, size, &fsck_options))
 				die(_("fsck error in packed object"));
 			if (strict && fsck_walk(the_repository, obj, NULL, &fsck_options))
 				die(_("Not all child objects of %s are reachable"), oid_to_hex(&obj->oid));
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 2cf843c195..1925f04321 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -100,8 +100,8 @@ int cmd_mktag(int argc,
 	/* config might set fsck.extraHeaderEntry=* again */
 	fsck_options_parse_config(&fsck_options, the_repository);
 
-	if (fsck_tag_standalone(NULL, buf.buf, buf.len, &fsck_options,
-				&tagged_oid, &tagged_type))
+	if (fsck_tag_standalone(the_repository, NULL, buf.buf, buf.len,
+				&fsck_options, &tagged_oid, &tagged_type))
 		die(_("tag on stdin did not pass our strict fsck check"));
 
 	if (verify_object_in_tag(&tagged_oid, &tagged_type) < 0)
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 3e748a55d9..dadc2ba65f 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -241,7 +241,7 @@ static int check_object(struct object *obj, enum object_type type,
 	obj_buf = lookup_object_buffer(obj);
 	if (!obj_buf)
 		die("Whoops! Cannot find object '%s'", oid_to_hex(&obj->oid));
-	if (fsck_object(obj, obj_buf->buffer, obj_buf->size, &fsck_options))
+	if (fsck_object(the_repository, obj, obj_buf->buffer, obj_buf->size, &fsck_options))
 		die("fsck error in packed object");
 	fsck_options.walk = check_object;
 	if (fsck_walk(the_repository, obj, NULL, &fsck_options))
diff --git a/fsck.c b/fsck.c
index efd987dd2b..edf7a0618f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "date.h"
 #include "dir.h"
@@ -962,7 +960,8 @@ static int fsck_ident(const char **ident, const char *ident_end,
 	return 0;
 }
 
-static int fsck_commit(const struct object_id *oid,
+static int fsck_commit(struct repository *repo,
+		       const struct object_id *oid,
 		       const char *buffer, unsigned long size,
 		       struct fsck_options *options)
 {
@@ -983,14 +982,14 @@ static int fsck_commit(const struct object_id *oid,
 
 	if (buffer >= buffer_end || !skip_prefix(buffer, "tree ", &buffer))
 		return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
-	if (parse_oid_hex(buffer, &tree_oid, &p) || *p != '\n') {
+	if (parse_oid_hex_algop(buffer, &tree_oid, &p, repo->hash_algo) || *p != '\n') {
 		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
 		if (err)
 			return err;
 	}
 	buffer = p + 1;
 	while (buffer < buffer_end && skip_prefix(buffer, "parent ", &buffer)) {
-		if (parse_oid_hex(buffer, &parent_oid, &p) || *p != '\n') {
+		if (parse_oid_hex_algop(buffer, &parent_oid, &p, repo->hash_algo) || *p != '\n') {
 			err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
 			if (err)
 				return err;
@@ -1024,16 +1023,18 @@ static int fsck_commit(const struct object_id *oid,
 	return 0;
 }
 
-static int fsck_tag(const struct object_id *oid, const char *buffer,
+static int fsck_tag(struct repository *repo,
+		    const struct object_id *oid, const char *buffer,
 		    unsigned long size, struct fsck_options *options)
 {
 	struct object_id tagged_oid;
 	int tagged_type;
-	return fsck_tag_standalone(oid, buffer, size, options, &tagged_oid,
-				   &tagged_type);
+	return fsck_tag_standalone(repo, oid, buffer, size, options,
+				   &tagged_oid, &tagged_type);
 }
 
-int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
+int fsck_tag_standalone(struct repository *repo,
+			const struct object_id *oid, const char *buffer,
 			unsigned long size, struct fsck_options *options,
 			struct object_id *tagged_oid,
 			int *tagged_type)
@@ -1057,7 +1058,7 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
 		goto done;
 	}
-	if (parse_oid_hex(buffer, tagged_oid, &p) || *p != '\n') {
+	if (parse_oid_hex_algop(buffer, tagged_oid, &p, repo->hash_algo) || *p != '\n') {
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
 		if (ret)
 			goto done;
@@ -1266,16 +1267,18 @@ static int fsck_blob(const struct object_id *oid, const char *buf,
 	return ret;
 }
 
-int fsck_object(struct object *obj, void *data, unsigned long size,
+int fsck_object(struct repository *repo,
+		struct object *obj, void *data, unsigned long size,
 	struct fsck_options *options)
 {
 	if (!obj)
 		return report(options, NULL, OBJ_NONE, FSCK_MSG_BAD_OBJECT_SHA1, "no valid object to fsck");
 
-	return fsck_buffer(&obj->oid, obj->type, data, size, options);
+	return fsck_buffer(repo, &obj->oid, obj->type, data, size, options);
 }
 
-int fsck_buffer(const struct object_id *oid, enum object_type type,
+int fsck_buffer(struct repository *repo,
+		const struct object_id *oid, enum object_type type,
 		const void *data, unsigned long size,
 		struct fsck_options *options)
 {
@@ -1284,9 +1287,9 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
 	if (type == OBJ_TREE)
 		return fsck_tree(oid, data, size, options);
 	if (type == OBJ_COMMIT)
-		return fsck_commit(oid, data, size, options);
+		return fsck_commit(repo, oid, data, size, options);
 	if (type == OBJ_TAG)
-		return fsck_tag(oid, data, size, options);
+		return fsck_tag(repo, oid, data, size, options);
 
 	return report(options, oid, type,
 		      FSCK_MSG_UNKNOWN_TYPE,
diff --git a/fsck.h b/fsck.h
index 3ca1683f74..62b7c3c93a 100644
--- a/fsck.h
+++ b/fsck.h
@@ -231,14 +231,16 @@ int fsck_walk(struct repository *repo,
  * Blob objects my pass a NULL data pointer, which indicates they are too large
  * to fit in memory. All other types must pass a real buffer.
  */
-int fsck_object(struct object *obj, void *data, unsigned long size,
-	struct fsck_options *options);
+int fsck_object(struct repository *repo,
+		struct object *obj, void *data, unsigned long size,
+		struct fsck_options *options);
 
 /*
  * Same as fsck_object(), but for when the caller doesn't have an object
  * struct.
  */
-int fsck_buffer(const struct object_id *oid, enum object_type,
+int fsck_buffer(struct repository *repo,
+		const struct object_id *oid, enum object_type,
 		const void *data, unsigned long size,
 		struct fsck_options *options);
 
@@ -246,7 +248,8 @@ int fsck_buffer(const struct object_id *oid, enum object_type,
  * fsck a tag, and pass info about it back to the caller. This is
  * exposed fsck_object() internals for git-mktag(1).
  */
-int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
+int fsck_tag_standalone(struct repository *repo,
+			const struct object_id *oid, const char *buffer,
 			unsigned long size, struct fsck_options *options,
 			struct object_id *tagged_oid,
 			int *tag_type);
diff --git a/object-file.c b/object-file.c
index ecbcc501dd..f58acaa939 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1283,7 +1283,8 @@ static int index_mem(struct index_state *istate,
 
 		opts.strict = 1;
 		opts.error_func = hash_format_check_report;
-		if (fsck_buffer(null_oid(istate->repo->hash_algo), type, buf, size, &opts))
+		if (fsck_buffer(the_repository, null_oid(istate->repo->hash_algo),
+				type, buf, size, &opts))
 			die(_("refusing to create malformed object"));
 		fsck_finish(the_repository, &opts);
 	}

-- 
2.53.0.1055.ga2ffed1127.dirty

