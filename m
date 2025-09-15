Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573342F5318
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926493; cv=none; b=KjZMPjjEEc4RZmJ6weNsy1t5bsftibnMsPJ1lxn73zEC/l+dKClUihOHSAsCYiCgy59B6B2sJdG88X0xRBQ9WNS7YOBSYQyj2bJv/Dcc20lnQGd6JS4oZ23Pso1A+m0EWBfwFZSF1cFZnQ3OvSjaDNT8J/7zSoP0h1hRtOQxIUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926493; c=relaxed/simple;
	bh=qlL/n6k93CYmrYX42UhLqHQJ3Nz9sXVhqeWrQRPgym8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SNV2pznuUMIrG7aJdOUiuIGJbKrIX0jn2RcScaQcQ4xgd13G//puzBGkHhAgVbGFIv+4Vgu9blW79bTaepsIqrtMk2QR6nvbAPEWfBISpsPqnoxZc2/3JmlAgGIJvcpk4Reik9nBz4Krr3hqyUG1bs6aMc33/RF6WQ/YThwILPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QmoSKcGW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q/QzFWw2; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QmoSKcGW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q/QzFWw2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8818DEC0242;
	Mon, 15 Sep 2025 04:54:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 15 Sep 2025 04:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757926490;
	 x=1758012890; bh=566joM/xH9Vmh5Mpfy9oyzU+SCvJCR0fnyCJPf67QIc=; b=
	QmoSKcGWJW9Ny+h4DNJFIiBi+5fFDI0bYCiMh8YnOMUdKP+o2njaEh47huGZmJE8
	Tj0LD08OzSPjr+ZKi33tC6aw+m03WL+DIAsjh2xOR/k2BMMLTqA7I54Bg2FZ1muv
	AsdPDiS0SRIZ8LfLgI3mybrDfpQYOoZlV9Yx5BfcjeyZotLFDMF08A6ECpBwhFY6
	iMgKFKUJ4clpapZlb43x2Ns5BwlptKvKgGlHFGRyYrKNx3NfnCn7Hyh7Y9m7N3lv
	QOe8OTmhTxgcM9W8R05LWBHLtZaEz/DtXTR1e0nsKE9HS8Fu/bC9KvTM3htJ3NxT
	uxISnQi25QX/vLFHTsbcFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757926490; x=
	1758012890; bh=566joM/xH9Vmh5Mpfy9oyzU+SCvJCR0fnyCJPf67QIc=; b=Q
	/QzFWw24qe+HScwdyK2Qgvl09S+ON3vmMZRy8Mw5+9RlXiXknIt/FO0n1otxBoNp
	tQxVmk19H/mnbKMXix2ndARNnC6Pla1JLxSfq10PsYDNeSSmZOLmWIONsNWqAE97
	UBifBA3NUdgw9+Kipn9fXYKYVutL3uqjxapwoWpoCOdWCRlQf5vXdbXs1+YOC9LO
	71k0o1qRUvm5Ve1szK0xpAiFGhKtsAdgHDVFoFa6bpJCPR+xVUPQyFPuFjaWR5El
	2weCKtBhJRIaK8ulZFLMo/ZnrQAkUr6bhN1+/CzPJKwf2xHrs8rhmK1SxFtRpW0n
	we6tG+g9clIarZBTu9Ysw==
X-ME-Sender: <xms:WtTHaIZ6X97tA7Wg5_dEWvk4Oh3pC2r5BQug2BWnHsBxLmep6u2ELQ>
    <xme:WtTHaO4hVkGRjvP4eHXZyPjccLFv_mc6-rdw-yfz4A3fS5lN2WpZy_G_yhBWVqW_M
    zkN7S1yWrIbPMD3nQ>
X-ME-Received: <xmr:WtTHaJZwMWU7lUk9vEHMamJrgMVvtTzxiuyvqR0hV9wgHcr4gAULfagknhd2sD-OIpj5zCzTNjpUDdU3T7H4_94D_PIwWhzAOfvTgRyF5JVNnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:WtTHaNhwkZSK89m1cs5qLimtiTXbHJHRaQ-pi7VuuUiFyW9gikzm7A>
    <xmx:WtTHaK91a0i6ok25xZMAA2DeGDBiMGRUCnFfMtHJWtEYmo_utBUc1A>
    <xmx:WtTHaIqdCffyALCAB40gsW3Lx3fEFfOJuYRr1atWkPi6wZh_0p-tcg>
    <xmx:WtTHaCVRS7HrangIMxaal-MN5AKgo2fAI-MHetr5O5xsX0PoKqYQVA>
    <xmx:WtTHaNWMFBH73QrkU9GWJxaKjwS2m2SJMRHLhJQQ_QHJrgvLqSs4lOOH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:54:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4fa566d3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 08:54:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 10:54:25 +0200
Subject: [PATCH v5 07/15] packfile: reorder functions to avoid function
 declaration
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-packfiles-store-v5-7-d6340350934f@pks.im>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
In-Reply-To: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
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
2.51.0.450.g87641ccf93.dirty

