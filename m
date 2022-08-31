Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1148CECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 16:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiHaQD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiHaQCv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 12:02:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71A6C0B46
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:02:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so2053986wmk.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=/65WLX84ti1xb6mAYXh4iJe/ahbDthLvUFdM3hoa+1A=;
        b=OQOFIzJxQlshfP50ptx19bimGXPlwZpLYOnFCGngQZYNDENyvo7wCwDIyWAC0hX8wj
         bjGw2yR3mjwBMk2fh7+nh4/tvl5ZJWEggD9XgJExkAmM4NunpA0HLXuZcidRBJvJd/Vb
         M7BzmB4Jjyei3tLvbqAsPratlfTVTUahSAMQQnAI8Jk8JNudSPVI6JW6ksqi52qZzsbF
         s0Bcy64IbpoerI+gvDXsxqhsY5fyocgv4Q2wGrmfNrOVKT3soe3LcFCPsl0Pt81iC8gW
         JdT6jdsWYxibsLx6osA5u4oSqdZhFU0ZbFeEmVltHWzdmMbxmaJcz1IIyyuQDZ0xaVBq
         BfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=/65WLX84ti1xb6mAYXh4iJe/ahbDthLvUFdM3hoa+1A=;
        b=qmB1UBUXtRMYLu9gMq8cPE0YrcEXMjRERn9C72a4pZJTM+00GUjCUDwRkYPTY9VaNm
         PzBQeMnbBAs+qdojCC5FvvuB+ExI5WXd6mnmVfK9KX7tDR8xqGS2wo/y6TdKy6xUx5ZL
         TULMUA6LBZAhb8gtT81vqdm2NmD5E/ovSMlvBE/zLDyd0Dt3JdRqS1ZtAF+wjmRIwLG2
         jKXlY5hNfoaDomQSpP6PHRkEoFz7/2BqopjEvWhoODj1OMHVauPZHVFkWwfVkYDWutCi
         jJPRP7qFdObGvzocO6M/Pi6tRFmbbEakiPJFQH8ou66SL5ph2/g9eEtOzdTzexLiVfg2
         wOig==
X-Gm-Message-State: ACgBeo2JZvdh05Ev5qqG5r9uiVNetaOPyBHx7f1wUzQApNGvQboL+Cps
        b5wodc2F+zLlxQJucN1U5QKjjc4iqBE=
X-Google-Smtp-Source: AA6agR5Fow7P1lvxr4SD5VK2a+moYBiZXOi5rFCVYm8Jx3AQavAzPm15CwZyUfBRVbxGiO9TBzwi/w==
X-Received: by 2002:a05:600c:3b92:b0:3a6:8d6:9a2f with SMTP id n18-20020a05600c3b9200b003a608d69a2fmr2502832wms.159.1661961764490;
        Wed, 31 Aug 2022 09:02:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18-20020adff2d2000000b0022542581800sm14601456wrp.45.2022.08.31.09.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:02:43 -0700 (PDT)
Message-Id: <46d0fddfe8fbc2c568cb5a3d14594276db2bc1a9.1661961746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 16:02:21 +0000
Subject: [PATCH 4/8] scalar: implement the `help` subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        gitster@pobox.com, Victoria Dye <vdye@github.com>,
        Johannes Schindelin <johasc@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johasc@microsoft.com>

It is merely handing off to `git help scalar`.

Signed-off-by: Johannes Schindelin <johasc@microsoft.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 scalar.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/scalar.c b/scalar.c
index 642d16124eb..675d7a6b0a9 100644
--- a/scalar.c
+++ b/scalar.c
@@ -819,6 +819,25 @@ static int cmd_delete(int argc, const char **argv)
 	return res;
 }
 
+static int cmd_help(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	const char * const usage[] = {
+		N_("scalar help"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	if (argc != 0)
+		usage_with_options(usage, options);
+
+	return run_git("help", "scalar", NULL);
+}
+
 static int cmd_version(int argc, const char **argv)
 {
 	int verbose = 0, build_options = 0;
@@ -858,6 +877,7 @@ static struct {
 	{ "run", cmd_run },
 	{ "reconfigure", cmd_reconfigure },
 	{ "delete", cmd_delete },
+	{ "help", cmd_help },
 	{ "version", cmd_version },
 	{ "diagnose", cmd_diagnose },
 	{ NULL, NULL},
-- 
gitgitgadget

