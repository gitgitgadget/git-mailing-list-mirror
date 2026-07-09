Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475673F12C8
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586183; cv=none; b=u7ZLPyaH5wDvYVUw3+SiJXEK9XR1sRUqIkluOFIK/2OrYGHvsmbhwe1R522UXi3V6P0I2VljBqFqNijjY6n/OhI3g0J0n06zadjmNiWLe9ADmtyGs4lxCl/be9Eo9vNItq6ZsWrnYv99VN21IpckmYIcU9tfMGw+SwYdOsnirkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586183; c=relaxed/simple;
	bh=XoFa/m7dqcBJWo/T7oxpZ9R46LVxpEkK6fssVcqQrFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YW0NCR3UR4eNCjT5Fudi0ijdifg2OTGR5beMPxwp1X7udlFS960W98CLrUX5hb50jyL0x9JcO9pqbmZu9sBmmofbvSFXQtmAetADz97Guji+du3eHAlqADQJtidj+L8xbbZx4zAbHhaGqaaZ06Y7gJx5AqQk7aX0Ux4fNRLp0N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C6wL9vU+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L28iiFwD; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C6wL9vU+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L28iiFwD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9A0A27A0097
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 04:36:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 09 Jul 2026 04:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783586181;
	 x=1783672581; bh=LCQOeLwk5LMujSn8ZaBz39H0QN7VgucDpjBTJ37UVoc=; b=
	C6wL9vU+tsdONdqh5eSgGp9RpnW9Q2/+QTnxYtmKczRPzse/SjzSDh+m2Je/8EMT
	L1xVtIGn6ziuUbTCu3z47JAVu+lBP5QOFNdvTs0iL80MKL4/KUsGqXwEgzO1Eydm
	6Fm0AIlAXLJ7oWOfGDqdnAps5HTIMCGnyRgMkrGRa2h7SKoEMeoHHWgek6qMOY2X
	YrlaOhDQqdpkEi+KWy9adw9RRCtHLA7CXN2RnTRGpEgU2DSlQRk3t0nbUjDzs05K
	6VI3c/wsmIUZ7WvtErFleyhezY9e5qAN1mfQwG7/sVJv5UmJvK11rt8rWRc890MS
	zRIo6p+LNpChqECZpQ1unQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783586181; x=
	1783672581; bh=LCQOeLwk5LMujSn8ZaBz39H0QN7VgucDpjBTJ37UVoc=; b=L
	28iiFwDAeZaXYndjaXJ4j9qJSoRMC5b5es92uMhXNDjad8cWTkk3sj4S2OPXkv8V
	Z7SHv/+EABCw9GpfiqQ6dAdFbrnLHHhOXV/b/AmHpa6t16JZoIA+gJ6AuqV82xkt
	+u3RpSSdnztkI5e+ZLAgyrtcvc/Y7JnA1G4Dyli8P+nbEZ3ehZQi1VHqqYqzCgvY
	Kx6TbmqGzsLR1o4TAdL642DsHjq18XtH9fcNqFtXL5w2uK/Lhonw/3Q7JuWu7VSz
	rr2xTQJNwTTwb9maPAllWOUxH+rJugCnEm9vS5E5EFEJiVb+7pOgex8zKpPrAhH+
	g8gixOYQD2JfFgcdkJVIw==
X-ME-Sender: <xms:hV1Pam8oeU0p5LG-f9FVKxrHHEQlDVczXVMsU20jGUoPM3EuSXDaIg>
    <xme:hV1PatoF3gUuFBnVCNSlP3R6JYe9bofzw0Le4OqdpKHl3ZtbojH0xNkpFvDVICig0
    DXVvdu5HT25JjNgYg9sR984mRVkOceGYG7Oo-vyfEgO_6PuyAMRvOE>
X-ME-Received: <xmr:hV1PahrF5OVclYTJPyFty_RKjEf_HHMTUi9YkB83Fr5lq4kcoP7TltbEGl_VScvrDSJA1LluyBaOJ-jUfCu7ygiG8qXy-qI53VSnKIo3sQ>
X-ME-Proxy-Cause: dmFkZTFJZsxlobujWJB//0c8jFk+g9m5YwHaKid7RhhsWsrb3qr5adtFPEPRJlCzgkUGfR
    JG6CIiAno2pOBhH7DklbqZu9xUQIigXIPJkGHVUTwsze8tc+lkQZfZAkaCBYX/oqRJ86J7
    +uU4XN10b7A8ePywNenvyvXtXe723ViToHyDgx8pO+ZtBQLFfkvp7tAk/ALSOx6F3Y0nzU
    0lEIwtDidzHjGzG002urpytlGc/3tZmFw+4do2Qjzd2XwrXCQedrz7EvHCoUTJqUI2OwHf
    QZQqGzTqeQWfrIDHk7fUorddTS8sPNygHDPsvsHQTJxEp1OVZSb2U0cuyATcJ2BHowFBML
    woc2Bry9I0LUxuJ4WvkR4dD0onWurNikpE1tIib4gQ6NlHxvRMXMLEd3p6YcukaqJJquGt
    wJ6VfxFem66NorRZ6dG2H2evH9E3F4czVprOesazVXesGPk7s9h8GVRwxUrwSoYpZCYTOo
    K4P/i+/NJJpTLZnaefGp9sSuyg5rM7USXqwqW7we10NGjqPvksl5Kw1QeG5MZNynIon44s
    zPjkXVddKV5H8FLBxpYPcq22DZ/SbpdPHo5Px+llxXVZ1F6267UlPBjqgp3TihAfs79odI
    CV//s5FRTfe7TYJSTgs+TOLS5N58XCSVsmabrkscK36JmS9plnH+2Tpzz5tA
X-ME-Proxy: <xmx:hV1PajnJ6hPADZ3aaDJ3i9U5nUKPAtrmVE-vlHsD18LFBYymrvJybQ>
    <xmx:hV1ParHYcfsJfdRwRTStD0Bvq8b8s6jvTvMtVSBRgDWJ96AbDaOFzQ>
    <xmx:hV1Pako2_1rd1TYy4GxRwKbvxFEbx143pIvm_vUyQxWUb_AT4Bffmg>
    <xmx:hV1Pav6ip1BK2BJKiWuDunvfaxxl5WOQKxQOVhRh2l0ziIxNhtsVoQ>
    <xmx:hV1PauvY99N3eqGRy1IS7mwd_aebMjeaPqXmwQ4Ud5nyx9LRC0Se9qRk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 9 Jul 2026 04:36:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 115f39f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 9 Jul 2026 08:36:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Jul 2026 10:35:25 +0200
Subject: [PATCH 5/7] pack-bitmap: introduce function to open bitmap for a
 single source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-pks-odb-for-each-object-filter-v1-5-82fe014b12b3@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
In-Reply-To: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 0e3e18a557..5d2af96e2f 100644
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
2.55.0.175.ge4962bd3d5.dirty

