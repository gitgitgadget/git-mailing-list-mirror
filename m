Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2204156EB
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787293823; cv=none; b=dR4VYxJ06fRBqZuEfiFtyRrApJqFUk8lAKouJ7Hnt4Z6iAj0kr6Rq5kZkO9ME39gahqJXS9wzKrbSmf3qJgmBhqMjdufGcSYSQ9PiaxK0GHH7TkG4qYaefop3zkjU6rDnLip268fzvHoXlEfIGRsLD5aWXRLuJVY+UPSrw+sCus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787293823; c=relaxed/simple;
	bh=oNVhj+04r5QgWYtWlMBF3q3K020v2fGQTt18EusdNmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YvICK0puV301Q7ppyDx3x8DXBLm2EJ5OoNAkO1ZiB5trV+zQomJkNVQltbMe6NDHVwwUWfV0jWvaXQMRcyTAmJjzzsWNiqyUf+mEIT/3eIz4DKztw5Y71aPLWLE8uyLfo9pJQsiMTAaLO/TPvm4rOCFWr/52pygSiCIxQP/t7lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fkVU5HYe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lE2zcFKo; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fkVU5HYe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lE2zcFKo"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8BEA8EC02A8;
	Fri, 21 Aug 2026 02:30:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 21 Aug 2026 02:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787293821;
	 x=1787380221; bh=cn53tK2EQgqX+GtA8ytcyMXLOdXZzK0sPTPiFV/gO74=; b=
	fkVU5HYeVHHTr88VFtbBlmZX1SDXhSb+x7h1nZ8Xv9LI4rgiCZmsjzZd9l1+oxlL
	iCKSps8u9lDjgN+wtVAgGL1MFkC2cOpUnM3d4mseLs1C9l2d55MdSMl/wbAkacva
	82TFXqh4l+CfJXX/SitG1zVtnH6He/qG68Eu3zqVJJZP9S6TGCuI0iGrourm3jhy
	qZp/znnCHWWXqEzVG4dd+UFF9yNPJIItGiyvfOQ+p8BbWMZ2YJWs+k/drMZ6/jjL
	sH2TaoDaZE2g0gLYnLYw0b28MCmXxnkdY4B8QzgE5havCNnWWoraVTMo3wttXY89
	vqFjH2Pemb7gqhc3EksjlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787293821; x=
	1787380221; bh=cn53tK2EQgqX+GtA8ytcyMXLOdXZzK0sPTPiFV/gO74=; b=l
	E2zcFKoOx8qdRWn8svWwLATO5Ym4r2aKkjZ/NuXQKNNYJI+lcE+GCjx6sPkLQ8fT
	3/v+9XjxsR3Qn4kxYC6VwVcyQOLnBbpk5lU042kYaXNAxrwivmjpQ/EuQv6s81sF
	k+AsrTk4MYMbNX1HoeKfrSqo9zwr0kj47fDH+5LEfwP8bVD5Ejr/LU6kYD9C+Hdb
	ImLfEFtRGEtRnwP9hdj4Um9wmO/gOzScx9ioLEP6WQTpI0O3OZN09CpFUvm0ZQlY
	UjUnJ84rPIdTrx15vsqUvoN8AA4GXs3prY4I6n1NhSK0ukeQ8/N3IYUUOasxQjPQ
	9l4bugBcbrX5EssAM7VMw==
X-ME-Sender: <xms:ffCHaoRN5T3gEtfTndblNF3rNms3X1QXDxDDBd8Imdm2HAmnrRK6Yg>
    <xme:ffCHasp_I2dqy-tJl4eUJ48RzDWU28QXdVNelLpW0qfb5CmVOjOMlx8Mjfc53ooRi
    aKSjS7v3_imhsAP0Avl4HUxC9Zke5xRM0BjyXoeV4I1YetUgw-dYMg>
X-ME-Received: <xmr:ffCHauJ3N2wmGUmKvcqzOnMd_ySdzlzpfsHboGKJ_Y6adZzeMEz0lt1YfQ3HCuTtjiOZey3xm6YMNzI4WWvrhVWfjFiDlk0IuPF66WGB0oBn>
X-ME-Proxy-Cause: dmFkZTGvGr7AfD8DCnwMaod+pFuPIsXtrfEPPcql2hViDk1ZB8UQGHOuXDkGbeRxx2570l
    cRxGSWWWMovYlUT44fOZtzhNuR2uyD1biL8STN/BNnE9CfvJalG+92PvRA5Rf5iSe1mIQp
    rQDnz14/uoDmFci+eTs3zjZowpnDp9o/yN2BM5n46dTwTmCzgXr3dk5OdMbE9RmJ5o+Srm
    Fd7KdtJ89qrpxh6A/yke8ZFpXrtJo/ItD9nlo9XiiDqbg2xEI+4gp82nM6vzDGnM4fkm9p
    69ZV+W2vom486+Rw7nic5ewj1j03AB4c4xKwZ8M1/tlzf/fE/UHatBuW2LwjNnelus2UfD
    WPNgPkUoe44meY0RvZ6WIM3/+n1jdO5MiGlpOF7j+7WpLNJoToAKifsn3+W9FfwyBgEFbq
    jr26vHn8mMQQmjCWSUXU1iH30vwi9Lb7gMqLua/qJMJ6TELbIKuRqEk04C48tXGoeP0Uho
    Z+Z3LcdDcMxT+/mw2TBgTVkrpIF0ViGjBpQe/S2VKhv2nu1lLa9vmJsm4G82v3zOvPbl/p
    d8fiki1djQcYQ+HK7dKOThbvt1STB0ToBNaD/WMZuCMJAiwFDIRBp6wenW8DXcldouEH4N
    bDXA6q5UF/cm5tORiNYZlS65VrcUxRszh/ieoqoY4rlzadTi+mpvEjH9OhXA
X-ME-Proxy: <xmx:ffCHanpBTO-9AHf5xWxiN6NxCONcJSF0l0IPnYRKmaRADpmtGtx4fg>
    <xmx:ffCHauw52cMuGB_LOuXgpFAGieTN65dWbHzHyJRC2950iq5Zy9yKug>
    <xmx:ffCHajMLFJ8ekopZwWnmJTInxxJfvEB0QHmMgyMsnwSh8nZBvnByAA>
    <xmx:ffCHar7e1aCkWPWF5oNn3HUsVKK0HHydUCHifK8N0ZJuRPV5rGxMgA>
    <xmx:ffCHai6AA0qUKZN2h8WQ3t9E3u7yfCihNOnKjKMqkz-nvwCiAm1GJBf2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 02:30:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 47751d36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 06:30:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Aug 2026 08:30:05 +0200
Subject: [PATCH v4 5/6] bundle: get (mostly) rid of `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-b4-pks-odb-generate-pack-v4-5-074e8bd641f8@pks.im>
References: <20260821-b4-pks-odb-generate-pack-v4-0-074e8bd641f8@pks.im>
In-Reply-To: <20260821-b4-pks-odb-generate-pack-v4-0-074e8bd641f8@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>
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

