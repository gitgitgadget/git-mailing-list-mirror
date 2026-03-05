Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EDB246BD5
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720436; cv=none; b=sbQg+5Z9xrwoOiWeHQHkGcTSOfC2sALps3ABtqziMyo7qPq2PuTtC3NNdygh8hsdVXMnMPDLL3+PLI/oOdjgR3AlrwvRvwRx9Dc1ZVTDmGoSx8UXc4ohLLtIKruQeDExKq0z3I7NzXpBiXD27s4EJhrSVyIWMWf9T0ZpxgEgCIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720436; c=relaxed/simple;
	bh=wYpL+3jmTUDOrYTBZRDBzBFALlwN5TphllovP85O6EA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G1xU4AZUDlDzDLpV5roRzX2qnp83wOuRrbTQxU6oZBworjRu/jo6xH4Z9MHtEMaROQ+LekwJxBx4/WcmjiyZb6ThDU/yC7mn9BqHwHpJ0889XZh3ytAI/SDmYjVqGjZNbrbS2Onep1m/zgtSw4/ui5FJXhPifMDRPxclbczDegY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SVryjKDj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UagDEe/p; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SVryjKDj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UagDEe/p"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CA2537A01E2;
	Thu,  5 Mar 2026 09:20:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 05 Mar 2026 09:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772720434;
	 x=1772806834; bh=0EGpbTsDi1x0UAj4I5k0vl3i8TqssWwl0fcHjw5t4A4=; b=
	SVryjKDjLXQtN4dAmynW9WaC1Ca7odm4/ontfAdmy+zS9IW1CCAWWg/5jnF1nT+t
	WGmSMm1+ZGji1Os7dBHDXZAClCzw2lfozd1NB1jFIDxmoA1Ouyf3MDMdQx9Xt7Gq
	7Z46j4kmiQTYBIqVN7cFC4uMcyWhf6VrAhio/T+d8pR0tkVm+INfYjKW4spfVgkp
	b15aOhqpEtQKTC2AnvBDnrJ8npa+qqeTGnmBM4XVoP4RBjeuHhScQCwFVI5rL9Fx
	yQuVoyMNZNYGPnRzrlAa3BX3ET6CPQbXeu6uJmapk94s2Expm810V+tbPcuUmR9Z
	t7axyOJnhu+ZWcsi68CzcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772720434; x=
	1772806834; bh=0EGpbTsDi1x0UAj4I5k0vl3i8TqssWwl0fcHjw5t4A4=; b=U
	agDEe/pyMSC5p1gE1gXn+UXBcFfJLysgZ3T7Z6lKyt41927zVgYSzMEItWSTZHEl
	fIpSPl1uLk5NYpnF1B+e2ftcVOTujdXhbuju1YXO7itKqwO3hMCYeBu6PC89PbHI
	dnbYo9wFV0Q9Z0s/W+KHU1aOjtDe7F7aSFd+5/sNTRFHsn2tmgyo1WmB+MsMJObu
	+tOaVhwTyniG1FXq7ak6PaLxXz4/9kQCgSccvsRq7Zl0sHyYoBTCiQgdAW8ymiSE
	Q1+o0qfxXUzZEOM9QTMq2cWb6gO1HGNZLsEoDLytM16AaaNpV6tdROViJKvDvATn
	VQwPOm1zH5RCpjdwviFYw==
X-ME-Sender: <xms:MpGpaXLfiCSvfkve7CMEU49f3VgBVt8MQrUU5ODaFiyNI6kn0aqbCA>
    <xme:MpGpaSJQTsNwqOa_GgiWtqZvOCr0en0aXdtVZH5zcNn4zZrHhzIPWp-2tXaBvNhby
    ENZoyPiFp8m-Yl6yE3oqwEwfpQmhGhhk6jfFY7jhYXhdeLzoc8>
X-ME-Received: <xmr:MpGpaUu4mE3f49ZaGvaS7xaPPpEFu3PW2JR9eOlAGDR9eoP2FSRKNEFejdU9jfhhhsZKekfY2QZm7q7D4f14Q3XKhchxGaqoSxGY5JFRjCNu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:MpGpafTn3QcUuuHxKCXEGVkoW6Ysjv9nIuj87cYONkd1BKQjtH-j6Q>
    <xmx:MpGpaaMwEtIbpcqMV5K3hJ1VEQu7g0NVkNVOvwonbRLza7B2qSTojg>
    <xmx:MpGpaUZ1S0hgPzfgTTFpaznrAg8QaGPdprJGip4IaALOvNDU9yYYZg>
    <xmx:MpGpaUzm8OvmaAcXi15V-govjQQkpJVjuQER40jejc4XIN1TMRqriw>
    <xmx:MpGpaUMKDrzvbrLqD-cGDHECf4gUEwfp99_kCihhqYdZn5KIgeYhvX96>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:20:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b3323ba4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 14:20:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Mar 2026 15:19:57 +0100
Subject: [PATCH v2 17/17] odb/source: make `begin_transaction()` function
 pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-b4-pks-odb-source-pluggable-v2-17-3290bfd1f444@pks.im>
References: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
In-Reply-To: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
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
index ee540630d2..caac558149 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -53,6 +53,7 @@ enum object_info_flags {
 struct object_id;
 struct object_info;
 struct odb_read_stream;
+struct odb_transaction;
 struct odb_write_stream;
 struct strvec;
 
@@ -233,6 +234,19 @@ struct odb_source {
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
@@ -438,4 +452,17 @@ static inline int odb_source_write_alternate(struct odb_source *source,
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
2.53.0.797.g7842e34a66.dirty

