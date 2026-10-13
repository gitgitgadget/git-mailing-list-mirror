Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B937B02D
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877014; cv=none; b=G97ykgsiE1dphKKVIteCpABSlezcjgtKFWE30dUczi1kEbAvTjvos5sEoafn9j4+/34ZQcnjiyiWuc5N6KI4HmPx/W2MYXvwplOiJfCji0PovfRiL32XWcgEb3MPPr1bW9r24DzBQcwKYFudS0r1zJwg1KhRCmg90iFThFdbEKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877014; c=relaxed/simple;
	bh=cpLqzlKZ7aif3q411cPhk82D0UQPQwvrdUtlR2n39uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iGdE8pQPOBWWMmJCv+z6U72j4fUR/lCOE0fNbfQwYnRGpg/AlSq05OAeaMHlW/mCTEi2WtPnnUt0HnzDFZAVWVCu+RgZhA1Ni7zrTwUQZ4dQ0rTY8hIhFzNFpBxbKd9bBZ3D4Wik2axu71zf6XcMeqlazurkBkPQ2QDaZ31ZmsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dv668y8i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sYyk6TqX; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dv668y8i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sYyk6TqX"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 00E68EC039A
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 03:36:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 03:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791877011;
	 x=1791963411; bh=omOqjPjs2XiAsDziuBoSoU1YMoxMXomynGcRT/u46/0=; b=
	dv668y8i65weMEsnoxb2BobGeRs7n0skU2moNhHDIhRfbqPvQ0YDM4ZTBBB8O0mG
	hiqk6/WM/TJ8t8mrE25u+ty3Ty2p9hh+m/FPRfw5AYtARt+dordgrPN4IfK89HyG
	nYDf4yfgHu+1Swf14dn5dDFGR7MkH/f56T89fj2uhRGZPWAb24EF397arhQczYfN
	OJ4noaIVtTg+/UEbpy/mYFtdZpCOpexCnzM4a6FNxvS6X5KDBUgyABNRAxoVv3yy
	tUELvLTJ/w/z/YoLWce+VxhdpgS8ehJCGEbD6Bnm2gPbI32Vu37Ke/PKspN5kI2p
	R5i77f77CnQxMZwz+oRexw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791877011; x=
	1791963411; bh=omOqjPjs2XiAsDziuBoSoU1YMoxMXomynGcRT/u46/0=; b=s
	Yyk6TqXHyJUR+AnB2CuuwC8iKrDaSIlvOfLJjLYpJy4eqoaAWa6wha8Pm6jxKkjd
	KBKMEXrwKDM5zBdUlTjYiszzEo1VWbnWCZXbLt8CflqtInPMq5L3cZSZsYh1SHtw
	pRPpgYzkMXLuC9QUTh0qchDORtzJ932qYFFbNxmncMCvhEeoW3uYK5dhlgXM0E0y
	EB2PRXJkt+tLpzto0YmIqZHDtldNukt+gE3ZDOQW2t3/tKPYT50nuMumEeB8tfcu
	g/FfHuYDRQcLKx9+zUEY3dJ0UAfV1FaD/yyMjQmTb/EWBfp4P2ILnIWjjKF9IrGr
	jbLhPx6doGWVgUxN9R1Cw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791877011; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:STeWMazablIEkq+rCtckkqpU7RnER7//sxiWizL7qS71ELD
	ca1aCsA90+O1pQity0evZy+T31/+AZukb3f5gb7QngFTsf5hBeQX57ppwznsNZTz
	QO6kknZHSELZA6KYM36uy6cDbGRx3fjB5lYcOw4Kni/BShVFJNVSdWdv4RceXyyg
	lqrwKz/YjFWU6JOtkLi7glwnnCKE8GNRzhMu/QJ0y6jgAwN3tQXq8kWoLMrOnZL2
	abHpbNAFwM3pO4DexRQAsLCoB95m6ggRUufVp1F5yN6q8l1nW85S3zWMV9VinJYj
	sxc8pD9QqHGGl7yrfQVXt9M+mx5kfcvM3VJP3lw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4ixn3zNdfHsweVabOG3S/xH4wi+vdL1N9PR+shMBAIc=:cpLqzlKZ7aif3q411cPhk82D0UQPQwvrdUtlR2n39uk=;
X-ME-Sender: <xms:k9_Nat1u4tNsTeXQMu2SXH_Z0OCJlaJ-qq5aw-twvYQkyDsjdfOyGQ>
    <xme:k9_Nari5kTKhLnDw7YmyUIW4bjTCMGVP6Un4bYuLRwO9yIS92XhK53huRhyuX8yNe
    XenO2EdYmVr4e8rAQyfWMKD-SUwO_5ihyCUqgkHJj7aSM1HcfoMnpg>
X-ME-Received: <xmr:k9_NarRrBW-LDYIpNp0Xgpi7tleGY0rBz6VkvDEcsA3BFIj07eiqBA>
X-ME-Proxy-Cause: dmFkZTEFUVtx0m1gVgvNwfak4FvGqNwTOGPAovQRfkApREj2T7mxel/rrbDAojqhTaTULx
    av4CfVjP0KE1DOqoFDpaKjw8rpFImExzn183toIDOGLzFoICAzeDh7WoadDfFSos4NwGeq
    AVQGNMhic9Efyki9sto/FeW5OnRJESUaCCtb1BKIpS32JxZfRcJtch0K1zvGmmVaBbq56U
    gb1tLWfysaH/3Y2AgzcjOtJtBO+J/y8R3GpcKKeecMWvbAEV1gp3TL0CNpZgq2MlEs0/6Q
    r0IEitoKCMe9DwPsTW1OjN7IR/VgLutSFNc2wIrT7oWnh5s6MahxoSojtzP4nQ46RZLIkp
    Q6jYY1OS4TdWFr+YRHdv+LHlp7ud1dTqGNLZG4I4wgxHzbIdiGKts6f0PuBKrWx19KIpe8
    3EtvSwrNHiEoDv5egFxm0wNn06kTBrTD+ZwHxOaeW35J89EWAAZJvyD3/MDAkXq7Okiphs
    Z2CVF3UjUJnQzQ2uGt+1IPtO8Es9qNOnvT7nFecMJ8qi144/mf5zJ85h+jJdUq/PGkfAF3
    oOYXYBp11X6pVODAxvSfBjHtnlJvGDf12QojS9CnTNJiCv3kzLb/24PjYeVp8UZB4KeHTY
    6QhthfI2qTieXWOiRhNLS+38SnvJ3htqzKPutizmlh7VBa3UCbAs58UeJ6UQ
X-ME-Proxy: <xmx:k9_NakgXzW47WqLA7i_pp0a8WxzMe_E_z3N6EIY3gQ0RqZqHEi0IXQ>
    <xmx:k9_Naj4V_8AoA0kJQVRGB_JXpUhXF8GoS5oC_j-eZVoNe10gX3Gp9g>
    <xmx:k9_NapBAa71YquVELtKi9TRw3Qbs3HQzGhuCVkE3Ir2C3NZwL0_37g>
    <xmx:k9_NaibnPtXzlFEXecndmi7LromCOoG3e2_uemOkz_wJEHKF39_ccQ>
    <xmx:k9_NaszDZGC8v0I12SaORofxmRz6ZYvnP2Hvs1xMFohSbBTmXfbDM03Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 03:36:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 831d5f9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Oct 2026 07:36:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 13 Oct 2026 09:36:28 +0200
Subject: [PATCH 4/5] odb: remove read loop for found objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-pks-odb-files-alternates-cleanups-v1-4-b7030ff2b26f@pks.im>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
In-Reply-To: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>
X-Mailer: b4 0.15.2

Before moving alternates into the "files" backend we had to handle
alternates in `do_oid_object_info_extended()`. This made the retry logic
somewhat complex, as we had to juggle reloading of the sources, the
second read and fetching missing objects. And to handle the potential
retries we loop around that logic multiple times.

Nowadays though, the reload and retry logic are located in the "files"
backend itself. Consequently, using a loop is a bit on the heavy side
and makes the code harder to reason about.

Simplify the logic by removing the loop. Instead, we explicitly re-read
exactly once after having fetched objects from a promisor remote.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/odb.c b/odb.c
index 69a4c203bc..095183aec0 100644
--- a/odb.c
+++ b/odb.c
@@ -265,7 +265,6 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 	struct strbuf corrupt_err = STRBUF_INIT;
 	const struct object_id *real = oid;
 	enum odb_read_status ret;
-	int already_retried = 0;
 	bool corrupt = false;
 
 	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
@@ -277,38 +276,39 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 	if (!odb_source_read_object_info(odb->inmemory_objects, oid, oi, flags, NULL))
 		return 0;
 
-	while (1) {
+	ret = odb_source_read_object_info(odb->source, real, oi, flags,
+					  &corrupt_err);
+	if (!ret)
+		goto out;
+	if (ret != ODB_READ_NOT_FOUND)
+		corrupt = true;
+
+	/* Try to fetch the missing object from a promisor remote. */
+	if (odb->repo->fetch_if_missing && repo_has_promisor_remote(odb->repo) &&
+	    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
+		promisor_remote_get_direct(odb->repo, real, 1);
+
 		ret = odb_source_read_object_info(odb->source, real, oi, flags,
 						  corrupt_err.len ? NULL : &corrupt_err);
 		if (!ret)
 			goto out;
 		if (ret != ODB_READ_NOT_FOUND)
 			corrupt = true;
+	}
 
-		/* Check if it is a missing object */
-		if (odb->repo->fetch_if_missing && repo_has_promisor_remote(odb->repo) &&
-		    !already_retried &&
-		    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
-			promisor_remote_get_direct(odb->repo, real, 1);
-			already_retried = 1;
-			continue;
-		}
-
-		if (flags & OBJECT_INFO_DIE_IF_CORRUPT) {
-			if ((flags & OBJECT_INFO_LOOKUP_REPLACE) && !oideq(real, oid))
-				die(_("replacement %s not found for %s"),
-				    oid_to_hex(real), oid_to_hex(oid));
-			if (corrupt) {
-				if (corrupt_err.len)
-					die("%s", corrupt_err.buf);
-				die(_("object %s is corrupt"), oid_to_hex(real));
-			}
+	if (flags & OBJECT_INFO_DIE_IF_CORRUPT) {
+		if ((flags & OBJECT_INFO_LOOKUP_REPLACE) && !oideq(real, oid))
+			die(_("replacement %s not found for %s"),
+			    oid_to_hex(real), oid_to_hex(oid));
+		if (corrupt) {
+			if (corrupt_err.len)
+				die("%s", corrupt_err.buf);
+			die(_("object %s is corrupt"), oid_to_hex(real));
 		}
-
-		ret = corrupt ? ODB_READ_ERROR : ODB_READ_NOT_FOUND;
-		goto out;
 	}
 
+	ret = corrupt ? ODB_READ_ERROR : ODB_READ_NOT_FOUND;
+
 out:
 	strbuf_release(&corrupt_err);
 	return ret;

-- 
2.56.0.212.g129ede20d9.dirty

