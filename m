Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05767390C94
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 05:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786945205; cv=none; b=ipr7AXYZJpsHtXVvts1uRL+MzQFccKv8P0Kb1A4ZmRYMByd4pBPhZFI4hH0BYHXoYXvOnVfRohXUEn9Gj+lz7qkZYen9XcDFyBoDALfdx+pUsHjmlSAhMJXpNgsrjlNFpb8TiwXwdc8YvXtg83VHkIChOKb7AF4XXOakJvu0C8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786945205; c=relaxed/simple;
	bh=iPStTzAj7Y6I4Eh6v77zlRhbj54revAl3qKBsMEwYk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=el8x+Nrq46oe2bPxohbm8s6YofTZm5RmLutgXCw/m4+V7JKQL/HW54N7RiTt4h6mBymcb/MGQAsF0RCjsM3OsKnbbOofjqOuP4Ih0B57g3LTxOOhdZJJRNewasr/dR03ABWVSDcUrsz1f40hidqCar95/cvcyiNY8cRt7pjPlbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WQdLVDBp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HTxluVn5; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WQdLVDBp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HTxluVn5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5EF727A0112;
	Mon, 17 Aug 2026 01:40:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 17 Aug 2026 01:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786945203;
	 x=1787031603; bh=nfF1yzJJ6Ah6qOf5U6FBBnFgmQcqlFMd2gRYKNTm8Z0=; b=
	WQdLVDBpCwfi/UCtEvbQM+TyKSM+5UA68KG7PDu2MVTINMbZhpFq86EAJ4dH+rQY
	ZoOBoy4DAlpZgtXq5MDyJAVJkcTuOHBeQroK7DOo6ozXVD+8+MzyAPj/qLcu/5a+
	Mu7RmAfYhmJs1pH4bpri+FAC4gfkw9PNxFWNJDc4EUbAw+2CUrBP5f3RkimMTWR2
	9Zle8cVdWO3bYYOQ5ukCvw6rfCpG+auQDsH2mbl4aMTbDzAoKnHavQcA6Ffb6Ejr
	GRNTkKd6d0XskAzECTP81jQhg0vkLcDJnlgHVX2r5gy+vqGSAcaLhhbjTBk6gdjX
	MUowlc9oBPLNUN55IbbP+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786945203; x=
	1787031603; bh=nfF1yzJJ6Ah6qOf5U6FBBnFgmQcqlFMd2gRYKNTm8Z0=; b=H
	TxluVn5XKJAJwj2fIZf+hMsKHooKVPvLQAdG+vo3qQGyuPblbWRrlL49IxzkvfU7
	yxy8lRWuCFsK+r+t2Wt1haoF7ArABvzKjJ+RQrX0ksrY+qtHG0FTyxWi7LgMPB/z
	Xj5VGgnQO6RJLpoiBq4hSUjOC5kH3N4l4NH+gyvOFSPhihEs6tstbRxoy0+yWU5L
	U+tnk/rbHrqbldtNw1k+CG5byyALbTcH8EWpLAMG88+tuh4NiK1pgRGdUj+uL43q
	9OgylqZdwJV3T2N0IAKgfeOpskR4CXksHFI6Oc3sOeOtwPGyboWTy9N1FN0ZdNoK
	G+WwBgz+byNe/rOaqVCcA==
X-ME-Sender: <xms:s56CasBBi72QaFLFIVDNSOXTsRft54p2MWbLoYYoqsgUAoWi27oKJQ>
    <xme:s56Cakge8caVYbdLVOjUNX-KQ_xJeqFEkUcMMIqFPeRh1VeLllG_ISUw9oBKv8A4n
    KihLH9tZf7JnqA5Kc-b4EKm2Ozhlcrhz4IjQFAIL_5wuGLEkeL8Pg>
X-ME-Received: <xmr:s56CatOKh-RhQHp1jagvwBpNFYOcLS8wLoGmc1dcbp_1k8IchvI_QH4wmUEj6VeFvphiQ_zZgv11VN5p5YUDCS58xpTuWK2AoImg4SKedQ>
X-ME-Proxy-Cause: dmFkZTGeW2cWtTe/0/3Egi22CTLp68JooedKlwx9wvNRYWgu7LtDWjl27d5XG7KxA9foX8
    y3SrYbOioGyWkip5HgOpZXXyaSORil/GN/TI5+pucRL2EKt8MfXDsIhvcU2vuKYZkFfWB4
    okxQTCBRr3dGe41c5J4TRrc9znaz/Fz1hkivdKjSsNnj01eF6YIpzuB4gt5ncdRF0LMHxy
    6A3HvidyMfsWwJHME2oacrCuP783Kql1R/XI0+u6MDrG47z6fN5MwqpIYFYYb14aMgaRxQ
    GB696gYCcKSfNnA6pqmwfQqPiyBmLt+XvazC3ugIb9ME4CfT+t5N/jtfRTkC2FU4rXXmJF
    NWLdndc19YeWXmM9J4sAumCXAF6UWaCfyh+aCZEUkJjtCbX2/QahRstTwxlL8MIQAHwFiQ
    7tuEAsantS7nm5nbWR9zPYDQCXXP28C5/QrkSPdmIxX/rXm7vCSLqHd2gir3x2BgIMBcsD
    +Sj5k2Tig8LBME1UW9czLu5O0CyQLZjam5QZm+ksFBkbbQFWjdlDDxiX1rQFXDL5MQFJII
    /GlVCL9sikRg2sIbHfH0jmrh2ORkm0iYzluhWHZIsnWQ2GwJLWqU/+tFWbXuvdnbRWycEc
    G7aadoaWRWcfmhKycDxcasVlMi2qGCiGnFeOi9nSGs8LsIkNg87ocZciDoOA
X-ME-Proxy: <xmx:s56Cat72zTBWw9WBbXh5DjGAiJGR98Jb9fFtOWDEizTC2_FqwNYflQ>
    <xmx:s56Caj0O7NWNfK7nSBrN3vYBOdKktG20XJXifECOrH8tqjJDH7-pTw>
    <xmx:s56CambJIM6oJbafI3t8j-Yz7djIYJ3U1xbPSg_9SDElZzLKXoYkJw>
    <xmx:s56CajAXhDIWX7RyAvNj_N_1PCinT1QL3PKF_MWWFBewt2KU4rXbOw>
    <xmx:s56CavYvZGlr49KytpJGmNTPjFxZ5yNJnYKTWLcvbng0OsTofeK-Xywp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 01:40:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f4f3983f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Aug 2026 05:40:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Aug 2026 07:39:46 +0200
Subject: [PATCH v2 5/6] bundle: get (mostly) rid of `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-b4-pks-odb-generate-pack-v2-5-4c8a96ccfdb3@pks.im>
References: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
In-Reply-To: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Refactor "bundle.c" so that we don't depend on `the_repository` anymore.
This conversion is trivial for most of the part, as we already have a
repository available in all calling conexts.

The only exception is that we use `get_log_output_encoding()`, which
implicitly depends on `the_repository`. Add an `extern` declaration for
this function so that we can drop `USE_THE_REPOSITORY_VARIABLE` and not
accidentally introduce more uses of `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bundle.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/bundle.c b/bundle.c
index b64716f252..a9330bf0d3 100644
--- a/bundle.c
+++ b/bundle.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -21,6 +20,13 @@
 #include "connected.h"
 #include "write-or-die.h"
 
+/*
+ * NEEDSWORK: this function implicitly depends on `the_repository` and is not
+ * available because we dropped USE_THE_REPOSITORY_VARIABLE. We can remove the
+ * declaration once it's accessible via `repo_config_values`.
+ */
+extern const char *get_log_output_encoding(void);
+
 static const char v2_bundle_signature[] = "# v2 git bundle\n";
 static const char v3_bundle_signature[] = "# v3 git bundle\n";
 static struct {
@@ -294,7 +300,8 @@ int list_bundle_refs(struct bundle_header *header, int argc, const char **argv)
 	return list_refs(&header->references, argc, argv);
 }
 
-static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
+static int is_tag_in_date_range(struct repository *repo,
+				struct object *tag, struct rev_info *revs)
 {
 	size_t size;
 	enum object_type type;
@@ -305,7 +312,7 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 	if (revs->max_age == -1 && revs->min_age == -1)
 		goto out;
 
-	buf = odb_read_object(the_repository->objects, &tag->oid, &type, &size);
+	buf = odb_read_object(repo->objects, &tag->oid, &type, &size);
 	if (!buf)
 		goto out;
 	line = memmem(buf, size, "\ntagger ", 8);
@@ -362,7 +369,8 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *
 		struct object *object = revs->pending.objects[i].item;
 		if (object->flags & UNINTERESTING)
 			write_or_die(pack_objects.in, "^", 1);
-		write_or_die(pack_objects.in, oid_to_hex(&object->oid), the_hash_algo->hexsz);
+		write_or_die(pack_objects.in, oid_to_hex(&object->oid),
+			     revs->repo->hash_algo->hexsz);
 		write_or_die(pack_objects.in, "\n", 1);
 	}
 	close(pack_objects.in);
@@ -395,10 +403,10 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 
 		if (e->item->flags & UNINTERESTING)
 			continue;
-		if (repo_dwim_ref(the_repository, e->name, strlen(e->name),
+		if (repo_dwim_ref(revs->repo, e->name, strlen(e->name),
 				  &oid, &ref, 0) != 1)
 			goto skip_write_ref;
-		if (refs_read_ref_full(get_main_ref_store(the_repository), e->name, RESOLVE_REF_READING, &oid, &flag))
+		if (refs_read_ref_full(get_main_ref_store(revs->repo), e->name, RESOLVE_REF_READING, &oid, &flag))
 			flag = 0;
 		display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
 
@@ -406,7 +414,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 			goto skip_write_ref;
 
 		if (e->item->type == OBJ_TAG &&
-				!is_tag_in_date_range(e->item, revs)) {
+				!is_tag_in_date_range(revs->repo, e->item, revs)) {
 			e->item->flags |= UNINTERESTING;
 			goto skip_write_ref;
 		}
@@ -428,7 +436,8 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 
 		ref_count++;
 		strset_add(&objects, display_ref);
-		write_or_die(bundle_fd, oid_to_hex(&e->item->oid), the_hash_algo->hexsz);
+		write_or_die(bundle_fd, oid_to_hex(&e->item->oid),
+			     revs->repo->hash_algo->hexsz);
 		write_or_die(bundle_fd, " ", 1);
 		write_or_die(bundle_fd, display_ref, strlen(display_ref));
 		write_or_die(bundle_fd, "\n", 1);
@@ -507,7 +516,7 @@ int create_bundle(struct repository *r, const char *path,
 	 *    SHA1.
 	 * 2. @filter is required because we parsed an object filter.
 	 */
-	if (the_hash_algo != &hash_algos[GIT_HASH_SHA1_LEGACY] || revs.filter.choice)
+	if (r->hash_algo != &hash_algos[GIT_HASH_SHA1_LEGACY] || revs.filter.choice)
 		min_version = 3;
 
 	if (argc > 1) {
@@ -528,14 +537,15 @@ int create_bundle(struct repository *r, const char *path,
 	if (version < 2 || version > 3) {
 		die(_("unsupported bundle version %d"), version);
 	} else if (version < min_version) {
-		die(_("cannot write bundle version %d with algorithm %s"), version, the_hash_algo->name);
+		die(_("cannot write bundle version %d with algorithm %s"), version,
+		    r->hash_algo->name);
 	} else if (version == 2) {
 		write_or_die(bundle_fd, v2_bundle_signature, strlen(v2_bundle_signature));
 	} else {
 		const char *capability = "@object-format=";
 		write_or_die(bundle_fd, v3_bundle_signature, strlen(v3_bundle_signature));
 		write_or_die(bundle_fd, capability, strlen(capability));
-		write_or_die(bundle_fd, the_hash_algo->name, strlen(the_hash_algo->name));
+		write_or_die(bundle_fd, r->hash_algo->name, strlen(r->hash_algo->name));
 		write_or_die(bundle_fd, "\n", 1);
 
 		if (revs.filter.choice) {

-- 
2.55.0.739.g4f2b995119.dirty

