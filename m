Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B2F3491F2
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947601; cv=none; b=Sa8hbTc2mqEv2JJhLif4yjIjuQj7nO/50E7+IKvA8KQQD5ylc/Vpetc6HC1BS17teBfBIymi6SZ+hgZk8zSShV4AJ6dc4EbxTZCBvbptOr2cNuYxEFmXCX3+zDswkxYmwV3Fk2sKL7E48pNxRl5QQPgvvebc8dhk3Z2t6pVKEjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947601; c=relaxed/simple;
	bh=+5uQZCoxrudCr0hdZMdZ0vCV+dLQ6CFhsRvdDySccqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ssl5viltvTZ5SbscyI1sVgm57CkPVfCvuk7oNQi+KexDusS30c33kHf8+3CLwFanaTt1RE/jgmUTKqvhIGwVKv5CzRUyI1aC+Qmi4tk8PocvLWTEuHsPm+r1k6dfEoxYWmiD0jMybZTtEcmUOLQPg7lct3pO6EEO3lWXD4o2i9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VMjnKVVH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jDcXeUyx; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VMjnKVVH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jDcXeUyx"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7355714000D1;
	Fri,  9 Jan 2026 03:33:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 09 Jan 2026 03:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767947599;
	 x=1768033999; bh=JSEzEqFVKYNpg7PpyGIDZx8PKNthW8kPP0uwr4hBZMs=; b=
	VMjnKVVHnXs1cIy5NxnhJUpltIruAC+c1/nU0zTfvE+LiK9daeqIzNTQ2CUNusSk
	51/AKZP8JlZ+Y38eFSbVUqe9RCLIw0+o9nnhATmeM0L5m3ce9zH4/V42nUxodJQ0
	U1GIiddxn4J8qLXQ12oe2a0/qMASRYSapctIebUha/eOX98aPtd9t2mt8skm1wFe
	X9vF6ibuLoQUDCvWyGRo6h2TY7vfHBLU7nGD5Kzx+9GZSAWtSKJGs6wotVQn5HhM
	h5k72VjH9VmVWMvSCT3xFJESW6oZxBuhNSUy+5DOHaSPslzxv9XPOcD0ioJF0IHO
	z8DcCF58o8tAj+heRL4Q3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767947599; x=
	1768033999; bh=JSEzEqFVKYNpg7PpyGIDZx8PKNthW8kPP0uwr4hBZMs=; b=j
	DcXeUyxKoJh4HQ8GFdck2ipzJm1KzucnzuRQWfjrLQUfSTjycJcYHsegMS+4/+jz
	rf1zSa63BcS7WZa3ZtZQZqIvQmxh2cpXIw2Cobcr2npu/zpUjB/uac6uwHxPdHLY
	OoNOOdqFw5nIenebmrxJDT35YcGpchxRM56am4L2j/JYBwKLFRe4y1rcYg8WQA2y
	8DvyOGzCZcUo3AGoYp9g7RkSpjYNRSDNVVq3/DuEPlT5MGML7ckHWOvcZEwKyUv2
	QP4hyqsRJTa/DFNCy592zHqe2fx9Ma3JiCR9mK4q+RZQk33RTM1ibqbIjx1MojQU
	XYtUvhFV8CD9JeRYYRBwg==
X-ME-Sender: <xms:T71gadzNxwZaHUVJqem2WaoBqOECMaJSXJnuuhHK8wLRt-bJSCDRXg>
    <xme:T71gaUQPBVgRzsoES2Gy7u6IgK-bdRhF3AOJIycmuLJavV7a5wbNDsICV3OS0mT-M
    jwJRULo4a8eyj4wOz-DTSdv7mFNsD4IA0CY_tg7t2shD4BrINe3vw>
X-ME-Received: <xmr:T71gacWleH7XkhsY4tW7yfY8hvS85E6F1XwkQ34Sxa0bsG8-YGsLDtafSyZQBxtt6AijG_UHNNuxC2FcCdgxneBzhrqWNpgxcJq4ehRY1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttg
    hlrdgtohhm
X-ME-Proxy: <xmx:T71gaeagCb9LpEYSd4owpStlSqQ6oanpbVAaIOUALMeW9_aJYEQjWA>
    <xmx:T71gaa1b8XIvXrXqy7TidSZ8rroHRRRPVVyGgfdgj3UJEYgaufi_Kg>
    <xmx:T71gaYjEM6EUAEarI1UCAacO1b9dQA0dW6jwTvFZmrfvhGc3b8kGrQ>
    <xmx:T71gaWbx58oOSIWi3lu21p55OHOSmHuRHcetXtqIrw8v6VCxsbmkyw>
    <xmx:T71gabUFhwdmx9LNcwsvmbeNuFVDwV0hwBSoU_A8CzTJh304n0cXKEa6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 03:33:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dc1365b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 08:33:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 09:33:10 +0100
Subject: [PATCH v3 02/10] packfile: pass source to `prepare_pack()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-b4-pks-pack-store-via-source-v3-2-877fd7b7bf81@pks.im>
References: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
In-Reply-To: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.3

When preparing a packfile we pass various pieces attached to the pack's
object database source via the `struct prepare_pack_data`. Refactor this
code to instead pass in the source directly. This reduces the number of
variables we need to pass and allows for a subsequent refactoring where
we start to prepare the pack via the source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/packfile.c b/packfile.c
index 0a05a10daa..ab86afa01d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -975,10 +975,8 @@ void for_each_file_in_pack_dir(const char *objdir,
 }
 
 struct prepare_pack_data {
-	struct repository *r;
+	struct odb_source *source;
 	struct string_list *garbage;
-	int local;
-	struct multi_pack_index *m;
 };
 
 static void prepare_pack(const char *full_name, size_t full_name_len,
@@ -988,10 +986,10 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 	size_t base_len = full_name_len;
 
 	if (strip_suffix_mem(full_name, &base_len, ".idx") &&
-	    !(data->m && midx_contains_pack(data->m, file_name))) {
+	    !(data->source->midx && midx_contains_pack(data->source->midx, file_name))) {
 		char *trimmed_path = xstrndup(full_name, full_name_len);
-		packfile_store_load_pack(data->r->objects->packfiles,
-					 trimmed_path, data->local);
+		packfile_store_load_pack(data->source->odb->packfiles,
+					 trimmed_path, data->source->local);
 		free(trimmed_path);
 	}
 
@@ -1020,10 +1018,8 @@ static void prepare_packed_git_one(struct odb_source *source)
 {
 	struct string_list garbage = STRING_LIST_INIT_DUP;
 	struct prepare_pack_data data = {
-		.m = source->midx,
-		.r = source->odb->repo,
+		.source = source,
 		.garbage = &garbage,
-		.local = source->local,
 	};
 
 	for_each_file_in_pack_dir(source->path, prepare_pack, &data);

-- 
2.52.0.542.g9473a8513b.dirty

