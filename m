Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77465C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B6361B96
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345632AbhKPD1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 22:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244575AbhKPD0a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 22:26:30 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBF8C126D06
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 15:51:12 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso1014322wme.3
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 15:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=THp3oyYMQZ0IyvYbWDVtqI55HStotyepThNgwaAMuqY=;
        b=MtLJsnXXKYy/qq10u0szPk0uGaytJ+Ode/YLawZLT1PBzigIJgPno4T6pWhhw2huUt
         OEzO6faMoU1feDadnLhysHr5a2onxFsDckkMuPtE1hHRJXqRQ4MBB3QRDtlsshx69MRj
         xorF5hQxUBdWXwvyhJO6KdMAhIo8tH2ie8C5FaRF/F7Sr57EinAr3/rWkxEHjc5ongSm
         cSTapGdlhcaCqZU5MSOMNVE2qg6BdBtZkzQ7KzLbF3kMI9VGFlJm20CiLCtNWQ6modc6
         CDDkXWXOfRKTXZa/Tienq5EPRWBOt+nh4h7C2I5jPD/ixahurYGDJh2q5n73BMa2Bu1k
         T5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=THp3oyYMQZ0IyvYbWDVtqI55HStotyepThNgwaAMuqY=;
        b=n6Wh4z9KyHpRqe4oAWguLvKTGY47qSZfTV0zevLtyDync5s6M+n5N7XeHV6bkBOT4t
         WB+AWDOO63K/rstscA/3ihdGdENtvJBm9i8xua9Yi4+h0vAXjTWVmgVC7S+A9XTKibJS
         SOtQNmEDRCGB73vW9sihrfgej7/Q+xBt8e+o9kgZ0sPiEtfCiICG6zeMJHGWAZ6V8W/P
         DC3J4Gea0jKjsAumNmfrhC/ylJuCGlTKtpxMNdln20UJ8fezd64H0nMxOD07p1IE/Lfb
         X2gG78pPTcYFrjW2Qe+7ZMmosBc3E7pv7FV5VxnY+31Z4kREN2kpmCpUQNXKERcxZkaL
         /WtQ==
X-Gm-Message-State: AOAM532jzXTFtCDlXGJxpwmITDSAmVZFEVo8wah/3u0+ESXBkdDcZNqX
        DfIZDTIqR01VmpNIRRH1QGh0/CO5ftU=
X-Google-Smtp-Source: ABdhPJxigg6kPI6WiSKanLnLLVhp1TPfdSg80Hm2ugNbSMYJdeZgHJIcxhqQvv2pZoAy69dXVARgfw==
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr63379317wma.30.1637020271247;
        Mon, 15 Nov 2021 15:51:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8sm15268697wrh.16.2021.11.15.15.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 15:51:10 -0800 (PST)
Message-Id: <12d99641f4c3738efbc5c70ef4f8d70eccb6fc8b.1637020263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
        <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Nov 2021 23:51:03 +0000
Subject: [PATCH v9 9/9] core.fsyncobjectfiles: performance tests for add and
 stash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Add a basic performance test for "git add" and "git stash" of a lot of
new objects with various fsync settings.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/perf/p3700-add.sh   | 43 ++++++++++++++++++++++++++++++++++++++++
 t/perf/p3900-stash.sh | 46 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100755 t/perf/p3700-add.sh
 create mode 100755 t/perf/p3900-stash.sh

diff --git a/t/perf/p3700-add.sh b/t/perf/p3700-add.sh
new file mode 100755
index 00000000000..e93c08a2e70
--- /dev/null
+++ b/t/perf/p3700-add.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+#
+# This test measures the performance of adding new files to the object database
+# and index. The test was originally added to measure the effect of the
+# core.fsyncObjectFiles=batch mode, which is why we are testing different values
+# of that setting explicitly and creating a lot of unique objects.
+
+test_description="Tests performance of add"
+
+. ./perf-lib.sh
+
+. $TEST_DIRECTORY/lib-unique-files.sh
+
+test_perf_default_repo
+test_checkout_worktree
+
+dir_count=10
+files_per_dir=50
+total_files=$((dir_count * files_per_dir))
+
+# We need to create the files each time we run the perf test, but
+# we do not want to measure the cost of creating the files, so run
+# the tet once.
+if test "${GIT_PERF_REPEAT_COUNT-1}" -ne 1
+then
+	echo "warning: Setting GIT_PERF_REPEAT_COUNT=1" >&2
+	GIT_PERF_REPEAT_COUNT=1
+fi
+
+for m in false true batch
+do
+	test_expect_success "create the files for core.fsyncObjectFiles=$m" '
+		git reset --hard &&
+		# create files across directories
+		test_create_unique_files $dir_count $files_per_dir files
+	'
+
+	test_perf "add $total_files files (core.fsyncObjectFiles=$m)" "
+		git -c core.fsyncobjectfiles=$m add files
+	"
+done
+
+test_done
diff --git a/t/perf/p3900-stash.sh b/t/perf/p3900-stash.sh
new file mode 100755
index 00000000000..c9fcd0c03eb
--- /dev/null
+++ b/t/perf/p3900-stash.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+#
+# This test measures the performance of adding new files to the object database
+# and index. The test was originally added to measure the effect of the
+# core.fsyncObjectFiles=batch mode, which is why we are testing different values
+# of that setting explicitly and creating a lot of unique objects.
+
+test_description="Tests performance of stash"
+
+. ./perf-lib.sh
+
+. $TEST_DIRECTORY/lib-unique-files.sh
+
+test_perf_default_repo
+test_checkout_worktree
+
+dir_count=10
+files_per_dir=50
+total_files=$((dir_count * files_per_dir))
+
+# We need to create the files each time we run the perf test, but
+# we do not want to measure the cost of creating the files, so run
+# the tet once.
+if test "${GIT_PERF_REPEAT_COUNT-1}" -ne 1
+then
+	echo "warning: Setting GIT_PERF_REPEAT_COUNT=1" >&2
+	GIT_PERF_REPEAT_COUNT=1
+fi
+
+for m in false true batch
+do
+	test_expect_success "create the files for core.fsyncObjectFiles=$m" '
+		git reset --hard &&
+		# create files across directories
+		test_create_unique_files $dir_count $files_per_dir files
+	'
+
+	# We only stash files in the 'files' subdirectory since
+	# the perf test infrastructure creates files in the
+	# current working directory that need to be preserved
+	test_perf "stash 500 files (core.fsyncObjectFiles=$m)" "
+		git -c core.fsyncobjectfiles=$m stash push -u -- files
+	"
+done
+
+test_done
-- 
gitgitgadget
