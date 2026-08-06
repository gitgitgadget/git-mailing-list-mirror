Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B8A3DA7E4
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002674; cv=none; b=f69EwcIubQHMvAL2ei0SsnVTqOBEZs56dSiCypzFzDOs3jnxW7qiZu07OOJMp/iwJkTY2U/OjWG5akv3uVrHOIbLNXuq0BXtr82Ct3reAb5Ze+iOSIMddk+M8g/XmbfcKi48DO5qEbbbmCJBqvMAfvzLx9XTsUo60k/Jk9a5uBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002674; c=relaxed/simple;
	bh=f6cFjoLlnFfH2hwTFje89MkuYI1XV44R4voGIAq6Ago=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mk2OsD3n3BGtvlOvw3PxWjAOFsCtEqHSfOMkEDt48RhzMJIsjL2KaIQ49FBqzK4KhpFqD8yyhTi+JrtOUw/ewltJt1zMiFFjPywt4Gvu6oq3V6jXV41PvrNyGY++O40PAxBjmQeUvUBub+MH8pxqXZFmmVdIKV6qPwPtisVq+bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZxNdRZj0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VDKMF38G; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZxNdRZj0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VDKMF38G"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0183B1D0019F;
	Thu,  6 Aug 2026 03:51:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 06 Aug 2026 03:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786002671;
	 x=1786089071; bh=TeNNo7XrpFpLNeKgLEZfuDW9c19t2ccAPVUTfXKoXnA=; b=
	ZxNdRZj0oWV9+oYHi8XxYwSu4NujEiF66f+Og8u1R73J7Un2l8UtpQN9LeEO59o8
	1/KWhzzwECkAg+49qzn77FXa+D6iAPcvCl8m7zR95pCdqoFN6htvL3NEUvsNr0Ou
	tSc6AmsRmrjcILQbJ5w1i6ztHNMD/D/iEVg0FCw4gAiangHBbdy5MeASYXnLDIde
	SnmOHp+4nZVcmedQZb8b7+Qw2KDQeDreHA/qujf+Kku6t2XRFtFDYftBv4Vas90o
	VvXPkk1PiK3Jfeu21jdVjlbjZT2V/jZ30QBp0kEnCzIULurgO/34lHgYG8AqjAss
	opM1xMAeUzsDvqvIdjuC8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786002671; x=
	1786089071; bh=TeNNo7XrpFpLNeKgLEZfuDW9c19t2ccAPVUTfXKoXnA=; b=V
	DKMF38G+NkamvP1lRh53qwNSVqSWxn26bHvJlvoPkdV3RbJSWqS7MkTiGh8bDvck
	8tru+ZLoAH645yLZH9NhbK95mr8LgpqfBLbqzoeAOWzTgAIjSDeK1p27+csO1Yp9
	+kdNoA7P4nPq7WleBNDR6oRRkezpPP/HegwPXBAp6OeQHOxjyB6D9hTclDoFENWF
	G6O/TS8tolAj7VRRxclUjJyZgdfc14wfFDnzfHhQeLJLNcK0H+BnD3+BqYk+ppHQ
	JfqXbWQu+D2wvjzCLtaamASVX/VKRhEmOIeNrJqu/qbsCKTZSO02CTSyjKoNGevD
	WjPoEUgiUNSGepBGDB1FQ==
X-ME-Sender: <xms:7zx0ag9NJ0ky2XwezvuKhuyffWbLoW5LS3bYJUiv4YGEBrMjzBkp9A>
    <xme:7zx0avsJ-uOEYhVrEDXjcvZxYbhqKCNuKLehV-DLphdVF-g_2OGZfTOKPnPPsVsTf
    _tIRPhEkSN8eLkf7B8pHUmzH9gU-0ANkkvfqPDTZ6ML2-jeUAFAbg>
X-ME-Received: <xmr:7zx0arDPuwFyVevbeIqCJhRcACOQVo5Z2D1oB-4ZveRFWEToYMKxC_DXzqAFHfaWLLLe_30goZ-8kRm9ORiwNeAK0Ci7EPI5ZgNjHO-ocA0>
X-ME-Proxy-Cause: dmFkZTGJiFop5Eo7uUgbFGmEFhj+5nj6icWyraTDQIYOPUKU2fZsPkxCJWcyicJ0UouqvP
    h2OQhoDZCtyJjqI5q8mR0jmJwL8i7rfGe6oQYxSjvf+FqWpojPB8RP52RC3Zop9FrXNOEf
    4MbvEMu2TNdZgrmAtmZaQOpKM5Sa1wKSY2NP/ifHOPJ8fmMFAS7RDet52+61Pr92CddgnB
    wV9xqgUkMHTf5kM94PyIqUU/Ij6MgO+B5w49KfK8y8pKbeabufQ4FkVvQr8b1nCF1awoR3
    /HWjArmpEwRBCCuwbHDnL4nwmozT8bfNNR+phxsj0YP8nC5l+N1VoCeUrYvojSWkmQQnKS
    scOUumbr0ehLFobZ8UT+xdk5zno0fOh9F3VCIiqLZChYZWHDIe73ixzaomoy9oS41u4KHm
    HKe/2UaRRY6E7yImfl3ubvZWuJ29VdKKO9KPd6uvKKyjPKtV8kQRE2YHAkE2GiwHTg67OW
    wsyhlb3OvvypcgqyFj6KlHDRsr3HIh2vOBL+KGnnozKQJpJk6QYge5C2JL8pN5Ar1+oLCf
    TTyGoukkX4/wqlDxdthSW/VdoISYoE0nJH7Vm4V+nkVjroiqtBtOKb4xhKVgIEVmeWtX+y
    Je9E6ULgMKmI7QMC+zjnVc+jyXZ50E3MzJUSNwl9GX48MhRo5IwGm1xBbVHw
X-ME-Proxy: <xmx:7zx0avWb72guV6sUHSiaFhGfjxjuOTkWHSg5yXorlJrAt_vY2c8rbQ>
    <xmx:7zx0ahC7QN1vsYs9cFjgsrfAamSBbXG6yP4GEvNqDvFt96bzNcfXAQ>
    <xmx:7zx0aq9T9v32wnp1zBf8LvUNu4aC7c5wthegSoO3VeBa1plXhAQPzA>
    <xmx:7zx0agHvT-DLqhxascnOd96ridNgPU5qakoY3jrrFwUF6wlB78OFbQ>
    <xmx:7zx0anAjz6Hs-bGfi7_0egy0Yv3Fkd0VUHZJk-zNECkdzN6Wc2zMQ86p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 03:51:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7f54c328 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Aug 2026 07:51:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Aug 2026 09:50:59 +0200
Subject: [PATCH v4 1/6] loose: load loose object map for the correct source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-pks-odb-create-on-disk-v4-1-ba8b4fdd2e3c@pks.im>
References: <20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im>
In-Reply-To: <20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

When loading the loose object map via `load_one_loose_object_map()` we
pass in both a repository and the corresponding source. We ultimately
don't really respect the passed-in source though as we instead always
load the map via the common directory. This doesn't make any sense
though, as the function is called in a loop through all sources, and as
such the expectation is that we'll load the map that belongs to the
given source. The consequence is that we'll ignore loose object maps of
any configured alternates.

Fix this bug by instead loading the map via the loose source's path.

Helped-by: Toon Claes <toon@iotcl.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 loose.c                       | 18 ++++++++++--------
 t/t1016-compatObjectFormat.sh | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+), 8 deletions(-)

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
 
diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index 92d48b96a1..9cafcee509 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -187,6 +187,24 @@ do
 		eval signedtag3_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag3) &&
 		eval signedtag4_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag4)
 	'
+
+	test_expect_success 'rev-parse maps oid of object borrowed from alternate' '
+		for repo in alt borrow
+		do
+			test_when_finished "rm -rf $repo" &&
+			git init --object-format=$hash $repo &&
+			git -C $repo config set core.repositoryformatversion 1 &&
+			git -C $repo config set extensions.compatObjectFormat $(compat_hash $hash) || exit 1
+		done &&
+
+		git -C alt commit --allow-empty --message A &&
+		echo "$(pwd)/alt/.git/objects" >borrow/.git/objects/info/alternates &&
+
+		oid=$(git -C alt rev-parse HEAD) &&
+		git -C alt    rev-parse --output-object-format=$(compat_hash $hash) "$oid" >expect &&
+		git -C borrow rev-parse --output-object-format=$(compat_hash $hash) "$oid" >actual &&
+		test_cmp expect actual
+	'
 done
 cd "$base"
 

-- 
2.55.0.679.g6767b8d81c.dirty

