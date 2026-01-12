Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE75346AEE
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208474; cv=none; b=pAdIBNi9hGow+GF1GB4vrmSf4f3QKWAJUQopOdZzULMKexENkaM/MZZu+RTgwXyO5ztQjWg+t2NULDSXZEQktkf+rjY3RUCbNpuKU14IqC8oKiK4PU0Tscv/tBXH45QvNESeMbZ7ZWkpRa1rKLimRuqADcVja+JWtNb47Or3l2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208474; c=relaxed/simple;
	bh=r6IVUrd1CnwNzhcdbt41LqIzX1nSnrYt8KkaNs4iz0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jPXDE0aeH/RKFbihSrtXOBI+VmKdTesJr4AH5OhKHgwprJtORQ6TgICvthNZARcQwIWUcAD/9zwQMP3MHgEoe4+j+IExuAD138si7jvIJAUntQfwOEz5fukHMPkt5G+LuJhtNceYlgGfNRPikPlLuch4GD51mbFS2H7zvcuPGdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CkyA1E4P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KIP6a6Bs; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CkyA1E4P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KIP6a6Bs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ABC797A0024;
	Mon, 12 Jan 2026 04:01:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 12 Jan 2026 04:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208469;
	 x=1768294869; bh=ofNpzyUQQIs8E+vefKOXcQRyeXr3hTbVnqgZpZQBI+w=; b=
	CkyA1E4PJqjf7OwO6bhNDOpm1MyEOUo8AVv++pYKS/GU7RgU4g3zl99x5IMtEHjr
	PWtH+53CoKQSEfhkVUgXF7AILlINyYOF9Mg8BLtzHjW+iyhM2NPHdAbHVFqU1I0i
	2OfuoYY/ycqxhYUwKOqAUpFBlMp7BP6Ni+NE1b04OV+SNU0AEXP5sCqD2mP0/cdr
	6e5tCxXEtswkFDWp5Y/oV/2eGzTmEvpdaY/XabmxcHEk7NIQO7vgyOD10zlJrK+y
	ienuBA3k2OVvhF9JRN5JZxgnyxaovH8YFTn27kHLax+dEsCjJ9zch4y03fewFjKi
	xUz2eRjOgprPNHADFG8bEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208469; x=
	1768294869; bh=ofNpzyUQQIs8E+vefKOXcQRyeXr3hTbVnqgZpZQBI+w=; b=K
	IP6a6BsDtBXgC87nx5F7Fgvbyuz6WF4H0ZnXvwcCBlVzlTuWRKMd3u4Gmy3EtiTs
	RTbPiWNSNpdJDjzyI5NZaFleIBSeoBAMBSUNQkgkHjY73FgWxEt205Nv2i5hEy0V
	27WUeYBwFccuy3nzBgcxLerYWhoIvWZckJvUwjesMKyVsfOMlZcBqXCjpReTRy1T
	6vE1kIh6vUXdKXIzzfi9hvAQh/2TDDGvW6zIX/AMtugzZUfu1jsTTjlPzP4xA7yw
	Nx2MKEe2kcJZoTM1NcMnt4SXCths64s2xLyzP+I9hMHrbrbE/q9toVPYwySJS2Ff
	fT/6urr0n0FEEzgGYLSCg==
X-ME-Sender: <xms:VbhkafRPZwGymhN5lXABFQq5lJLpngbWwSpuyj7fOgd6SKPFgZIvPg>
    <xme:VbhkaUeEM6-d-roO8VquAX1ZwxUCMzNhIKyLwjGGPS3_aPLVAnq5Z8fwFNpHwiqyJ
    M_3Vzblo9xEHicoHoYQmt9U1-e1lFPom_3lPp-l-lxtatcGJxzVxQ>
X-ME-Received: <xmr:Vbhkaep2_q0IPC9RRG2MMdg6YfWZnrRoshwio4eex0-7qR64mE--NC0oTueeNWekcTZYGMSbIn9ewlmYoApE7rmwsB5xCaXkY19O3F6VBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprghp
    lhgrthhtnhgvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:VbhkaV9N1COi4HhtSCNud2yoDpAPJBBIYh3tTl2wVSQaACWhST019w>
    <xmx:Vbhkaaca8hoZszzgTQBcXOuBwH4Uqe7u2CctZpQu95xSClF28109Mg>
    <xmx:VbhkafKBK_CuhYmW38E6iPMaDmVvGALpUJgY4tQ0HcWuhVRCud0l6g>
    <xmx:Vbhkaag2Zg4V9FF-lTP5MlnUvSjnzyQMWF-CHVF2RhR5XC9iTZgH1w>
    <xmx:VbhkaVznYud4HhLKBHvRSLXXNYiWW936F09HjfFpZmAbTrbnRs3P4Jzm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:01:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d57a4bbc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:01:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:00:45 +0100
Subject: [PATCH v5 5/7] packfile: disentangle return value of
 `packed_object_info()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-b4-pks-odb-read-object-info-improvements-v5-5-9a6124e95bf2@pks.im>
References: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>
In-Reply-To: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The `packed_object_info()` function returns the type of the packed
object. While we use an `enum object_type` to store the return value,
this type is not to be confused with the actual object type. It _may_
contain the object type, but it may just as well encode that the given
packed object is stored as a delta.

We have removed the only caller that relied on this returned object type
in the preceding commit, so let's simplify semantics and return either 0
on success or a negative error code otherwise.

This unblocks a small optimization where we can skip reading the object
type altogether.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 21 ++++++++++++---------
 packfile.h |  4 ++++
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/packfile.c b/packfile.c
index f7c33a2f77..8c6ef45a67 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1587,6 +1587,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	unsigned long size;
 	off_t curpos = obj_offset;
 	enum object_type type;
+	int ret;
 
 	/*
 	 * We always get the representation type, but only convert it to
@@ -1607,12 +1608,12 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 			off_t base_offset = get_delta_base(p, &w_curs, &tmp_pos,
 							   type, obj_offset);
 			if (!base_offset) {
-				type = OBJ_BAD;
+				ret = -1;
 				goto out;
 			}
 			*oi->sizep = get_size_from_delta(p, &w_curs, tmp_pos);
 			if (*oi->sizep == 0) {
-				type = OBJ_BAD;
+				ret = -1;
 				goto out;
 			}
 		} else {
@@ -1625,7 +1626,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		if (offset_to_pack_pos(p, obj_offset, &pos) < 0) {
 			error("could not find object at offset %"PRIuMAX" "
 			      "in pack %s", (uintmax_t)obj_offset, p->pack_name);
-			type = OBJ_BAD;
+			ret = -1;
 			goto out;
 		}
 
@@ -1639,7 +1640,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		if (oi->typep)
 			*oi->typep = ptot;
 		if (ptot < 0) {
-			type = OBJ_BAD;
+			ret = -1;
 			goto out;
 		}
 	}
@@ -1649,7 +1650,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 			if (get_delta_base_oid(p, &w_curs, curpos,
 					       oi->delta_base_oid,
 					       type, obj_offset) < 0) {
-				type = OBJ_BAD;
+				ret = -1;
 				goto out;
 			}
 		} else
@@ -1672,9 +1673,11 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		break;
 	}
 
+	ret = 0;
+
 out:
 	unuse_pack(&w_curs);
-	return type;
+	return ret;
 }
 
 static void *unpack_compressed_entry(struct packed_git *p,
@@ -2152,7 +2155,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
 				    unsigned flags UNUSED)
 {
 	struct pack_entry e;
-	int rtype;
+	int ret;
 
 	if (!find_pack_entry(store->odb->repo, oid, &e))
 		return 1;
@@ -2164,8 +2167,8 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	if (!oi)
 		return 0;
 
-	rtype = packed_object_info(store->odb->repo, e.p, e.offset, oi);
-	if (rtype < 0) {
+	ret = packed_object_info(store->odb->repo, e.p, e.offset, oi);
+	if (ret < 0) {
 		mark_bad_packed_object(e.p, oid);
 		return -1;
 	}
diff --git a/packfile.h b/packfile.h
index 59d162a3f4..d7cce582af 100644
--- a/packfile.h
+++ b/packfile.h
@@ -378,6 +378,10 @@ void release_pack_memory(size_t);
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
 
+/*
+ * Look up the object info for a specific offset in the packfile.
+ * Returns zero on success, a negative error code otherwise.
+ */
 int packed_object_info(struct repository *r,
 		       struct packed_git *pack,
 		       off_t offset, struct object_info *);

-- 
2.52.0.590.g1f87b77810.dirty

