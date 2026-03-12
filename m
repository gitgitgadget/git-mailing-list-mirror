Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40537379EC0
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304992; cv=none; b=Kio4d8/ThqUp9ZFN58vGs6MN6sKFNq5yf/OaVrAoFnIiMH/h3vo+087KAOOD1tauPzllJzLl07a/ty87TJP/1OHumKqaD5uYXghAibkljKEInLoP74LVM35YLEfv1cpj/RaGrpFFae5x0xikqDlxz5hLhA/85SBYbZE9oq6QQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304992; c=relaxed/simple;
	bh=DbU8H4RWlUPHrobDldmDByw1DPlocA+ob5wSs43VMpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=egIop7NFmmDnRvu+i9m8qR5o2USx/leALl7L7HkIl5h39gM/fkG3rctne8oTb09t/0EPP0d6yDC4eAqE7Bk/VEeDBGVigmqzFXKujTFhNSJWXmVEEmLgqieVUfpRaBF6e04ia21PAo4JPSSSgCp6CyF6EPx5eSusTBpjCE/jpQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gWMARcnI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mmgPMqhQ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gWMARcnI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mmgPMqhQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 550E3EC00DF;
	Thu, 12 Mar 2026 04:43:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Mar 2026 04:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773304989;
	 x=1773391389; bh=muMAu8LVtrtFiVc6GeANJ/wRFZif3NCXvaqhVtHcG+k=; b=
	gWMARcnIaFvrnTX2fboTu2gbuAjStq6+FIIqV9jc8wBSGZttKxQn409NeGGfhf1b
	vvN9pyNjc3W/waDLF9SCiw1X/6w/PV8QQlMWjVQwEKtHAgCa5uqAhz2lC3Y7N1Uv
	rt0Wf5GW596jRnbWQq/rxRW2xyzRbCbvF1syQkYcwf5+Vc8NyAJS/Vm69r0FvsMF
	aEDfGkI1ra810tlPS9rkpMg/mE3fzC9CM4rECXW0OsZDDp2MTlrvNAPULaxvxktW
	YmEl7b3AJnR0iLyrMD7CihZQjTbK7kXYAyxsUUsP4NTWhbOiMZdahH/dr7JMB6Xj
	fVhtG8CqABTTeDfVc+VHXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773304989; x=
	1773391389; bh=muMAu8LVtrtFiVc6GeANJ/wRFZif3NCXvaqhVtHcG+k=; b=m
	mgPMqhQh0B3huqYgIz07Dd2RJIgOTTYHLYLm9pbcn4v8nZv4JiC4ryubOHGlEKsR
	xYotZcB552SdcLh4ZG0LMLvXg6bYtru4ctaW55/F7zvzf24Lo9L8zCgtz84crrYy
	eMzZUdQEopO3Fykzmff2wcJEodewWu79Xc/vUmSFKPjy9UI9u0BtwF5VYYkfuQD/
	nV3Xg4ZnpO948GYeyf/83KAJQ1NnO90CCXPW/ETzeKeO1rlLrT+dkdlRi+tWVahd
	A7BjKsVYdeA9t8gQnP37nrXi891VLWxhH9dI6e4QZPFehCn/sToMQQwa+zWRqUx4
	LN+Ik48SA3jYkIvr4XxSQ==
X-ME-Sender: <xms:nXyyacbBgpOfmVNh8ASEJpvDnHYtMyGTle6i5D5ztR2QpXMVh3NhQA>
    <xme:nXyyae1cHlHGb10c3zQ-42FpyjW9GEE0VUnaFM2MmBL4ucj-BcoONXcFZ2hUBeivB
    et2aBUF_fWdDw1tURp6Mbk4tjafZx5W8tOzG4qennQmy5omcIGiiw>
X-ME-Received: <xmr:nXyyaUWHZDaCvBpNHgUoBUQjBoF_RF4FCe7xqDmP2e1MwLkN_8PqHkv7LDF4HBRt6hxMTqfFaJQ_X7XZf82feCkaVmUMjqyfY_8E8bRrmVg_8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeifeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nXyyaQUavOw9CHfwii8NNfZVAguWXaGw6D-JK8zIO8Er6BFexJOOkA>
    <xmx:nXyyabcNdYibzGHKladzxg2srJHnhg_A6D4wNIlqBTs54OftToNBlg>
    <xmx:nXyyaRXCbqWz7IhbKqyG5j6XO0PrM3XIR75jSlAeCuTy5v7VhRUL2Q>
    <xmx:nXyyaceKtoHAKIqEMFcx2s3LPvwdcGZ3w1WUe_QE8Ij9IsbLt71pkQ>
    <xmx:nXyyabexdpN-BPt_TvYxITDUbQlZdtvUxCU3ndb-xHQSTOx9uo-_iNii>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 04:43:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 622a9deb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 08:43:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Mar 2026 09:42:57 +0100
Subject: [PATCH v2 2/6] packfile: extract logic to count number of objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-b4-pks-odb-source-count-objects-v2-2-5914f69256bf@pks.im>
References: <20260312-b4-pks-odb-source-count-objects-v2-0-5914f69256bf@pks.im>
In-Reply-To: <20260312-b4-pks-odb-source-count-objects-v2-0-5914f69256bf@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

In a subsequent commit we're about to introduce a new
`odb_source_count_objects()` function so that we can make the logic
pluggable. Prepare for this change by extracting the logic that we have
to count packed objects into a standalone function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 45 +++++++++++++++++++++++++++++++++++----------
 packfile.h |  9 +++++++++
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/packfile.c b/packfile.c
index 215a23e42b..1ee5dd3da3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1101,6 +1101,36 @@ struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *stor
 	return store->packs.head;
 }
 
+int packfile_store_count_objects(struct packfile_store *store,
+				 unsigned long *out)
+{
+	struct packfile_list_entry *e;
+	struct multi_pack_index *m;
+	unsigned long count = 0;
+	int ret;
+
+	m = get_multi_pack_index(store->source);
+	if (m)
+		count += m->num_objects + m->num_objects_in_base;
+
+	for (e = packfile_store_get_packs(store); e; e = e->next) {
+		if (e->pack->multi_pack_index)
+			continue;
+		if (open_pack_index(e->pack)) {
+			ret = -1;
+			goto out;
+		}
+
+		count += e->pack->num_objects;
+	}
+
+	*out = count;
+	ret = 0;
+
+out:
+	return ret;
+}
+
 /*
  * Give a fast, rough count of the number of objects in the repository. This
  * ignores loose objects completely. If you have a lot of them, then either
@@ -1113,21 +1143,16 @@ unsigned long repo_approximate_object_count(struct repository *r)
 	if (!r->objects->approximate_object_count_valid) {
 		struct odb_source *source;
 		unsigned long count = 0;
-		struct packed_git *p;
 
 		odb_prepare_alternates(r->objects);
-
 		for (source = r->objects->sources; source; source = source->next) {
-			struct multi_pack_index *m = get_multi_pack_index(source);
-			if (m)
-				count += m->num_objects + m->num_objects_in_base;
-		}
+			struct odb_source_files *files = odb_source_files_downcast(source);
+			unsigned long c;
 
-		repo_for_each_pack(r, p) {
-			if (p->multi_pack_index || open_pack_index(p))
-				continue;
-			count += p->num_objects;
+			if (!packfile_store_count_objects(files->packed, &c))
+				count += c;
 		}
+
 		r->objects->approximate_object_count = count;
 		r->objects->approximate_object_count_valid = 1;
 	}
diff --git a/packfile.h b/packfile.h
index 8b04a258a7..1da8c729cb 100644
--- a/packfile.h
+++ b/packfile.h
@@ -268,6 +268,15 @@ enum kept_pack_type {
 	KEPT_PACK_IN_CORE = (1 << 1),
 };
 
+/*
+ * Count the number objects contained in the given packfile store. If
+ * successful, the number of objects will be written to the `out` pointer.
+ *
+ * Return 0 on success, a negative error code otherwise.
+ */
+int packfile_store_count_objects(struct packfile_store *store,
+				 unsigned long *out);
+
 /*
  * Retrieve the cache of kept packs from the given packfile store. Accepts a
  * combination of `kept_pack_type` flags. The cache is computed on demand and

-- 
2.53.0.880.g73c4285caa.dirty

