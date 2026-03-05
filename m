Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA424A058
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720407; cv=none; b=hjvM9LYHylnd8PZrE1ka2p+NQszLJ+MKLcGVYKPNdS2lPRjckOZX9l0IXCb62vvhWavn1vsCHp+HFdSGS2tqtmQSiLk/lzf9Ie4IbGXfA7bf3d05DYtUYZcXQ6776+nuGwJZeeWRqMCymvm+WUD5Bh8moqAru9gFdlmqF0ImmAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720407; c=relaxed/simple;
	bh=HTkTHjRq/j9kVFSThi2VDulFHpTrEyt3BGEF7PiruX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QiRoAeWbhwVu9tLnamgdqCVVqaEUj72yM+ivZ2HO3QAXYJVvENV8Tdrj1T5UjAIjYJQ/LOMSZE/iaNQQwsWrUT7qo1u2TqXKDfc2z565MQujWWGYG6+sGovDjsEqcqtlkuru5O0enEqaYZ/tfX2Eweld0KYvtvI/nsvDSfv7tMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fq1F3bJs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hPN6YR/k; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fq1F3bJs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hPN6YR/k"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F0C37A0017;
	Thu,  5 Mar 2026 09:20:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Mar 2026 09:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772720405;
	 x=1772806805; bh=6zE8bDZAXfDvsuZEQTKDIa4GbTzDmJiV6QCuK34hVPM=; b=
	fq1F3bJsLyZEjor87DSgpIPRe7644NZC2nGOzc4Xt7rwlFaCaRIjE/P5B7Dgi4Qh
	zuvkuXPWoGcOcn4N33AkU5AY9bnyS6JGLEfPebJRmuj8lysNsWYKDLZV6DzrzJ5T
	D3qBUtnjqZ5NacJ5eFsGalkQQplFSCwcU5bbLsbTtMEDGWK3QwiWimXIaKDFAwyn
	9od6jbfqeQwtP6HDChyN0DFiuVO6ySgnrDE2nWNtYKDy8aS1DmMp7R/2YmhMs6xa
	5qV3oOmqXcjvJ5BT1csUESfoyV9ho2AtbQ81U6EgHr/OYgxDvOH2n4JpHf/mEpst
	jNlaUttB2ZImskHQZL4p1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772720405; x=
	1772806805; bh=6zE8bDZAXfDvsuZEQTKDIa4GbTzDmJiV6QCuK34hVPM=; b=h
	PN6YR/kA0/DGYDp68UgSxSq0fIC1/iMakpZKFGvzdd7wqE4Y2ZSadOc+uNPrVTTM
	DQodpB4OPOVhUBOsYyDhzHdCtcqZdQXhwDvlVwZYgPGBihCyVg/aX2OtIJBXHg57
	S4+MRMer0G0p+ZkFBwI0txMpswN80a1u1zV7RleE90yXbXARHhKzpxRLhbdRPYlA
	16lHdbMGe19psiAP/YvtKLVJQ0XPrCcm7VdMWaFyybLufaMqtIxcsSKZVro/uwhL
	IBoCaSUqlHMUh8GdbshdAn8ITxU4Pno/ADY8dNJdEMBIP2E2qlQsHx5yNxhClP5q
	I1zuqYWyM9zZTlemgkGnw==
X-ME-Sender: <xms:FJGpabKLWusRVqsj32wv7s4KCwiNpdZ_7BIqP2CarOjwOI9O9Efaag>
    <xme:FJGpaWInVhaUHYD03sIEPWuryBwDU7Hjt0RW-7WvnfvKZFliZFgSpki9L82q25745
    FHc9qUMWI1tcGO7NVQhdya3oaPQ3MWEI6l8a555JCFh8HGjhCfA8kk>
X-ME-Received: <xmr:FJGpaYveUqK3MXIpDCHI13RFzCXUF5ZIcTKs7lJX50JMx6BnU0CJi11aoxah2ks-xEl-DjHkET56fPntZAzuWULi3wm2udvdUctuLw4fnKKq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FJGpaTSxfRy-5EwUkEkOeqlMupiyXp-frCTu2-IFO2r-MmfR5fX_eA>
    <xmx:FZGpaeNg6i-XR7Pfw55aN1gGz8iTOoS-Mo9PW3Ws1jEoqZbIH_F_mA>
    <xmx:FZGpaYaAsXPbeDIHQrRPFO9QbYpzp4sXxB1Kx-2R2krxUC-CWpJG8g>
    <xmx:FZGpaYwwf_NYZV6aYF2c-QPVOp3nC2VqqHHGAT8ynjkzFNm9qCA8HQ>
    <xmx:FZGpaYOAXuIL9IJwX4_ctnIRehn8gU76tmLpZBLelRr4yAsp5TepJ_aQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:20:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3abd0893 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 14:20:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Mar 2026 15:19:46 +0100
Subject: [PATCH v2 06/17] odb/source: make `free()` function pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-b4-pks-odb-source-pluggable-v2-6-3290bfd1f444@pks.im>
References: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
In-Reply-To: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 7 ++++---
 odb/source-files.h | 3 ---
 odb/source.c       | 4 +---
 odb/source.h       | 6 ++++++
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 7496e1d9f8..65d7805c5a 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -18,10 +18,9 @@ static void odb_source_files_reparent(const char *name UNUSED,
 	files->base.path = path;
 }
 
-void odb_source_files_free(struct odb_source_files *files)
+static void odb_source_files_free(struct odb_source *source)
 {
-	if (!files)
-		return;
+	struct odb_source_files *files = odb_source_files_downcast(source);
 	chdir_notify_unregister(NULL, odb_source_files_reparent, files);
 	odb_source_loose_free(files->loose);
 	packfile_store_free(files->packed);
@@ -40,6 +39,8 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->loose = odb_source_loose_new(&files->base);
 	files->packed = packfile_store_new(&files->base);
 
+	files->base.free = odb_source_files_free;
+
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
 	 * is not (yet) possible though because we access and assume relative
diff --git a/odb/source-files.h b/odb/source-files.h
index 803fa995fb..23a3b4e04b 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -21,9 +21,6 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local);
 
-/* Free the object source and release all associated resources. */
-void odb_source_files_free(struct odb_source_files *files);
-
 /*
  * Cast the given object database source to the files backend. This will cause
  * a BUG in case the source doesn't use this backend.
diff --git a/odb/source.c b/odb/source.c
index c7dcc528f6..7993dcbd65 100644
--- a/odb/source.c
+++ b/odb/source.c
@@ -25,11 +25,9 @@ void odb_source_init(struct odb_source *source,
 
 void odb_source_free(struct odb_source *source)
 {
-	struct odb_source_files *files;
 	if (!source)
 		return;
-	files = odb_source_files_downcast(source);
-	odb_source_files_free(files);
+	source->free(source);
 }
 
 void odb_source_release(struct odb_source *source)
diff --git a/odb/source.h b/odb/source.h
index 45b72b81a0..4973fb4251 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -51,6 +51,12 @@ struct odb_source {
 	 * the current working directory.
 	 */
 	char *path;
+
+	/*
+	 * This callback is expected to free the underlying object database source and
+	 * all associated resources. The function will never be called with a NULL pointer.
+	 */
+	void (*free)(struct odb_source *source);
 };
 
 /*

-- 
2.53.0.797.g7842e34a66.dirty

