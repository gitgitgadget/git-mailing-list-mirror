Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F53597B
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786073679; cv=none; b=ZCgt8YyfZWRxoGkQwJijQ3ETlF4l3DvJ642DOOMnLpuObynoVGMUIz3zG4JUjDv2qDVC9jH7rCg6RCBljbO7b8Vg+zziQBGnEfL+yO/ndxHLgBwdXNAIAxYlko8m1/Hb7Bv8CuFZwWxc70qhtG1Cnnuyg1bDbMJ2wLzJ9GD7P2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786073679; c=relaxed/simple;
	bh=f6cFjoLlnFfH2hwTFje89MkuYI1XV44R4voGIAq6Ago=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDXNH7PGLOL6DNv5LppRNZg+aQfK09fH4rj2jJFXoZF1nKMBHgLWAEhq8iMuaOoLoyEjm4+dJsoZEv0Rq52f+Uo7qviVqSjHNtOWhYKEpRK3hI7IUfSVAu+aZ/7p9PcD+DV4M3D7bJN5RtO3KyTmYFZfJ90vXrDyKASHVGbuEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dGAzg4x3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XurMQt18; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dGAzg4x3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XurMQt18"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5388FEC01B8;
	Thu,  6 Aug 2026 23:34:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 06 Aug 2026 23:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786073676;
	 x=1786160076; bh=TeNNo7XrpFpLNeKgLEZfuDW9c19t2ccAPVUTfXKoXnA=; b=
	dGAzg4x3Yu/5v6GddZxcNFdmUNcNo/ZNGfabP1f61kzIxtHSwNxT1+UrKb5RfYmn
	BA/ueSl/GBJ1+Rs1gGVX/gtFmMjOi0OlXBWgUuyPPO+mHfKn2MgWowsdW+Ul5HIB
	Xb2Ar+sipefirVBDiPWV5b6lCKOfGUX28E/mZaQBtBVRt3iHoDNaItImB+K5fmb/
	2VuKL+sa9V9IgK8Yn6HsyICpFgaMjVcMsgVITbyjy3q9Za+MCs7Ixr8vGIye6rut
	kFmcykb2o7K2RniUHAPWXUpcVsn/zwL5vbBbB0dwey1fXr0uciSwgmGxUoi6Njwm
	ny5hnTdsAVhhrAhfYpISiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786073676; x=
	1786160076; bh=TeNNo7XrpFpLNeKgLEZfuDW9c19t2ccAPVUTfXKoXnA=; b=X
	urMQt18D/PVN4YmBm21yqbSC2Dnrg9pzygdz1ktxz+CWrD64if1D3zYwT8o/JN3K
	2BvzOBA621r7CvrDt5vLS05LZfa/I1y4E9gcY0VtWrhnTDdZ7OW1pLstS7s9OMI7
	2kcpi5F/vGzU0pkEoY6n4lbBkcn2D/Qq2bRaUpiforMndq9aukQeXT8Oxls9CLI6
	TfeOy4QPcQIRqS2PVk2R7/xYmvX2I+jQY0uLAVt8G2rJ6AuxmeO6NE7l2KaODzmF
	etAlRfIrMWp9KcVJrChwHgh5cod1ak9ZH6HjosY/cTjxtnP6xt0Fi+eofVeCSVo+
	Ar//cCaiL7DZF9vVn+qFQ==
X-ME-Sender: <xms:TFJ1aiO2Nqg4JWBr1hBS5Hlo8ifJ741DQGMd5FfU4fSS0YXt-38ElA>
    <xme:TFJ1an-_YWw9A7b7lwBpQ8V2NNHk1IAgk9GLg4fGSYNNDwoh2k3k-Cj2dfRrSde6g
    7Jxbo4tphN3nTRqtGYuEqDXvV85EceTQhwACZYl9t9KQXpKT1rhnzQ>
X-ME-Received: <xmr:TFJ1auSwqBA2XenFBhGHHWUw33BNJBn-r7ijU5hZXGXlqoAGbQIl6eHmp2A0-Erck6OcmGOToI_xEYudB5Cpx0kORLTNTycrIMhBjKRz8zzz1Q>
X-ME-Proxy-Cause: dmFkZTE7kdBa+2ZpN9yaQzNopvi5XGOOKBTvLDG9gmHatLClTyCzXowykrFEsXwaSZzd4i
    7rZ+PYPbEsDpQY65/3WEOnc3hfu3bdJkEr0npqZzCOFaVJnElXRww4Mk5FBkx2+neuda5y
    A+H0Sn3NmT1/usz1Tgjyy7AJoC08TLsGbBAgN5++8fR1k3aPnOSgHwDRp6T+iuecMdWx7o
    nj7jBoWmovohcLM4ckangVr/9NTxAZBdKgEEJXE/ShuS40CTDkm1PTxNMXsIZneVIrNtc+
    YP0jF47y+J8bJU/RfS7k4wGaeZn5/rp5UAv2tEyMAQrx5mBuiXa3CjLgjK6t3CHEGqxXCr
    4TvxchQCdwZqiQLLxEhI56l/2SIjGhOgPSDsoYuaZmiz761J04dMeFYsxH/Te6iiqwdIEQ
    Us4/bQ/ZWqQUPZZwZWgp4seh7b5X9StwivGH0sTPJomUFHAMrcX/Ie0Fqr/fO05qizH7ko
    jOmw/+PadBxzxqSUTufYVjBMbU3dKbFT7WKEKfhPG96aev7JcerIWk6BR9z8J9sTPFoG8m
    HPDpQKX7LNYgjLxQRcEor7b+XNML1AvqYwBkTeixbGVUAqpWaFVT6ryOib7ScmRPrUf7ev
    cnOY6gG6lE47Gql6T+RQNco8KL4xl5ekcqut2f2OcDKfBKhHzsSjBp62A0pA
X-ME-Proxy: <xmx:TFJ1ahk3EEq5OpRs76XP6ZiC85rjU4C_T41q9N9I8EPaksDNI3tjnQ>
    <xmx:TFJ1amQhtUB4XHhENXN9XEVKzj8Hmq3QRkWnYuMQIzNkCKrB74VrOA>
    <xmx:TFJ1anNd5Revx87TvzgNy4c8--PJ8gtLjMjv7dHHfbPORtNAmUJJlA>
    <xmx:TFJ1anUvjaYds3u8pE2wkO0cvMZMQVTDjenxSy7OSvtyc_bzSFyrOQ>
    <xmx:TFJ1ajskctOzgJTmu7UaGt5ejziwIYf3mslzy4F1hn6fKcxSnL2dIf_i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 23:34:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 06c960f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 03:34:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Aug 2026 05:34:25 +0200
Subject: [PATCH v5 1/6] loose: load loose object map for the correct source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-pks-odb-create-on-disk-v5-1-399da0b0b140@pks.im>
References: <20260807-pks-odb-create-on-disk-v5-0-399da0b0b140@pks.im>
In-Reply-To: <20260807-pks-odb-create-on-disk-v5-0-399da0b0b140@pks.im>
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

