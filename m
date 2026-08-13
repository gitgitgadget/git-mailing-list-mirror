Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207973FD132
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 20:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651738; cv=none; b=K1cRt08S5KxrfeEbhCYZKCCLDQbRPE/z82mwg5Q0JzaFaWXiTjl64EUmT2I7U+REGEef4uyG5MZM4kfwcSafn5rn/ypWftg7QwaOwMojJQCTDzsN0Rsn6jhjCTRkfe1rdTWEE0abs10lLFuXPLVBDSj66mIqxMfVa58wOuemKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651738; c=relaxed/simple;
	bh=U7ecF1FgI8bQFuPvEjXG1kTf1a3PL+DlNnzVX0xqqpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbFsAfC47hf5oLRYeD4x5r3TnNyQhaWkGQ+QXWBXIeifI48u3MQy3EBoE1RaeDHp/0rRgeGPtS3ELObvYb1v9rfiitP9Da/lNq3H0Lo7H+vi49ze5mx35Tt1CkmDHqmI4r6ti1M8w705D5XNmYFluk4qpURcM6aTRO1YriXTvRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvoUI/7y; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvoUI/7y"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9aea40d799so138438a12.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 13:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786651735; x=1787256535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sMfeVTqcLcF4mv6c5e8aN4H4XQIB+mXPiTom2Bmh1kA=;
        b=bvoUI/7yykWkzIo7n+3CZ8aH3PG8LJn4Yyx/XfozGBWD/stk0SJE0Pe8THmcEhZNJr
         4vqr8Go3ESKxUDU5wFe+BSktf5endDEo4Ws9WGqMQ0P0rcju6ZSddzPcMjjHgJK4hLj1
         KWTJlqWfcB6gc7xZye1owcL3QwyB/vZU4ixstSGEQpQRfkCcX8RVm3+9vnZiN/Gd31dX
         dfedH3KN8JzQcaY8BsOs/l9jdYJaG3Wwr+RBJZKiyb5Cgk0h5hro9/kcOafZvu3PV6bZ
         CWiIkIn96zWqFKfMBQ4bQKebO/QoMH8Ejw9Jv7/1AVP2DRzhfn81ysg04cLbnEeawYPq
         8KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786651735; x=1787256535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sMfeVTqcLcF4mv6c5e8aN4H4XQIB+mXPiTom2Bmh1kA=;
        b=ITdBID17Z8CvZ4NfYJp8/VeuHDHAcxEogGN/+BeRaLElFgKP4zuatHXDoakhtuZEcT
         UPxtoFF0yXFZHNlfPhCsovLVnrnCqON9uxz4IKaK56xxTIQb3yrmMqDxPAa+wqfVjoNk
         vBZPXQYcciq9wHcznlMao44OITGX1AfkS/fQqDfqNxQrWu/wP1mMhEUU7wkxa+rY1na1
         YBIvEOzZ2RUNuxB1SLQZhEJlMzXluoj5ewNVM+wVDpAkAoVjbQOCVTdFTlr2JuZIuyGt
         YBj1l0Q56bkOybjQL0kLaohR8xvZCM29Cg/BstVz3s2imo10kb9FZYH1FrZdG78PE188
         CUoQ==
X-Gm-Message-State: AOJu0YxDlntOFdlaDnXPT8HK9EzNRCs6YhfI64xwTfruPpOBBGC2TmG4
	dhnNmeHFP2Fb2yx6eJmhS2/+zYyJJ/adMru9FZR1WYCYktiuB+F7yYbW6k85XUk8
X-Gm-Gg: AR+sD11DCg5Ws8YELZJifOpgYeLaBT1/2cVv7hYVp5o+KGmV0LeVkmxuFlNEcGsrI3e
	jiXqGgXwcMhVQyPMnHalH2JiElCgiCan0Qe05IgXvrCFUqvfOkNvZ1gTJd3weV79k9/usrweq3V
	8SrrEvVVEsSOiBY3xRwSSscgm0c6aH4FKQ+Fyhfjj3I3LfP5b1VZrY/22YZ5QUmyxjSOfipnq0t
	4M7QsiMkiZCD57X4Ae4OIp5a9/QC3O7F5cH96rhWB4fVCd54/D8iRdb6BTDGL/YCwC5ZBgx6PQE
	ishRt6SjLGFkHPpmwNy6pDDeyjBlrjEtUN8vwdT5nhSZTPPaJw7E1pwVROsIQBv0pMRqXmUCzrP
	oagke1tkQdhSMyXGUtGPyPUuyyGEzR8bVpzuNX4D8Pb5T8UytV77a7VM4T06Xx7YO3b7w19Iksl
	X6M8uQX2nx+Oh7vixr3D9RrDY5CDsz4mFo470EjXnf+TBz2z8dNsaI3GosmWpdnXdTPqf9NeT8f
	pqyU9WPOyOgSSdOwJFekTs1Swyk8iLHGTbOUwWnQVMejrunmnjprgY2yfTbP9wxgijY+cSjzzd7
	MFKorvnHgy7kq4XI/6bpSprFLiXCXd3W
X-Received: by 2002:a05:6a21:458f:b0:3bf:6237:4d49 with SMTP id adf61e73a8af0-3cc71c93b4bmr386629637.23.1786651735127;
        Thu, 13 Aug 2026 13:08:55 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:ad47:4055:841d:89ad:96b0:2f73])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387c6f95sm1533440c88.6.2026.08.13.13.08.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 13:08:54 -0700 (PDT)
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
Subject: [GSoC PATCH v5 1/6] builtin/repack: add --drop-filtered and --dry-run options
Date: Fri, 14 Aug 2026 01:38:25 +0530
Message-ID: <20260813200830.84348-2-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813200830.84348-1-r.siddharth.shrimali@gmail.com>
References: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
 <20260813200830.84348-1-r.siddharth.shrimali@gmail.com>
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
--drop-filtered (e.g. --drop-filtered=dry-run), to stay consistent with
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
index db504d673f..ed79c04e13 100644
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
+				N_("write bitmap index"),
+				PARSE_OPT_NOARG, option_parse_write_bitmaps),
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
+			die(_("--drop-filtered does not work without --dry-run yet"));
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
+		 * An explicit -b on the command line is a conflict we have to
+		 * report; a bitmap setting from config is silently overridden
+		 * for the duration of the command.
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
index 0000000000..07a976874a
--- /dev/null
+++ b/t/t7706-repack-drop-filtered.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='git repack --drop-filtered option validation'
+
+. ./test-lib.sh
+
+# Check option validation before any promisor walk
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

