Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5D356A3C
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773990485; cv=none; b=MWWcCi85qp0VaP0jBpZIh0AWNbUYpvmsjfwDb/eMeQkQVQ+y6zw99XstsVrJ92fADTdDON3ZcwB6WrOAW2kXwYeE5xlU232h0NUPhpg4GsOxVv+6a20Nwwbms2su+y0CtbaWqKu5LxfcVWGWTer8nG/V1J9322AOi/aSWol/OzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773990485; c=relaxed/simple;
	bh=LDgfKCKzd56XoMRcwZahActKGxDucFjNmXndLkLudQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mXlRqpMglMpy3Goi5eWUhkWMxLQ41x+OxtL2/0q8ne6xdNapq/1Tajml30iS99Ue4njLkDB2wBampy4NSG1rZX/JZB9UrdgAP5JPCWakBq+VBohXAemt8U7qbhLMaO338VcW/naZjl/1abZtVZ+Pz8wXHnKywi3EFL6F2zfaUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SUuHBbFp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RoSm9UfR; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SUuHBbFp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RoSm9UfR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7CC26EC01E4;
	Fri, 20 Mar 2026 03:08:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 03:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773990483;
	 x=1774076883; bh=BulbMiwXRbZW5ObG5YkEmb9uQ1+nseNgzzhFLIvFEtE=; b=
	SUuHBbFpq/GeVXelIfMucSjD0RN6QHg5eho8Fu3lF44DoruxW/rc0Rw0g/udPHEE
	2RlUQiZLWDvpqUt8N1Wwec7IbOLYMZb5VTTfYrygyhnjQMOBg7sGPYwYIoz99XUw
	BEoHld/g17phwnjDP+3BItLMDfy/j/H3Im2XZZCIcr4IF5TYjdvGIyxtj/Lvi7lW
	HukYzBeW/fMKH7QhbuwRiFcL3G3kqSXMUMoXdaW3XC/HyQOdKAOizlO0Br04mhhz
	pVm505FbiTP1SKRc0O0eP1pRSPo56Tb7/cUrPSuoLSMyOogqQ16XTeFLr7FfVNp0
	OHIBqP3cyp0BuUEBNkaMmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773990483; x=
	1774076883; bh=BulbMiwXRbZW5ObG5YkEmb9uQ1+nseNgzzhFLIvFEtE=; b=R
	oSm9UfRisdNvbBXmdSBCGbGqa5oHKXzehBFDFOS/meHOjlAxbxoCwHZILMLv85mY
	DrstXQhs6EYMP50TikbpOIsfuvifySuTGYqu03d0soxIWrWmDHHb2PIEGdga0UG/
	jLybPPO8vFgLSYGaR/vWNmuATcz4jyJywniaYgRIT9vfsEtmLtcb6EY/JfbZlDdm
	39TH6ZkPS5PiG95W+fBKb01f6GwgoXQcQEtZnuAcdeLm8Jk85mbYfvVcGjqO8dIp
	lYF6A4z88qifoOtJRclt41K1meB4hMIHG1axa1K4Ailggc2kYCjNWO21ylxo1Abh
	tcw2Ux/TtLt5/3Oq4TuXA==
X-ME-Sender: <xms:U_K8aawsTeSUbB5V5lJZVdOhYaO0nBnVuXk1cv2DRNUwSQqlM7e5Yg>
    <xme:U_K8aduEYJO3tr3Tmhx0oHjudMgjdwekibQz6Ofe11A9y9YyJKgMF3PqgXd9cz3bV
    EcMNC7H2iSNNKC8NDbASEUI6Qu0Zt9UXJVCbAuOFPejfVVh82S8>
X-ME-Received: <xmr:U_K8aZtb1w8TVoEQe-ngs1OcEqCRSqYphu8YhaAC4T7E_QM-CzP-zkgx2XIiM3fuBF2jcKDTX1WW66PU0f8HuYLoH1C5Fro3s3tghUnmHc_S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:U_K8aaPGrQDc96wFG4It-TkjoQVTDTzfgwUTxQjkyAPPPdCELOGd9Q>
    <xmx:U_K8af2AGU3Gdd8t6E22ZByaBoWjKwSCkdUcCD2_fuagmihz-Y8W6g>
    <xmx:U_K8aeO6jBd2n2l0IE1Th2J8XVXDrb5Wl_swPFT4IxfW9swXpWXgIQ>
    <xmx:U_K8aX2O6ge-Xw86F2krIYHNf9PrqOpKbcaX0ajbD-93kgkOdJpCvg>
    <xmx:U_K8aduu182CokUqRTA21dzxe--URlVtWrFOBey4PfDCgM-eDqbKV8Ag>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 03:08:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 050b06b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 07:08:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 08:07:34 +0100
Subject: [PATCH v2 08/14] object-name: backend-generic `get_short_oid()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-odb-source-abbrev-v2-8-fe65dcd8c735@pks.im>
References: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
In-Reply-To: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The function `get_short_oid()` takes as input an abbreviated object ID
and tries to turn that object ID into the full object ID. This is done
by iterating through all objects that have the user-provided prefix. If
that yields exactly one object we know that the abbreviated object ID is
unambiguous, otherwise it is ambiguous and we print the list of objects
that match the prefix.

We iterate through all objects with the given prefix by calling both
`find_short_packed_object()` and `find_short_object_filename()`, which
is of course specific to the "files" backend. But we now have a generic
way to iterate through objects with a specific prefix.

Refactor the code to use `odb_for_each_object()` instead so that it
works with object backends different than the "files" backend.

Remove the now-unused `find_short_packed_object()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/object-name.c b/object-name.c
index 4c3ace150e..7a224ab4af 100644
--- a/object-name.c
+++ b/object-name.c
@@ -120,28 +120,6 @@ static void find_short_object_filename(struct disambiguate_state *ds)
 		odb_source_loose_for_each_object(source, NULL, match_prefix, ds, &opts);
 }
 
-static void find_short_packed_object(struct disambiguate_state *ds)
-{
-	struct odb_for_each_object_options opts = {
-		.prefix = &ds->bin_pfx,
-		.prefix_hex_len = ds->len,
-	};
-	struct odb_source *source;
-
-	/* Skip, unless oids from the storage hash algorithm are wanted */
-	if (ds->bin_pfx.algo && (&hash_algos[ds->bin_pfx.algo] != ds->repo->hash_algo))
-		return;
-
-	odb_prepare_alternates(ds->repo->objects);
-	for (source = ds->repo->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-
-		packfile_store_for_each_object(files->packed, NULL, match_prefix, ds, &opts);
-		if (ds->ambiguous)
-			break;
-	}
-}
-
 static int finish_object_disambiguation(struct disambiguate_state *ds,
 					struct object_id *oid)
 {
@@ -499,6 +477,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
 					 struct object_id *oid,
 					 unsigned flags)
 {
+	struct odb_for_each_object_options opts = { 0 };
 	int status;
 	struct disambiguate_state ds;
 	int quietly = !!(flags & GET_OID_QUIETLY);
@@ -526,8 +505,10 @@ static enum get_oid_result get_short_oid(struct repository *r,
 	else
 		ds.fn = default_disambiguate_hint;
 
-	find_short_object_filename(&ds);
-	find_short_packed_object(&ds);
+	opts.prefix = &ds.bin_pfx;
+	opts.prefix_hex_len = ds.len;
+
+	odb_for_each_object_ext(r->objects, NULL, match_prefix, &ds, &opts);
 	status = finish_object_disambiguation(&ds, oid);
 
 	/*
@@ -537,8 +518,7 @@ static enum get_oid_result get_short_oid(struct repository *r,
 	 */
 	if (status == MISSING_OBJECT) {
 		odb_reprepare(r->objects);
-		find_short_object_filename(&ds);
-		find_short_packed_object(&ds);
+		odb_for_each_object_ext(r->objects, NULL, match_prefix, &ds, &opts);
 		status = finish_object_disambiguation(&ds, oid);
 	}
 

-- 
2.53.0.1055.ga2ffed1127.dirty

