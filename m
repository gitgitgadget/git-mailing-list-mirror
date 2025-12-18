Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E142D6407
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040950; cv=none; b=qzpLK5nWYhPdjSu8XmwInW7CrKnDP8v+lN5zJqBCR2ccxz3NLzelVDYhu2Ene2XDJ2KuiuET1L3RI2cR4wu+xhQtNGgU5QwxXhbrm4bSqGibU6mn2/4JDmUTsZLp6qQUA5m+VTgq942cGkAb3kMhaH2FbbR0AknnX7jHp9aArns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040950; c=relaxed/simple;
	bh=yiq8G34pyar6cvTytkgxeB/0/Um2/KUJauGLSSz4fEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U54wHa/nKSmgDDRMo0Ov9fPO8VJ4dYYyZJRYwc6LsplAtp+YNUpXimq0Z0RDWWKjcEoZd6k9WroEPigT+q/nEuD9xbXXy+DI2XZZ/ugib7fs+RTNAdr3BCayPQqcmkI8Wh45w0kE/WnwQE6PR2sk245f2oipv+4LvfOJETknnPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aqjPcnbu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iq0S0drm; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aqjPcnbu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iq0S0drm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 30CC97A016A;
	Thu, 18 Dec 2025 01:55:48 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 18 Dec 2025 01:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766040948;
	 x=1766127348; bh=OVgoSiO4WeAhVVVmv0bSYc8Lkzq0fgjt4oJ61cqJyzM=; b=
	aqjPcnbu7brMof9Jm3O/O/QXdJp2BW9qhbdDV9wThijVWxAljaz+u0arfPvPGKIP
	DwYP9CYG/DKyuKwCMh6Ct5tjHYiHTsh5anV2kYHVMfhuCvWg9h4hQIYIBCNbaAD0
	0X96tCYvtY1+nBDEqJWDcssk0mEwHsNsVeqNB4hz3JvIOasFv+hWIsocNhex6GgR
	G9tXcGDNvXE5uvo7Js0HkmKRZMt2F/Kr4Izp9jDE+0sV6GDv0Wsv5yfBjgBhEn8e
	4I2TVX1yIw0mcCCD4qPgvFb7Vvlcrf2TG7pm25dk/YFCY7a5CxyF1mM18pGx0STf
	7GReY3ICd9Codw3BdXB/FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766040948; x=
	1766127348; bh=OVgoSiO4WeAhVVVmv0bSYc8Lkzq0fgjt4oJ61cqJyzM=; b=I
	q0S0drmKvsQZVFthhsVelQguDGRo/QObOjC21XRbKLOgMtHRV/ZdxrVqUCQL4DmD
	ebRQ8zDpy+jVUoDjPj11KiErHG61aFuIj+LQ1BOspuKrkxS6oJSDwijJ4DPxRzKL
	j/0dSsKOcR9O+z1uKIwm9vrOVwsaDnjZ6fiipE03Aa3xGgOczMhx26RU+Oq0KaFq
	2VTu+oAEx7MtiQ2AhZwz5Ey5LYoPJzE08wz4KJb19gqAcPE+i3GZ+yNpxSPsDASi
	NZSS6SA9nfT4gQLm5E0bEJVL2lOFHPnqcjPz1Cyt6vo3dsQ5af47318bqfyFS0O1
	peQZnwedativmtnmVOlWA==
X-ME-Sender: <xms:c6VDaVx7fnCEMgrowGqCMcrnXXiN5FFgCcq5MI1_eij0t0xwi_bRVA>
    <xme:c6VDabTNEuKIMEiREtonS_Ciz7Jk59b6c20sGKQ7FLr3q9cCXdH2LzXYT7yw5B67P
    X-CPmoYjI2pfeyQkrKloN2VFuPR-L8G65t-69B0PmaLIy6c73TA>
X-ME-Received: <xmr:c6VDac9DChWcjoosncd3FfJ2v8Rkqfwh9OvxpTbdTh4rB5ifl_pVPcPfovLyF1twNGN3at_LgDoaAc0YpPWls0Dl2rPjlssf7FABXP008A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:c6VDaSoi-Vo4g2IAU6OSY5JAVLOj05Upw8VaDxDTFotf6B72L6a1vQ>
    <xmx:c6VDaZnFQ2XJHr1PT_N5dvI7LK8Mf-WfaCyyQ6lQLsV5t7-6wb5hVA>
    <xmx:c6VDaZKDBnbuvYHMKCoeiLjC_4XVJjvSqNftNVg0Soe8qT9mPh3ArQ>
    <xmx:c6VDaezjJ93eDbX2VFK4t644c1eRAkaF6l9BhHgwC9XS35J-sUopVQ>
    <xmx:dKVDaRjMxIY9FpPOHMAt15Ca9mYc4EPwTTKoajLaGCgeDLEopxXRD1Xd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:55:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 73673cef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:55:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Dec 2025 07:55:26 +0100
Subject: [PATCH v2 07/10] packfile: only prepare owning store in
 `packfile_store_prepare()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-b4-pks-pack-store-via-source-v2-7-62849007ce21@pks.im>
References: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
In-Reply-To: <20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

When calling `packfile_store_prepare()` we prepare not only the provided
packfile store, but also all those of all other sources part of the same
object database. This was required when the store was still sitting on
the object database level. But now that it sits on the source level it's
not anymore.

Refactor the code so that we only prepare the single packfile store
passed by the caller. Adapt callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c | 14 ++++++++------
 packfile.c     | 19 +++++--------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 4855b871dd..5b8b87b1ac 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1213,12 +1213,14 @@ int cmd_grep(int argc,
 		 */
 		if (recurse_submodules)
 			repo_read_gitmodules(the_repository, 1);
-		/*
-		 * Note: `packfile_store_prepare()` prepares stores from all
-		 * sources. This will be fixed in a subsequent commit.
-		 */
-		if (startup_info->have_repository)
-			packfile_store_prepare(the_repository->objects->sources->packfiles);
+
+		if (startup_info->have_repository) {
+			struct odb_source *source;
+
+			odb_prepare_alternates(the_repository->objects);
+			for (source = the_repository->objects->sources; source; source = source->next)
+				packfile_store_prepare(source->packfiles);
+		}
 
 		start_threads(&opt);
 	} else {
diff --git a/packfile.c b/packfile.c
index c46d53b75d..23d8f7cb93 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1063,16 +1063,11 @@ static int sort_pack(const struct packfile_list_entry *a,
 
 void packfile_store_prepare(struct packfile_store *store)
 {
-	struct odb_source *source;
-
 	if (store->initialized)
 		return;
 
-	odb_prepare_alternates(store->source->odb);
-	for (source = store->source->odb->sources; source; source = source->next) {
-		prepare_multi_pack_index_one(source);
-		prepare_packed_git_one(source);
-	}
+	prepare_multi_pack_index_one(store->source);
+	prepare_packed_git_one(store->source);
 
 	sort_packs(&store->packs.head, sort_pack);
 	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next)
@@ -2098,15 +2093,11 @@ static int find_pack_entry(struct repository *r,
 {
 	struct odb_source *source;
 
-	/*
-	 * Note: `packfile_store_prepare()` prepares stores from all sources.
-	 * This will be fixed in a subsequent commit.
-	 */
-	packfile_store_prepare(r->objects->sources->packfiles);
-
-	for (source = r->objects->sources; source; source = source->next)
+	for (source = r->objects->sources; source; source = source->next) {
+		packfile_store_prepare(r->objects->sources->packfiles);
 		if (source->midx && fill_midx_entry(source->midx, oid, e))
 			return 1;
+	}
 
 	for (source = r->objects->sources; source; source = source->next) {
 		struct packfile_list_entry *l;

-- 
2.52.0.351.gbe84eed79e.dirty

