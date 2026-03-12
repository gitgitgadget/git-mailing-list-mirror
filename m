Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F0C387346
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 08:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304995; cv=none; b=XlSQOaf47TDAjKmlTJezD6mK/sw4G+3ypb5MT/0EGtiYE7TBmFneOUg7zy+ybhLzWJPlyRNZbhg1TkHhf+7dvmoqtev4GxCYmLBckkd+rlKmmZA76mmuaG3PeS1VCiUOW3ubuosjMWA84pYO56yTL1yD7uEfrwL3BMknwA9263w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304995; c=relaxed/simple;
	bh=Ua+Jg+oqgx8n6a1ZUo11nZ9EN+3Wk3qjzlUK9CSDvMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XSBEzBIMVbpeATA10YIxZGDmHjoHh6OK3rS5liFx+UNoFnvkYK3zPttbJIZFnwIF89nKea9LVK4TTnR+88RCXh3qh46r3TQziWb5H04G/5CbDf+TRdHT6iVZhSou6GBkg8pz/ylUS/Qsnm2+831SBOJtE1uweYl9tudibIPOOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bbnaIDLJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s0sndqcO; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bbnaIDLJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s0sndqcO"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5CA9E1400127;
	Thu, 12 Mar 2026 04:43:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 12 Mar 2026 04:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773304991;
	 x=1773391391; bh=xOIPFm4licUVvaD0MgSHFTMvLRpqNGgEyfkyEVvA0ng=; b=
	bbnaIDLJYu5ORexMLR9LIhJdappfKxeY9nynhRBPuJ//FNYntnDfHvUwfC5zJoWA
	4k8TleuaoPCVLStESJLzkiCyExW3+XaafAkT2S3blxwfMLDUcbTU3TtiFX2TIi3+
	/lvwag6iuz3hlL0TZoVRKUDsUKux1MPb20kc9pwEqMd7kKZ10I0CGiBNLoXr6wwe
	fvb07gAuddcEme3upFQRWHyyYqdrF+t1+LOTKSbQ9wDwwLTKMwGN2YNp37gxCJ8c
	QyIe4EgT6Tm205UotgejdyO6M0zU0fAvxSWThV5XkKZqEXhFZfK83IU9YXOsYf0U
	vq+KRjiyIWYDMwEpdWX1/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773304991; x=
	1773391391; bh=xOIPFm4licUVvaD0MgSHFTMvLRpqNGgEyfkyEVvA0ng=; b=s
	0sndqcOlt+mi+rPwzdnb8uUlyqN+/QeSCyJ1Hr742LvLOKVJWwgmDVGEHss45dt4
	A4ITUFKpLkFwniLf36e2OdDvNnTkCXHz92p9hGqbeb+HgEU72PWKZb1tyg7TkbNJ
	MY8OBKxsYuHgyTdyolGVqoW+bGR8bQQECOxMJNpPUWPWB8F99o575HaK+SKNtrjr
	mEKcUiq6YcIvVB6oJ8hzIrrYVrKBVobv7nx4Af1rMwwBK+vr8nIK8nGEgyrBSFmv
	P2IzaPJrgNysl8qHK/lPZe9iHGlInr7hbLqAfWicmAmLeQtqP9Ae/nxZ9H+nM9dG
	zJy2P9FGXy0DfJ7TQBg1g==
X-ME-Sender: <xms:n3yyaVP3s9bSw9PZ4fQIT9SFA-uEeH-VuYWW49Ae857NkVOm-D298g>
    <xme:n3yyafbXKscDFhAUQ6HI19BNn1ATv-Xkn6qN17Vkz9xIb3wZAtqfC4AMR6WXZAu9Q
    SkveGtv63ZWSF8qLTgAdJcSsoPR2UThHkNERvQt2Qv_Q-hNcEAqpZo>
X-ME-Received: <xmr:n3yyaRoAi-rO1BA97qcyJNtZ_XnvsdHbjAS38ZrxvuyoI6dgYRvJ367YQj3oGIBvw8HcRGK3p3i_lu2NIkbC1BGkpNqoMJCm-_12INdo_CUBhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeifeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:n3yyabbqCExOnIXTrlwJVRmWxRB0hrMvV9U8mXpZVcMcgeiz7_DPdQ>
    <xmx:n3yyaRTv1AD4pMqgB9U9vP1_x6UkMP23xENSi4dzKlAGsKNGLdUHwQ>
    <xmx:n3yyaa5Ed3KlrgKwgEfVBYmjQBQPO_aYRDUGq7Bbe1zTveye7_nVFQ>
    <xmx:n3yyaeybt4Zxd8jryS5-xdr8hrhiBI6wGJeU5HR8VbseDBtqR99Q4Q>
    <xmx:n3yyafBeuyWrYbGtVs2nBXTo08U1mRVUKkpnI5rJ8WP2DVx3cqI-yBgu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 04:43:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b8c8efe0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 08:43:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Mar 2026 09:42:58 +0100
Subject: [PATCH v2 3/6] object-file: extract logic to approximate object
 count
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-b4-pks-odb-source-count-objects-v2-3-5914f69256bf@pks.im>
References: <20260312-b4-pks-odb-source-count-objects-v2-0-5914f69256bf@pks.im>
In-Reply-To: <20260312-b4-pks-odb-source-count-objects-v2-0-5914f69256bf@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

In "builtin/gc.c" we have some logic that checks whether we need to
repack objects. This is done by counting the number of objects that we
have and checking whether it exceeds a certain threshold. We don't
really need an accurate object count though, which is why we only
open a single object directory shard and then extrapolate from there.

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

