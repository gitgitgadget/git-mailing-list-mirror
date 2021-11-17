Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F873C433FE
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AFCE63212
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbhKQOX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238451AbhKQOXC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 09:23:02 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80328C079782
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:44 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso4950372wml.1
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2WSVpdckOKo8sTzLhexO457CfG7Z/d/GCqQg3H5ly1Q=;
        b=UZKDhMCH/YkGWXYGtoH8Dbh7IlDH+H8eOxmcZFmjHvQgE9aMPonFAy8CC/WEFd0ZL7
         vUb+17H6PcMQlG9pwj0GgZZWD7LKTEhG7APy65mHngrLQVi7HnKNCyYDPIj6uURxeCJS
         RoA4BfxMnbypb7ONXVphFitR7iME1U9LRiv+hY7YnnRCIzadunbEtqaVevesb9EgP6ba
         HgkRKkuNEyxuPaqxEShHh5kC3mfQGMZpoNxjXmwZwSzggcCdA3A624Z9ldotmbzJI9pL
         7ZVLsRXhMCzzRVaptc1qRHbkSTGugGej3ja8LXLAc9yDvG6jo2ri4qy2JZhV7TROmdb7
         1ylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2WSVpdckOKo8sTzLhexO457CfG7Z/d/GCqQg3H5ly1Q=;
        b=ePA5/FlWCpegLJ3eIJCr8l4Fsw275ZsGEiiTrJO0EEPrZjEJC8LUXxxnY1cRDbYONs
         hXKqoZbBf/T/bXjVh3EDxzyBWcYta8Qf+kNjH/C8FCay+KimJPnUDv9ggDOgKSLvVEbE
         b4SlXA+ZD3nLb0hXrd9aY47WrMPomioOZYrUA/NjqoXDScYobe4Fmo4LKnIL6Z7d6Pbj
         76eSurnNbJ3h8NqBn98f7GPFLOe3bm/lKUSI7yGjhpa5xRqFuVfFXsZYW1O5AQr0V2O4
         0yKSbu8lygd6w/B1t6KYglCgPCx+Bw0uelOHW5Sl1LpQAew6WR9AX21u0thqr+HExdIX
         yFNw==
X-Gm-Message-State: AOAM532Vw5pZpRNRVcaDEQ/l7cbFDtgaWLFr8GKznLyiTNc9Su4HO8Wc
        rOWs+VQJO1RIzKzQAmqHzlUiPGzqv4s=
X-Google-Smtp-Source: ABdhPJy2q5g0ojrxoy1Lb6JIhCucYa3qSb61g4a7MKcuRW/2BDD9aXurRGrguwaHYkX1W+dDmvuTIQ==
X-Received: by 2002:a05:600c:2e46:: with SMTP id q6mr71314wmf.6.1637158782964;
        Wed, 17 Nov 2021 06:19:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm20608wrz.23.2021.11.17.06.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:19:42 -0800 (PST)
Message-Id: <96a803416b531cd7a85cdb68e54d0a7d58ddcbe8.1637158762.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
References: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
        <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 14:19:22 +0000
Subject: [PATCH v7 17/17] scalar: implement the `version` command
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
index c53697ad6a0..1fc4965bebb 100644
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
