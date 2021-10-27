Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1D7C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBA161073
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbhJ0Iag (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240949AbhJ0IaI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:30:08 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B9EC061233
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j2-20020a1c2302000000b0032ca9b0a057so1620684wmj.3
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x4VHMf5Ie9TYvQ9UrPa0BHCWFCVGGp9dxV4hFNAFBh4=;
        b=C1Li2CiyMGhLXyH8mBLhdTW/kL4GoWU7tHU1pBN9PKG426Yj82uf3D10L/s38rGic7
         3qzIt6ughxJylFYHWWQ0g0m0/3Sn05WPSVuOLo500Y5I1zCbFeb9ssowL/j4ts+7H1KZ
         PWG7wgTFQjluNrc4/c8fz7r4+CrE7pMRiZuuiFd1Qr0lbHXVIRORVErwztKLSpsS+1DC
         BXCuNqa1s1icRbvcQKGBIBbJ0oPXjd3JHxQyBp5K3Cj9dOV6121RESCrHsLKPvnPE4X1
         dXq2ttTd/GjPv6eA3Z7E8Xs+/27Hnk6iXbiE0+AmgxQcj1JMk+pLpkshKMd4+Tns/8AJ
         u3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x4VHMf5Ie9TYvQ9UrPa0BHCWFCVGGp9dxV4hFNAFBh4=;
        b=qD/7fXFtYhpKTQHWGhp6Y8ViOrOb27ldCgvHDd1FRDat4p18tc9d5Y4lhyW5JL6SBA
         lityJvu2QWvM02tjA0H5g1zYJdhv4xeNgNHHsBE+SllFKXHN+S97lHezTk1RgC5DQHfq
         5F40EQRkDZo9KbxMyaTYtbeR6zQJpbcwUto4pIvzgT+I0YhMbeFhoK2fmqDjcx9yCtht
         fzxcxkc2E6WyDJJIrBmwdQPWix+MP/qby14NC6umwaoUzU9IFnJ8023H/T1mpO0sZuvY
         l1xq/aBEGkoYw2v7MbCYFptb/mrks4MKXXK+28Me36tVNyEwah67tvf5ZKn/yImrIJMx
         xwJQ==
X-Gm-Message-State: AOAM531XtRHboeuw2gf9WVtL1mKnYUfvIBsWJgSp8ObJmBDWGg/6XkGt
        qxO1HnxZhkVMtYQ/otnlwVjHceypEFc=
X-Google-Smtp-Source: ABdhPJzaVQy03cS3hcZtuQ5gls9jJYge8ALBKo2/5uN3ZELlz+0Pf2D2vAjuLMScrYDVZVmUt1j6Rw==
X-Received: by 2002:a7b:c4c4:: with SMTP id g4mr3111886wmk.93.1635323249424;
        Wed, 27 Oct 2021 01:27:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t6sm15316710wrw.78.2021.10.27.01.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:27:29 -0700 (PDT)
Message-Id: <e3a6eea0534d4e0ae5e9597b1dc3b86bfd9bffe2.1635323239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
References: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
        <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 08:27:19 +0000
Subject: [PATCH v6 15/15] scalar: accept -C and -c options before the
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
index f416d637289..cf4e5b889cc 100644
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
