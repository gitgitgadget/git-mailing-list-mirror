Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA087C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 23:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbhKSXHK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 18:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbhKSXHC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 18:07:02 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5A0C06175E
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:59 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c4so20603101wrd.9
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2WSVpdckOKo8sTzLhexO457CfG7Z/d/GCqQg3H5ly1Q=;
        b=FHmglD+93qL8l5tA4AGRndNdqnjtUraulyRzPpHbokIRPQkq3x/gbHhNor+Md64DPW
         Qad9v599pOxjWdjj7bw00o4+YKQbQD6unfqBX/aDImKsxHo0oddeNHxVnGeTO4M0vbYA
         JxJS6AzSjavoJHuC6Qcpsor7MVmZgPVSv6jIT5OURHaM76CtYsQWyMLIjJLk3K/c7hsh
         N/J0A5tcxeT4wgztbjsIVGcVhAXBJ/buE7DnULkJ/4+4M7XQi+ONLvP0R7iy1pXEpY9Q
         W3NvJhKxNy2cD6xwLZkNsgh4MIBrSO6EbPqkc8pvReEEkCJeSiHrvnBR6tlzmnzkS8Gx
         U2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2WSVpdckOKo8sTzLhexO457CfG7Z/d/GCqQg3H5ly1Q=;
        b=jZzE6e+Mv2YXk4oeOzy+ponRSrfh+fl5krPj3NZ4TX96LMRGNbyt/Ogw/H5QPDM9kU
         0RL1nQJmuxkeguwXHNqQqfTXQ0qjafOBLuyDbB+jYXQt6nl303SVK8Dwb3uvZzREYj6y
         q/CTCf31IwSZsKGqQ7XE9IcOYY9F3zwfPIBQIHbRdUP2grl6WqKcwOcJk88/sSjflYfL
         EQMiGifzEk/98je2fQQXaBJSrKK5SQoq2/jkHj5S8a5hkmbQtLIf3HPMssfgngeWd2vx
         H7yyIPpyu2JaL5wRW8u99kZ90SuAZLUjEubdaDKcUBBXayt+mf1RRM4nSOiLFu4g9rsB
         Y6Fw==
X-Gm-Message-State: AOAM532jJzqT6qYHmA0+7mdTOTFwVF8xZ/CMWwbRf87nGmwTHMXO5AK3
        Q7JxECMw2O8YuQttl4GZ3MnLJP1Uz2A=
X-Google-Smtp-Source: ABdhPJz9ZjoaEOpLiV9sUXEPa13DFPzUv3Z0/x3t/wkFpSNNTStEEFIkuqxfZoNugF2s5Bqs600zRg==
X-Received: by 2002:adf:ee4b:: with SMTP id w11mr11882442wro.115.1637363038301;
        Fri, 19 Nov 2021 15:03:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p13sm13541008wmi.0.2021.11.19.15.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 15:03:57 -0800 (PST)
Message-Id: <889f613ab188bdc883d85f40988a3eda2dad19a5.1637363025.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
        <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 23:03:44 +0000
Subject: [PATCH v8 17/17] scalar: implement the `version` command
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
