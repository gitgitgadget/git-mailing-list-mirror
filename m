Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BED28469B
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297435; cv=none; b=Pzj3kMan2SZ2yQxOBbnRjXLZqzWMD4HyLyJlCDOtfog3F+Kq6xMWQ4P9+0HIut3VOEL6fgqbrXK2/a8BocnLSCyUh2hatA4UcA2TmaYDer5viDQlcR61ccPT8VVvVPvMBOrdLnTD1DbvVqovFKghtgtZ+Ou5X2sALuZQKQhIOuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297435; c=relaxed/simple;
	bh=xFmm+2sKCxPRqJOGTlvIwl1Xkm7yrPlMtGK8KLrSRbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fYFhu/UYOqFp5FBcmgO1qOUHdA7wtKPZKxKx/ASQukdkM9Tg4AW8Q4nkBokb3wRRcnmLQgeymFqEPBYtCW8DJNcSfWugNccaFjdhA6cTvw9BOc2ieBwDUFM4HBjPQgC5MW38V2Vt66SFOgDFNwl7e1FcZB2Sy1dnVY/zyiY++q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AMTYsVU0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k6Pqc9fc; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AMTYsVU0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k6Pqc9fc"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 48DA11D000A6;
	Wed, 24 Jun 2026 06:37:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 24 Jun 2026 06:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782297433;
	 x=1782383833; bh=8C4BgYaCb4sBbJjCGV2unTq1+1QcltbgxNBiF/YQN7o=; b=
	AMTYsVU09Brpe3YrsaaI+38rPlUszoN2TSxipCQJ29yqeVzhNeajxDVOYxNEVjFx
	1l0GQbP8O7pAvLYrZNRJ3V4RNlSec8e3ioCkhBKk0U91c0s327g/sVNCwLZpFf5F
	XH5b+5pxuOfc5ykQ5B96Z9rKJ2+hWoDCmcoQaTQcMPccFmeelSzLiICNzmE1y4Se
	AjsU86yG9uuSR5bDGn1U9HZNyK9/893OpAzpQU3+aVEeMvJeEs9JtxCQDSsZj32s
	3yKQhiFA06qITyeWo6CdI6cLidDt8I8rhM7Ld5YCbsQ2Vkn2Z33uYmPc2IwHzCe6
	Qbo34O2HqjOdJGXCS2Sbew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782297433; x=
	1782383833; bh=8C4BgYaCb4sBbJjCGV2unTq1+1QcltbgxNBiF/YQN7o=; b=k
	6Pqc9fcpV4prljYVFzyW9CEaZY8QVjnH+q6N1nDnND79r0sS2IZT9pMFe+3VKTOo
	DVIDjrlELOOaYEy5KJorbsK6d+zbMPGrmmpCLgLFNt6q0+WGsZeJocv/Yekza1vy
	EkKjIc2uhcZ4F5qJXTkA/vxI7OlUYivN2l6EK5k4p4jwISjJpBiBx1hi7OmLAcEr
	vD7D6aap/sufvvFgVAyIzG30od/+Mx2brBJ4plBHYB+SeHJrP0Df7js+ZbBQb2Ad
	VGyEFp9Mj9cqqBi4vEmyB8aF9tSbtbhstvPA1shGlg3KX/iM+S21sjCahDx8MWjw
	LO4SYHwBFAIvSo1Ayo+CQ==
X-ME-Sender: <xms:WLM7aql_Mp1dkJMkx3Fc8xHvwcG6OivrYRzkoWPRoTuwCUJLrH4-1Q>
    <xme:WLM7apQo0Dz85x1vZIAEA0vbfzbgzMpeEF0Yd64OqvIBxo-pL6UEYk1snA3tNtLGS
    BYmfl3WZnwHVA-bQ4rj0V0V2LDzJZboqHQvIC4wVEtgHDi0auIxTA>
X-ME-Received: <xmr:WLM7amBHBN6BBegskvs-geYgeyn6-5T3RJfH0rlW2SxjGdeKwTyu95XteZJwNPjkW6i9VLnbSk0bHqgre0r0xP7l3lbS_Ej5OPFESWmA>
X-ME-Proxy-Cause: dmFkZTEOwm4YoRsqFw0fXg4S9vibqhIjnq3CiK14uK5FjeG4Pjj47W66neq0QFAMtlLRvm
    JK8JIMJ9wQ8saYTRxk6t5b4UxJiYlnDrLqO47htI8sxO+J/Say5jKZSEP2D7A7pObQhm6r
    lKQ2NqJCCp0oXDPfqyMmHbDn3JT6fGlY32Cz8SeiwgjBwpGOTD6/V8y4W20+4Gt5+tLsEE
    ktr3MVx/eC0cP0DSNDwYr4lzkXS9VHkWGzpA0TZ5lrziO6+2/D2yl9u6KE7QfJ6xmPZRtl
    8LlPQoUSg864j3FNeioxfBshytaxXuyfhW1wzArwh5HfwCOrvnjF/TELDiZKETzbq2q5qI
    pZht6j3cvfBqDXd1tMUM4Y751vgUGfZre3E6PK158z0Um+pNOTWsjTKzgSyA4abEwJ7Sz2
    lknd5xvvqAwVYo1f77luCgbeXYjdV6TIT03fGL5ABEloqqt6716VJLPrVUNgqTtGn/6o1r
    +9NqyVs2aABYgSnl3bTMyee2r4D8jW2N7aMgwZrIfO5ZfdhM/RSc7pafokdeIQ9nv456J2
    HOUKZtei1lUOKdv2ot6q9uixT+oWyVOHmFaEcZ36cd3egKj9BioISWyASoWUjna9FIHa7c
    rzzk2B78nyLIxWLXnk8u7m3Qpr+80y1iAqWD8/3+QKU9FF1xiyeCDH6cz/CQ
X-ME-Proxy: <xmx:WLM7aoQnPVXUXoqaXa1OSNQQ6-YhVW64fVxmDPiZqNjnYjGZxCyuqA>
    <xmx:WLM7asrmm4xTLCXgAd_Fg3bunxUW8T_NM0E18i7gzEWT1YzGsbGR5A>
    <xmx:WLM7aixBhOj2_muPeU1N6c6OQ0xLK4IkhCAUOPXmjESM-Ghpcg1-2A>
    <xmx:WLM7apJRQH2G7ze1onN_IQ96GZD0H7_VAmteM8XeLhCQdkYZzxRkDw>
    <xmx:WbM7ai4kWoQTbOLOsF9HCcR5423juMT4uler5BksQemgxEtiPU4OgYLj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 06:37:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ad57d3b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 10:37:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 12:37:03 +0200
Subject: [PATCH v2 1/4] odb/source-packed: extract logic to skip certain
 packs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-pks-connected-generic-promisor-checks-v2-1-132d73ee47b9@pks.im>
References: <20260624-pks-connected-generic-promisor-checks-v2-0-132d73ee47b9@pks.im>
In-Reply-To: <20260624-pks-connected-generic-promisor-checks-v2-0-132d73ee47b9@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

The caller can pass flags that allow them to filter out specific kinds
of objects when iterating objects via `odb_for_each_object()`. This only
works for "normal" iteration though, as we `BUG()` when the user passes
flags and specifies an object prefix.

This limitation will be lifted in the next commit. Prepare for this by
extracting the logic that skips certain kinds of packs so that we can
easily reuse it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-packed.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/odb/source-packed.c b/odb/source-packed.c
index 42c28fba0e..3afc4bf01f 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -126,6 +126,22 @@ static int match_hash(unsigned len, const unsigned char *a, const unsigned char
 	return 1;
 }
 
+static bool should_exclude_pack(struct packed_git *p, enum odb_for_each_object_flags flags)
+{
+	if ((flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
+		return true;
+	if ((flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
+	    !p->pack_promisor)
+		return true;
+	if ((flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
+	    p->pack_keep_in_core)
+		return true;
+	if ((flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
+	    p->pack_keep)
+		return true;
+	return false;
+}
+
 static int for_each_prefixed_object_in_midx(
 	struct odb_source_packed *store,
 	struct multi_pack_index *m,
@@ -306,17 +322,9 @@ static int odb_source_packed_for_each_object(struct odb_source *source,
 	for (e = packfile_store_get_packs(packed); e; e = e->next) {
 		struct packed_git *p = e->pack;
 
-		if ((opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
-			continue;
-		if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
-		    !p->pack_promisor)
-			continue;
-		if ((opts->flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
-		    p->pack_keep_in_core)
-			continue;
-		if ((opts->flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
-		    p->pack_keep)
+		if (should_exclude_pack(p, opts->flags))
 			continue;
+
 		if (open_pack_index(p)) {
 			pack_errors = 1;
 			continue;

-- 
2.55.0.rc1.745.g43192e7977.dirty

