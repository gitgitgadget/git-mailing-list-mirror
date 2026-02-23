Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5154D30F92D
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863533; cv=none; b=apUVAf5YYrTyEW7/gySYyexM0vjjt0ol0X+Pyk+wQtr2oZhv4DGk6NbokzCGBfb9+TdICLcw97wsTS6aIn/7ZfUB+fy//WsDszfOyPcg8PX0Zt0fL/XNc7p8ArzqgpuIS8l2KACUCctx3dlFnpTQWr0ZMg3MvcCwffN0RM34N7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863533; c=relaxed/simple;
	bh=Os1JsHZsgpt77+whP2I8y8RZwR3I2v7lkDt26Z3kFYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LaJdTrNfGZtxzaWOVCFI/RhLJ1EI0UsRyL1lNC6YlgolmVKXnvxrPG6vjN4fgvZg6Cr/bUCUl/Ou4WB8cgwS+m1m0EwhH+ah11g7YXyOHOmAg2uyT3YpmcMuaEwShQGSRoU0Ue5odZrWGBQARnA/Ux5iIdB7F/oF8GYibNZmh18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IvcrF31S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JXs/Ybnz; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IvcrF31S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JXs/Ybnz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 94308EC05A7
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:47 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Feb 2026 11:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771863527;
	 x=1771949927; bh=dcUVMBnukyzS3pp1Q1xZ5fnZCdo1Ak/qDR6oFJMXxqI=; b=
	IvcrF31SoLyLiD8Z3JjrrwfHEuCcynJQ7J0pMOE+vq7723ewbaQNbcB+A2zOiwKS
	xm32b5OI2Jklg6NCA9wN5ojlRctX4z9NPB74t1DOuUw0ub0ZZjq7Q4K/4ZHG1tr0
	GAy5GROeQ/Cv7HaXSlg0jzM6NVSg41DVAiXjpf5ezJzdT6eadb4lkm0cyMm25OOB
	S2GDw36Py0mgRjKWiSleUJnOSlm+mrFM3uazb17Qo65Oo4W0slJbUZD24Yqfv9rC
	s7tkH05MW+9wrpuFhaPvxa5aea85fohOuDTWSU32lrVp/xdNoSOepz7nJyAEUvvd
	GkFmbTCLtu+lLZrgNW/D3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771863527; x=
	1771949927; bh=dcUVMBnukyzS3pp1Q1xZ5fnZCdo1Ak/qDR6oFJMXxqI=; b=J
	Xs/YbnzihTPh4O/QnR13Z1T0xEPxwBCzMLxszilzowLVaxGBlKxM/Q+LMu0wpD50
	eR7mRHblc8JNpwTlk8hpgLGmoXEA1m8fPXnu8PdsFFDWqBPg2sf6oPisiS7imlkx
	SioQyfV41vMA17V2+mWFfgQuSsd2fR1OC94DRlBiAfYILq8SEp1P4Wouy5bT2adr
	A6ppPbzFePML9HKR52haZykZSC4YOMM2iCHjAi/ysp/6Rr16ANV3w8JGnwKz9crr
	9pYdhLWEE3fJQ+2zazjknXsOovKWl4H8cUlicvrmM3H3B78I8SIOAY+fbpmkMSO2
	kMsCbbKQWfFDOVTTUJxjQ==
X-ME-Sender: <xms:532caWCrr_GAM1Kxewg3Hs872rlxw8AxAOSG1DqXz0dj39FjULotmg>
    <xme:532caXdM5J6BVkbdqxj6QUOFMlPL0eUb15MymEdqjaNbBBfY5yY6dXTVQeOfvREeT
    q5zD_6T5QiBsRAnm7-9YEdUNZhbWCAWl7Actfyq0AbnmzJScl5uiA>
X-ME-Received: <xmr:532cafPjve_UMDjzjHprWIaKI0cAi7EdCSyAHklHeQfHzOU3q39NmpircuG28HYBfZPEkEVOCx-QhDOaR3QB2P7apxKkjjKlHfeiTYb7tQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:532caZ7hH_WkvCzaM0U5huZoevmT1499K5uHDuQf8pMxUoNhpuPvWw>
    <xmx:532cabL5E6Zit9Y6GEyQ7HmILEAJ_9Y5r2N6c4T4qd7z2-1b-jbCTw>
    <xmx:532cabcpmvZaEms6VnmXBxyr5CePEQSjhS26YEZoavnyVyKlHh76kw>
    <xmx:532caWc20bYXxNF08Bepav_a02ZT_lmkDy-GL2YrFcXZ0EFLkpo3Eg>
    <xmx:532caZDUZ1qFWzj9ffkEv9O7ydFrWN4KUhhMAED9Foqy4msruYAOaGEP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 34bdba21 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 23 Feb 2026 16:18:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:18:05 +0100
Subject: [PATCH 14/17] odb/source: make `write_object_stream()` function
 pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-b4-pks-odb-source-pluggable-v1-14-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c              |  2 +-
 odb/source-files.c |  9 +++++++++
 odb/source.h       | 28 ++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/odb.c b/odb.c
index 5eb60063dc..f439de9db2 100644
--- a/odb.c
+++ b/odb.c
@@ -1013,7 +1013,7 @@ int odb_write_object_stream(struct object_database *odb,
 			    struct odb_write_stream *stream, size_t len,
 			    struct object_id *oid)
 {
-	return odb_source_loose_write_stream(odb->sources, stream, len, oid);
+	return odb_source_write_object_stream(odb->sources, stream, len, oid);
 }
 
 struct object_database *odb_new(struct repository *repo,
diff --git a/odb/source-files.c b/odb/source-files.c
index 67c2aff659..b8844f11b7 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -109,6 +109,14 @@ static int odb_source_files_write_object(struct odb_source *source,
 					     oid, compat_oid, flags);
 }
 
+static int odb_source_files_write_object_stream(struct odb_source *source,
+						struct odb_write_stream *stream,
+						size_t len,
+						struct object_id *oid)
+{
+	return odb_source_loose_write_stream(source, stream, len, oid);
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -128,6 +136,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.for_each_object = odb_source_files_for_each_object;
 	files->base.freshen_object = odb_source_files_freshen_object;
 	files->base.write_object = odb_source_files_write_object;
+	files->base.write_object_stream = odb_source_files_write_object_stream;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index a6ef7f782c..ddce43eb20 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -54,6 +54,7 @@ enum object_info_flags {
 struct object_id;
 struct object_info;
 struct odb_read_stream;
+struct odb_write_stream;
 
 /*
  * A callback function that can be used to iterate through objects. If given,
@@ -216,6 +217,18 @@ struct odb_source {
 			    struct object_id *oid,
 			    struct object_id *compat_oid,
 			    unsigned flags);
+
+	/*
+	 * This callback is expected to persist the given object stream into
+	 * the object source.
+	 *
+	 * The resulting object ID shall be written into the out pointer. The
+	 * callback is expected to return 0 on success, a negative error code
+	 * otherwise.
+	 */
+	int (*write_object_stream)(struct odb_source *source,
+				   struct odb_write_stream *stream, size_t len,
+				   struct object_id *oid);
 };
 
 /*
@@ -351,4 +364,19 @@ static inline int odb_source_write_object(struct odb_source *source,
 				    compat_oid, flags);
 }
 
+/*
+ * Write an object into the object database source via a stream. The overall
+ * length of the object must be known in advance.
+ *
+ * Return 0 on success, a negative error code otherwise. Populates the given
+ * out pointer for the object ID.
+ */
+static inline int odb_source_write_object_stream(struct odb_source *source,
+						 struct odb_write_stream *stream,
+						 size_t len,
+						 struct object_id *oid)
+{
+	return source->write_object_stream(source, stream, len, oid);
+}
+
 #endif

-- 
2.53.0.536.g309c995771.dirty

