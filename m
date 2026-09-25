Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0284F474F
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369846; cv=none; b=I34T9UThKcsGZpXdJu8I2TK5ViEpp1Yc59nKNhm/6nBlR9HTrNQjZ3p8KXps+vqOGBC+cMMGWoDQc9C98yWLCRVcqiRWqFTyqGwwb/PNaSgIbCYZf26GSvDIG1zmXsVXkx/Yt7VlcBQ8FSenARbto9pIugRKM6oFCmt+494Rw3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369846; c=relaxed/simple;
	bh=IGTeTwJu1xrhmarkbPMUfQfFomQPzEFYMMTbSfhqq54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cT9TVbhh0B4PCe7IfZR47c006ITzav3SZUw+VRs1fIHvUPTEKQ2VxodvCz4pjoN30wUHXd3UuAY/xFC7X1ftDNvh4ztNnPyooIgeYX2Qh/pIm0ru88V9XJ1Ju7tGGZfj6JujJbnPNB7x7RluTrz3QSniCVUOZhzBrzwRn8/9xxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFuupBBX; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFuupBBX"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-341027843a5so852524eec.2
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790369844; x=1790974644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S9wQ48oXry+CeH9kfZONB2dEbZuH/H9ELk/AMLASLD4=;
        b=oFuupBBXcNe7MvldbhThq2PSdGvnBJct+BdUp1T/rL+lQsiofUWBkafKVZZiuv8WKi
         K1fwRO9RoiOG7wiXbVW6GZIuAqrMpXic0/UeMmwTza4EK7EZBljuBHyJ+8bqATsSClpi
         PUdseGVcqL73Ebx1vN7T+fw6gd5BMQI683qMxYyt+RYKJ09N+coaKZWc3SU8k+emMfeK
         F8rA00E4RyDjL5qF0Ee24LgY2cOEW1Wr6LFlAamIhWoqHBe7BfmLyJCzNGtBhvM6N2wK
         E/K1zTUN6AXn19koOdn4t12KCTY5sOxIE/JpAMqneXH+n/jTmts88G1NsEKkONquSBrO
         mCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790369844; x=1790974644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S9wQ48oXry+CeH9kfZONB2dEbZuH/H9ELk/AMLASLD4=;
        b=kWpT86BnQdk7AtxwO6jLSYdXCjdueLQFpwktoQlJIFNPvM9qKtrzlZZV8wePm+iVrV
         U9DWcgvlkidNt8cdIQhE07+KlBODG81KuQYAhFo5TJQuM6kyD5rOULfkVaTCFiA9Mth1
         vnky512E4VoriCI1jLKH2GXh1NFzsvCzdDozsvhrCMh/K+3uJdfPe95+m+DjeiVKq6uE
         d5lS4gxi+DlUqYkEWfSenjgVpSe/0QFXXTTA5c5DJ59xXymO8pNWPFs84oXb9YUAbwPf
         iwUYU07gXETw05WUXXFRp5gQK278vXRrHOyaE1CGfERO1QpePJmheuMnay3w60Pz308B
         Y8Fg==
X-Gm-Message-State: AFuF++k0SRaYofHA3QO+IsTm5BF0SkQFYCMUM/OBj2zeTSYagOpMBUXQ
	OROg9LB8Ehw3di0XWgMQB5fdd7NFNVQftphYKvpCZAic8T/jbGtSvFgb5vjyvYeo
X-Gm-Gg: AYBFou1NXts9C/zzEQCtoPHcPRmpsVbu/MJOp10tFfLvGK1C97jqEMVfZlULYvCdikn
	qaEf807c7pAX5EOFMUExdE4ffbFq9UMTe0f7rVP8/4sL6pJPMqkxeNwXsrhzPqdjd6i4n5ujU2q
	s/Bv0ZpoCxgEhBqqeZwb7T4epeULyYt4Y+peY/wOogJX9u+0buPmG2LItpeFct+MgqooCZbhtL7
	doXH7x1P87v7lx1w9eOyMHrsEuAwyuC2x/L2YAbUoh62a6OpEDUcjwga9q3oaKtvH0Ur7FrrHBh
	7xFpf0w2n/PQOoUDk0HWgwPr8kKFR4dVyOIYZIt79UlEOpheyeyO7ygRqoPCPHLDiz2TprlNHQv
	u4XQhX8ikCMas/bbU0MG/0u/PULMu7O6ZVK2e7ZcNACqmRGgAuzJ8xQZ50GuRqkocWBJOUXlYDD
	VYQVt03KIclOQS1CLChMYsddMNt+F45QiGrELrOpyQO8t2w7pV1DN5iNTVSV8LLamcjWF3aAUxG
	0UrqpLi5a9lRNuv0uqztjmfiBZjCpsZOsIyvg==
X-Received: by 2002:a05:7300:7953:b0:33e:518c:6837 with SMTP id 5a478bee46e88-34272179145mr1236119eec.24.1790369844440;
        Fri, 25 Sep 2026 13:57:24 -0700 (PDT)
Received: from royce-MS-7D09.lan (76-14-104-130.rk.wavecable.com. [76.14.104.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145632298sm8082744eec.22.2026.09.25.13.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:57:24 -0700 (PDT)
From: Royce Remer <royceremer@gmail.com>
To: git@vger.kernel.org
Cc: Royce Remer <royceremer@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/1] pack-write, pack-bitmap-write: register tmp pack files for cleanup
Date: Fri, 25 Sep 2026 13:56:33 -0700
Message-ID: <20260925205633.530651-2-royceremer@gmail.com>
X-Mailer: git-send-email 2.55.0.1.ga30d533ec0
In-Reply-To: <20260925205633.530651-1-royceremer@gmail.com>
References: <20260925205633.530651-1-royceremer@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`git repack` correctly uses `register_tempfile()` via
`collect_pack_filenames()` for the `.tmp-<pid>-pack-*` files it
creates, so they are removed when the process exits gracefully.

The lower-level pack-writing functions invoked by `git gc` and
`git maintenance` do not. They call `odb_mkstemp()` which wraps
`mkstemp(2)` directly, bypassing the tempfile subsystem entirely.
A SIGTERM leaves these files stranded on disk where they accumulate
and can exhaust available space:

  objects/pack/tmp_pack_XXXXXX   (create_tmp_packfile)
  objects/pack/tmp_idx_XXXXXX    (write_idx_file)
  objects/pack/tmp_rev_XXXXXX    (write_rev_file_order)
  objects/pack/tmp_mtimes_XXXXXX (write_mtimes_file)
  objects/pack/tmp_bitmap_XXXXXX (bitmap_writer_finish)

Call `register_tempfile()` immediately after each `odb_mkstemp()` so
that the atexit(3) and signal handlers unlink the file on abnormal
exit.

Signed-off-by: Royce Remer <royceremer@gmail.com>
---
 pack-bitmap-write.c | 3 +++
 pack-write.c        | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 1bcb3f98a4..c566419690 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -23,6 +23,7 @@
 #include "oid-array.h"
 #include "config.h"
 #include "alloc.h"
+#include "tempfile.h"
 #include "refs.h"
 #include "strmap.h"
 #include "midx.h"
@@ -1378,6 +1379,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 
 	int fd = odb_mkstemp(writer->repo->objects, &tmp_file,
 			     "pack/tmp_bitmap_XXXXXX");
+	struct tempfile *tmp = register_tempfile(tmp_file.buf);
 
 	if (writer->pseudo_merges_nr)
 		options |= BITMAP_OPT_PSEUDO_MERGES;
@@ -1435,6 +1437,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 
 	if (rename(tmp_file.buf, filename))
 		die_errno("unable to rename temporary bitmap file to '%s'", filename);
+	delete_tempfile(&tmp);
 
 	strbuf_release(&tmp_file);
 	free(offsets);
diff --git a/pack-write.c b/pack-write.c
index 83eaf88541..fa6b532230 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -13,6 +13,7 @@
 #include "path.h"
 #include "repository.h"
 #include "strbuf.h"
+#include "tempfile.h"
 
 void reset_pack_idx_option(struct pack_idx_option *opts)
 {
@@ -87,6 +88,7 @@ const char *write_idx_file(struct repository *repo,
 			fd = odb_mkstemp(repo->objects, &tmp_file,
 					 "pack/tmp_idx_XXXXXX");
 			index_name = strbuf_detach(&tmp_file, NULL);
+			(void)register_tempfile(index_name);
 		} else {
 			unlink(index_name);
 			fd = xopen(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
@@ -263,6 +265,7 @@ char *write_rev_file_order(struct repository *repo,
 			fd = odb_mkstemp(repo->objects, &tmp_file,
 					 "pack/tmp_rev_XXXXXX");
 			path = strbuf_detach(&tmp_file, NULL);
+			(void)register_tempfile(path);
 		} else {
 			unlink(rev_name);
 			fd = xopen(rev_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
@@ -346,6 +349,7 @@ static char *write_mtimes_file(struct repository *repo,
 
 	fd = odb_mkstemp(repo->objects, &tmp_file, "pack/tmp_mtimes_XXXXXX");
 	mtimes_name = strbuf_detach(&tmp_file, NULL);
+	(void)register_tempfile(mtimes_name);
 	f = hashfd(repo->hash_algo, fd, mtimes_name);
 
 	write_mtimes_header(repo->hash_algo, f);
@@ -535,6 +539,7 @@ struct hashfile *create_tmp_packfile(struct repository *repo,
 
 	fd = odb_mkstemp(repo->objects, &tmpname, "pack/tmp_pack_XXXXXX");
 	*pack_tmp_name = strbuf_detach(&tmpname, NULL);
+	(void)register_tempfile(*pack_tmp_name);
 	return hashfd(repo->hash_algo, fd, *pack_tmp_name);
 }
 
-- 
2.55.0.1.ga30d533ec0

