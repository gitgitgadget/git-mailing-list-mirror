Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B103B19A8
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673363; cv=none; b=ovAoESX3xbmdtTrFWrFTjlcDncEN9FOWFvRnLSuaMi36xSYFtMnBE2kA95+u9QP0Sr8j62cu2j+tkMUs5JFB+4fqHyOVyj0ylyBuTRPUX2UqZQJyYKvqysdgwP8m0LW1p8UDkugdgR48t8pQGzOj7v1FQ9j3eKE3Wf8O0CJK6uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673363; c=relaxed/simple;
	bh=pYP9IyfmdKkE24ihd00QFBey7+gv8HbK0+6CaijuFLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qgkD1EPajrusOIM5wwMdB7PzeqyoU7f6rTXRiUOppdAG9oAK2pZrU9cLbApg2mo1aV5gvACyf2FXxvkEfML23VWrkS+o4lCh6zrF4cdr7S9H8AmxgjYtade/LYtWv8LsVbmdzxUugdTMqLiUKlL6uwOCJ2CFJzjmPPnw7NUWrTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dcbZUK9Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=px8hnWFT; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dcbZUK9Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="px8hnWFT"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7922C1400096;
	Fri, 10 Jul 2026 04:49:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 10 Jul 2026 04:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783673361;
	 x=1783759761; bh=ise0ikbTck+BH+a3D3HE8zqhZVl30TP5saMxHP6oPyg=; b=
	dcbZUK9ZAPQT1nSRlF15saI79qN5tkl3LXhp8jOqeFfw2puLd3snbPssuW4LwlVo
	In/GSZshWHLIPLjv5niHFYE+9HH50KIuiZXpV1YLWGxfuCX7lrQFOtDudE6N/5Lp
	7COsEHR+N8ZnQYFU+Lc4iXu0A1wKU8HvLePMcCUvUWQyDJ2u3YjB7WzcCdNz5URW
	iZi0/OnFNAQ5kqF217LwrhibDKrwTV5jzorCZrb07CY8+LbOZsSPXBSA154RKJNL
	+6PAWK2boELfN/FRh7khFU95lqBdzrdMhUuUynyqDCT9YFRh5ww8+KtdFahDGmKP
	H8f42RaMDfSxVzSsfAhhgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783673361; x=
	1783759761; bh=ise0ikbTck+BH+a3D3HE8zqhZVl30TP5saMxHP6oPyg=; b=p
	x8hnWFTSUS1lbDdwiWlMkgCe1KygrxD+rUBpL602vUbpYC6EYj/BaByO0LOteEuV
	aU1QbZhfuXVk4Xu35QXr1t/n07vWdCa5TGIBp/DcRDVZV+i8eieZd+GDdpy5gnjH
	F9A0eCknBLi+mFB791yvRDE8++WusZUWypepIZfw/VrTdHW5FRYrYbVL9TTJ0EaV
	6iuIZDsz/ej4iIsT2HOvMCl3jU/p3fKPPb+rHoxyFspiVffptFeZWSBToWEu7IeZ
	dgK11gmoaNyDIBfPi/HUPxZGSNNAJV0POtqKFTeo03r8MHnlcmzt8UK2uvsVsxh1
	3psOvl5Km2rM9aiDc6LZg==
X-ME-Sender: <xms:EbJQagAXaxE_Tj-E82DcMfPfRBnXTYHEC_roI5earH6O2ZP63n630w>
    <xme:EbJQap_CFIfeNntd29RRmV2lvT3M8Fz7GS8OhRVBfKyKpqv60EukPYSOKIlUxXs7D
    0nXT9pbUFkEn_y49Alq9lP8c3AZKaQ8aGZtzTxTKpmdAdDeZ69m4A>
X-ME-Received: <xmr:EbJQag_Aw6urUVQyIeUduwcANv2KGkE0uCv1MHBh2hUERQiAOWIgKS-zW9yv1SVTiA8XlcnniPvsrykVoTsIQnO9TXZGavs8d293_mGMdUj_SQ>
X-ME-Proxy-Cause: dmFkZTFE+x5gr7UloLPA6jM40K7mMyQeSOsUliZzSCco3YhIdZITTbK0OfYKG1RpJPwjMT
    akLUsFRIk1w1BYc7wDLbAQP93OikdgAZu4cP0cMTooYSAFiDzGl7vFx5rruw7CCFIYSPnM
    eXarahgiRppT++omYBYoBgr6krn8ax2eWZEMV0Iu28TeZxqrTO5tEhquxvBHhhts2AVWAe
    vptB0NuA5a1v2DXnyjThVCiNTm4N1Xz9fqtSo5f4JowVx1YSEXB27kJDAVw6pma+x2ACY2
    8ssS/oc5fHpJ+cGfmh2vlmR6uP2HE4nMjh/lv4XPmXGdx2RXiWZ10rC2Hxn9ZwDbtKEeVN
    ihmPTXUPt71vTM2t3Eh4AmjkhIoWJolDIABtH3XAmijx2eks5R8J0aRFORYQM705sdGpo9
    vG6GmzM9PAOMS0Uo0kgHri2lMaHlw6REBI5/QYkEdwNk3tHzWcgZMCFZ3usFlsXJxO5fjy
    a+jCBU2jxIFgDiaSUSO5xKZh4kKgI2CdDYXFgqfmXdh7QuBgF5rMzZkExsjyMDQmWrH/pQ
    OrfSrryvduZ+IJ2woqy2pqDpFU4IuAy62N3lC/JrMuo5+sASXcc1wHXB/Gnfw2UbMOmZqZ
    DO+c78d4bAvgr0OxqbPVIsA2hVHZHYl0IV2T/6sVvsMPKChmlM70mbVm/KfA
X-ME-Proxy: <xmx:EbJQagfEhPkCMWH3nEreGvzqk8q6iEiFUUyX5cwQUP1Np5oME3gwUg>
    <xmx:EbJQapE8e7gBA5HOYKV3uzMWmEDmNmXx7mYBy8tH6PR2CyNtVewB5A>
    <xmx:EbJQaueQIOMXn34SJgculhKhpgLdDCI64hU2csqa4KSRmw--vg-ZvQ>
    <xmx:EbJQajFG1EuBZQAablL4WdglHbEXIPPPckld4lDpqH56yqyHKgwuoA>
    <xmx:EbJQap9J1fVP5wpSWCcJqeSn2cWRX76D-KYgZaR00qucbx4L981eCwMN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 04:49:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ce4f0bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 08:49:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jul 2026 10:48:58 +0200
Subject: [PATCH v2 6/8] pack-bitmap: introduce function to open bitmap for
 a single source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-pks-odb-for-each-object-filter-v2-6-3710a9cc165a@pks.im>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
In-Reply-To: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The function `prepare_bitmap_git()` opens the first bitmap it can find
in any of the object sources connected to the repository. In a
subsequent commit, the "packed" object database backend will learn to
use bitmaps to answer object filters when enumerating objects. That
backend operates on a single object source though, so using a bitmap
that potentially belongs to a different source would be wrong:

  - The source would yield objects that are not part of the source
    itself.

  - The object source info would be attributed to the wrong source.

  - With multiple sources, each source would enumerate the same bitmap
    another time.

Introduce a new function `prepare_source_bitmap_git()` that only opens
bitmaps belonging to the given object source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c | 12 ++++++++++++
 pack-bitmap.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 72c8ae3228..09ba15d26b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -753,6 +753,18 @@ struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
 	return NULL;
 }
 
+struct bitmap_index *prepare_bitmap_git_for_source(struct odb_source_packed *source)
+{
+	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
+
+	if (!open_bitmap_for_source(source, bitmap_git) &&
+	    !load_bitmap(source->base.odb->repo, bitmap_git, 0))
+		return bitmap_git;
+
+	free_bitmap_index(bitmap_git);
+	return NULL;
+}
+
 int bitmap_index_contains_pack(struct bitmap_index *bitmap, struct packed_git *pack)
 {
 	for (; bitmap; bitmap = bitmap->base) {
diff --git a/pack-bitmap.h b/pack-bitmap.h
index ae8dc491ac..9f20fb6e56 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -9,6 +9,7 @@
 #include "string-list.h"
 
 struct commit;
+struct odb_source_packed;
 struct repository;
 struct rev_info;
 
@@ -68,6 +69,7 @@ struct bitmapped_pack {
 
 struct bitmap_index *prepare_bitmap_git(struct repository *r);
 struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx);
+struct bitmap_index *prepare_bitmap_git_for_source(struct odb_source_packed *source);
 
 /*
  * Given a bitmap index, determine whether it contains the pack either directly

-- 
2.55.0.229.g6434b31f56.dirty

