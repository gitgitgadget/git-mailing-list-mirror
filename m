Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0A730FC1D
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863540; cv=none; b=YYOZ2MoEJklDigWFtx501Rc11chi9reaEJGR7Q6u226HF5rPS6zdfF1NZPbr31hgtzhYJzBQCXxoQKXHzqKTRqr6e09qYyLGVjzixfSew68vJPI2u7mhDMoUE6xXo53FqW8oLrsiSyzO7vbdSPUfXbcWTUhEnxcZlKL0XUnnDw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863540; c=relaxed/simple;
	bh=opBskmlUkIzsYxxl+65L44/HP3teLa1Lj6yjMWfNEG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lo6v2LXW71GP9dgSn7vzqVFrm7VF8m54S8YsUOC8Q/ceuistqua7X8d33XJo2ys1HFZfxob83RqzcRK7UWpxzTYvcW6zyO34teINAeLsOCNip3X9PEk7x1ncbEnCwFWAxgL4y6N2EOCZoBkzTjV+nHeZ54h2hWO6PAcTwVpjpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J5oYQupQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aUSiOp3I; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J5oYQupQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aUSiOp3I"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C78EB14001B9
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Feb 2026 11:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771863535;
	 x=1771949935; bh=fr35Ig2URcRrSE2reABiA+pLkrShX877pIwfO/eUKX8=; b=
	J5oYQupQJsAvfp7uJjiz7wNCbAzsjdcFUbbvzc2cwGif/rReifA05uJmIGo4swOF
	rZrFlN+5QTDq0ga0ixgrdVl/O5W704bbEc+nQWVIbUMa64YEChGHPQljmEqp479x
	jzP9a3Uht4zke14coveWkbFgEVQCAxxziHwS2PRDx8bxT/2dVa1c7K8g8BJkCCGZ
	b921wuWWz3XyiKQ7nnJPxQp5kx0KgAo1OBMtnPzfjIGc/D7aCvgQv2JjNcwSoJyZ
	t6hFuo89yifPvsGGMVQlusx+dKDGWbtBMDF3aF+brsuSuvuQ70vawMC2Hp5jWFFV
	MBOIPqjxK0nV/1KhYv+sZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771863535; x=
	1771949935; bh=fr35Ig2URcRrSE2reABiA+pLkrShX877pIwfO/eUKX8=; b=a
	USiOp3IZVos7CAw56qslaHgvlsCVnW3u8/wOyu7YU+SHelg8flwO5610izfzLI6+
	bvBZbI/wlAzjPY+XDvDv2WqVOWv3E+lEaF0U8MkF7qFLoRBPEv8371tqydG2/5pq
	iV2Ym3001DhtwCB98MCEvl/yHw2G31RnaC7o9Gc10yL7UTCKB8BqjyuLvyq9CfGJ
	N/9ypHWEeRrnxsQ9KjFcaGkZlG/zmIHMuaueMuiqxk/Sj9MGL+rr2n6nXp3U7QSF
	JMgpZGkBAVjPm3DbY8VbNhxMi1snrfz1UtPtLFoHex3GAaku7G9IKa5VF6ebqKj+
	lu4JCKdElH/Qk1LozwleQ==
X-ME-Sender: <xms:732caYtwpOe9_Ggg0x4O45DG9XK-oaKFDnT5l28xJqB2JgKFizpbzA>
    <xme:732cacbh5E7sK3EqzBbg9BhAxg0O1bT5EiwhcuB1K51RZAGN2rEkuKOLtZJfpADJi
    ZkyQkJskLynUzRaautptiI6qdRqRLGcyp35ixEA-WemnQNRONk2LA>
X-ME-Received: <xmr:732caZZw9oxPA-8FtNtwiXFcdz9365FdLueXFQ0k5ezc7J1I4QDHqEV1khgE0KqgH27adbWx6ufvXLR4UtVWYPVrLODXWg5PBmetMtbI_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:732caQU10rTrrxldQBx7BEvnr5s0T6YCCsjxi-4MmOmTj_vBsZBX4w>
    <xmx:732caY0G5LAYvHSDjWe-yM7DknwIV7OxjhbAPQ7n5vc6Qoydzh_O_w>
    <xmx:732cafZkoEAd3hVBydV41Jx1sNuUkLny_CiVGvl9BDrOGcjoIQvE7Q>
    <xmx:732caToKxxSMvMLviPTgPipBzCaUMVBIaNcL9SZTbiopTi7tRK4COw>
    <xmx:732cabfPAda2wiimiq5l4l33CWreEGeZP7pVjO0u-YmaZY3wJKBEMcFS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1a8c3696 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 23 Feb 2026 16:18:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:18:08 +0100
Subject: [PATCH 17/17] odb/source: make `begin_transaction()` function
 pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-b4-pks-odb-source-pluggable-v1-17-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 11 +++++++++++
 odb/source.h       | 27 +++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/odb/source-files.c b/odb/source-files.c
index c32cd67b26..14cb9adeca 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -122,6 +122,16 @@ static int odb_source_files_write_object_stream(struct odb_source *source,
 	return odb_source_loose_write_stream(source, stream, len, oid);
 }
 
+static int odb_source_files_begin_transaction(struct odb_source *source,
+					      struct odb_transaction **out)
+{
+	struct odb_transaction *tx = odb_transaction_files_begin(source);
+	if (!tx)
+		return -1;
+	*out = tx;
+	return 0;
+}
+
 static int odb_source_files_read_alternates(struct odb_source *source,
 					    struct strvec *out)
 {
@@ -213,6 +223,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.freshen_object = odb_source_files_freshen_object;
 	files->base.write_object = odb_source_files_write_object;
 	files->base.write_object_stream = odb_source_files_write_object_stream;
+	files->base.begin_transaction = odb_source_files_begin_transaction;
 	files->base.read_alternates = odb_source_files_read_alternates;
 	files->base.write_alternate = odb_source_files_write_alternate;
 
diff --git a/odb/source.h b/odb/source.h
index cf301679da..0e99052e08 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -54,6 +54,7 @@ enum object_info_flags {
 struct object_id;
 struct object_info;
 struct odb_read_stream;
+struct odb_transaction;
 struct odb_write_stream;
 struct strvec;
 
@@ -231,6 +232,19 @@ struct odb_source {
 				   struct odb_write_stream *stream, size_t len,
 				   struct object_id *oid);
 
+	/*
+	 * This callback is expected to create a new transaction that can be
+	 * used to write objects to. The objects shall only be persisted into
+	 * the object database when the transcation's commit function is
+	 * called. Otherwise, the objects shall be discarded.
+	 *
+	 * Returns 0 on success, in which case the `*out` pointer will have
+	 * been populated with the object database transaction. Returns a
+	 * negative error code otherwise.
+	 */
+	int (*begin_transaction)(struct odb_source *source,
+				 struct odb_transaction **out);
+
 	/*
 	 * This callback is expected to read the list of alternate object
 	 * database sources connected to it and write them into the `strvec`.
@@ -434,4 +448,17 @@ static inline int odb_source_write_alternate(struct odb_source *source,
 	return source->write_alternate(source, alternate);
 }
 
+/*
+ * Create a new transaction that can be used to write objects into a temporary
+ * staging area. The objects will only be persisted when the transaction is
+ * committed.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+static inline int odb_source_begin_transaction(struct odb_source *source,
+					       struct odb_transaction **out)
+{
+	return source->begin_transaction(source, out);
+}
+
 #endif

-- 
2.53.0.536.g309c995771.dirty

