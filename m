Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D95C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 11:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhK3L7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241040AbhK3L61 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 06:58:27 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EC1C06175E
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:55:04 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a18so43880096wrn.6
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OV69YLrfn+4NmtmyV55tOgEZ82XpKu32hPU3F6o5+x4=;
        b=l1Lqg5mTWaq78CKCudmmROpJGzpmIDEntHemxnkcVo5WjedrN4DjNyheySseg/rout
         ZKGmwYzS90N+KApMi6FUQgm0CpVRMX6pv9r3KbFLTkIAcB6RPPyvV0YLtp6asO6JKILU
         RAOm+Im8W73nRLCLGEaHJGp/7ES3E/6WdueKyG/6cTN//IGmzF6bt26XXue3C5cdYPZG
         x7fxjeeI6YsYxc6Bb+btjXb2mmPxSZ8/6r4FVrUdlBMn6ZYUn5UEpM8+ANKk/Ss/I3zh
         fK0vrDtRg1lcCSm8A+IxQKBBv0HU1MwJT880phqw8cGb5DCe/TlzYcRcib5nQzn4lqD+
         cPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OV69YLrfn+4NmtmyV55tOgEZ82XpKu32hPU3F6o5+x4=;
        b=vNpkjVfcMtQC7BXt7zxy5T2oC1NpJeBTu11emRD8v+1b2VN4o+IK89cxr4jLLbymG/
         niCU7i3LQS8CeHUeXx8p8ZiT+la5ghmP2Lm+uBvAEyUUZNcCawC/KONsA7Fvzz3LKQkr
         MSac2mF0sYj/iRvWKdQF/zUz50APfE+arMIz2HOeWchwsTKwfXGBUHxVk1qtzuURfynD
         hLCwFCAW28CfO4oKq+ys/Gp6DRRk3+LtppxAT3VG5yqY1+9kTCeYkKVs8WGxUF1SMkso
         7vskdRTNeIp8fIITu8iXgiB83qxaPFp8bSRjs807s5dN5mT9irTp/aOx2tUb7DstV5fp
         3l0A==
X-Gm-Message-State: AOAM531t5lQB96m/hYpZkBNxOazIz+V9lhZan0kd8ISyz4Zg4Z2GH5eX
        phpoO+Bixt+JN8gC2cLtGWBFsz56vQo=
X-Google-Smtp-Source: ABdhPJxYYU+kAE3BGdVQYCrikXgWE4r4AfIEq5HevndlUdhZ86hQV4zkHU2rTQDyLw1Ov5r5iQ2SFQ==
X-Received: by 2002:a05:6000:92:: with SMTP id m18mr39834840wrx.617.1638273302842;
        Tue, 30 Nov 2021 03:55:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay21sm2127061wmb.7.2021.11.30.03.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:55:02 -0800 (PST)
Message-Id: <4ee1b701c7bf36004c352da8f04525f7ef4d8e0f.1638273289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
        <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 11:54:49 +0000
Subject: [PATCH v9 17/17] scalar: implement the `version` command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The .NET version of Scalar has a `version` command. This was necessary
because it was versioned independently of Git.

Since Scalar is now tightly coupled with Git, it does not make sense for
them to show different versions. Therefore, it shows the same output as
`git version`. For backwards-compatibility with the .NET version,
`scalar version` prints to `stderr`, though (`git version` prints to
`stdout` instead).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index d4303c7c4a2..1ce9c2b00e8 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -10,6 +10,7 @@
 #include "refs.h"
 #include "dir.h"
 #include "packfile.h"
+#include "help.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -357,6 +358,15 @@ static int delete_enlistment(struct strbuf *enlistment)
 	return 0;
 }
 
+/*
+ * Dummy implementation; Using `get_version_info()` would cause a link error
+ * without this.
+ */
+void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
+{
+	die("not implemented");
+}
+
 static int cmd_clone(int argc, const char **argv)
 {
 	const char *branch = NULL;
@@ -750,6 +760,34 @@ static int cmd_delete(int argc, const char **argv)
 	return res;
 }
 
+static int cmd_version(int argc, const char **argv)
+{
+	int verbose = 0, build_options = 0;
+	struct option options[] = {
+		OPT__VERBOSE(&verbose, N_("include Git version")),
+		OPT_BOOL(0, "build-options", &build_options,
+			 N_("include Git's build options")),
+		OPT_END(),
+	};
+	const char * const usage[] = {
+		N_("scalar verbose [-v | --verbose] [--build-options]"),
+		NULL
+	};
+	struct strbuf buf = STRBUF_INIT;
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	if (argc != 0)
+		usage_with_options(usage, options);
+
+	get_version_info(&buf, build_options);
+	fprintf(stderr, "%s\n", buf.buf);
+	strbuf_release(&buf);
+
+	return 0;
+}
+
 static struct {
 	const char *name;
 	int (*fn)(int, const char **);
@@ -761,6 +799,7 @@ static struct {
 	{ "run", cmd_run },
 	{ "reconfigure", cmd_reconfigure },
 	{ "delete", cmd_delete },
+	{ "version", cmd_version },
 	{ NULL, NULL},
 };
 
-- 
gitgitgadget
