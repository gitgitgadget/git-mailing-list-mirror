Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9812820DD57
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068655; cv=none; b=mvxzQLDK+m3EmUtVQWXf0UHJ6vew5DSI5oXm54YKLIOJPFwf9dlYT2ql8fLGWboUlRt0jDGFtx1Ch9lgK8Ea2znjVXoEQO2UiJd/Jllj+rXooIyAx0L6GB8ha4g99HYSBr00LSNY/afpgh6BiRn/eDCuVrP1wqSIvuPgPYv+67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068655; c=relaxed/simple;
	bh=irV2AYnq53NNlWvY94ZhJns4XvttmizgElFfX4ptNuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EssybAoQAU1zD9RukxncI1NNLK341ycbMVa+peKyE3U02AOGHTLkt6J8y/oOxI1qgBApFPzG9XcDiJsBfYaSMFC04Tv6qduxaUipeeczr4TNp6YBaUAWe4a5vDQr6vk7rGKzzilh9N4CqNNFZLVPwT489owvhUN6gQcopFpvNoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mDCFQcnz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n1daXkVN; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mDCFQcnz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n1daXkVN"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87F8111401F4;
	Thu, 27 Mar 2025 05:44:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 27 Mar 2025 05:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743068652;
	 x=1743155052; bh=LWiZ12T9KHSri8DSTPWaBiDhBldh58xm+WN7Qx0Lytc=; b=
	mDCFQcnz8J1v0Nbc6ChrOdhjM17DNPt0nSUiWW7gOtiKgPtf1gqCpG5zJcGvaRHY
	7Li52L2sk36CQGiwcd66KpVywBF+0dVZUw0F11AMgI9ReMpvg0IhM2QKZcl6jAQa
	28m65hejXuhMJEY0ou+Z4jgTxDk5iAGXYFXZbQ2fPvf7U0z33672NcKyua+qNkqA
	kekc6EIxdUnEoJ/4oieYLrNoI2yjBqCMtORuKJpnebRM0VJf/8C3HKdsUMgVkUIS
	oy+w0ncbHotFOWdb4gMIL7Jl8VdpKWdVI19ZwOna2yUxKmiI6t6tdslcbjwiE8pc
	bUKfp1XQCGsHrjbVWBi+DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743068652; x=
	1743155052; bh=LWiZ12T9KHSri8DSTPWaBiDhBldh58xm+WN7Qx0Lytc=; b=n
	1daXkVNm5LIaAiWG04BzQxPEIYe7N3z1JJM9BJFYlibhOvGjk0Wr2GBfEQH3u1NS
	dmZX3tS57ljC6xNYBxUJxsZW4AZsnYTACKxovFEpjVBpLVcffHUfXlMCzLc8sSZc
	/2nnCL7xagKyWDroTlKSJD+k2yF2t6NBXp3DmILmdIs4HDygC2OEiJsEf+JQE/IL
	9vkdlAttKe1GEJvmn5CzHmhX2/JGU+cchps+d+OkAnwduGS6OaJOjWIyDjMAxVFD
	Gmu+1V6kgklp6FZNgbKRFKbroCYfNgHOTTb1MjSQnG3AZy/Te+Ty8ZEe7TBAMA1L
	KPJnO6FrkMk/SxiE5SmBg==
X-ME-Sender: <xms:7B3lZxMLcdLHFfQfmAzRBXoFIq9d05od_b_JaG-zc4nkDFUFw5ZtHA>
    <xme:7B3lZz_ljiEyW5P3k-luUaJbEIk6w5R_44GecxcXgUQc2UYaTvPcptDS6xE13O2-B
    H0Xccim4y4xO5wP3w>
X-ME-Received: <xmr:7B3lZwSOQps2TbelyPTNbwvViBBfK_8Hg200_c68eRu3WaIhcmt4KqHWgPpzdl0vA20L6KjsMAYwPINKYz-SK1g6K4H0XT79zjxMHo8bQ1_U2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:7B3lZ9t7gY_NmdAaaMyQAvcNLtRCPcyOmuZ4vxDiV7SOzy-DfdRGkQ>
    <xmx:7B3lZ5dCkMMavR5fxizvo1hrXmI6WUPDoIyjC4_z7FO2XM49S-xjlw>
    <xmx:7B3lZ52gWrZIXCrR4kYojX35z4dh8CgGcQvHX7J8o_PFw3IhbPIWaw>
    <xmx:7B3lZ18CPbr9q1TY6Kb_eSwEz9k5X55w0NGp9-NYiniugtdx8JJcaw>
    <xmx:7B3lZyEW6qW0cbAzXmMWvYfOzQbWL2Tgbg7ZDwwheNQQetm90tlbfI9M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 05:44:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a1a095da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 09:44:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 10:44:04 +0100
Subject: [PATCH v2 09/10] builtin/cat-file: deduplicate logic to iterate
 over all objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-pks-cat-file-object-type-filter-v2-9-4bbc7085d7c5@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
In-Reply-To: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Pull out a common function that allows us to iterate over all objects in
a repository. Right now the logic is trivial and would only require two
function calls, making this refactoring a bit pointless. But in the next
commit we will iterate on this logic to make use of bitmaps, so this is
about to become a bit more complex.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c | 85 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 37 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 430320adfe9..6f5dbc821a2 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -622,25 +622,18 @@ static int batch_object_cb(const struct object_id *oid, void *vdata)
 	return 0;
 }
 
-static int collect_loose_object(const struct object_id *oid,
-				const char *path UNUSED,
-				void *data)
-{
-	oid_array_append(data, oid);
-	return 0;
-}
-
-static int collect_packed_object(const struct object_id *oid,
-				 struct packed_git *pack UNUSED,
-				 uint32_t pos UNUSED,
-				 void *data)
+static int collect_object(const struct object_id *oid,
+			  struct packed_git *pack UNUSED,
+			  off_t offset UNUSED,
+			  void *data)
 {
 	oid_array_append(data, oid);
 	return 0;
 }
 
 static int batch_unordered_object(const struct object_id *oid,
-				  struct packed_git *pack, off_t offset,
+				  struct packed_git *pack,
+				  off_t offset,
 				  void *vdata)
 {
 	struct object_cb_data *data = vdata;
@@ -654,23 +647,6 @@ static int batch_unordered_object(const struct object_id *oid,
 	return 0;
 }
 
-static int batch_unordered_loose(const struct object_id *oid,
-				 const char *path UNUSED,
-				 void *data)
-{
-	return batch_unordered_object(oid, NULL, 0, data);
-}
-
-static int batch_unordered_packed(const struct object_id *oid,
-				  struct packed_git *pack,
-				  uint32_t pos,
-				  void *data)
-{
-	return batch_unordered_object(oid, pack,
-				      nth_packed_object_offset(pack, pos),
-				      data);
-}
-
 typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
 			       struct strbuf *, struct expand_data *);
 
@@ -803,6 +779,45 @@ static void batch_objects_command(struct batch_options *opt,
 
 #define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
 
+typedef int (*for_each_object_fn)(const struct object_id *oid, struct packed_git *pack,
+				  off_t offset, void *data);
+
+struct for_each_object_payload {
+	for_each_object_fn callback;
+	void *payload;
+};
+
+static int batch_one_object_loose(const struct object_id *oid,
+				  const char *path UNUSED,
+				  void *_payload)
+{
+	struct for_each_object_payload *payload = _payload;
+	return payload->callback(oid, NULL, 0, payload->payload);
+}
+
+static int batch_one_object_packed(const struct object_id *oid,
+				   struct packed_git *pack,
+				   uint32_t pos,
+				   void *_payload)
+{
+	struct for_each_object_payload *payload = _payload;
+	return payload->callback(oid, pack, nth_packed_object_offset(pack, pos),
+				 payload->payload);
+}
+
+static void batch_each_object(for_each_object_fn callback,
+			      unsigned flags,
+			      void *_payload)
+{
+	struct for_each_object_payload payload = {
+		.callback = callback,
+		.payload = _payload,
+	};
+	for_each_loose_object(batch_one_object_loose, &payload, 0);
+	for_each_packed_object(the_repository, batch_one_object_packed,
+			       &payload, flags);
+}
+
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf input = STRBUF_INIT;
@@ -857,18 +872,14 @@ static int batch_objects(struct batch_options *opt)
 
 			cb.seen = &seen;
 
-			for_each_loose_object(batch_unordered_loose, &cb, 0);
-			for_each_packed_object(the_repository, batch_unordered_packed,
-					       &cb, FOR_EACH_OBJECT_PACK_ORDER);
+			batch_each_object(batch_unordered_object,
+					  FOR_EACH_OBJECT_PACK_ORDER, &cb);
 
 			oidset_clear(&seen);
 		} else {
 			struct oid_array sa = OID_ARRAY_INIT;
 
-			for_each_loose_object(collect_loose_object, &sa, 0);
-			for_each_packed_object(the_repository, collect_packed_object,
-					       &sa, 0);
-
+			batch_each_object(collect_object, 0, &sa);
 			oid_array_for_each_unique(&sa, batch_object_cb, &cb);
 
 			oid_array_clear(&sa);

-- 
2.49.0.472.ge94155a9ec.dirty

