Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E076DC433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 14:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJGOiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 10:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJGOiO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 10:38:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7629CFBCF2
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 07:38:12 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b7so7590043wrq.9
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48/iS7LeqJsjy4OT+ueXQXou+jViItrDvxmBZ6Vw0sQ=;
        b=Fas+nPvg8XxhE/EqbDLV4nflOhQx1Qo1pIm0fIQKCEsm9w4sHqK/O6/UYwKFbAQvvt
         T7GeQEQOzj3bRiFW1Hhb8cFHbKvnoyM/oJ47iLIKYiZLkipB7QVFx94jwTXQ0/dAcLnb
         X84GK53KgGnO5bv1TY3Lek4rwFwRd3C3aihoNh2mpj0/1p1gvBBtNnLiAB/rD5DXWud0
         rwL6oUQ3FPBC9lgXa8Pp3Hg38CiFVP1daK9IDAMQwRIMg75d++M8vDSyl4hgvbFRLp4Y
         TwkPv8nSSc5uTKdtm2m1qjF/aq3ZCsbs9ElzqjkC005CcnXYtFD4tkkSI/p9vR3poAcj
         yhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48/iS7LeqJsjy4OT+ueXQXou+jViItrDvxmBZ6Vw0sQ=;
        b=thqzmn/prRGJRrPgNVUUK2ImIjfUSGbxX+UzPexcVyDAhu/28vIZ2ArX3Lypls0nha
         zwPStd+IskolFObQSCPHEVZGm3nsYs2CiwyqE1s+BTt+3iKvPBskdR64zTJEk6gZVgiL
         WHmiHqtTp6Fg5SIqxty8kaUif3ve9jboX8hi5pObYKFEryrYUYPCpNi/+m+J4jeIg52Q
         bjK1qtFGSSvwcIetQ+YTmTc0xBT+EAhOv+9Vx2Adegnre7nxcxkAmMNjTL1qCXdb8HQb
         4XF1MZWwh3zRR0UpjXKCD8DzB9Jcpz0HjeOnYT7utubE/8wHXOxmb1bnHDFsWRQmmXmA
         k8mg==
X-Gm-Message-State: ACrzQf2ABpfs/zTipwNjEzY0oiWLiq4462WLfmD/heHJFQIE0LU3ZMbM
        D+X+WYHNGxRHP5MIRoI9U004rPHAkco=
X-Google-Smtp-Source: AMsMyM6WRT/aBtFN2BCys+3lnNnZ2NGWLLmP2MuY183mYBlLcEtv4ENfoHdFFZB2yAi3zDMFP8fyDg==
X-Received: by 2002:a05:6000:5ca:b0:22e:5477:1296 with SMTP id bh10-20020a05600005ca00b0022e54771296mr3552027wrb.377.1665153490601;
        Fri, 07 Oct 2022 07:38:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d44c2000000b0022e55f40bc7sm2211203wrr.82.2022.10.07.07.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 07:38:10 -0700 (PDT)
Message-Id: <7fe59688018d195f27456af029d5b4fd8e40206b.1665153486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1355.v2.git.git.1665153486.gitgitgadget@gmail.com>
References: <pull.1355.git.git.1665056747.gitgitgadget@gmail.com>
        <pull.1355.v2.git.git.1665153486.gitgitgadget@gmail.com>
From:   "Daniel Sonbolian via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 07 Oct 2022 14:38:06 +0000
Subject: [PATCH v2 2/2] git.c: improve code readability in cmd_main
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Daniel Sonbolian <dsal3389@gmail.com>,
        Daniel Sonbolian <dsal3389@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Sonbolian <dsal3389@gmail.com>

checking for an error condition whose body unconditionally exists first,
and then the special casing of "version" and "help" as part of the
preparation for the "normal codepath", making the code simpler to read

Signed-off-by: Daniel Sonbolian <dsal3389@gmail.com>
---
 git.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/git.c b/git.c
index da411c53822..340ec8bcb31 100644
--- a/git.c
+++ b/git.c
@@ -894,12 +894,8 @@ int cmd_main(int argc, const char **argv)
 	argv++;
 	argc--;
 	handle_options(&argv, &argc, NULL);
-	if (argc > 0) {
-		if (!strcmp("--version", argv[0]) || !strcmp("-v", argv[0]))
-			argv[0] = "version";
-		else if (!strcmp("--help", argv[0]) || !strcmp("-h", argv[0]))
-			argv[0] = "help";
-	} else {
+
+	if (argc <= 0) {
 		/* The user didn't specify a command; give them help */
 		commit_pager_choice();
 		printf(_("usage: %s\n\n"), git_usage_string);
@@ -907,6 +903,12 @@ int cmd_main(int argc, const char **argv)
 		printf("\n%s\n", _(git_more_info_string));
 		exit(1);
 	}
+
+	if (!strcmp("--version", argv[0]) || !strcmp("-v", argv[0]))
+		argv[0] = "version";
+	else if (!strcmp("--help", argv[0]) || !strcmp("-h", argv[0]))
+		argv[0] = "help";
+
 	cmd = argv[0];
 
 	/*
-- 
gitgitgadget
