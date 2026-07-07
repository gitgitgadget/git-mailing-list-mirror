Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0B941DEE8
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438402; cv=none; b=JdkjV7BSa+H1IrszPTDSivC0Ayrs45xltsrcehUycYghh4Z3hr4KGsAWvkPLTK8bdODfnhS/ScWD2QpwF6aQ4Dru9Hb0zFOcbibOzxD/Hd7N+HBvEVv6oZWZj3eJQYIy34l37vJe0/gVXXC0g8om+9Gc2rfFH5ZD3OYoqGJjt/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438402; c=relaxed/simple;
	bh=fRTyiBvkN4pFsV9RDMlxRjNKmDhwQH056w2BcjCBUbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UR4syoUcASDUIvyBbu7+I0Hk3Mhu6oEHmPrDyS05tgmm3JhhE1ekqHJratBbWY7rcmX+NaszXtFcTt7Q3KL3aweRlpJrg1g3tuOj4Ra/pUSDqxTCScznpedelK3kFFr8EhDtBV8uAMQk6tKe8Ug1p6Yg94aW8iyajw6z/WHchvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HpdE82HL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ICNFPlrL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HpdE82HL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ICNFPlrL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A40B31400108
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 11:33:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 07 Jul 2026 11:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783438400;
	 x=1783524800; bh=BTTFWYyL3IfL2szTU3IN+g0uBiyUbs3KXYTMim+Z3jo=; b=
	HpdE82HLIfUUZZWzjmOHr90Kr8GdFPaYMFrXEDR/7/C4EDMiClajwODeYPLy2UTh
	7L9IFGYBfGP/kBnCRIjDOwAwbNIkwK6tO5lqRqJPKiitm9SGXclC421Y9gtgDGth
	xCNE1NmBlYlVEj7d/FizFYIbfTsaOP9xPLW83F676XZz1abjk5t2u7TT9mzJtXOW
	1/UnrkxEwhT/yP0z2wfySYhK2LIy0lxtU078n3lGz/N+FVNUmPNXfvFQ1eH6cHxI
	ZOfsvLKEc3s+AofEIGHyVkQjXEYscdD+ooYN1slQKTN7P5IKJy38F8qm68m0TmMz
	Da/T2Kg8oTxdUP3UeOVuoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783438400; x=
	1783524800; bh=BTTFWYyL3IfL2szTU3IN+g0uBiyUbs3KXYTMim+Z3jo=; b=I
	CNFPlrLg5DyjoSLYHF4D7LfQ+nEo+bJbLrcz9LEJ4JYgSvgmECnb6pbmkrIM4g5Q
	RLpERv7oDcrmjew1g6z0AMNgp/KGZNwE5RH9RH3/nDGe4uzCiPjvRAL6zcbV1Ukf
	jprsSc47FRVtr54OP7z5NcFpVK0usIoVhh0PiCY+SlKi654S7Pgz6AEIRn3pCwiD
	QFYcZq7JBOnc0MseG4XZB8lzwwQgQKpcAXBDradAmFbgflda2nNIaMuPZJssA5M4
	oP4WXWNX2o9wP8emdOzvSnTKwXi4QzXlywB34eR6a56RJgaf2z+ou2xbgQ+rVNJT
	Fo7ExhQ432BnHZkeQQqgg==
X-ME-Sender: <xms:QBxNar0L8b4ISdAMAhRVipMaFxHscK3kECBDqMwYuKchoUA8wpmULA>
    <xme:QBxNahDiCTyql0ksogx8CeeEik2gpVenKQSedE1EVJTWdgNsyddNfzgLx2li1FtmL
    opp4sFvIVhLYDkm6W5ZvQRzeJSW9iPikkvXcRND7LRyHvNK5HiA>
X-ME-Received: <xmr:QBxNahgMMjTdp119hVk0Gatm2jH4uwcJJTXqM_3B2_wWxR0v-V66kpXaO82QlODfdJ9RTdblXI2LKit54b3IXvEE_knzxbFzRgdVXRb0Hg>
X-ME-Proxy-Cause: dmFkZTEJsHBfpO0PYEe5AorOfHcazVp/tBbkPBeEyBKukAxlTkshoZ2/gbuXJescdgLEDk
    2G/3VKtvJlc5njlYrPCxkg9j00cHK7EbceH5LxXeH6PWEH2F+oepzAb9SewsjRo/KIW0lU
    1lQE5NNhIb7f+4g+C5KCZPv4MqEkNsifUe5QUQNQKxPxqlLS2wxm0+oRvJw1AQX0T0+0UM
    M9QSGRn0kaVEjf9V7cMY2jYCFqjaWroOsmMwIqvkSpUhAyQDxnLPwdCWG3jz/2YPCd808h
    PkY/4hDSR4JLrxsPxxXC41eGPaToRv5DPX2LX50SXBrynI5VER33qWb84HYOTOnZBOy4BJ
    pcw1aUyQu0uR/csOnpJ4Y/qBoFO8MkheJCYT9FPXkDmD1n/r/OTiukJvJo1IOHOWKTrPRU
    VP9fM3tFXz4R5jfTjr4Pt/j4/iuJvai8vth4NZlSn7cG/wYY1dlv5afmw9nlxAPIxL+Rst
    cph7f7ua5+XxDY3RCXOPdgjyssmbcG516OxYJyvfiTU0J0ASZVcX2851SkDQtT7x1V7PKC
    PWcdwdhXuWGoQgeJ5gbkKA1PDxjaGjjT2L/ffvt9NIxOyqKL0RdHxTdat7T/hal+x7Qz+l
    LbqLW2y3b8zsAGtpdl+CFalvr4pq5SoyG5YXPL2U9gysHExWKoMfch5zkSMg
X-ME-Proxy: <xmx:QBxNal83wo5jWUf59kcT7Xgfr2WuUsrlGwaHeX2LJCCgP8eFifkYOA>
    <xmx:QBxNat_iKVWV8Zh1VfWUxQJxPka2vuveT2tX7OpaENdvLpjMWCkQ7A>
    <xmx:QBxNauDf6C1os_AYo48hOiOrs-ZBRfwX9vkZyuVr3Tm_YbWyNfv1CA>
    <xmx:QBxNatybyXaAkjrypFPhkeb_Y8Wu6KVV_AcQHN4HWXFc9WN-Qds7wA>
    <xmx:QBxNapEcv9y1538OQwaUoXBlnkS0X7wKJSHXNiXtKUjjyG85R7eYtJMy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Jul 2026 11:33:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97ca5515 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Jul 2026 15:33:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 17:32:42 +0200
Subject: [PATCH 10/11] builtin/gc: fix signedness issues in ODB-related
 functionality
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-b4-pks-odb-optimize-v1-10-aae607667be4@pks.im>
References: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
In-Reply-To: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.55.0.141.g00534a21ce.dirty

