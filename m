Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C6B31CA75
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415811; cv=none; b=sl+LJEaNqrpSZgktTbBbA2Eh15KuNdF1T9ZhjXXA4YvM9aSvHX9E7LGq2TQz4bOw/UrcZ5/MCQhbMb4KZzzMptsHpCJ0XNNXiTkmH5iD0+nTC3R6Qu527Aa8ajzILpaKcs1zDXBi/dLjGczFfjxLsVArX++0Q7gZhx3/+wB50L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415811; c=relaxed/simple;
	bh=0dmCEcJ2htUk671wY+gdihivajaC027+6qYvm2bdBuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WPwxjpodaukt6EkoWuH/XLXMoGgSOX5ZpMivi/k15V/ARpsu3aITtCqchu9OkNKt+/9+472pzIZdqmLmgdPNSu15nfW5XjsusPkg3IvEkrJBwLX/Pq2spUPXS3W6QiKF9gF3dHwXNE84mtOiHSg+LLp4GnvPjflSuWJhyD4UU+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=em4rWP/D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ifZqthY0; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="em4rWP/D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ifZqthY0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2E7971400100;
	Tue,  9 Sep 2025 07:03:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 09 Sep 2025 07:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757415808;
	 x=1757502208; bh=SEPifKZo0mTEvD5Eze8YqmS7sEn7pca8f+lhIBdwTAU=; b=
	em4rWP/DTLqrye1bpEfzSRTwr4ltE+x6tU+k0S/H6GikivbwdN+obsTchoQFK2h2
	+8dIMsQ94wc5EPOYenPMo+AjBNV5WAN+/KIcVAiOR/DHKCeQdicofkKIu666Cq3I
	kc7fN0oVftZxzADoKQmZ6dExLF6/0qBNC5401PWMNhdaZ2BwXetNuxvCVOEShIGJ
	heWgKrcYbi8AOJj1p2vXtrHHwcl7ZIW3wpxnPJaN1wbeO7r6eRhD2pwFb1K3MFXo
	DaUO2tbAeEqkTjPIj2TVMLAh4+QrK6M/rkt+ZnShHLlhCh8+D/mLPTzCdQqXzGlR
	3giFHGkh0q8Gyhpccu9pgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757415808; x=
	1757502208; bh=SEPifKZo0mTEvD5Eze8YqmS7sEn7pca8f+lhIBdwTAU=; b=i
	fZqthY0/Cx2FpXjNhw/5h5irW9GXFhot/pKbEp1wur40u1DjTs8yKQ+uMMCdJTaW
	UmzfFnD2XQkc7XnRy5kBGdg/6lrQOKXL6/S/EEOc28Oz5JnBxpU1NVkv6esV37hK
	aOiE3G2KYatqTbWOG6oOFZMDmT+oA7zAJ2vMwo95CmOOfZlOXcfP/8ir8JzftO39
	kLfM15zU6AZ2F9EGS6hPZSm6ORTRpXC859S9PeMBv9f0JswRQdRB/DnTagsxb7Rc
	TTG9jnQDGXgneUzNwnE/qp+YItFpFqzzLNzfF5cf7xkqhBZ62W3mVz0mvd/DFCot
	Zebm9Mg6xV1Y3D5k56xCA==
X-ME-Sender: <xms:gAnAaGnqkQbMoFPfZMbqzU-No_BPxdwnXNsrro5VWzj3d8l6BYG2Lg>
    <xme:gAnAaJW3ma4nEnd8rhjB9wUYgXCn3V6kMn1v-prM2UdkN98Zbs0LIR1AS0VMTrrkt
    FjXPwSEbBhyaFOVpw>
X-ME-Received: <xmr:gAnAaLEyYGt77OyquQMhItLEVc122rXO2wnduId9Kh1yx18NMchc7285q4mfKm5mIGrk0ZpE-mQbP4gphoqdHajqcIA1_u132-P7EfW7TPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:gAnAaFdYwpNRWOuNJlAAHkHdmlYEfc0TL-MBAwg7uEje7Oa_TXb4_w>
    <xmx:gAnAaMIgTmuShD78vuXRAQsmSTlo5aEmVUu6yjfpB7RP35l0m1tQ_g>
    <xmx:gAnAaKGGw6YPOws6a86DMrejck2tq_ljE5QPtIuM0xNctWZJeZFpHw>
    <xmx:gAnAaPA5El5HVHb_zpX5Wofzf_hYbNv3A9tHgp_5LZ2M3_ZIdObSlw>
    <xmx:gAnAaIp4Esh16Von-WzYsZ2MmXf6WEoKP-fvZbfgU-ZltCDjpSrkn9CX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 07:03:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 25141c7c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 11:03:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Sep 2025 13:03:06 +0200
Subject: [PATCH v4 07/15] packfile: reorder functions to avoid function
 declaration
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-b4-pks-packfiles-store-v4-7-151c4ba3619f@pks.im>
References: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
In-Reply-To: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
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
index 2145a4edb1..59bc02575f 100644
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

