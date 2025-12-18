Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396621CC59
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 03:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766028945; cv=none; b=mEWp4CJJ+6d1gm4HgRZXI+wMc+l6nXxv9CX0FJjrOHdDKuyAUpjmPJTYgbJ5dDOYTT+tmB2MeleAwU9TCt2Z7tTqEMRIraqvXeL5XTS3NG4AJWC9qZGhtG/q/n5/ANrYFfWcnHCFLGHm/0pJcC+xwHNukO/flkRESfBII2A04ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766028945; c=relaxed/simple;
	bh=VcS3WGCBCmJKBMk6HZC2RLJRyfxMJcLpeTfnQWEf+Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M5YGT4v2YtcqPYVfs+Em+J5fU1SvTGBc/d8dydF85ClR31lrbcj++D0776Wy5oS5h5d1Gt1vRCdJRD4tNfv4dL7H51MHb5BFbH6OGq1KmkPutWvDQ77fzJB365goMPprszJM6/t8Gxn9YtXGcEUDLP6MOYIjqdNyvf4+WS1Z0Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MRMACu6h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BWfxIEqS; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MRMACu6h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BWfxIEqS"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D46E1400221;
	Wed, 17 Dec 2025 22:35:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 17 Dec 2025 22:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1766028942; x=1766115342; bh=Y4ZZ2IzwO3orBKTFZ2lposUkrMTsbDdP
	eeXPdTUFRNI=; b=MRMACu6hyE7EuoTEG4RAKNmh1YIliP7lZxUgC/3N7Ft99/MV
	wwXw5EL31rracn4pWt4QNGY32NcbLs8tC+qiY0Evqzce84SDd0JSGGZEHBR+yBp6
	cHOdfws0SXnYuTOLEkHWWYotNUHi3s1UnwXhPe9gBI8p2ODj7hKkxikBUP3VIuoE
	a+y3cknvXIdONcflucUJIKf5iaSNFFwIEao+LKy2OEojuYMWHnn610A0WGB6GEAG
	f93MlKoDRdfEA3uJJOp9/mdQTU75TDePgyStCLNP8zw2Jr1cY+2HSRSPu35L/Ueu
	seGZSNoVB1dkGdfS3SSYhfl2s1LNEn10Vze5ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766028942; x=
	1766115342; bh=Y4ZZ2IzwO3orBKTFZ2lposUkrMTsbDdPeeXPdTUFRNI=; b=B
	WfxIEqSOKYIYqRKJfmj4wCZpmJ/lz4+O6vMU3SGsC+TyNxYo+kerGvmJxWnxIuhk
	gDDDD9TR/2QAHqmA6AJCa3asT2pqLBTzR6u1JnswQMUQRw+gEFd6jKUxE6GpSRa4
	U35JOscgfCcxC11WPZtt/UTvs61BDakPnhqMoUi199TvcLFJ+r6DT7LExAPslAlP
	A9P+MHRNNIO2OnLXnYJdJRC9EZx5BtIvLtdcoirPpj+BRXRWtONyCroi96fj7R25
	0zJtkINKxjo8rCUgW+sebSW2PZsi89TqjLj5w9hHfIWP5/KaY/DyrwdkX26wu0J5
	68MPkrqPETuAdr3plmlTg==
X-ME-Sender: <xms:jnZDaZUXIA2VV3WLzEHCZvAeaT7_0IttrBQtFKkclHrinK-Hx_PM3Q>
    <xme:jnZDaQmpZMJaICaO0_YUcVZSWzWtUXJ1vEm_UeUgaUOCnCGeWOgivMGcQU6fjvaWa
    X5dv5NJEcUrsg1nrCYFYrlzyvXgIa2-mmyw6qonjhGHM1L0Va0SwQ>
X-ME-Received: <xmr:jnZDaaYc8ERd37DWAZUSVh5UeN-5YvGdZhqPXIeCCQVml9gpQLZRrX75E8kE9RwQXJ6D7MmqiqA2tZvs-nLZdmw3LNjcapADyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpefhveehledukeeiteehtddtveegvedujedvlefhgfduheetjeetfffhieetvdduhfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtoheprghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jnZDabNkIUpYdSgcK01FMYOdxUuzYLHH0wKwirz-GlWo4326Yqg1fw>
    <xmx:jnZDafbn9UwIMxPO3_igzCBKadEK_deYX3tvvnKHxQs55E-CIo8bkw>
    <xmx:jnZDaZ0VeSzRwscoQ-HYXto3um3RZoUmeerHag-VCX79YsF4b1TqPw>
    <xmx:jnZDaVdVoFM3hxShUNPOoRaxku2rRn8HccmhAY225fwiHEEBcbl3SA>
    <xmx:jnZDaS_xi4sDiBZ15sBiGx6YXPcLAkv-eu65aHv3ftCjS1Fy4-iA7hSM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 22:35:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, 
    Aaron Plattner <aplattner@nvidia.com>
Subject: [PATCH] odb: do not use "blank" substitute for NULL
Date: Thu, 18 Dec 2025 12:35:40 +0900
Message-ID: <xmqqpl8cxy0j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

When various *object_info() functions are given an extended object
info structure as NULL by a caller that does not want any details,
the code uses a file-scope static blank_oi to pass it down to the
helper functions they use, to avoid handling NULL specifically.

The ps/object-read-stream topic graduated to 'master' recently
however had a bug that assumed that two identically named file-scope
static variables in two functions are the same, which of course is
not the case.  This made "git commit" take 0.38 seconds to 1508
seconds in some case, as reported by Aaron Plattner here:

  https://lore.kernel.org/git/f4ba7e89-4717-4b36-921f-56537131fd69@nvidia.com/

We _could_ move the blank_oi variable to a global scope in BSS to
fix this regression, but explicitly handling the NULL is a much
safer fix.  It would also reduce the chance of errors that somebody
accidentally writes into blank_oi, making its contents dirty, which
potentially will make subsequent calls into the callpath misbehave.

By explicitly handling NULL input, we no longer have to worry about
it.

Reported-by: Aaron Plattner <aplattner@nvidia.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object-file.c |  8 ++++----
 odb.c         | 29 +++++++++++++----------------
 packfile.c    |  3 +--
 3 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/object-file.c b/object-file.c
index 12177a7dd7..e0cce3a62a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -426,7 +426,7 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 	unsigned long size_scratch;
 	enum object_type type_scratch;
 
-	if (oi->delta_base_oid)
+	if (oi && oi->delta_base_oid)
 		oidclr(oi->delta_base_oid, source->odb->repo->hash_algo);
 
 	/*
@@ -437,13 +437,13 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 	 * return value implicitly indicates whether the
 	 * object even exists.
 	 */
-	if (!oi->typep && !oi->sizep && !oi->contentp) {
+	if (!oi || (!oi->typep && !oi->sizep && !oi->contentp)) {
 		struct stat st;
-		if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK))
+		if ((!oi || !oi->disk_sizep) && (flags & OBJECT_INFO_QUICK))
 			return quick_has_loose(source->loose, oid) ? 0 : -1;
 		if (stat_loose_object(source->loose, oid, &st, &path) < 0)
 			return -1;
-		if (oi->disk_sizep)
+		if (oi && oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
 		return 0;
 	}
diff --git a/odb.c b/odb.c
index f4cbee4b04..85dc21b104 100644
--- a/odb.c
+++ b/odb.c
@@ -664,34 +664,31 @@ static int do_oid_object_info_extended(struct object_database *odb,
 				       const struct object_id *oid,
 				       struct object_info *oi, unsigned flags)
 {
-	static struct object_info blank_oi = OBJECT_INFO_INIT;
 	const struct cached_object *co;
 	const struct object_id *real = oid;
 	int already_retried = 0;
 
-
 	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
 		real = lookup_replace_object(odb->repo, oid);
 
 	if (is_null_oid(real))
 		return -1;
 
-	if (!oi)
-		oi = &blank_oi;
-
 	co = find_cached_object(odb, real);
 	if (co) {
-		if (oi->typep)
-			*(oi->typep) = co->type;
-		if (oi->sizep)
-			*(oi->sizep) = co->size;
-		if (oi->disk_sizep)
-			*(oi->disk_sizep) = 0;
-		if (oi->delta_base_oid)
-			oidclr(oi->delta_base_oid, odb->repo->hash_algo);
-		if (oi->contentp)
-			*oi->contentp = xmemdupz(co->buf, co->size);
-		oi->whence = OI_CACHED;
+		if (oi) {
+			if (oi->typep)
+				*(oi->typep) = co->type;
+			if (oi->sizep)
+				*(oi->sizep) = co->size;
+			if (oi->disk_sizep)
+				*(oi->disk_sizep) = 0;
+			if (oi->delta_base_oid)
+				oidclr(oi->delta_base_oid, odb->repo->hash_algo);
+			if (oi->contentp)
+				*oi->contentp = xmemdupz(co->buf, co->size);
+			oi->whence = OI_CACHED;
+		}
 		return 0;
 	}
 
diff --git a/packfile.c b/packfile.c
index 7a16aaa90d..2aa6135c3a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2095,7 +2095,6 @@ int packfile_store_read_object_info(struct packfile_store *store,
 				    struct object_info *oi,
 				    unsigned flags UNUSED)
 {
-	static struct object_info blank_oi = OBJECT_INFO_INIT;
 	struct pack_entry e;
 	int rtype;
 
@@ -2106,7 +2105,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	 * We know that the caller doesn't actually need the
 	 * information below, so return early.
 	 */
-	if (oi == &blank_oi)
+	if (!oi)
 		return 0;
 
 	rtype = packed_object_info(store->odb->repo, e.p, e.offset, oi);
-- 
2.52.0-448-g904c30f108

