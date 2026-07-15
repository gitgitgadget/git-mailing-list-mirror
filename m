Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249A03749F9
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096576; cv=none; b=Rcm/VPwBp3R66Wzw9wX25vO0vIDYAL744YSRRWdb+6jOOthvz5mjmBDh4sBMrx6ulWXonqetbPV1hYoP320B2uK8/KiOSNvrhzS9cUUjnEWAKd9xBSo+RXRtXuKmMItuzOO0ltcCnXpIIBCi7cHetONyPfmxkPTSAvB0uXFdDkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096576; c=relaxed/simple;
	bh=yIX7Nh5yqwyFJfBYbsyusdohBvkVrntji7/cJrtTPjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PnYgBd3yhUiHXTJoEpo89IqkgVxS2MSMHDTTPgTWaMT+9iT5yKcNZPYCVP6Y08cc/E8EhzWqQegSiFTgS1wp3tTcpW4fCnA02Q4WTGmNX0bfIRjQ1yZeqkEAkB13bXpJGEXSyma3zJuxInLeZINpvu8LSZsKIxe86Rxt1GxJKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lZAfFB0Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T0qHqaY/; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lZAfFB0Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T0qHqaY/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8B52C7A0144;
	Wed, 15 Jul 2026 02:22:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jul 2026 02:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784096574;
	 x=1784182974; bh=3mAmiJzGW8KF7qayVGCj/Rz1zqi6cvs4g54m3kzA7t8=; b=
	lZAfFB0ZaqFpmfmcBw5xS5gx4wN9xPe3nW7dCpqcpIcMl4lsVD4TGFQkWN/iGP3f
	0X3zHJ2o0UzPndlFgJ276HTm2rGl7jO4oOUsartu02oYEnNQ1l/HNkC/KbMZiU4u
	avUX6HVNfC/JALti9rvphlyVD409fqXpiAez2j1ow/eNZ29JjFvtMd1vS4ywRC68
	sTdBv4mqBQmVhIAeB5SfP1xfoLC7t6isvnHcBp+SsdM/0Mh4pX1I6VNHxn1k1LZg
	OhV1NPPCWX2avHDfCvPAa9IGQkyAAJXAwJeIa8xcxXzaDhCwpFHgf2G8ZmdmFio4
	MXs0VT8e0E42Xzj191s5+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784096574; x=
	1784182974; bh=3mAmiJzGW8KF7qayVGCj/Rz1zqi6cvs4g54m3kzA7t8=; b=T
	0qHqaY/V5slvMEfsR/bebtqznQWnyMGSsS6G1NuxAMYBx0ayXtUacK8twzRw8rYb
	zhVGqgodt0qd+PCxyZgd0ORRwipf0wCibGpqWqcDy2Zrymm5UOpFuiMM7p5u0ia9
	G0W+T2JeoSjs/E3Eo8kFu3J5jJvedbAuSAa3+kMnAPMSHEjB+nSPYFtG80oJuO8S
	dOuwrEtBRs1997jmutR4xzbOZNac0eYLdh19e1JUSxgCyeF0mu1r/WdiC0b22umM
	YV9i4/zJWbCzdOHyUTJTvRGXGUPSMXu/6lJUZIjx5c9LKKVE4sDsfQRXIDzxpF02
	RVxWb/hYJxA4rzyhTLngg==
X-ME-Sender: <xms:PidXalKooSZlePkD4yJPf_3k4nman2fvGMH-hcA7tcZAPqcmoYaUmQ>
    <xme:PidXak2YF-8SHAESpCzsiZt_GdZaGijdmHzPjntxP6J4yD90nB1GI7BDVejzTCKXq
    WmbEvMpQ5WdmDv7I-t1ak4oSiQ_8-yjIpPSyaNuHt2kYY36mR5uPbQ>
X-ME-Received: <xmr:PidXanhhoHUHAcVswLCwwkoDtq3EnxBxf3gvs6jzlU4okP1wcvvnkZQ-49eqftdM-_i_LdUficOemOQbrERynzY0pLgYCSRSjagl2BWBB2k>
X-ME-Proxy-Cause: dmFkZTEwhg+nFrnjE7PeeHPsViPYWgRSIAER5edtATL9rD4GjIVofjsumxHitYZGdIbBvt
    J0ua5kw7xclyk8xrEaMCpEXjc0UOe9ujgssx19SA7DZAp5T5NYVev6VGARcPP+bQRfJX1y
    R/0ezDlM/lt/oWCwXZ3S3H8mZXUXZ5ixtTY7UfI/vfYtni7US5zJazpq1j2iYCRcMONN/q
    1E6sl59ghZDBoIy2Yw7TVqJGmqA2FVxrJp8p21xYqYfn/nqLuzabUSmymSnnrIotVXGJcu
    kQqsnDRJB0mcCtH8a+YBjR0hX5RYLFdPQsUq+nJy/3RGG2ZgYKM8diJ/T4EbQoLbAZllg8
    ZVGp0WrqJYn1n4OcYlNsNT1YQgY1W+ezZgj6TC0s9yTTm5GveqNKW69/Mtc/ESdD5MY8YJ
    BSnAW1LEJfQaD5FM5MGfG6uTp5QIsO1erLU45DCUS+zwT0edLGNOHgC/VkxgIEJ7k+jGpG
    m+dJHiQ2zR+5L4vZ08pUY33wGMRS1MD7mmjT3qrp6JTWb22er9Lb5eTeJkLaHeMEoIGLEr
    7cLN7UCHPMe42veNPLUtfs0zJP+qKGpO/XkrWA74n/fEquMzqAMsFHM/C4JIKnuyX4vpv7
    AYKxeUrAI8mgURxuODGstGEKsMmMyp9KeNLPkDQoIv7fnJ6/G/2694h4gw+A
X-ME-Proxy: <xmx:PidXatW_aPsepXYWAnibJtY-0iU5Fx4RnBGsTNpDwH66iBROjJqTog>
    <xmx:PidXauXaxBzgrBFlAVt7B_ZXRvQETXOPl4Bd71o8TODxRIw4QA9YrA>
    <xmx:PidXalgQxwxtFRZsAyp3OBP1XEoWzjmcNEZpnkq9TyzZ8LpJyKU8aw>
    <xmx:PidXahZ8mbhv968sRCSv_uLUChyAs_s1UJfLJlFrpDEzt3PJ5nF60g>
    <xmx:PidXanfU9AuVR3xmhte3M0Th208jAk2JOrMJXkZHDdg6cCr6_o4uxn0P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:22:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4d8167cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:22:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Jul 2026 08:22:36 +0200
Subject: [PATCH v4 6/9] pack-bitmap: drop `_1` suffix from functions that
 open bitmaps
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-pks-odb-for-each-object-filter-v4-6-616d7adf7fb7@pks.im>
References: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
In-Reply-To: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

In the preceding commit we've refactored how we open bitmaps. As part of
the refactoring we have consolidated `open_pack_bitmap()` as well as
`open_midx_bitmap()` into `open_bitmap_for_source()`. Consequently, we
only have their `open_pack_bitmap_1()` and `open_midx_bitmap_1()`
variants left over, where the `_1` suffix doesn't really make much sense
anymore.

Drop the suffix.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index e32795a595..72c8ae3228 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -460,8 +460,8 @@ char *pack_bitmap_filename(struct packed_git *p)
 	return xstrfmt("%.*s.bitmap", (int)len, p->pack_name);
 }
 
-static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
-			      struct multi_pack_index *midx)
+static int open_midx_bitmap(struct bitmap_index *bitmap_git,
+			    struct multi_pack_index *midx)
 {
 	struct stat st;
 	char *bitmap_name = midx_bitmap_filename(midx);
@@ -539,7 +539,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	return -1;
 }
 
-static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git *packfile)
+static int open_pack_bitmap(struct bitmap_index *bitmap_git, struct packed_git *packfile)
 {
 	int fd;
 	struct stat st;
@@ -603,7 +603,7 @@ static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_
 
 		/*
 		 * The multi-pack-index's .rev file is already loaded via
-		 * open_pack_bitmap_1().
+		 * open_pack_bitmap().
 		 *
 		 * But we still need to open the individual pack .rev files,
 		 * since we will need to make use of them in pack-objects.
@@ -687,7 +687,7 @@ static int open_bitmap_for_source(struct odb_source_packed *source,
 	struct packfile_list_entry *e;
 	bool found = false;
 
-	if (midx && !open_midx_bitmap_1(bitmap_git, midx))
+	if (midx && !open_midx_bitmap(bitmap_git, midx))
 		found = true;
 
 	for (e = packfile_store_get_packs(source); e; e = e->next) {
@@ -698,7 +698,7 @@ static int open_bitmap_for_source(struct odb_source_packed *source,
 		if (found && !trace2_is_enabled())
 			break;
 
-		if (!open_pack_bitmap_1(bitmap_git, e->pack))
+		if (!open_pack_bitmap(bitmap_git, e->pack))
 			found = true;
 	}
 
@@ -746,7 +746,7 @@ struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
 {
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
-	if (!open_midx_bitmap_1(bitmap_git, midx))
+	if (!open_midx_bitmap(bitmap_git, midx))
 		return bitmap_git;
 
 	free_bitmap_index(bitmap_git);

-- 
2.55.0.313.g8d093f411d.dirty

