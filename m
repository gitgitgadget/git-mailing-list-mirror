Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114912343BE
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807438; cv=none; b=Ve8hDM3PXq4bnkaU+k0hydf5fEhlAT/ILjORlP3Hd6O8uUA0A960tY2w8DDrgOPtTfWo4hwf4cW10a7Ou0JraibbI/9vo1bCJ+5215J7NID3HvsYTz7tJaq4mc2bhld+siH+5ZU0oJhW0noMvMSYzUDQXSlVph7cjk3ToA+kXtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807438; c=relaxed/simple;
	bh=t+78s95Fr/AZALcVXVm/3Y4kSZ68GgUea7LFzXxeVFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PVtQVrLS/PRjt5trJbzUy6xBbwPFBaq7OM5IytIpHaFPobcXhCE3HD+XV4qFdaqsno4wmBYC0Hm1ZHMZ6IoqJ0x1elfxrVEqEZtJZfFDFremIS391eJ422D01jlb1xDGBdHKqeKoCWZUSP9itqYSvmdNKQoRCqlDKJyIjFYz744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h7VKBkvb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zC/zEvKl; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h7VKBkvb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zC/zEvKl"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 17A4C114018D;
	Mon, 17 Feb 2025 10:50:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 17 Feb 2025 10:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739807435;
	 x=1739893835; bh=bUQoO4X3F/YsI0DEHSWA6Zn2qHIueWoh36yqFCQ5E9c=; b=
	h7VKBkvbPSCXQZrrtTfQm4E2HrumlOd9wcko0bg8dG3o+VQlSDc+SnJk2YwviCwI
	lqnpeIt0T6PLakmX8VGfN/p9HwhVX9yaiIZI8FF2SfPftIW2ziNyzuEIso50ky+E
	qMVgDYoyu9CFz4RFqJ3fh4lnuzThKWVa0zAmePErCktdK/Puz+j1zqjSDMmzTeLT
	7pbXptQV60M1KwWEFYdbXL4Btwkr66Wmg0gN2pSEtmATNf33VC5ZUFYFxylRLpqi
	J+IcftkxwYFwiSmHu1wMP7fr3S+UTVLnXuvoUQJA4chbGJqnUop/+oS+HYwABsZV
	OzMo+VF6Yq52VWMgGJOdqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739807435; x=
	1739893835; bh=bUQoO4X3F/YsI0DEHSWA6Zn2qHIueWoh36yqFCQ5E9c=; b=z
	C/zEvKlDJAsxeN9lj4V+labiNMl/b9NeOeRexw5+HHRTc6YEgTXEguRa453vbJPr
	YWbMGXV+ZMH9FPwvRxpdgbOKw3epJ0urQy9L4zPld3FI1AAyxOpdUe/SzKhadem/
	u3JlqRXjazppt6GBO5ebjP7cp/EyBaT/c2U3kBW7cDgVS9enGUiAAjxY5W0At09e
	i025nyd9LuBn2oEd7og6iNfFBAbZ9304S55nmcEgytu68Fdyzwz/KOEu2dNIsbHS
	XlrcT6Mr79w0AJrmIHK9dktutQwJ/bSl8hoBQzpRy3Hc13ARX2BuDTIeS6E99k35
	A2K4BbpGnTeWDg4FbfcZg==
X-ME-Sender: <xms:y1qzZ-qa3V2I84EBm98T2scpqPG5f6EtrPfrjfMTUG2rDqnjk6zQbw>
    <xme:y1qzZ8pNNxT0eHWspgMkTQ5ldFIwRqutb-2TRdAZI3dE8DMcKkNTqBgXSZ3TyyB0q
    CD0ss4VdEQSCRz3Gg>
X-ME-Received: <xmr:y1qzZzPzByWZy78zqtllaQcMGRRMK5fgfzaHWOhmXEeqgHO504pz3ToQv0j7srrbTdoLbBj5D8a8rEKvsS4esUqwVyXKpd0PQzl9ShHz2akH7Nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:y1qzZ97KyZoyTL1RbvW6HFLtuOveeZDf-MVcWuGQ_ZL_TXFeskZmVQ>
    <xmx:y1qzZ96YGvlo-1mBO0b3ATBdRNi52r9V_wHlKJNcfd9yUsU3d-13sQ>
    <xmx:y1qzZ9gmOedAhLBndBVKbvgQ7J7iBNKBjpTbuJLPXXy3tBxY26Jzjw>
    <xmx:y1qzZ34r-V1VMl-9DL-58m2BIhquYJo6bBLiJa5YKA_uBlEEkJEisA>
    <xmx:y1qzZ6uO7y3yPMCwPceJoQ22njprP0frSArqU5J6rn2lMkaYWXCdMWTj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 10:50:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2e6d2dab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 15:50:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Feb 2025 16:50:24 +0100
Subject: [PATCH 10/14] refs/iterator: implement seeking for reftable
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-pks-update-ref-optimization-v1-10-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Implement seeking of reftable iterators. As the low-level reftable
iterators already support seeking this change is straight-forward. Two
notes though:

  - We do not support seeking on reflog iterators.

  - We start to check whether `reftable_stack_init_ref_iterator()` is
    successful.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 06543f79c64..b0c09f34433 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -547,7 +547,7 @@ struct reftable_ref_iterator {
 	struct reftable_ref_record ref;
 	struct object_id oid;
 
-	const char *prefix;
+	char *prefix;
 	size_t prefix_len;
 	char **exclude_patterns;
 	size_t exclude_patterns_index;
@@ -718,6 +718,20 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	return ITER_OK;
 }
 
+static int reftable_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				      const char *prefix)
+{
+	struct reftable_ref_iterator *iter =
+		(struct reftable_ref_iterator *)ref_iterator;
+
+	free(iter->prefix);
+	iter->prefix = xstrdup_or_null(prefix);
+	iter->prefix_len = prefix ? strlen(prefix) : 0;
+	iter->err = reftable_iterator_seek_ref(&iter->iter, prefix);
+
+	return iter->err;
+}
+
 static int reftable_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				      struct object_id *peeled)
 {
@@ -744,10 +758,12 @@ static void reftable_ref_iterator_release(struct ref_iterator *ref_iterator)
 			free(iter->exclude_patterns[i]);
 		free(iter->exclude_patterns);
 	}
+	free(iter->prefix);
 }
 
 static struct ref_iterator_vtable reftable_ref_iterator_vtable = {
 	.advance = reftable_ref_iterator_advance,
+	.seek = reftable_ref_iterator_seek,
 	.peel = reftable_ref_iterator_peel,
 	.release = reftable_ref_iterator_release,
 };
@@ -806,8 +822,6 @@ static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftable_ref_
 
 	iter = xcalloc(1, sizeof(*iter));
 	base_ref_iterator_init(&iter->base, &reftable_ref_iterator_vtable);
-	iter->prefix = prefix;
-	iter->prefix_len = prefix ? strlen(prefix) : 0;
 	iter->base.oid = &iter->oid;
 	iter->flags = flags;
 	iter->refs = refs;
@@ -821,8 +835,11 @@ static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftable_ref_
 	if (ret)
 		goto done;
 
-	reftable_stack_init_ref_iterator(stack, &iter->iter);
-	ret = reftable_iterator_seek_ref(&iter->iter, prefix);
+	ret = reftable_stack_init_ref_iterator(stack, &iter->iter);
+	if (ret)
+		goto done;
+
+	ret = reftable_ref_iterator_seek(&iter->base, prefix);
 	if (ret)
 		goto done;
 
@@ -2015,6 +2032,13 @@ static int reftable_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 	return ITER_OK;
 }
 
+static int reftable_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
+					 const char *prefix UNUSED)
+{
+	BUG("reftable reflog iterator cannot be seeked");
+	return -1;
+}
+
 static int reftable_reflog_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
 					 struct object_id *peeled UNUSED)
 {
@@ -2033,6 +2057,7 @@ static void reftable_reflog_iterator_release(struct ref_iterator *ref_iterator)
 
 static struct ref_iterator_vtable reftable_reflog_iterator_vtable = {
 	.advance = reftable_reflog_iterator_advance,
+	.seek = reftable_reflog_iterator_seek,
 	.peel = reftable_reflog_iterator_peel,
 	.release = reftable_reflog_iterator_release,
 };

-- 
2.48.1.666.gff9fcf71b7.dirty

