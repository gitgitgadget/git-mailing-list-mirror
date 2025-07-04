Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7628219C542
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751638457; cv=none; b=krkIZ1ddIAuPlph39VAxXuXJZMVqLTBKr6X9bX2G8RHfPrRpX3jH3UIv8al28Klnl+6iqt0BV88d5UHi/NM7asL69m/IV9xbOUowY8FVsngL0Oz2czDbsD3YuxdD6i1WXHKO1mRFyDAOsnklVCKcxXqm5JTXuJ8aNqp21XcMtYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751638457; c=relaxed/simple;
	bh=qx4eueFtoQEbqXj76WNAFntENR0YHUWUKYUF4rpOJ9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fB4pvDyXTlCgGcGyT88ny0+jFCfOc5EMao4FAKx/zKUU9AGua4iTdeyc4KDRzsG+jrAqHs7eI9pTupZxvoOirVizD/cPoh5D44PB5yV7DQynYvK9MJHweN0kCO0SGAtP0Jgm7BJE/ACJaAcK52zvAKzOOzsUDpkUAl17cpSXkWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4bCwugl; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4bCwugl"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31329098ae8so845008a91.1
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 07:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751638455; x=1752243255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BHhK2LCjii7mK8Q+aqHXFvptcvbarjqQ98wYAwlbUo=;
        b=R4bCwuglStQp9U1yy59yVjvbqwaFr1+qyD9HX39iceQRFbw5PNHKnUHeEXsLO950aH
         tpSR5qvG3FtzMC+DEpzRsBRQtfhNZ2I9SPEP5ffeLQK7zWnAXsYsgGKaL4sTR7G89Ge9
         Bw11sk9ralPD3np6hQyKuADhzaxuCkJj/YbTFsO6EFGvCAxra0vV/O4HTw/4Oin9VNHD
         VBGpJuZyRCFdDOl5lr539U1MBIcvDDru4SM6RWmyTV8NDK4L/7qJL0iuFAhWZjXnIRqt
         Veif2GbwvnCV2eOFM7IXHk1YYcIskSUyYdDpOTgUUlE3bnuTLetFG0+OKR2d1VZ2rNAe
         nZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751638455; x=1752243255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BHhK2LCjii7mK8Q+aqHXFvptcvbarjqQ98wYAwlbUo=;
        b=X0rElFGgrRP6g1HWFfLW/0wlCgacD4zmBiQeI52dYw+8MAttuc3OtR3IReBlWrHjZT
         X0XA3Foym0JM2q6uezMMUsoNiy6OTpNff5kp6w2fGoZO/s24B4ranUWGKzv9ktHf490b
         jSdMwPu/xZl48W/iW3YjIPQ9wFIwZW0w8ma0OThD/pRDFgXql1zS6hwGc9bXfwzipE42
         Olv6NPiWjKyufRBaWwVHAe3AbILQzfFouG9uRxd1AeX3hrPvcZpbF5BXT4Is+8QC+Hpj
         5UgedCH+Ooj5zoawt8watCvem+VY8jQlp40b1fUS/A1V7rvAHCj8DNZ7NhrrQg8xuSrF
         IZEw==
X-Forwarded-Encrypted: i=1; AJvYcCUNXiLPS+6ehJPt3XYS2W3djU1QVrY9OEH2nKR658TzSmqpNgaa0Qjzx6g7q22NDnwCgB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6eNLQLzbd6Rl7hFdiBU12n8UjOToSrS2fNjtQx3C5Bx1bvEoR
	WsiZo+kNru2S272QxO2KvbutYLiZpQbaYX+BaWrun4QNXDYRJOYUdTIh
X-Gm-Gg: ASbGncsqsqGaq3u7LgxkxZ2c6CyHO0R2+YebiXLSPt5MPgUah+ilGQ54tDC62k+morf
	c9daR0MXFSjeZuR/Hchn2DckUfko/tb6QPJ38Nm3yY0qjGK/mZHMQ3lCSd3lETc2zvevlo9Z496
	vUS3ZXeDj9qSqX9sN/mMNQdsLmN6X2ZSmDzlXRb1V8F7RpqBLc6r5tF+sWPf1yOzZcEwBOtWLie
	tf8CF1NZf+3VvkD6rXR23v4QeHgp5M3d+bYBrxsVnYRnczjqXh3li2P2Krj6Ymuyee2e9YfHgqj
	AyYKn+JQyjfWhrUiQcMKEFhPbU57ptMUKtvH0LP9proVj5Li8eg6ubf2ISQHkZC72sVBX3j4/5V
	5F3k15oUhtTQ9Aro=
X-Google-Smtp-Source: AGHT+IFCRZHTUtj8FpLpwP+q7DQYsJWO4xn60Zp7O6WsNJOOXfpv23LUPya109MZ/M5NXk2megRE5A==
X-Received: by 2002:a17:90a:c2cc:b0:310:c8ec:4192 with SMTP id 98e67ed59e1d1-31aab039de0mr5054944a91.10.1751638454745;
        Fri, 04 Jul 2025 07:14:14 -0700 (PDT)
Received: from thinku.localdomain ([2401:4900:1c96:b11f:29cd:a954:9c31:7c0d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaaf2cd54sm2115780a91.23.2025.07.04.07.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 07:14:14 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shejialuo@gmail.com,
	shyamthakkar001@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com
Subject: [GSOC PATCH v3 2/2] builtin/prune: stop depending on 'the_repository'
Date: Fri,  4 Jul 2025 19:42:35 +0530
Message-ID: <22fbbc8cf1b5cd622197e6d9f009acdbbcc0e802.1751630981.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751630981.git.ayu.chandekar@gmail.com>
References: <cover.1751630981.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor builtin/prune.c to remove the dependency on the global
'the_repository'. Replace all the occurrences of 'the_repository' with
repo and thus remove the definition '#define
USE_THE_REPOSITORY_VARIABLE'. Also, add a test to make sure that 'git
prune -h' can be called when the repository is `NULL`.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 builtin/prune.c         | 27 ++++++++++++---------------
 t/t1517-outside-repo.sh |  7 +++++++
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index dab3c19b6f..320e9c2341 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
@@ -64,7 +63,7 @@ static void perform_reachability_traversal(struct rev_info *revs)
 		return;
 
 	if (show_progress)
-		progress = start_delayed_progress(the_repository,
+		progress = start_delayed_progress(revs->repo,
 						  _("Checking connectivity"), 0);
 	mark_reachable_objects(revs, 1, expire, progress);
 	stop_progress(&progress);
@@ -78,7 +77,7 @@ static int is_object_reachable(const struct object_id *oid,
 
 	perform_reachability_traversal(revs);
 
-	obj = lookup_object(the_repository, oid);
+	obj = lookup_object(revs->repo, oid);
 	return obj && (obj->flags & SEEN);
 }
 
@@ -99,8 +98,7 @@ static int prune_object(const struct object_id *oid, const char *fullpath,
 	if (st.st_mtime > expire)
 		return 0;
 	if (show_only || verbose) {
-		enum object_type type = oid_object_info(the_repository, oid,
-							NULL);
+		enum object_type type = oid_object_info(revs->repo, oid, NULL);
 		printf("%s %s\n", oid_to_hex(oid),
 		       (type > 0) ? type_name(type) : "unknown");
 	}
@@ -154,7 +152,7 @@ static void remove_temporary_files(const char *path)
 int cmd_prune(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo UNUSED)
+	      struct repository *repo)
 {
 	struct rev_info revs;
 	int exclude_promisor_objects = 0;
@@ -173,20 +171,19 @@ int cmd_prune(int argc,
 	expire = TIME_MAX;
 	save_commit_buffer = 0;
 	disable_replace_refs();
-	repo_init_revisions(the_repository, &revs, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
 
-	if (the_repository->repository_format_precious_objects)
+	repo_init_revisions(repo, &revs, prefix);
+	if (repo->repository_format_precious_objects)
 		die(_("cannot prune in a precious-objects repo"));
 
 	while (argc--) {
 		struct object_id oid;
 		const char *name = *argv++;
 
-		if (!repo_get_oid(the_repository, name, &oid)) {
-			struct object *object = parse_object_or_die(the_repository, &oid,
-								    name);
+		if (!repo_get_oid(repo, name, &oid)) {
+			struct object *object = parse_object_or_die(repo, &oid, name);
 			add_pending_object(&revs, object, "");
 		}
 		else
@@ -200,16 +197,16 @@ int cmd_prune(int argc,
 		revs.exclude_promisor_objects = 1;
 	}
 
-	for_each_loose_file_in_objdir(repo_get_object_directory(the_repository),
+	for_each_loose_file_in_objdir(repo_get_object_directory(repo),
 				      prune_object, prune_cruft, prune_subdir, &revs);
 
 	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
-	remove_temporary_files(repo_get_object_directory(the_repository));
-	s = mkpathdup("%s/pack", repo_get_object_directory(the_repository));
+	remove_temporary_files(repo_get_object_directory(repo));
+	s = mkpathdup("%s/pack", repo_get_object_directory(repo));
 	remove_temporary_files(s);
 	free(s);
 
-	if (is_repository_shallow(the_repository)) {
+	if (is_repository_shallow(repo)) {
 		perform_reachability_traversal(&revs);
 		prune_shallow(show_only ? PRUNE_SHOW_ONLY : 0);
 	}
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 6824581317..8f59b867f2 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -114,4 +114,11 @@ test_expect_success 'update-server-info does not crash with -h' '
 	test_grep "[Uu]sage: git update-server-info " usage
 '
 
+test_expect_success 'prune does not crash with -h' '
+	test_expect_code 129 git prune -h >usage &&
+	test_grep "[Uu]sage: git prune " usage &&
+	test_expect_code 129 nongit git prune -h >usage &&
+	test_grep "[Uu]sage: git prune " usage
+'
+
 test_done
-- 
2.49.0

