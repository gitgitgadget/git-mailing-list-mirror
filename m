Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04323101C0
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155915; cv=none; b=S+7i+603fcqRGBAjlWSjwJwWOPGprjrwanMs7nzUxNIKSlYJBVICHWrm7/KzYPLAqEXS3eubILXeTeHrk3K4ZVZYN8u6y6oa0Xv1GQJ1DtlZSFN5bhWju/tZAPERTXjMNzJFJrPUq+I4YrfJv/qQT1euNjLH0yILGtJGNVOD8f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155915; c=relaxed/simple;
	bh=xEIHtjXyxYoI4yU59+uvOfJeuIF1gpf8inuCG1lZ1UY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ltqJVekoU8gWqj2adqqvJlP/NELRtjxImqmNI8Tma+1r++yqJ0U/mWITNOq9VWbxXyboeWF5eLOsD41s7Rg/AK6PovTUDZpBZgS5y9I8vcOZ8AdWaBNJyw0rXVHxw4x4OTynwb2TKioqBvbSqwcc4SSh0YLGsNS06bvoHgXR/7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WooionCP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cOXuV6Vt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WooionCP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cOXuV6Vt"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0DCCFEC0ADD
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:18:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 10 Mar 2026 11:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773155914;
	 x=1773242314; bh=4TCzCr9DEFOHdHMRtEcdKDlDIaSJZCgY0Q3afMWm6bo=; b=
	WooionCP5LdtatB4o47zv5yAGiIB0rCwrFWTc4s9ZxZy7Zt2q6rH8uVU7gErJyBB
	pRwMbjaDfvGLpbjJcDQagiWs2rAPwJOtST/M4za/MskQjBGF+rB1n7S3LVWGFo3M
	KGaJioUjZBgTVsXBGEnAdkEuu3S9IQ4D4iD7uatRfPVPwifNNJ/ZJ5VtRVWUKxR5
	arHZmaxqP5hSTawuKF6n2H34okMHqkhHzNhDzSj3nvp8Rb9W9GE1TCEpaQu3aSCE
	WfXZwb7LxRS2YPGuRlNcXf+/lHMG2Xt2nng88f+vXqqn6dIdNZOPBPYcQQ+qlw+t
	UegfzH9EMr6AfZz2l9pmHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773155914; x=
	1773242314; bh=4TCzCr9DEFOHdHMRtEcdKDlDIaSJZCgY0Q3afMWm6bo=; b=c
	OXuV6VtzjsckSBCX3uAtlbHzbExsCwzlm7ZVK8rmOi/l5vkqyco6JcvVrFemyxPx
	G/lK1XNPg0tzliv1HGOnboWNyi8BNi5vvV13XcLCb2id2haflsSf0cYy//3WBYON
	QJj0HscEf7YAp0WJWCrYHmHZqE0oXdNb6IJ3pFKf5SepGyXM5g+a/wOPle/HBQfW
	lLYlzE5Al1rqYpIij9BF2dmUoC1NvV2pf3zPw2CMNV55tbiiEi2IYPoChy3q39vQ
	QswkQlMgQ15j71UeuL8pCDcpWfQWAvoJBNWk7wof8c5NyYJmm/Gs+YhiZ90/A/7A
	nESjUg/dAOvdjHPMq5IKw==
X-ME-Sender: <xms:STawaeUW3ITSNJCDek0ET7nwIZbslP0yrLBLEP7V4j6_SxgDO7lVbw>
    <xme:STawaRiSA6Z9LuG5J1-Dp1x_i_zo5mEpW7na1GIXsvXz9fSvnUe6Ihu1C7HhFrz3S
    7ImsMdzm1wuDuQnvz6N13zWm8e8Xdxy6LV1cqUja-9Tf23lugTgDjs>
X-ME-Received: <xmr:STawaYAvCd8USqSK0LhoJAwGB5qgltMQLAaqawmBry6wQL9maWouedSHB7LnPZYdgaEUA5fakRXE348bz3iOigmu3inC2iDupswe0Xea>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedufeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:STawaae6C2ojpM5JnyznhOmK-ro35P1sIL4udSqYVgQqKFkFnMKRig>
    <xmx:SjawaYd4yTV6ffeu7fJ-R-4nKUdH-qi_0-rgUZypPXZ8TKEIsBSedg>
    <xmx:SjawaWiIMNkaYBevtxNdlhrg3H0KBK6QKxoi-oK87KdmePPJyF22ZQ>
    <xmx:SjawacSNFhOYcJJIRxwzDKU7z_52dBvRhFUlIGulQFcHLXbk_d_orA>
    <xmx:SjawadkBEJqfbExvMswhVuPa3Cl1txgU9nfQ3AFWPm0c88aVKYYnisPZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 10 Mar 2026 11:18:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5e7d4652 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 10 Mar 2026 15:18:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 16:18:23 +0100
Subject: [PATCH 3/6] object-file: extract logic to approximate object count
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-pks-odb-source-count-objects-v1-3-109e07d425f4@pks.im>
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
In-Reply-To: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

In "builtin/gc.c" we have some logic that checks whether we need to
repack objects. This is done by counting the number of objects that we
have and checking whether it exceeds a certain threshold. We don't
really need an accurate object count though, which is why we only
open a single object diretcroy shard and then extrapolate from there.

Extract this logic into a new function that is owned by the loose object
database source. This is done to prepare for a subsequent change, where
we'll introduce object counting on the object database source level.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c  | 37 +++++++++----------------------------
 object-file.c | 41 +++++++++++++++++++++++++++++++++++++++++
 object-file.h | 13 +++++++++++++
 3 files changed, 63 insertions(+), 28 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index fb329c2cff..a08c7554cb 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -467,37 +467,18 @@ static int rerere_gc_condition(struct gc_config *cfg UNUSED)
 static int too_many_loose_objects(int limit)
 {
 	/*
-	 * Quickly check if a "gc" is needed, by estimating how
-	 * many loose objects there are.  Because SHA-1 is evenly
-	 * distributed, we can check only one and get a reasonable
-	 * estimate.
+	 * This is weird, but stems from legacy behaviour: the GC auto
+	 * threshold was always essentially interpreted as if it was rounded up
+	 * to the next multiple 256 of, so we retain this behaviour for now.
 	 */
-	DIR *dir;
-	struct dirent *ent;
-	int auto_threshold;
-	int num_loose = 0;
-	int needed = 0;
-	const unsigned hexsz_loose = the_hash_algo->hexsz - 2;
-	char *path;
-
-	path = repo_git_path(the_repository, "objects/17");
-	dir = opendir(path);
-	free(path);
-	if (!dir)
+	int auto_threshold = DIV_ROUND_UP(limit, 256) * 256;
+	unsigned long loose_count;
+
+	if (odb_source_loose_approximate_object_count(the_repository->objects->sources,
+						      &loose_count) < 0)
 		return 0;
 
-	auto_threshold = DIV_ROUND_UP(limit, 256);
-	while ((ent = readdir(dir)) != NULL) {
-		if (strspn(ent->d_name, "0123456789abcdef") != hexsz_loose ||
-		    ent->d_name[hexsz_loose] != '\0')
-			continue;
-		if (++num_loose > auto_threshold) {
-			needed = 1;
-			break;
-		}
-	}
-	closedir(dir);
-	return needed;
+	return loose_count > auto_threshold;
 }
 
 static struct packed_git *find_base_packs(struct string_list *packs,
diff --git a/object-file.c b/object-file.c
index a3ff7f586c..da67e3c9ff 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1868,6 +1868,47 @@ int odb_source_loose_for_each_object(struct odb_source *source,
 					     NULL, NULL, &data);
 }
 
+int odb_source_loose_approximate_object_count(struct odb_source *source,
+					      unsigned long *out)
+{
+	const unsigned hexsz = source->odb->repo->hash_algo->hexsz - 2;
+	unsigned long count = 0;
+	struct dirent *ent;
+	char *path = NULL;
+	DIR *dir = NULL;
+	int ret;
+
+	path = xstrfmt("%s/17", source->path);
+
+	dir = opendir(path);
+	if (!dir) {
+		if (errno == ENOENT) {
+			*out = 0;
+			ret = 0;
+			goto out;
+		}
+
+		ret = error_errno("cannot open object shard '%s'", path);
+		goto out;
+	}
+
+	while ((ent = readdir(dir)) != NULL) {
+		if (strspn(ent->d_name, "0123456789abcdef") != hexsz ||
+		    ent->d_name[hexsz] != '\0')
+			continue;
+		count++;
+	}
+
+	*out = count * 256;
+	ret = 0;
+
+out:
+	if (dir)
+		closedir(dir);
+	free(path);
+	return ret;
+}
+
 static int append_loose_object(const struct object_id *oid,
 			       const char *path UNUSED,
 			       void *data)
diff --git a/object-file.h b/object-file.h
index ff6da65296..b870ea9fa8 100644
--- a/object-file.h
+++ b/object-file.h
@@ -139,6 +139,19 @@ int odb_source_loose_for_each_object(struct odb_source *source,
 				     void *cb_data,
 				     unsigned flags);
 
+/*
+ * Count the number of loose objects in this source.
+ *
+ * The object count is approximated by opening a single sharding directory for
+ * loose objects and scanning its contents. The result is then extrapolated by
+ * 256. This should generally work as a reasonable estimate given that the
+ * object hash is supposed to be indistinguishable from random.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+int odb_source_loose_approximate_object_count(struct odb_source *source,
+					      unsigned long *out);
+
 /**
  * format_object_header() is a thin wrapper around s xsnprintf() that
  * writes the initial "<type> <obj-len>" part of the loose object

-- 
2.53.0.880.g73c4285caa.dirty

