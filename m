Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773343F9284
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922152; cv=none; b=OXXiob71jGOJYlqybOH+gF1EGPyuVlZyput+ADaO3wEqHvWKPiEJYKll1zUZtVGxkF6jMryCHZ5N9sWq2WuN8dW3C56IFbP8C+j+LQmfeec0rvWOoN+ZS3TBc35YTTkzKBCmXaI2PXLPTNm9HmV5GmZH9fgVrqRqNgs/KPr0vgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922152; c=relaxed/simple;
	bh=W0IJzdF8B6czCufxRF/fyoyXsNkQg/zZJ0/S9wrBs2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=He0J7/+49oLFDitcM/KQL/om8ARFGwN+8wZ+6uNTaG64CEayZnDowNI1EcgpFClMF1j14h6WNZi1PSnnt/KolCsMKxofqFyRilLskwtWsp+reEMpfH38S2sfpcwC03wQMG79lnuRpIRN4FeEwnCw/02KWV48fli/LqxMHO2nE1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P0u9vAm6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V5Vf3xXv; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P0u9vAm6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V5Vf3xXv"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A3061400157;
	Wed,  5 Aug 2026 05:29:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 05 Aug 2026 05:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785922149;
	 x=1786008549; bh=V9TYUCli2wyFZp9Nj7+N8WVykOQKxfgdp6SB2zVZ0vE=; b=
	P0u9vAm6cSWsftWFNlKpuYV+LnT6TMiSL3oOFRW0xulGXybmvSb6cN6TPM66pEYU
	LFsmFEyzeaHmvex/5kslzYx/wrdA+eMcIcUYNm5+ORrn1FYu/cYceqsSn2xgf+aT
	Ha6TAu/oQor/Lvz8S6SCGL1FuQJh++g6bvajOlCHujKN1CmIGoIw4qjaQXK6v4Wu
	ZN7Vbh94D1tvvs7NcSmoXV0lPAu+5enhziKwKOrHRZyhi2iLe0wIE+g9GT6vZ2S6
	wuznNzIjk/5x8hcg1ERp+zSIt/9n3duplCI5AfmcGfoK+wq1zbViTfYAXWgA1azT
	6+U16DZ6wMvHH3yklYFARQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785922149; x=
	1786008549; bh=V9TYUCli2wyFZp9Nj7+N8WVykOQKxfgdp6SB2zVZ0vE=; b=V
	5Vf3xXvbr9JBp+8v0WUQ9y+kidym0nQBmCDgmMn07OiXzFm5riTYiD8ed2Jo8Dpo
	DlJp6Lxts2g/w1IZ944aANEhOht2EgWB01FWIDEt8O9rCg9BP3xO2urXQMBlrgjs
	mJnqcdwdGJX4NYBeo1aZ55eZ2j761vf+6nPbRFXJVnL8PZghB7obOPA9dqllaStG
	5tji+qIkmELjoPMCt3V3kLbMBqjNnGSdE8Jw71bmX1QUOrcrpSeXdLp31opy5aOk
	0O1oW8ZuOL+5uYPM+uhPJ8rzl/ND1gkMHOVT0WQZsZ/hHSFVeP1ks+Hb9L6rBRrz
	t9+5AIHaU3kxBp9P3QxWw==
X-ME-Sender: <xms:ZQJzarYoPXZsrDRu7fiRTq33pLmWwHmACqDGfKLI7Bpmi79lH5cdlQ>
    <xme:ZQJzahaalAkxuGSM5WQepe721rHRaHeVI12bJczJKs94DZz5-dSkvEz5uW20vSD1x
    Cw6sHRULELKal6nZZ3Zmi1f0Qb_AGhnPVQyI62zMtI2NFDCjnTJYw>
X-ME-Received: <xmr:ZQJzai9t5yS3DBIL2Ph9tPBjv1HWsP1RtpI0UBwPhXGPap6_qPugMhLwVPKRYxWWX7_GyfWQGLZMmsVAIfhIGmAPDnhzAozrRIerY68bsQ>
X-ME-Proxy-Cause: dmFkZTE5Dc+FfrkisQb5rMhIjfBUYY8IRmEIZbSHMIBCABfvXnlXkOrU1VS+slHYecbhva
    5cGzxC/sQgy9Vz3FCqlDrmr90sB0MBIjRQW4B01+jInGMY3hkKMWYT8AO32aK9LBDWSxp7
    7J/h2G6M6iDGTSXYhiyH9Sc9tI2/go8XhzV8FhB4dCpKYFlwu/YQwj/scjj16Vdj61fe+j
    Bfrq/H5dtAxkFRo15/QJtb6HHq1OePWLklNpi0SOqNLZdIN7eP75dQ1+cOJVL1pLFQZU4q
    fTnZRNSSZQMNfr/Ccca/e+kdjpbhctrCId47g1xfD27q93xd8roq+cBb6lyuj0nsmmq3VB
    oEZU/6SThbWYAZmgAB841FZFJCIBHU84YrtW+JmFSsSGbi12ZON3SzB24Z7eP/XQWoYcPC
    ouUNL/rFMVh4pL4TLXDLT9ruLniCtIEpn94LBQjtIeOgfwSjswU4U+W5UPfEfzKxdDb0+s
    TmOyBKkiqvcwYFYXKyLLOEhrReJIAOgtgnrClhu9XA8f17gzrWdjJpFh43uxherfEbxMR7
    k334FHlFUa70G7zLCkGCltUuaqW72gb2pHOBa9kpuHBat0+7aYB4DoGUJvM3AbGJKAhaH/
    rrpf7dYXEGj+Dc+oGUxTfKqLDgZt22sfRh5k9yUZI0KMIdJ2VGz38SxPaDrQ
X-ME-Proxy: <xmx:ZQJzagjFFeUjYKkAWgiQwZkBydygOnl9ueDkGfAFEF9Cy6Uk6oP83A>
    <xmx:ZQJzaidK61mDaAPBYZzIwCjwOLdDpvOXV76EhpP3_lBaJDvtDCOtmA>
    <xmx:ZQJzanrqVyowWNOpbRk4YXtUjCZbPYQKabWrYeeWV1dX5kG1uI4Hkg>
    <xmx:ZQJzanCFe4AhuOjY3QqblcXTwetzs6eb6QqKsgmj566qBVg3WKa5Mw>
    <xmx:ZQJzan-R-tVtnUTtH71uMJ7daQFyjK-dxf2J7-a7TYbxmGn6fVf9JLdP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:29:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f3a37f6b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 09:29:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 05 Aug 2026 11:28:54 +0200
Subject: [PATCH v3 4/6] setup: defer object database creation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pks-odb-create-on-disk-v3-4-c0ee3ac5141f@pks.im>
References: <20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im>
In-Reply-To: <20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

In a subsequent commit we'll make the creation of the on-disk data
structures of an object database pluggable. This will lead to an
in-between state where we have already configured the repository's
object database, but it's not usable yet until we eventually call
`create_object_directory()`.

Defer the object database creation so that we handle both steps in the
same function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 24 +++++++++++++++---------
 setup.h |  9 +++++++++
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/setup.c b/setup.c
index 5dfab3e79e..d85171f3b6 100644
--- a/setup.c
+++ b/setup.c
@@ -1765,8 +1765,6 @@ int apply_repository_format(struct repository *repo,
 			    enum apply_repository_format_flags flags,
 			    struct strbuf *err)
 {
-	enum odb_new_flags odb_new_flags = 0;
-
 	if (verify_repository_format(format, err) < 0)
 		return -1;
 
@@ -1801,9 +1799,12 @@ int apply_repository_format(struct repository *repo,
 	repo->repository_format_precious_objects =
 		format->precious_objects;
 
-	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV)
-		odb_new_flags |= ODB_NEW_HONOR_ENV;
-	repo->objects = odb_new(repo, odb_new_flags);
+	if (!(flags & APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION)) {
+		enum odb_new_flags odb_new_flags = 0;
+		if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV)
+			odb_new_flags |= ODB_NEW_HONOR_ENV;
+		repo->objects = odb_new(repo, odb_new_flags);
+	}
 
 	return 0;
 }
@@ -2651,11 +2652,13 @@ static int create_default_files(struct repository *repo,
 	return reinit;
 }
 
-static void create_object_directory(struct repository *repo)
+static void create_object_database(struct repository *repo)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t baselen;
 
+	repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
+
 	strbuf_addstr(&path, repo_get_object_directory(repo));
 	baselen = path.len;
 
@@ -2864,9 +2867,10 @@ int init_db(struct repository *repo,
 	 */
 	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
 	repository_format_configure(&repo_fmt, hash, ref_storage_format);
-	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
+	if (apply_repository_format(repo, &repo_fmt,
+				    APPLY_REPOSITORY_FORMAT_HONOR_ENV |
+				    APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION, &err) < 0)
 		die("%s", err.buf);
-	startup_info->have_repository = 1;
 
 	/*
 	 * Ensure `core.hidedotfiles` is processed. This must happen after we
@@ -2882,7 +2886,9 @@ int init_db(struct repository *repo,
 
 	if (!(flags & INIT_DB_SKIP_REFDB))
 		create_reference_database(repo, initial_branch, flags & INIT_DB_QUIET);
-	create_object_directory(repo);
+	create_object_database(repo);
+
+	startup_info->have_repository = 1;
 
 	if (repo_settings_get_shared_repository(repo)) {
 		char buf[10];
diff --git a/setup.h b/setup.h
index 654f10e059..e55d647b70 100644
--- a/setup.h
+++ b/setup.h
@@ -241,6 +241,15 @@ enum apply_repository_format_flags {
 	 * relate to the object database.
 	 */
 	APPLY_REPOSITORY_FORMAT_HONOR_ENV = (1 << 0),
+
+	/*
+	 * Usually, the object database is created after the repository format
+	 * was applied. This step is skipped if this flag is set, which leaves
+	 * us with a partially-working repository.
+	 *
+	 * This is useful when initializing a new repository.
+	 */
+	APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION = (1 << 1),
 };
 
 /*

-- 
2.55.0.679.g6767b8d81c.dirty

