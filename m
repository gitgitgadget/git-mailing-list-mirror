Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BD91A9F8D
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834755; cv=none; b=RrMIzVlJFdbtlFsCXAcWEA0IHPUkHlgTYymWlSQz8JugSPuBY0IFH/U2tgK6yhZ6WiUj+04ySoT25XSLjEuSOSt9dvVXqrHnGNkn6/PLQTn+H4L04bBRWt6z4ihn9CfvidGC0A95mm+pVtRn0Y9KCQO2vSsl4l2HM28AOO+U7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834755; c=relaxed/simple;
	bh=cU+SyTC4Im6aNJWGuyUVs7m3FgNCs5udkVuUXYKMBX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R5dTl5ORMrPjAVWjInQRNM+sVSfLm2BV/eWpbGCoA8cnjo4YccifboxptT5iUeR2y3Y2Tq+K1H+PjA2uz2olsKlZ9gs9ij+DK8nfesY1jTR3IRqFLjU/4O8RGgEAz/gvVC3Ho1sCwC4Glrz3RYAyQflJOZ91IljwqXVXcOST6Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TTOf101K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KG4x+cU9; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TTOf101K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KG4x+cU9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 886BE7A01C1
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 06:59:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 07 Oct 2025 06:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759834752;
	 x=1759921152; bh=1l65DBygnIoiSYdtKC6UJqJPiv54G1oTAdanchEbP30=; b=
	TTOf101KuunZYsUktCjMqX8qWiz+S/QBLw18yPcr5c2qKn85pJbCAYmoVVls/Ert
	T4KISVB9E0iLm+xzoI+YsUg/nufbjfcYgdcFDUTj2pNto3J9iCPWlgG18I2pjAc/
	cymJNPxqsK7jF+HGwB8AChAT/SP3WvQeLCD+k0UJucb5qFbivlNJcL/Q3ZqQP5X+
	COIWYC73169fq8vZNUF4mE7mZ4ZyPyqnS4JRlaZKxz1pDF0hjwcef2jIqHCRuWbh
	xznMzFRi5i6nRREXOzNolVj9auVoVx27EfrTajcMZ6wpYEwmE/Wrtzxpl2bI4JzS
	ahtYfiZl/Q5BejvlfT4tbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759834752; x=
	1759921152; bh=1l65DBygnIoiSYdtKC6UJqJPiv54G1oTAdanchEbP30=; b=K
	G4x+cU99Csd6PQZIuUD5Qwl26oM9HebkuEd1i0vpR8cHPC2REoXfUqYKnKqjdaaU
	tcaJgdOuXtEjuwF2RBmb3Q4kiU7UCM4aOVzDJ22sK7GXtaTOOzEAk8rJUmG4gd7z
	tqZbPjSOeYEDUXUZa3/UGWreGGDEPdw0H8Ac1+lKqU2mp+k2rIDtCEqORpA32gwF
	eap+cO1Pob41UZXHaMsYCMXxPL4gQoOzY5NtlNWjYZhxRTxLfIHyXpNJrGm5SgCL
	jlqOoV8+9nZSyJFX7vMSW8Kg+D6ImkBqHHnVp1LGI37r0ZEacjnQdsca1TUh3pUA
	IcFpcN63YPbxhw6MDi9Rw==
X-ME-Sender: <xms:gPLkaPi87SQSz-oQVBFghBkkN6tn9R86CATFQqj2CcLBwzll-KyI0A>
    <xme:gPLkaC9aQDyziZAUOSE5BE-FdgqTevpfCeckUvF-Afrx8N8n2-ucCxwT0NFDY4-UD
    NbG9H1ypT2AmM0ea0cLxDZSo6R4FomAnFuA6bt4kuURIqFO6soc8g>
X-ME-Received: <xmr:gPLkaEsL49kGRReQtARhJ5u8hS0QLpjweD3KUtwrB4ZitZVFgg0_IVOOnu8X6_zMcWo3eKGlwVOFfCyzsCOWdthKg73Jh5bCh0DRUHHtXT4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:gPLkaBayap11f1wjxOiSLuLOtjBPZa8itP7zKsg3ga0AK7EL5FUyXw>
    <xmx:gPLkaMqM2sOMx7futyTaR5u4d4sJcoHscXMtAcupa96Xow6fdVAZyA>
    <xmx:gPLkaO9abnaWdKi-haHnkkbfgxV-o4jw8YAmp8YqATwrsEELXXNYRw>
    <xmx:gPLkaD97Arj_7xoLoDE9JwIoAEmL4Y8NpB5v7ZK_prSJgIvWsQjKoQ>
    <xmx:gPLkaAizZyFs7rVY-w8yoIfPSxgcjF5jgzMgjzH8Ugjp6vWlzI-MuVdb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Oct 2025 06:59:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eb70fbae (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Oct 2025 10:59:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 12:58:42 +0200
Subject: [PATCH 05/13] upload-pack: convert to use
 `reference_get_peeled_oid()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-5-916cc7c6886b@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The `write_v0_ref()` callback is invoked from two callsites:

  - Once via `send_ref()` which is a callback passed to
    `for_each_namespaced_ref_1()`.

  - Once manually to announce capabilities.

When sending references to the client we also send the peeled value of
tags. As we don't have a `struct reference` available in the second
case, we cannot easily peel by calling `reference_get_peeled_oid()`, but
we instead have to depend on on global state via `peel_iterated_oid()`.

We do have a reference available though in the first case, it's only the
second case that keeps us from using `reference_get_peeled_oid()`. But
that second case only announces capabilities anyway, so we're not really
handling a reference at all here.

Adapt that case to construct a reference manually and pass that to
`write_v0_ref()`. Start to use `reference_get_peeled_oid()` now that we
always have a `struct reference` available.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 upload-pack.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 0d563ae74e..2d2b70cbf2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1249,15 +1249,15 @@ static void format_session_id(struct strbuf *buf, struct upload_pack_data *d) {
 }
 
 static void write_v0_ref(struct upload_pack_data *data,
-			const char *refname, const char *refname_nons,
-			const struct object_id *oid)
+			 const struct reference *ref,
+			 const char *refname_nons)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow deepen-since deepen-not"
 		" deepen-relative no-progress include-tag multi_ack_detailed";
 	struct object_id peeled;
 
-	if (mark_our_ref(refname_nons, refname, oid, &data->hidden_refs))
+	if (mark_our_ref(refname_nons, ref->name, ref->oid, &data->hidden_refs))
 		return;
 
 	if (capabilities) {
@@ -1267,7 +1267,7 @@ static void write_v0_ref(struct upload_pack_data *data,
 		format_symref_info(&symref_info, &data->symref);
 		format_session_id(&session_id, data);
 		packet_fwrite_fmt(stdout, "%s %s%c%s%s%s%s%s%s%s object-format=%s agent=%s\n",
-			     oid_to_hex(oid), refname_nons,
+			     oid_to_hex(ref->oid), refname_nons,
 			     0, capabilities,
 			     (data->allow_uor & ALLOW_TIP_SHA1) ?
 				     " allow-tip-sha1-in-want" : "",
@@ -1283,17 +1283,17 @@ static void write_v0_ref(struct upload_pack_data *data,
 		strbuf_release(&session_id);
 		data->sent_capabilities = 1;
 	} else {
-		packet_fwrite_fmt(stdout, "%s %s\n", oid_to_hex(oid), refname_nons);
+		packet_fwrite_fmt(stdout, "%s %s\n", oid_to_hex(ref->oid), refname_nons);
 	}
 	capabilities = NULL;
-	if (!peel_iterated_oid(the_repository, oid, &peeled))
+	if (!reference_get_peeled_oid(the_repository, ref, &peeled))
 		packet_fwrite_fmt(stdout, "%s %s^{}\n", oid_to_hex(&peeled), refname_nons);
 	return;
 }
 
 static int send_ref(const struct reference *ref, void *cb_data)
 {
-	write_v0_ref(cb_data, ref->name, strip_namespace(ref->name), ref->oid);
+	write_v0_ref(cb_data, ref, strip_namespace(ref->name));
 	return 0;
 }
 
@@ -1442,8 +1442,12 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 					 send_ref, &data);
 		for_each_namespaced_ref_1(send_ref, &data);
 		if (!data.sent_capabilities) {
-			const char *refname = "capabilities^{}";
-			write_v0_ref(&data, refname, refname, null_oid(the_hash_algo));
+			struct reference ref = {
+				.name = "capabilities^{}",
+				.oid = null_oid(the_hash_algo),
+			};
+
+			write_v0_ref(&data, &ref, ref.name);
 		}
 		/*
 		 * fflush stdout before calling advertise_shallow_grafts because send_ref

-- 
2.51.0.764.g787ff6f08a.dirty

