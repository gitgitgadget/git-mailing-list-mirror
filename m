Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859D1C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707A661037
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbhJGLBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240896AbhJGLBd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 07:01:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31174C061779
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:59:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t2so17760838wrb.8
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cq7xpzv9Jt0r+m3QH1PsZIBW9iGrieo+DLK5++RfiqM=;
        b=Dou5n6Hyoz+rWNUBWzRibf4LkcfLrhXggwhJqCtOtYLIEic1QNvP3ehmVyt2856s15
         j3CKi7JaEAvAmNUWejP37TvbX7DyzPhG/cS49WSdZTJvS3lhSJfOK166Gqf7LY2DFM24
         TVZocrpzIgmvfW9UT2Rbc0+jXSXiceKwKRYVrdGHo0XjXYq0GWps8KYjC6DeV+PNaYDi
         vTcL5aevo3EKerkETM5rrABWD8fBZfqGvDraHKwEhoGX55OykX/uuZ8P98seCAmyjAOW
         5uvMk1dYIHLMkh2j1cOpr1+fEYKGgg8vw6qmmh3c3XHWNbeRNAf8l/lp+vsn0RZ5lNqs
         JiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cq7xpzv9Jt0r+m3QH1PsZIBW9iGrieo+DLK5++RfiqM=;
        b=Av6WML4HKeN5k4XLUejNBfG+6d9Dq4SfgHFwu3rGbZSWsiox+M8xgWQ2g7UQ3eNNH7
         I7neYuHLixmVd5R6qYYLPJM/4ER5/CQbzEPyR2hQ272lrTlBVDWWOUz7c3HhZ4qaitAs
         loGyQWNDznS3190KESHY9Oq2xGqyPezFusjQfZszykIGwU55sfIrV5XWdO1TdWsBbE/z
         xXSco0OCrf31eQSddQfA8LrDIMGyYI3tuzGkskFy/kEaWSeWScSe9ud3SgSq1neucOAz
         lMpskpS5fAG5Xfx473GdXkbxOf9mLNO0tG0Xh7O1707ytBwKAAMcued+rnnqnGldFVIL
         /GSQ==
X-Gm-Message-State: AOAM53059/8mtM3Zdj1GgiPE7rzeR6OxxnOtXsXmdVoqI5PCCzji+ztk
        XU4dSS0GmUJZkTH4RzIfRx15uFzoB1E=
X-Google-Smtp-Source: ABdhPJyPaT1z8Eb1TNe1XaiFAmdQ+T/x2XE2azy5KqDwHC0Kmc1lAeu3AxjB62oKiQSqY/6KgXR8iA==
X-Received: by 2002:a05:600c:3550:: with SMTP id i16mr3814971wmq.153.1633604359848;
        Thu, 07 Oct 2021 03:59:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15sm16243235wrt.0.2021.10.07.03.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:59:19 -0700 (PDT)
Message-Id: <2ecfaa5d0fe7fecde35e409900b2dfb78b02a96b.1633604349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
References: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
        <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 10:59:08 +0000
Subject: [PATCH v5 14/15] scalar: implement the `version` command
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
        Theodore Ts'o <tytso@mit.edu>,
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
index 8aaeca7cc64..b2e92cf63b5 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -10,6 +10,7 @@
 #include "refs.h"
 #include "dir.h"
 #include "packfile.h"
+#include "help.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -356,6 +357,15 @@ static int delete_enlistment(struct strbuf *enlistment)
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
@@ -749,6 +759,34 @@ static int cmd_delete(int argc, const char **argv)
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
@@ -760,6 +798,7 @@ static struct {
 	{ "run", cmd_run },
 	{ "reconfigure", cmd_reconfigure },
 	{ "delete", cmd_delete },
+	{ "version", cmd_version },
 	{ NULL, NULL},
 };
 
-- 
gitgitgadget

