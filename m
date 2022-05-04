Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710E5C433EF
	for <git@archiver.kernel.org>; Wed,  4 May 2022 15:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352483AbiEDP3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 11:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352612AbiEDP3I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 11:29:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ABF193C6
        for <git@vger.kernel.org>; Wed,  4 May 2022 08:25:30 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e24so2506426wrc.9
        for <git@vger.kernel.org>; Wed, 04 May 2022 08:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VhRAkQGsOMMZYApuyWPvng0WDXvqAdGMjGolWIX9Q10=;
        b=JeOJwkRVr763YWikAA143DiKXhO4u7Fee4vi05SmMaJ3nJDM7JlxIQ+wWlofvHBMOo
         OC1yz9Q99/HXAGIOb0Jahb0rxrczoSlNNUCh/E1XQZaDGpYEpa1fcfU9+9dpmE08e080
         qzZ/FgUCfky+VyhdeMmtB7pILF5Ex4nRdkt2/9LRrl1fZ4ehEBS+c1qkEjn+LLtPqPO6
         Lgm3YcyHMFrkujj3vwt/MEChe93TRR7+mDJIORBB6v4ieoT0tV3ejKYZ7TuKbraVczwo
         wyg9uBtei2sxB1bgX+Golg64g9u8OBAhkO4869icHuOR159p6xzq4v+jA1kEl7dgujim
         +mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VhRAkQGsOMMZYApuyWPvng0WDXvqAdGMjGolWIX9Q10=;
        b=E4kWu7xV5StrEMbUNEc8XlPaKRi86nA+2kn9wGW+PaZbzjMcS5ND3timkc0OmyM2cS
         HygHRHCXXZXhI7jOXDMfufXC41xz6qT1np8QdmOLlPEXQsLc7naS2/2vQyh9iGbmjZC2
         luP6VXyuGqojdGdNsyjkXJ4yNBO6XUSUR00J37nh76fTKBB5NqrOqrAmOfeDhoFTbLZI
         FuWAdWedQ4eCvwtsSeG8PX+J+/ZjCsI+SYdxBCKckCORhF98bhyiR3vy+o6eZJdFRmu8
         mBxsShgBxzoIOwUQ8Ay9fIf5SbC32Wq9IKkYSUHy4yY83Zu45WsjcKidKKRlYlAZiOIF
         tYMA==
X-Gm-Message-State: AOAM530ML9cHTWja725OFosJxpuEO1ixyAKUT9ldzu0pWMeg1F0hpYv/
        ORMskBtlGLvy44PgP+c1wxW6EOZps1M=
X-Google-Smtp-Source: ABdhPJx8E79gGep2tQiy7ZzPIkSvg2Cp32R5vWs07muoC7JhQO0aqrj+pIEn8bID20QgLBhFVrhJog==
X-Received: by 2002:a05:6000:1861:b0:20c:8125:ee0a with SMTP id d1-20020a056000186100b0020c8125ee0amr2663674wri.713.1651677929105;
        Wed, 04 May 2022 08:25:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1-20020a1ced01000000b003942a244f4fsm4010670wmh.40.2022.05.04.08.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:25:28 -0700 (PDT)
Message-Id: <32aaad7cce1436ee1c6a7607cc8656b1275aac2f.1651677919.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
References: <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
        <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 May 2022 15:25:18 +0000
Subject: [PATCH v3 6/7] scalar: teach `diagnose` to gather packfile info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

It's helpful to see if there are other crud files in the pack
directory. Let's teach the `scalar diagnose` command to gather
file size information about pack files.

While at it, also enumerate the pack files in the alternate
object directories, if any are registered.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 30 ++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh |  6 +++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index df44902c909..9adde8cf4b9 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "help.h"
 #include "archive.h"
+#include "object-store.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -592,6 +593,29 @@ cleanup:
 	return res;
 }
 
+static void dir_file_stats_objects(const char *full_path, size_t full_path_len,
+				   const char *file_name, void *data)
+{
+	struct strbuf *buf = data;
+	struct stat st;
+
+	if (!stat(full_path, &st))
+		strbuf_addf(buf, "%-70s %16" PRIuMAX "\n", file_name,
+			    (uintmax_t)st.st_size);
+}
+
+static int dir_file_stats(struct object_directory *object_dir, void *data)
+{
+	struct strbuf *buf = data;
+
+	strbuf_addf(buf, "Contents of %s:\n", object_dir->path);
+
+	for_each_file_in_pack_dir(object_dir->path, dir_file_stats_objects,
+				  data);
+
+	return 0;
+}
+
 static int cmd_diagnose(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -654,6 +678,12 @@ static int cmd_diagnose(int argc, const char **argv)
 		     "--add-file-with-content=diagnostics.log:%.*s",
 		     (int)buf.len, buf.buf);
 
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "--add-file-with-content=packs-local.txt:");
+	dir_file_stats(the_repository->objects->odb, &buf);
+	foreach_alt_odb(dir_file_stats, &buf);
+	strvec_push(&archiver_args, buf.buf);
+
 	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
 	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
 	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index f3d037823c8..e049221609d 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -93,6 +93,8 @@ test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
 SQ="'"
 test_expect_success UNZIP 'scalar diagnose' '
 	scalar clone "file://$(pwd)" cloned --single-branch &&
+	git repack &&
+	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &&
 	scalar diagnose cloned >out &&
 	grep "Available space" out &&
 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <out >zip_path &&
@@ -102,7 +104,9 @@ test_expect_success UNZIP 'scalar diagnose' '
 	folder=${zip_path%.zip} &&
 	test_path_is_missing "$folder" &&
 	unzip -p "$zip_path" diagnostics.log >out &&
-	test_file_not_empty out
+	test_file_not_empty out &&
+	unzip -p "$zip_path" packs-local.txt >out &&
+	grep "$(pwd)/.git/objects" out
 '
 
 test_done
-- 
gitgitgadget

