Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475D61DE3D1
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022132; cv=none; b=RaEokSIDst2C1CZDjFxIQ1FD9dg8o79dkROMFRMqZYBvAzvvlwFCYIyGd6/PNFlVGG/mCqiYXd4pZxzr5HKS1skBwj3dgWoXLU/6xDT11yNNtLf8PgZ19LKvUZaQYEB88pOinLcjmBDV307/aSN/I1sVo+7te2MUgsuyaQQUWUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022132; c=relaxed/simple;
	bh=hMEtawmNW5xatGwNlod1H+JFCUgj5fLL+5qlgB2sbLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mqY5L4DHSp8dz7s60aA+Q3EGGj5X4/NK3B81D49ng55tBcB6XoNQvOcxvfc5p/bFZKSAqqBEu3CJvt0cPbiz22cFFV2jhztuGWwU7XL9jzCDtZI4valE6ffmYgWYfDTo1TpIK0/D1AMYTQUkWYYwijf74WdS4XM5L9/uDmjr2/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W9r6OI4C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VYTqGt78; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W9r6OI4C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VYTqGt78"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6771A1140160
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jan 2025 05:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737022130;
	 x=1737108530; bh=360nQlw5sv6tLNEvIDpc9RfCmud2VNdxYlfI8vAPrdo=; b=
	W9r6OI4C26qsr0VxnCUuz2TSnp0gOVgCiG4jbCp4arqMs8btIa3B9Xml5IAyn9nd
	CcDyYlXeubfUo3HO/mD2khMKBVkkjWEUqqMTknEJh663cEpjnsOt69EZ9pyw0oCn
	vDLb9CVa83mk3rsf2w98eptzGRHBO9xBA9qz8MYi1eFgm0stNEKdYe3b3Z3B/NMq
	RbGOJYXYZ7QBVRoy/NIrQpQsQI8ThE65ExZeYstyQm1EJR7GskJIi1W6X/yAc2Wc
	oePaOTxjybi8nodTIjiQy1e/F6q3w1BOPxzCay8TQtGMAK0OASCjBjxqC5Dr02NM
	dQwEL4usVgaksRRvStsxTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737022130; x=
	1737108530; bh=360nQlw5sv6tLNEvIDpc9RfCmud2VNdxYlfI8vAPrdo=; b=V
	YTqGt78HWZI71eK2W6XkXQ2fUnL6MnMnk7aXQnGA/a297qQMEQzQhPcW4ADfvJzk
	451OXaKhMytUMyLkLyeKX/V5N+5blt3wWvf5iO0p3Iz2ZHeLW+dAXxlMl6AlOtuV
	lllbljVmYWHbBWrZTLxPQmlmxnJCO1ZB5B1FVcRXuAOyRO3T1MFTrcbvcsv27jpH
	s5gQzX0RcK574cn+gFyUrRO7XJI5aZ+Nme+FA8TaQLiVxs6SnvvBoA5OP5cfB+81
	7Vjf/4cXJv7oVFpGNwy2Th6q00D34DOEbWzFrEav21p+hcAKcxDd8QjukTnN42+H
	I3yLjcpwe3if85ubEiizQ==
X-ME-Sender: <xms:stqIZ0TFmwjievJ6pbGGNTCq7yyqU3J0QXAFh_O__VfsJ_vyR0bs8g>
    <xme:stqIZxwyNLiGrCPuofwLv4BisXIOjXsaNLckAPJwd6d0TuuHu6wBKpv7cJtEiicfW
    RDSTLeNFCwETPVR8w>
X-ME-Received: <xmr:stqIZx3WbsQON_x5S4RVQMa-dXMXZ4vLH5k9lIKvEwrIArJwjV1g4mZ3UdnlJp7BI2IiF7ScaLEyd_KAPIcoOEqAe6F8lhRRGzK1lSJGUkrGcMKkag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:stqIZ4CkLgUQmWcXtvGEmCrO6712lEUGOn7ui7Tms2LBmjtUpIYoYQ>
    <xmx:stqIZ9jO6v5P79sHJmshLoLczC1p2EUGuMJVHFiEw9t1VVDmX8aM4g>
    <xmx:stqIZ0q-1v8dpGfHvC7VpI6--l5L6JLvqIzpRpRvS_N3kd2vRfwhQw>
    <xmx:stqIZwgTO-jZf9Zb3UvrZaiIJCST07tl-42Re4ITI1OuHOki1KVYZQ>
    <xmx:stqIZ9a_BQVh9GoWjn7cCrXZ-K6ea-KF72-4sv5uEG3Om3KpY5r2cXam>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 798aaab4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 Jan 2025 10:08:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 11:08:42 +0100
Subject: [PATCH 10/10] reftable: address trivial -Wsign-compare warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-b4-pks-reftable-sign-compare-v1-10-bd30e2ee96e7@pks.im>
References: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
In-Reply-To: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Address the last couple of trivial -Wsign-compare warnings in the
reftable library and remove the DISABLE_SIGN_COMPARE_WARNINGS macro that
we have in "reftable/system.h".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c |  7 ++-----
 reftable/stack.c  | 12 +++++-------
 reftable/system.h |  2 --
 reftable/writer.c |  2 +-
 4 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 0ce294078b..cff7564087 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -117,7 +117,7 @@ static int decode_string(struct reftable_buf *dest, struct string_view in)
 static int encode_string(const char *str, struct string_view s)
 {
 	struct string_view start = s;
-	int l = strlen(str);
+	size_t l = strlen(str);
 	int n = put_var_int(&s, l);
 	if (n < 0)
 		return -1;
@@ -556,7 +556,6 @@ static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
 	uint64_t count = val_type;
 	int n = 0;
 	uint64_t last;
-	int j;
 
 	reftable_obj_record_release(r);
 
@@ -591,8 +590,7 @@ static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
 	string_view_consume(&in, n);
 
 	last = r->offsets[0];
-	j = 1;
-	while (j < count) {
+	for (uint64_t j = 1; j < count; j++) {
 		uint64_t delta = 0;
 		int n = get_var_int(&delta, &in);
 		if (n < 0) {
@@ -601,7 +599,6 @@ static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
 		string_view_consume(&in, n);
 
 		last = r->offsets[j] = (delta + last);
-		j++;
 	}
 	return start.len - in.len;
 }
diff --git a/reftable/stack.c b/reftable/stack.c
index 531660a49f..5c0d6273a7 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -220,9 +220,9 @@ void reftable_stack_destroy(struct reftable_stack *st)
 	}
 
 	if (st->readers) {
-		int i = 0;
 		struct reftable_buf filename = REFTABLE_BUF_INIT;
-		for (i = 0; i < st->readers_len; i++) {
+
+		for (size_t i = 0; i < st->readers_len; i++) {
 			const char *name = reader_name(st->readers[i]);
 			int try_unlinking = 1;
 
@@ -238,6 +238,7 @@ void reftable_stack_destroy(struct reftable_stack *st)
 				unlink(filename.buf);
 			}
 		}
+
 		reftable_buf_release(&filename);
 		st->readers_len = 0;
 		REFTABLE_FREE_AND_NULL(st->readers);
@@ -568,7 +569,6 @@ static int stack_uptodate(struct reftable_stack *st)
 {
 	char **names = NULL;
 	int err;
-	int i = 0;
 
 	/*
 	 * When we have cached stat information available then we use it to
@@ -608,7 +608,7 @@ static int stack_uptodate(struct reftable_stack *st)
 	if (err < 0)
 		return err;
 
-	for (i = 0; i < st->readers_len; i++) {
+	for (size_t i = 0; i < st->readers_len; i++) {
 		if (!names[i]) {
 			err = 1;
 			goto done;
@@ -1767,14 +1767,12 @@ static int reftable_stack_clean_locked(struct reftable_stack *st)
 	}
 
 	while ((d = readdir(dir))) {
-		int i = 0;
 		int found = 0;
 		if (!is_table_name(d->d_name))
 			continue;
 
-		for (i = 0; !found && i < st->readers_len; i++) {
+		for (size_t i = 0; !found && i < st->readers_len; i++)
 			found = !strcmp(reader_name(st->readers[i]), d->d_name);
-		}
 		if (found)
 			continue;
 
diff --git a/reftable/system.h b/reftable/system.h
index 5274eca1d0..7d5f803eeb 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -11,8 +11,6 @@ license that can be found in the LICENSE file or at
 
 /* This header glues the reftable library to the rest of Git */
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 
 /*
diff --git a/reftable/writer.c b/reftable/writer.c
index 4e6ca2e368..91d6629486 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -577,7 +577,7 @@ static int writer_finish_section(struct reftable_writer *w)
 
 struct common_prefix_arg {
 	struct reftable_buf *last;
-	int max;
+	size_t max;
 };
 
 static void update_common(void *void_arg, void *key)

-- 
2.48.0.257.gd3603152ad.dirty

