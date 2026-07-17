Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017173C3432
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280760; cv=none; b=btAps+hYMUAz/rk21hovXqavCnSCMVbqZ0Mu9IZr/jXpSqYS6JvEY1H+Te9uFEvj1tect49eFvYtAD1x8F/3w6ES85/KsrPGTUk0GyjtLUyS8ao44GwhWCvAA0YFiDHvYY/d613kgaxzXh648e2LV1rZXovLoy0dR+wlpNFm9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280760; c=relaxed/simple;
	bh=YKGHazYNgUeEJP9uzOXkhNlpbjloRUevbZvRGFN8Akw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQRyVKUGwPF7Y5ABSHX27glDvSFMWEcGZ2QN2jXj8aX5fRT4S5jA8wNBXUedUG0bPVMmZGAY0MS3ffzDziyLCszOrg/6hMrwKIMOV+09ztkwuf3fwSWwYd5/ty9AeZv4RRtqGMJQHfRR2Zi1mRzWyRTRXsT+aOenk0gX/+JaEXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jN9K3wli; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QIGPO44f; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jN9K3wli";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QIGPO44f"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5CE5F1D000C5;
	Fri, 17 Jul 2026 05:32:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 05:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784280758;
	 x=1784367158; bh=565NzVobf488RTdCqu+UWVr7Fx6fN9aVNgVq14U69vg=; b=
	jN9K3wli6Op1UPYiDf87wbbZwD3e0wIpTOXy4j6j4w29BAVHvHD/vW35JRBEj1M8
	TZ/kc0GjFA8JoDJdr6nG9Blbn0NIpvdnWuBDvnrtKJd/NTQqyO/3/hLs8yvIacFL
	A1qO3ntcNLMxsLG1b/Zus99BxqHqTPNOCRVPb1n03qk8Nse9dhhO0EsepVpvRa+r
	4Hrmh/c83N3pHMUbhnA4/IRDe9km4ZNTZjynWjEXJCXPDPbedLjBHw/5xBFovjhK
	oC+Jxh2glQ+uoLtzhGmYtR6pfqqwMmyEUiLhvNNS9hSRvhGZtj7R77hGDvVmeRLb
	DKMv1X/7kHIl4YWV7eFC4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784280758; x=
	1784367158; bh=565NzVobf488RTdCqu+UWVr7Fx6fN9aVNgVq14U69vg=; b=Q
	IGPO44fsjqQ2rK3jOmnLFhuiOiz3sjhitoj7ymrbrm/d6+KAypgob2YZ/J8rVtFa
	MyzyIdJiR5wA6lzypzqt8c8fiI2v8cisAojA/S9G4h1V1LHd/sBX3n7UDnOiQIwD
	Q31GjdY84Fo1P2pYMPwUbs7oa7IWTs/xUPNHjgzjtDp5Ul9xpP9O7B5rD/ao9tmQ
	9AUgsMMznpHYfmVmcdL1+yvyxnuRYGXZcWKNfUWp9yEl6v5IgIhGZWKj7K+mFhmA
	L16QiZpdxrfTP7kZ8hFzgDY4lvLkpKxpquWJ5wooTotfiO8ayH6YYgL44Sq10qvW
	8WffrDviUEF6oVcAv41/w==
X-ME-Sender: <xms:tvZZagZCAhs_3yn3UW7ow1sN0BjkhY7G4y24CbgdgB-OxpinBpRlRA>
    <xme:tvZZahYgY3GUzIccsVxkYeh1NtKrBjSOnPiCLwDqkRaSneqVJZHRHEOFnbzpk0ath
    41VL27nSLz869VxbC9_e3C1KtzL1JzdwzNsCoBaIu9SVwJzpLEgOWY>
X-ME-Received: <xmr:tvZZaoljmTK9L4NskRKHwOjOdfc9wQAEvqAY2KAfRxy8z7JAbRBDCYZK49NWTcCvuu8LjgmirOMQNCh2SbZfN7turzVopXv_RjFEsppb2uA>
X-ME-Proxy-Cause: dmFkZTGAjh6BdWTVqzaF88ulSCJquC6NOw6UUiO5I72vQ7mX8nWiEoDJbWlq0hEowNH1uO
    uBFO8VfJQrynzcRjMT9GhHw/ZWT0uVwl10dcEAYtRLejcG9k/wmtZHume01VNzEvqrewa4
    m/rIFh+MJUiNxD6zxJBr4cyTELl4kuW08CHtpvIuz93Chp1Dbb7L4pk4WQh31wMnmH3rkm
    KrWv1Gv4zneQjloLU00vcvWSQSG2wAQAHQVdUOqxte9aTMMQFflkzrWiuu1Zzwk2WNGCO0
    hJILUEA0xlv8JRDswWZgg9JThdx4qSWdp9P6dWJfQ4IjEbWh7alHDyMNEQmlbV/oGKv0R+
    tXfjm4QIsZZLpP47Wl2QhPWGcjuh1FYXWUxg1j36UNJKl6Uic/mU5M28lmWj8FZfzEpTAV
    6nuU0deG3io+9VYgj5xppb/x0kyug6c9Pzqde33Z/DlvwTUp1LPnhVzfdRGNdkdEUc0GXR
    yv8fT8qBVo4+tDRqg/5Q8L9UfQrueauXYWOrk0vKKmPbgy7Rphv9bSBtLsZaD7UzW4W0nP
    7J1p88L9lVgG8vTzuCwj7k3w9xp5LkbQZtwBB7+B8z1YYho8DZ5BIXiBzNQz3DdcjYsUZK
    idQpRMVNfsd4mlBrfIXJRkSF7ZzIuTXUH10npOFR1/QAzdCvGC/RyzUHdtKw
X-ME-Proxy: <xmx:tvZZalzA4hIsQ1jiLfFf9ejOCpkgmQV6NVA1wDmn6NjWzJ4pRTtRuQ>
    <xmx:tvZZauMM9cnKRozW3XcNmuXpirxDYoIMUqk3ukovHPVrqVYUyQehfw>
    <xmx:tvZZahRaxn8U7xaTaGyYAR4p4TCXtWK8IZMGkOzz3qWOGjCBbL5n4Q>
    <xmx:tvZZakYFZ9pghihkXmYTC6iI7wRjh-hC91HRMmky5Z9Ckk8WRDQ-gw>
    <xmx:tvZZamJtHzCgIhKnX-KUCdyQfthSbsP0DugSp2welkD9BEJpoNPL7Jsl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 05:32:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c7f10448 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jul 2026 09:32:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Jul 2026 11:32:16 +0200
Subject: [PATCH 8/9] object-file: move `force_object_loose()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-pks-odb-move-loose-object-writing-v1-8-46446a3cb5b7@pks.im>
References: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
In-Reply-To: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

In the preceding commits we have refactored `force_object_loose()` to
not call internal functions anymore for writing the object. Instead, it
now only uses generic functions that are accessible to all callers.

Consequently, we can now easily move the function to its only caller,
which is git-pack-objects(1). Do so.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 object-file.c          | 44 --------------------------------------------
 object-file.h          |  4 ----
 3 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e64a96f1a7..bb3bc486e8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -32,6 +32,7 @@
 #include "list.h"
 #include "packfile.h"
 #include "object-file.h"
+#include "object-file-convert.h"
 #include "odb.h"
 #include "odb/streaming.h"
 #include "replace-object.h"
@@ -4622,6 +4623,51 @@ static int loosened_object_can_be_discarded(const struct object_id *oid,
 	return 1;
 }
 
+static int force_object_loose(struct odb_source *source,
+			      const struct object_id *oid,
+			      const time_t *mtime)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
+	struct object_info oi = OBJECT_INFO_INIT;
+	struct object_id compat_oid, *compat_oid_p = NULL;
+	enum object_type type;
+	void *buf = NULL;
+	size_t len;
+	int ret;
+
+	for (struct odb_source *s = source->odb->sources; s; s = s->next) {
+		struct odb_source_files *files = odb_source_files_downcast(s);
+		if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0))
+			return 0;
+	}
+
+	oi.typep = &type;
+	oi.sizep = &len;
+	oi.contentp = &buf;
+	if (odb_read_object_info_extended(source->odb, oid, &oi, 0)) {
+		ret = error(_("cannot read object for %s"), oid_to_hex(oid));
+		goto out;
+	}
+
+	if (compat) {
+		if (repo_oid_to_algop(source->odb->repo, oid, compat, &compat_oid)) {
+			ret = error(_("cannot map object %s to %s"),
+				    oid_to_hex(oid), compat->name);
+			goto out;
+		}
+
+		compat_oid_p = &compat_oid;
+	}
+
+	ret = odb_source_write_object(&files->loose->base, buf, len, type, oid,
+				      compat_oid_p, mtime, 0);
+
+out:
+	free(buf);
+	return ret;
+}
+
 static void loosen_unused_packed_objects(void)
 {
 	struct packed_git *p;
diff --git a/object-file.c b/object-file.c
index 89825feed0..b867d8d9de 100644
--- a/object-file.c
+++ b/object-file.c
@@ -893,50 +893,6 @@ int odb_source_loose_write_stream(struct odb_source_loose *loose,
 	return err;
 }
 
-int force_object_loose(struct odb_source *source,
-		       const struct object_id *oid, const time_t *mtime)
-{
-	struct odb_source_files *files = odb_source_files_downcast(source);
-	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
-	struct object_info oi = OBJECT_INFO_INIT;
-	struct object_id compat_oid, *compat_oid_p = NULL;
-	enum object_type type;
-	void *buf = NULL;
-	size_t len;
-	int ret;
-
-	for (struct odb_source *s = source->odb->sources; s; s = s->next) {
-		struct odb_source_files *files = odb_source_files_downcast(s);
-		if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0))
-			return 0;
-	}
-
-	oi.typep = &type;
-	oi.sizep = &len;
-	oi.contentp = &buf;
-	if (odb_read_object_info_extended(source->odb, oid, &oi, 0)) {
-		ret = error(_("cannot read object for %s"), oid_to_hex(oid));
-		goto out;
-	}
-
-	if (compat) {
-		if (repo_oid_to_algop(source->odb->repo, oid, compat, &compat_oid)) {
-			ret = error(_("cannot map object %s to %s"),
-				    oid_to_hex(oid), compat->name);
-			goto out;
-		}
-
-		compat_oid_p = &compat_oid;
-	}
-
-	ret = odb_source_write_object(&files->loose->base, buf, len, type, oid,
-				      compat_oid_p, mtime, 0);
-
-out:
-	free(buf);
-	return ret;
-}
-
 /*
  * We can't use the normal fsck_error_function() for index_mem(),
  * because we don't yet have a valid oid for it to report. Instead,
diff --git a/object-file.h b/object-file.h
index 9fd540afb6..31781a9c53 100644
--- a/object-file.h
+++ b/object-file.h
@@ -98,10 +98,6 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 int format_object_header(char *str, size_t size, enum object_type type,
 			 size_t objsize);
 
-int force_object_loose(struct odb_source *source,
-		       const struct object_id *oid,
-		       const time_t *mtime);
-
 /**
  * With in-core object data in "buf", rehash it to make sure the
  * object name actually matches "oid" to detect object corruption.

-- 
2.55.0.407.g700c83d4f3.dirty

