Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F1F11F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbdGaU5V (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:57:21 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38885 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbdGaU5U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:57:20 -0400
Received: by mail-pg0-f67.google.com with SMTP id 125so18814681pgi.5
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 13:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+vCL24wLCczY7m58QNnjr7qiyYlwKak+CydqdQz3OiY=;
        b=pF2sMaHFV4PfA49FBED3dvFue2zvgncJk9CeFIskVvKvRfLB5M31vZ4qsNOabAbj6j
         eCe3K1M0Ty5XX38D/hCb1Uqvutgx+xJ84/CCetSZHKogpvZgQo/uaIqkHRqj4i86apUr
         T1ehlmvHf+FunZ5f38wzVmX9UTcZvZieMjFEUZzYwQr6PstsOA33je8iHR0eSBIUBH1p
         jWPrzz0nufEI0+RQd/Wk0JvPVMkgmFA6Ublnu25A7XlfYTGQaT3r6AqXJ734L4g5BHLR
         C9sW/fy+6Ott4HMUfXWX9Jvnwizj0ZOpJDw18l00raK1f3RLGLgDq5f0prDq/rwCmE7f
         P3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+vCL24wLCczY7m58QNnjr7qiyYlwKak+CydqdQz3OiY=;
        b=ZBHsRLwG518TBzkCrIKd8yciy7puR5kCDMWmH6+xYYvUtR9zE026KRP4Hk0iayYNIp
         kOeuSspgVjlsBC2exxMwIL2tIlSwWj8LIjmLWIh8u3SD2m6grgquW9lEIqqE6BEzAkfV
         HRZxBFde5Tix9ran9ERlzZqqbm9IWCkDGVfsTWUw+UHnIeEJvgsK1V1nwGibKpMEEuoM
         FXEPHYG8thizbGcTViF+xPBYrccN92Nq9+h5GNGwYB9nI4J7lXg/YozVBSGxQPQ6SZdr
         Ja35+doq79tiIdiGAolHkAbYxOxBDNBA95xlbQ1OIpLmCZxLLwMUuAOy48hjVK296wIZ
         FLPg==
X-Gm-Message-State: AIVw110i4pAm8c+v4X3IH4ce6HDe0rO9dU4GaCgPYU2Vh/uHdhdijgXb
        24E9k3MRTpKASvo/Uo9Kog==
X-Received: by 10.99.105.201 with SMTP id e192mr16383747pgc.158.1501534639549;
        Mon, 31 Jul 2017 13:57:19 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:6182:3b53:5da6:3508:cb8e:5545])
        by smtp.gmail.com with ESMTPSA id 16sm52881007pfq.151.2017.07.31.13.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 13:57:19 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 11/13] submodule foreach: clarify the '$toplevel' variable documentation
Date:   Tue,  1 Aug 2017 02:26:19 +0530
Message-Id: <20170731205621.24305-12-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170731205621.24305-1-pc44800@gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It does not contain the topmost superproject as the author assumed,
but the direct superproject, such that $toplevel/$sm_path is the
actual absolute path of the submodule.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 Documentation/git-submodule.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index a23baef62..8e7930ebc 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -188,7 +188,8 @@ foreach [--recursive] <command>::
 	$name is the name of the relevant submodule section in `.gitmodules`,
 	$sm_path is the path of the submodule as recorded in the superproject,
 	$sha1 is the commit as recorded in the superproject, and
-	$toplevel is the absolute path to the top-level of the superproject.
+	$toplevel is the absolute path to its superproject, such that
+	$toplevel/$sm_path is the absolute path of the submodule.
 	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
 	variable is now a deprecated synonym of '$sm_path' variable.
 	Any submodules defined in the superproject but not checked out are
-- 
2.13.0

