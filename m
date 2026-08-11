Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C9535BDB2
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470867; cv=none; b=RPUIhC4Y3TbTAJYBgEclU9gEKy7rIdPgwit65wldf0FnWDqyuMZXRG2Jx166OYYFdbKWNg/xjdM5FPrZb6cy13R0ej4ieMS23kWfz7eMBedNLAHGevygSrwB/iYwNt5/ZQsU6r1pVgftLAz179YVJC4jJAme2iE+SPwB5tMgdz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470867; c=relaxed/simple;
	bh=A3F65QhehYwBXnCUUY7ARMhnOCrt4XdPqCGYEJMMHSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBiM5VQD2sJbLtaVjUixu7nG+j5qf6DborDcjNLhzJ91xen6EBDhtIuITBK++OEaT7q880OEfJUzjCbiqthsfwgY4vJ+mruI7yluJVbaMujQgJdjnDMAF4op63TAqr8hlgups+Ltv8M0k8NX04WwiHH99Ko5WlLMfbY73CWExgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXS1TKgO; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXS1TKgO"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4864ebb6268so101485b6e.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786470864; x=1787075664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vJ6twJHPpCkLHfwkWKVbD0JnUAXzov2te+EFAW8cRC0=;
        b=GXS1TKgOcSopOVHEqXilHrIJvNVcFN/eV3cKnP2lAOp39KXmZSyyqYkkHjh/bQqs/b
         MlZnGnQAPqaKDD6U5ZA19JTH5r5ZDfzgFT+TAu/U7tgx126NPh0v4CYA92bc4wfDDcvC
         ZA0P+YWGLdc6SyOks+V1olNHeU71HNRE5Zt3eiQxMivgqamFd7wlc1iuuUhD+UXNyHXr
         X4NxwrR5lcJiSnpGYAd/xIerrSiSTUbfcpoHk2SUbwfTgU1y/cVEkGQDkvOhVp9tlR9i
         hhfch7a1BLcKpmZrkJiG5vsWClZhaXO/f5n66BP21RePSkA1cpg2basRTKOhQHFo3qcV
         oDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786470864; x=1787075664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vJ6twJHPpCkLHfwkWKVbD0JnUAXzov2te+EFAW8cRC0=;
        b=k2rtaymbM0grCjN5xlYndV3SLjM1+kaIzndGAK7e0H0d72+umWWUKai415AnR7ARWb
         Rac04tKjZ/TMSy6/iRmq8ceVSCnbVE/aAnQwDtpQiXPOCISK8bTI75RW9mrBwfSJXH0l
         +PlwGENqBnlt4wvME+LqBDDBDrDR0l+aXKcEmVujYhfZQHUGdWTMgfvfuyOSnKtdWBjd
         YXmn2TVaNVhs8QzlhLhktFQJcgz8XAS3CBYoy+VMmFuohncPebCdyLI1pBgAw7K9pfH3
         4mlRJGmYJT8tGg9lh3ZaE5lZGeoda5XYtvi1eazIqWGlaVYWo+Sve0aaRyhcMjJM602O
         Qp/Q==
X-Gm-Message-State: AOJu0YyP6Whzpgreag69n24s9/0we+OZZaSzlx+2mXZOcoWUjobwdRpf
	B5YrwrFC/7rsv9CgWooM8o70hY+VwifCqTdXYhN+dcdltQUWNE8RhKsx7Ycjhg==
X-Gm-Gg: AR+sD12ioSRNx4qk5x50IRwHaeC7jaMQX3U265T1loCdW60flejhWI7n8+I4KPQas9J
	ielial0Lon0lbY0uHcWFrFXTCzHp7EL46yi5VvwT4qxO1EwydkgZRvR4MK/hVRBcHTlfa7+haGV
	MJrfHVjrqkwyLZ4KWs1aChL1H/L4fVWPbTh3Dxhf1RZcONDEb6r0ZV6UyX9DsLtRtxV2/JFG+TN
	4hjEL3MxBNZ8/vtyvCVxqQyENfkmqxd72zIFoxfmUQ4bWnOAQDbulbFU83aOoqkkFym1XJ2ACLi
	t5lwhDnIFn/oPvewH/FLsp87OPw5p69b6AhL8U6ZDPnOTZCTI8z+AIFpiou/KtI32A041sy+DNF
	+4Dqyw0hZVfq5gzzFClO9HhjyngmIo6/DuSDZqXqGzjcq7CS8W0ysGnFiKYeWpUo+LHiawU6tX6
	klzNKAWiLwzD9P34tlcJiGML8A2kTmIWTBgJ66Ko3v06ivekIqOsggrZZw07wviC6En2XAiHQlK
	CH2ec/2
X-Received: by 2002:a05:6808:19a8:b0:4a3:3108:866a with SMTP id 5614622812f47-4b1fd915af5mr3811134b6e.17.1786470864052;
        Tue, 11 Aug 2026 10:54:24 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2001331d2sm1241489b6e.11.2026.08.11.10.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 10:54:23 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/9] builtin/receive-pack: properly clean up keep files
Date: Tue, 11 Aug 2026 12:54:07 -0500
Message-ID: <20260811175415.2044235-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260811175415.2044235-1-jltobler@gmail.com>
References: <20260809190106.1565882-1-jltobler@gmail.com>
 <20260811175415.2044235-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git-receive-pack(1) stores an incoming packfile with
git-index-pack(1), a ".keep" file is written alongside it to hold the
pack in place until the references have been updated, and is removed
afterwards. The path used to remove it is derived via
`index_pack_lockfile()` from the repository's primary object directory.

In bdee7b3013 (builtin/receive-pack: stage incoming objects via ODB
transactions, 2026-07-10), git-receive-pack(1) started using the ODB
transaction interfaces instead of managing a temporary directory
directly. When starting an ODB transaction, the sources list is
reordered to insert the newly created transaction source first as the
primary to ensure writes are routed to it accordingly.

Prior to using ODB transactions, git-receive-pack(1) would only set the
temporary directory as the primary source for the child
git-index-pack(1) and git-unpack-objects(1) processes it spawned and the
parent process would set the temporary directory set as an alternate
only. By using ODB transactions, the ODB source list is also reordered
for the parent process which results in `index_pack_lockfile()` deriving
the ".keep" path relative to the temporary directory instead the actual
main ODB source path. Consequently, this prevents the ".keep" file from
being properly removed after being migrated into the main ODB source
post-commit.

Update `index_pack_lockfile()` to operate on an ODB source explicitly
provided to it and update call sites accordingly to pass the expected
ODB source.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c     |  8 +++++++-
 fetch-pack.c               |  2 +-
 pack-write.c               |  7 ++++---
 pack.h                     |  4 +++-
 t/t5547-push-quarantine.sh | 14 ++++++++++++++
 5 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 86933d8d7e..d74b787148 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2412,7 +2412,13 @@ static const char *unpack(int err_fd, struct shallow_info *si,
 		if (status)
 			return "index-pack fork failed";
 
-		lockfile = index_pack_lockfile(the_repository, child.out, NULL);
+		/*
+		 * The lockfile filepath is expected to be the final location of
+		 * the ".keep" file after being migrated to the main ODB source.
+		 * This ensures the lockfile can be found and removed later
+		 * after the ODB transaction has been committed.
+		 */
+		lockfile = index_pack_lockfile(transaction->source, child.out, NULL);
 		if (lockfile) {
 			pack_lockfile = register_tempfile(lockfile);
 			free(lockfile);
diff --git a/fetch-pack.c b/fetch-pack.c
index 922a9b2581..6df5813b33 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1075,7 +1075,7 @@ static int get_pack(struct fetch_pack_args *args,
 		die(_("fetch-pack: unable to fork off %s"), cmd_name);
 	if (do_keep && (pack_lockfiles || fsck_objects)) {
 		int is_well_formed;
-		char *pack_lockfile = index_pack_lockfile(the_repository,
+		char *pack_lockfile = index_pack_lockfile(the_repository->objects->sources,
 							  cmd.out,
 							  &is_well_formed);
 
diff --git a/pack-write.c b/pack-write.c
index 24033a9101..85674e4b72 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -469,10 +469,11 @@ void fixup_pack_header_footer(const struct git_hash_algo *hash_algo,
 	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
 }
 
-char *index_pack_lockfile(struct repository *r, int ip_out, int *is_well_formed)
+char *index_pack_lockfile(struct odb_source *source, int ip_out,
+			  int *is_well_formed)
 {
 	char packname[GIT_MAX_HEXSZ + 6];
-	const int len = r->hash_algo->hexsz + 6;
+	const int len = source->odb->repo->hash_algo->hexsz + 6;
 
 	/*
 	 * The first thing we expect from index-pack's output
@@ -489,7 +490,7 @@ char *index_pack_lockfile(struct repository *r, int ip_out, int *is_well_formed)
 		packname[len-1] = 0;
 		if (skip_prefix(packname, "keep\t", &name))
 			return xstrfmt("%s/pack/pack-%s.keep",
-				       repo_get_object_directory(r), name);
+				       source->path, name);
 		return NULL;
 	}
 	if (is_well_formed)
diff --git a/pack.h b/pack.h
index 1cde92082b..68dcf08cf3 100644
--- a/pack.h
+++ b/pack.h
@@ -3,6 +3,7 @@
 
 #include "object.h"
 #include "csum-file.h"
+#include "odb/source.h"
 
 struct packed_git;
 struct pack_window;
@@ -105,7 +106,8 @@ off_t write_pack_header(struct hashfile *f, uint32_t);
 void fixup_pack_header_footer(const struct git_hash_algo *, int,
 			      unsigned char *, const char *, uint32_t,
 			      unsigned char *, off_t);
-char *index_pack_lockfile(struct repository *r, int fd, int *is_well_formed);
+char *index_pack_lockfile(struct odb_source *source, int fd,
+			  int *is_well_formed);
 
 struct ref;
 
diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index 0798ddab02..400a597606 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -70,4 +70,18 @@ test_expect_success 'updating a ref from quarantine is forbidden' '
 	git -C update.git fsck
 '
 
+test_expect_success '.keep file is removed after push' '
+	test_when_finished rm -rf keep.git &&
+	git init --bare keep.git &&
+
+	git -C keep.git config set receive.unpackLimit 0 &&
+	test_commit foo &&
+	git push keep.git HEAD &&
+	pack="$(ls keep.git/objects/pack/pack-*.pack)" &&
+	keep="${pack%.pack}.keep" &&
+
+	test_path_is_file "$pack" &&
+	test_path_is_missing "$keep"
+'
+
 test_done
-- 
2.55.0.424.g13c7afec21

