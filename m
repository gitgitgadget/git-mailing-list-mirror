Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6602E9730
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761972; cv=none; b=U7iRbH73pD659fIELT6juYaMiRsNCFiM9OvIaom2J4vXMujj9A+aC4TeLoKHYpyZcHCdiot1/0YEONKW1vPIu0UbvrAGneVof3TCV54b4Ch4Vq4t2cGXYu4tFwV6U8xoVZs/PuIGCehn9G4aySNmsQ99s/1fXXNe0FORuYuCuNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761972; c=relaxed/simple;
	bh=3c9pPjNAN19opDygX9vkn9JLaDLJbyrEiOwqX230zTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KGUuOnu4tGCemD8vjbTX+2En/8SpL9fv2Z4qqNNAnZy2+q9c50EkOi5OTwMDVlx0+VeXOyVrsDE1nAeVDFaA8h2eoTJBrC0RXQF54k+lAB9cD+4cr3E6gknnShUbk7Uwuv2QdrSeeBqpvEQ1a2nylOMqaq/gKYJMK55HoVswauk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sq0aWyrr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MWgaAwxB; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sq0aWyrr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MWgaAwxB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1D39714000B8;
	Thu, 21 Aug 2025 03:39:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 21 Aug 2025 03:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755761970;
	 x=1755848370; bh=R72nRgaHkOwSEi5GaZ8NO2Ay23hZFl4iyZZkQ2rKous=; b=
	Sq0aWyrrrk/YjPVIhqvVJm5k+Ngz1W87wu8MntfmA1Noh6reTao5nh1ZvyZGceGq
	9/OE+n12tvoNJE+BLFrjMjAylGAUC89/OfK18+IlN/TX9XOaSbn0osQ6ksCRX1lk
	FEVIZUlnEHbcOd7VdGXenOAHgmTp+3pvMHj9P+VB/CEbk3mExpPA3GmWlUM6iqb/
	810n0NQ4FXWzf0gZdbIo8eD5whQgrYyGLYE+jF+68cgL5+RNEyyXfeJcP6cSa7iL
	rDYFIofxN/0UfVGRO8F2AiZ77D53dxfkCLM/cxa4JVvOFEg/zw2ja1XT6PpaFRPL
	uhSn6RtV2QSRUSAcJdBy6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755761970; x=
	1755848370; bh=R72nRgaHkOwSEi5GaZ8NO2Ay23hZFl4iyZZkQ2rKous=; b=M
	WgaAwxBF2KEODysJlYBPHfPdw98Hzp1x8Bm8g8Ly4Sm/XV4cotCWedCXb13+m9P0
	6NUvINsAZ1+wE0UWQXfzpBlc1p8paUEGE7Cjl2jRPyDQp8uoDR+PXpftaDq6kEXc
	mJkGKmdzSN+Tngaf5LNDao0YtolD3zj8Yv01JQbdTM+Lwua92yRvBqq92cOKhJk2
	MZoyygzOcvL+TC1dxQ0zs1yFx9JVx0ARlkX0UxKTtgtUAg9bj+z8h+bBjlVUGFHI
	CYGfM+rXmzWBlh5DS0UGpZoDdDf2fccbvLvWTaIt5bws3HcEDYwQ5dmS8C9s3FXr
	e1a+b0rUZJz0f9WO63YTw==
X-ME-Sender: <xms:Mc2maOI8gGl1Inp_d0JJn5OW0Hd95-BhgvIZcl05ZqNMzG6UVm-5Gg>
    <xme:Mc2maJYAI3NtWbceQh8hmFuORjzy_R-mC8wtSMKKar6AOd3UWB-Pfa3ANPqKV0wef
    0Mt8waIF_nqiY6yWA>
X-ME-Received: <xmr:Mc2maIKHgP9hTKPtA_MLRyWGOgWGTqdF-CQ7l3vM1-czHxTDkcRNJ3nNcv8EOzMMarB0TYWTY_6fKjw4EHoJLFoylOexgFGmI-EP00SXsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:Mc2maPD5sVVeVRpKGBQ6JOojEHxoOM4vSwlHWrnniDAaU6ZUMa1eEQ>
    <xmx:Mc2maFqMJveiqljHLdpqFMYcZ-UaUWXdAjZyWZoBIQLsPCzI7ZPhpQ>
    <xmx:Mc2maCioTbpQeVjyP_8T2rV1oc435x7HpC2d_jz8UPU83SfPlf3Eeg>
    <xmx:Mc2maKBJMzB50KUvM5Uhyjz446M2LSyho9hZnzP4a_ogaspq-vCwlQ>
    <xmx:Ms2maLC0W6Rk6raFBqX49utbdYbQeI0DJ9s6jHJzsKVicX1MLLz9RKCd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 03:39:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e99972df (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 07:39:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 Aug 2025 09:39:05 +0200
Subject: [PATCH v2 07/16] packfile: reorder functions to avoid function
 declaration
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-b4-pks-packfiles-store-v2-7-d10623355e9f@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Reorder functions so that we can avoid a forward declaration of
`prepare_packed_git()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 67 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/packfile.c b/packfile.c
index 07c574f359..90f15b0c20 100644
--- a/packfile.c
+++ b/packfile.c
@@ -946,40 +946,6 @@ static void prepare_packed_git_one(struct odb_source *source, int local)
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
@@ -1099,6 +1065,39 @@ struct list_head *get_packed_git_mru(struct repository *r)
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
2.51.0.261.g7ce5a0a67e.dirty

