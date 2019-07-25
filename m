Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE00B1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 17:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403852AbfGYRqh (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:46:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40607 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403825AbfGYRqc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:46:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so23639455pla.7
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OO0Coi0qgDZFXHMHT94nKLHlJSrq8zSPoPkFmewxRFA=;
        b=FUn6P8K1L2Cmq59E5P0QDKXkmZrydAvVhdSZA7KLygxGU6l3/P019mvHFvhp45HBiY
         8k6uyTTbiAMQv+Cp3RNKxzzcaaIfq3N8oXminp+TCrkucw8hpAdSIHldd85G1BI8OBQ0
         HPbt+UNCv/+sDK2y0AXLAhPj8OS4VrfTdMCC70qE0I5/+41B3ahiGjIwykdNV3CbpBLS
         bUk2gIAC8sQWl/CYelLZvv2ZSdUqnggWoJgib613pdMqtJkJEFVjit+SaA6u691esPL1
         lMGYCxZ9sgZ8H119SveSuHzGJcUWA7pAGqUdDjNRDoPxjd2p+t2VpMb5z07Y9k7EWUCF
         A0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OO0Coi0qgDZFXHMHT94nKLHlJSrq8zSPoPkFmewxRFA=;
        b=Xik7oWCrW4M5hgBNCcVvd0QqfThDJq++smBSVY4GKR/BXc7ogssEdqTuv+uiFOCM9H
         rACzSxmEb3gy1qtcNA1+KKV6kAo31m3k7OAbVVc16JIym/E14fC9mrbgvB/JiZesXJhr
         V51ogM2vLe1Jom4QFXOF9OcZi7QFfMIo3X44BFVp/5ESFz9/nyU7GaKiCPeABoyFeWdC
         AIo13wyRADWbKUuhOzt9jOlMDNQojQmuZE3qhsAdahG5mgMCKOttsVGAHAi7TgKDnZBb
         Pf65ux+BDlVh23efupi349wP4fuETQp6Up1W4v8KJ5FWQAe2g4JQPycm4FhjQsTJ878u
         ERGg==
X-Gm-Message-State: APjAAAV8tMiKKXMsUdxtmN+BHECUGjNXn/P81dPNpC7hiVqzMXRab8mU
        9y239CDjjNCjky9dWRwtT5XtAzDP
X-Google-Smtp-Source: APXvYqzgm92rrOa/rdALRqTkfAROG3L16dy5u3U9CEdkxMXxmYzcCHldLYkeD+shIGk/KLbqwa3ciQ==
X-Received: by 2002:a17:902:d917:: with SMTP id c23mr92113694plz.248.1564076791641;
        Thu, 25 Jul 2019 10:46:31 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v138sm58171800pfc.15.2019.07.25.10.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 10:46:31 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 16/19] merge-recursive: alphabetize include list
Date:   Thu, 25 Jul 2019 10:46:08 -0700
Message-Id: <20190725174611.14802-17-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.559.g28a8880890.dirty
In-Reply-To: <20190725174611.14802-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Other than cache.h which needs to appear first, and merge-recursive.h
which I want to be second so that we are more likely to notice if
merge-recursive.h has any missing includes, the rest of the list is
long and easier to look through if it's alphabetical.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c572d37b21..32889a2f0d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -4,30 +4,31 @@
  * The thieves were Alex Riesen and Johannes Schindelin, in June/July 2006
  */
 #include "cache.h"
-#include "config.h"
+#include "merge-recursive.h"
+
 #include "advice.h"
-#include "lockfile.h"
-#include "cache-tree.h"
-#include "object-store.h"
-#include "repository.h"
-#include "commit.h"
+#include "alloc.h"
+#include "attr.h"
 #include "blob.h"
 #include "builtin.h"
-#include "tree-walk.h"
+#include "cache-tree.h"
+#include "commit.h"
+#include "commit-reach.h"
+#include "config.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "dir.h"
+#include "ll-merge.h"
+#include "lockfile.h"
+#include "object-store.h"
+#include "repository.h"
+#include "revision.h"
+#include "string-list.h"
+#include "submodule.h"
 #include "tag.h"
-#include "alloc.h"
+#include "tree-walk.h"
 #include "unpack-trees.h"
-#include "string-list.h"
 #include "xdiff-interface.h"
-#include "ll-merge.h"
-#include "attr.h"
-#include "merge-recursive.h"
-#include "dir.h"
-#include "submodule.h"
-#include "revision.h"
-#include "commit-reach.h"
 
 struct merge_options_internal {
 	int call_depth;
-- 
2.22.0.559.g28a8880890.dirty

