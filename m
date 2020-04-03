Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC68EC2BA1A
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BAB20737
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDKRMGec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgDCUsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:48:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36544 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgDCUsW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 16:48:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id i7so10945611edq.3
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 13:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4YVMGCNoUoYnEhdsv8Sz5uThwH/6empGMKsEKfxUeEQ=;
        b=SDKRMGecX52MvJSIrMLxZ8c5lFRTNatLbqrUREfEtkY9oMabzSpuq0govXBfTn7FGz
         mSbVfgYm8gskgz9bmeOPGPQLL3Ioj0ojjbAJA08cPtanv58psj4QCKKtPrdktmfF4ha6
         zQM0NNrQbvr9qIDVsyCJ/KVoOalOTMJZgesEBLwIDX6i7IACcqtjB4Xd2lNDoBWxW7Zr
         FxNvwjv89IhfAC65GAko4pyS/jtBt/sGjbkp59yE6rKi/lijPuheYnj/w6NH1/pIdGd7
         wADFuhkcXrYFrHf8TnDRggDNPOm7UF4IB8YKEZlCnYFHNrMOhhzGFkFs7wUlDCSZR54z
         zwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4YVMGCNoUoYnEhdsv8Sz5uThwH/6empGMKsEKfxUeEQ=;
        b=m3/uuUWALiNOxIVUmMTBYT5XuqP8Lbhm9YSdLo/rinbaYDQx7RzP7ivNZcahZWRD1I
         oKh6glD7jsx76TG3f5ePXcp9lkKX7UGe1M18qru5ixPrikmaPnX+ad5FQYlBcmKGdyNZ
         MwiI0gHYrJxtoPR+0+v772dqwW39fqj5QG2Hr7yAOWp4BTqebi6IygtMVGlza+CNg+SO
         tRfzWLd+3QAehhfevvt0VZul2QAS4SGnLxaVzaTS0v7dedXSK9WIx4wUGqymNIAizSQH
         6mlHwnvjHJ0EaY0+z9eVIM1VblZrFeCjwHZjC4WFObCQStb1bcfESp2O5G9+QpHeIF+F
         SaDQ==
X-Gm-Message-State: AGi0PubZVLTezaQQ7t+p4ruODSZVx5G5FKmjB8tMRPXoDXD+0fnvhbUJ
        azcbVXWPZEtuMzpVxf5XMdDZvmXd
X-Google-Smtp-Source: APiQypLc2GKWPJ7VcN7NStvegpqbc0VyP4rxBSk/QFSfosID4a+QmTpOL3mbKMMnrk2bdH+WYHIHLA==
X-Received: by 2002:aa7:c14a:: with SMTP id r10mr9144745edp.340.1585946900113;
        Fri, 03 Apr 2020 13:48:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n62sm1562767edc.74.2020.04.03.13.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:48:19 -0700 (PDT)
Message-Id: <c39a35a959e485623aacdbbecc1fce7d16a956c9.1585946894.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.597.git.1585946894.gitgitgadget@gmail.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Apr 2020 20:48:05 +0000
Subject: [PATCH 06/15] run-job: auto-size or use custom pack-files batch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When repacking during the 'pack-files' job, we use the --batch-size
option in 'git multi-pack-index repack'. The initial setting used
--batch-size=0 to repack everything into a single pack-file. This
is not sustaintable for a large repository. The amount of work
required is also likely to use too many system resources for a
background job.

Update the 'git run-job pack-files' command by allowing a direct
--batch-size option that can change the value provided. Update the
default of "0" to a computed size based on the existing pack-files.
While computing that new size, count the existing pack-files and
skip the repack step if there are at most two pack-files.

The dynamic default size is computed with this idea in mind for
a client repository that was cloned from a very large remote: there
is likely one "big" pack-file that was created at clone time. Thus,
do not try repacking it as it is likely packed efficiently by the
server. Instead, try packing the other pack-files into a single
pack-file.

The size is then computed as follows:

	batch size = total size - max pack size

The batch size is then also limited to be at most two gigabytes.
This serves two purposes. First, having a limit prevents doing too
much work when the repository is extremely large. Pack-files
larger than two gigabytes are likely to either contain large blobs
or have been carefully repacked by a previous repack operation.
Second, two gigabytes is the size limit for a signed 32-bit int.
It's a good limit to consider, and to keep it far away from the
unsigned 32-bit int limit. This limit comes to mind because on
Windows an "unsigned long" is 32 bits and OPT_MAGNITUDE() uses
unsigned longs for its parsing logic.

This calculation mimics a similar calculation in Scalar [1],
except for a 3% drop in the calculated batch size due to the
round-off error that can happen with the "expected size"
calculation for a pack-file.

[1] https://github.com/microsoft/scalar/blob/616e9b16dd120b8fdb652d6d5a55618c731a8aea/Scalar.Common/Maintenance/PackfileMaintenanceStep.cs#L141-L143

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-run-job.txt | 13 +++--
 builtin/run-job.c             | 90 ++++++++++++++++++++++++++++++++---
 t/t7900-run-job.sh            |  6 ++-
 3 files changed, 96 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-run-job.txt b/Documentation/git-run-job.txt
index 108ed25b8bd..cdd6417f7c9 100644
--- a/Documentation/git-run-job.txt
+++ b/Documentation/git-run-job.txt
@@ -9,7 +9,7 @@ git-run-job - Run a maintenance job. Intended for background operation.
 SYNOPSIS
 --------
 [verse]
-'git run-job (commit-graph|fetch|loose-objects|pack-files)'
+'git run-job (commit-graph|fetch|loose-objects|pack-files) [<options>]'
 
 
 DESCRIPTION
@@ -82,9 +82,14 @@ only happens if all objects in the pack-file are also stored in a newer
 pack-file. Second, it selects a group of pack-files whose "expected
 size" is below the batch size until the group has total expected size at
 least the batch size; see the `--batch-size` option for the `repack`
-subcommand in linkgit:git-multi-pack-index[1]. The default batch-size is
-zero, which is a special case that attempts to repack all pack-files
-into a single pack-file.
+subcommand in linkgit:git-multi-pack-index[1].
++
+The default batch size is computed to optimize for having a single large
+pack-file and many small pack-files. When there are two or fewer
+pack-files, the job does not attempt to repack. Otherwise, the batch
+size is the sum of all pack-file sizes minus the largest pack-file size.
+The batch size is capped at two gigabytes. This intends to pack all
+small pack-files into a single pack-file.
 
 
 GIT
diff --git a/builtin/run-job.c b/builtin/run-job.c
index d3543f7ccb9..2ccc3bbae2d 100644
--- a/builtin/run-job.c
+++ b/builtin/run-job.c
@@ -3,12 +3,18 @@
 #include "commit-graph.h"
 #include "midx.h"
 #include "object-store.h"
+#include "packfile.h"
 #include "parse-options.h"
 #include "repository.h"
 #include "run-command.h"
 
 static char const * const builtin_run_job_usage[] = {
-	N_("git run-job (commit-graph|fetch|loose-objects|pack-files)"),
+	N_("git run-job (commit-graph|fetch|loose-objects|pack-files) [<options>]"),
+	NULL
+};
+
+static char const * const builtin_run_job_pack_file_usage[] = {
+	N_("git run-job pack-files [--batch-size=<size>]"),
 	NULL
 };
 
@@ -278,15 +284,74 @@ static int multi_pack_index_expire(void)
 	return run_command_v_opt(cmd.argv, RUN_GIT_CMD);
 }
 
-static int multi_pack_index_repack(void)
+#define TWO_GIGABYTES (2147483647)
+
+static off_t get_auto_pack_size(int *count)
+{
+	/*
+	 * The "auto" value is special: we optimize for
+	 * one large pack-file (i.e. from a clone) and
+	 * expect the rest to be small and they can be
+	 * repacked quickly. Find the sum of the sizes
+	 * other than the largest pack-file, then use
+	 * that as the batch size.
+	 */
+	off_t total_size = 0;
+	off_t max_size = 0;
+	off_t result_size;
+	struct packed_git *p;
+
+	*count = 0;
+
+	reprepare_packed_git(the_repository);
+	for (p = get_all_packs(the_repository); p; p = p->next) {
+		(*count)++;
+		total_size += p->pack_size;
+
+		if (p->pack_size > max_size)
+			max_size = p->pack_size;
+	}
+
+	result_size = total_size - max_size;
+
+	/* But limit ourselves to a batch size of 2g */
+	if (result_size > TWO_GIGABYTES)
+		result_size = TWO_GIGABYTES;
+
+	return result_size;
+}
+
+#define UNSET_BATCH_SIZE ((unsigned long)-1)
+static int multi_pack_index_repack(unsigned long batch_size)
 {
 	int result;
 	struct argv_array cmd = ARGV_ARRAY_INIT;
+	struct strbuf batch_arg = STRBUF_INIT;
+	int count;
+	off_t default_size = get_auto_pack_size(&count);
+
+	if (count <= 2)
+		return 0;
+
+	strbuf_addstr(&batch_arg, "--batch-size=");
+
+	if (batch_size != UNSET_BATCH_SIZE)
+		strbuf_addf(&batch_arg, "\"%"PRIuMAX"\"", (uintmax_t)batch_size);
+	else
+		strbuf_addf(&batch_arg, "%"PRIuMAX,
+			    (uintmax_t)default_size);
+
 	argv_array_pushl(&cmd, "multi-pack-index", "repack",
-			 "--no-progress", "--batch-size=0", NULL);
+			 "--no-progress", batch_arg.buf, NULL);
 	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
 
-	if (result && multi_pack_index_verify()) {
+	strbuf_release(&batch_arg);
+
+	/*
+	 * Verify here to avoid verifying again when there are two
+	 * or fewer pack-files.
+	 */
+	if (!result && multi_pack_index_verify()) {
 		warning(_("multi-pack-index verify failed after repack"));
 		result = rewrite_multi_pack_index();
 	}
@@ -294,8 +359,19 @@ static int multi_pack_index_repack(void)
 	return result;
 }
 
-static int run_pack_files_job(void)
+static int run_pack_files_job(int argc, const char **argv)
 {
+	static unsigned long batch_size = UNSET_BATCH_SIZE;
+	static struct option builtin_run_job_pack_file_options[] = {
+		OPT_MAGNITUDE(0, "batch-size", &batch_size,
+			      N_("specify a batch-size for the incremental repack")),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, NULL,
+			     builtin_run_job_pack_file_options,
+			     builtin_run_job_pack_file_usage, 0);
+
 	if (multi_pack_index_write()) {
 		error(_("failed to write multi-pack-index"));
 		return 1;
@@ -316,7 +392,7 @@ static int run_pack_files_job(void)
 		return rewrite_multi_pack_index();
 	}
 
-	if (multi_pack_index_repack()) {
+	if (multi_pack_index_repack(batch_size)) {
 		error(_("multi-pack-index repack failed"));
 		return 1;
 	}
@@ -348,7 +424,7 @@ int cmd_run_job(int argc, const char **argv, const char *prefix)
 		if (!strcmp(argv[0], "loose-objects"))
 			return run_loose_objects_job();
 		if (!strcmp(argv[0], "pack-files"))
-			return run_pack_files_job();
+			return run_pack_files_job(argc, argv);
 	}
 
 	usage_with_options(builtin_run_job_usage,
diff --git a/t/t7900-run-job.sh b/t/t7900-run-job.sh
index 416ba04989d..2d9f6cdf328 100755
--- a/t/t7900-run-job.sh
+++ b/t/t7900-run-job.sh
@@ -128,8 +128,10 @@ test_expect_success 'pack-files job' '
 	# the job deletes the two old packs, and does not write
 	# a new one because only one pack remains.
 	git -C client run-job pack-files &&
-	ls client/.git/objects/pack/*.pack >packs-after &&
-	test_line_count = 1 packs-after
+	ls client/$packDir/*.pack >packs-after &&
+	test_line_count = 2 packs-after &&
+	cat packs-after | grep "pack/test-1-" &&
+	cat packs-after | grep "pack/pack-"
 '
 
 test_done
-- 
gitgitgadget

