Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B321147B
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860057; cv=none; b=D7aXkfOgnwIrzUbPGIapgYtIOu2n9SBRiZ4Xn/lPgHKs40nCwLYCeQ8LpoCegyUT2OLN1WgMeMd4xSyunnH1tHH+YDnwDdi7rXGomevxACM+01k0iRipHSx3FtvieU1MIF9CeIdx/5I46gjPPc3Q4Vuu7PAX3A5G/5v57g+etoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860057; c=relaxed/simple;
	bh=HOL8awrclugrhV/K/xSlfRR/oHErfTWxtYtnpYE+C8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XPhYmC69fxZUjnzr5RxQwNf/LEFhs0xlF+2ExqOMbikjtaOA2tWLG3VwkSgYM+W5LaMLBOrTqOXFs+97D3ZJUVNDRFT8DuKeEVOV8ED4QN/IYz/QnzKzTlpr5vDRGIgMEiqHMTF750eAWEiT5Rb985D7ojtqA0quv/z1Ed9qFQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XfTCqGO5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V41aNFyM; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XfTCqGO5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V41aNFyM"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id DD8B41140151;
	Mon,  2 Jun 2025 06:27:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 02 Jun 2025 06:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748860053;
	 x=1748946453; bh=EAyIepFJgFgFM2GMxxO/oyc9AyeeMI386bZnp9YkH8E=; b=
	XfTCqGO5KaFmHtc3goO2tMKYTC4j4BOJ2v6cD47r4GdzLTkUI6b5sG6uo5PyEEJ2
	oo4AXY0FhEr4fcXv8KBorziShX3/Ref0EJSHjBRX0Rlc/55hjzrNX/TbrZ5R+OoJ
	ACMzRDzX0eG7ThxIiRSZI2DWrJVuKPp6ibymciVC+GJS1hlaCxXRO3sOTMB/i0T7
	8REgH5mL7lXU+17P8pV+9mp/HeCZosBJFa7ZbEs+H1S8zW/kZw8wDUfCaWMCqMw7
	+1sdAmS3TqZE0K2KeE+p+vs8ZklSZaQf83E5qsymqi7x/DkvpNnmqRLeZtwkHeZe
	Leg+awOMnC0inaMb0fPkdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748860053; x=
	1748946453; bh=EAyIepFJgFgFM2GMxxO/oyc9AyeeMI386bZnp9YkH8E=; b=V
	41aNFyMM8a/BUKX3Og9iJCjTD5avxMp/llSGf/asfqRCDhPmMoUGg0wd0+J9B6x4
	x4i62hKKXzTc2OnNBLFAVLl/tZua2E8tcLQIvfpLTdoLlGxNNx8XhWoCvb5fDm7k
	vdZzOCsUSSFjQLMGifdL/Kg9FIUGziYM9NoXWWrJH7EDae6FxyO8sCLpZotSP98F
	fkM3N+TjbjBrRXhKIt6TIKF80FIVavstF90R0uqdsXYuJu8X2exz6zXzy16z2wnt
	nS2UqYM2hI3hpkMQOd4cMsUHazJVzsxiCZ07h5aBG0xRKwiiuIzVE0Bz48acz37W
	TsuAI4IsTQ5TKIgpSiW+A==
X-ME-Sender: <xms:lXw9aHmcpBg9ZGpmh705v39_lb5FL8BS9_UEdACt2mvYFVeuezcRlg>
    <xme:lXw9aK1xLdi1AaarK7HEgwWjAcGDYIzr2XmfogLE9xIG9F2hDV_cPX8tT413chkcf
    UXO70A3DaZ3R9ogwQ>
X-ME-Received: <xmr:lXw9aNosV6jf9LBoCWGPJuAY0Mr6oWAoDZhxJguf8MEvELBgCE2begkrepoNuiJpMIVhq4k_-5gzAomeF0Y50qmyO9F6eo1kp82Us4t7RhQRUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeegvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdp
    rhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:lXw9aPlgRamMrXlNyr2LU6w1MPYLFEXdAOfrss3Jrq-wHpJ67KM3JA>
    <xmx:lXw9aF3EefdKMM74G7lWUuAX4vsJMWNRZHp2Un1jYrGk18yZ9IUzYQ>
    <xmx:lXw9aOvF5vER9h86c-Ztm6FiVKaWLJmMxmXLICBQvxTO5mjhRdH_eA>
    <xmx:lXw9aJX4VAYF24DNxXX_hQnoCMl-FGgegkxSNoD5oPFNFis2aCHxTQ>
    <xmx:lXw9aHMtfL9fDux6eGJjyxJ7TFMM3Cr2I4F2SgWvfyJ_2g1YiiEashfB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 06:27:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5003999d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 10:27:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 12:27:17 +0200
Subject: [PATCH v4 16/17] odb: rename `pretend_object_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-pks-object-store-wo-the-repository-v4-16-e986804a7c62@pks.im>
References: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
In-Reply-To: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Rename `pretend_object_file()` to `odb_pretend_object()` to match other
functions related to the object database and our modern coding
guidelines.

No compatibility wrapper is introduces as the function is not used a lot
throughout our codebase.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 blame.c |  3 ++-
 odb.c   | 18 +++++++++---------
 odb.h   |  6 +++---
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/blame.c b/blame.c
index 858d2d74df9..dce5c8d855c 100644
--- a/blame.c
+++ b/blame.c
@@ -277,7 +277,8 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 	convert_to_git(r->index, path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
-	pretend_object_file(the_repository, buf.buf, buf.len, OBJ_BLOB, &origin->blob_oid);
+	odb_pretend_object(the_repository->objects, buf.buf, buf.len,
+			   OBJ_BLOB, &origin->blob_oid);
 
 	/*
 	 * Read the current index, replace the path entry with
diff --git a/odb.c b/odb.c
index ad2a621698c..dd6b37eaa92 100644
--- a/odb.c
+++ b/odb.c
@@ -863,21 +863,21 @@ int odb_read_object_info(struct object_database *odb,
 	return type;
 }
 
-int pretend_object_file(struct repository *repo,
-			void *buf, unsigned long len, enum object_type type,
-			struct object_id *oid)
+int odb_pretend_object(struct object_database *odb,
+		       void *buf, unsigned long len, enum object_type type,
+		       struct object_id *oid)
 {
 	struct cached_object_entry *co;
 	char *co_buf;
 
-	hash_object_file(repo->hash_algo, buf, len, type, oid);
-	if (odb_has_object(repo->objects, oid, 0) ||
-	    find_cached_object(repo->objects, oid))
+	hash_object_file(odb->repo->hash_algo, buf, len, type, oid);
+	if (odb_has_object(odb, oid, 0) ||
+	    find_cached_object(odb, oid))
 		return 0;
 
-	ALLOC_GROW(repo->objects->cached_objects,
-		   repo->objects->cached_object_nr + 1, repo->objects->cached_object_alloc);
-	co = &repo->objects->cached_objects[repo->objects->cached_object_nr++];
+	ALLOC_GROW(odb->cached_objects,
+		   odb->cached_object_nr + 1, odb->cached_object_alloc);
+	co = &odb->cached_objects[odb->cached_object_nr++];
 	co->value.size = len;
 	co->value.type = type;
 	co_buf = xmalloc(len);
diff --git a/odb.h b/odb.h
index 09cfd9e01f9..8eaa4ba7ba9 100644
--- a/odb.h
+++ b/odb.h
@@ -281,9 +281,9 @@ void *odb_read_object(struct object_database *odb,
  * object in persistent storage before writing any other new objects
  * that reference it.
  */
-int pretend_object_file(struct repository *repo,
-			void *buf, unsigned long len, enum object_type type,
-			struct object_id *oid);
+int odb_pretend_object(struct object_database *odb,
+		       void *buf, unsigned long len, enum object_type type,
+		       struct object_id *oid);
 
 struct object_info {
 	/* Request */

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

