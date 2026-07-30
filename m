Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB2D445AE5
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433351; cv=none; b=H9f4o5Vis2zpgV3cQzwv0U6N3dwCvdBBCSK43Bg4FypT+weStzT+Rdene7CZG0ldP4krI4UmUAr1Tng1gtAroAMNOSpUO2aDgl3GD9nvSbu8WTGvK+u+bq2wmVN1ltyQX+U/pj3AvXFbq2SKHrdH10UIxv6De3NQi3Jgrc7OUmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433351; c=relaxed/simple;
	bh=BHhL5pVqbjIuYKlBdTMRdeluaSmB4pmH0eMhHetBj60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGNEFd6PrHoZelhQzVgUAQX28XDAdTlOK/lBHkUVCuR4J245+fCB01v/xhdPtEOVNU8HYSI5i1WqYYUzwpcRKoGUxFB9ttV6X1SWxdEm85L+rnIOtGPdjr8a3ke40nHQeylRCla+/tVOzgfGI9uwRx/DzCNX+AJPbBonlMqmFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGRvNEPz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGRvNEPz"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cf452def93so8653685ad.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 10:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785433347; x=1786038147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p6giAzWzRx5F9EM/qy1QHLLykLaj7RN0TJJSGZCyyII=;
        b=bGRvNEPzMcL0C/FTtiBRqtuQDhn3p0P3HOnmhIJSpuKvrxITlMvYqhPopz7+DxBgbO
         IBsnVNP6FSnMAO9WnzWrLa8avP8zggpyPArriRxl8aZ4RsY9bMM7/AHw5WeYrDUqFGdZ
         BnSjGE+Tfvk1WDT5NwHkZ1NEUndTLGc0LhiTipS6Ziyn46dIdvt0r1T6ql0LMhB2oXiQ
         DQ2ysQBYVoIY0II36DhOLyiALSS2GZCFCw9EfUtyP8bU28I46hyA3HdjSQlWi55sZhIx
         j7GDBjpkw59B5xdtvvADnatPERZfTzQ01Sl6NKwfr6RSrlIrQI5dZo1vofDpnI7q3ckJ
         uwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433347; x=1786038147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p6giAzWzRx5F9EM/qy1QHLLykLaj7RN0TJJSGZCyyII=;
        b=OhKBI37E3U1EziZ4J0dcWg/NSt0VZvcPU+s7VWkIis/vvU+F4soNiwlgAy28XF9vyA
         sOd+0Xrxf+NzviP4NCMfyAGgiKvpflKObRxeU6ZM0dUzqr4/dZCZ9WTPmXFlgvedEnhY
         43sz4nIU3sD9/QbX1e0db8qI2kSn8LQLQm5UtO81xbbfNQLQAo+FEGWIPj90Jhc6rcOU
         tnuPgNPF5b8qgJM4Mz8K8s2tI7eFpvt4pvTx5uEiXrrLIF3g0i5p3Ltal5dOvMpK+WUH
         8vG8Wb5+U8wwFoCt8SQfCd4Fj8eIUs0b6E8Eq9gcshSOVofiVQ/Lwn5I3IsQKFE4jNt3
         dmEw==
X-Gm-Message-State: AOJu0YyIEZMi+EcggT6SSIKKMfz6S5G3xEstOjqR4Yf23VWrcfnl6sHh
	B87lOefnUrhni/wucus8TrU/vO4t8RyCWXaU0NfpG0j+yC/1WvdKF6ZTINBQuA==
X-Gm-Gg: AR+sD12PF/uaLzXYidmpSeuFDqaZCB9s+9J6N5qkvoQThk69574WN4r8s3dWZbZQM3d
	SJCkSISRuenqnr708VCE2SpmSBrJcUZcvW2H9V3xEULcSHBAZPB3MegnQO2WgecqOsvflft97pF
	Qg8XkLNHn1xNZ/LPTtnrnduCAu3QMb4EQB31CRP7acof+oPgutxwo6ZA420GTwMZGOKHdm0w2AT
	DmGDfoOb/AOHUSOuJ1N6oGUJGrBLL5VBChs/isPxvvlcgDqrWJO4SizTydkJyOzMfHaUW2mWEwL
	+UYQ3CdrwTXy6eAVJfmlp/fOH6I02GVDjy35xFh49g0K6qXi0gTZX4awcl09QJIRTPuMbRc49ag
	vvai+ahwgY+xHG7poMLPt5m2mLK1XkvVX02QNk+RD0FhAmFOYpdXgPX5u7h6sarPejnYGwqXtY7
	C3HPKOi/DPD21k33X5ktDPte3tBRyutlw4iEWF4qnv5uE2iNgyuj1r8aj6xRZ5S7k7tadDzG1Jr
	zvTcw7p8dagUnv3cn54Uang/PF98S/D0srh9OaSl75RCPw5nlqhQDrMKIKKlr+/JzwB4oWG3rlL
	AmNbeq51qMqaS2LSXmUKB5V49kI=
X-Received: by 2002:a17:902:d2d0:b0:2cf:461a:3863 with SMTP id d9443c01a7336-2d03e39db6dmr11669195ad.22.1785433347072;
        Thu, 30 Jul 2026 10:42:27 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5622:d88b:20c4:5444:d41a:b6c2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc9dffsm25163964eec.14.2026.07.30.10.42.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 10:42:26 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v2 1/7] builtin/repack.c: add --drop-filtered and --dry-run options
Date: Thu, 30 Jul 2026 23:11:47 +0530
Message-ID: <20260730174153.9949-2-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
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
the "all objects in one pack" closure that bitmaps require. Snapshot
the bitmap setting after config but before option parsing so an
explicit -b/--write-bitmap-index on the command line can be told apart
from a repack.writeBitmaps configuration value. An explicit -b is
reported as a conflict, while a config-provided default is silently
disabled for the duration of the command.

These options currently only perform validation. The actual enumeration
and deletion will be added in follow-up commits.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 builtin/repack.c                | 63 +++++++++++++++++++++++++++++++++
 t/meson.build                   |  1 +
 t/t7706-repack-drop-filtered.sh | 49 +++++++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100755 t/t7706-repack-drop-filtered.sh

diff --git a/builtin/repack.c b/builtin/repack.c
index db504d673f..322b01cb3e 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -14,6 +14,7 @@
 #include "promisor-remote.h"
 #include "repack.h"
 #include "shallow.h"
+#include "list-objects-filter-options.h"
 
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
@@ -28,6 +29,8 @@ static int use_delta_islands;
 static int run_update_server_info = 1;
 static char *packdir, *packtmp_name, *packtmp;
 static int midx_must_contain_cruft = 1;
+static int drop_filtered;
+static int dry_run;
 
 static const char *const git_repack_usage[] = {
 	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
@@ -148,6 +151,7 @@ int cmd_repack(int argc,
 	/* variables to be filled by option parsing */
 	struct repack_config_ctx config_ctx;
 	int delete_redundant = 0;
+	int write_bitmaps_before_parse;
 	const char *unpack_unreachable = NULL;
 	int keep_unreachable = 0;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
@@ -231,6 +235,10 @@ int cmd_repack(int argc,
 			   N_("pack prefix to store a pack containing pruned objects")),
 		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
 			   N_("pack prefix to store a pack containing filtered out objects")),
+		OPT_BOOL(0, "drop-filtered", &drop_filtered,
+				N_("delete filtered out objects (requires --filter)")),
+		OPT_BOOL(0, "dry-run", &dry_run,
+				N_("only show which objects would be dropped")),
 		OPT_END()
 	};
 
@@ -244,6 +252,13 @@ int cmd_repack(int argc,
 
 	repo_config(repo, repack_config, &config_ctx);
 
+	/*
+	 * update the bitmap setting after config but before command line
+	 * parsing, so we can later tell whether -b/--write-bitmap-index was
+	 * given explicitly on the command line or not
+	 */
+	write_bitmaps_before_parse = write_bitmaps;
+
 	argc = parse_options(argc, argv, prefix, builtin_repack_options,
 				git_repack_usage, 0);
 
@@ -252,6 +267,54 @@ int cmd_repack(int argc,
 	po_args.depth = xstrdup_or_null(opt_depth);
 	po_args.threads = xstrdup_or_null(opt_threads);
 
+	die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
+		!!filter_to, "--filter-to");
+
+	die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
+		write_bitmaps > 0, "--write-bitmap-index");
+
+	if (dry_run && !drop_filtered)
+		die(_("--dry-run only takes effect with --drop-filtered"));
+
+	if (drop_filtered) {
+		int bitmaps_from_cmdline = (write_bitmaps != write_bitmaps_before_parse);
+
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
+		if (bitmaps_from_cmdline && write_bitmaps > 0)
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
index d8161c368b..c2bf60d129 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -963,6 +963,7 @@ integration_tests = [
   't7703-repack-geometric.sh',
   't7704-repack-cruft.sh',
   't7705-repack-incremental-midx.sh',
+  't7706-repack-drop-filtered.sh',
   't7800-difftool.sh',
   't7810-grep.sh',
   't7811-grep-open.sh',
diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtered.sh
new file mode 100755
index 0000000000..65be756e33
--- /dev/null
+++ b/t/t7706-repack-drop-filtered.sh
@@ -0,0 +1,49 @@
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
+test_expect_success '--drop-filtered fails without a promisor remote' '
+	test_must_fail git -C plain.git repack --drop-filtered \
+		--filter=blob:limit=1k --dry-run -a 2>err &&
+	test_grep "drop-filtered requires a promisor remote" err
+'
+
+test_done
-- 
2.54.0

