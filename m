Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEC43AA517
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007297; cv=none; b=tjJckhYS87Ul5PxTCb/h8O8r9FfQEmBNV0waRghJoXDFRBS/PXfu30IbKd18ZDI8ITK17JnjIuB5s1v9fwoS55C351Q48GoAEH1AlSqZ1cdZUf2c8XT++0Kh3Xm2Qx3HBnfIscn5xbljehO96h9dgqjD1V/so/ZMBcoZOX7HSNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007297; c=relaxed/simple;
	bh=3jDL7AxDpWb9jzRbvObi9OcQppZ9TkKF6h5FlBG/y4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mpLhQo/h8qTA0G2uBPZlbET4vR44lE0QHIcnj0hGheIq9Fmtnf4znHxxDD6m9Smh4UtjbGUoot+DT8oBjRffsCkkaPs2kPtcghYdq5Ncb4beulRz/WlGTZWBo/zWhUnV6aFYe9kSfz2JNsotnyrBfQ4BQxi6gEi8CwjkDpKecv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JrJR30an; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pvnsNaA8; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JrJR30an";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pvnsNaA8"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1F014140019F
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:48:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 20 Mar 2026 07:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774007295;
	 x=1774093695; bh=vGeHebL+ZMhH+MK6sV3DoMQ8bq7zNOB/0f+jexaSl5w=; b=
	JrJR30anSwUqSQc8n1H5ioX0/K33lvOgjROBeuRtUgIj2GaFKi/OycbYSeHVeCUf
	ZW42OLWZ/B/xr5Qgp7llppe4QjVY7dBvc0+ZGfkXcece1KPJektomogVH4mlcsoD
	Aj6V+g1gtPVX5iRvYsKQ19/7zDVLlHFxxjpjMRRZShjkJYHLN7wEu4xpKozoM5b/
	tZQMnuHLJjsBEcNEmcA+tSoQ4S0WtHFlZKdIfOXH0VxR7+3YrtmoBRvAKU+NGH5c
	HnE1JtEhxN0syhGB2BjmCIa1sU+Y2B+Rj41+LJ8qCRrX8ZWXwrk9tJc1b9RdJ0SZ
	GG5iXTOfKoYRyhOQeWsRLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774007295; x=
	1774093695; bh=vGeHebL+ZMhH+MK6sV3DoMQ8bq7zNOB/0f+jexaSl5w=; b=p
	vnsNaA8Nwh6iSzvSNKAQPEubXchHaazWEmWM3ZcFUy13y5lowmmKG8taWMU6e5iV
	8s1E+YfplVPcDQsIVloaaQXkwsWl51YVViPqcwDy/hKt+Ho/QPjVruQC6C4WVB8e
	olSEnC8LEUcALz6FMIK7l9dD1R52XMIOz4VpN50dkoXpoiNTlEkV2p3LnJ3jPJYK
	ylkohtZUzwb3dkHM/VHtItmfySrbiTk6l9xGPAZeUxjF8ZTScleMGojkE/WgzeMM
	tGQtv67prZuMc+Ja5n6xQOAxUXIp6Nh0BNO/VeqT9Mt7E/YcXaedFjYf1C4jSDs1
	iZtpaKREfKEhWVJLN2CwA==
X-ME-Sender: <xms:_zO9ab9TIXH7B5PjsLwhK-BO4aWBCWRgMtJtgXSbBGHYTsQKBBw0Og>
    <xme:_zO9aepWIpkUrx_Zpba3HuvmAJf3RFj12RBWuRJ61bVxrHKToFxwQdyYfq3j0xLhS
    UzTTR5lZEez8qHtnRR6lo7eGu0dW_u5TMM6bxLFFe1SmUPy83mJog>
X-ME-Received: <xmr:_zO9aeqoj5XWtaf81G2u0FYorNsWvVoCQEOJGvgzsz5EFLwdwTxR-l0pbeKtMz8o7l1yPQIR_iguoFcmBe61Gof1zQn3gCHCSf2OUsiO2OON>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:_zO9acmoGsy6f4ClIW-TWbkzvpuEom0Mp0SetNY5nSfl_ZX5WTY1aw>
    <xmx:_zO9aQFpb2O2ac6CF55eY8pRrzQ1qhq-DwjBJrkVQ7f8mAMIyRwPhg>
    <xmx:_zO9aVqIXds-UWVwc98ar9alpHRlLA4Q8Mhe9Ei3zNQ9hYKiWk2NAg>
    <xmx:_zO9ac7zSj0t8nSztXLGDLxSQvncEbOOT51ZQKbasStNclrepTba5Q>
    <xmx:_zO9aXu8HkVtjilv_fQvybHHXd_sLIwbkdXjngcQZk_7CY4-zgaLSCUh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Mar 2026 07:48:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 69ef434e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Mar 2026 11:48:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 12:47:16 +0100
Subject: [PATCH 11/14] builtin/fsck: stop using `the_repository` when
 checking packed objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-fsck-without-the-repository-v1-11-6594f997926b@pks.im>
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
In-Reply-To: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

We implicitly rely on `the_repository` when checking objects part of a
packfile. These objects are iterated over via `verify_pack()`, which is
provided by the packfile subsystem, and a callback function is then
invoked for each of the objects in that specific pack.

Unfortunately, it is not possible to provide a payload to the callback
function. Refactor `verify_pack()` to accept a payload that is passed
through to the callback so that we can inject the repository and get rid
of the use of `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 13 +++++++------
 pack-check.c   |  7 ++++---
 pack.h         |  9 +++++++--
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 83299c583e..874af76e05 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -448,15 +448,16 @@ static int fsck_obj(struct repository *repo,
 }
 
 static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
-			   unsigned long size, void *buffer, int *eaten)
+			   unsigned long size, void *buffer, int *eaten, void *cb_data)
 {
+	struct repository *repo = cb_data;
+	struct object *obj;
+
 	/*
 	 * Note, buffer may be NULL if type is OBJ_BLOB. See
 	 * verify_packfile(), data_valid variable for details.
 	 */
-	struct object *obj;
-	obj = parse_object_buffer(the_repository, oid, type, size, buffer,
-				  eaten);
+	obj = parse_object_buffer(repo, oid, type, size, buffer, eaten);
 	if (!obj) {
 		errors_found |= ERROR_OBJECT;
 		return error(_("%s: object corrupt or missing"),
@@ -464,7 +465,7 @@ static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
 	}
 	obj->flags &= ~(REACHABLE | SEEN);
 	obj->flags |= HAS_OBJ;
-	return fsck_obj(the_repository, obj, buffer, size);
+	return fsck_obj(repo, obj, buffer, size);
 }
 
 static int default_refs;
@@ -1088,7 +1089,7 @@ int cmd_fsck(int argc,
 			repo_for_each_pack(repo, p) {
 				/* verify gives error messages itself */
 				if (verify_pack(repo,
-						p, fsck_obj_buffer,
+						p, fsck_obj_buffer, repo,
 						progress, count))
 					errors_found |= ERROR_PACK;
 				count += p->num_objects;
diff --git a/pack-check.c b/pack-check.c
index 7378c80730..79992bb509 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -53,6 +53,7 @@ static int verify_packfile(struct repository *r,
 			   struct packed_git *p,
 			   struct pack_window **w_curs,
 			   verify_fn fn,
+			   void *fn_data,
 			   struct progress *progress, uint32_t base_count)
 
 {
@@ -161,7 +162,7 @@ static int verify_packfile(struct repository *r,
 				    oid_to_hex(&oid), p->pack_name);
 		else if (fn) {
 			int eaten = 0;
-			err |= fn(&oid, type, size, data, &eaten);
+			err |= fn(&oid, type, size, data, &eaten, fn_data);
 			if (eaten)
 				data = NULL;
 		}
@@ -192,7 +193,7 @@ int verify_pack_index(struct packed_git *p)
 	return err;
 }
 
-int verify_pack(struct repository *r, struct packed_git *p, verify_fn fn,
+int verify_pack(struct repository *r, struct packed_git *p, verify_fn fn, void *fn_data,
 		struct progress *progress, uint32_t base_count)
 {
 	int err = 0;
@@ -202,7 +203,7 @@ int verify_pack(struct repository *r, struct packed_git *p, verify_fn fn,
 	if (!p->index_data)
 		return -1;
 
-	err |= verify_packfile(r, p, &w_curs, fn, progress, base_count);
+	err |= verify_packfile(r, p, &w_curs, fn, fn_data, progress, base_count);
 	unuse_pack(&w_curs);
 
 	return err;
diff --git a/pack.h b/pack.h
index ec76472e49..1cde92082b 100644
--- a/pack.h
+++ b/pack.h
@@ -85,7 +85,11 @@ struct pack_idx_entry {
 
 struct progress;
 /* Note, the data argument could be NULL if object type is blob */
-typedef int (*verify_fn)(const struct object_id *, enum object_type, unsigned long, void*, int*);
+typedef int (*verify_fn)(const struct object_id *oid,
+			 enum object_type type,
+			 unsigned long size,
+			 void *buffer, int *eaten,
+			 void *fn_data);
 
 const char *write_idx_file(struct repository *repo,
 			   const char *index_name,
@@ -95,7 +99,8 @@ const char *write_idx_file(struct repository *repo,
 			   const unsigned char *sha1);
 int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
 int verify_pack_index(struct packed_git *);
-int verify_pack(struct repository *, struct packed_git *, verify_fn fn, struct progress *, uint32_t);
+int verify_pack(struct repository *, struct packed_git *, verify_fn fn, void *fn_data,
+		struct progress *, uint32_t);
 off_t write_pack_header(struct hashfile *f, uint32_t);
 void fixup_pack_header_footer(const struct git_hash_algo *, int,
 			      unsigned char *, const char *, uint32_t,

-- 
2.53.0.1055.ga2ffed1127.dirty

