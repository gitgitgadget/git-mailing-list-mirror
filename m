Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1771C208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 13:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753986AbdHUNiP (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 09:38:15 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36791 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753874AbdHUNeM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 09:34:12 -0400
Received: by mail-pg0-f65.google.com with SMTP id y129so23851504pgy.3
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 06:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kB81fQK/ZBlRb+cvm2wJ9R1muZjgpLNu7gLnM5ggVnU=;
        b=Aev1IIe/O2qOnQ4l6Gybs6fq1UH5tU1R2+D+kwttVkmJl6opDlEXdAqulRel318lPy
         4T2oTM7yQGqmiuVxXJz8Ek/9wzXPV6JtMtILaf0lPo2gKNoZZ6LsjyJkJ1iXw/hGqDgZ
         UpZdVeFLobZq6+sRvTUe83I0YmxTOC3GCmrVtl25wwTjrL5pwpWtn1L1ETRCuOOpJSR3
         v7IaVgaiLDBUL9AdIjFrtYhDHM5ZSLk8x4XncGkB4xoAThZuk9QlhnA1OzZxhE9SSGXw
         zttApzxwu9PNixgZ8KVUiN0UElmAkIjKK4RpIkWTzpdPrAZdMwNVbAz8p3x3HzrGBDPw
         8mLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kB81fQK/ZBlRb+cvm2wJ9R1muZjgpLNu7gLnM5ggVnU=;
        b=FF3e/AsrgXu5seFNDsveCj/6bQwhmgJhvrLAZrGLqEumIN2PVqK1Q6ZJeMApGwtvYn
         OCBuGPo4cwAdGUPlOreSNvvT3ylSxVNbffCnaZYIHRYR7WHuNfx4PfoFBLakoKhDDNTv
         VN+wSSI3IRIa2mAgIqwOVV1VHxpk8S4lsnguhGJbsZw/CbsQcQsJKFMJU9zcVFlcWyrd
         NadbAbKwSUmMJl921QFdME9SOV0IcRC54PqUH+NgoymRCz9i4BonOTzUJ9ShlXxl31IT
         lt0W7vOAMOrD0BhOxFv0zZPlb30BLNelxVQRRnyenfpDuABKbiC6a+Q4JUFzw9P3d9UW
         6+rA==
X-Gm-Message-State: AHYfb5gnn+HaRk8ndpfyrWJOxZAmG89A20+TymORBcPhJwoQsKOtFTOm
        gNCZo0gnpee2mA==
X-Received: by 10.98.131.143 with SMTP id h137mr2451440pfe.259.1503322451869;
        Mon, 21 Aug 2017 06:34:11 -0700 (PDT)
Received: from localhost.localdomain ([117.246.88.188])
        by smtp.gmail.com with ESMTPSA id e13sm21388836pfk.27.2017.08.21.06.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Aug 2017 06:34:10 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH v2] branch: change the error messages to be more meaningful
Date:   Mon, 21 Aug 2017 19:04:40 +0530
Message-Id: <20170821133440.5552-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.656.g66e7d6d0f
In-Reply-To: <1500107583.1850.4.camel@gmail.com>
References: <1500107583.1850.4.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The error messages shown when the branch command is misused
by supplying it wrong number of parameters wasn't meaningful.
That's because it used the the phrase "too many branches"
assuming all parameters to be "valid" branch names. It's not
always the case as exemplified below,

        $ git branch
          foo
        * master

        $ git branch -m foo foo old
        fatal: too many branches for a rename operation

Change the messages to be more general thus making no assumptions
about the "parameters".

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Changes in v2:

    - changed the wordings of the error message

 builtin/branch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a3bd2262b..62981d358 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -707,12 +707,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		else if (argc == 2)
 			rename_branch(argv[0], argv[1], rename > 1);
 		else
-			die(_("too many branches for a rename operation"));
+			die(_("too many arguments for a rename operation"));
 	} else if (new_upstream) {
 		struct branch *branch = branch_get(argv[0]);
 
 		if (argc > 1)
-			die(_("too many branches to set new upstream"));
+			die(_("too many arguments to set new upstream"));
 
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
@@ -735,7 +735,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		struct strbuf buf = STRBUF_INIT;
 
 		if (argc > 1)
-			die(_("too many branches to unset upstream"));
+			die(_("too many arguments to unset upstream"));
 
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
-- 
2.14.0.rc1.434.g6eded367a

