Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EABC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BAE661A79
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbhKQOXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238417AbhKQOW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 09:22:59 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A52C06122C
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:38 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso4941024wms.3
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=97iVUlZN97wuaA47a0t2uiGKid4HTvg3w7rjoSoQOX8=;
        b=Y3sWOq46uM3NDM5UijyYrn6ARWoQESw4H9jP8jqhA62dX/yzI3oJ4VFELFMoUPVI9Z
         yCKtXL54kTz9tY115rMh/Ac/41CgpCx2mcSECXXutSS0S8Y4qqPUSBMzkofze9nL095v
         KbfxshwM0XTt0W5s4eW/zLKpHeLaslHpN/E7g+/+a4aHySHbj+sFLQjsabAEOZq1KRgH
         V+jRCEYi/OfvjJC3f2E4zZeyzgDm1zWqO7K+PgnfJCWPQADsteN6ivpbagG2h8Tn/sDp
         zstuMaQnBbhJQMddYDeRDPu8B2Wf4MieWjRnIetElacYrh32tU+oKbwLAwQIVqPwH8ek
         roXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=97iVUlZN97wuaA47a0t2uiGKid4HTvg3w7rjoSoQOX8=;
        b=hnopXO/pQOweVtlAiJJLTGgpxhbb6rVxbukKOLqH1GJbC4MKwRtenFh58YVlyy+W8g
         uMYwguUX0qvjcA5zSxANWqYiahj2tRHYzcC6V0y30d5feJUPvpf+OP8v6HDkOQ443o5r
         EDZvNSHhQmI4Qkjzquv52lM4IfjSCKn04Ynu+eBuztGtZmI2Q+jlLdTAGKmup/UBE16Z
         FIe1yvgvMxtd8LhU4Nm1xh2c/OJ6F0HTyUjg3yQSlLM8SppGMLC7QNyHI65ZtscCTcZ8
         w5cKT5ksd8zsHkdpEmR7hWyXGuc+Ozc/fbFVBVVaj73KcNlRa0nt9JIi/WQkG34z5tj5
         krsg==
X-Gm-Message-State: AOAM5317y1R2w9i7Xn3wg41okzMI3UCY1oVn4sDERBv18NMoS/FfScY6
        jtmFzuhJEbLIYTFnKy0xajK73p3+UYw=
X-Google-Smtp-Source: ABdhPJyF0n68O1O90RXJLpV26xfJQ7hmm+hod+wqcJQuUmf03eLWKQZLv1kPmqNgbo22rxqnbabtDg==
X-Received: by 2002:a1c:a5c7:: with SMTP id o190mr6739wme.186.1637158777285;
        Wed, 17 Nov 2021 06:19:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm25749wrp.8.2021.11.17.06.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:19:36 -0800 (PST)
Message-Id: <dfa0c4709890acb522f791c84af37bed71a4ba1d.1637158762.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
References: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
        <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 14:19:15 +0000
Subject: [PATCH v7 10/17] scalar: implement 'scalar list'
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
index 097d3bd478b..4feacd8d62b 100644
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

