Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B8747D44F
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935730; cv=none; b=eUDPkrJRNegW+7DjWt23Qfej8Z7LgMLAIG+UIpIivzFOTH8kEDdxNgHxpZ3uNnHHyUv38lsTP8YrZ3cwRCTmGEkQFbnC9RtHAQaBEuwaZ3ybCtxrVNTSCI+kWb6+sVWsVu1ihKGwHHlv0byHznu8P8MOKJAc6OkLrovSCjiS1Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935730; c=relaxed/simple;
	bh=zKhvZpdAkcvFdWsAfmUvrK/pX9vpEd9gOMsYxejJX+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nzkReuaIu7e98uRMqRwJsaGkGxJFgPiO4c0YNNQ76A5cbZtsGPPNdDc1k5OmBD4spkGlzel+RiV85YFnDtTvIAxeZZtlNWCiRzYFpOg36/RACo5Rt0//DeHn23YkoMnEHnjmp0NxN1xlu7e5QN9sK7auPOS60YWFCqUxe8peCfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eHL4F7sG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QcZ071hK; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eHL4F7sG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QcZ071hK"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 92F63EC008A
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 06:08:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 06:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790935726;
	 x=1791022126; bh=WDKY85rO2DUf0qw7BC0KO9KAnJWJlhLpLHHZrVVhgoc=; b=
	eHL4F7sGeA+Kc06kykUjQlg8OCpoqttoDFubRZNRi9L4VM21QenFUEA13+omp9EI
	KRpvgSuThLxtzovuTwBPsoybQMOfOOUzMKh8ZeKlwQnXs8QaNld65ccBYaqac68Y
	/MwY96yzlMT9YVDOMnkoxZNGI9ceJ9gTLBZ58/MjcbLUOIqtArdudeml0T7dDC7T
	B5rJ9ANGSGq6EXZPUmebml2gkCZbReQa74+Jb2H+/rVE/YmYxUOqCj26K9TX6MCq
	R0tKz2qx+oVdTwH4RSfu+6hpTdZMX84Fgyniz6RXh3Kz6nA/JHfLBMceZHRDR3fc
	xx3R4sNRcarmtNKSHJ/cCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790935726; x=
	1791022126; bh=WDKY85rO2DUf0qw7BC0KO9KAnJWJlhLpLHHZrVVhgoc=; b=Q
	cZ071hKIYUQSHLzmDp4pe6hXJmvFzquZhvDY91dhc+AJvbkG/NW9ENqpIHcumiYL
	4xudc/MqBIX0WUc82UJBTltd4QBOJjq21flOlZUe+RXa3kzfJV3GEXjKYS8vigrd
	TqROfEx3A5h4ZL5fIeTmVvCJcFO9woWjZsCQ38vf3OvuGciJYusAl8vf1CZTiIaj
	5GmlIeIEdWkK3HgqqnWEhi6SbDLjF22EEneO6WTNjCV/YB19AYjG5kGqsRKvW1cb
	XqHnK8SESpYNa9ILx6P+yLyVHWlsPUgLWiF6eKbdVuex3O7EcmIMPBjHozCM53SM
	v9SpF5PbQ6WlCVnQl3bGw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790935726; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:u1BrFv+wiNuGrieGAcWv7j4RC4VFmEShLjOtkxnTgULngYY
	tiACaE6zUg4QmAW3Afl+WaKikQUpUXDOFqk4gII9/Ht+SdkY1/MCy3CpBswRaBKY
	0whUHv0u9lMYKJ0t8fJ5wzK0vlm/DbabWbtcy1PZyRkmWZHZssXb5Jk5siHPOoah
	7SggaAD21nGh5rUq8CqqwOOXvOz7sCYj2kMEeycKzK8K4ASv2Z8MI/InoH4gzgOy
	ZoMdpvggHYoGL2KUVpPtYjHuf3P38G3Z9u6/Q7t++PSa8lUL9ndvPf6WQPD3q4qX
	c3a+Xo6Tt/NOsfqGbtt9p9KvwHsCpkF7h9vWtdw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:AieP7zMKRxAPD5p3jvylQ5O9vouCqMmdvmCzJSEaarc=:zKhvZpdAkcvFdWsAfmUvrK/pX9vpEd9gOMsYxejJX+k=;
X-ME-Sender: <xms:roK_ahoMAAfnkaydBMClSzEStkfYDOrnyqVW6TqsAlp4w_Xu_CFBXA>
    <xme:roK_aqmXfGCWILVxrSHZ6tdi2u_eM9juE9jGY09-6SU19zwi-tzvvTsK63XyHe5TX
    tGciR5YrAaJUgvgxnKfMwuxPnQw3LdowWQ_ihybjWIRsx3r_5uaMA>
X-ME-Received: <xmr:roK_aj3UPN-ZLygr7MRezfYH1mlA6Ex53tbqd8ZTR7XHwuHYQ5Jewg>
X-ME-Proxy-Cause: dmFkZTGlP9C9GTaLZ5ybEFZacEw6Jo/d+yUI+CqODggjw8cFo7NwiaDx6M4Kz185Phcj/e
    X2YxrIZO3aa0SYZnufkcUVDiotX/NUee0Q0+LbNlEPa6zzeEKMrisdX+DPw3mILzQwXF+H
    MY0xBHLNf8j7GJ1shBuy+WR1wwuCixwxlU8rx/DN1VJUoqMiCJnIxRRQSLwhRSTaw2JHVK
    VrfwV5uP8XJDhipRlB24u8HRQ89dEIfKq5ckj11q9L2cMStoc/k0tH8T13DYvTSfGCIgic
    HDbaOBIo4GfajXSiWsiKjHYfxBoooOopYBeo7gvoxKUs+4z++jQA4fUWDLJeZjV3bPRhU8
    E0mna+YPQsCXXJqcuzHgKoovJOM8KCw0Zko10xKk+AQlgs2RjWls8TSDR9rLGVfVNoU3Zb
    sJyykBpmZ3rMl+KvQCKH/VZUXMhSe1WJIIBpOSYH6CWb4L52xSsIZlzQb9alrJC5060oMe
    Y4CBT+9TxSKWEuy7vWoNmZHmnD2hsiEKeMIqCtRxXJew1osskvyR5ofDwJhvpYhTDtg2sj
    WQnyEt8FwcDaAGSHT2vXi/FjEIAMTjDmFlDz4AO2WR2PD03u9PPTwRec3/eYSpIWcZnIiC
    092U6/vvfRVxpgXUBnMBpjbIKOevCZmq5QnJuydZsSG4tPsolZXUWnRZGJ9w
X-ME-Proxy: <xmx:roK_aiCtRqqHtUJrWo2xl1CMgajK_dWV5MSvrCjxPE4o9GOXtUETfQ>
    <xmx:roK_agxsR_rPCp51IBscMR-u2mCs5fNWGxrp9ZOMWXEjNp5ERJ4ZZQ>
    <xmx:roK_agm2NoBbFCdz8dS4UFnME2j19Nx0tg2Yeoy7RwyuPSnuMIQDMQ>
    <xmx:roK_alGhImwBtVn1p9Sx1lZlV-30dMgHb6G67EAuZsU9g1x9L36kSQ>
    <xmx:roK_apKEwJ3e1qDdEAWC1G68Kl-AOxQk6JsSNICZjRqbASXVHQHgLwhP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Oct 2026 06:08:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e03123ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 2 Oct 2026 10:08:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 Oct 2026 12:08:18 +0200
Subject: [PATCH 07/13] tmp-objdir: absorb logic to set and restore primary
 sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-pks-odb-move-alternates-v1-7-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
In-Reply-To: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The functions `odb_set_temporary_primary_source()` and
`odb_restore_primary_source()` can be used to adapt the primary object
database source. Nowadays though we only have a single user of this
subsystem left, which is the "tmp-objdir" subsystem.

Despite that, this functionality is also becoming less useful overall as
alternates are becoming an implementation detail of the "files" backend.
And with that change, there will only ever be a single source attached
to the object database anyway.

Move the logic into the "tmp-objdir" subsystem accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c        | 45 ---------------------------------------------
 odb.h        | 17 -----------------
 tmp-objdir.c | 38 ++++++++++++++++++++++++++++++++++----
 3 files changed, 34 insertions(+), 66 deletions(-)

diff --git a/odb.c b/odb.c
index 1dc8647159..8b54271c27 100644
--- a/odb.c
+++ b/odb.c
@@ -239,51 +239,6 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 	return alternate;
 }
 
-struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
-						    const char *dir, int will_destroy,
-						    struct odb_source **prev_source)
-{
-	struct odb_source *source;
-
-	/*
-	 * Make a new primary odb and link the old primary ODB in as an
-	 * alternate
-	 */
-	source = odb_source_new(odb, dir, false);
-
-	/*
-	 * Disable ref updates while a temporary odb is active, since
-	 * the objects in the database may roll back.
-	 */
-	odb->repo->disable_ref_updates = true;
-	source->will_destroy = will_destroy;
-	source->next = odb->sources;
-	odb->sources = source;
-
-	if (prev_source)
-		*prev_source = source->next;
-
-	return source;
-}
-
-void odb_restore_primary_source(struct object_database *odb,
-				struct odb_source *restore_source,
-				const char *old_path)
-{
-	struct odb_source *cur_source = odb->sources;
-
-	if (strcmp(old_path, cur_source->path))
-		BUG("expected %s as primary object store; found %s",
-		    old_path, cur_source->path);
-
-	if (cur_source->next != restore_source)
-		BUG("we expect the old primary object store to be the first alternate");
-
-	odb->repo->disable_ref_updates = false;
-	odb->sources = restore_source;
-	odb_source_free(cur_source);
-}
-
 char *compute_alternate_path(const char *path, struct strbuf *err)
 {
 	char *ref_git = NULL;
diff --git a/odb.h b/odb.h
index 5c86572b5d..4143812f55 100644
--- a/odb.h
+++ b/odb.h
@@ -226,23 +226,6 @@ struct odb_fsck_options {
  */
 int odb_fsck(struct object_database *odb, struct odb_fsck_options *opts);
 
-/*
- * Replace the current writable object directory with the specified temporary
- * object directory and return the newly installed primary source. The former
- * primary source is reported via `prev_source` when non-NULL.
- */
-struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
-						    const char *dir, int will_destroy,
-						    struct odb_source **prev_source);
-
-/*
- * Restore the primary source that was previously replaced by
- * `odb_set_temporary_primary_source()`.
- */
-void odb_restore_primary_source(struct object_database *odb,
-				struct odb_source *restore_source,
-				const char *old_path);
-
 /*
  * Iterate through all alternates of the database and execute the provided
  * callback function for each of them. Stop iterating once the callback
diff --git a/tmp-objdir.c b/tmp-objdir.c
index deaaf6ba2e..31a7920be7 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -51,6 +51,26 @@ static void tmp_objdir_reparent(const char *old_cwd,
 	free(path);
 }
 
+/*
+ * Restore the primary source that was previously replaced by
+ * `tmp_objdir_replace_primary_odb()`.
+ */
+static void tmp_objdir_restore_source(struct tmp_objdir *t)
+{
+	struct odb_source *cur_source = t->repo->objects->sources;
+
+	if (strcmp(t->path.buf, cur_source->path))
+		BUG("expected %s as primary object store; found %s",
+		    t->path.buf, cur_source->path);
+
+	if (cur_source->next != t->prev_source)
+		BUG("we expect the old primary object store to be the first alternate");
+
+	t->repo->disable_ref_updates = false;
+	t->repo->objects->sources = t->prev_source;
+	odb_source_free(cur_source);
+}
+
 int tmp_objdir_destroy(struct tmp_objdir *t)
 {
 	int err;
@@ -62,7 +82,7 @@ int tmp_objdir_destroy(struct tmp_objdir *t)
 		the_tmp_objdir = NULL;
 
 	if (t->prev_source)
-		odb_restore_primary_source(t->repo->objects, t->prev_source, t->path.buf);
+		tmp_objdir_restore_source(t);
 
 	err = remove_dir_recursively(&t->path, 0);
 
@@ -298,7 +318,7 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 	if (t->prev_source) {
 		if (t->repo->objects->sources->will_destroy)
 			BUG("migrating an ODB that was marked for destruction");
-		odb_restore_primary_source(t->repo->objects, t->prev_source, t->path.buf);
+		tmp_objdir_restore_source(t);
 		t->prev_source = NULL;
 	}
 
@@ -328,6 +348,16 @@ struct odb_source *tmp_objdir_replace_primary_odb(struct tmp_objdir *t,
 		BUG("the primary object database is already replaced");
 	t->will_destroy = will_destroy;
 
-	return odb_set_temporary_primary_source(t->repo->objects, t->path.buf,
-						will_destroy, &t->prev_source);
+	/*
+	 * Make a new primary source and link the old primary source in as an
+	 * alternate. Disable ref updates while a temporary source is active,
+	 * since the objects in the database may roll back.
+	 */
+	t->prev_source = t->repo->objects->sources;
+	t->repo->objects->sources = odb_source_new(t->repo->objects, t->path.buf, false);
+	t->repo->objects->sources->next = t->prev_source;
+	t->repo->objects->sources->will_destroy = will_destroy;
+	t->repo->disable_ref_updates = true;
+
+	return t->repo->objects->sources;
 }

-- 
2.56.0.379.gc618271300.dirty

