Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA501C3318
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381479; cv=none; b=qqxfjcOgP1CXQ2mLfPKtKFe+avzLZmR1KUa/UWwk5hgfbHvJXMhB9rpX6+8ZfTLt9zvAy35hFodn9/0LfHEDoQPvXu0xf8ipHyAyfDqMEsAriM9SzE4KOThUAi1yaTxCxWpSLhOegPJKdABgrbW/jzfHgIjzEiDWkLj/6Rs02kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381479; c=relaxed/simple;
	bh=hzNHZg1bDu5aGO35XUeg9X35WCEklFPLzX4k7t+ftEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KiRK8LziKsUxc6vTABtsiP0zvHgvmV50miBxi31317zH5zC2GfyIsrjnk+HmHEv64JAYVmd+/0l3hqaLwgsD9YjrnvaKgsHNYAQfNskbLenpe1ZUiSmb9764AlvOQ2F8i+pX9xJEaIGRVyO1d/IbQ6/fXy42vBPrZ8Prm4ts/L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t6lZcXEn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P4pwIS2J; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t6lZcXEn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P4pwIS2J"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 077277A0152;
	Thu, 25 Jun 2026 05:57:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 25 Jun 2026 05:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782381476;
	 x=1782467876; bh=euRYBlkRVLLBGwTOGdFo6186jVZ8MOrtDDVXwOGYPLE=; b=
	t6lZcXEnyTuhwiq5nNkAf+vt8Yb7KMmlXtTCFTTWDG0zi+6+gAwIbg4zLSyet/nG
	ax+4/2WA4Y6tlqAKguFDtAayNnp1pHw6VIP46W+xplDXvyS2bAyOjKeDJki69QPQ
	FSJGrq5gvzek2hS3kG2SF2uzkuT0MXuY1FIFzmJxPq1V9QUSGNM5MVyWcmluiOMP
	5r52RgFuwOSo5kdSpJR6EoAyGjoczrDy2JJB4FobRhQt3xmK+ba8Uv9h3Tc26QCh
	CudvDQDihk2Hr88pZ5Q7c+4BQAjjrQCbTcc7oNSuRXkfFppw6et+uy4ZKJDyoJ+f
	jiQiWwS7+m6UW3QQytcedw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782381476; x=
	1782467876; bh=euRYBlkRVLLBGwTOGdFo6186jVZ8MOrtDDVXwOGYPLE=; b=P
	4pwIS2JQuw2sHtMjFqK/X9k/I+qr0sg3NlgwDTO07iXiQowPsy8Mq1el1lJIkNgP
	vXRb8zqWXJo5afHVcvgvgEtE0L157Db6/rQjxNB9wQcGEU8MmLTWVLxC64K1tp8I
	FvuUMAXAJOfTU8jP8ixyXC5i7qctCQ04YSzE7iJ9MXeKB5UPGfkeSTVuo3srd9+Y
	CFq3gewt+Qsvf/++ySBARah7P89Nbu7PI1jEV4UkKym1sITIYQtg9+5lWWl+8/LQ
	0nwfYZoGGcQN7t50EiXF6DbtTeE6Q49DsYASn7fJ96oFv9j1FD/0mGxxnPLiWQHQ
	gVsTw/S9Wj6ieYabZ1bnQ==
X-ME-Sender: <xms:pPs8aj8IaVXxNYj4WhHP3IOIOSqQzuGiL9DFsEKQa1AtuBoFeDutnw>
    <xme:pPs8anIUB6mjuXUQryzaH2h7s8MZzqvZjxKzu1YnjvEoDylGRvOO_kkLaZGSgOhXW
    bEhDMZ4n8sPdqcwIxfHudFzx6ZyGQs0-iQhCSdnjB0-FQdkUDaKaso>
X-ME-Received: <xmr:pPs8auYo-D1wIzCGIVlUfV9GgWO4JYDygCuymquhAYcqRyuY3bHZoNKnv4dFZW3rE-qlOGEU-L6W9Vv7EL1hBEzmP4bwc5HndVS4FrWt6A>
X-ME-Proxy-Cause: dmFkZTFlCm4oA1wczD9UOeyzznN/Dz6R6epJS0EwRilGmnsdznMtxSDSXIX2g12XzSTE4I
    8lZ8x93Ii7KAH49OU6btJDN3ONXamZrNImfsK5pmLhKYJmEJnQ16qP55qwHvfqzzj9ayqP
    xb+A4oP99a5jp9fpLTayGzTYgBp7fAzVIXpUaAHqwXxMMSAzz65UVMuzPhSbA0twpWOIsT
    M9W3uAQsQLAHp+04JqnEs7HPp0BBo6lH2VGuT8izLDCmeNjq41eGrnAIxPZivJ6Sjl/SDf
    +5ynhME/f4e+IMUmQUQ8JCwozoJuJ9M6lSd6+XIvCvb5t6MQMdQnuB+lp81XKczSkFe7NR
    u56chaL5cen3ZNiiQqBI/FyUi/MqcWJmJKUNmwrlSV137Mf2msSNZnHkJRqEjgf8Cl0ULb
    zCvGF0Ow3VgE/VpJUMr8tFES8PspI+Bj1Ead9MJN6xUHlb8BcyHZySFISKRrGKFZsboRqF
    lXOrXaHDyYH14D2uhTBqIG5/bZVrLCTtESOmCvaUPOn5dUBvacnprrUTjf1xNEDiS3L4Oq
    JSrN2p/cDNmfNeMdltc+XRahXOEZMjWHyEWnaWsUXMlou05PESMyrALEPdB9k1kc0wNSKJ
    HMwbEyJ5gSX2tMyjrBzUCF8lKHaZd2jhPrwrXh0kpcTCvT5zd/CGvAXZNMdA
X-ME-Proxy: <xmx:pPs8apKROmiR3wKxYqZ4uPZkaReWytDSqMVhDg8jf4P5Xo0z5rUM2w>
    <xmx:pPs8asCisjgpWNkv2Uh8M9ihPLGJdz0O1rnAiYZwfZhmnnGBadE7WQ>
    <xmx:pPs8aupM2TXP2fLMHl2TJYOjiHUSAdPJCCXPnL6QoYlXRnBdauqshg>
    <xmx:pPs8angFK2pwPUhE6vo3tAqND09mSqQK42bjWzxzFWyCRNWU8JndSg>
    <xmx:pPs8aqxA6LZsZC1qmF5d7jElRMKQ6FodQfiuRgvxXDBc2K7pBvzvE6GA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 05:57:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 242677d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 09:57:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Jun 2026 11:57:41 +0200
Subject: [PATCH v3 3/4] connected: split out promisor-based connectivity
 check
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-pks-connected-generic-promisor-checks-v3-3-7308f3b9dc44@pks.im>
References: <20260625-pks-connected-generic-promisor-checks-v3-0-7308f3b9dc44@pks.im>
In-Reply-To: <20260625-pks-connected-generic-promisor-checks-v3-0-7308f3b9dc44@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

When performing a connectivity check in a partial clone we try to avoid
doing the connectivity check by checking whether all new tips are part
of a promisor pack. This makes use of the fact that we don't expect full
connectivity for promised objects anyway, so it's basically fine if
those objects are not fully connected.

The logic that handles this promisor-based check is somewhat hard to
read though as it uses nested loops and gotos. Pull it out into a
standalone function, which makes it a bit easier to reason about.

We'll also further simplify the function in the next commit.

Suggested-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 connected.c | 85 ++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 34 deletions(-)

diff --git a/connected.c b/connected.c
index 7e26976832..d2b334173f 100644
--- a/connected.c
+++ b/connected.c
@@ -11,6 +11,49 @@
 #include "packfile.h"
 #include "promisor-remote.h"
 
+/*
+ * For partial clones, we don't want to have to do a regular connectivity check
+ * because we have to enumerate and exclude all promisor objects (slow), and
+ * then the connectivity check itself becomes a no-op because in a partial
+ * clone every object is a promisor object. Instead, just make sure we
+ * received, in a promisor packfile, the objects pointed to by each wanted ref.
+ *
+ * Before checking for promisor packs, be sure we have the latest pack-files
+ * loaded into memory.
+ *
+ * Returns 1 when all object IDs have been found in promisor packs, in which
+ * case we're fully connected and thus done. Returns 0 when we have found
+ * objects in non-promisor packs, in which case we'll have to fall back to the
+ * rev-list-based connectivity checks. Returns a negative error code on error.
+ */
+static int check_connected_promisor(oid_iterate_fn fn,
+				    void *cb_data,
+				    const struct object_id **oid)
+{
+	odb_reprepare(the_repository->objects);
+	do {
+		struct packed_git *p;
+
+		repo_for_each_pack(the_repository, p) {
+			if (!p->pack_promisor)
+				continue;
+			if (find_pack_entry_one(*oid, p))
+				goto promisor_pack_found;
+		}
+
+		/*
+		 * We have found an object that is not part of a promisor pack,
+		 * and thus we cannot skip the full connectivity check.
+		 */
+		return 0;
+
+promisor_pack_found:
+		;
+	} while ((*oid = fn(cb_data)) != NULL);
+
+	return 1;
+}
+
 /*
  * If we feed all the commits we want to verify to this command
  *
@@ -46,42 +89,16 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	}
 
 	if (repo_has_promisor_remote(the_repository)) {
-		/*
-		 * For partial clones, we don't want to have to do a regular
-		 * connectivity check because we have to enumerate and exclude
-		 * all promisor objects (slow), and then the connectivity check
-		 * itself becomes a no-op because in a partial clone every
-		 * object is a promisor object. Instead, just make sure we
-		 * received, in a promisor packfile, the objects pointed to by
-		 * each wanted ref.
-		 *
-		 * Before checking for promisor packs, be sure we have the
-		 * latest pack-files loaded into memory.
-		 */
-		odb_reprepare(the_repository->objects);
-		do {
-			struct packed_git *p;
-
-			repo_for_each_pack(the_repository, p) {
-				if (!p->pack_promisor)
-					continue;
-				if (find_pack_entry_one(oid, p))
-					goto promisor_pack_found;
-			}
-			/*
-			 * Fallback to rev-list with oid and the rest of the
-			 * object IDs provided by fn.
-			 */
-			goto no_promisor_pack_found;
-promisor_pack_found:
-			;
-		} while ((oid = fn(cb_data)) != NULL);
-		if (opt->err_fd)
-			close(opt->err_fd);
-		return 0;
+		err = check_connected_promisor(fn, cb_data, &oid);
+		if (err) {
+			if (opt->err_fd)
+				close(opt->err_fd);
+			if (err > 0)
+				err = 0;
+			return err;
+		}
 	}
 
-no_promisor_pack_found:
 	if (opt->shallow_file) {
 		strvec_push(&rev_list.args, "--shallow-file");
 		strvec_push(&rev_list.args, opt->shallow_file);

-- 
2.55.0.rc1.745.g43192e7977.dirty

