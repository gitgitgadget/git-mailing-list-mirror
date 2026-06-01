Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C238A734
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302037; cv=none; b=eRmZOpJ1Ny3vr6kXJQc9+QGLoMqQ7LQru5tU8aggvHT6js09ncaPjg8TJz8802QeSNl4dUydA/EmaAF/WqpSYx9qM+xaMetHjUeIAGAuGF1v7AQiTe5+CzKQ4kqYm+XVpP0ztyG84AV7kuLPe6Zfr46lw9aP+2ADDDGif1WqSt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302037; c=relaxed/simple;
	bh=6e0dmOEecgMeFVQN54ihP03yHlTqaQYGqXjAVnOgRVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VRHlMr02Iwcm/YejUMmTV9UcfL7rgZ8M2Kj5tbfx/9fW+pm02MEn2/gYYCQ4hecmlmxd48nJOzWHktJe+jr7guzmMN8jxxIQk7eVUmwIKtTz7A+VJ37nbBklSDsraYjmIw2M0bEWWwDuS23mu2sIsBHbJE1AzJNM930GbHpAgrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jQoi9qs4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K5g6XgMv; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jQoi9qs4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K5g6XgMv"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2C59BEC01B5;
	Mon,  1 Jun 2026 04:20:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 04:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302035;
	 x=1780388435; bh=bbHftUDs+QYZ9baVg8bZoYPgEsIDBp3nK3g073uCtKw=; b=
	jQoi9qs4er/VamyYQmQ36C6MtrZ3lGvdttQTtJlqrZ+xRslsy9eOW+Qm5Ln/3EGB
	E33VbBHLix3o2253PmPwBhutHHw5NUsZnN+tFtxu/BvYH1swAsjkum9uzLWkM/94
	ZCBUt8WirNDjJBk3UzNigEovCZinjfPEqQuXyClKuXICLR+1pM6pMshcC72auODK
	4hDEbcyIxOzrTKzHa236wXLd9VI2NFU5Pm0DyjFO4xjB6/yijr6xaRet8q3cREja
	AS8wFrSaGQ8fvzHLeABtRzDmSlB/HyqMh4nqqtagZf3m8LHSU5tJUaN9YCmiuVKv
	IzMu1xL0JfDsy9IHxw0lxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302035; x=
	1780388435; bh=bbHftUDs+QYZ9baVg8bZoYPgEsIDBp3nK3g073uCtKw=; b=K
	5g6XgMvN3TxF7/U3nrSdiI7mpmf7ENYR8Ig2Gyuhte7vzjQNY2JOkJNMf4rzj645
	YTJEuhmDp9O/rE4LM8qIj8iygdCPojh/ouC1T61P8tcRBhCaOZzOz6X+ZcbeZ4e/
	agSQ8jj65NQdsi/z4TzRH01iX2K8GVsPICkbI/6J11i+HEtC8nfLnp47RDFivyEt
	PNB641YfjrXmkCn5NZEp/5tNzwwh5dMsyCcPW9sbtpnBM6bHKgHQ/+taLN7/av/O
	HJMjEmjQ4Mf6Qf/FeTTVEeRy4imBCA1LuDUU636n8OU3rUlX/rMW5cAsLVoFGLSm
	wagIqzYpvHFnVWX/09bQQ==
X-ME-Sender: <xms:00Adajk7cY8Z54rhThoHOKP1G0CCXg1xcMRfrKBG3MO-J4J2UzxbMQ>
    <xme:00Adas0Mi61RZvTAyBqzNJBCN4sPx5ecxsDTGnxKcJVZ7jEPt4c9X7nRowctTIHGU
    xY0W23saC6TNHpCB2l_cBr9j9Pvk2nZSfrxrKcZ70Qaq54hlCQ>
X-ME-Received: <xmr:00AdanSX-Zh_McrIni2ZE6dFor6hfKLe3buL1Gl-84AN15shYsjDuvwdyVe3TMS0Dn0-TMVwmdpiYm6Z-BSPKdel_2cR8JvoS9DgaFzvLa1J>
X-ME-Proxy-Cause: dmFkZTGoVC3PWkC/M98GLpgwKSp8+X2EEbK9QrLPRCVzfq6z8mGb2cg1WSKI0P1YF6K99Q
    xKY18KC2TzQ71gWxrLtHBcpqPwInMMILQwQmN+IaQps5jv2t4yhm/OcWnxr3PAuKdie/5H
    xdZiEXHfq3CyGlKpLwv2vL5myW19uyY8AtAnQMD9jV84wJQFe0QGymylYpZQO++m8ND1Hj
    j7fjS2tB+vIBobG7JpZXtzobTDeXEGy6yi7zeMBs162gs+xcsIodAA21pY4HTX/IAVCIU8
    kOLzJFDG9r9Lr/xlbzdlHVCtb2SlM1MPmdQV95SWFIB7kaTFV8arUy82aX0eqGVCnq+ErH
    ND7p0n7Sib52hKkyWFAQwREeWcoSGckj34n5kOuHsoLKKn/7C/ekI0A84UE4WslPfzKTNg
    uTK9d0J9JeEE5rc9OpzGgCWpbFBMHbvNKIxIAZpIWrG8y4FW3rr2zR5SOFU7jlNbRhIbQD
    j7PTSsOlgDSvOKuYQidhshhvi7g7N1TveL+db5+Y7fkScSEyWJ5B6hGkudmklPYRRurNxE
    l9kRdxa6LDFU9F1bnyJBm6s44KbnFR3JRi9sX0+J8sPPDQ57DAJD69HwwP/de7MOUAHcLd
    8+SqAowdPburirLXoKjZJ4ByIgBdgWwRSUrKFCxr4Jc1xUKfZ90B0rK4WOqQ
X-ME-Proxy: <xmx:00Adamv9Ib8N6UXkNUuRlMhgDayIJ_ex6AHStcZT_DRuXYUwV_vfZw>
    <xmx:00AdakaGkT2zB142KWARd8mdQ3xXCqT5CLMWQ1FhZpGGTt5BcXBXdw>
    <xmx:00Adajv7uA9CABmnskaSFuJhvVh9Zy0vkTaGLNUHlpcmlCtyhSJoYg>
    <xmx:00AdauGscoP1hSIXe_s2gJMebaqKMXS2UhPT3fuwEOvMnXceTK16XA>
    <xmx:00Adau9ZyZRoeg3wT8w_y8gNr089Ha_a6i0KEITYfki1f4d7jI-lgFDF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:20:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a0e5fb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:20:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 10:20:25 +0200
Subject: [PATCH v2 02/18] odb/source-loose: store pointer to "files"
 instead of generic source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-odb-source-loose-v2-2-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The `struct odb_source_loose` holds a pointer to its owning parent
source. The way that Git is currently structured, this parent is always
the "files" source. In subsequent commits we're going to detangle that
so that the "loose" source doesn't have any owning parent source at all
so that it can be used as a completely standalone source.

Detangling this mess is somewhat intricate though, and is made even more
intricate because it's not always clear which kind of source one is
holding at a specific point in time -- either the parent "files" source,
or the child "loose" source.

Make this relationship more explicit by storing a pointer to the "files"
source instead of storing a pointer to a generic `struct odb_source`.
This will help make subsequent steps a bit clearer.

Note that this is a temporary step, only. At the end of this series
we will have dropped the parent pointer completely.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 4 ++--
 odb/source-files.c | 2 +-
 odb/source-loose.c | 4 ++--
 odb/source-loose.h | 5 +++--
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/object-file.c b/object-file.c
index 641bd9c079..7a1908bfc0 100644
--- a/object-file.c
+++ b/object-file.c
@@ -178,7 +178,7 @@ static int open_loose_object(struct odb_source_loose *loose,
 	static struct strbuf buf = STRBUF_INIT;
 	int fd;
 
-	*path = odb_loose_path(loose->source, &buf, oid);
+	*path = odb_loose_path(&loose->files->base, &buf, oid);
 	fd = git_open(*path);
 	if (fd >= 0)
 		return fd;
@@ -189,7 +189,7 @@ static int open_loose_object(struct odb_source_loose *loose,
 static int quick_has_loose(struct odb_source_loose *loose,
 			   const struct object_id *oid)
 {
-	return !!oidtree_contains(odb_source_loose_cache(loose->source, oid), oid);
+	return !!oidtree_contains(odb_source_loose_cache(&loose->files->base, oid), oid);
 }
 
 /*
diff --git a/odb/source-files.c b/odb/source-files.c
index b5abd20e97..185cc6903e 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -264,7 +264,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 
 	CALLOC_ARRAY(files, 1);
 	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, path, local);
-	files->loose = odb_source_loose_new(&files->base);
+	files->loose = odb_source_loose_new(files);
 	files->packed = packfile_store_new(&files->base);
 
 	files->base.free = odb_source_files_free;
diff --git a/odb/source-loose.c b/odb/source-loose.c
index b944d21813..c9e7414814 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -1,10 +1,10 @@
 #include "git-compat-util.h"
 #include "odb/source-loose.h"
 
-struct odb_source_loose *odb_source_loose_new(struct odb_source *source)
+struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 {
 	struct odb_source_loose *loose;
 	CALLOC_ARRAY(loose, 1);
-	loose->source = source;
+	loose->files = files;
 	return loose;
 }
diff --git a/odb/source-loose.h b/odb/source-loose.h
index 8b4bac77ea..bf61e767c8 100644
--- a/odb/source-loose.h
+++ b/odb/source-loose.h
@@ -3,6 +3,7 @@
 
 #include "odb/source.h"
 
+struct odb_source_files;
 struct object_database;
 struct oidtree;
 
@@ -11,7 +12,7 @@ struct oidtree;
  * file per object. This source is part of the files source.
  */
 struct odb_source_loose {
-	struct odb_source *source;
+	struct odb_source_files *files;
 
 	/*
 	 * Used to store the results of readdir(3) calls when we are OK
@@ -29,6 +30,6 @@ struct odb_source_loose {
 	struct loose_object_map *map;
 };
 
-struct odb_source_loose *odb_source_loose_new(struct odb_source *source);
+struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files);
 
 #endif

-- 
2.54.0.926.g75ba10bac6.dirty

