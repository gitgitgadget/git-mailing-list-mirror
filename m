Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B341C2F4
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572376; cv=none; b=hc1LZNEQuH6Axi+TPruKUkPLmXIh/vaXyFU4bjk/tdtzJ+NDYOFtGwHnXNA5a8xT9aahgwSZ+BWIxKwk5OM82Bv5fDqQE/+PG5ZBSJ2lZb/u57akvSTRj0KtNZ/dXAf03O0wpai5HKLoBynebmRYZRSQ+FupcZUPHet0e50X7K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572376; c=relaxed/simple;
	bh=5OBLgES1CSJfDobbr6MqgyQH5aL6e+g9g/6JFCyShUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XxU8wS73n0/RW/LVAhiqPrpx5xwh4vwdE8aq9GRHgyBIzdwbTkAL7tatu4p/BQ5RoJ7u9bds23QzdsBfn5y1P/XzqFoM2MtvVdOGwRSYJu0WD2W4hCUcdZMzclWJtCYFQws1ojf9BB1N/Fd8QWfZMODwYWR7m65+FyKshjz0Mfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kW6t7Z8T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cPtZU/qn; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kW6t7Z8T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cPtZU/qn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F4134140012E
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:26:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 04 Jun 2026 07:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780572374;
	 x=1780658774; bh=HzFcSR4v05BTSMi1hzaI5K5SbQSvYkJWDkIXef1zchs=; b=
	kW6t7Z8TOd3QA25BUmwLryQwH/rwEkUlQLnjKNhpvu2nHkxz6wo1OQj+f9qRDDe5
	P1q/g6okeKgtFjUq4HVXRRB6Fuk0bxwE/CseeYYR2h1YusLg95uJxFlxBg29OmPi
	t6DegL7fCi4E+4hPBE7QagXwFrH76fomN6qaDyI+Dvy3Qua+7iP4z60reYDQ8H+d
	A30L1gcWevXaoTrDxQEvZnyAl5JmfSLclKL0cF25hHcjFNpzGcATRMjGBY5urwvl
	SsGYukkV+wmfM+WeFmMnGbI6NqvTer3DzhkH0/l/x/4yRDVabE4ax6hPKeb4oZEV
	UUarG35DA0pUaGQxQLZoJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780572374; x=
	1780658774; bh=HzFcSR4v05BTSMi1hzaI5K5SbQSvYkJWDkIXef1zchs=; b=c
	PtZU/qns23phhSKdXwSq0jEWaWhPEPwS/DuWWLiFJ/zdOlB5zMuQIIOr27UVzPLB
	EDc2Q0h/v4pMIJZ75+PDGL7bcRs/IDDNB1ZcH2pljvF9neDb/BZ9GFegyvZkTm+A
	lws83iRoYPftVKtzbDzSerdfJrdlGleF2Kvg2CTbNPHPq+7DJHIUPZpFteBiibRr
	Tkt/b56SnFP+t39OYXc0qHU5a0XW6LzgfrCldusai8momW5B4elTJ6wWZyaT7FfW
	xyUNNIX2ilcsVTgqh9/QETzLxbRmaAjlk17NSjasJPesqWy3us9KE7oxES7M8P4z
	FyLoJgBss411HSabzU8QA==
X-ME-Sender: <xms:1mAhauaQtgYtXRKhvkk7YfaCo27hc1WfjWf31YHJVQJPJ-FOgodhQA>
    <xme:1mAhaoVqkpA2MtThyL4UP5XNKnOQ8wZlCtKUgA_ZgN6cN4uzmgCv7amAXYEBui3xR
    iCH1xYsUTv0jfxxlz1SBx6Af-iLPerlSBOqw2w9Y8sgaWP3h2Vl1A>
X-ME-Received: <xmr:1mAhaulDyR4CWtad2D8FLMqA-562Ojnx87U4aTkZ4hfzOE_OJ5hI2c9x68iLbyN9e2ynvHN40qx03xZhoHLil1nUudBlsP-IvLsKxbC8Tdc>
X-ME-Proxy-Cause: dmFkZTEgCyScvAHJZtwScmArpd3MPVD65pRFEMle7OxDyvGrBgzCBJpJZt/i/e/55qfMB2
    OZ+A4mOijyyVR7BQZ8gApb6Lys3WwA/DRBZO1Z6gq18/NjHv9k/YmqxGulaGbdjpGbGIe8
    TR7oy8jORNRJjZkYPAiPkwIOcJg76HwsAVLzInKh/aA4zWo5I7a3yFoBSrwplR1bXvqyzb
    7cwWjx66LW0j/HaZcKLdC3JWI1rUB6+uoj5Ia8HwsvfkXaZepnJEy9rr0yADWxKwm6t/hJ
    h4TWvBlU4kw/rB+rZbM4p/EdiFJ50OcReCBplYqL1Hq7W/DA0KsY8Jaj3WslUYFsjaCmru
    A/4gg3c4iI7sbMOLZU3DPPrxJDwXIovWGeIOVWUeuS85/ctaPf9DcbN8LxXoSin9XiEhRB
    ZxTXtPduqebcfkkupj9FPffmLX49o7c12cYF8skqxAZfnQqrN5733D/Enj6a7oExWzpkTf
    b0Ewkhw7NFYFhP24i0bVZ/kofHeqX1CNZIVNLUbAe5GkK4TsY6QuJrQqXfTUx5KSk6RmzA
    3X6VNR9OVzvvptRm3KEkJTn4p8308tbIWsxEnE/NeuGuAqX68Wsys7z21DeHoB35Xs4lY6
    FNxFy0f3WjrMjI4jcJEYgtDEpKuFTtjfB7T970KpSaXTZHw47h2bUL4C1jpg
X-ME-Proxy: <xmx:1mAhalzB9v-mGI6pMygh2lt4hnN4M9c43sRQ58HfvSqqvCzr46sa0g>
    <xmx:1mAhapjxvVdg6m5rlfOQZsW4Dp-wU37o03OdLWpeZ5ry-G8CZSmuLw>
    <xmx:1mAhaqVauUycETdXbSith71H3nqtWWtvtyJw6bCma0ZwKxRO7UHO3w>
    <xmx:1mAhar3fdueqRRPjEvtMYX7GhDQVFYxsYqvleYyoo3fYZKMrMXs03A>
    <xmx:1mAhas4fzmo8xsc4UUqaweuuAfvnmR2y0G-im-n9dfyK8UpbKamcvkFq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Jun 2026 07:26:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3d686b01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Jun 2026 11:26:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 13:25:41 +0200
Subject: [PATCH 14/16] odb/source-packed: stub out remaining functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-odb-source-packed-v1-14-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
In-Reply-To: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Stub out remaining functions that we either don't need or that are
basically no-ops.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-packed.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/odb/source-packed.c b/odb/source-packed.c
index e40b52e445..08a2de9bc5 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -501,6 +501,43 @@ static int odb_source_packed_freshen_object(struct odb_source *source,
 	return 1;
 }
 
+static int odb_source_packed_write_object(struct odb_source *source UNUSED,
+					  const void *buf UNUSED,
+					  unsigned long len UNUSED,
+					  enum object_type type UNUSED,
+					  struct object_id *oid UNUSED,
+					  struct object_id *compat_oid UNUSED,
+					  unsigned flags UNUSED)
+{
+	return error("packed backend cannot write objects");
+}
+
+static int odb_source_packed_write_object_stream(struct odb_source *source UNUSED,
+						 struct odb_write_stream *stream UNUSED,
+						 size_t len UNUSED,
+						 struct object_id *oid UNUSED)
+{
+	return error("packed backend cannot write object streams");
+}
+
+static int odb_source_packed_begin_transaction(struct odb_source *source UNUSED,
+					       struct odb_transaction **out UNUSED)
+{
+	return error("packed backend cannot begin transactions");
+}
+
+static int odb_source_packed_read_alternates(struct odb_source *source UNUSED,
+					     struct strvec *out UNUSED)
+{
+	return 0;
+}
+
+static int odb_source_packed_write_alternate(struct odb_source *source UNUSED,
+					     const char *alternate UNUSED)
+{
+	return error("packed backend cannot write alternates");
+}
+
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
@@ -715,6 +752,11 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 	packed->base.count_objects = odb_source_packed_count_objects;
 	packed->base.find_abbrev_len = odb_source_packed_find_abbrev_len;
 	packed->base.freshen_object = odb_source_packed_freshen_object;
+	packed->base.write_object = odb_source_packed_write_object;
+	packed->base.write_object_stream = odb_source_packed_write_object_stream;
+	packed->base.begin_transaction = odb_source_packed_begin_transaction;
+	packed->base.read_alternates = odb_source_packed_read_alternates;
+	packed->base.write_alternate = odb_source_packed_write_alternate;
 
 	if (!is_absolute_path(parent->base.path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);

-- 
2.54.0.1064.gd145956f57.dirty

