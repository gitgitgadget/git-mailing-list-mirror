Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54404363C55
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196163; cv=none; b=F4Q8JuD6r8cMdyGQt5zS1PxVQRIydUweA5tx76UzTJ9sJ3i15LY0s1Pc4E2A5znOalRodi5ygXMfHJHQabF+KfOEpEC8T/g+1zbNG2hc2Kh92BGvQACkOFW/h0EnMUC4xK9YwmFAdYYcUqpsFTUMTDPWrq+8PDZRxhdyDDZnArw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196163; c=relaxed/simple;
	bh=bZN5NWXsbDMN4p5K+U0AOuH2prbveNTqvvYxgGU3G0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fDXaSK3RHeQ53GzH+gXWi7was6j8lUoLJyEpMlE0t4Yh/JzpmXnXDjfEBdsAHETFrMk+gsemLoKRmQk1zLnJR7/eb1yeCo2/GVwcRNdzmQilKJdXMtH53edssSpnoDlOmuMGWWW9s2NmafjFQFdbIViYF6oMANLlvL3M8kQ231A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j179wAgB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JBzTgcXb; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j179wAgB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JBzTgcXb"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AEC0C7A00F1
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 02:02:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 03 Apr 2026 02:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775196154;
	 x=1775282554; bh=L1eiowpfIL5YTpJcHN2cv6gQN+SJOzHia92rYtan94U=; b=
	j179wAgBqqUSuZSZ0i33LwSH5q0i3jII+bIoZ2ti3V0RA2lHUqOtbJNerk6o69mf
	bbbboYoFuhijYlprnpPGBYKIrucBWbvdiuBkv9fn+PIw8z39m9IO/ijxeLkEJ822
	OeAWF4fL/XttIg27HljnVIIO++CxS8KihUNf+R345m+B4EabHiUL0f1i7pNCuI0W
	eGc2b64zEfAOt9GnEPjHF/R7dyIWkPTeaW6I/RwhjLm5B3J50lWjkk0Q3Y6xnAtC
	huWOoxc1BSkK9+c1rQPnK9u9h8gVJJKMj9sgfxvIFyZBxIMUkMaJcI/67LEqu9St
	iA4eETQiY1rpAbRfXlDaWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775196154; x=
	1775282554; bh=L1eiowpfIL5YTpJcHN2cv6gQN+SJOzHia92rYtan94U=; b=J
	BzTgcXb4ddSaHIUYdD2MPiURO5w6f+4mT5MnQFmBl4tcIZey2BfxXuV2T6DTs0Pw
	L7Fv2Xq8F7t4oCnzRU7UjEArTqFZysC80IzZdYLGzYrnzwEOQWJ0yEhauwz5ff/z
	s0gGKXjdjK5lyxhHVmQDAW5QPRQsnI5sG7UNOSCLNmgqnEhTvBp0nMcqQnJtsxr/
	OipXyJ6ymPBG4oPxv6Hm7JlkQQxw7e9EFU5m2YnLbqP75YJ5gIScKKAIyetbVVhL
	p3ZTMcuhQ/7ViQp0MzONAmgZ3igby3tQ1rK3UyZasTPCWooIBF3QeXwmP7WqglBZ
	y1XBU6LJZWEfS8jnkOqpg==
X-ME-Sender: <xms:-lfPaac2o7cffVQK0BPRMoiAEYEa6lHbBJWo0qiZ20ODsISqpN7y8Q>
    <xme:-lfPabJjLK5e3mmMapS6-YL07eQHoh1KW-UGjm_p30YiqfOVPBPmo3Grx2yiGdWns
    6TYZneyGoha63qmO9c4PPFwnIy9zYM7H8UsHpjr7e9SXPcMnF2xgw>
X-ME-Received: <xmr:-lfPaRLKsspuswXsJxhXgCYB9HGJPq2iGg0WRATfHAxtd8puM26z6PjRCbl-VdnMzAOWcvSAqj6-5_HI2dA_YeKXiEmICcQhTuQuU34PHWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:-lfPadG2uTxmWtYZXAyc9nQgaYjHyF5AcnwZsIq75Kry4z0RQl3y3w>
    <xmx:-lfPaWmSIx1rUluDA3_LR2iXM1JcpsNXKfOlbZhsSFC2dUCf_3rEgg>
    <xmx:-lfPaaKZJiburSaKOgVFRsscEoTzPrL-OPMBLT4W_n5_XA74tyGnyQ>
    <xmx:-lfPaXb_zRjHgJrUwbxDT0YeuRSeXtcpsyJxWCLzbCa93DvTk7WZfA>
    <xmx:-lfPaYNcPXcODgXqH32nG_ueDN0OWx-J52fpB9iuFd0EtNgdsAFgBdt7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Apr 2026 02:02:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 321ee3af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Apr 2026 06:02:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Apr 2026 08:01:54 +0200
Subject: [PATCH 07/16] odb/source-inmemory: implement
 `write_object_stream()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-pks-odb-source-inmemory-v1-7-8b8d1abaa25e@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.1

Implement the `write_object_stream()` callback function for the inmemory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index d2fc4c4054..890e2a8c7c 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -123,6 +123,45 @@ static int odb_source_inmemory_write_object(struct odb_source *source,
 	return 0;
 }
 
+static int odb_source_inmemory_write_object_stream(struct odb_source *source,
+						   struct odb_write_stream *stream,
+						   size_t len,
+						   struct object_id *oid)
+{
+	size_t total_read = 0;
+	char *data;
+	int ret;
+
+	CALLOC_ARRAY(data, len);
+	while (!stream->is_finished) {
+		unsigned long bytes_read;
+		const void *in;
+
+		in = stream->read(stream, &bytes_read);
+		if (total_read + bytes_read > len) {
+			ret = error("object stream yielded more bytes than expected");
+			goto out;
+		}
+
+		memcpy(data, in, bytes_read);
+		total_read += bytes_read;
+	}
+
+	if (total_read != len) {
+		ret = error("object stream yielded less bytes than expected");
+		goto out;
+	}
+
+	ret = odb_source_inmemory_write_object(source, data, len, OBJ_BLOB, oid,
+					       NULL, 0);
+	if (ret < 0)
+		goto out;
+
+out:
+	free(data);
+	return ret;
+}
+
 static void odb_source_inmemory_free(struct odb_source *source)
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
@@ -144,6 +183,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
 	source->base.write_object = odb_source_inmemory_write_object;
+	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
 
 	return source;
 }

-- 
2.53.0.1323.g189a785ab5.dirty

