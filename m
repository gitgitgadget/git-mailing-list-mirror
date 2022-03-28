Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A27C433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 14:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243598AbiC1OEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 10:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243575AbiC1OEH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 10:04:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFABE5EDFF
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 07:02:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so13038914wmb.4
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 07:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YZAsi0B+autmzfzGuxw5aPrHZZWF6NKcxAUhcZiJlOk=;
        b=YS5hsqlpID1LH3u41LuVnQDq7VjhRRrV9/yiGSU9sPwE1TRX/jD+xNmeMea0Ru8/Nk
         CRr9s9dOdKkBWb+UeLOA+79rG/xZ1y1FJyjykTqqqTSVekSiY+mSpfBWn0YcOriac2h0
         p340oHSneyO6yz17EZoqg0xaOaeySVbaM0y3nUrayOJpimZPJuIs7d9+yUGJaKUVL/A5
         s3cvCfOOIf/AVpwa/m2KnfY2peR9yfzzct9PNQu/FFliKxMhOY0bLRseCNhMcQdn8Q5n
         /zqth3YjT/p101SbTXgKd66MU4X+tcJR16JfZqo2E7Xs7xopav65Q3cJia9NgUBopWLG
         9x9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YZAsi0B+autmzfzGuxw5aPrHZZWF6NKcxAUhcZiJlOk=;
        b=sGqaq4xrJBx1sxwqWyRNJ29J7Tqk41WJ4tIW6TCvVEFCYmjMjHl7bir3D4/H7ZeFQ/
         kwPvN3LC+dbJiH/VkXDFqaB1uBnr7iJueTp/ZSRWXrU+N7Uy06Lg5ZAOksgUVrmHiWUE
         ecVb5we3q30mtmfItxXNUApNyLfnYbQ+YuHx3xKZT6utlCVSyZgzYXb0kH5SOT5cCd2H
         fCki44GgAQ1zVJMd/M33t1FRcxO+oZaPmrfwqq5V3OY7s73MjPug1wiBxOyCkAyYAUYe
         DQtxDD4VrtSpb+fKhOQ55jpD6Q8zCpBabvzbt+Soc2f+u6qkCnTUTZPpsuQQ67Eb16gE
         kj2Q==
X-Gm-Message-State: AOAM530U0vTW8fFcTJQs49b1JZjOqhcaSrFOrMwxJzynSoz3rZ72X6Hl
        8tt8NJ6BoqfA4+vBEeff6iWYzYXVPVo=
X-Google-Smtp-Source: ABdhPJzxu0HXwwckgjUmVlb9kSk0e1FRRoggHbtTlNVqL1Zoij3S1fFqKc3V+BtM2zcUTVoteyYEgg==
X-Received: by 2002:a05:600c:1d8e:b0:389:d079:cc0 with SMTP id p14-20020a05600c1d8e00b00389d0790cc0mr26642595wms.98.1648476145133;
        Mon, 28 Mar 2022 07:02:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 185-20020a1c19c2000000b0038a1d06e862sm16766963wmz.14.2022.03.28.07.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 07:02:24 -0700 (PDT)
Message-Id: <28c07219fd830196af1171320b86bc2a58ba3d79.1648476132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
        <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Mar 2022 14:02:10 +0000
Subject: [PATCH v4 6/7] fetch: after refetch, encourage auto gc repacking
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
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

After invoking `fetch --refetch`, the object db will likely contain many
duplicate objects. If auto-maintenance is enabled, invoke it with
appropriate settings to encourage repacking/consolidation.

* gc.autoPackLimit: unless this is set to 0 (disabled), override the
  value to 1 to force pack consolidation.
* maintenance.incremental-repack.auto: unless this is set to 0, override
  the value to -1 to force incremental repacking.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 Documentation/fetch-options.txt |  3 ++-
 builtin/fetch.c                 | 19 ++++++++++++++++++-
 t/t5616-partial-clone.sh        | 29 +++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index d03fce5aae0..622bd84768b 100644
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
index e391a5dbc55..e3791f09ed5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2306,8 +2306,25 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 					     NULL);
 	}
 
-	if (enable_auto_gc)
+	if (enable_auto_gc) {
+		if (refetch) {
+			/*
+			 * Hint auto-maintenance strongly to encourage repacking,
+			 * but respect config settings disabling it.
+			 */
+			int opt_val;
+			if (git_config_get_int("gc.autopacklimit", &opt_val))
+				opt_val = -1;
+			if (opt_val != 0)
+				git_config_push_parameter("gc.autoPackLimit=1");
+
+			if (git_config_get_int("maintenance.incremental-repack.auto", &opt_val))
+				opt_val = -1;
+			if (opt_val != 0)
+				git_config_push_parameter("maintenance.incremental-repack.auto=-1");
+		}
 		run_auto_maintenance(verbosity < 0);
+	}
 
  cleanup:
 	string_list_clear(&list, 0);
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 87ebf4b0b1c..4a3778d04a8 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -216,6 +216,35 @@ test_expect_success 'fetch --refetch works with a shallow clone' '
 	test_line_count = 6 observed
 '
 
+test_expect_success 'fetch --refetch triggers repacking' '
+	GIT_TRACE2_CONFIG_PARAMS=gc.autoPackLimit,maintenance.incremental-repack.auto &&
+	export GIT_TRACE2_CONFIG_PARAMS &&
+
+	GIT_TRACE2_EVENT="$PWD/trace1.event" \
+	git -C pc1 fetch --refetch origin &&
+	test_subcommand git maintenance run --auto --no-quiet <trace1.event &&
+	grep \"param\":\"gc.autopacklimit\",\"value\":\"1\" trace1.event &&
+	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"-1\" trace1.event &&
+
+	GIT_TRACE2_EVENT="$PWD/trace2.event" \
+	git -c protocol.version=0 \
+		-c gc.autoPackLimit=0 \
+		-c maintenance.incremental-repack.auto=1234 \
+		-C pc1 fetch --refetch origin &&
+	test_subcommand git maintenance run --auto --no-quiet <trace2.event &&
+	grep \"param\":\"gc.autopacklimit\",\"value\":\"0\" trace2.event &&
+	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"-1\" trace2.event &&
+
+	GIT_TRACE2_EVENT="$PWD/trace3.event" \
+	git -c protocol.version=0 \
+		-c gc.autoPackLimit=1234 \
+		-c maintenance.incremental-repack.auto=0 \
+		-C pc1 fetch --refetch origin &&
+	test_subcommand git maintenance run --auto --no-quiet <trace3.event &&
+	grep \"param\":\"gc.autopacklimit\",\"value\":\"1\" trace3.event &&
+	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"0\" trace3.event
+'
+
 test_expect_success 'partial clone with transfer.fsckobjects=1 works with submodules' '
 	test_create_repo submodule &&
 	test_commit -C submodule mycommit &&
-- 
gitgitgadget

