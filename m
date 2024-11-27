Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E62010F2
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724934; cv=none; b=QKnrUPJ8JTLf/9ktr6R0w8AHo91/OScxu0wWBGayn1GwzeK1PGFjk3cxgj4UZl9Gb5v12EUlVjUtzU9zpwtNwsSVsi0f3RdteGFns6odVuE/PVLhGBhFbkUJ3jP06JZ5JSHQoA+kOd0+QiNmRIym8wwG5ny9+SDjCSx1hIKu4oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724934; c=relaxed/simple;
	bh=XswBKIEYVgzBzr7Zn3z0ELPX7Dim66xK7iLqybRKUKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgB60mzQaqWu29r+PkwMHRgom6d602bKGG8RgnZhuEUKlQu4sEq9TIikHR8SihNbFeAFH195ZZOvk86aUwVDwZSjmrixFTA46sJgp8tTayJlhQaQ0tGh4hnzQgGqea6n2wcjML726pwZVNit9Ze0iK7fR1qNMQFKzYua/Xo3OBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efqugE0E; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efqugE0E"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so858942166b.3
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 08:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732724931; x=1733329731; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1r7ySIMkMP2E3CKpRumrzTuZwI4S8S3VQBRTXzSrfGU=;
        b=efqugE0EiCJVrLfh4JSvrdnTB6RgyfbHEEw0wY0Co+Uzrh17nBIsZBakkoHf/4hs8v
         HEwqpLNx4i5ejVvTEwUDbLPwA9eGtdHfsFRHRuz/IA7Y3mcJUyRCM5MDjTekZxgkHwIF
         KZ27afzB8ePhfQRtNvFuyeWVPK8mKM+fxgtiDsQ2H1EyjoRUC0g8l9T3n3JAkCHeJOHo
         aS4rtosub47Yu1H+R2upGLfmyKkVEPZsk+V9zRJxlNByDLi/olmew6iCnsVu0b1/fdY+
         REdR/kLWf7Jz2SIHoGSgXx5CJTO7hBNgiPbY9VmqafyG8MXp4k4EB+47M4tEWNzXqkwF
         RvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724931; x=1733329731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1r7ySIMkMP2E3CKpRumrzTuZwI4S8S3VQBRTXzSrfGU=;
        b=omrd+pBQZOBrMu5+1KyO0B7XWnHAQsLgO6vfmBVbGWIo7O/yDiTREdDR13Lg4FEIJx
         Fkv3qdqtu3sUm5rPy0xwkAGfms5OTEH+oMqnxJPxbowm+8pDtuvN7ISU2FHMjqsdHvy4
         5Tk4fwN+nkxnvB99hlHAL7MSy7aqowL83D3nSocGWCHEfu4u9ImH9NaOKC578Xtu6wI0
         TPn+DA70Ev/lkDjko1Nu3zQRPp74UlVJcjOdTJsT16QmAtvri1V3BaLOOms0WV4b8E/v
         ssAMg40JKRb0Dl3IhINGfjNuDWKnsoSxdnI06t93EbwCFRcEtDMEnWt74kHl1ZrzoVUU
         QCmg==
X-Gm-Message-State: AOJu0YwfwKm7Z8ceBXZEJI0egve5gM3sUBdwMIq6y9t/ant4iTSfhs7W
	GYTLdUmiK+wf104tAfSi6nYqnc/B243bOsEbLRHrG1CT8RpKi3JZ
X-Gm-Gg: ASbGnct3xZFwh0YDpvA2WH5C5UeyR+wPkzIcP+e7CWuhhej5/DZKFMKiCzfKXiZV88x
	90ylfgb/+DG9+1qf+mvaejLpimZ4sZ5PZy5HNZb1m80qGy4+xmrmFR9/kWHZQRMchDMIDVtjTSq
	f4Fw1xRTR59zZswy0L9UyM2mbyoip8H1PxfG+1jy19e+q4gX+oawuxXAv7ks4U9uMpI/mSWg7D3
	gKNtWjZGeOWAgKYzauW0ObhY0avZTPfnHgr/cuXAZ+JJ8fCa+ZEKsl5wKPCeA==
X-Google-Smtp-Source: AGHT+IGwTvXPNmneVRxdE1btt+xpoPW7TJ4XHaGxPxQzma1PIYatfRsCEoEHmyHg+xOcmI1LWhwqOg==
X-Received: by 2002:a17:906:32ce:b0:aa5:3591:420f with SMTP id a640c23a62f3a-aa580f1b93emr410819966b.16.1732724931068;
        Wed, 27 Nov 2024 08:28:51 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:5640:4a6:5555:68ae])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54e15c169sm420042366b.67.2024.11.27.08.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:28:50 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 27 Nov 2024 17:28:29 +0100
Subject: [PATCH v3 4/8] midx-write: pass down repository to
 `write_midx_file[_only]`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-4-c5a99f85009b@gmail.com>
References: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
In-Reply-To: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, me@ttaylorr.com, 
 shejialuo@gmail.com, gitster@pobox.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5314; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=XswBKIEYVgzBzr7Zn3z0ELPX7Dim66xK7iLqybRKUKU=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnR0i8Ucu2fHvXCepJjiRfWJFzNJZdZj9aPsS0C
 /6AzNSOj+6JAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ0dIvAAKCRA+1Z8kjkaM
 f9+zC/0RDC6SWIjHnedN3oGH5EWi73LxsujlFsqcYcRUL8hAbRA5WF0O3zPq87IFNJ51GnzMJxp
 KHKQ9tjGt27KJz9jAf1+myNesxqtSG5i/0+bL7tLddNpAGkRPgqK3abKnEFYok7hEtArbCMro33
 bwRJml7BUgzBHLokOBlBhFogm6mGOlVlOOnvrqZh2pAyxYyuMlEctlWhdHndPWNeyV/6Nwzc3DY
 KA5/LRByE43wns+pcJ98nuzRFCiyTS+6AojPZ1ZOG5RmcJbE1PrUvC+tQS2LxTLVeXGD5QY3VfB
 kZuMplr1dNg/wdG3kknpuAuzVR6R+eqz9BZbYIzJ4qcL6Iz0LgoZt/UplqmLigKO3RnLDyB07on
 8z9drryOIXQyfUSPangLptpK9BsNZxD/8sNvoTdWnpt/vpCkbUKfKNZNpQYNNNFprCTBt2D4Yh9
 q14WMHaWGAC8ujzEC4F+m7Y8Ycb8YwFnEpzZ+QfOLc9tcL90Amv8DfFRwF4km77+3GzSk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In a previous commit, we passed the repository field to all
subcommands in the `builtin/` directory. Utilize this to pass the
repository field down to the `write_midx_file[_only]` functions to
remove the usage of `the_repository` global variables.

With this, all usage of global variables in `midx-write.c` is removed,
hence, remove the `USE_THE_REPOSITORY_VARIABLE` guard from the file.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/multi-pack-index.c |  6 +++---
 builtin/repack.c           |  2 +-
 midx-write.c               | 22 +++++++++-------------
 midx.h                     | 10 ++++------
 4 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 85e40a4b6d3e47e9ec1ec27c094455e5ba75b5b0..2a938466f53aaa11096170554fe11a4ed46a25e4 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -120,7 +120,7 @@ static void read_packs_from_stdin(struct string_list *to)
 
 static int cmd_multi_pack_index_write(int argc, const char **argv,
 				      const char *prefix,
-				      struct repository *repo UNUSED)
+				      struct repository *repo)
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_write_options[] = {
@@ -165,7 +165,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 		read_packs_from_stdin(&packs);
 
-		ret = write_midx_file_only(opts.object_dir, &packs,
+		ret = write_midx_file_only(repo, opts.object_dir, &packs,
 					   opts.preferred_pack,
 					   opts.refs_snapshot, opts.flags);
 
@@ -176,7 +176,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 	}
 
-	ret = write_midx_file(opts.object_dir, opts.preferred_pack,
+	ret = write_midx_file(repo, opts.object_dir, opts.preferred_pack,
 			      opts.refs_snapshot, opts.flags);
 
 	free(opts.refs_snapshot);
diff --git a/builtin/repack.c b/builtin/repack.c
index 96a4fa234bddfd2b63c8d9733379d9b1012a4014..9c21fc482dfb387c818c0d0a74f781848b5a0953 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1569,7 +1569,7 @@ int cmd_repack(int argc,
 		unsigned flags = 0;
 		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL, 0))
 			flags |= MIDX_WRITE_INCREMENTAL;
-		write_midx_file(repo_get_object_directory(the_repository),
+		write_midx_file(the_repository, repo_get_object_directory(the_repository),
 				NULL, NULL, flags);
 	}
 
diff --git a/midx-write.c b/midx-write.c
index 1c355cdf8db4e9fed61a4aabf61a237ad26181ce..1bc2f5256916e69924245951f654c1047ffeab84 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
@@ -1505,24 +1503,22 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 	return result;
 }
 
-int write_midx_file(const char *object_dir,
+int write_midx_file(struct repository *r, const char *object_dir,
 		    const char *preferred_pack_name,
-		    const char *refs_snapshot,
-		    unsigned flags)
+		    const char *refs_snapshot, unsigned flags)
 {
-	return write_midx_internal(the_repository, object_dir, NULL, NULL,
-				   preferred_pack_name, refs_snapshot, flags);
+	return write_midx_internal(r, object_dir, NULL, NULL,
+				   preferred_pack_name, refs_snapshot,
+				   flags);
 }
 
-int write_midx_file_only(const char *object_dir,
+int write_midx_file_only(struct repository *r, const char *object_dir,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
-			 const char *refs_snapshot,
-			 unsigned flags)
+			 const char *refs_snapshot, unsigned flags)
 {
-	return write_midx_internal(the_repository, object_dir, packs_to_include,
-				   NULL, preferred_pack_name, refs_snapshot,
-				   flags);
+	return write_midx_internal(r, object_dir, packs_to_include, NULL,
+				   preferred_pack_name, refs_snapshot, flags);
 }
 
 int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags)
diff --git a/midx.h b/midx.h
index 3b0ac4d8788b373c59fe69ca2d78e9d914702bc0..c37ad5b5242b56d21fd76bd59957a1bdb82786ec 100644
--- a/midx.h
+++ b/midx.h
@@ -123,15 +123,13 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
  * Variant of write_midx_file which writes a MIDX containing only the packs
  * specified in packs_to_include.
  */
-int write_midx_file(const char *object_dir,
-		    const char *preferred_pack_name,
-		    const char *refs_snapshot,
+int write_midx_file(struct repository *r, const char *object_dir,
+		    const char *preferred_pack_name, const char *refs_snapshot,
 		    unsigned flags);
-int write_midx_file_only(const char *object_dir,
+int write_midx_file_only(struct repository *r, const char *object_dir,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
-			 const char *refs_snapshot,
-			 unsigned flags);
+			 const char *refs_snapshot, unsigned flags);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags);
 int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags);

-- 
2.47.1

