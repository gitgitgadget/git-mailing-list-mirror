Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E75434D384
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015343; cv=none; b=qZRxITiFX+Y9gDg5p0hQPnOdRVtpozsvFH952TuGtqMaFo0S1MQAY6JcOkf1dkufyA4P/D44GFPt2DreRk8LjcuTFMWgol+Dihf98qBQbyMikH2AfO7zRaPMw6BmDVF+gUI7ATI8fszS92aKnJ2412Q0TBwbKDS4eAknc6VS9VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015343; c=relaxed/simple;
	bh=8hk52r/pihWk6XSKEDFO9qHD3Dwb07a6dlPV/XybGQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czoLtAyNGvwt/6hQ/AGPLRZfP0gT1DHuXZYx0980SHj0IuIA2vtLCmZe3wtia3fHu6IyFUbXvjeN+8NoDmxIXx1ArrbXhQ4Rzhh+62j++TEFTNOIry4mjKc3LcTGMtBLVBHxz6ppUiokOuFVaywnXxOdABPz5jom/fgd7pTPELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWo+sscS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWo+sscS"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so2054796a91.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786015341; x=1786620141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I/wvU+HvJus7J7KC7JCzpKjrYTACDq715NCrFiMFHvs=;
        b=gWo+sscSWg07X7SeYgS2vraV5Vr+IUSMdR9aojj/rr6/8JqZyD1C+0j0ra4Aod8NUB
         E0aR3OaRnePQzzfwXeyssyq3V2R6MjGj9tt4Cglbi+6hJ9xk+Ma2echBu3/M02gJoKjK
         LJTVNiYGrlTo5o389EFjaVV1nIq8FXwKBiP//+zZoCM4IQnse51AT/zMJorPNrv4a7fG
         s74hbDMqBe7j5Ay6yBVOZj1VIpdNxJSnXft23fcNEuvjYt0XUAJ7Jk1+7PQCrXqQZqAG
         D6WFhBJegAsjzN45No9XZNTreXgWvKzhd54omm1hXPsRuvHcbh307J5WqefRMG+lmqD7
         4Klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786015341; x=1786620141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I/wvU+HvJus7J7KC7JCzpKjrYTACDq715NCrFiMFHvs=;
        b=lBjS0A7Gs3FU/Cdlysx8IJ/mGECc+os7Vl++Zk8edMtPuJ+JjidRb6Il38muSb07XN
         QJXO+ITP7OWn2Y7ibli5l+KcZ6dSoLHmvYkdvvAo9toISvUk2ExdTbYQHlss3Mf6MhGm
         lM5YdobnIBxFGhq/vtyns/mL+ucmfz+kQbnmcV1D+YFfLdFKpwU5/K7KoJH8BNzK5E9X
         7UTb+KZW5v5y29Y5NYERQShSYOD8/nrexhccExTGRKgXCv7m+PiUoI5E2eSfiPrBBGCK
         K9btM+7ahrQVJkhUY1Wct1Yerr2P2t+lFfSMuC/ZB8CEevUQNszIUrivx0DEwc65LcR/
         5kZg==
X-Gm-Message-State: AOJu0Yy1CtS4nxKNx3MElvbl4QH5syKRhFt4kC2b8pFg+BTtGPKCBZLg
	cEMV5nw034DO8+n0YbcVcv1jWbvT6MEBHc0gEXCXKsZi5lO+KSUUwODUNaCg+bUK
X-Gm-Gg: AR+sD114ADFvHioeArnl53WGwZ23lpY30wK4MO9QGRNP+Y55Dc+WZiNUhOJOG/5YgY0
	R1wCFvMuT9quSjeo7YMKvgycfVkigceieq1FgM7kpVI07xZV8gy0LMLH5i4kFdg/qRjtA8+rEy/
	KJ/jTGg7zBQyT5rAmwV1FqIuM1G3y+XkOaroYDd1lIijwfrn52w0iUBs8wLuAFVezdHMN8UqHA4
	nK+2WWYCUdWIWCYIaAsa1rTH4iFo7gzjvqQgUeb0yGH6KBJpShejWtOX3sSw3uao2hz7UjL1ewv
	Rv5v5UB2o3H/kOUyAg6qZa72dpDEQuxKN/FDGFGeaYjIhiWuTvcUnqQZKTX3XZsVIxgn202Lkuy
	yq/8mbrWnKE35bV5WJ0WWSElO15yk24uxJhS0qt0OpwxD0ziKftZ5sHXO2HGPRxF1brtuDPDECc
	JkufiRCRxOXthawh9r0clGMmSKgqOPUMgX7SB7nw/95I6P99sR0H8g5zg0vDu4LOTMFkkcb8aar
	oIfQI66GnzNiumgbP1r9kx/+oIUKiPG1iyIh06HP7EG1Zc0LHNQ54BswxPBKkP9gNqAhvq8ES+l
	xtmvjwsWoOf4
X-Received: by 2002:a17:90b:1811:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-3903bb0ab77mr11432904a91.0.1786015341132;
        Thu, 06 Aug 2026 04:22:21 -0700 (PDT)
Received: from localhost.localdomain ([123.252.204.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca8df89asm42490376c88.9.2026.08.06.04.22.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Aug 2026 04:22:20 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	ttaylorr@openai.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v3 1/7] builtin/repack.c: add --drop-filtered and --dry-run options
Date: Thu,  6 Aug 2026 16:51:56 +0530
Message-ID: <20260806112202.75067-2-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
References: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
 <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two new command-line options to 'git-repack':

  --drop-filtered: intended to eventually delete objects that match
                   the filter specification. Requires --filter and -a,
                   and is incompatible with --filter-to.
  --dry-run: show which objects would be dropped without making any
             changes. Only meaningful with --drop-filtered.

Keep --dry-run as a separate option rather than folding it into
--drop-filtered (e.g --drop-filtered=dry-run), to stay consistent with
the --dry-run option other Git commands already provide and to leave
room for it to describe other repack behavior later. A
--drop-filtered=<mode> form can still be added later if more
drop-specific modes are needed.

--drop-filtered also requires a promisor remote to be configured, since
dropping objects without a remote to fetch them back from would be
permanent data loss.

--drop-filtered is incompatible with bitmap writing: filtering breaks
the "all objects in one pack" closure that bitmaps require. Detect an
explicit -b/--write-bitmap-index on the command line with a dedicated
option callback that sets a "write_bitmaps_given" flag, so it can be
distinguished from a repack.writeBitmaps configuration value even when
config already enables bitmaps. An explicit -b is reported as a conflict,
while a config-provided default is silently disabled for the duration
of the command.

These options currently only perform validation. The actual enumeration
and deletion will be added in follow-up commits.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 builtin/repack.c                | 71 ++++++++++++++++++++++++++++++++-
 t/meson.build                   |  1 +
 t/t7706-repack-drop-filtered.sh | 55 +++++++++++++++++++++++++
 3 files changed, 125 insertions(+), 2 deletions(-)
 create mode 100755 t/t7706-repack-drop-filtered.sh

diff --git a/builtin/repack.c b/builtin/repack.c
index db504d673f..2e8b7ea45c 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -14,6 +14,7 @@
 #include "promisor-remote.h"
 #include "repack.h"
 #include "shallow.h"
+#include "list-objects-filter-options.h"
 
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
@@ -28,6 +29,9 @@ static int use_delta_islands;
 static int run_update_server_info = 1;
 static char *packdir, *packtmp_name, *packtmp;
 static int midx_must_contain_cruft = 1;
+static int drop_filtered;
+static int dry_run;
+static int write_bitmaps_given;
 
 static const char *const git_repack_usage[] = {
 	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
@@ -111,6 +115,21 @@ static int repack_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
+static int option_parse_write_bitmaps(const struct option *opt, const char *arg,
+				      int unset)
+{
+	int *value = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+	if (unset)
+		*value = 0;
+	else
+		*value = 1;
+
+	write_bitmaps_given = 1;
+	return 0;
+}
+
 static int option_parse_write_midx(const struct option *opt, const char *arg,
 				   int unset)
 {
@@ -194,8 +213,9 @@ int cmd_repack(int argc,
 		OPT__QUIET(&po_args.quiet, N_("be quiet")),
 		OPT_BOOL('l', "local", &po_args.local,
 				N_("pass --local to git-pack-objects")),
-		OPT_BOOL('b', "write-bitmap-index", &write_bitmaps,
-				N_("write bitmap index")),
+		OPT_CALLBACK_F('b', "write-bitmap-index", &write_bitmaps, NULL,
+			        N_("write bitmap index"),
+			       PARSE_OPT_NOARG, option_parse_write_bitmaps),
 		OPT_BOOL('i', "delta-islands", &use_delta_islands,
 				N_("pass --delta-islands to git-pack-objects")),
 		OPT_STRING(0, "unpack-unreachable", &unpack_unreachable, N_("approxidate"),
@@ -231,6 +251,10 @@ int cmd_repack(int argc,
 			   N_("pack prefix to store a pack containing pruned objects")),
 		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
 			   N_("pack prefix to store a pack containing filtered out objects")),
+		OPT_BOOL(0, "drop-filtered", &drop_filtered,
+				N_("delete filtered out objects (requires --filter)")),
+		OPT_BOOL(0, "dry-run", &dry_run,
+				N_("only show which objects would be dropped")),
 		OPT_END()
 	};
 
@@ -252,6 +276,49 @@ int cmd_repack(int argc,
 	po_args.depth = xstrdup_or_null(opt_depth);
 	po_args.threads = xstrdup_or_null(opt_threads);
 
+	die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
+		!!filter_to, "--filter-to");
+
+	if (dry_run && !drop_filtered)
+		die(_("--dry-run only takes effect with --drop-filtered"));
+
+	if (drop_filtered) {
+		if (!dry_run)
+			die(_("--drop-filtered doesn't work without --dry-run yet"));
+
+		if (!po_args.filter_options.choice)
+			die(_("--drop-filtered requires --filter"));
+
+		if (!(pack_everything & ALL_INTO_ONE))
+			die(_("--drop-filtered requires -a"));
+
+		/*
+		 * Only blob:limit=<n> is supported for now. Reject other
+		 * filter choices early, before walking the object database.
+		 */
+		if (po_args.filter_options.choice != LOFC_BLOB_LIMIT)
+			die(_("--drop-filtered only supports --filter=blob:limit=<n> for now"));
+
+		/*
+		 * an explicit -b on the command line is a conflict we have to
+		 * report, a bitmap setting from config is silently overridden
+		 * for the duration of the command
+		 */
+		if (write_bitmaps_given && write_bitmaps > 0)
+			die(_("options '%s' and '%s' cannot be used together"),
+				"--drop-filtered", "--write-bitmap-index");
+
+		/*
+		 * Without a promisor remote there is nowhere to re-fetch the
+		 * dropped objects from, so dropping them would be permanent
+		 * data loss.
+		 */
+		if (!repo_has_promisor_remote(repo))
+			die(_("--drop-filtered requires a promisor remote"));
+
+		write_bitmaps = 0;
+	}
+
 	if (delete_redundant && repo->repository_format_precious_objects)
 		die(_("cannot delete packs in a precious-objects repo"));
 
diff --git a/t/meson.build b/t/meson.build
index a25f37d2f5..92352e43c4 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -964,6 +964,7 @@ integration_tests = [
   't7703-repack-geometric.sh',
   't7704-repack-cruft.sh',
   't7705-repack-incremental-midx.sh',
+  't7706-repack-drop-filtered.sh',
   't7800-difftool.sh',
   't7810-grep.sh',
   't7811-grep-open.sh',
diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtered.sh
new file mode 100755
index 0000000000..f27b09a30e
--- /dev/null
+++ b/t/t7706-repack-drop-filtered.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='git repack --drop-filtered option validation'
+
+. ./test-lib.sh
+
+# checks for options validations before any promisor walk
+test_expect_success 'setup plain repo for validation' '
+	git init plain &&
+	test_commit -C plain initial &&
+	git clone --bare plain plain.git &&
+	git -C plain.git repack -a -d
+'
+
+test_expect_success '--drop-filtered requires --filter' '
+	test_must_fail git -C plain.git repack --drop-filtered --dry-run -a 2>err &&
+	test_grep "drop-filtered requires --filter" err
+'
+
+test_expect_success '--drop-filtered cannot be used with --filter-to' '
+	test_must_fail git -C plain.git repack --drop-filtered \
+		--filter=blob:limit=1k --filter-to=./filter-out 2>err &&
+	test_grep "options .--drop-filtered. and .--filter-to. cannot be used together" err
+'
+
+test_expect_success '--dry-run only takes effect with --drop-filtered' '
+	test_must_fail git -C plain.git repack --dry-run 2>err &&
+	test_grep "dry-run only takes effect with --drop-filtered" err
+'
+
+test_expect_success '--drop-filtered requires -a' '
+	test_must_fail git -C plain.git repack --drop-filtered \
+		--filter=blob:limit=1k --dry-run 2>err &&
+	test_grep "drop-filtered requires -a" err
+'
+
+test_expect_success '--drop-filtered fails with --write-bitmap-index' '
+	test_must_fail git -C plain.git repack --drop-filtered \
+		--filter=blob:limit=1k --dry-run -a -b 2>err &&
+	test_grep "options .--drop-filtered. and .--write-bitmap-index. cannot be used together" err
+'
+
+test_expect_success '--drop-filtered rejects explicit -b even when repack.writeBitmaps=true' '
+	test_must_fail git -C plain.git -c repack.writeBitmaps=true \
+		repack --drop-filtered --filter=blob:limit=1k --dry-run -a -b 2>err &&
+	test_grep "options .--drop-filtered. and .--write-bitmap-index. cannot be used together" err
+'
+
+test_expect_success '--drop-filtered fails without a promisor remote' '
+	test_must_fail git -C plain.git repack --drop-filtered \
+		--filter=blob:limit=1k --dry-run -a 2>err &&
+	test_grep "drop-filtered requires a promisor remote" err
+'
+
+test_done
-- 
2.54.0

