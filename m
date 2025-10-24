Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD72030DEC5
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299783; cv=none; b=XTg7KhtIQoe25vzMHTTzHf3FbLRGAEjyvcjeBDwkdH+DVxcJL33s6XJbQ1X5ly4EHJhGWyRULf0+ngU+Wfixju4HSvbQspxKzU7JakF2Hj6riurZfe4Fey3TLqASjLxeeJbvkopCF3Z2SD8uuyAVw1AUkj1d7UnfmVP2V/dYmGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299783; c=relaxed/simple;
	bh=y8oGt6lNfx2Qt2Z2utz4oU87qNMN9HiGZAVRLZaX11A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oq/eWl4zL6QcMcQfamsjpnE83SQ5VrXS+rnSQmHDINjdKjPkvrShtbCo9A0Hb3Q3vcB1sq5x7ldSi83sxxFBm0dajBYUGXcc0HJNxJRCGIWBPnACUdmL9fwq5DkgezWinG+F3YSA4uzymgMe4gbDqIJaFDW9VXeLq1IrY3TAH2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y/y1Ov25; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hc8Kom+9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y/y1Ov25";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hc8Kom+9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 300F3EC02A0
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 24 Oct 2025 05:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299781;
	 x=1761386181; bh=gcSXToptyATdGV6kKHDRnuEKt5hdKsCx7whaRaW0uHg=; b=
	Y/y1Ov25a8YeF1vdKuqojuvGcm7DNEPW1ezFHxsrvD9R5/induDsA86TY42tW+Ci
	wggtMcbvJk6QMLIMb+XzTt3SijSb3G74yBk86m2oqOZzFx7eX8otrYZmsRWnKGN0
	nlvo/XXj14kmb58EZZNZugn/QDYvJIL4kD8yjGDa13Kiw6E7W/e4wZOWpFruJq3v
	0xu/RDlnbjL5Kb0fsC/mdZbsbVZ3UTCO6YW/NkIsF7P3K9g5B3V7tRJNkvuAvP/7
	fzZHNVjnZH/56OHqtpiDzACIG05LJL4RNxFpQIDKeLUzo/C4ieGBispsEpt/uDgK
	pKhIpTxzpxi7hm7Nz1Piiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299781; x=
	1761386181; bh=gcSXToptyATdGV6kKHDRnuEKt5hdKsCx7whaRaW0uHg=; b=h
	c8Kom+9sQODvRUpLUC0u4AQLxd+ODhkYAzYTRnSvzBADCDR3AlZARM5b8mU6DeAG
	cFZp2uUUzpz1UWl97j9u1BdkPpRo97bYm6u2jA25Qbi/emmN/5Hu5lOYwqZxAfd+
	c/pIH54mSKhEaS2dJt87C0QQ13AnPphGi9UBbUsDTsxLDhq6HcMxfuEs1DuHMlrf
	5IZ5TTKgXSvZ/lg5UWvrexslepgx6nr6RQUIomtvHrTMwbHKipUahIVw0rFwdg1w
	/oIYHiROgaypBC16eLsvxVyGUjSAizV2Cb4jR/vWihcech+krIkdS95w7A/x8djy
	oRo8G2eRbqJpiYB5J6dsw==
X-ME-Sender: <xms:RU37aLdqei2SiLIjbdYVKaHQ-xui5FBhNoyFNX9eMmOKtlsoirE1tA>
    <xme:RU37aILuUxKz5gh6R7pcfIS4arauj48Mct--1nVP10_A9M7gEUlDBBEA_8Mqn1Haq
    eX1brNab5UzmkNCzFdQzjg9LgqrWdIPQ8ZyFBSWxYxzQh-_0Lm9>
X-ME-Received: <xmr:RU37aKLE_02Uj8sinpXPRUVPMocDvrrLdke1Mdp7259llE1Z1WUomo05Avr6g-aHHt07iL_slmLLPJfLRuWAILIz3kq4Pb3vhIfzYFBiKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:RU37aCHGXSpLg8zUIyS76iXNfJBkx8hPHrhbdNQqehx55aYlHLXB1w>
    <xmx:RU37aHn3fy8XdGCVtxfn3WGafRPZn6TecOPWNJJ_hbxQ9hCEd-A_ug>
    <xmx:RU37aHIBCgUaWRFO29K7tfKUp-PGyHo2P9osxWHOCBOvCxDKT6qQXA>
    <xmx:RU37aAYTpmKlkbLZOb060QMxrqXVVKIfVMV6ZSSpPaXXKKcP6EOZ3Q>
    <xmx:RU37aNPfQwagBzdp9U5i06xjazOSvFZ7pl6FdzitDceYLaGUi6yUJnG0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 52317a12 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Oct 2025 09:56:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 11:56:04 +0200
Subject: [PATCH 05/13] object-file: introduce `struct odb_loose_source`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-pks-odb-loose-backend-v1-5-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Currently, all state that relates to loose objects is held directly by
the `struct odb_source`. Introduce a new `struct odb_loose_source` to
hold the state instead so that it is entirely self-contained.

This structure will eventually morph into the backend for accessing
loose objects. As such, this is part of the refactorings to introduce
pluggable object databases.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 13 +++++++++++++
 object-file.h |  7 +++++++
 odb.c         |  2 ++
 odb.h         |  3 +++
 4 files changed, 25 insertions(+)

diff --git a/object-file.c b/object-file.c
index 4675c8ed6b6..38e09262e42 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1995,3 +1995,16 @@ void object_file_transaction_commit(struct odb_transaction *transaction)
 	transaction->odb->transaction = NULL;
 	free(transaction);
 }
+
+struct odb_loose_source *odb_loose_source_new(struct odb_source *source)
+{
+	struct odb_loose_source *loose;
+	CALLOC_ARRAY(loose, 1);
+	loose->source = source;
+	return loose;
+}
+
+void odb_loose_source_free(struct odb_loose_source *source)
+{
+	free(source);
+}
diff --git a/object-file.h b/object-file.h
index 097e9764be1..aa84fc2a752 100644
--- a/object-file.h
+++ b/object-file.h
@@ -18,6 +18,13 @@ int index_path(struct index_state *istate, struct object_id *oid, const char *pa
 
 struct odb_source;
 
+struct odb_loose_source {
+	struct odb_source *source;
+};
+
+struct odb_loose_source *odb_loose_source_new(struct odb_source *source);
+void odb_loose_source_free(struct odb_loose_source *source);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
diff --git a/odb.c b/odb.c
index 77490d7fdbe..f1b250ceffe 100644
--- a/odb.c
+++ b/odb.c
@@ -151,6 +151,7 @@ struct odb_source *odb_source_new(struct object_database *odb,
 	source->odb = odb;
 	source->local = local;
 	source->path = xstrdup(path);
+	source->loose = odb_loose_source_new(source);
 
 	return source;
 }
@@ -368,6 +369,7 @@ struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
 static void odb_source_free(struct odb_source *source)
 {
 	free(source->path);
+	odb_loose_source_free(source->loose);
 	odb_clear_loose_cache(source);
 	loose_object_map_clear(&source->loose_map);
 	free(source);
diff --git a/odb.h b/odb.h
index 2346ffeca85..f7e1bf87803 100644
--- a/odb.h
+++ b/odb.h
@@ -48,6 +48,9 @@ struct odb_source {
 	/* Object database that owns this object source. */
 	struct object_database *odb;
 
+	/* Private state for loose objects. */
+	struct odb_loose_source *loose;
+
 	/*
 	 * Used to store the results of readdir(3) calls when we are OK
 	 * sacrificing accuracy due to races for speed. That includes

-- 
2.51.1.930.gacf6e81ea2.dirty

