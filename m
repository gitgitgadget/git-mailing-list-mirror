Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F30D4BE445
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968047; cv=none; b=bFmiyFyZIxFLimeLho1K6372UW+TV1Uoj8Fo/DGFJBrxgoXyIcfTJVf8wa8r9ap00vt24xRiSy2nU9JszDvqt+GBsWilTXY08H5SxLSrvZsomiBxuuyEvZqfd3K2o4JqYn3ocPrvMGFEwptgeH9U7V6HrA9fUKzjvfFAn4DurXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968047; c=relaxed/simple;
	bh=VeanuXu7RTIgOgyezx7JrfDHSF8nQDtejXGwQFLuzx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GrVQd8XCE+tQVYs1rdFhXiQCnY87Ad0H5P4DoSJDh0atftj2B8jxPpvy/99jooYGZtfYoAPedOGeVop8IDyDAIMz9cHMTL/kQfiOrFOvuNPumX+8EWUMab9+afmKK4Eh3nsMH5kCqvFgOEKZEcRUQDEMxj1AQ+V97sPBPEwgdok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kskxBJYq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KLk2DFfN; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kskxBJYq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KLk2DFfN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 41A1CEC0247
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:54:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 14 Oct 2026 04:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791968045;
	 x=1792054445; bh=0ghyDKMXmEExwsVfJPy58cteSU72iLaxI4c08UmKvLo=; b=
	kskxBJYqjweT3elmWBRfyOELvQmdAe5k89Q1BAP6DDI3wNDi62aDyFO9jprhVorx
	NqFvwDXpJ1H/ZW8Asauy484EifvlpZe+JmFRzdgK/ZHi68fQ2wYkhFzoFxIG+fD2
	uECs1FoOFUkIY0lJyxDvlcyzgXE+zqQpRYQoTgSoSlV7J4HmTdGefqtpe9DgK1mA
	s5hRylJUCdz8+QEk9yziNLH4rhC4eiJqASF2tvZs4O4q9gQXwHnINYCeCoIIKw2n
	LedqG2PDdEauwU7HldrGZ+ZRMG4gm1coQP43w+ZlRY8bNr6Cd6rpRfxrWDZqpILQ
	+yFCL3GdFM+GlEkB2ET7Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791968045; x=
	1792054445; bh=0ghyDKMXmEExwsVfJPy58cteSU72iLaxI4c08UmKvLo=; b=K
	Lk2DFfNhnEpd32cPlHlNAipT+uD9D7kMgjrQ49eVmUR0WavWOVriJ4WdWnD5lTwz
	Nay1+N//UtxMQGxPdQXuX2pSLIlaLpYGdExS7qg0bMOXXCO3Y+14Ep+ET8HSeRQC
	8X+BSwBs4eLjaKArEcUcmxz+i8dIESAIRN2fIBtDXaQi4G6QzJX23p7Yqnt6aVPV
	szuVddHEquoeKX8p14mk0gqKZ0XNZHgMFUd5gpEyP/scYP7QIOPggTUsM0k+fTXx
	XL/RUb5naOTNd0p8G0BT7RH71kpDe+5YBBX2UBC2bNkRdpgoGocoXIpICzjVruNF
	tVH48erIcmDdy8FZufDpA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791968045; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:C3/Nhit42nUQ+LeKoEW69X334q1DgEXmZfMpJCFzTf+XaCU
	7EQU2f+9Nqe7WEM2sCKFxG0LUin5HUOs1dmFGYp6sm5aZ1KLdLTwPM14dYhYzc+t
	9CSyyZjUcDhvvv+iXjcuPHIqEjM1TcgwKqq2z1Ib//grDo7AKD/GMF3C5OMRWO9Z
	9p0f+vVrA9F2xjAbGEwPCV2px7H1aYvrk/UOdJmJzx7K2+P1EVfb8VWfm7qvE69X
	qUqREgbLqZdydFRekb1IJAeqxaLmdksmvUcKrIbJpO9XdKuE9EnrHkRp8/b3FjuF
	Yx83m/M2f2ngp6uvfl4OT02Er14uzONXXRrGHbA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hP+kynejrtH7Sx30vXdBv73UCbaYRaHVDpDaBsuIB3w=:VeanuXu7RTIgOgyezx7JrfDHSF8nQDtejXGwQFLuzx8=;
X-ME-Sender: <xms:LUPPalbNcl_vXgsbyuB7m8rIvPunjF3ATLumiRMbUfKU2TQmOHBFKg>
    <xme:LUPPajZy0wptzmsmEQht6movZ_8Qj9pq5Lj2BdyEfa-4vT8n6X9CiUwTn2y-ZFS13
    Myzia_RlHfIGadIZvdp6aAPJQrf43yzXt1v50FbB3SIpsTYBDOLY3Q>
X-ME-Received: <xmr:LUPPas8yViDYpYiasrizdcPD9eSQAMMhV6NETpi8tTqqnAS5_XSjkg>
X-ME-Proxy-Cause: dmFkZTEIGbfxSI3LK1PjypvgEMHVXUW0L5HWcG0BIsOmbk6itNM66/4zvoSPIX2WOSwp1X
    61Ife/ZBu0XlHdtlQJBOGqy3Y4djmbT/ZTaw+DFeOy2p/xriFVqMihR2QN5pzzYBDKw2VT
    qv4rA+uKFyqpW0LG1fskR+o/dZ8j5BYdcM2t2y/v84NZWoeKtSFHlzlC59O3EAJaZsgJi5
    ab0DSmncPPyrquYVpCiXeeXgmWhnsNx1yTH2IoJtv9NiunhMjc0uAh6jITC5QQ7XMnL0lB
    u1haWUg9JeY4GmBu5H9VkPO9DUniWQ3hzuMSYDU6A/ES/I+5NjGtpi65Yl6lLdAwHGTwbZ
    GvOtf/M1/4jtUJl/O7phRJmdWSzbjyZoLM4dxYqzcPeolvCETG2duB1A5reaFavE9QWFlD
    1PYC00+7moqb1zYOf6ZIv9hjXTlRZPF0YaseK6exckcLwDiNiRKn1dSjQBcP9Tq7f5LLqk
    vI8qlwhBlhkNjUROo5QSItiAcwLi7QNKTZ8BaYTflTgXhQ7p9mf+mZ5MqF/xJO5X/s9UiI
    xtmydRxAiDpXagiEpGunCoSP7q4BPbboOaTIlQXYbEe7/Y2JRbHxvMyzLcoVNikuURCq0c
    7oZAiED7wQEP9KptqN1xAcqw1lQrnAGFnBs1pgTkoax9oNATiARUgN4zwjlA
X-ME-Proxy: <xmx:LUPPaiiqTWiG93McdsaWWrdeFy0K7N5kVh-QhZ1vfOEUz6vY9U1oGA>
    <xmx:LUPPaseYEmrvRCoa2a9__cWhn9NGBUJRtDqQ8NnbB4naEzfxbgMNZA>
    <xmx:LUPPapokOJcp4Wceje9_zMzO7jy3HtEiPPd_aFKYeVLlDV2xXHeq-g>
    <xmx:LUPPahAFraValC-GwYcjnDxhzcWnF15hf3Blw7GLREQC4OZDSMRLfg>
    <xmx:LUPPag2ZlG3tlAVPHhXm6iX2sHR4wt9zg4Jqs2Xu8rVV1cNYQ_GlY0yG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 04:54:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a561e093 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 08:54:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 Oct 2026 10:53:47 +0200
Subject: [PATCH v2 3/6] odb/source-files: make the second read an
 implementation detail
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-pks-odb-files-alternates-cleanups-v2-3-fed9b2caa3be@pks.im>
References: <20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im>
In-Reply-To: <20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When looking up an object fails we perform a second read in all sources
with the `OBJECT_INFO_SECOND_READ` flag set. This flag tells sources
that the first lookup has failed and that they should reload any on-disk
state that may have changed in the meantime so that the object may be
surfaced after all. The "packed" source uses this to reprepare its
packfiles, whereas the "loose" source short-circuits the second read
because there are no caches to flush.

This logic lives in the generic object database layer even though it is
highly specific to how the "files" backend handles its reads. But now
that alternates are an implementation detail of that source, we can
easily move that logic into the backend, as well.

Move the logic into the "files" source and drop the flag.

Note that the "packed" source also used this flag to figure out whether
it should try to surface an object via a packfile that should have the
object as determined by a multi-pack index, but where the packfile has
vanished. The multi-pack index is stale in that case, and that scenario
should really only happen when the process is racing with a concurrent
maintenance task.

This code is adapted to instead use `OBJECT_INFO_QUICK`, which means
that the fallback may trigger on the first read already, but not in a
case where callers know to handle false negatives already. In the worst
case this could cause another scan through all packfiles covered by the
multi-pack index. But that scan should be fast enough anyway, and it
only triggers when we hit the race. So the effect thereof should be
limited.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c               | 15 ---------------
 odb.h               | 12 ------------
 odb/source-files.c  | 13 +++++++++++++
 odb/source-loose.c  | 10 ----------
 odb/source-packed.c | 15 +++------------
 odb/source.h        |  7 -------
 6 files changed, 16 insertions(+), 56 deletions(-)

diff --git a/odb.c b/odb.c
index 98c5c862f5..69a4c203bc 100644
--- a/odb.c
+++ b/odb.c
@@ -285,21 +285,6 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 		if (ret != ODB_READ_NOT_FOUND)
 			corrupt = true;
 
-		/*
-		 * When the object hasn't been found we try a second read and
-		 * tell the sources so. This may cause them to invalidate
-		 * caches or reload on-disk state.
-		 */
-		if (!(flags & OBJECT_INFO_QUICK)) {
-			ret = odb_source_read_object_info(odb->source, real, oi,
-							  flags | OBJECT_INFO_SECOND_READ,
-							  corrupt_err.len ? NULL : &corrupt_err);
-			if (!ret)
-				goto out;
-			if (ret != ODB_READ_NOT_FOUND)
-				corrupt = true;
-		}
-
 		/* Check if it is a missing object */
 		if (odb->repo->fetch_if_missing && repo_has_promisor_remote(odb->repo) &&
 		    !already_retried &&
diff --git a/odb.h b/odb.h
index 0ccc47ee73..dd85b880a7 100644
--- a/odb.h
+++ b/odb.h
@@ -383,18 +383,6 @@ enum object_info_flags {
 	/* Die if object corruption (not just an object being missing) was detected. */
 	OBJECT_INFO_DIE_IF_CORRUPT = (1 << 3),
 
-	/*
-	 * We have already tried reading the object, but it couldn't be found
-	 * via any of the attached sources, and are now doing a second read.
-	 * This second read asks the individual sources to also evaluate
-	 * whether any on-disk state may have changed that may have caused the
-	 * object to appear.
-	 *
-	 * This flag is for internal use, only. The second read only occurs
-	 * when `OBJECT_INFO_QUICK` was not passed.
-	 */
-	OBJECT_INFO_SECOND_READ = (1 << 4),
-
 	/*
 	 * This is meant for bulk prefetching of missing blobs in a partial
 	 * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK.
diff --git a/odb/source-files.c b/odb/source-files.c
index 54235821d5..9788a5adf4 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -427,7 +427,9 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	enum odb_read_status status = ODB_READ_NOT_FOUND;
 	enum odb_read_status ret;
+	bool retry = false;
 
+retry:
 	/*
 	 * Reading an object may fail even though the object exists, for
 	 * example because it is corrupt. Report this failure to the caller in
@@ -435,6 +437,9 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 	 * prefer the first such error in case multiple reads have failed.
 	 */
 	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		if (retry)
+			odb_source_prepare(&dir->packed->base, ODB_PREPARE_FLUSH_CACHES);
+
 		ret = odb_source_read_object_info(&dir->packed->base, oid, oi, flags,
 						  status == ODB_READ_NOT_FOUND ? errmsg : NULL);
 		if (!ret)
@@ -444,6 +449,9 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 	}
 
 	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
+		if (retry)
+			break;
+
 		ret = odb_source_read_object_info(&dir->loose->base, oid, oi, flags,
 						  status == ODB_READ_NOT_FOUND ? errmsg : NULL);
 		if (!ret)
@@ -452,6 +460,11 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 			status = ret;
 	}
 
+	if (!retry && !(flags & OBJECT_INFO_QUICK)) {
+		retry = true;
+		goto retry;
+	}
+
 	return status;
 }
 
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 0664634938..180ce7403f 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -222,16 +222,6 @@ static enum odb_read_status odb_source_loose_read_object_info(struct odb_source
 {
 	struct odb_source_loose *loose = odb_source_loose_downcast(source);
 	static struct strbuf buf = STRBUF_INIT;
-
-	/*
-	 * The second read shouldn't cause new loose objects to show up, unless
-	 * there was a race condition with a secondary process. We don't care
-	 * about this case though, so we simply skip reading loose objects a
-	 * second time.
-	 */
-	if (flags & OBJECT_INFO_SECOND_READ)
-		return ODB_READ_NOT_FOUND;
-
 	odb_loose_path(loose, &buf, oid);
 	return read_object_info_from_path(loose, buf.buf, oid, oi, flags, errmsg);
 }
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 2226fbd313..48fe00c2bc 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -52,12 +52,11 @@ static int find_pack_entry(struct odb_source_packed *store,
 	 * packs, and repreparing the on-disk pack set does not reload the
 	 * borrowed, cached MIDX, so scan its packs directly for the survivor.
 	 *
-	 * Do this only on the second read, by which point repreparing packs has
-	 * already had a chance to find an object merely relocated into a new,
-	 * uncovered pack; only a genuine hidden duplicate reaches here.
+	 * Skip the scan for quick lookups, which are expected to accept false
+	 * negatives in favor of speed.
 	 */
 	if (midx_result == MIDX_FILL_OWNER_UNAVAILABLE &&
-	    (flags & OBJECT_INFO_SECOND_READ)) {
+	    !(flags & OBJECT_INFO_QUICK)) {
 		struct multi_pack_index *m = store->midx;
 		uint32_t i;
 
@@ -86,14 +85,6 @@ static enum odb_read_status odb_source_packed_read_object_info(struct odb_source
 	struct pack_entry e;
 	int ret;
 
-	/*
-	 * In case the first read didn't surface the object, we have to reload
-	 * packfiles. This may cause us to discover new packfiles that have
-	 * been added since the last time we have prepared the packfile store.
-	 */
-	if (flags & OBJECT_INFO_SECOND_READ)
-		odb_source_prepare(source, ODB_PREPARE_FLUSH_CACHES);
-
 	if (!find_pack_entry(packed, oid, &e, flags, &bad_pack)) {
 		/*
 		 * The lookup may have failed because the object is known to be
diff --git a/odb/source.h b/odb/source.h
index 1867347dfc..0cfe762376 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -119,13 +119,6 @@ struct odb_source {
 	 *   - `OBJECT_INFO_QUICK` indicates it is fine to use caches without
 	 *     re-verifying the data.
 	 *
-	 *   - `OBJECT_INFO_SECOND_READ` indicates that the initial object
-	 *     lookup has failed and that the object sources should check
-	 *     whether any of its on-disk state has changed that may have
-	 *     caused the object to appear. Sources are free to ignore the
-	 *     second read in case they know that the first read would have
-	 *     already surfaced the object without reloading any on-disk state.
-	 *
 	 * The callback is expected to return an `enum odb_read_status`. Please
 	 * refer to the individual values that can be returned. In case reading
 	 * the object has failed with a generic error and `errmsg` is non-NULL,

-- 
2.56.0.212.g129ede20d9.dirty

