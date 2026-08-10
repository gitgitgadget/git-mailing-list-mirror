Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212F0431E6E
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383674; cv=none; b=dGoVTfbJD77H15NkRVdEKrL2s1qK5Ps8ym7G/eDFcvCJzLeCO/R02qG4DX4uv7Qx4Vn3D9E1YOEOqzmxNMp9KypccI77Y+RBP1wZ4Y8MBTHTn74pSW6x3stXoIOAStlDsLdFLiKHtWjPOqx5jCw2WLH9T/folvkLl554v9lyqfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383674; c=relaxed/simple;
	bh=c7Es31idI8En5Ybvr5toWK/1R/LPEAAfCAcN6wI7lhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk7Sd+6jHzp0rJ5uWZPYJDqx1z9OXfpmkay3Wnm8UOWDWXi+AxeHLzITWdaHDjTSdAI0n5eLX/Hq0Y6JTNnfs82r5uCo4EgSFEOMIh+gyInCHSJCgtDNwEXb2W39lZ1f9eDq+BNO39uZIa9tsbN383lU0jFLjr7rfr0tz0PQncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdnFIiMl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdnFIiMl"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso2207632b3a.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 10:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786383672; x=1786988472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhjmlNM3GXLYo2/3ZE6lej1m3GkMQxDy3HuHP3MafAc=;
        b=SdnFIiMlp4L69XAYH2qPrCOsS+/uhzEgOa5DLkJQf1yRE3q32gHaGyCM45UEaOy7hJ
         0U2Z0TaDoWQaJXPSvZJWyoro4UXQZXRcsR+3tZPUs+4Fru8TlzQwHZPPGVxQC/Dsvmn+
         8PepE9UrETogp69HXqd9w1IU6T8kIzFCQDdwVSm93ac30AEyXOnGkrDGkqpbgI+E1Gw4
         k7zM5+EUY1I/eMaFmIk+ZW/GnEVIzaS4yWZS2yte3+akMY1RAaAdmJYttzfawdd9fNtD
         KCaJdfE4nJ2hM1v54OMO6cWasBfoqeUwGjwcIwPM/O6liuzxEGGBRFmO01F3gJOXY8Vt
         he0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786383672; x=1786988472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhjmlNM3GXLYo2/3ZE6lej1m3GkMQxDy3HuHP3MafAc=;
        b=MDL9jZwDDx5XEOLuh0oBnM+7fnpTyF0jDxl2fsWkmLF0wx4iFfH2jTh15ONgT7MQlM
         dAE+gAL8QBcqpYwB/L1+7xGiygTVZak+2lDTVw6WoEdD0lj+VqDaXnpdsOmFRbYjD3dn
         2Wu2h4lzFU9nlNyH19wsKEeg8wF4zA26Loj/vPzNrxYzAQd6+NO8UD16R5c45VJSfw2N
         vijS/M0F8E2ItgerffVjOQ7K/+BiHFRRziIphsHBHRyUq18Hh81sQj29LMTSNWS7EQLm
         IP3ZBrk9aYvS09xlgvz2YH4Yf+z0BcnF8LU/vFtGbkdGSvYFhDWFR47DJpvKgkT2KxZS
         cqBg==
X-Gm-Message-State: AOJu0Yz89CPIW5ZWosoGzehgIJjQbummvvq+KzfUObp9Z7QsKlvxGAaY
	gch0nF12j3lh4tU51K+01hCSSx+D8MTyNoyfyoXz+SWvWFYmrNsOSzqZJXGmHiPz
X-Gm-Gg: AR+sD11d1P1qmLiiSzdfUKm3i+nIL21zOZSz7q1b447Av4rqOC52rhT47KZbpMrBCr5
	qsBYxyre9ZGD/BNnVnSWtA3j91KbAhb+iVgUP3bde8c9eGl+Sqw81oLfLdTkSlNdMZFMX/TU5AP
	W6sNhNLYk1rFHg45kNHZqJiPwZwqGoiZZhYyAXS0AgemA+oweDlxQ1q1Lx0nlZbbO+d+x3TJTTA
	TfGysUa3U5D97ol+pPpYLUA99/m8FX9ZZJycyHcMNO4xLYyJXrZUujNuTU8shumKWUKLYqNHkmh
	NG85AkQpjgv27FPTDtkb3ZgyIt8FydYEwzXcX9bqQwobzs+fMgMv8bEMqX05ctGCm4yB9i4ItCK
	2Z33J5xkB9ko0hDP3jSau5bVWX2VStD3rwspMOrXzVrGuchdnLVWl93fm7PpJx3yw3X0meG3eYF
	UnhL92MB2o7CuZSzhraznltgqLXhlJvLlkQZ95zKjMik87rHxCA1ThgrQnduZB8g7tdxuDEfTg/
	8ZLAtTjIlc4mw/BQcPox15X8d6Sdoyo0ZYShJaVWPGxK9uTuYuA6TVbAcjnSwo5zHJ7oDflLjXk
	11DUNdjj66alRw3XNtdEeg==
X-Received: by 2002:a05:6a21:1193:b0:3c3:7fa2:9618 with SMTP id adf61e73a8af0-3cbce9e8db5mr27014683637.37.1786383672037;
        Mon, 10 Aug 2026 10:41:12 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5026:8db8:20aa:c615:9a47:206a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101b7b39bsm36865585c88.14.2026.08.10.10.41.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Aug 2026 10:41:11 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	ttaylorr@openai.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v4 1/7] builtin/repack.c: add --drop-filtered and --dry-run options
Date: Mon, 10 Aug 2026 23:10:41 +0530
Message-ID: <20260810174047.6524-2-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
References: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
 <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
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
 builtin/repack.c                | 74 +++++++++++++++++++++++++++++++--
 t/meson.build                   |  1 +
 t/t7706-repack-drop-filtered.sh | 55 ++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 3 deletions(-)
 create mode 100755 t/t7706-repack-drop-filtered.sh

diff --git a/builtin/repack.c b/builtin/repack.c
index db504d673f..19b26ca723 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -14,6 +14,7 @@
 #include "promisor-remote.h"
 #include "repack.h"
 #include "shallow.h"
+#include "list-objects-filter-options.h"
 
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
@@ -28,11 +29,15 @@ static int use_delta_islands;
 static int run_update_server_info = 1;
 static char *packdir, *packtmp_name, *packtmp;
 static int midx_must_contain_cruft = 1;
+static int drop_filtered;
+static int dry_run;
+static int write_bitmaps_given;
 
 static const char *const git_repack_usage[] = {
 	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
 	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
-	   "[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]"),
+	   "[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]\n"
+	   "[--filter=<filter-spec>] [--drop-filtered [--dry-run]]"),
 	NULL
 };
 
@@ -111,6 +116,21 @@ static int repack_config(const char *var, const char *value,
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
@@ -194,8 +214,9 @@ int cmd_repack(int argc,
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
@@ -231,6 +252,10 @@ int cmd_repack(int argc,
 			   N_("pack prefix to store a pack containing pruned objects")),
 		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
 			   N_("pack prefix to store a pack containing filtered out objects")),
+		OPT_BOOL(0, "drop-filtered", &drop_filtered,
+				N_("delete filtered out objects (requires --filter)")),
+		OPT_BOOL(0, "dry-run", &dry_run,
+				N_("only show which objects would be dropped")),
 		OPT_END()
 	};
 
@@ -252,6 +277,49 @@ int cmd_repack(int argc,
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

