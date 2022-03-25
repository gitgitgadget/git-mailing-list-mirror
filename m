Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BB3C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiCYT3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiCYT25 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:28:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3251B1EDA15
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:02:51 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so4953753wme.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zYPbOmp0UZ7wKG2ZlzAJ4yOnCp946+BWBwpR6jqJJm0=;
        b=kHdAGqjZseEAFe0ENRoLRVCKmO4uyAI/NTsy1a0sgoe8tWzft1Ia48PxjV9vSUac6E
         G2/bSbrUCHg5yf89gyQXDBVLLI27ecZOo4R4qhuuhoL/BJZURR5qGjUjdb8JB/E2P2PM
         RzIA2YrT0U1c6qzles+VDhFp/xdaKaZZ4hrtpuSoGE2R3fv3dzzTVwCoUONhHUEAgUyc
         t5ejrSPnbIqaxkrS92Tfy3zFrvhAp7+WYrvSfuoTgYZ+YPHLDdjpETpZ+gfU0wYonN8y
         58src2AR3MtBwLErwgXw+NrzF8/QnLfQehy4D60O2y+Rom/WcliTqqb0IOGV64qEi/SA
         LiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zYPbOmp0UZ7wKG2ZlzAJ4yOnCp946+BWBwpR6jqJJm0=;
        b=EMpO/Sx9u0TuqFg0UUXb9BbQ0WrwR9jtcDCEonKk0OzWXymEXTVPzzcTySEQ3MIKU+
         TqAG78718Jr1mt/1ll19uF5b4IVRdDArUQ8AHoNHATgcxQkN7IlmxEJaFzdWzhWJguKh
         hqdofIyZARJu/mvocJ+78gug/0Abfja/bvRunaghXLp3dTjRBRI5LwWoWJWOx/cveaj9
         qCH1sOC+qgcYnxHpssL1w1rLOLni2sm5LJ2gqCF+PTbnxV4YBXL/N1orHRX5Ii+YVrpd
         cIQ+Iobq8GS0Pqsiz/PpqH9QXbr5FwDC9Cl+OqPwtcB92MWvtmjCFgtJYXH9HY0Rvbb+
         Brtg==
X-Gm-Message-State: AOAM531mYdNha2MKOycuL6pF9Q0OUzXKmLgxWbRjiWO5d7R8JY2e7Zis
        Q4BYfoUQovcrjs2/YIbZ7aCCF0CLEtI=
X-Google-Smtp-Source: ABdhPJwogoOojurpydaOrgqmRWr27sg8pOBty/GWnl9tQ8xppsg9ye48h4GxmOZ0kq75tVvXQO6c0w==
X-Received: by 2002:a1c:3587:0:b0:381:50ff:cbd with SMTP id c129-20020a1c3587000000b0038150ff0cbdmr20856160wma.140.1648234969548;
        Fri, 25 Mar 2022 12:02:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c028700b0038cc9bfe6a4sm4883089wmk.37.2022.03.25.12.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 12:02:49 -0700 (PDT)
Message-Id: <fb2c550512e1ab4dccee805db6121bc1d7e7d48f.1648234967.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v3.git.1648234967.gitgitgadget@gmail.com>
References: <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
        <pull.1185.v3.git.1648234967.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 19:02:46 +0000
Subject: [PATCH v3 1/2] t7700: check post-condition in kept-pack test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chakrabortyabhradeep79@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The '--write-midx -b packs non-kept objects' test in t7700-repack.sh
uses test_subcommand_inexact to check that 'git repack' properly adds
the '--honor-pack-keep' flag to the 'git pack-objects' subcommand.
However, the test_subcommand_inexact helper is more flexible than
initially designed, and this instance is the only one that makes use of
it: there are additional arguments between 'git pack-objects' and the
'--honor-pack-keep' flag. In order to make test_subcommand_inexact more
strict, we need to fix this instance.

This test checks that 'git repack --write-midx -a -b -d' will create a
new pack-file that does not contain the objects within the kept pack.
This behavior is possible because of the multi-pack-index bitmap that
will bitmap objects against multiple packs. Without --write-midx, the
objects in the kept pack would be duplicated so the resulting pack is
closed under reachability and bitmaps can be created against it. This is
discussed in more detail in e4d0c11c0 (repack: respect kept objects with
'--write-midx -b', 2021-12-20) which also introduced this instance of
test_subcommand_inexact.

To better verify the intended post-conditions while also removing this
instance of test_subcommand_inexact, rewrite the test to check the list
of packed objects in the kept pack and the list of the objects in the
newly-repacked pack-file _other_ than the kept pack. These lists should
be disjoint.

Be sure to include a non-kept pack-file and loose objects to be extra
careful that this is properly behaving with kept packs and not just
avoiding repacking all pack-files.

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t7700-repack.sh | 57 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 770d1432046..ca45c4cd2c1 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -369,10 +369,61 @@ test_expect_success '--write-midx with preferred bitmap tips' '
 	)
 '
 
+# The first argument is expected to be a filename
+# and that file should contain the name of a .idx
+# file. Send the list of objects in that .idx file
+# into stdout.
+get_sorted_objects_from_pack () {
+	git show-index <$(cat "$1") >raw &&
+	cut -d" " -f2 raw
+}
+
 test_expect_success '--write-midx -b packs non-kept objects' '
-	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
-		git repack --write-midx -a -b &&
-	test_subcommand_inexact git pack-objects --honor-pack-keep <trace.txt
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		# Create a kept pack-file
+		test_commit base &&
+		git repack -ad &&
+		find $objdir/pack -name "*.idx" >before &&
+		test_line_count = 1 before &&
+		before_name=$(cat before) &&
+		>${before_name%.idx}.keep &&
+
+		# Create a non-kept pack-file
+		test_commit other &&
+		git repack &&
+
+		# Create loose objects
+		test_commit loose &&
+
+		# Repack everything
+		git repack --write-midx -a -b -d &&
+
+		# There should be two pack-files now, the
+		# old, kept pack and the new, non-kept pack.
+		find $objdir/pack -name "*.idx" | sort >after &&
+		test_line_count = 2 after &&
+		find $objdir/pack -name "*.keep" >kept &&
+		kept_name=$(cat kept) &&
+		echo ${kept_name%.keep}.idx >kept-idx &&
+		test_cmp before kept-idx &&
+
+		# Get object list from the kept pack.
+		get_sorted_objects_from_pack before >old.objects &&
+
+		# Get object list from the one non-kept pack-file
+		comm -13 before after >new-pack &&
+		test_line_count = 1 new-pack &&
+		get_sorted_objects_from_pack new-pack >new.objects &&
+
+		# None of the objects in the new pack should
+		# exist within the kept pack.
+		comm -12 old.objects new.objects >shared.objects &&
+		test_must_be_empty shared.objects
+	)
 '
 
 test_expect_success TTY '--quiet disables progress' '
-- 
gitgitgadget

