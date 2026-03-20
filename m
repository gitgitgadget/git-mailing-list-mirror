Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31448359A6B
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773990494; cv=none; b=e2meC83qdFT9ddVk1a1S5HrbmbHIa4i0/cXPma0kAbCIsNwXzRVD+nnaNb8iD30Q67KfXi6Pz1rACkNl/OcqQU2E9vkqurcZlwNyrN5YxfgxtlGiFUR5u5ExahSS4J1VYnqiExYhlDXHjPK7LPNTcCSyTmlpyXrDhwk//N+Ga84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773990494; c=relaxed/simple;
	bh=rHpbvQ+OiFhiv++FXrDZMtvQO0QNnsif00k4OJBKWx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MCoo0Wc6i+Ffr9VJprpeRs3lDsj/CwxRFSPpgr1U0IHc7x5OArdbJN3yADTf3fPeADla67uz7gcpkp6W1Z0lLYLcvmnzqhzYuWRtEXn50FjyAm8t9bnPoODe1RbeAvgsn7CBtusEmksrewtVxI8lqBr182VLZ0e0AgH17rtv/7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GDQdPVeW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fdjkUKfX; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GDQdPVeW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fdjkUKfX"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 73B2FEC018B;
	Fri, 20 Mar 2026 03:08:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 20 Mar 2026 03:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773990492;
	 x=1774076892; bh=Q/iNgF3mbahp8w07rseD2TUd6ql7S09h8dq481zOz7g=; b=
	GDQdPVeW2NJpkXXiRBqUS12hFDUtpN+0hZfArORIzIpbJvjQ2IkoXIsMloiuq35n
	PMlj63LyCl9tWRrhF2jVT205ehofP9Mg2e2xeOvFGB5Bwb/CcUeb3vxJ7/f1A8sc
	EwR/PvbP8+i/RIFB6GKOWMYYTHRHHbhGpXczvSG0ECsqSDYxMklJnESGQX2yTgVW
	314Uz4C/FSGnRTtOiD71tqzJcxXdoPCshXs/Ighp/sJjywS+05VkOaliFvj6uAbU
	sZDbX6xEnr1NHNGDx5is+w11wnbh8eLS3KOL0LGXpYxsWXNz8uVtGaaFA5zPiIO7
	jXc7i09dOR2tQP32q5eSJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773990492; x=
	1774076892; bh=Q/iNgF3mbahp8w07rseD2TUd6ql7S09h8dq481zOz7g=; b=f
	djkUKfXkei6kLTVO2aCbDg/2qX0iBAKLIoscPczrOPJWvBvYUaLWi2Pl/ZQRX1/a
	EqCaBxIh82VDB46M1EHsj+N9HoGjloMTHezFvRjpW/WOxbNF8YqCN8RViJPjiqfU
	9xID/l4gvWWezdVI/Bne1LDi57LfMrunGcIGuJobf/+hmgjoNAt1M3mftdzFKAPS
	l55aYai8J7dl52PmYPQLEQuVEYfRPPYwVYrOp0yHgBaWt3hJ3h/1V9x24pwiJfdZ
	x0ahp69Hyic+bavUJEjLSajSpAc/p3Xwsw02W4DVezI/wlzC9W2u/nIFbTOLHoFL
	2T1qNIaOhhtMXYik4lYhA==
X-ME-Sender: <xms:XPK8abt8BqryraN5J9qHxi4vL002wM_QzA9DzVScu1nTJ7TGfBDyQQ>
    <xme:XPK8aT4VCRFjRVjtuSKD6fLOSU3RJLcb0qzllwz64C8xI9cmaUor-An0Tyv2R-6rT
    quWCev4gy4-FITDsTcdo1ubNCQH8yrFl8qAp86lOtPeV7vAQsOjkg>
X-ME-Received: <xmr:XPK8acLHmfdYg6jA55eQBWFI2uP8q89yGkGsw1eeJ4UVWtgl-xb-2jWnEKHI0IsqEvUz04S32pe0biexlkwYNnZlNTN0xFCoYkbC4-a7bGhq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:XPK8aT7dlOF4CHusUmk3hs6Pym71FqkqeCoqUb1wsfZ61vzOHnBWgw>
    <xmx:XPK8afxise6VA7IMmA7-sCvliqYDU6I6rC6VIsGO3E7IHQiUMkLOnw>
    <xmx:XPK8aXYOV9M_CzuzsgWxP-bS-Tyr-EdITtp-P6gDvbV69HiutTE-1w>
    <xmx:XPK8aRQ2qkm4X8B6HK0Dq2O_UcjnfwhIWu6bvyrNCWzsHRIHSw3yrQ>
    <xmx:XPK8af54cAmZG2aZNPdUrtE5f5ska_oHSnty48prfEKdsy6wY86s63RV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 03:08:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1e51e320 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 07:08:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 08:07:37 +0100
Subject: [PATCH v2 11/14] object-name: simplify computing common prefixes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-odb-source-abbrev-v2-11-fe65dcd8c735@pks.im>
References: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
In-Reply-To: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The function `extend_abbrev_len()` computes the length of common hex
characters between two object IDs. This is done by:

  - Making the caller provide the `hex` string for the needle object ID.

  - Comparing every hex position of the haystack object ID with
    `get_hex_char_from_oid()`.

Turning the binary representation into hex first is roundabout though:
we can simply compare the binary representation and give some special
attention to the final nibble.

Introduce a new function `oid_common_prefix_hexlen()` that does exactly
this and refactor the code to use the new function. This allows us to
drop the `struct min_abbrev_data::hex` field. Furthermore, this function
will be used in by some other callsites in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hash.c        | 18 ++++++++++++++++++
 hash.h        |  3 +++
 object-name.c | 23 +++--------------------
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/hash.c b/hash.c
index 553f2008ea..e925b9754e 100644
--- a/hash.c
+++ b/hash.c
@@ -317,3 +317,21 @@ const struct git_hash_algo *unsafe_hash_algo(const struct git_hash_algo *algop)
 	/* Otherwise use the default one. */
 	return algop;
 }
+
+unsigned oid_common_prefix_hexlen(const struct object_id *a,
+				  const struct object_id *b)
+{
+	unsigned rawsz = hash_algos[a->algo].rawsz;
+
+	for (unsigned i = 0; i < rawsz; i++) {
+		if (a->hash[i] == b->hash[i])
+			continue;
+
+		if ((a->hash[i] ^ b->hash[i]) & 0xf0)
+			return i * 2;
+		else
+			return i * 2 + 1;
+	}
+
+	return rawsz * 2;
+}
diff --git a/hash.h b/hash.h
index d51efce1d3..c082a53c9a 100644
--- a/hash.h
+++ b/hash.h
@@ -396,6 +396,9 @@ static inline int oideq(const struct object_id *oid1, const struct object_id *oi
 	return !memcmp(oid1->hash, oid2->hash, GIT_MAX_RAWSZ);
 }
 
+unsigned oid_common_prefix_hexlen(const struct object_id *a,
+				  const struct object_id *b);
+
 static inline void oidcpy(struct object_id *dst, const struct object_id *src)
 {
 	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
diff --git a/object-name.c b/object-name.c
index d82fb49f39..32e9c23e40 100644
--- a/object-name.c
+++ b/object-name.c
@@ -585,32 +585,16 @@ static unsigned msb(unsigned long val)
 struct min_abbrev_data {
 	unsigned int init_len;
 	unsigned int cur_len;
-	char *hex;
 	struct repository *repo;
 	const struct object_id *oid;
 };
 
-static inline char get_hex_char_from_oid(const struct object_id *oid,
-					 unsigned int pos)
-{
-	static const char hex[] = "0123456789abcdef";
-
-	if ((pos & 1) == 0)
-		return hex[oid->hash[pos >> 1] >> 4];
-	else
-		return hex[oid->hash[pos >> 1] & 0xf];
-}
-
 static int extend_abbrev_len(const struct object_id *oid,
 			     struct min_abbrev_data *mad)
 {
-	unsigned int i = mad->init_len;
-	while (mad->hex[i] && mad->hex[i] == get_hex_char_from_oid(oid, i))
-		i++;
-
-	if (mad->hex[i] && i >= mad->cur_len)
-		mad->cur_len = i + 1;
-
+	unsigned len = oid_common_prefix_hexlen(oid, mad->oid);
+	if (len != hash_algos[oid->algo].hexsz && len >= mad->cur_len)
+		mad->cur_len = len + 1;
 	return 0;
 }
 
@@ -785,7 +769,6 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 	mad.repo = r;
 	mad.init_len = len;
 	mad.cur_len = len;
-	mad.hex = hex;
 	mad.oid = oid;
 
 	find_abbrev_len_packed(&mad);

-- 
2.53.0.1055.ga2ffed1127.dirty

