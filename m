Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA94E1FBE90
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784864943; cv=none; b=B9A+smdCM/eWNjaZYpxgbTVXH1GxlvX0iM3iROrrThWpzt2coCno4qBhCrIJufQN9gF94LZWh6zqLMEqAF8K3rACsqwo7HaXc/Y2TuVL7yKAUq3bSXHPRX8nCrdz6oauxut6bqOZh30FM31AN7r6nD9ITk1Ajne+YgfCKWCJtlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784864943; c=relaxed/simple;
	bh=7zzy+egwHrMyDTgkfxshWihDEF4XDYFEu/zAE75xd0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GsC7iA5KZOt48/+DNRogcIF4vYT26ucdUga0wsKfIMCgDIr398fIdsy5eFyQMWEArqv7mre2xtqgkTHuq3VUY6MU67cVyYZqLkEQRu1oXBfvrHdnQaNDhcw2uaH+dZPbejrZV43GGF3IEIISA/KDVrpvJ3ovJpYnQU1rSpM89iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lh0yOs9E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HCFItGK5; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lh0yOs9E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HCFItGK5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5BBB67A02FB
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 23:49:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 23 Jul 2026 23:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784864941;
	 x=1784951341; bh=ed0F2FtRrXILsEVMPhazlYfFJioic1WNQkY8/tXX87I=; b=
	lh0yOs9EEVLBs6J85+2oNV9s9bUQX22MXn52ak0sfas4AAMSIptp4P2M49KXtNm8
	EnTeujsmFgSg+kUZVb98ESzeS4SeEMr0vBhYAupBV/MTyLoHqojalKzoqSzHJ1Ma
	f4ZBBqw/7fDAP5NKv5tyCpo3q9+jr7kyZHR+6WJIwL/mQMfe9xzsUOIr/niMrpyO
	D3QBbE08C0moXGvVMsTosTe59/wlQ6OUiU84h7mKvHHdtaAQDN6T5CAFk7WFzW4X
	YViavFHuSo1DG73c2vMdsYmLR94qIs0N5nuaFq1KBoq+0O68DRUdBYKOZIarFn34
	Zw5Li9sbpYZj8v4o7Uy3PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784864941; x=
	1784951341; bh=ed0F2FtRrXILsEVMPhazlYfFJioic1WNQkY8/tXX87I=; b=H
	CFItGK5B1tbZR5DoXVPQspHFNg8wv9SGtkmCpyLssMUO7jfdleqFwA6OtOeWMOV5
	TLeCp9dOgHYs/iFM3CHcF940E3XGTA39N9yVZWsHOjWTCIH1bNc0+FvNnRmIb3gs
	1UbVpV2moIC8YGFnT3nU/6AdJcckJtpEmbjiYEqCtD9rLyNBN1tLaUFLjIZIptIn
	5WUbEvUa4JIdv5WjjtZIJ0pyOe0wvnxs/5uhVZ/qk2BRTIb7e705mKVA1jtAXt0m
	mmdd1LOQCUsM/0SE9aaj+Sf9S/aChKLChqn+xiL5hFmU1a+NNegU5iR20yUz6tiW
	CU0SFoDnFzocQtqVJ0f/A==
X-ME-Sender: <xms:reBiagjMWLBFIEKHAsJmOZR2UXknXJhgdUkBe6nWB0UxE75qbE7Mtg>
    <xme:reBiav8jHou3Z_HMMCJC5_ktYb5yMjBEcF8xfMhD6y42srB3Jcpvg5p2938LWLB2P
    UgvpzOaNScIEZ0MQXaJu9X2JOlbazjivzEDyJfRd5w9oCUuPHrixQ>
X-ME-Received: <xmr:reBiatvYYh0fav2B804OcWstUxwvF_eowxRi-BfHZ-0N9rYRhL4kQusr-xDHb7oOdJy3IZUFgXp1epk0sn9fHufUM7M48uk-ZgCQl66lD7M>
X-ME-Proxy-Cause: dmFkZTF7nifSebCXgnY8NY9fTsGaLqoVcY29FeLuYWLpOhnMSqS04OylhUIQeXF3q+61wf
    BVFDQADUqAv7STYM1c8O91jovYiTdNTSKEPORuP2Y7gotaKfHfOVcDvtBjxRqZJHL8VlVJ
    oskxFTo07bBWsma6bnSEzOPpbNzEB9/5penQZMq+TNV5J0A3KY8PVooC4KNEzBTlDDob03
    /UeU4k+fh54mmTsXNivXWX93XVy9n3LI4KT7mFQGV1t/ZxBOUOiNXCpcwI0e8ULve2W0D3
    bzwmVXOp+1nMYqENIJFXevwFzIKMJbOKUPOz6WQLhFCZcC2V3iadSpsZbCRThEyXrT9mMI
    M/s3CuKo52699fkZvMWpk9jTvk7f+oAV/Ytsa2YWmw23IdGlfrGW8eDnQEL+s4TzDfmp5P
    B+S+Sm4OC76Bq0ag4PXxZGx21pUBoGoF+PUu+WMxF7M1gViRJHkSXM3FwV0BhaKULf0lto
    rwjFnWl2RXpElI5wIb2dT7JovDA7A5rgYhEJEOxj8lXRLfHd5RFgak1wbP9+V8TaJwdATL
    DLfCuBoueeSA4Dikl5tpiNvYl0ZDzC7+cuWcvFRiw5jA+eZctMgoEISpRsEP6Fi8XSSPjh
    V/Yig/YU8/SR4KdvfWFL5sn0QyfEjlLXgovmVoxT56Fw7M4T72uTgHzM4Cog
X-ME-Proxy: <xmx:reBiamaYRI4qXKiBnZF6psQqJWiygH9hFY6VLpwP27XN0Bh3AFctTQ>
    <xmx:reBiatp8TceZed4-bDmhVL2xZEGToyofKqv34caFoC5LnHnyW4rF9Q>
    <xmx:reBiar_xzGCJoKtLRidlVecp1UwW4KyPqIj8KgS0U_QRfqXhwo4F6A>
    <xmx:reBias-Rh-UduHZ4RbKz8HhylC6-pTeltxhtKQoz1Tppoc7AITyiCg>
    <xmx:reBialjNx1jV2eoJOafALFTrJy9XMW0s2DCWaGzDvGKPN1cT3nh8Fmcj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 Jul 2026 23:49:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d7355412 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Jul 2026 03:48:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Jul 2026 05:48:40 +0200
Subject: [PATCH 1/5] loose: load loose object map for the correct source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-pks-odb-create-on-disk-v1-1-3b3d265d979b@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
In-Reply-To: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When loading the loose object map via `load_one_loose_object_map()` we
pass in both a repository and the corresponding source. We ultimately
don't really respect the passed-in source though as we instead always
load the map via the common directory. This doesn't make any sense
though, as the function is called in a loop through all sources, and as
such the expectation is that we'll load the map that belongs to the
given source.

Fix this bug by instead loading the map via the loose source's path.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 loose.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/loose.c b/loose.c
index bf01d3e42d..9dad75373b 100644
--- a/loose.c
+++ b/loose.c
@@ -61,9 +61,11 @@ static int insert_loose_map(struct odb_source_loose *loose,
 	return inserted;
 }
 
-static int load_one_loose_object_map(struct repository *repo, struct odb_source_loose *loose)
+static int load_one_loose_object_map(struct odb_source_loose *loose)
 {
-	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
+	struct repository *repo = loose->base.odb->repo;
+	struct strbuf buf = STRBUF_INIT;
+	char *path;
 	FILE *fp;
 	int ret = -1;
 
@@ -78,10 +80,10 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source_
 	insert_loose_map(loose, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
 	insert_loose_map(loose, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
 
-	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
-	fp = fopen(path.buf, "rb");
+	path = xstrfmt("%s/loose-object-idx", loose->base.path);
+	fp = fopen(path, "rb");
 	if (!fp) {
-		strbuf_release(&path);
+		free(path);
 		return 0;
 	}
 
@@ -102,7 +104,7 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source_
 err:
 	fclose(fp);
 	strbuf_release(&buf);
-	strbuf_release(&path);
+	free(path);
 	return ret;
 }
 
@@ -117,10 +119,10 @@ int repo_read_loose_object_map(struct repository *repo)
 
 	for (source = repo->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		if (load_one_loose_object_map(repo, files->loose) < 0) {
+		if (load_one_loose_object_map(files->loose) < 0)
 			return -1;
-		}
 	}
+
 	return 0;
 }
 

-- 
2.55.0.407.g700c83d4f3.dirty

