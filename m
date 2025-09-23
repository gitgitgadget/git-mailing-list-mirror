Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458BD32127D
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622653; cv=none; b=nHizt3WmgHxDakqpb9NHnSqcwc2mKGozJlytR8xCekCNbin7stDkXYK8P2z6w5YlH9aExS2zetknJstjA8380AFYvJ0pixQx2Mlbaen0PPCrwxsieaWdSR4qmIWQSRffr+JLI1xCrWU8re+GGDw2mhYSlxD4o/2PmJlwcSR9UL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622653; c=relaxed/simple;
	bh=Njcav+F0/slK8cTh8E9INbGE7JMbiJIVLxwt33b+9ys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=emOx9RyYy2CzIDNpGcVEY1/6fGdH2lIOqQqE5rSuFF7xGLt8TV89buOiED7zHfOjzB7QqagwvPS0xuIejpbDGcP1RrGOwmEM+vTYc96q9sEbWD6iuxqsvMFxOyYI7KeyJ63tMou8DogSVbG7mL1HQ3A3LhK+UIGLUpvyQ5Mzd9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PrKp2oEK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RC7H/LZK; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PrKp2oEK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RC7H/LZK"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 75BD11D002D0;
	Tue, 23 Sep 2025 06:17:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 23 Sep 2025 06:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758622651;
	 x=1758709051; bh=TggbCMkmrdghZxnr0TzdHYKMyZ2Zq/jormkxR8X7lno=; b=
	PrKp2oEKS1SDLhTo93Ancx2MrhMxWfoJXcSIpuWk27LxD7AtAgxt8LSM6Vwu704+
	GGa8eiAOkGtF2EWvvHgK11Ael4V/bDrkJVaxEqLd/0HsKUiNk03G1znuP1yc5m3T
	Uu52/7xXow5gie6WG4FTjCGXcEBwSKbblWq4wNMu0nFeZBqyEYjLV1LI8bya9W1E
	QKoAfYQAxi4E3zoyiSTn82kmiPqZbyFnGScH8jar5BrB5kvK5fJ8BEle1a/p/lXk
	54BPrjUOMYYKftcrepRlk3Js0w5H79K8fUCiWXVJGe8lg0K1Fe9NI3dTmHmd6GpO
	57bCbhO1HB1d5HCQTPDZgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758622651; x=
	1758709051; bh=TggbCMkmrdghZxnr0TzdHYKMyZ2Zq/jormkxR8X7lno=; b=R
	C7H/LZK5s7jqKAqOzauX+ybBCLiSj16m4umhBURsLYvLAGjyFy+ek2o/fYvyq4Gd
	W2qwcRSle2Oo2/CdmNnaegUlwB25yx0N6ncQT/9U2H6dWIyNAXdXwce3jy3vT55j
	7QTXwizHgzx3X9n3bAOLS++ndf0P2je0PBwulFOLfOVcwvPGTq9YxXiqeB1hhP72
	gNY0TSkQ4r6yZY1ROXRwyrCaJU+jDO4HegGUv3pA4LYSdll8EHiUmdGXxkd3c5RC
	yBqSIlOyUkGqLqJhriSmFq2v8EGtpoEZhmu2HTTkEBeeZ8rT1VLlV7kdVwQEWGzN
	tbSQ81rVxrIrOIHUQRDog==
X-ME-Sender: <xms:u3PSaFJQco1uPq9u-9-IeFEztpsKc4K9esizz6scSu-f-rWL7urxwg>
    <xme:u3PSaE0g3wzB7AeaJKKrParNG0rVpN4FS2h4nAX7AEv2kzbJyfPGuvEWBa6pcKJWJ
    ej5YahiLS5wE9cTGU7WjzAt7nYYlhsAzZTAxuOwqWT8zpyCqBaxRg>
X-ME-Received: <xmr:u3PSaHhJxce-InvEji5-JT-5z1DO-JXITFct_4S0H0p1zf4hAFtCEmk_mk2uYcqjR4mLEbnD4Sj9z8ec77GRjBtYGVJWhDCmnOF4V6d6--1p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomh
X-ME-Proxy: <xmx:u3PSaNWHj_0m_clInIq3j5crhcoJlqVpxayoZtyXvfOnibGNCpDAtQ>
    <xmx:u3PSaOUC-D4I7aAjpOmzfWHB5aDHXuTuF8-1EkAoyYt0wFS7LJY7hg>
    <xmx:u3PSaFgYf3LKGTkDy_polAbuzKnrT2d1b3oicUtCY0e3FZmeX5ZJBQ>
    <xmx:u3PSaBbkJL82tkNxoVSKxl4Lrbrh1FFlsrRoZHrtx0k_dl4QJuGM5w>
    <xmx:u3PSaMmmWfvmBRi6sPuymlKic6Y9C_ztmDpvEleccDe3FUpDJNDL6x3y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 06:17:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e6be9b18 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 10:17:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 12:17:06 +0200
Subject: [PATCH v6 07/15] packfile: reorder functions to avoid function
 declaration
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-packfiles-store-v6-7-b48f2a882759@pks.im>
References: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
In-Reply-To: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Reorder functions so that we can avoid a forward declaration of
`prepare_packed_git()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 67 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/packfile.c b/packfile.c
index 95a78f267f..5588a7ad6d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -946,40 +946,6 @@ static void prepare_packed_git_one(struct odb_source *source)
 	string_list_clear(data.garbage, 0);
 }
 
-static void prepare_packed_git(struct repository *r);
-/*
- * Give a fast, rough count of the number of objects in the repository. This
- * ignores loose objects completely. If you have a lot of them, then either
- * you should repack because your performance will be awful, or they are
- * all unreachable objects about to be pruned, in which case they're not really
- * interesting as a measure of repo size in the first place.
- */
-unsigned long repo_approximate_object_count(struct repository *r)
-{
-	if (!r->objects->approximate_object_count_valid) {
-		struct odb_source *source;
-		unsigned long count = 0;
-		struct packed_git *p;
-
-		prepare_packed_git(r);
-
-		for (source = r->objects->sources; source; source = source->next) {
-			struct multi_pack_index *m = get_multi_pack_index(source);
-			if (m)
-				count += m->num_objects;
-		}
-
-		for (p = r->objects->packfiles->packs; p; p = p->next) {
-			if (open_pack_index(p))
-				continue;
-			count += p->num_objects;
-		}
-		r->objects->approximate_object_count = count;
-		r->objects->approximate_object_count_valid = 1;
-	}
-	return r->objects->approximate_object_count;
-}
-
 DEFINE_LIST_SORT(static, sort_packs, struct packed_git, next);
 
 static int sort_pack(const struct packed_git *a, const struct packed_git *b)
@@ -1098,6 +1064,39 @@ struct list_head *get_packed_git_mru(struct repository *r)
 	return &r->objects->packfiles->mru;
 }
 
+/*
+ * Give a fast, rough count of the number of objects in the repository. This
+ * ignores loose objects completely. If you have a lot of them, then either
+ * you should repack because your performance will be awful, or they are
+ * all unreachable objects about to be pruned, in which case they're not really
+ * interesting as a measure of repo size in the first place.
+ */
+unsigned long repo_approximate_object_count(struct repository *r)
+{
+	if (!r->objects->approximate_object_count_valid) {
+		struct odb_source *source;
+		unsigned long count = 0;
+		struct packed_git *p;
+
+		prepare_packed_git(r);
+
+		for (source = r->objects->sources; source; source = source->next) {
+			struct multi_pack_index *m = get_multi_pack_index(source);
+			if (m)
+				count += m->num_objects;
+		}
+
+		for (p = r->objects->packfiles->packs; p; p = p->next) {
+			if (open_pack_index(p))
+				continue;
+			count += p->num_objects;
+		}
+		r->objects->approximate_object_count = count;
+		r->objects->approximate_object_count_valid = 1;
+	}
+	return r->objects->approximate_object_count;
+}
+
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
 		unsigned long len, enum object_type *type, unsigned long *sizep)
 {

-- 
2.51.0.536.g15c5d4f767.dirty

