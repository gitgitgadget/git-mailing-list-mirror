Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18D41A2C0E
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677364; cv=none; b=JnWlUHu83TTEnKpjFDODXHMaVzrdZR0zPgB6skIogyyeSa2o1FZm3Wvv+g97FIVYr+bWvLV2Ph4qaNbj9mzuv62ZMhzO+QlVEcGB3oqXPGEjAPczeXmSjWFRy3HB64EBA9Jc1iCfdNDaD1kp7fwWlhPZX/ByvB1ruUB7UP3lE6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677364; c=relaxed/simple;
	bh=jSqZnhrpGlgUpYW0OjxKjx4GyOcliOxuDr4zmHHwVKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+aJTbtPZNKPFnSBYy5O74K1IBstqee+Wpw1yb1t7INFtEXMxlTHo1VCNm0L1sGApQS8ytIt5Hq21B8FFsZMVGeIVNfbT9nfbsbe+QwiGcaa4II/vRbMnVZ4V9W8wqCglHW1fto9u6AJB+dQRLnIyo2FljsIlTHcqC7Ww1QEifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e27Og9Fe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ebTF4y/w; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e27Og9Fe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ebTF4y/w"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 18F9113800E4;
	Wed, 23 Oct 2024 05:56:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 23 Oct 2024 05:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729677362; x=1729763762; bh=GRZxOjyw+a
	GTiMxB8yKA5+hY+H3Yg+ZNigUod2shHEk=; b=e27Og9FerEBAVw315dxTAju68/
	SC9qPkXw8FCwF2jm2LswmFV9poeOvgxJ9npEmbdrmyCoKUxaomkpxmskIfN557go
	xR7EEfyAxP6DTyUjet+rVtkxlUlG5c4hwpC6UwhY9bY5BsnrTLe3fo/E+h/l5Heu
	lDU9ijbnrfXetPfyJV/7lAtJR/L4COdlOL7ttl42HtXw4+56m0zPIDuSIoxKvxhU
	JW0Vi1NSO+njm5+9uveqXwIAVUBTUST2LDmq0J/otzbSRryZkMoPz0D8A9sdZnA4
	LDmUw8Yy3Qw1m3te3dwVCRafP6zacdXou/sU2+vEuOyw1gF/p6OtfBMlxISA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729677362; x=1729763762; bh=GRZxOjyw+aGTiMxB8yKA5+hY+H3Y
	g+ZNigUod2shHEk=; b=ebTF4y/w962Krt99lR0wVbJb+D3nnXfvwv2BoAVz2CC9
	yK6dmJvaz+AthT+vOce7plFo+nrMW58t7kgk+0LIYxd1tHM9EOMmHeZLbaQAHHZE
	hXDwu3xhZcV2DKKUAAHm6C/tzlNiF9RvkKMZhI3dvxqhwoHA2wqVgDDb0x//k297
	K0NvwYt0t8TI3OgFdvqYC/nvJL+ihYB93q5FbzoG/k1GRkqxtpFYnw6p2Fj3xkp/
	hwiR4zw1FDpWaFxjudDooCA/fGbDt9RFq6QMmXT9AjGzof4QQ0zYCNQI3gBmNxz8
	g2A3rEhNpim2aZ2+t+P9rCNz1H2pORUBgXk0jscrWw==
X-ME-Sender: <xms:McgYZxAiJzKTPW6WQlYdrGC6bsOSoOQWKCItW_CMZUTsoG6OfW-36g>
    <xme:McgYZ_j8-REvYzO594uAmGJpOrBfPVWSQFUt-uodNXhlWunFh25NrpRNrwUaAbuA4
    Oj1h2EcgB4JHwpr2w>
X-ME-Received: <xmr:McgYZ8ndt3z1MAOX2n7udDndGAmmG98AZ4ACVQBwP4bOKRnM8LIlDoFBLh_2ezTGNYyz10dC_tV5iQSBujbfvfCdQ0Evxy0jhO4EnUAwQl41>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:McgYZ7xwu1N-8V3OpCKyucAqOb9aKOFYa8Ef_pWjq_QvJhjocslujg>
    <xmx:McgYZ2Ssqz-jYCOf-pPsbWy16AmD1cXE87L0qXdt8KhC56Qsaz3l4w>
    <xmx:McgYZ-baEH5o0LE_SmrNRGjEImmqJ1uV-siYaSiwWuImEai291ALLw>
    <xmx:McgYZ3RpfYQxYmqWaZRA35jpCH8QjMg6r18pBmc6_NTcol7xQHPV6g>
    <xmx:MsgYZxdicpjT7cECw9aoypGo0kSD7VzixAiLzZkAZMjAuRpwQn1jEG4g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 05:56:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8e957251 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 09:54:29 +0000 (UTC)
Date: Wed, 23 Oct 2024 11:55:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 2/7] reftable: explicitly handle hash format IDs
Message-ID: <c1bd8e2b3c4c524a21f68e822812e41179827e4d.1729677003.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729677003.git.ps@pks.im>

The hash format IDs are used for two different things across the
reftable codebase:

  - They are used as a 32 bit unsigned integer when reading and writing
    the header in order to identify the hash function.

  - They are used internally to identify which hash function is in use.

When one only considers the second usecase one might think that one can
easily change the representation of those hash IDs. But because those
IDs end up in the reftable header and footer on disk it is important
that those never change.

Create separate constants `REFTABLE_FORMAT_ID_*` and use them in
contexts where we read or write reftable headers. This serves multiple
purposes:

  - It allows us to more easily discern cases where we actually use
    those constants for the on-disk format.

  - It detangles us from the same constants that are defined in
    libgit.a, which is another required step to convert the reftable
    library to become standalone.

  - It makes the next step easier where we stop using `GIT_*_FORMAT_ID`
    constants in favor of a custom enum.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.h |  7 +++++++
 reftable/reader.c | 10 ++++++----
 reftable/writer.c | 16 +++++++++++++++-
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/reftable/basics.h b/reftable/basics.h
index 7aa46d7c30d..86141602e74 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -150,4 +150,11 @@ int common_prefix_size(struct reftable_buf *a, struct reftable_buf *b);
 
 int hash_size(uint32_t id);
 
+/*
+ * Format IDs that identify the hash function used by a reftable. Note that
+ * these constants end up on disk and thus mustn't change.
+ */
+#define REFTABLE_FORMAT_ID_SHA1   ((uint32_t) 0x73686131)
+#define REFTABLE_FORMAT_ID_SHA256 ((uint32_t) 0x73323536)
+
 #endif
diff --git a/reftable/reader.c b/reftable/reader.c
index 90dc950b577..64eb6938efe 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -109,16 +109,18 @@ static int parse_footer(struct reftable_reader *r, uint8_t *footer,
 	if (r->version == 1) {
 		r->hash_id = GIT_SHA1_FORMAT_ID;
 	} else {
-		r->hash_id = get_be32(f);
-		switch (r->hash_id) {
-		case GIT_SHA1_FORMAT_ID:
+		switch (get_be32(f)) {
+		case REFTABLE_FORMAT_ID_SHA1:
+			r->hash_id = GIT_SHA1_FORMAT_ID;
 			break;
-		case GIT_SHA256_FORMAT_ID:
+		case REFTABLE_FORMAT_ID_SHA256:
+			r->hash_id = GIT_SHA256_FORMAT_ID;
 			break;
 		default:
 			err = REFTABLE_FORMAT_ERROR;
 			goto done;
 		}
+
 		f += 4;
 	}
 
diff --git a/reftable/writer.c b/reftable/writer.c
index fd136794d5a..9aa45de6340 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -103,8 +103,22 @@ static int writer_write_header(struct reftable_writer *w, uint8_t *dest)
 	put_be64(dest + 8, w->min_update_index);
 	put_be64(dest + 16, w->max_update_index);
 	if (writer_version(w) == 2) {
-		put_be32(dest + 24, w->opts.hash_id);
+		uint32_t hash_id;
+
+		switch (w->opts.hash_id) {
+		case GIT_SHA1_FORMAT_ID:
+			hash_id = REFTABLE_FORMAT_ID_SHA1;
+			break;
+		case GIT_SHA256_FORMAT_ID:
+			hash_id = REFTABLE_FORMAT_ID_SHA256;
+			break;
+		default:
+			return -1;
+		}
+
+		put_be32(dest + 24, hash_id);
 	}
+
 	return header_size(writer_version(w));
 }
 
-- 
2.47.0.118.gfd3785337b.dirty

