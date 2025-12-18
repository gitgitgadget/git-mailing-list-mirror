Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33FB3218A6
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039327; cv=none; b=edfjwcwX5EZo2oTMjZTf4iQZ5cdcG2tMCipxg0v9GP1l3J9pim9xLxPf/ZaGsI7sRlcDNsCVeUrDlB7X8+QFcHDkjgGUeALZtnfCmGjo62Q8LJj48qjOXGCyeDciNk8yY0u8yC9UW0T8SPvCWntJLR2HNF+LkHWCUrmejOT7zqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039327; c=relaxed/simple;
	bh=DDXGsA7OHE5nUL6fHZVn/vPw8eGg4KXNNxjIhOi0oG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OmweT9mBAhjYtPj1ftLyzDc5rR8a5BNxn2WmvA3Rf+Piyot94KnyHniN8PV+zNoClnRWugSZOOZDS7tEh88kBW+AGZfJOqAKgOXh3VOjNhVjoDX2WN3JzhdNZ0068DxMa2XlhP+QwIvqdc8FsI0sDQ+9NrfOOoBGhpbBaQJyGfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vQLzjaor; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ccd8NGyI; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vQLzjaor";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ccd8NGyI"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 24F1D7A0177;
	Thu, 18 Dec 2025 01:28:45 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 18 Dec 2025 01:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766039325;
	 x=1766125725; bh=mTUj+PbxbuIYeyyPCPuuJPYrJHjuEsmGG8QChZ4zfsc=; b=
	vQLzjaorViiWSZGBaehXLxmd9ttCYNBIho4yp9kOfzIfE0UOWmr4em89NnEBOLJ2
	9Khu7qC54qBIk8DV7cyRX+9Wt9BYABa9w9pFScQ7g0p1hXNidrdLhwnqKIETeDif
	5LJAkrc0jpX2EP8ZoouNi9bUHGXe61I2lNi0qP+09N9c4IwHstDd6li37gzuSBSq
	gS/aAshPGzITsAtTRF0I4pRcfUIQy3PWkRuwXosH/2PfV0165JYUbeiEWDSkRCyd
	3fUehDpJ0LUpIHvcDpzaiXRISeVjQW4/3ZVYN56tP3cPeBy0J1STGaetJDJHuh3F
	Xx3OyQOCOQqhomyynOjGiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766039325; x=
	1766125725; bh=mTUj+PbxbuIYeyyPCPuuJPYrJHjuEsmGG8QChZ4zfsc=; b=c
	cd8NGyIp6vkLbjZ5FVHkdUDv6gGA4llEFCiSb8eHHPCnExCr7O4M5MrQ33w70Qcz
	0hpGpy8H5OnU97v3Y3RDq6GR9/XnffOLBCwuRoTOxo1wPvK0v6V926cUkP8ZB0rV
	teS++flzkV9VDceVyi72R6xDZ2kXfYPikKGe0iNC5bZj21Fxg5HkQyt4EyvRqRsf
	UeS2+oUXwoTd7IXCFiohukZxKNLpjdI2AHi9bsKqioJzBaIsXrOGpJd5axyq0/BG
	Z5HF7AwFatt90pggCVXAXxWqXLVICocic/E7A/px/zrgh2h3kJZ/LFzk3KCrVy+p
	adfxzbVQGllb+Tc87XOWQ==
X-ME-Sender: <xms:HJ9DaXtPBgZTXQxaIWrVXK0YeT44Zgnpr9DrsFek-5-9a-xsg9rCmQ>
    <xme:HJ9Daf5QTt0HCf0seDZ0VODMWvfRmsxfDfVXE6jDdh0tbeEFyfevm5oIqltPrwQbM
    uc_pEp0-5rUbQ63SgZ9R-ScIc8Z9ySNzvhjDm_lgL7okzZ3UqzYXg>
X-ME-Received: <xmr:HJ9DaYK4wrmvFNuXw3IAFxS2U1Rfj4kKOffAe1L3thJmG28zG9HJ-z6qbBHjYCZukTuEZJMAijBeT8fdssB-HCW8gkfWE4Hfu0Euon9yHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegrphhlrghtthhnvg
    hrsehnvhhiughirgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:HJ9Daf7eT8Z0aflUufDsWtJGJvmcoOvX4h1SFjLalbw2UAGAJ1sSrA>
    <xmx:HJ9Dabyh43KVWEp6d1R-MPquSbxsamzWJizCmAEK9joFLppFRqoa8g>
    <xmx:HJ9DaTZGHJoesv4spJaYLaaXIFHRmkvTTYsJU68efJkWu8b1cVvfYA>
    <xmx:HJ9DadRyuQAJYegpQBsAmjetn9eSf9ZOeAoA8G75YKDZfQws_eQJHA>
    <xmx:HZ9DabhWeqUVjJLWYXHpzfwAXM5kVfg34cr0qCnOEgrVSBpRnf1jxE4C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:28:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5661d110 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:28:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 07:28:17 +0100
Subject: [PATCH 7/8] packfile: fix short-circuiting of empty requests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-odb-read-object-info-improvements-v1-7-81c8368492be@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v1-0-81c8368492be@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>
X-Mailer: b4 0.14.3

When reading object information from the packfile store we have logic
that tries to bail out early on empty requests. This is supposed to be a
performance optimization so that we don't even have to unpack the object
header stored in the packfile.

This optimization doesn't work though: we compare the passed-in object
info pointer with the pointer of an on-stack variable, which of course
cannot ever become true. This issue was introduced via d9f517d051
(object-file: split out functions relating to object store subsystem,
2025-04-15): before this commit, we checked whether the passed-in object
info was a `NULL` pointer, and if so, we set it to point to `blank_oi`
instead. The commit then split up these the logic so that we continue to
set up `blank_oi` in `do_oid_object_info_extended()`, but then do the
check in `packfile_store_read_object_info()`. But even before that
commit the logic was only partially working, as it could very well be
that callers pass a blank object info themselves.

Fix this bug by introducing a new `object_info_is_blank_request()`
helper, which simply verifies that none of the contained request
pointers are populated.

Reported-by: Aaron Plattner <aplattner@nvidia.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h      | 10 ++++++++++
 packfile.c |  3 +--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/odb.h b/odb.h
index afae5e5c01..b869c054c1 100644
--- a/odb.h
+++ b/odb.h
@@ -353,6 +353,16 @@ struct object_info {
 	} u;
 };
 
+/*
+ * Given an object info structure, figure out whether any of its request
+ * pointers are populated.
+ */
+static inline bool object_info_is_blank_request(struct object_info *oi)
+{
+	return !oi->typep && !oi->sizep && !oi->disk_sizep &&
+		!oi->delta_base_oid && !oi->contentp;
+}
+
 /*
  * Initializer for a "struct object_info" that wants no items. You may
  * also memset() the memory to all-zeroes.
diff --git a/packfile.c b/packfile.c
index d2ae2432eb..ce83e77899 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2157,7 +2157,6 @@ int packfile_store_read_object_info(struct packfile_store *store,
 				    struct object_info *oi,
 				    unsigned flags UNUSED)
 {
-	static struct object_info blank_oi = OBJECT_INFO_INIT;
 	struct pack_entry e;
 	int ret;
 
@@ -2168,7 +2167,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	 * We know that the caller doesn't actually need the
 	 * information below, so return early.
 	 */
-	if (oi == &blank_oi) {
+	if (object_info_is_blank_request(oi)) {
 		oi->whence = OI_PACKED;
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;

-- 
2.52.0.351.gbe84eed79e.dirty

