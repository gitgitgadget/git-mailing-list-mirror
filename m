Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6D8316905
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155920; cv=none; b=hfa3dw8SzAGTLbggVKe0E669YgkfdNPYhkrclbHnnStbxUJxm/OWH7v6Go8q9uSVgeHCN46t3YF1Sr9jPVmpt/Rc+sX8xmedtkTjdsR5aexDYEtjhPyFqi27gKREKDovsEqTaOvua6WwYubjkDTGViibfDZGroIlPPSFT/9nc+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155920; c=relaxed/simple;
	bh=9km4RxKCPiHlf4DaXQyEp3Pb8+qbykPpZ8g0jjNPMjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LL/hOl+ykRY7djhYxgWrQ4F5P+TthKqRbkxbaXdv2CGOifqRBpvZSzdH3mSQ3Qw0Z9URiuuJL1amNxvfbtcZiSjs/IrM+vJHSOB6QYmcTsiYiE9FPEAn3TfQM4u7R4pWQFnqid5bFJ77adxBzEfmis8PArwI7RTXyD4abDhX5IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y21bWKeD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nLgGMQOw; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y21bWKeD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nLgGMQOw"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8EF8914001D8
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:18:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 10 Mar 2026 11:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773155918;
	 x=1773242318; bh=Al1IZkpZhDfhZrgqW77iEjs2gbhUJFvSs3XjPiH+6gc=; b=
	Y21bWKeDwgayZ5GgDkU/XfGxzQ9FLMDOqpoRXJUmb+LA+ylsugnSnlcI1XIdyMts
	JkWS7NtRBluNHll6CapIa8pyckBUqu+Q0rC16opnY0A3XBo2ge73oiTlxJXaqI1K
	qckqKLDIjDv5Exx7KafVm9Ws2Oq8pfzRIjLabFwQ8d30bbZDKcY/+/wE/LEZhKpv
	ddJFpJ6VeoTAPIvq5cj2qOBmVlI8+qXzG50ASsN44TgK4NrNiit5JiaFcGgtNbnp
	i9jiVwREgCHPoL2QORw1nn45xgxkl+CU4cy3OyXk5JdHwByQYMFvgU3Iysvs7GAD
	1G4emkc4QciY9wjlGDWqdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773155918; x=
	1773242318; bh=Al1IZkpZhDfhZrgqW77iEjs2gbhUJFvSs3XjPiH+6gc=; b=n
	LgGMQOw9M24u7JDhlytKcBqALWQi3JxUXX8Fd4ogQ6r5rWmik8WYRn4Lni8hlqHX
	RG7vzUT/sQda6O9skcjlXxrAlrmastISbyu5sGGjUrvrfKolbgA02xJw1lRyp0yN
	Gje+N9aePBJH3ZlAC7WKRoADWzZ4bGnfG9BKkNV8TLM8y1XabV306OJ2mzwKCRwp
	kK627wSu8TTp705MsD5fPONig7UPk70YYviAhI/pxdEElIT22DlJlckjrBLrV2iA
	uBY7N9/cgmmm5AE0YoSDcd3+XHbo5Dn90wQSRqZgpJLIwp9bdarc+vKx/auXLCaJ
	AfIysTampeoF8ZOuBpcyA==
X-ME-Sender: <xms:TjawaUoU055rqcUWioTUWNqcJU0VaaXXUfbwEeMKSnr-E3-VMxTH-Q>
    <xme:TjawaRk08spNmQUBBLYyMZxzaM8DAbu0JtC7Kv1qLU5MZSwldAU2VtmSnBWwTNLIl
    z4ni6vCgObe3pQIh5JK6Y-8JWuf7zbVU_R48CTNMFtHUmPFV3tXEQ>
X-ME-Received: <xmr:Tjawae0PHTVc0rOgJd4N3N5kCDerKqfCZSCnP5JLyPfWQ9B9A18ZoW3q_QWB2VlJsJcYwczbPbbO05KuJ_GXDz4Qyti7fusrF7eB0TVi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:TjawaRA3oFayHPB4VzdNDFVxulJdpfbpmLPz5FDojDrU0znKnbYOwQ>
    <xmx:TjawaTzHlBfmsdYYBtf6yzacn78R1EkHLE7wvmDfDsC4qqNCuWDldA>
    <xmx:TjawaXmpUyrymr6FZMSUwnk1PU4arI7ulHxLLzjA9gbJKF_M5lKZEA>
    <xmx:TjawaQHobGhdodZCAgju_RB0Ydun2-X5VnLg8VL5NqP_EeU163k65Q>
    <xmx:TjawaYJqUJQH9B1JQv4f8BUTZXj9CgYzC9BBE4gifz8Dk6_FCF4-0BYC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 10 Mar 2026 11:18:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd2b47d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 10 Mar 2026 15:18:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 16:18:25 +0100
Subject: [PATCH 5/6] odb/source: introduce generic object counting
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-pks-odb-source-count-objects-v1-5-109e07d425f4@pks.im>
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
In-Reply-To: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Introduce generic object counting on the object database source level
with a new backend-specific callback function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 30 ++++++++++++++++++++++++++++++
 odb/source.h       | 27 +++++++++++++++++++++++++++
 packfile.c         |  4 ++--
 packfile.h         |  1 +
 4 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 14cb9adeca..c08d8993e3 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -93,6 +93,35 @@ static int odb_source_files_for_each_object(struct odb_source *source,
 	return 0;
 }
 
+static int odb_source_files_count_objects(struct odb_source *source,
+					  enum odb_count_objects_flags flags,
+					  unsigned long *out)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	unsigned long count;
+	int ret;
+
+	ret = packfile_store_count_objects(files->packed, flags, &count);
+	if (ret < 0)
+		goto out;
+
+	if (!(flags & ODB_COUNT_OBJECTS_APPROXIMATE)) {
+		unsigned long loose_count;
+
+		ret = odb_source_loose_count_objects(source, flags, &loose_count);
+		if (ret < 0)
+			goto out;
+
+		count += loose_count;
+	}
+
+	*out = count;
+	ret = 0;
+
+out:
+	return ret;
+}
+
 static int odb_source_files_freshen_object(struct odb_source *source,
 					   const struct object_id *oid)
 {
@@ -220,6 +249,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.read_object_info = odb_source_files_read_object_info;
 	files->base.read_object_stream = odb_source_files_read_object_stream;
 	files->base.for_each_object = odb_source_files_for_each_object;
+	files->base.count_objects = odb_source_files_count_objects;
 	files->base.freshen_object = odb_source_files_freshen_object;
 	files->base.write_object = odb_source_files_write_object;
 	files->base.write_object_stream = odb_source_files_write_object_stream;
diff --git a/odb/source.h b/odb/source.h
index a1fd9dd920..96c906e7a1 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -142,6 +142,21 @@ struct odb_source {
 			       void *cb_data,
 			       unsigned flags);
 
+	/*
+	 * This callback is expected to count objects in the given object
+	 * database source. The callback function does not have to guarantee
+	 * that only unique objects are counted. The result shall be assigned
+	 * to the `out` pointer.
+	 *
+	 * Accepts `enum odb_count_objects_flag` flags to alter the behaviour.
+	 *
+	 * The callback is expected to return 0 on success, or a negative error
+	 * code otherwise.
+	 */
+	int (*count_objects)(struct odb_source *source,
+			     enum odb_count_objects_flags flags,
+			     unsigned long *out);
+
 	/*
 	 * This callback is expected to freshen the given object so that its
 	 * last access time is set to the current time. This is used to ensure
@@ -333,6 +348,18 @@ static inline int odb_source_for_each_object(struct odb_source *source,
 	return source->for_each_object(source, request, cb, cb_data, flags);
 }
 
+/*
+ * Count the number of objects in the given object database source.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+static inline int odb_source_count_objects(struct odb_source *source,
+					   enum odb_count_objects_flags flags,
+					   unsigned long *out)
+{
+	return source->count_objects(source, flags, out);
+}
+
 /*
  * Freshen an object in the object database by updating its timestamp.
  * Returns 1 in case the object has been freshened, 0 in case the object does
diff --git a/packfile.c b/packfile.c
index 1ee5dd3da3..8ee462303a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1102,6 +1102,7 @@ struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *stor
 }
 
 int packfile_store_count_objects(struct packfile_store *store,
+				 enum odb_count_objects_flags flags UNUSED,
 				 unsigned long *out)
 {
 	struct packfile_list_entry *e;
@@ -1146,10 +1147,9 @@ unsigned long repo_approximate_object_count(struct repository *r)
 
 		odb_prepare_alternates(r->objects);
 		for (source = r->objects->sources; source; source = source->next) {
-			struct odb_source_files *files = odb_source_files_downcast(source);
 			unsigned long c;
 
-			if (!packfile_store_count_objects(files->packed, &c))
+			if (!odb_source_count_objects(source, ODB_COUNT_OBJECTS_APPROXIMATE, &c))
 				count += c;
 		}
 
diff --git a/packfile.h b/packfile.h
index 1da8c729cb..74b6bc58c5 100644
--- a/packfile.h
+++ b/packfile.h
@@ -275,6 +275,7 @@ enum kept_pack_type {
  * Return 0 on success, a negative error code otherwise.
  */
 int packfile_store_count_objects(struct packfile_store *store,
+				 enum odb_count_objects_flags flags,
 				 unsigned long *out);
 
 /*

-- 
2.53.0.880.g73c4285caa.dirty

