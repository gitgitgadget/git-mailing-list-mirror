Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CEA635
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 06:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629654; cv=none; b=MSDM6n3q4RoncTFL9u8BAYU0M61/JcMruCjOvWvmx8VkiwaZzTni1oIMjY1bze6dB9PiPqKQPi+5AmPAHJnJzWoxA6qeq/rVEPXPgTzuiED8dSE8oA2RBgBMVhRt1F3gf/wjrQzmA4w+FZ5K4/taQCFmXISa7XdgmChjTRBSfs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629654; c=relaxed/simple;
	bh=u3pJJ8vBnzS/ljt/ZI9HbLwre1bunsv6sZ6rJ6xlG8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAbR++M+Qzpyz+9yTezmkXjcPNDF6xWvjWBM/4UPFENmywN8g86cTNjI6sAuv8QpYDjJmvmnXAcvGK2+67IG+nizuwA8QotLKHMN0klThD7DJn5rBNI2iR2REeP3FmROA7IHwO5lyMR9VD7Q9BMj/q0ydd4yB/ETq3Kq84ujcKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OL6536bP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gLmdy0m9; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OL6536bP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gLmdy0m9"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13D211140165;
	Fri, 11 Oct 2024 02:54:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 11 Oct 2024 02:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728629652; x=1728716052; bh=a0Wh6eQsnl
	l4dhrb6IgYXukdP8zx/TgHfwnJLS6tI/4=; b=OL6536bPalXK3Qo2a/mM/Vh+y/
	CAcxEagEqP6znt58u0/fnm4bWLyw9jg7NRd+P7grrYle+8AXrx6n57JOzvWJGNG1
	sDjMW4OeskE8bXotBuFN13FrLUebt9uhIz/j2MhF5gczxV2V+LwX3TJnnSQteG+F
	H4DgVomtSLp2ycIyhmDozb1FaJwEXFYHWoSowmeowVsmk7D/nx96R7KNfqdHg2GA
	yawMALESY+v++MbTs+XiFnBl+wGbgRE22jR6xsBaPY0+Bz71rHNIQx9o9Gn2K2Qb
	U+WfuQKx27KRwHT/hLLzlludV/WyXFrrgvolt0SE0az3Tw/gvFse7/cM4SfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728629652; x=1728716052; bh=a0Wh6eQsnll4dhrb6IgYXukdP8zx
	/TgHfwnJLS6tI/4=; b=gLmdy0m9NvNCbwwUnNU+2dWYdamoHbPiul8tFyCHOV9C
	gXtnwLAJtlYx+6SsWjOiLZWFuo/2QaYwwG1SfkEcaFhAciGFxItPc8GpK0PeyC6F
	cgAbE4/z6/IrBslwfqlBKClgeI7TI5pRjBJJ4niIv34z/ZuQ+Wz1tCuvid7rQrWV
	oRQjrQI/IqFR4V9nemiYTmSBsQV4Bqqa0X5NTcAMJvbgFkt4CSYDSTWiKxA+Zddb
	jHBVP0NWxF+g5bqO/eKeLAH3lGSR8zJOGRfsX7S89wE9Dv1d0EX2ZWwXOuvbPhf5
	aJ9vTJ77+UeiUoHJyPvJ8YRVnRg++/qAv+mvTlwK1w==
X-ME-Sender: <xms:k8sIZ1WIiGl3uumPsl_F_TBNXyrAI-KVBj_h_HshwOUetaly-d85BA>
    <xme:k8sIZ1mG8EW6-bP5ypMzYf8wAERe8atWgC_Inr41B8RL8i3v9JoiJkr3BZV6DH7I3
    nzqeWdAxyAAhFgezQ>
X-ME-Received: <xmr:k8sIZxaCid84Q60FrabdHqZy-RHY7ilv18aaLmsZrTmex1wk50chqIkEs7KjebUgB_NRXSiG-Vt7m5sLEivLFFu9N2lEQL4IWvhQTpMva4tAfKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmsh
    honhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:k8sIZ4WTl_33K9HF3AuBT_aKSrgHMx-lJcPhIxlpeVD9mxc1QFEQCQ>
    <xmx:k8sIZ_kR87hnwtGb7Zqu0XJ3ZMIGbDqtUP6d1MuADdDdG0ixmVi_UA>
    <xmx:k8sIZ1f5FiLyNYPWTeWLI4gtQ00FcAdRprUtlwogIEM_aQjLlLHX5Q>
    <xmx:k8sIZ5Hlneh1sUQSF8lrPv5qLd7tNozHLZvMbydEtwPRgTAjTwB0Og>
    <xmx:lMsIZ0wFR8xVPXIZInzoJau5gvEH4vfVN9wJc_NDZtKqlIpGHYj5qu_t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 02:54:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e5e0a9ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Oct 2024 06:53:05 +0000 (UTC)
Date: Fri, 11 Oct 2024 08:54:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 01/10] reftable: stop using `strbuf_addbuf()`
Message-ID: <7408482c152bbf465ecd098059b1477fd38c251a.1728629612.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728629612.git.ps@pks.im>

We're about to introduce our own `reftable_buf` type to replace
`strbuf`. Get rid of the seldomly-used `strbuf_addbuf()` function such
that we have to reimplement one less function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c  | 2 +-
 reftable/record.c | 6 +++---
 reftable/writer.c | 7 ++++---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 8d41a2f99ed..cd4180eac7b 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -60,7 +60,7 @@ static int block_writer_register_restart(struct block_writer *w, int n,
 	w->next += n;
 
 	strbuf_reset(&w->last_key);
-	strbuf_addbuf(&w->last_key, key);
+	strbuf_add(&w->last_key, key->buf, key->len);
 	w->entries++;
 	return 0;
 }
diff --git a/reftable/record.c b/reftable/record.c
index 30d563e16d3..87157f2c386 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1031,7 +1031,7 @@ static void reftable_index_record_key(const void *r, struct strbuf *dest)
 {
 	const struct reftable_index_record *rec = r;
 	strbuf_reset(dest);
-	strbuf_addbuf(dest, &rec->last_key);
+	strbuf_add(dest, rec->last_key.buf, rec->last_key.len);
 }
 
 static int reftable_index_record_copy_from(void *rec, const void *src_rec,
@@ -1041,7 +1041,7 @@ static int reftable_index_record_copy_from(void *rec, const void *src_rec,
 	const struct reftable_index_record *src = src_rec;
 
 	strbuf_reset(&dst->last_key);
-	strbuf_addbuf(&dst->last_key, &src->last_key);
+	strbuf_add(&dst->last_key, src->last_key.buf, src->last_key.len);
 	dst->offset = src->offset;
 
 	return 0;
@@ -1085,7 +1085,7 @@ static int reftable_index_record_decode(void *rec, struct strbuf key,
 	int n = 0;
 
 	strbuf_reset(&r->last_key);
-	strbuf_addbuf(&r->last_key, &key);
+	strbuf_add(&r->last_key, key.buf, key.len);
 
 	n = get_var_int(&r->offset, &in);
 	if (n < 0)
diff --git a/reftable/writer.c b/reftable/writer.c
index b032a47decb..031d8149a9c 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -225,7 +225,7 @@ static int writer_index_hash(struct reftable_writer *w, struct strbuf *hash)
 		*key = empty;
 
 		strbuf_reset(&key->hash);
-		strbuf_addbuf(&key->hash, hash);
+		strbuf_add(&key->hash, hash->buf, hash->len);
 		tree_insert(&w->obj_index_tree, key,
 			    &obj_index_tree_node_compare);
 	} else {
@@ -256,7 +256,7 @@ static int writer_add_record(struct reftable_writer *w,
 	}
 
 	strbuf_reset(&w->last_key);
-	strbuf_addbuf(&w->last_key, &key);
+	strbuf_add(&w->last_key, key.buf, key.len);
 	if (!w->block_writer) {
 		err = writer_reinit_block_writer(w, reftable_record_type(rec));
 		if (err < 0)
@@ -778,7 +778,8 @@ static int writer_flush_nonempty_block(struct reftable_writer *w)
 
 	index_record.offset = w->next;
 	strbuf_reset(&index_record.last_key);
-	strbuf_addbuf(&index_record.last_key, &w->block_writer->last_key);
+	strbuf_add(&index_record.last_key, w->block_writer->last_key.buf,
+		   w->block_writer->last_key.len);
 	w->index[w->index_len] = index_record;
 	w->index_len++;
 
-- 
2.47.0.dirty

