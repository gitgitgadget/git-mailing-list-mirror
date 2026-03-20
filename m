Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DFB3AA4FD
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007293; cv=none; b=RYZXYhczqievWvMHiuTUslWyyBE8YPnyZqQsxY5/e65kcQe76q3uZ2hRVdDfwf2vj3+06uEBH8cPaqI+9Ik/b7JCC5ryuVlm0tB4OxTT2N8PTJ+8WRJPeQVqbhKtKMFeHco9W/Bzj3cae6cwCurg8ZzMI4eWE7g3wfT1h6yd9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007293; c=relaxed/simple;
	bh=p3krO29EO9i2IF1Ge9IFBMyEh5huuIXAAxceskosnvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYr6OraMPD3R3gZXG7fW5eoWtBNCdUbo505rc/wFRcL6FPsCStZk0GRcGoXzlK7p8X3Q7aSqSacYR0tyk0mR0PkKGvKK8/7MPcLgJ5X7ySz+jtGM4KOlPELhb4aofjbmdiBpxZHJfsjQZ9sgmyOxVGctUhAoQJvL08LBUKZ/I2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K+pwYezU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jgtsC9Ui; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K+pwYezU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jgtsC9Ui"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 60438EC00E5
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:48:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 20 Mar 2026 07:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774007291;
	 x=1774093691; bh=Rz3CMsx/U7I3TU36RD4Ua43tVdbKqHv/jy5iRT1K9hA=; b=
	K+pwYezUJ2geSLCIofwy6O3dA44iOwePrgIr3OcaeIIHwuMGr3F7eFChXr9kFKsD
	ElFN5cHCgLTOA+TEPFZ/TudOZQ+qICp/W986ual6UypTN0x1Gs5CK3muJOUpfsoM
	/JwpnvIbSEZPUF33E0I13GcrM+SZacRTcumenjePLaXiv4FlGl5CprM7IRj3XWi/
	myv1JertWWeEjLUJAX9Z40Cz8bJxbQ7lbKXTnyKMQnlp8fstmSLhX5vZAlfoUhXJ
	4UEKrNZLjdQzRnbiP+blYcyW7rLnSlCUC66/iqxzqkSZgvr/iUEnQG4zPFshtG5Y
	9CzlFd90OMUScEKm7UbBXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774007291; x=
	1774093691; bh=Rz3CMsx/U7I3TU36RD4Ua43tVdbKqHv/jy5iRT1K9hA=; b=j
	gtsC9UiQjDtR2ejZ7VS3heW2t5ghGKVIYGz/qbL27o+Tl2tAb0WjKjZ/J1HJKM4a
	0GZ40UAea3zbesSbMB9P0FrePEBcldTyhqRdGK+ceszgSCTiUDKtRryq0KrmpRJS
	nCFPv4IBDMz9yEdO9n2wD3URxSlqsCgL13Att49SOxpR7A/T4j0oM+TDvbyIEX+c
	aRlwFsCnHIkJz5W88lTbn06SxygR61SJaNZ/IdkkBQ7zmkfZOOPDBGKphPuZkIlL
	EzxNb32zHxXuaQyqYoApKb3/3T+C5owNTsqRyingoRNy/ilrj5DDCz2ZteVm+Ibx
	1hCm9HWikLo+OxATASwQg==
X-ME-Sender: <xms:-zO9aa7qR2mGoPQj6T49Jzl_aKQPaulHtdk_p5G8HwZHpO08D4Q37g>
    <xme:-zO9aa1Uf1NyM1YDCALSj43hm8fqDuiIvfsECzO00reAkYfI92bxvEBnjx46tMGde
    E0qEYbR6sIl3-0RNoT7Wv1Et50vohuxi1mVdnlcnYdA0UHkoNG_4A>
X-ME-Received: <xmr:-zO9afHm6IRocCne3CA4r3BmMxF-ESNbF2uH9ghXVlE7ExiTaUePOKQ1tDVn9B_zUDBLDbR3BY5un2e6iWjgLhnFFWl2jGabbgNim2MYVdpm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:-zO9acRbSCPH8BVFjLPuQTNKig44DJbOKXeUrAwhMaem5Dg25fDtDw>
    <xmx:-zO9aeAfFjri4reEz6tx4qUNs1y-0IUxGkHMLI3ngaEPVNHisRVypA>
    <xmx:-zO9aU2_OQBNScIFRjlLpO_A1Rlr_fo50h-OwTQrmqbuCPUxP9CIMg>
    <xmx:-zO9aUWrcCo5uy0MhKqGt1VIPavbdq5FspTlX8CiWiLtqe3XAOqwHA>
    <xmx:-zO9aTYk2_w0hoNrOEW9pmsMAAVlXasLDFDJdl3G5zPk3AeTZemTUrGL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 20 Mar 2026 07:48:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fbe3d530 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 20 Mar 2026 11:48:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 12:47:15 +0100
Subject: [PATCH 10/14] builtin/fsck: stop using `the_repository` with loose
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-fsck-without-the-repository-v1-10-6594f997926b@pks.im>
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
In-Reply-To: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

We depend on `the_repository` when performing consistency checks for
loose objects. Refactor this to use a context-provided repository
instead that is injected via the `struct for_each_loose_cb`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index ea441b072e..83299c583e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -400,7 +400,9 @@ static void check_connectivity(struct repository *repo)
 	}
 }
 
-static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
+static int fsck_obj(struct repository *repo,
+		    struct object *obj,
+		    void *buffer, unsigned long size)
 {
 	int err;
 
@@ -413,9 +415,9 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 			   printable_type(&obj->oid, obj->type),
 			   describe_object(&obj->oid));
 
-	if (fsck_walk(the_repository, obj, NULL, &fsck_obj_options))
+	if (fsck_walk(repo, obj, NULL, &fsck_obj_options))
 		objerror(obj, _("broken links"));
-	err = fsck_object(the_repository, obj, buffer, size, &fsck_obj_options);
+	err = fsck_object(repo, obj, buffer, size, &fsck_obj_options);
 	if (err)
 		goto out;
 
@@ -462,7 +464,7 @@ static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
 	}
 	obj->flags &= ~(REACHABLE | SEEN);
 	obj->flags |= HAS_OBJ;
-	return fsck_obj(obj, buffer, size);
+	return fsck_obj(the_repository, obj, buffer, size);
 }
 
 static int default_refs;
@@ -710,27 +712,28 @@ static void process_refs(struct repository *repo, struct snapshot *snap)
 	}
 }
 
-struct for_each_loose_cb
-{
+struct for_each_loose_cb {
+	struct repository *repo;
 	struct progress *progress;
 };
 
 static int fsck_loose(const struct object_id *oid, const char *path,
-		      void *data UNUSED)
+		      void *cb_data)
 {
+	struct for_each_loose_cb *data = cb_data;
 	struct object *obj;
 	enum object_type type = OBJ_NONE;
 	unsigned long size;
 	void *contents = NULL;
 	int eaten;
 	struct object_info oi = OBJECT_INFO_INIT;
-	struct object_id real_oid = *null_oid(the_hash_algo);
+	struct object_id real_oid = *null_oid(data->repo->hash_algo);
 	int err = 0;
 
 	oi.sizep = &size;
 	oi.typep = &type;
 
-	if (read_loose_object(the_repository, path, oid, &real_oid, &contents, &oi) < 0) {
+	if (read_loose_object(data->repo, path, oid, &real_oid, &contents, &oi) < 0) {
 		if (contents && !oideq(&real_oid, oid))
 			err = error(_("%s: hash-path mismatch, found at: %s"),
 				    oid_to_hex(&real_oid), path);
@@ -747,7 +750,7 @@ static int fsck_loose(const struct object_id *oid, const char *path,
 	if (!contents && type != OBJ_BLOB)
 		BUG("read_loose_object streamed a non-blob");
 
-	obj = parse_object_buffer(the_repository, oid, type, size,
+	obj = parse_object_buffer(data->repo, oid, type, size,
 				  contents, &eaten);
 
 	if (!obj) {
@@ -761,7 +764,7 @@ static int fsck_loose(const struct object_id *oid, const char *path,
 
 	obj->flags &= ~(REACHABLE | SEEN);
 	obj->flags |= HAS_OBJ;
-	if (fsck_obj(obj, contents, size))
+	if (fsck_obj(data->repo, obj, contents, size))
 		errors_found |= ERROR_OBJECT;
 
 	if (!eaten)
@@ -789,6 +792,7 @@ static void fsck_source(struct odb_source *source)
 {
 	struct progress *progress = NULL;
 	struct for_each_loose_cb cb_data = {
+		.repo = source->odb->repo,
 		.progress = progress,
 	};
 

-- 
2.53.0.1055.ga2ffed1127.dirty

