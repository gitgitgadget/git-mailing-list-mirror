Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21138C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381154AbhLCNiY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381076AbhLCNiN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 08:38:13 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D81C0613FD
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:34:46 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id o13so5716191wrs.12
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OV69YLrfn+4NmtmyV55tOgEZ82XpKu32hPU3F6o5+x4=;
        b=oVEZdvdf3UdETbk98H/hQKl+vN1GW7FNBj93Eu1ip8nn6ivnHqDPmmFoG5BsZj+DLm
         PJBnETpGGuD2YamjF0I8FuOmPjB68UjiF3fSqH4m1jHcFyU0hB1rUiQSqTzkvjIW1Qyd
         yLwX6zw7m8hgMrFF9wAG48ewxcv+/AXrGOLsUVx7ZcR8LeHgptCMU26s70U6bSeXLEoo
         5UqUa/UCCLeWq8C0VcmpVBjgXMvwwMwouSJjKhtpXjHAJEpCQuaj2phAYnV43ly+D+wG
         aTvqVhsdj/0fJqFJ27zCxCKX6U/f0UaC3aP9mTZ0LFHTAy804pxr0RiPT9njhJBH9xTr
         qtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OV69YLrfn+4NmtmyV55tOgEZ82XpKu32hPU3F6o5+x4=;
        b=zIleBi8Ko5xm8EwpNeYOXXA1LU1UopIjglR1sAuCzl6ZygZ2aIo2vNpFXow3ReCAbn
         KMBpm+OCeaE5BcokJmUa97eF94Z1GP51Z3SgJrH3gSi0IvO9jO08emv1mxIbd9U1xKv7
         7vmtqni1DxdbgvTiiLFz3gFgQ4WlpeDYpvZWbmaNQ91+gFEGgyg+Yy6Uvuk7SrIWlhSw
         hHcCjFdR21dMQAXgZ6vWhfbgfCOU1Yuk4lb+d9BBfNtWFKh4EcC6P/3JP5WVBtfgwbYf
         woYEDPv+SRNnbAsPa8cOZVPYM1/ri7NwmktK6ctzBAsdvEfGSQ+VmR+KQx9QCqPvQmas
         rGkA==
X-Gm-Message-State: AOAM531QVCTtqVyFNA5Lnq/UvA+GfboN5VTwbtb0TYxaiMvUb3pdaejV
        dG+61MK3riAOgLMTGJ6qPH1yq+AqqPw=
X-Google-Smtp-Source: ABdhPJytagIthqwTo0Dr8N5mbEQM19GqxX4qeq412W83GGdTlcFO1mo7xCKSIvo3sKF5mZ9IcbhMYw==
X-Received: by 2002:a05:6000:1289:: with SMTP id f9mr20969143wrx.329.1638538485244;
        Fri, 03 Dec 2021 05:34:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm2727591wrt.36.2021.12.03.05.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:34:44 -0800 (PST)
Message-Id: <b5f416d79b4a3d8388f0081380044d28474ede50.1638538470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 13:34:29 +0000
Subject: [PATCH v10 15/15] scalar: implement the `version` command
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
