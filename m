Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A99C4332F
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiBXQtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiBXQtL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:49:11 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7699F1A94BE
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:48:40 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so146639wmp.5
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lg9DwJID4DjPDFlYsI8DFYnbZhMDDJ3IHcq0B/LcPKM=;
        b=SJhL7KEDMahRoX907+qdHT+72TLX8QDQeZXC7+b0A90/94DvmSc/WJuPQgiOUxB2k2
         H0psCkaQ7IPgjmKFMl/wnHreXq2w/z2tIO59gPwb9fm3DpOh10rHZQmjgxuY7NIfZH7B
         VStKHi2K1XKK0z/T9OP5GXmWo7XJBnuds2dR4lgbRuiJDgB2Atj4LwC6eeGWPzsjkCGx
         dZJSUyCiNCgHfiCmrIujNBD9SYP7nhCzxdzbIDPmcwYy5gnXcRpV+dCH+PSwCqhRJB9/
         TLlpx3LXqUFA2vaC3SyI+h+xLZ08kU0jXamGjWAYEwiH7OfqV4dOqjoHfsouyhVPsHcS
         oEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lg9DwJID4DjPDFlYsI8DFYnbZhMDDJ3IHcq0B/LcPKM=;
        b=7LwC3dec50t4QOUYeBRcev5pwn1LT5yh++312k1OYrzKkveuN3+ktM2LgUOW3ioXIN
         YbPAErYpu+UrNOYemZ4jqxHUsY3UqWG6IaXQdbNpUTSlNC/D11zgTh2RxECC2Ca4Rxuh
         ShkoUq7eCV877kyTBsUFZ4VWLgR+HIO+KpuE60mCTFUzRizdFvdqI/sif/hKxss6Cfft
         YlXOV6PNPgKKs7eKShJXfllBICSRmmuZZ92jjiCIariNBQ7HpITKHjhpzW0V9PE/Y5iD
         N5aH94ZdussGyV3+VrP6mJTbCVQWbOGLs/SJByuC9OjEmYkwJtM6Q9W83i8kh0LqGO+h
         4SVw==
X-Gm-Message-State: AOAM530i5ze2+rqszJNj1t210+h4e58Q77ww7pm7EDqLIV6nG6QMLK/y
        04E8/LfT2aRCuM9DwOXPu0WJdIZWjKg=
X-Google-Smtp-Source: ABdhPJy+eyGxOkDxo8kkszGMmt1jrnkrETMD3g3++n77hg01+OFrR2AlHFM8V2Ycxpy3hyjpSCp4ow==
X-Received: by 2002:a1c:2742:0:b0:37b:b481:321f with SMTP id n63-20020a1c2742000000b0037bb481321fmr2967638wmn.56.1645719226318;
        Thu, 24 Feb 2022 08:13:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x2-20020a7bc762000000b00380fd1ba4ebsm4484118wmk.9.2022.02.24.08.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:13:45 -0800 (PST)
Message-Id: <2338c15249a3a58032bc1f8b0cd029f3897b4e88.1645719219.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
        <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 16:13:37 +0000
Subject: [PATCH v2 7/8] fetch: after repair, encourage auto gc repacking
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

After invoking `fetch --repair`, the object db will likely contain many
duplicate objects. If auto-maintenance is enabled, invoke it with
appropriate settings to encourage repacking/consolidation.

* gc.autoPackLimit: unless this is set to 0 (disabled), override the
  value to 1 to force pack consolidation.
* maintenance.incremental-repack.auto: unless this is set to 0, override
  the value to -1 to force incremental repacking.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 Documentation/fetch-options.txt |  3 ++-
 builtin/fetch.c                 | 23 +++++++++++++++++++++--
 t/t5616-partial-clone.sh        |  6 ++++--
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 1131aaad252..73abafdfc41 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -169,7 +169,8 @@ ifndef::git-pull[]
 	associated objects that are already present locally, this option fetches
 	all objects as a fresh clone would. Use this to reapply a partial clone
 	filter from configuration or using `--filter=` when the filter
-	definition has changed.
+	definition has changed. Automatic post-fetch maintenance will perform
+	object database pack consolidation to remove any duplicate objects.
 endif::git-pull[]
 
 --refmap=<refspec>::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f32b24d182b..7d023341ac0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2020,6 +2020,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	struct remote *remote = NULL;
 	int result = 0;
 	int prune_tags_ok = 1;
+	struct strvec auto_maint_opts = STRVEC_INIT;
+	int opt_val;
 
 	packet_trace_identity("fetch");
 
@@ -2226,10 +2228,27 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 					     NULL);
 	}
 
-	if (enable_auto_gc)
-		run_auto_maintenance(verbosity < 0, NULL);
+	if (enable_auto_gc) {
+		if (repair) {
+			/*
+			 * Hint auto-maintenance strongly to encourage repacking,
+			 * but respect config settings disabling it.
+			 */
+			if (git_config_get_int("gc.autopacklimit", &opt_val))
+				opt_val = -1;
+			if (opt_val != 0)
+				strvec_push(&auto_maint_opts, "gc.autoPackLimit=1");
+
+			if (git_config_get_int("maintenance.incremental-repack.auto", &opt_val))
+				opt_val = -1;
+			if (opt_val != 0)
+				strvec_push(&auto_maint_opts, "maintenance.incremental-repack.auto=-1");
+		}
+		run_auto_maintenance(verbosity < 0, &auto_maint_opts);
+	}
 
  cleanup:
 	string_list_clear(&list, 0);
+	strvec_clear(&auto_maint_opts);
 	return result;
 }
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 230b2dcbc94..60f1817cda6 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -187,7 +187,7 @@ test_expect_success 'push new commits to server for file.4.txt' '
 # Do partial fetch to fetch smaller files; then verify that without --repair
 # applying a new filter does not refetch missing large objects. Then use
 # --repair to apply the new filter on existing commits. Test it under both
-# protocol v2 & v0.
+# protocol v2 & v0. Check repacking auto-maintenance is kicked off.
 test_expect_success 'apply a different filter using --repair' '
 	git -C pc1 fetch --filter=blob:limit=999 origin &&
 	git -C pc1 rev-list --quiet --objects --missing=print \
@@ -199,11 +199,13 @@ test_expect_success 'apply a different filter using --repair' '
 		main..origin/main >observed &&
 	test_line_count = 2 observed &&
 
+	GIT_TRACE2_EVENT="$(pwd)/trace.log" \
 	git -c protocol.version=0 -C pc1 fetch --filter=blob:limit=29999 \
 		--repair origin &&
 	git -C pc1 rev-list --quiet --objects --missing=print \
 		main..origin/main >observed &&
-	test_line_count = 0 observed
+	test_line_count = 0 observed &&
+	test_subcommand git -c gc.autoPackLimit=1 -c maintenance.incremental-repack.auto=-1 maintenance run --auto --no-quiet <trace.log
 '
 
 test_expect_success 'fetch --repair works with a shallow clone' '
-- 
gitgitgadget

