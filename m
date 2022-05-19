Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A0CC433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 18:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243796AbiESSSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 14:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243803AbiESSSR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 14:18:17 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204F9EBAA2
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:18:14 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so3126094wme.3
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q4Nq0XKv3sAz87ZRO+MCbKnQgUW64Vx3dbiERrPUd8U=;
        b=EvnVBEOJ4Jmyf69+PNIiXo+BW/tNcX9n9OSGjMeIsDqbn9bb66hPHfXTL0PgFci7Rr
         52Z122Q+bD+bVBz3EIFm7KSlKY7DDlPpa7Au6yfuuSuDz+825T70wfmHbIJLM97caaJy
         WtcLMtNEgkdJFrHbD6n3/ayGnqBuAqC9LrOVnMoOXCcKXN0E8p1s2ep/QQ5BBs7s7uB9
         twH5jWqWBcQyuMg5rWW95ae+B5tVaQl0Gpek1WuCcoyLESQ0oS8l5FjM5yVSMLTNcuml
         nnawgvFFnEGTkJW4jox6yPVnwyIQUxIr3uWVhBEIMOhaMrUU2H7WU7px3yzyadJj4ZTU
         gBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q4Nq0XKv3sAz87ZRO+MCbKnQgUW64Vx3dbiERrPUd8U=;
        b=JscRgLkF/RqBOg56X+txK4OzjShpccIpZMYxrkyfaLTCOO/yiSlgSXbTuT85QWG9Eu
         tKVTTdeBnC4QRCtrm1mAVXJPpeXp5tB/SqtZx/uswkl9bqLMdwg+lOd3WO4f+6DVYVpD
         Mgr9Ct2xvrBgKAAy/FYFRj1tfc+yvP+g4hAtlZzvEZ7XK1QSmLd+x5Wh8pSGXOsL/J70
         Dnlry38WYJY+xCEib5F/blhc/WolkKWBSwNensWLWHtGfL5JJwfEeyR7E+CapCytt8Wb
         DaElUAqjBk/yIHkYMbjaTHQX2pBw3qg+pKYqRDBaWwqQdQQ6kv59iczMOrqpHhgX9PUL
         zEIg==
X-Gm-Message-State: AOAM532W29qK8uOjYeIKgLEOsZX1F8900QKqKY8NeMelUn/1VwU778sq
        RxxGDkYDIjYPojKY0sD/1+8swZJXa1g=
X-Google-Smtp-Source: ABdhPJw/l8jY33z8WGVNn/cEudQsF9/dit6iF0qln6SVi5A9wd+uCZCfVrDTrrJQvlN4bOSVAvMUIg==
X-Received: by 2002:a05:600c:5112:b0:394:55bd:5f9d with SMTP id o18-20020a05600c511200b0039455bd5f9dmr5603731wms.188.1652984292343;
        Thu, 19 May 2022 11:18:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11-20020adfba4b000000b0020c6fa5a797sm248478wrg.91.2022.05.19.11.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:18:11 -0700 (PDT)
Message-Id: <0fa20d7375009999d978da682c3f98a604cda9e4.1652984283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
References: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 18:18:02 +0000
Subject: [PATCH v5 6/7] scalar: teach `diagnose` to gather packfile info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
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
index 0a9e25a57f8..d302c27e114 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "help.h"
 #include "archive.h"
+#include "object-store.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -595,6 +596,29 @@ cleanup:
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
@@ -657,6 +681,12 @@ static int cmd_diagnose(int argc, const char **argv)
 		     "--add-virtual-file=diagnostics.log:%.*s",
 		     (int)buf.len, buf.buf);
 
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
+	dir_file_stats(the_repository->objects->odb, &buf);
+	foreach_alt_odb(dir_file_stats, &buf);
+	strvec_push(&archiver_args, buf.buf);
+
 	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
 	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
 	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 934b2485d91..3dd5650cceb 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -93,6 +93,8 @@ test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
 SQ="'"
 test_expect_success UNZIP 'scalar diagnose' '
 	scalar clone "file://$(pwd)" cloned --single-branch &&
+	git repack &&
+	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &&
 	scalar diagnose cloned >out 2>err &&
 	grep "Available space" out &&
 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <err >zip_path &&
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

