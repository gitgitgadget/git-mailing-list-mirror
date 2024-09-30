Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826417A924
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683721; cv=none; b=EgzNYmO4+6K+s/hPuRElW6kTnmV8PqOpy+jxy6oc1JP0aAuJSqhMcLxalhWQMzRSHpDmHbtIARp91cTu44K66//4nTfRUsSHPNM4mJa+dATX5nMSueQ1YDyfbjnlFWyC8SEUF9C1HFyTwFiWGIPmJOjA/mUNL+uvKOovP8HHO2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683721; c=relaxed/simple;
	bh=gPocTrFEySpMFdwOwC+Vi0bhdBi+6sLaQrGVZ+8Kdek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lo4RxsaCAJWorneHzKx9tQvWZF6wsa4/es6cUO55WMV7eXa2Jo2UQhFcVW1s4rPo8sTUUEQ04gehYbLO+LeW4xaNJBfmIArS6hsvWWzUHPq5TKGyff11fcRxEfm4RokQ09/wcZv94d+9gHVI+4Lvj4hEu4LX78lIhGuAEwlLwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TapjjKbq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aNkD4Mka; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TapjjKbq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aNkD4Mka"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0B08213802F6;
	Mon, 30 Sep 2024 04:08:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 30 Sep 2024 04:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683719; x=1727770119; bh=pUvH4yiUxU
	CbPuvU0/P6huj4B8hJht8habCevMNqevU=; b=TapjjKbqpA+uigeLOBBS87v9qJ
	AuSkkrPFe3qsrd8C/ePZhZ63gjai+zYoq9VNkJZzSe5d7YBjp2kCJ2mowkX9mU0C
	dzQpKv8Ra0/teJlvLGDP9DtS7YSIsghJKMM2fLHy+B1rGWUrjyi0ajPcKt8iuTmD
	BU35BhAApCCZnpiRVhGtON8U5apwhdto0BeG4vAxPwbr0D++PMloyrNkIWolfP4+
	mj9h0op4dqJfSwaDdq09hWdgGs8HNT3NTfze7sH6yeI5GMOvzZEaWVTq6RiBRXYK
	UTT3SVG+YUYpRcAgMI7UW576ueRftIsVbmKUHNvCmC0u8RunEipvyDgVhECg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683719; x=1727770119; bh=pUvH4yiUxUCbPuvU0/P6huj4B8hJ
	ht8habCevMNqevU=; b=aNkD4Mka2FfxG5QHwHuyVvn53BcsPx6ik19binXz+Hxp
	+1MQ+L1fTLOhwoTfAeus8WMeckL+hr6nYFzD+r0DyeFFTRZVJTLRr1rJdEBV5qtC
	SHVDPAqErZGvR5EM/erFBGMVFP4FpZRIGOcfyDkFg0BL7GQZ1w4tiTN8maUEJxpx
	1aHdAQX6aNd7vRpJGfX9wY9HB7EvnpHOEr9swWOAV49HjpHbiW4j30Sd2CwowX+H
	Jb+pM8vnxb3Vtkb+GliYAF10Qa8Zr/ZsUv20lYooBbmp3x4Gpa3Ai/iSJAJlQSK/
	4wUUHkJGc11xiAIpApNsnzw4T6toIXTIZR4NXQCtpA==
X-ME-Sender: <xms:hlz6ZqyXmp5ICLMzD9pliMqi0SVmym5nJyES4ox-n2qYDEfm4QcMcA>
    <xme:hlz6ZmQ4na4Y94XJJBDtQstiDjWEjUW_LnW_Ft9QlUdS0oJDFSnfZFfoTQc4mumid
    jnW8MJWZ6gTJGvj6g>
X-ME-Received: <xmr:hlz6ZsUyK0V4Jna6-1AYWVaizn-BzMFekl5DahMHNFtU2EAuZnYAdXSW9CTRMngPuVPN4heh1xiEe56FjzTFIg_VTJvYwfVd0aYNwFvwPTu1y9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhope
    gvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:hlz6ZggIgSu2k1JTd5_KSvo4-YHhq20kPLPt58aDbwgg6mu7gPFnFA>
    <xmx:hlz6ZsBfywbuMuGkyHkzmeFiRnXDtU8zWX29EnsPYXHW9p3_T6GbFA>
    <xmx:hlz6ZhLhhOIfVVKWG35xhedfVSQz5_w-BMPXsbw36ojvkC85Mv-Kcw>
    <xmx:hlz6ZjCS_1-7DRx1RlD1MOe456N4QHg7f-tvLt0zHIwnFxYu_PSJ-A>
    <xmx:h1z6Zv82n2FZAM1LkN2szHN3aNBUoePUakaxDGkI3CIVxuIB4AKKn8xw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:08:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4ee7cc22 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:07:51 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:08:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 09/22] reftable/writer: handle allocation failures in
 `reftable_new_writer()`
Message-ID: <9edd1d84cdbd53d966ff5cfe9b75281dd5966b07.1727680272.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727680272.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727680272.git.ps@pks.im>

Handle allocation failures in `reftable_new_writer()`. Adapt the
function to return an error code to return such failures. While at it,
rename it to match our code style as we have to touch up every callsite
anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-writer.h  | 12 +++++++-----
 reftable/stack.c            | 14 ++++++++++----
 reftable/writer.c           | 22 ++++++++++++++++------
 t/unit-tests/lib-reftable.c |  8 +++++---
 4 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 189b1f4144..43623dc7c3 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -90,11 +90,13 @@ struct reftable_stats {
 	int object_id_len;
 };
 
-/* reftable_new_writer creates a new writer */
-struct reftable_writer *
-reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
-		    int (*flush_func)(void *),
-		    void *writer_arg, const struct reftable_write_options *opts);
+struct reftable_writer;
+
+/* Create a new writer. */
+int reftable_writer_new(struct reftable_writer **out,
+			ssize_t (*writer_func)(void *, const void *, size_t),
+			int (*flush_func)(void *),
+			void *writer_arg, const struct reftable_write_options *opts);
 
 /* Set the range of update indices for the records we will add. When writing a
    table into a stack, the min should be at least
diff --git a/reftable/stack.c b/reftable/stack.c
index 498fae846d..ea21ca6e5f 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -808,8 +808,11 @@ int reftable_addition_add(struct reftable_addition *add,
 	}
 	tab_fd = get_tempfile_fd(tab_file);
 
-	wr = reftable_new_writer(reftable_fd_write, reftable_fd_flush, &tab_fd,
-				 &add->stack->opts);
+	err = reftable_writer_new(&wr, reftable_fd_write, reftable_fd_flush,
+				  &tab_fd, &add->stack->opts);
+	if (err < 0)
+		goto done;
+
 	err = write_table(wr, arg);
 	if (err < 0)
 		goto done;
@@ -898,8 +901,11 @@ static int stack_compact_locked(struct reftable_stack *st,
 		goto done;
 	}
 
-	wr = reftable_new_writer(reftable_fd_write, reftable_fd_flush,
-				 &tab_fd, &st->opts);
+	err = reftable_writer_new(&wr, reftable_fd_write, reftable_fd_flush,
+				  &tab_fd, &st->opts);
+	if (err < 0)
+		goto done;
+
 	err = stack_write_compact(st, wr, first, last, config);
 	if (err < 0)
 		goto done;
diff --git a/reftable/writer.c b/reftable/writer.c
index ed61aaf59c..54ec822e1c 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -117,13 +117,17 @@ static void writer_reinit_block_writer(struct reftable_writer *w, uint8_t typ)
 	w->block_writer->restart_interval = w->opts.restart_interval;
 }
 
-struct reftable_writer *
-reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
-		    int (*flush_func)(void *),
-		    void *writer_arg, const struct reftable_write_options *_opts)
+int reftable_writer_new(struct reftable_writer **out,
+			ssize_t (*writer_func)(void *, const void *, size_t),
+			int (*flush_func)(void *),
+			void *writer_arg, const struct reftable_write_options *_opts)
 {
-	struct reftable_writer *wp = reftable_calloc(1, sizeof(*wp));
 	struct reftable_write_options opts = {0};
+	struct reftable_writer *wp;
+
+	wp = reftable_calloc(1, sizeof(*wp));
+	if (!wp)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
 
 	if (_opts)
 		opts = *_opts;
@@ -134,13 +138,19 @@ reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
 	strbuf_init(&wp->block_writer_data.last_key, 0);
 	strbuf_init(&wp->last_key, 0);
 	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
+	if (!wp->block) {
+		free(wp);
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
+	}
 	wp->write = writer_func;
 	wp->write_arg = writer_arg;
 	wp->opts = opts;
 	wp->flush = flush_func;
 	writer_reinit_block_writer(wp, BLOCK_TYPE_REF);
 
-	return wp;
+	*out = wp;
+
+	return 0;
 }
 
 void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
diff --git a/t/unit-tests/lib-reftable.c b/t/unit-tests/lib-reftable.c
index ab1fa44a28..54c26c43e7 100644
--- a/t/unit-tests/lib-reftable.c
+++ b/t/unit-tests/lib-reftable.c
@@ -22,9 +22,11 @@ static int strbuf_writer_flush(void *arg UNUSED)
 struct reftable_writer *t_reftable_strbuf_writer(struct strbuf *buf,
 						 struct reftable_write_options *opts)
 {
-	return reftable_new_writer(&strbuf_writer_write,
-				   &strbuf_writer_flush,
-				   buf, opts);
+	struct reftable_writer *writer;
+	int ret = reftable_writer_new(&writer, &strbuf_writer_write, &strbuf_writer_flush,
+				      buf, opts);
+	check(!ret);
+	return writer;
 }
 
 void t_reftable_write_to_buf(struct strbuf *buf,
-- 
2.46.2.852.g229c0bf0e5.dirty

