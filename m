Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4961730CD9E
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368831; cv=none; b=qsPGhm4ICwWbCgQ694+lnG9/C7C0X97P/YAfNsaNye54DiYWuheLthFJ1LOAQBHy9qSdpoliZb98gayAQH8P6pTnH7EwGPy5c6W0TMAJ8uq8gM1NjUs2t6ymSot+uTynqNRubE6lwyNelvzCTEpJ9TkGGbkNQDF0Rfvqx/BH2Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368831; c=relaxed/simple;
	bh=6DbwhE5K4TMMKjnDvIsbrbf/lbpx8TgFctJo1N16uhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oEGBClHn7NiuB16YSvfhxx6TePQHiQdRC6vujFENjsB5EhEs/TyvnHNDrQaPJa1LP2yd2hTh+N4InUSAub5mszBsx2ZOj+b1/v0tcNrO4FANwLLRj07lGMLwIa8gHm3GySlk04L8a19uoRXUaDplcnXW2nAuxTM49jtDdGY7PCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R6ok4N2o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZCS4Iq45; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R6ok4N2o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZCS4Iq45"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4AE0314000EA
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 09:33:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 10 Aug 2026 09:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786368829;
	 x=1786455229; bh=nBET3TdWrzTpAj6+Uk0e2qusK0joG32CZkGd5VH02m4=; b=
	R6ok4N2o+13e7FidzFNe7isZK0sfqJD3ZQXOCQyBUoKeN+j8/9tgHtTw/08eVM46
	0nxc2XNwLStcqHp737D3VQZrJDzbJ/OfpUJhGQMjE2ZOKno1Qm8k2gT2k0/Pyctf
	oesyG9CY/wq2azMfbLgdyJv9X3Tv7sjI95fzVGyBnPgjgkX+NoVCa3E6l4jMGVUX
	EtaqN8tGinFaGFHyOEvwVtZtLWp0WVwO0orw1ozXK5BHgHt8KUtqF4QE3kKkuOjT
	XXaaKAAO9eKNT0AeNM0FupB1r0G1AcChO0/2Jh7Tl5jvrP8Uq9IQ2Om5mD0D2Zan
	m3Z9eYFd+S+q66LKUdrj+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786368829; x=
	1786455229; bh=nBET3TdWrzTpAj6+Uk0e2qusK0joG32CZkGd5VH02m4=; b=Z
	CS4Iq45u777U5ImuRVBMYPfzDLnNRs+VWsw8DxjFHABmSyfbYW3MZjEKTJ0ewy2y
	b+/JrAUg3pr981lmdFKQtNgMIYgE4vk70lfWyKvjjBon8KNCilni3ePZ1LUWWm5n
	3x/vfROdy6CAXcJx7sBpPGubAdLCR/937SqFOLcjXaDrmrrrYbdKnwcOlwee9P7O
	l3ZUd/kJ7sJM+xVFCDUHxA/QJ81Eg97HP4nOKTl2Cce0vriqoI7QDjOvhO4EImtu
	47I5Y0qJdzYa7aAfYXKBQEowkEvmzfdtQqApWZm/laLPayCe4qbC4JfBL/dgZ8WN
	AAWpPe2HKF8+4494xBOVg==
X-ME-Sender: <xms:PdN5atz3mk4ZCpfYFLTRq3haoe12ioyaY34g4pdsfOY3sSsD8vaWfg>
    <xme:PdN5akNFG6DzulBp24LmAa6O3SLpXfAOFEbFASPFLlnkk6NgCi2QHz17btWNyb0Pj
    8XTyCK1Et6z2bZMbMepwHe9StOuwHxJxHQuEaxVSFqkyBF-MP9ajg>
X-ME-Received: <xmr:PdN5as8avRutoQfcQTGjTVf20xTsUW1cLk8GfNuHYgpycpd9mFCItHt1X9Ul-kmC2PWo0pNUEy8i3kQTvHa9CotdOzs-CdvtSWqPWYybsQ>
X-ME-Proxy-Cause: dmFkZTEqG70237HTmxT6vjqEFX6cdwSOb18WcHLifhLzEOadHfeML0vGCH9+S783NrLLlR
    d0MgPvRYCy33A4D5A5/j/Bg/RXjPfjtBrKeYM3deoREjnN0yHrbvrVxfI7mso0h4iTOdBH
    UZvmO5RSHDWvWaSZvaV1pSorSfKNhs95KQNN/mlKjcYy7Pqb5u+wMhS4o/DSRahJABxozT
    L5CyPr72k96GMW4GiNdUuPJchHaIzEB9oKOF0V028dupKgaGrm4AVNzfxFvSsRPIXLQF5l
    vIARau+c5EIjzb92McyNgv6rryozKwcOV64+p44/FpSkrsw3Cv7OsEcAUlHPX2vHpqL/Ox
    izmi9DXMLPVrh/uVwFWuk2LT2Gc0mgsxdyNPzgpPTpXr9j3gxrgqVZAcr3Pc1D7/+41qUS
    mWvksqPgkzRopJUwekN1AB6L4+66/xHtSSEzVQR/Vdy8XsbtgfOr2DJuuVaR6eJ73VUTRz
    1Q62o0pnquAbNs1/ec5HAWgMkg2Ns/5zEjDLmDEvHSOnegY+1fpdhdt3rRjWFA9MeLqLdW
    JFx7nYObV5ycnX8fn8Xv3fiSU1XKfTuIcodLYGMc2TGqjmetxXmQyAXWOD0+erHgcHjpbz
    OfirZdsQJMYT15LXztK+2BgtpJDyNOe8gcq+RI38Ne+6WO+hPTAcgjdGUJuA
X-ME-Proxy: <xmx:PdN5akrl41ZIEhjtcSpRjT5T2OAjPpv0m-f4lBnrb7Mu1oG0y3i-Yg>
    <xmx:PdN5au4RZuzJT06HkMOLLTf_3UL_4vOdUsmDJrrKsG4NHjX_mxf3xw>
    <xmx:PdN5akNjpAhDSrbHwUDPemm1fLq1GxweXkWiIcuLgVRIqHWlvxGbEg>
    <xmx:PdN5agN_7wkls4A27EmEyvZ7J37vS6KOsFk7AqPOBPezWlWalsIIQQ>
    <xmx:PdN5ajwbJN-nYinQibVpcxMasqpjQtuzTtjbKMJ_-3t_4MQPziDKEb_x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 10 Aug 2026 09:33:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fbacb486 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 10 Aug 2026 13:33:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 10 Aug 2026 15:33:31 +0200
Subject: [PATCH 4/4] odb: drop `alternates_db` field
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-pks-odb-eagerly-prepare-alternates-v1-4-f0fa4a4004e1@pks.im>
References: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
In-Reply-To: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The `struct object_database::alternates_db` field tracks the value of
the "GIT_ALTERNATE_OBJECT_DIRECTORIES" environment variable and is
used in `odb_prepare_alternates()`. It's not necessary to store it as a
separate field anymore though, as we stopped lazy-loading alternates.
Consequently, we can simply pass it to `odb_prepare_alternates()` via
`odb_new()` now.

Do so and remove the field.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 14 +++++++-------
 odb.h |  7 -------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/odb.c b/odb.c
index 2eb37a2f44..fc21199f80 100644
--- a/odb.c
+++ b/odb.c
@@ -490,12 +490,14 @@ int odb_for_each_alternate(struct object_database *odb,
 	return r;
 }
 
-static void odb_prepare_alternates(struct object_database *odb)
+static void odb_prepare_alternates(struct object_database *odb,
+				   const char *alternate_db)
 {
 	struct strvec sources = STRVEC_INIT;
 
-	parse_alternates(odb->alternate_db, PATH_SEP, NULL, &sources);
+	parse_alternates(alternate_db, PATH_SEP, NULL, &sources);
 	odb_source_read_alternates(odb->sources, &sources);
+
 	for (size_t i = 0; i < sources.nr; i++)
 		odb_add_alternate_recursively(odb, sources.v[i], 0);
 
@@ -1062,11 +1064,11 @@ struct object_database *odb_new(struct repository *repo,
 
 	o->sources = odb_source_new(o, primary_source, true);
 	o->sources_tail = &o->sources->next;
-	o->alternate_db = secondary_sources;
 	o->inmemory_objects = &odb_source_inmemory_new(o)->base;
 
-	odb_prepare_alternates(o);
+	odb_prepare_alternates(o, secondary_sources);
 
+	free(secondary_sources);
 	free(primary_source);
 	return o;
 }
@@ -1100,8 +1102,6 @@ void odb_free(struct object_database *o)
 	if (!o)
 		return;
 
-	free(o->alternate_db);
-
 	oidmap_clear(&o->replace_map, 1);
 	pthread_mutex_destroy(&o->replace_mutex);
 
@@ -1126,7 +1126,7 @@ void odb_prepare(struct object_database *o, enum odb_prepare_flags flags)
 	 * the lifetime of the process.
 	 */
 	if (flags & ODB_PREPARE_FLUSH_CACHES) {
-		odb_prepare_alternates(o);
+		odb_prepare_alternates(o, NULL);
 		o->object_count_valid = 0;
 	}
 
diff --git a/odb.h b/odb.h
index aefb34213f..748366a610 100644
--- a/odb.h
+++ b/odb.h
@@ -69,13 +69,6 @@ struct object_database {
 	 */
 	int source_paths_icase;
 
-	/*
-	 * A list of alternate object directories loaded from the environment;
-	 * this should not generally need to be accessed directly, but will
-	 * populate the "sources" list when odb_prepare_alternates() is run.
-	 */
-	char *alternate_db;
-
 	/*
 	 * Objects that should be substituted by other objects
 	 * (see git-replace(1)).

-- 
2.55.0.679.g6767b8d81c.dirty

