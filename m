Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57773939A5
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877013; cv=none; b=fjVb5oUFpL8j/CRmM42odlxSvselRTp7FqU111znZ5/PIGqf2ZTq0jUrg+3aYX8ISYPmGlc0M9i0V05MC9j5ZEpVcVmVu82smbc7qjnFobMfAWKgrQUEeZNC//VWcAygi7vXVOLQfwYflifIKTC6XL8YUmzv+ubXcnxUAJNlpdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877013; c=relaxed/simple;
	bh=VeanuXu7RTIgOgyezx7JrfDHSF8nQDtejXGwQFLuzx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d8IBTd05Lv5dcyVVRRJ9bZvJ/t/nWHfVyrTBHN2f/TemkjVN0T0GALqBma80brfYFWRRTcUP980tBcU3Ix0StiP7HvaBpcJl7XwGhGGVF/sKBFzKLop4lJWRFj+4azUl8fMQ3RSKrars9BQ8QNrob8N0l4p1scEtSMQKJah1JCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WOaL6v61; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ilolmZKh; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WOaL6v61";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ilolmZKh"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0EC8DEC0347
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 03:36:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 13 Oct 2026 03:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791877010;
	 x=1791963410; bh=0ghyDKMXmEExwsVfJPy58cteSU72iLaxI4c08UmKvLo=; b=
	WOaL6v61x+EZoPws/TAikYcQJ9p0TSNsFJooOD+zBRsosCaCHL9BoN1kELFiHasB
	Z0nwWkStDk2HkaPBd6lmtVQ8sZlFYq2VZQavqip6eQ/tClnaZumVIbd0ZfmU1a9a
	orUJMzgJishkBNrjp8G8iyAV/p+EkxVt0GxbNw9BdBwFRS1/DoSCFPVuH7Ntml0v
	q2u6sHQXPSCWyIgj920+omySZh/OQAdEqbgd+8prQYVvz1fioyzmFehjw3Q92Dni
	9TUtpb52zfKAJvZeHvxVR4vVsSW6e/enHXnFVew3q2ExHq50/83BFipkQGrQaS2J
	B6xF5QIyQrugUvLsNRNqog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791877010; x=
	1791963410; bh=0ghyDKMXmEExwsVfJPy58cteSU72iLaxI4c08UmKvLo=; b=i
	lolmZKhNMmQfECAH28A7Sg7TO+FIlerVFlNxy7MNNEWbkfOyc8z3BeSG2wxP6kSH
	hIV9mHLQHjz1x6LUXDy0f9KOn+ptvLFgyhSNLmmlKMDwC26BO4m9QQbYVnfo28Sw
	1awqEuJeov1NKrxn3gVl66qL1l+u/IPhC/jbZnSPAEwfD8UjDe0njEBUCHCG8RJn
	utCWnhP+qgtP2Y6zoAWe7dSM9nuu9k6Jtf4mFO9/G4Us+nRh7oiGQ9OAr5e0tYYi
	nq2kmUueY4tTrxmxi+DKIawGEh+yEkGr6Zv1bd0ziASvoRLdropfWZnkjMnqcfup
	ziJOKXkhFMuWTSqz/uIig==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791877010; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:GnWHcmvr86yN1vB3x/fB3QaulJ8yIqK0lQrS3O7/ZwF3T9h
	hOiNba3OzDnKQIfMomCkR+W664M4MLnzAoUyoowB2fgUu+GeQs180GiBES4l5Nnw
	45qR4DqRBkLFsSceRQoLlRT4PXp5+m2h166thCZz4LRF+Ot1lcMsMGVh6sC5nFtp
	qEQbCYdQpSk6JDY3FFNrQmmV8HTylwpFLBbTjl5ybgScKParPhczdwHmsTD+BDhj
	ImiYOO/p8lvQIs/mgR5RsWccm96WBKiqnoUx7tuOSGZpPw3h7z1iJmiTvbDbLUmQ
	i+r1JszjKh/npvn+NABzb3Din8t3S34n7+s6Dwg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ypnNyWLXBNJ7hau3zkQDacUYEM+TcZ/P6GLoElHrjC8=:VeanuXu7RTIgOgyezx7JrfDHSF8nQDtejXGwQFLuzx8=;
X-ME-Sender: <xms:kd_NarxZ4Cgx9WwQfZN1Cfq9dAPezx7OQjh9KToQer-rZO7rRWoHrw>
    <xme:kd_NaqsUR2swrMBPabRXoo-MpzQJwzYhzMUHWuo9PYIMHlBlUIi4X0xrLAVhJ6Jo8
    SQZV0L7Iemj8zL1IQiDnnbxHjIzQX7lzQSfXMjln3DNC_Mp6fL_22Q>
X-ME-Received: <xmr:kd_Nait39xUaCSte58tZOKxea2pqX3fHbLnQZfJZj0QEC26WEfdBKg>
X-ME-Proxy-Cause: dmFkZTEFUVtx0m1gVgvNwfak4FvGqNwTOGPAovQRfkApREj2T7mxel/rrbDAojqhTaTULx
    av4CfVjP0KE1DOqoFDpaKjw8rpFImExzn183toIDOGLzFoICAzeDh7WoadDfFSos4NwGeq
    AVQGNMhic9Efyki9sto/FeW5OnRJESUaCCtb1BKIpS32JxZfRcJtch0K1zvGmmVaBbq56U
    gb1tLWfysaH/3Y2AgzcjOtJtBO+J/y8R3GpcKKeecMWvbAEV1gp3TL0CNpZgq2MlEs0/6Q
    r0IEitoKCMe9DwPsTW1OjN7IR/VgLutSFNc2wIrT7oWnh5s6MahxoSojtzP4nQ46RZLIh3
    HJZIANtFfh+B7H97QGZXPBIhxewvA793Zt+6f51ysFYMEngKhoss/IDCckAeQlDRpKlPzI
    jMRnrZzI9Hr/JFnTdatzHvpJCiDn3KW1zZdAmJEp8/B21dGwxKVIL7vALEsXYA2jV69vVw
    UnHjJIdf/XALyPF1P3KW1DYXwhtFSeBQ0DT4/rk6Cedi66jP3FzQ5JvrKfnoWjeO7lAEvy
    jJZI5GiGOoH4GYE0AccwRYjMIpewxo4cBjLKQO+ohMNVcssfhdTD3byQ7hHLATtW9puQnT
    d2QXRe0PtJiftBZwmIEvRG4U+WheJiN+2c68Q/hO0pHIm6PMdSA7fBaAiQLQ
X-ME-Proxy: <xmx:kd_NavPi3L0fn_4WayHP61GE0yeo6M26tuRH1bPoMvjYYP0IyiKncg>
    <xmx:kd_Nag1vWKcgxNNtrNtSZvI24_42H0NJrUe4jeaYh1hhWzhPooWJRg>
    <xmx:kd_NarN3-mS6MJQbE0X5ZfX-vyp_fywQbi0VZDaqLxDkr78hUc0DBA>
    <xmx:kd_Nag3TBgcoRz7CUyaNOrVuadkS128CbrSws8TklNBbIfr3uh7b1g>
    <xmx:kt_Nai-3S9wJ2Jxm1hhgPWYRvyFcNIs2pCF_WzzHBmARied9QS_upgIy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 03:36:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 198b7abb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Oct 2026 07:36:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 13 Oct 2026 09:36:27 +0200
Subject: [PATCH 3/5] odb/source-files: make the second read an
 implementation detail
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-pks-odb-files-alternates-cleanups-v1-3-b7030ff2b26f@pks.im>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
In-Reply-To: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>
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

