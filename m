Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED53CA487
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787212552; cv=none; b=uoyXG42s64gwcmecLH2gsL20iitJfEmfwOlrSKqBgaAeJFaAqvinYNGssobQF4nbi1VFxqchfubfSrNRlfgADqFEtxRbaayWQQ0PEZqg11RCYptpgiyendUhGvUB01HOm0jTW9EaSI7ULJouRsZXXKfXu0Ad50wgEQPchRV+Cg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787212552; c=relaxed/simple;
	bh=oNVhj+04r5QgWYtWlMBF3q3K020v2fGQTt18EusdNmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qiwfpaNjRkaXAkrl+D9z0uDbHMUBVQauyCEYbVLGGzmgq/aelmMNBux7pJEKH+CEZ5Rq/K7ozKyKH19l8ANIfdqd74sCbTxjC1NH3BLJCy4Av8r5xLvMfYrZ1rehaaFV3/oOIH18DtJZwZdwtC3MLpGkRCLLosp9YzAd+tAM4G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SqzteXwQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eaJVAGan; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SqzteXwQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eaJVAGan"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id ABABAEC01B2;
	Thu, 20 Aug 2026 03:55:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 20 Aug 2026 03:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787212549;
	 x=1787298949; bh=cn53tK2EQgqX+GtA8ytcyMXLOdXZzK0sPTPiFV/gO74=; b=
	SqzteXwQCVoy4gIcbhH0nUrAUTOq7Xe6QBP9/hc7+OJDwuYPm2PZykM0OxEyB6St
	f5LZWXgvqwSjOA7uLzt0nXCRkqSwex5f90FEaU7uDjQNUhEB+uAzzKa+9ke/AgUL
	X1J7GCviCE2sphx0+2GwsOp4dDoV8q+M4WeAVJqdIZMrywaxQ6QoMmGD206rwn5J
	KWW+sOh/SsuWE6PtBtV9gf4nW/+NUvyx/86VkV7vXHD8Fn5fSKAjYUNzSoHfrQVv
	qv+LfaVHQmb/WxA8juAzN9JucWfNh83nvFAHgI4xND+qY1Y0MAgr6dP11RZmJ8JB
	rvqkhfowtbDW9sNB0ty7hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787212549; x=
	1787298949; bh=cn53tK2EQgqX+GtA8ytcyMXLOdXZzK0sPTPiFV/gO74=; b=e
	aJVAGanscKe3L4tzCAg3yaN020jP8tTO764IeOiIJBIsDxm87wA7k2vGmNAy84fm
	sCypz+9hdQCMhNOxhCJ7BVbSI9owhLSKUDhzrpj5+mbhb2PjrtCvMzyCgyI9z79P
	92i9osExChVohwwjC11Sig0KSqq97bVna5J9JcPqvPCA96IAEavlCoBowC/NjUYC
	fQZn9rB/YaRzw+LXLQUHqmAln99O0gHz4JLGD8Y1xwEgjGrM1U8rK9cHtgilAkuf
	WcF4sYurW9ugKR4gRkxQkqLQrXsGxEzKALLFPk+uADBm2f8dgHskon/NZ5oe8mEm
	nQzPwsquG34syfSxwmgVQ==
X-ME-Sender: <xms:BbOGapfd5KSQYsHvd3YhVwdOPYPna2MVaz6V4bursh0Tsm5QzHS7iw>
    <xme:BbOGauPD6nDYBoVxMtrfyfiWYsiBCRQpxKPlJAz3SB8AFt4vleqccp7Z4n7XfZrFv
    qXKSGRcY6nt4-8y9_e21N0vCjd-mwy_zGN0GZA0ShghXF5hKmfbZQ>
X-ME-Received: <xmr:BbOGanhnId3OTQ5UsxxZ_YqScbnOlJKgxNU1YwFMbaFg6M60NEm4ZjoxmbvU7a4GBbp6yjMKZKrBmD8yP1Pl2uL5BCccuhvcj1DjSuR1Zw>
X-ME-Proxy-Cause: dmFkZTFf6dj8/8V1XaAc7B1kVMFZTKvMbAEygAXbbhBXRMoJE0Q/MsehWCz6Zsr3VItoGJ
    sSOYPjnsDlfrh3lzEARCv0NJnfuJQJusLASMKcwM9uC/Tbs/YIBauNX4V2AuW+yb3o66jM
    JzMl+gjCx01/1zMiYhH+kC59/ghsfTubikmfaAxgUR/millS0tlPNpkYgp4jFToJY+LVEk
    c6s4D4aztX2xzEJ3LDQqGoLTd3S6W+Hcma/glCPpKbDpT9Cmp60wceni6gyM3ckjl3Tvge
    oRcfTlFV6iALm7ps8/b3emKy+rfSopq+d7NQ4EYMi/B5tNUxYa1zjgIENCda7YAb8HlkXH
    ms3D+tucSQKjSNvW9oMkswfseCdnE0gArzFfRZPVuLupioEZAb3mfQoC32zehNgeDPm7W/
    Bmp7YEF6LwVweyvK6SicqwNwfg+/hzu0wU/uq2R84IQiWUDwyHQACj9VOthFWuuN1RqD5U
    AZQQdbkVCPHnVS07URJOBVMREk2ruzRO37kEAhF/25Y1eCzp1xJ8phkITdEje+vzmE5I+S
    Zv/5hp6T3aucJ84764DgZwyU85rvYQqT1+mfLZQ5YOiZmGBNu0alIJHJV2MtMYjM4933xD
    c1QuKkWsGYo0tf9fIa6PMTdn/Hxq/u1GjFMIab/0bdXs3hf38aZJ73Gy47rQ
X-ME-Proxy: <xmx:BbOGah3s7nWYJpIpi9jSfpywPn38j1Ncrdp3jI_M324acVbswdhtjQ>
    <xmx:BbOGahjM2VzTNGX1afdoeaJbq0rfNU9qVyjeoUvfO1l9NZKcyl2lLw>
    <xmx:BbOGahfEz3otN7jRZiAg75yASOwWt1t4XdMf_Ka26h_O-09_rijNVg>
    <xmx:BbOGakk7wjO3BsoLNl84WFlR_Jp_0xPmQlRUXg08_mITR2tPlU1IRQ>
    <xmx:BbOGarCTS2YITwK7nn2hf1_0SkidDWk1B8th2jA2HAtnBsyRB2EWx36M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 03:55:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b22b4f15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 07:55:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Aug 2026 09:55:29 +0200
Subject: [PATCH v3 5/6] bundle: get (mostly) rid of `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-b4-pks-odb-generate-pack-v3-5-bc42252f6169@pks.im>
References: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
In-Reply-To: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
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
2.55.0.822.g20453c30eb.dirty

