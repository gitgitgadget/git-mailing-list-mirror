Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70077C433FE
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 11:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhK3L67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbhK3L6T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 06:58:19 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870BDC06174A
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:54:59 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso14554329wmr.5
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AdTnGWdf70EJL03j4oz0mW5N6Ss1tIPbDoMbKCDSoeQ=;
        b=IdV25p34XAtViOBKTuWs0m5wxoP1qvKcYFGAADleCQZ+avGd61CMw9D2aabn6xLqY6
         BTtD+xHBJTQIve7yymPfMSwzkccLMo/A2rwokrjWpZq9qJRoNMhcl0k3J5iK/Yj7EAnR
         N0ILM5SPkTuDyISeCM5p8VC9JUlxToiXz3M9PXyCnGdu+KxDy2ykLYZDNKZe86asyUNp
         EsQZmyvwYOP8SfUMI2RleJVe6thCuIpHZqhgo6b9r1SsBy1T3T+sNMURGYT6rDX4H7SD
         XBrAAFuJVyt9yLtbnGnWMnHr5k1gcpT390TMhW5AauFg7tWwwi91QsmkXgaNJFdP8n47
         ksXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AdTnGWdf70EJL03j4oz0mW5N6Ss1tIPbDoMbKCDSoeQ=;
        b=Z5qN2aXhS0Wj1YqlmdyhuckcpITlCoquF5UtvEAv4J1H2dVTbc3plKLfhIlVwmPiYe
         icUGYBcr89dWnH8VHzeiqZdGyXEIBQV9tcqwV6E+tK7UvAiPyNavrt08s/Ybk3jyb8D7
         EuijNIr5bJmCx72rH4QUd7OH5g4RUq9AytGVMGLDojuKPknBmdXA8wAuDoOmadLsBFps
         mwlKP5Eo69MwkBYu3DaDeGlaGrK+RmdJUJfFIHYtXvvJM/8pADIf4TVaNV5dlH+mgKNs
         R4xa2S+nW30Srx5u+CxctHXCZR/Tssh8szU/i3mj6r9vrvZv3qhR+4J4pvdYlMOGhSEu
         sXTg==
X-Gm-Message-State: AOAM533vJfxmidZKYTXvnMRabMVuZoK7e1NnUX2bVFXyyrrOHD/VV0iu
        dQsAIV7LSbhwr2ZLUJwAVt/Wz2pEooA=
X-Google-Smtp-Source: ABdhPJzTARS/6MLwSYkL0y9s9qwkBaGjdsDhIVXmzM4JDlCPUah/+gzY5r6DD5RN7I7L4R12KgDTfg==
X-Received: by 2002:a1c:3b04:: with SMTP id i4mr4437597wma.126.1638273298048;
        Tue, 30 Nov 2021 03:54:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18sm15962803wre.7.2021.11.30.03.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:54:57 -0800 (PST)
Message-Id: <6afb2eb4163ab92d8e107674f7766281b05fbe24.1638273289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
        <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 11:54:42 +0000
Subject: [PATCH v9 10/17] scalar: implement 'scalar list'
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
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The produced list simply consists of those repositories registered under
the multi-valued `scalar.repo` config setting in the user's Git config.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c   | 11 +++++++++++
 contrib/scalar/scalar.txt | 11 ++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index ec783e72ef3..65da885c5ac 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -251,6 +251,16 @@ static int unregister_dir(void)
 	return res;
 }
 
+static int cmd_list(int argc, const char **argv)
+{
+	if (argc != 1)
+		die(_("`scalar list` does not take arguments"));
+
+	if (run_git("config", "--global", "--get-all", "scalar.repo", NULL) < 0)
+		return -1;
+	return 0;
+}
+
 static int cmd_register(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -337,6 +347,7 @@ static struct {
 	const char *name;
 	int (*fn)(int, const char **);
 } builtins[] = {
+	{ "list", cmd_list },
 	{ "register", cmd_register },
 	{ "unregister", cmd_unregister },
 	{ NULL, NULL},
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index d9a79984492..f93e3d00efd 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -8,6 +8,7 @@ scalar - an opinionated repository management tool
 SYNOPSIS
 --------
 [verse]
+scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 
@@ -28,11 +29,19 @@ an existing Git worktree with Scalar whose name is not `src`, the enlistment
 will be identical to the worktree.
 
 The `scalar` command implements various subcommands, and different options
-depending on the subcommand.
+depending on the subcommand. With the exception of `list`, all subcommands
+expect to be run in an enlistment.
 
 COMMANDS
 --------
 
+List
+~~~~
+
+list::
+	List enlistments that are currently registered by Scalar. This
+	subcommand does not need to be run inside an enlistment.
+
 Register
 ~~~~~~~~
 
-- 
gitgitgadget

