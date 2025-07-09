Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7848D2BE63F
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059855; cv=none; b=sJWsyqCTElbrs/t4nxn+2ucndmzA2U4EbOAAhCv1lLxhyINxjygAcCNEXVvufdPGPuLPDa+qSOcDIwi4fEXVFM1w3d4GlGlAjD/LsEMuNNtLVe0NBFLy4bpuiHL9i85LpdOxDzGhZ+fpXwFUDs193IjTYQycaPE8cc0KDBNFi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059855; c=relaxed/simple;
	bh=DBNAwiDDclZkzjb7/Lz98oLwyd6pLLvuPjoS0oZNSYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PHid/R3YISuIM1NrW1EnTraQbdL17FkYuepJmSymRNQ9hWLigFfXpg7q/pJj5gjr2zLI2iUdMAnd3qS41mqX2f8G8cjyydO0VPVryja4yjXNNNaF5wWCzAj9sxEfPSTMjVZL93Npl36aObZ21jDiKWwf/Ka7+M2siFZSP6qwWaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kSOFBCAw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=adkefWH7; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kSOFBCAw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="adkefWH7"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B7FB61400330
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:17:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 09 Jul 2025 07:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752059852;
	 x=1752146252; bh=QSDKq7WvpsxzoqcBIpSvHW0mfROR26AAEOvUuQnY7Uw=; b=
	kSOFBCAwYuAsR28I2/wWJpM4optRRZSHOeGII+MUCRjSRCIlzEX/oeEmtem8xmxI
	H6m7B8cDwFia36c9ErRtpWK3Sy6oG7EgTeyAoU2jyIUp9c3ZZsinU+hhQqn8Z5Ml
	/aTcXuaO+mDizwG5N+YC0q3kPM2YNH/TUnqDCgh6NknQUL/uPpF3DABtkzIWxzIf
	yG7In51M1AvfO4F28hewEcH3FWgghkc/jy3Ebr/sGMBmAYB43SPKuMVeM6OxAISZ
	K2UCgxojeoLpsIbPxv1IPij+4yZDoVmt+FggfW0boaalGeTc79jm6pY5HlkQpYX5
	87uTlyFZUY+AOksc4BhWMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059852; x=
	1752146252; bh=QSDKq7WvpsxzoqcBIpSvHW0mfROR26AAEOvUuQnY7Uw=; b=a
	dkefWH7NKCpnpoMOkaiZZ5PRMisHsdKEIgkCwjdxpHm9Vp6/GHYBWzGNKWkk9Xo4
	rmo0UgAddnDdc3uACU/U9qKanvLKlaQuV2nHT1s/WRuDCrpzeijnB+eKtbYECvjq
	dAdrgZYChI/lGFLx31ZyLhy7pxjr4+qRww4QqSK30z7VMILhTthLHDGIU33/xvuq
	MjaxJpS5cPqq+A1afuk7zbAbJBUsFbPY5fzOsOVPiAXJ7bhJjmkVIAnMgqguvt12
	48glG80AN9Iye6BDDJnb2LQeuC3uhDB2LFmzPbRhBZnzD50CFN5kJTVtiOcD6tdv
	gFT76MIdGizNa7WsDJpdg==
X-ME-Sender: <xms:zE9uaDTU8t0qwBmOiqSwtAkTxvIbbOZ33uRjcOb5O0Lwwf0kvx7y0Q>
    <xme:zE9uaGx9Hd91fJeNXjvFjfRtREAcMAxpO3BxKO46LafAW190V3_IuZP_LlFWb6LeW
    Qj-J-PGFEFGbGOsVg>
X-ME-Received: <xmr:zE9uaCPwQi5u8NSeQ6r7b3xhGHCAvEIHVbMYbtWvRW32a1_cAqeDOKMlSYjyQdGCGzmYWt4WrDTrWw7KW7In1NlJe-Kz-bh02mkHFa0eyTp8tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:zE9uaFOmqDFYJvWER20kffvpjfVXcm-E6CTPsxzRhu-Un1bPwUbgUQ>
    <xmx:zE9uaERQbLqtMXvjNtfTugJobe8ZCwB4obOs_6DiRxQxEPXk-vDDyg>
    <xmx:zE9uaHBO6rVCIp_govptTcsltCaCRr4rl1ENbyM8VqhH6ztHpP36yw>
    <xmx:zE9uaDilDz9s-Mvb3StFQlKnDJD-fi3vhxSVvhbewpyWTPBHkg9VLw>
    <xmx:zE9uaAIG5jxn4Z1vbbQxmPX8DdweSQWvDkBYoH5ym5yHESBGgqFWwdQ4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:17:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eb77f292 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:17:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 13:17:14 +0200
Subject: [PATCH 04/19] object-file: inline `check_and_freshen()` functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-4-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The `check_and_freshen()` functions are only used by a single caller
now. Inline them into `freshen_loose_object()`.

While at it, rename `check_and_freshen_odb()` to `_source()` to reflect
that it works on a single object source instead of on the whole database.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/object-file.c b/object-file.c
index 7aecaa3d2a0..9e17e608f78 100644
--- a/object-file.c
+++ b/object-file.c
@@ -89,42 +89,19 @@ int check_and_freshen_file(const char *fn, int freshen)
 	return 1;
 }
 
-static int check_and_freshen_odb(struct odb_source *source,
-				 const struct object_id *oid,
-				 int freshen)
+static int check_and_freshen_source(struct odb_source *source,
+				    const struct object_id *oid,
+				    int freshen)
 {
 	static struct strbuf path = STRBUF_INIT;
 	odb_loose_path(source, &path, oid);
 	return check_and_freshen_file(path.buf, freshen);
 }
 
-static int check_and_freshen_local(const struct object_id *oid, int freshen)
-{
-	return check_and_freshen_odb(the_repository->objects->sources, oid, freshen);
-}
-
-static int check_and_freshen_nonlocal(const struct object_id *oid, int freshen)
-{
-	struct odb_source *source;
-
-	odb_prepare_alternates(the_repository->objects);
-	for (source = the_repository->objects->sources->next; source; source = source->next) {
-		if (check_and_freshen_odb(source, oid, freshen))
-			return 1;
-	}
-	return 0;
-}
-
-static int check_and_freshen(const struct object_id *oid, int freshen)
-{
-	return check_and_freshen_local(oid, freshen) ||
-	       check_and_freshen_nonlocal(oid, freshen);
-}
-
 int has_loose_object(struct odb_source *source,
 		     const struct object_id *oid)
 {
-	return check_and_freshen_odb(source, oid, 0);
+	return check_and_freshen_source(source, oid, 0);
 }
 
 int format_object_header(char *str, size_t size, enum object_type type,
@@ -918,7 +895,15 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 
 static int freshen_loose_object(const struct object_id *oid)
 {
-	return check_and_freshen(oid, 1);
+	struct odb_source *source;
+
+	odb_prepare_alternates(the_repository->objects);
+	for (source = the_repository->objects->sources; source; source = source->next) {
+		if (check_and_freshen_source(source, oid, 1))
+			return 1;
+	}
+
+	return 0;
 }
 
 static int freshen_packed_object(const struct object_id *oid)

-- 
2.50.1.327.g047016eb4a.dirty

