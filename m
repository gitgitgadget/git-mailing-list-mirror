Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1B9A208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 13:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753753AbdHUNff (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 09:35:35 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35379 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753387AbdHUNfe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 09:35:34 -0400
Received: by mail-pg0-f66.google.com with SMTP id m133so4508676pga.2
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kB81fQK/ZBlRb+cvm2wJ9R1muZjgpLNu7gLnM5ggVnU=;
        b=GwUce6YDmyC+HVjunddUtSxIxiMo6TD/ga+b9jYsN6NXVeg83Zdp1SqlOU7FBO9Yl9
         0+J7RzSDf51NV2thTn8/o+jcu/PA9gP3QvFoDoJKRPRMVxuWNcaooVn8s7UFqtrYT07x
         Bi40l1y4L09GaFl3TvRIN1iOdrmjmW/jj8+Vcqe7Ua8imR5fTuW15QtGjsrgs7HbCP/g
         ls85GqgiWxp+Y8qEx0EUGxOjns9gZRUuPsiJ60z4eEqT8OTkS7hvQnbjMng1+KiRZi8F
         UHlosI3bOPgfPunDvKkb6RupKV6qgsBA7v/19WOc/a+pwY2PCB6/EtzKGXkpZxxU9Du3
         +Wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kB81fQK/ZBlRb+cvm2wJ9R1muZjgpLNu7gLnM5ggVnU=;
        b=UYjvfJ7XLDjvofCEeWk/2qVn6BG25wCU4tdeX2MPha503Mj2hpwYsvF14FCdS7UcEQ
         HD/QDbCabpSKaDrKjUv0vSEFwsaajPq64HyUZyq8AQbzvCX37Mucw031xiLz+8nW42p0
         ZxuXBirOwRjju/sEH6qC+aCUZSo/mEFIj8e2wD/JvbgGbyopy9Db6Xq541bE/sKPO4On
         zqKcaA4TTVHpMrhBH9wQZg7md66jJu4Ae7xFtFsQX7nrQM2fexelUe8seK0T0dRhH6qP
         NU90CL6kViBFL0nJqvH08ZzPi2lANL8odwcW8f+b17mMZJJf0B9Wgp4jBoFoOU2xU+TR
         /1WQ==
X-Gm-Message-State: AHYfb5hUQ2+S+PhvGndxsJXQJxer9KRynjDspRXXqLNnd0BNJ66YKcRM
        NVjQGiGQd/mdLg==
X-Received: by 10.98.8.65 with SMTP id c62mr15023353pfd.267.1503322533488;
        Mon, 21 Aug 2017 06:35:33 -0700 (PDT)
Received: from localhost.localdomain ([117.246.169.117])
        by smtp.gmail.com with ESMTPSA id a4sm4115497pfl.147.2017.08.21.06.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Aug 2017 06:35:32 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH v2] branch: change the error messages to be more meaningful
Date:   Mon, 21 Aug 2017 19:06:08 +0530
Message-Id: <20170821133608.5652-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.656.g66e7d6d0f
In-Reply-To: <20170730115908.13841-1-kaarticsivaraam91196@gmail.com>
References: <20170730115908.13841-1-kaarticsivaraam91196@gmail.com>
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

