Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596A93612F1
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921965; cv=none; b=XltJgjLiIT6TB0tlonWQMqDhoTCGno5aEg1mFziBFqe37spZXwCq708K/TUr7GOk2xucXT1D2eRHTGs4uLEPwSP5d50sEKOWhVthRzsKxW9iEZtn7bSbZl2YbcC/t3YfHseE5woNgkJ3tEAgJ+T8RrkaT5tUF0Ug2qPY5JX3K14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921965; c=relaxed/simple;
	bh=anoIM/CX8LRepGM09wpTQBo2unKzQfc1O68AJe1Pin4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hepC2f86zxxgrxaxEInPpfT0TzBHHGUxNlfojHnUq6Tnl6Jv66nmE+GcMhApuDhRdewQsnNgiq5ptXUwDfEQR1r4Q33ZA9Y/y6cgUemeav138+IQodf6ksSn5WRZQ9EbpE0J6mBGKRCqQGaee7SIj09rhUwH1iMFpd8U6uS57r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CEZSazdC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SW9UfNuY; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CEZSazdC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SW9UfNuY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1DA221400060;
	Mon, 13 Jul 2026 01:52:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 01:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783921963;
	 x=1784008363; bh=0upQ6f1SozuzQe3/1QU2Mu+VF8XK135swik6zJnvAkU=; b=
	CEZSazdC1y+VeRiCTzwNm7LZXFpg4WD/hJ7NjdVMnt2gT/vU18y0BhWyQMIdkFkR
	qA4JHvoQIrjh97W3kmfoWGvDrUgCbyzKGYEp0i+6M63fPrpa8LT2tGqSqjTvcH+C
	2pxzZktRgDNbee6M+rzv1iM45dM84fJQv3xRFpIhUby6jh932J0QfxRirZcCxWsD
	Frw1nKnV+oLq+YW6lKrMrReC5OfgNQI3dasi31Hajg/Kwk6tzycdi0adKyKJCNWl
	PZtxT5eYqzi9tuEtbYx++qbptlTYuUHAWtbtvwQN1d02YXnXmTrF9ZjCG/AH3S4+
	i48p9O+1JmsmVVMH3BMY6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783921963; x=
	1784008363; bh=0upQ6f1SozuzQe3/1QU2Mu+VF8XK135swik6zJnvAkU=; b=S
	W9UfNuYYgNbtbOEY6CucY7ByZGSu0cGFJkvc4Z5nXG/zCje+Bx68Eqn/3qLpBu1Z
	NQgRpXDGmhn/PlFRJK77pO0o/R7FN3O36ADgECyJvwMQakHydMYPmPtUZalO/1Pl
	fe/onhPccClM1XgtDZmVrpgZry6XN8hZZy/KEOayftN6szjSwQemGEpJYlehdnPF
	lT4ZJfLCVDTZ10lGW1QyC5IGmULGadR7T83ta/W8DGkLwCtGy5Rbcgo0OMItvBXr
	tZQtCmU9mDrFlwQPZVT8r+9Z9XMQGXtpQDyJ9pDxreP7D5mfKRgiNsqpFUyT0J7e
	u5tfhPJGB/9d9R2adtzVA==
X-ME-Sender: <xms:K31Uao0YkJj_pSybK0xJ_5XA9jB0fzZiKvK210uak6bkTTMHmDQSzA>
    <xme:K31UapHB-CtEVxLs9iGwWbZboJ3ksgKBgklOKpToA0cN-Tdj-pKsS1ewE6XTWP5uP
    ZnELy7wYrOunGG-yHjIy11zcyyONv808_O3LFikgh8Y3P81BKMy5Gw>
X-ME-Received: <xmr:K31Uauimx5rJ72BfHTiZNnjOOXKL-_AqtS93VUvr1WGXW6F3JIWdSIiFmbxJtMtFu_ra2cLAQ8EWBtR6HkH5s7fKbEmuGJq-HCsbIBtQ>
X-ME-Proxy-Cause: dmFkZTEtKwvvvxZTQbuKna4enMGhIsikgk1L9mZGr2ARrEkq3kegN2LUSWU8J/dlCRyqB3
    Sv6r5AabeG/j6jGoa9l3oL3soetOf155xPMOnqDe7ReoDnznfRbFjajX1JsguenDPjC2NS
    zkBCQKuhTOgv6P/nByjkj4exDURjDa62JBTLoFRn830fjdR9ZmOxY9F+hDoCZjVCnaFSIR
    MAfqpTmdo+ejD2EdbN+Q+hkWVnEajEuOLCXPCLmNbcYTy4yjjgsnM/hA7fG2olPFDSG4Z3
    +yb3c7ga+A4VHzmeaLhVnTIoZPV8ZMqJj1i8YNx+6x03h9MuETqr4YjG+74phZIbHqLAZK
    hMKNPUhZUcXIaBOBRHTNj1H3MmKR97BNHqcLnlt99mE23H3YvraBOADNl7h2XqPnZKnFHo
    i+9PLAJEEqUZHIujYwNEPRJEK2T58a8z3iqY+VgRIrRFBMz4QS3sBNFI+DWDsSg6e2fck6
    7iTu9Qj3roZFg6i1Gnx00+WFvitZeZg6U/t9kd0RdWjSOnDRSqJw1x4dfQSYIliMcr98bU
    spkQVpHTJ8iOzdfX1MdWx+DSx8k5QgpJzx3IiQiNRaX3bHLTDcsdwJ8tKlSI0iE5NSlCvm
    hq5awBDc2SoQmdfyGL1xCmtSSo+Brg8ePeLXWwRhHjOJjxiZFMowcPS5aVGQ
X-ME-Proxy: <xmx:K31Uas_JsHyivQXIAAaHIb-tCplJmEYiiDx3bv_1yO1IrsLtnTbLTQ>
    <xmx:K31UatpkMGM5NmTRs_oV2msN9Ou1GbAxcsvVMJ-v0s4CbTiBVUKIJQ>
    <xmx:K31Uaj-4xlgYgikbCBZtBCPnqKTvYFTyUSkAD-O84rKCiAK4GjyqZA>
    <xmx:K31UapW_za38qvQyirZrOH1OC0j2pd-pQrFqZ_tqkNPb0nrn-Ov0aw>
    <xmx:K31UarrZZkJz74HCLKagT4QjBdShYcwkV5ikby9oO5Szq-SKGsNZ9CZt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 01:52:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aab7ae4a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 05:52:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 07:52:14 +0200
Subject: [PATCH v2 11/12] builtin/gc: fix signedness issues in ODB-related
 functionality
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-pks-odb-optimize-v2-11-9c2c3ee94b38@pks.im>
References: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
In-Reply-To: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

There are a couple of signedness issues in ODB-related functionality.
These are not a problem because we disable -Wsign-compare in this file,
but once we move these functions into "odb/source-files.c" they will
result in warnings.

Fix those issues:

  - In `too_many_loose_objects()` we receive a signed limit, but compare
    it with the unsigned actual number of loose objects. This is fixed
    by bailing out immediately when the limit is smaller than or equal
    to zero, which we also do similarly in other places. The warning is
    then squelched via a cast.

  - In `find_base_packs()` we compare the signed size of the pack
    against the unsigned limit. As the pack size is always going to be a
    positive file size it's safe to cast it to an unsigned value.

  - In `odb_optimize()` we compare the unsigned `keep_pack.nr` value
    against the signed `gc_auto_pack_limit`. We only reach this code
    when `too_many_packs()` returns true-ish, and that can only happen
    when `gc_auto_pack_limit > 0`. Consequently, we can fix the warning
    by casting the limit to an unsigned value.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3207182488..8cf3781313 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -430,19 +430,21 @@ static int rerere_gc_condition(struct gc_config *cfg UNUSED)
 
 static int too_many_loose_objects(struct odb_source_files *files, int limit)
 {
-	/*
-	 * This is weird, but stems from legacy behaviour: the GC auto
-	 * threshold was always essentially interpreted as if it was rounded up
-	 * to the next multiple 256 of, so we retain this behaviour for now.
-	 */
-	int auto_threshold = DIV_ROUND_UP(limit, 256) * 256;
 	unsigned long loose_count;
 
+	if (limit <= 0)
+		return 0;
+
 	if (odb_source_count_objects(&files->loose->base, ODB_COUNT_OBJECTS_APPROXIMATE,
 				     &loose_count) < 0)
 		return 0;
 
-	return loose_count > auto_threshold;
+	/*
+	 * This is weird, but stems from legacy behaviour: the GC auto
+	 * threshold was always essentially interpreted as if it was rounded up
+	 * to the next multiple 256 of, so we retain this behaviour for now.
+	 */
+	return loose_count > (DIV_ROUND_UP(((unsigned long) limit), 256) * 256);
 }
 
 static struct packed_git *find_base_packs(struct odb_source_files *files,
@@ -456,7 +458,7 @@ static struct packed_git *find_base_packs(struct odb_source_files *files,
 		if (e->pack->is_cruft)
 			continue;
 		if (limit) {
-			if (e->pack->pack_size >= limit)
+			if ((uintmax_t) e->pack->pack_size >= limit)
 				string_list_append(packs, e->pack->pack_name);
 		} else if (!base || base->pack_size < e->pack->pack_size) {
 			base = e->pack;
@@ -946,7 +948,7 @@ static int odb_optimize(struct object_database *odb,
 
 				if (big_pack_threshold) {
 					find_base_packs(files, &keep_pack, big_pack_threshold);
-					if (keep_pack.nr >= gc_auto_pack_limit) {
+					if (keep_pack.nr >= (unsigned long) gc_auto_pack_limit) {
 						string_list_clear(&keep_pack, 0);
 						find_base_packs(files, &keep_pack, 0);
 					}

-- 
2.55.0.313.g8d093f411d.dirty

