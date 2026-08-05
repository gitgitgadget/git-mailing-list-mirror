Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63AF2C1595
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922143; cv=none; b=p0mDomGMMsfy3AQHyEUnrcCeZYgcFqQtrWtP2Vghm9/TIImeV9UUHEUe6AA1Q5RH8xW+GmVhjdWr45SmLNinheY8VvTlE7gpHeggasJ0+YvMtoKrWcbOeK7k1+D1BgTmV8khFQPyhZuqTxsoX/nlj0OmeHm17eYOLZ7ridkVjoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922143; c=relaxed/simple;
	bh=f6cFjoLlnFfH2hwTFje89MkuYI1XV44R4voGIAq6Ago=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qiuYmhQ/gTKPsTWdiy5S+PpnWcYYX8aa2EBpaiclGqrgjR8gQX2S87sVioyEwoqYjoivt/+s3LDULd5I8SqaHFtVyrXHfbecQB6amjgjz7nT+5TjDHwPZvUDW53nBLQrtXBunV8P0eneek4Y7IWZ48vdOVYopvWNCscmgpSTKM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U1u+Z2Op; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H9zK3Pbb; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U1u+Z2Op";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H9zK3Pbb"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DED6DEC01F3;
	Wed,  5 Aug 2026 05:29:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 05:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785922140;
	 x=1786008540; bh=TeNNo7XrpFpLNeKgLEZfuDW9c19t2ccAPVUTfXKoXnA=; b=
	U1u+Z2Op1fyIMWsdAchFJtUw6p/h0QUE/YOmEBX5ivg/14h3ogN8i6tCbLjZJJX8
	wQPmnnIO+mpV/DdQqDO8Ha5Tta7tQWKgTG8m74ChP2Rd5kkdVTZjXeQWNxpCe+Wq
	x+u3innj/ECqpL6UMcsn1jlxrtaqciF/J+f23fMPeUz5LqdBjp+CX67rEtJQXUx8
	CHvvlfn1vdIw+ynDItzs4Tw+rtHeIHsXPT25pw5mgPqhgf0FFqP6hNBjWD4mjGi8
	EPs9qOs3lukqLvf2WZmB/XcM1AjOp9U4J8VBk6wFvuok826FpD176QgK2+UU3KSO
	oRCSZnKISZ/+mS0BOA29xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785922140; x=
	1786008540; bh=TeNNo7XrpFpLNeKgLEZfuDW9c19t2ccAPVUTfXKoXnA=; b=H
	9zK3PbbsPAO+uvWT9NXdHvoGAEq/g7TfqdXQYpuMzHGnSN+Of4qaqfEsNSLosIGH
	K5xrcoSnGqCLpjfcQ2lN7w1vKAOMY/PNeGM5TUy1WRxAwtOCTu7D5hY+7nPAlPJT
	Lp0A+eiqRigjb/ADHvOzR797742cLZldcLzxOX1d2xopzZgZUqD2RqrDQFldI4cf
	bm6yNVAE2DZMwQx2HyRR6l2KyEtNWtlUb+GcFVOWz13rB5pugkR7PPNaxEnFqtGO
	GDVkeyAqw/CAC1Gm00pKy5cKCxK+8ZK46KH2BMq6FFr5yqxpl5NZ6Q9iTNoD+V91
	puP5Lyd1xcFPJfEc0i60A==
X-ME-Sender: <xms:XAJzahpPR1wyd4ZsnjRXpFDrk8f7TN1InTN7l93CIsm5XKnnRblXxg>
    <xme:XAJzaqrKlDY9FDxj-FdwR7keLZb2cg55iDdq9A1E213EIQK8ce1utz6VFPslCj4SM
    tl81pkabW7Tqp3pHDmeNT4WJgfgi_KEisoMPGzqcfwlLSDFJN__Tw>
X-ME-Received: <xmr:XAJzajMUEZowGCfyxC3tqBitGLajlOIc8ZRBm5n7hAxqFUOdEfsLk9vFyaCpCgiBT7g_QBX-HHf_z8OZI3S10xetMazn3_cwPHoRiZkCow>
X-ME-Proxy-Cause: dmFkZTE5Dc+FfrkisQb5rMhIjfBUYY8IRmEIZbSHMIBCABfvXnlXkOrU1VS+slHYecbhva
    5cGzxC/sQgy9Vz3FCqlDrmr90sB0MBIjRQW4B01+jInGMY3hkKMWYT8AO32aK9LBDWSxp7
    7J/h2G6M6iDGTSXYhiyH9Sc9tI2/go8XhzV8FhB4dCpKYFlwu/YQwj/scjj16Vdj61fe+j
    Bfrq/H5dtAxkFRo15/QJtb6HHq1OePWLklNpi0SOqNLZdIN7eP75dQ1+cOJVL1pLFQZU4q
    fTnZRNSSZQMNfr/Ccca/e+kdjpbhctrCId47g1xfD27q93xd8roq+cBb6lyuj0nsmmq3Qz
    HlvA0wxRfHT65Fj0xMAkuInzh/1n+9TvG+v5EiwsufxD0VDuAWGMK84rvkPBoJkgBwF8k/
    P1YPrVRb9bVHWZRpX6vVtbcyIc7XLSYvoMwQluz8oob4kuDaVHZOsEaz0iiTjBeIhXqrxm
    QGvB2xn71qEIOwi5sH0MumqSjWxcnRwROv4vcXZfluE2+mIsj6h+Lp4cTHnRNhbZrxF+D0
    3BN0w5jsjyL29WvVWGndqFsDCKRIlFUCxY6PraU4xIC2RNoiICtTN4cEptOyKdpiqHL+WS
    lhuk472TbgwLCWf4H+6r9214/3jdbUqS2xTxy3zrTg66KjPbSZ2kpY6pyKwg
X-ME-Proxy: <xmx:XAJzarx5j6PDKoS_CWEnS7q7_w3bNOHlZCLWgA8xH1S891ZuqtffRA>
    <xmx:XAJzasvyBnpVmWO7x4YUP2-2aeBzvn6TJdCqhP5xz0PuOrj_bWpllA>
    <xmx:XAJzak4Q0l4IYb-jbwK2ILBR7U9YktX4Jl_-AiF_wi28tyoJfLkQFw>
    <xmx:XAJzarQY6k2NpMxCkk21tWWjbgM7nW6Ik852TcNe3zoU5LOeyZGObw>
    <xmx:XAJzakOmzD1b6pQiy7ZBEtS7upsVkdHCzuMGFjCz1UCu3e2t3jhK3DzD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:28:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3db90dac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 09:28:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 05 Aug 2026 11:28:51 +0200
Subject: [PATCH v3 1/6] loose: load loose object map for the correct source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pks-odb-create-on-disk-v3-1-c0ee3ac5141f@pks.im>
References: <20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im>
In-Reply-To: <20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im>
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

