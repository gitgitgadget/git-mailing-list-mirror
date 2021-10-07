Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF57C433FE
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 11:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7EB660F58
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 11:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbhJGLBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241037AbhJGLBd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 07:01:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB04FC06177C
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:59:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m22so17895455wrb.0
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HBNrd8h57EHcdKdkPIOTjFextPdmOMJpWyQiiEj8UK8=;
        b=AfjQviz+f0ERne/L/DYtjD7LME0F261U2q4zqA2/gkdkfXT8M9sXLSuoNMuUTdWhbq
         aHPb5JKJVH6JlPYG4CVndAI3D5+fLdbyi5wlaIy/usgDK4gD4WWYoEOVJ9+JJIufP0BS
         lElYer92zuldDmOC7XjlrdKjhxAkxTU0P7umLBibWHT6oL4RkaI5zarUpmsHUczwW1Lk
         Ledvy5FIIt1Zr3h/2crirGdZXm7dsdJbIagkgovbEzN0Gq8FDCFplOetqLR1B9Oc5Wc3
         Idu/Qt1ERBzE39WpX6dXq2DUCK+aQV1ua9YTb/5l9pDGE/V/PLW4hHTiqLQVmrbLBaCd
         V5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HBNrd8h57EHcdKdkPIOTjFextPdmOMJpWyQiiEj8UK8=;
        b=PVNprEQrSU66wXeE5lF4juBKyrMFHE6ZVthDEFcVbcA4UUxxrgfO9jvdKw2xCmDXKp
         HXlxk5IVZ4DSwDGxON7ha3IxzmcnFLebEKhCB2WJdf8oDIgRb0CuDVSvIkFLwOCyb+5W
         5DIjMhZSaWnHhEoZzJzksbhy6iwtY8qPYEbUysHmsbFaYkv/sdbHd0xyzasAwSZxEYg3
         lKPDBLK3wWl5McDlANklgMA/Oo2chkKsjiYwigvSfZUoXNCdQzDOa1fZGAxw94zLsAP8
         2Yg9kpW+3ArlXX34FCa0Eyfk8tr+sH9mDHmsJrZKgRhX37X84EXBNVvPRpQgbH9v0RMX
         Jghw==
X-Gm-Message-State: AOAM530He5HnZXCGyqRKZTK0DnF3Nq6BlNSb7+E3e7oYUF7NsrHye5pQ
        Phhs/Z5UqBLb8msCJX6ns8zLij9U5Z0=
X-Google-Smtp-Source: ABdhPJzezEkLDGjmy+8uTprBNFTR4pIvZn4KYMeJl9uiC7oaBCTLvNTprpUpR0jX8IJh8ZAZEQIsTw==
X-Received: by 2002:a1c:f002:: with SMTP id a2mr15425519wmb.79.1633604360426;
        Thu, 07 Oct 2021 03:59:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m14sm7765523wmi.47.2021.10.07.03.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:59:20 -0700 (PDT)
Message-Id: <f81e8b3bcf1b8972bc5214b31fdb092bb975b457.1633604349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
References: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
        <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 10:59:09 +0000
Subject: [PATCH v5 15/15] scalar: accept -C and -c options before the
 subcommand
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

The `git` executable has these two very useful options:

-C <directory>:
	switch to the specified directory before performing any actions

-c <key>=<value>:
	temporarily configure this setting for the duration of the
	specified scalar subcommand

With this commit, we teach the `scalar` executable the same trick.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c   | 22 +++++++++++++++++++++-
 contrib/scalar/scalar.txt | 10 ++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index b2e92cf63b5..6c496318bd4 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -807,6 +807,25 @@ int cmd_main(int argc, const char **argv)
 	struct strbuf scalar_usage = STRBUF_INIT;
 	int i;
 
+	while (argc > 1 && *argv[1] == '-') {
+		if (!strcmp(argv[1], "-C")) {
+			if (argc < 3)
+				die(_("-C requires a <directory>"));
+			if (chdir(argv[2]) < 0)
+				die_errno(_("could not change to '%s'"),
+					  argv[2]);
+			argc -= 2;
+			argv += 2;
+		} else if (!strcmp(argv[1], "-c")) {
+			if (argc < 3)
+				die(_("-c requires a <key>=<value> argument"));
+			git_config_push_parameter(argv[2]);
+			argc -= 2;
+			argv += 2;
+		} else
+			break;
+	}
+
 	if (argc > 1) {
 		argv++;
 		argc--;
@@ -817,7 +836,8 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	strbuf_addstr(&scalar_usage,
-		      N_("scalar <command> [<options>]\n\nCommands:\n"));
+		      N_("scalar [-C <directory>] [-c <key>=<value>] "
+			 "<command> [<options>]\n\nCommands:\n"));
 	for (i = 0; builtins[i].name; i++)
 		strbuf_addf(&scalar_usage, "\t%s\n", builtins[i].name);
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index 6fc57707718..3a80f829edc 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -36,6 +36,16 @@ The `scalar` command implements various subcommands, and different options
 depending on the subcommand. With the exception of `clone`, `list` and
 `reconfigure --all`, all subcommands expect to be run in an enlistment.
 
+The following options can be specified _before_ the subcommand:
+
+-C <directory>::
+	Before running the subcommand, change the working directory. This
+	option imitates the same option of linkgit:git[1].
+
+-c <key>=<value>::
+	For the duration of running the specified subcommand, configure this
+	setting. This option imitates the same option of linkgit:git[1].
+
 COMMANDS
 --------
 
-- 
gitgitgadget
