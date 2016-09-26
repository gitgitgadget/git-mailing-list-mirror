Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E4C8207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 19:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938318AbcIZTgT (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 15:36:19 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35458 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934954AbcIZTgS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 15:36:18 -0400
Received: by mail-pf0-f178.google.com with SMTP id s13so34495770pfd.2
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 12:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=H3DmpGFM3/wCNMJAYWzYzEE44qEAPXTDFKp9xVJJhsY=;
        b=O9JsOulOe3j6st50hUdQVPNUGv1PL6nHKITo/0tqvfRyduoz3xUp933nwfQ07MH7Jv
         56GOr6ipNcc37C7Ct+z9cRVGcM5CNaL9LLGmCPy5JDcaqh0QEsdduM2n6gZthEb3y3XY
         g+zZSCe0VOe6SvhttnuCHT5lCkbRhdJLBsnIpIUTlN44nHOTbTfT96S8OOFsW34T26Mm
         /z0UlcrB4gqxBFq5YlhlxOGBYsn1rnk1VXT13U9trfyvNjOMMZ9C94kJh0QjzcrC6alS
         5A4/2oCFQq2M2WG+CUjhCCRut6bLrAurLhAIzwGns3chBAAef5Hdz2ImMx3t8H5kVNZd
         QtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H3DmpGFM3/wCNMJAYWzYzEE44qEAPXTDFKp9xVJJhsY=;
        b=LjPacwxTYAe3RY8/FMbYNwviL0DqdVIPWKIH1ilPMb8UtgjsLdYR6nvbehSG9UPyhG
         6iNgKfYthMCGYET/bXNSUdbvzbfaboL9afLWiKKR9nc431pcAAOvv81P+ixXV/YoUGwz
         skdBXtBmZRgaXzeOrs9Wvp9UZdWGAw/K8JhMv038j+XG7ZdoVYCESOG3T5CfOqELKESJ
         L2/j10deyG0UUGulPrgGFaIrK+xOYZzxNPGV7gIhyT3z5GR1z5ot9aNoCzOOHE2PWMk/
         ttxdY7IQTiPeExHGHNwv9auG6+zn6UMlPB+hQhZP4TZE7ufsC18hdwPuvB0wP/YLVx1L
         RY7g==
X-Gm-Message-State: AE9vXwOIEc7wunZrP5p1RiFqR2f/am3g68+V7w84dfBb5uvCY8mhVXoUevkoBQLjiPWmkiuT
X-Received: by 10.98.93.85 with SMTP id r82mr41173846pfb.168.1474918564485;
        Mon, 26 Sep 2016 12:36:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d08a:7802:9eb5:6fd6])
        by smtp.gmail.com with ESMTPSA id sy4sm27685159pac.48.2016.09.26.12.36.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Sep 2016 12:36:03 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jens.Lehmann@web.de,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] Documentation/fetch-options: emit recurse-submodules, jobs unconditionally
Date:   Mon, 26 Sep 2016 12:35:53 -0700
Message-Id: <20160926193553.32631-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.129.g35f6318
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the section about recursing into submodules is repeated in
git-pull word for word as it is in fetch-options.

Don't repeat ourselves here and include the --recurse-submodules via
fetch options.

As a bonus expose the --jobs parameter in git-pull as well as that is
declared as a OPT_PASSTHRU for fetch internally already.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/fetch-options.txt | 2 ++
 Documentation/git-pull.txt      | 9 ---------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 9eab1f5..352b640 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -89,6 +89,7 @@ ifndef::git-pull[]
 	option alone does not subject tags to pruning, even if --prune
 	is used (though tags may be pruned anyway if they are also the
 	destination of an explicit refspec; see `--prune`).
+endif::git-pull[]
 
 --recurse-submodules[=yes|on-demand|no]::
 	This option controls if and under what conditions new commits of
@@ -108,6 +109,7 @@ ifndef::git-pull[]
 	submodules will be faster. By default submodules will be fetched
 	one at a time.
 
+ifndef::git-pull[]
 --no-recurse-submodules::
 	Disable recursive fetching of submodules (this has the same effect as
 	using the `--recurse-submodules=no` option).
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index d033b25..e4cd56a 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -84,15 +84,6 @@ OPTIONS
 --verbose::
 	Pass --verbose to git-fetch and git-merge.
 
---[no-]recurse-submodules[=yes|on-demand|no]::
-	This option controls if new commits of all populated submodules should
-	be fetched too (see linkgit:git-config[1] and linkgit:gitmodules[5]).
-	That might be necessary to get the data needed for merging submodule
-	commits, a feature Git learned in 1.7.3. Notice that the result of a
-	merge will not be checked out in the submodule, "git submodule update"
-	has to be called afterwards to bring the work tree up to date with the
-	merge result.
-
 Options related to merging
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.10.0.129.g35f6318

