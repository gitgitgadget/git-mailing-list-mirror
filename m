Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC5E40963B
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572370; cv=none; b=IdcpWMsMljstoxUzT8g+bRYUfdnCRebNYGuy3ehqp1wgUX4Raf8j1uPo4QE36xmHLZLVgHpOLuC8XzDJ4v8wbKSvOm0rFSw0+JYqoSUaOndNd+u5o6feslXIs0hW2qEg4oXcb/CGBrvdFS/gsNURZ+alW1+OQbdanDXgSfm9S2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572370; c=relaxed/simple;
	bh=+YrKBpzXd7hQKpZq4Ng9aPCfzgBu76qIMWsyLdlFnb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZNemvJ0muvsbAoek6dFx1jSip0UtZkOA7naMla327yDF0T7tfMtuxVImjnIjdP5L7X2rL++Ndgo2gxbbE/o0E6LKCRktBmrcCQrhOGE+N//dhLM3fA0jbzoXHNZgPNhKsSbhcrf14dB8X/gu/w1J+wsN5RqUSfyZhP7UDfeVXa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hVqlaFJy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TiczrR++; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hVqlaFJy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TiczrR++"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D13D91400133
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:26:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 04 Jun 2026 07:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780572367;
	 x=1780658767; bh=wEkiRm1Rhgd8cf6gYofQ2RuPYHfZh45nToAbwuPnJN0=; b=
	hVqlaFJyh7UuSfyyYMGA95wnPQf7Z2MTtUZ89qqItFOstx9/e2Jbxq+mXW65xyJR
	mJk53wQugEcNx2xXgKN6Ot3pmcBLIOfx52s8xpK6dx4es1mPpCiMFf5TeHQb18ca
	35QYLTf+Ocvjp3rIQywaHp+K5KkZHVOPG3x2CmeDkV3Sz8u2sh5pyA45yd9OELHK
	gdo+34JE0Bd84t/tMrwhFxza9q5jRvZSV7WSZV6/LCL+npS6Ss4LGJrJvfGqACJT
	3dEYqu+FzhQJQ5/P4e/6bGuQWMnTmd8sx3Z65th+ADFd9UwGPpddTWiUrprnGQ/2
	GP2oZi1XGsiGrZlGwD9kog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780572367; x=
	1780658767; bh=wEkiRm1Rhgd8cf6gYofQ2RuPYHfZh45nToAbwuPnJN0=; b=T
	iczrR++2NPGnOkLoCWRJg+ag2n2Cimm7SE/FE0rMkJ+1/AXc0KF11VzbnL8kOAiM
	c7CLNmEN2IKDvPJWXPoMP6E2C4jxoHphQ4VBdW6NcMpCNwBsmz2YnKVCWAy+Tq2n
	p4JE+fPghhVMumDrVSl2/x9WEN0v27Q/OhOBSxL70Vnby2ZMyegs59+lPrEEnJy4
	XDcbhAF7x2E9kzsTAXYBhe5ijPCkecQ5S/0bpcznkgg6yQslZbKVe9gvjNH3OpXK
	T7rgxMz7zZs5ocMRLY2jKF0Wlw1wYAYljsfcfyrFvLcSmVKCoYC30JDGWLL0tcuC
	1NMr7oJZLr+qhb5xmUSdQ==
X-ME-Sender: <xms:z2AhatVmaVGHaEO5yPOkKbhaxP091YGA5Yu7ZUy3ZxDps1d3Tu9qRw>
    <xme:z2Ahakg7QIUIqpu76XdOLiFPnNQatpc4VO-iRxdr-8qXCGij19vnlYhxShSG8ej1r
    yUJg7zWMqul8re4qYALGh8vjJgJQBbhb-aofyPfKY5cfwPJiVA_qg>
X-ME-Received: <xmr:z2AhavBYHgT97ZKmJZG_fGj2LC4fvKjRJzNYzmKnUJYXNYllIJ9R649wGW4TPupleL-BT2SL63VERQcLvU41qAVfLeTzMDPSsfDNqpBhBYY>
X-ME-Proxy-Cause: dmFkZTEgCyScvAHJZtwScmArpd3MPVD65pRFEMle7OxDyvGrBgzCBJpJZt/i/e/55qfMB2
    OZ+A4mOijyyVR7BQZ8gApb6Lys3WwA/DRBZO1Z6gq18/NjHv9k/YmqxGulaGbdjpGbGIe8
    TR7oy8jORNRJjZkYPAiPkwIOcJg76HwsAVLzInKh/aA4zWo5I7a3yFoBSrwplR1bXvqyzb
    7cwWjx66LW0j/HaZcKLdC3JWI1rUB6+uoj5Ia8HwsvfkXaZepnJEy9rr0yADWxKwm6t/hJ
    h4TWvBlU4kw/rB+rZbM4p/EdiFJ50OcReCBplYqL1Hq7W/DA0KsY8Jaj3WslUYFsjaCmHO
    m3H4qfBLJsqLTGWBEMUOrTDf89Q+TqQn3ve3xgwcXOKM+HM83181t5qv5rgQQp2smrFbLQ
    nJHp+UH25jLYfWDoGS5fFG8lbB0vyjjtHweNBuVX5ogOVOY6Ml7MIEKVuTOlrVUw+Tk9Ms
    od2/kvkF7CxgjM30W52zmt77i/gD90UdLCLMzTZiFVDIsQk0dTSG8fHxgI21QOuxPswgdM
    lf9JzZT0GnSES7uGk3zZXON0a7vJH461u10tgIhWsO+SWw78kvWzOUu/xxNUbP+RMbQMer
    Q5wuOZ73MUbyJURDrimrJRqXe6n60aXpVA7lxP/Cc1wY+r5FnMVa0RcOFjsQ
X-ME-Proxy: <xmx:z2Ahalf_iIqXhmZSiVmAFPYS9rUhM35ehlFjkAcchJDACxoKdj6vGw>
    <xmx:z2AhanfXFYlOxJSHcoVi8YQAvv_xVi0pNDiC9V9vPXa8fTCP5KTZGA>
    <xmx:z2AhapiUQJPOWhtiaDTAp3SGpuc9opPa1GGcp1dIuUiIqM3VyhTzzQ>
    <xmx:z2AhajTeHpOiBIwiX3sFkL_8wLZp9S-N83hvrK5dO1afqlHofwxWEw>
    <xmx:z2AhaonSJ_RBBc16CH5SN_cn8dZNvGzGZm9bYMDFlRz0Hw_ZCCrvc-p6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Jun 2026 07:26:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c85bc7ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Jun 2026 11:26:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 13:25:38 +0200
Subject: [PATCH 11/16] odb/source-packed: wire up `count_objects()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-odb-source-packed-v1-11-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
In-Reply-To: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Move `packfile_store_count_objects()` from "packfile.c" into
"odb/source-packed.c" and wire it up as the `count_objects()` callback
of the "packed" source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  |  2 +-
 odb/source-packed.c | 34 ++++++++++++++++++++++++++++++++++
 packfile.c          | 31 -------------------------------
 packfile.h          | 10 ----------
 4 files changed, 35 insertions(+), 42 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index c73a7e5f90..274923e0ba 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -103,7 +103,7 @@ static int odb_source_files_count_objects(struct odb_source *source,
 	unsigned long count;
 	int ret;
 
-	ret = packfile_store_count_objects(files->packed, flags, &count);
+	ret = odb_source_count_objects(&files->packed->base, flags, &count);
 	if (ret < 0)
 		goto out;
 
diff --git a/odb/source-packed.c b/odb/source-packed.c
index a61c809c8c..013d8a50f8 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -338,6 +338,39 @@ static int odb_source_packed_for_each_object(struct odb_source *source,
 	return ret;
 }
 
+static int odb_source_packed_count_objects(struct odb_source *source,
+					   enum odb_count_objects_flags flags UNUSED,
+					   unsigned long *out)
+{
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+	struct packfile_list_entry *e;
+	struct multi_pack_index *m;
+	unsigned long count = 0;
+	int ret;
+
+	m = get_multi_pack_index(&packed->files->base);
+	if (m)
+		count += m->num_objects + m->num_objects_in_base;
+
+	for (e = packfile_store_get_packs(packed); e; e = e->next) {
+		if (e->pack->multi_pack_index)
+			continue;
+		if (open_pack_index(e->pack)) {
+			ret = -1;
+			goto out;
+		}
+
+		count += e->pack->num_objects;
+	}
+
+	*out = count;
+	ret = 0;
+
+out:
+	return ret;
+}
+
+
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
@@ -549,6 +582,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 	packed->base.read_object_info = odb_source_packed_read_object_info;
 	packed->base.read_object_stream = odb_source_packed_read_object_stream;
 	packed->base.for_each_object = odb_source_packed_for_each_object;
+	packed->base.count_objects = odb_source_packed_count_objects;
 
 	if (!is_absolute_path(parent->base.path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
diff --git a/packfile.c b/packfile.c
index 95136b050b..5cb14b28de 100644
--- a/packfile.c
+++ b/packfile.c
@@ -949,37 +949,6 @@ struct packfile_list_entry *packfile_store_get_packs(struct odb_source_packed *s
 	return store->packs.head;
 }
 
-int packfile_store_count_objects(struct odb_source_packed *store,
-				 enum odb_count_objects_flags flags UNUSED,
-				 unsigned long *out)
-{
-	struct packfile_list_entry *e;
-	struct multi_pack_index *m;
-	unsigned long count = 0;
-	int ret;
-
-	m = get_multi_pack_index(&store->files->base);
-	if (m)
-		count += m->num_objects + m->num_objects_in_base;
-
-	for (e = packfile_store_get_packs(store); e; e = e->next) {
-		if (e->pack->multi_pack_index)
-			continue;
-		if (open_pack_index(e->pack)) {
-			ret = -1;
-			goto out;
-		}
-
-		count += e->pack->num_objects;
-	}
-
-	*out = count;
-	ret = 0;
-
-out:
-	return ret;
-}
-
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
 		unsigned long len, enum object_type *type, size_t *sizep)
 {
diff --git a/packfile.h b/packfile.h
index 210650923f..9f5b5c145a 100644
--- a/packfile.h
+++ b/packfile.h
@@ -153,16 +153,6 @@ enum kept_pack_type {
 	KEPT_PACK_IN_CORE_OPEN = (1 << 2),
 };
 
-/*
- * Count the number objects contained in the given packfile store. If
- * successful, the number of objects will be written to the `out` pointer.
- *
- * Return 0 on success, a negative error code otherwise.
- */
-int packfile_store_count_objects(struct odb_source_packed *store,
-				 enum odb_count_objects_flags flags,
-				 unsigned long *out);
-
 /*
  * Retrieve the cache of kept packs from the given packfile store. Accepts a
  * combination of `kept_pack_type` flags. The cache is computed on demand and

-- 
2.54.0.1064.gd145956f57.dirty

