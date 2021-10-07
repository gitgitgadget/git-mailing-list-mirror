Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B193C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F63C60F58
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241023AbhJGLBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241008AbhJGLBX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 07:01:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C315CC061767
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:59:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r10so17793041wra.12
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QyrukTNVfouEeAzxOv26evBXhIGqbMFj9uesv2a/2bw=;
        b=HnrLKe6j4tkDBeQL40F0WdypaxoWKP+MJTJQr9OpzDaXUA6apmzyGANMnSjlbcD3zX
         Dn+r1TAHLtDKc0WTjpHLmDpQa8ZAENjxL5NUcpNLdyTX1eppWBLLOYy2yJOvn282mu54
         CXaRpt4GvAnS11ZxYjPyUCv6Nav1pCgDgy9u3Mm4xERZIGfOXm1gz9o00ARAy5YOjY48
         yHgEpfxvksFGmqvX+kxuSYn3XFBsk1YSbAbuK6gEEj0DGdkwpypMEhwpyJ1x/n0OhAhA
         SPTUt9fudAro6spsyAYk3yokOQd0ZcS4fg4dqmPGO9Rw4ImFhC01+O/bAYK7sQ2Ff24j
         ofcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QyrukTNVfouEeAzxOv26evBXhIGqbMFj9uesv2a/2bw=;
        b=TRjdilxbcPfSrrfKkXcMjxGrSv8/F75cuVKL3yUkdt5IFqMYrpF6x5usVFV9p5mmLi
         X1tGhx2jTy08Wjo/HdX6CeUM3iSuc6NbbIfGM/GWTAN6Dq6DPdMAE2Agmy2RWGcV08JS
         vWUOsDo1SEJifeOHxACBju37bn1d2N4XKxEfG9XCFo2+VTSW9NsFC2TIEeE4W+3v1l8w
         /GBBpcwybfbCMSMrofrMX9uhUOLKISKdRdu23OQijb4R89WJtoFVTY2owlWNXuh6pwe3
         Y0S5tSfreZTQCuerdurRig0+alLFlotTTK6TBP+wxPVSQoNTp8lvXIK+UxdmEr/OSmYo
         ZqkQ==
X-Gm-Message-State: AOAM533O4dKwzBD0EwgnDDS0Hecgd/9v1ZXa9k6Zo0oWoby1xfMMEfK/
        neP6Y3Are5kSVVfYAr8mUD3VYEqppm8=
X-Google-Smtp-Source: ABdhPJxxFSrs15D5q16TgFG81rRkULz8EN2r71jk7kRdxV7fDCKtlEzL8kAQ+2Y0CK/5YvCQf998Hw==
X-Received: by 2002:a5d:47c3:: with SMTP id o3mr4571972wrc.25.1633604355415;
        Thu, 07 Oct 2021 03:59:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l12sm17507662wro.14.2021.10.07.03.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:59:15 -0700 (PDT)
Message-Id: <12efa86e4cb3e09b18e002b8a0cfaf0c27f939b0.1633604349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
References: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
        <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 10:59:01 +0000
Subject: [PATCH v5 07/15] scalar: implement 'scalar list'
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
index dc84ce0d5b2..d13eb951c3d 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -250,6 +250,16 @@ static int unregister_dir(void)
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
@@ -336,6 +346,7 @@ static struct {
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

