Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D0C3D47CF
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 05:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792042090; cv=none; b=ng81CWucdsTNrFOOAydKIXop4YJk/VWmtzIq8mdtpBUhghm4N3z0cEL5gf4t4yCBYHlujYzQAIcjLnpvlOH9xQr0UhAOFxkHS0et6XSzM7btsIY9HY9tCWgFxXBTsRwXiF4knHlHF+ehXZwUq4il1ZSSq5jmBC3bz4SUrSq3j8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792042090; c=relaxed/simple;
	bh=VeanuXu7RTIgOgyezx7JrfDHSF8nQDtejXGwQFLuzx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VKSBGUxAmeR4ZpxOei15IPprRoU9TJcDjdy7uWP9AjsCuRJV5+kN2OwGNmeTnmyxPfM1pUGF83bmPzF0byJw9GyuciqvhgxR9GuRlNV12Q7rhvDA6Ct613c2uHMIrRVX2K8zxKT0/t5rfL39oCkm+ZHZnGyxToq8GTygLguKS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gNXnQXdP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dy3AgOfr; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gNXnQXdP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dy3AgOfr"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0AE431D0013C
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 01:28:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 15 Oct 2026 01:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792042087;
	 x=1792128487; bh=0ghyDKMXmEExwsVfJPy58cteSU72iLaxI4c08UmKvLo=; b=
	gNXnQXdPxNQlxDwADxsqvTf7bN3HauCDEmBGF3g7mpC7XDBam/HGHb+lhBX34mUH
	hVxQs7dw6GVCHhdb1i9e+ujYf/1FpB268Mc/rf6n2uuhUWnzYOtOP7gceoCw+aV9
	/DX/dO8ElszUBNNGFb06ednaZBMJsSran1cCEtmTuiOqZ2ygIbhgBV3pTKiArRVw
	gubLhKX/+k1+42eThG5Pq++A7IdIAgFxgIzlUwnre5JSIPCnJWmyxsCk8Tv85y9+
	+hULlrwBYPxjFsNMhSremutNfwTm07m7UgydUDqLle73k0VCubY28tlGGhY6ejHB
	BmcCXwOCZ/bOd3R1KFZ+kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792042087; x=
	1792128487; bh=0ghyDKMXmEExwsVfJPy58cteSU72iLaxI4c08UmKvLo=; b=d
	y3AgOfrd6IxxGyZDTZG0sD7WJk8/akq+s3aGrg0tHv+R5dPvMZasNuNa3Ga8eM1r
	MM5G6kXzm6beA8FHSkJ4T5JpqaTCZkuWEYoq2EPNIbvWrYtaH6wwS53n8CQ5Z2ls
	UNZuB0aeTclvov7/FZ5w26Ir55V/SC0o+w0hJ/ljCV+WQZbhT2njAXzuACkpgMq4
	aXrwdbj+OOrTD5d/oNqOtlMYBj2J+TYRwftprrCHlgJDkShbk10XkYz09q5PpvKh
	AHB+wMFP0B0kVDTU33FSgefGMmSAygQi4qxXjlR41Jg2U3ZvVezrpU+/Ugp+4I5L
	OzvNvhQTXPH+WvnjWveqg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792042087; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:qyTv9tUT+7x4r1H89EhaTBZD9iPJ3Tdiyp8MQKUsKpoNIJo
	knO9U0ggwHmTbfDN6jbRo1uL5isIGqaNBEeHPFbwGAOxGcsBxhHMhD2oNuEER/k9
	SnH2/4U1/uit2v2pYGIlVJ1uL+0VrV5wDSrw2767FzQOfJufS5R3XT3ErfXFO5jv
	8hASovVy77Wd8qssBonGnfAOdr+WEcfQ2NxJZvrTyqWa2SvYDL7u1eYyKAHukU+n
	t/cxHwRd06Wyh/sSMH+ciz3hX9A6W8SOdf2rCh+nlCWlm0GADagyFjYIVw30lR5B
	LK3/opbma+DOpqUWiTZ4+4LkaV2COvyg995Oh6w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/0kf7njLo7mGay/59p9Mgv2yQM9faOTjlU5m0L2McX4=:VeanuXu7RTIgOgyezx7JrfDHSF8nQDtejXGwQFLuzx8=;
X-ME-Sender: <xms:Z2TQavcPAKvVAjPx2WDpn_v13e1uSVXZNUgCtNRWe4eo1NUQNW4oyQ>
    <xme:Z2TQasGcP-LjdQFy1GQZ0WmMVFJO-Nr526G13mddFuiMYrFSgy5YJReUujGC_tF-a
    DC-qSYydOusTp8zW93Wb_un49J9HRlePyU7aebrRXocmKM_-knhguE>
X-ME-Received: <xmr:Z2TQag236f7XfEkVAP6UnCYZCcJhno6fEITWvlFpzg4y4vbG4wWc7v6Zsob9mJzjMSPyIRM>
X-ME-Proxy-Cause: dmFkZTEa9JLFP211LHCPYAkcBBzEFk1IhJ4kgxZx+xXJTLD0p3Ey6drVVWQQL5l2AdU40C
    Ac/CKiFIR0gvL9/mDakqsSAPTjkzbS8TdjwpghFe6st3LJKw0bvqDCWGmZk+tpLVzFgW6k
    LTxfDRjI75E80+A7aT42+66KrxDs9tRv9a7kBslu1G2DcutR7sMdUSJPx75otId12kNwzZ
    YQW2FwQKLs970Txkry9K7eJ7JQmy6JHi1RpoHkPyOsFTY361NNI0H/W7dfkG4RTaraEMDN
    4CQW2BcGOU9oJJeVo8k4+AgzYKTE5w+nmis45BGjp7iaV/ypNPjF12zEkbDmn78vjVHxtn
    3lKAKoTYNDCHcyDHb2MD5YrjyCGxMCOO5SQJw55Y61F7ZWZh1zGhz1nLPILGKhduZcDDe7
    XODsyMDX7PyqEKIvtDCCMe/9T32KOQVQV/eEuTdQr3+FhNtvVlDhHbRLLBaUUbhTgdfrGv
    2rV41tv9DzYu59IRaVRpEfLjS/wyRf9Tk68K+yhjMgf8EItxTBcHU3A2uBZu/+dskPiGQj
    cBkmh9iQI50PpRARBzCaAfgM/cGKVlFlk+p09XRHL8wJST6xMl2FhhMlJ514cjVqAgwWuK
    VLi2AR5wivg10FX7NxqF4ipSrwNe5icbP30h/bw9IwCSf9hihNuejqZbcfVA
X-ME-Proxy: <xmx:Z2TQasnIlQ8pKlOfXHRE3CAd8LE-WF8zOX-h73WuwnEEiXIX8heLVA>
    <xmx:Z2TQao_QjNGnWAm2cr8-a4QRLTq-N_dGlpls3EjzSqA8R2tAVrn_Ew>
    <xmx:Z2TQapqgJQY18HhsQj9AZyW5CjK98SprVkkaU7vIGZsMreS5mgiTTA>
    <xmx:Z2TQapkFgVyfQZcIU4_55zwhgGXA311JDd-EBFCzdA8C7PrAukzxqA>
    <xmx:Z2TQapDKwj8PAkp_Gto_b2a-DlzG_AXiEb1nI5Uygiw2Bfe6TTowZIS0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 01:28:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 67242eff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 05:28:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Oct 2026 07:27:57 +0200
Subject: [PATCH v3 3/6] odb/source-files: make the second read an
 implementation detail
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-pks-odb-files-alternates-cleanups-v3-3-bfc62fd780eb@pks.im>
References: <20261015-pks-odb-files-alternates-cleanups-v3-0-bfc62fd780eb@pks.im>
In-Reply-To: <20261015-pks-odb-files-alternates-cleanups-v3-0-bfc62fd780eb@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>, 
 Justin Tobler <jltobler@gmail.com>, Tyrie Vella <tyrielv@gmail.com>
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

