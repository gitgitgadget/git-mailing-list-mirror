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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E8F91F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387883AbfGZPx2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38178 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387864AbfGZPxY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id f5so16156397pgu.5
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LaUZndmPjTAJX+NfTNj1j3eHLbwDbmNx6hO86Wr0Cag=;
        b=UYV6RzeBAL9xoQjvm3VrR51fcmdshOCLaay3gFNLYlEgbiI/xgkALiw/l6o9BWVlA0
         SXIZaiWgzrYAIjUV8bR5BN6Dt9BK+MP3AcN8lSbqCr66jOWHzO88x8RWHplL1HX3NbIu
         5jjDW5I8IvbGWGd9NRSERWKGgsTQZO4OKMp2yaq+VTA953Antp9Ae0EG2tc6QPOh+Bfe
         fmxhubf7Wfu5sM0vLWIHOliH5trX6K68vg58I05tPDuLmalVhuhcIDw+AjVfYiB8A83V
         PJnIvSs9vgB+lqvs1PB95jdIuvxoypQ9siVCjwSp489LrEVG44Y7KmP1iwFCCjL3ZY7d
         wxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LaUZndmPjTAJX+NfTNj1j3eHLbwDbmNx6hO86Wr0Cag=;
        b=b6ct0pjqT/Y0/8ZUUDAzSCRhR62Io7dbdQlHdzltf/UzaZV1NT8IcgY/+/xjMVetaB
         Lsp8roNHFwCQR77c7bt5mKJRjfqn7L45HNuZ1oEIkfQaHTwnfLlA7IOfqD/rPQlE2dMx
         bsh087cSSOel78TX6H2gPKaSh/nc7uU+/acQPNtYeyz0B4HHT5YUzk76TIh8NBnaa9kr
         OpeHAqT3UV2vv5XA4fGN+Sut46kyHH9urOHIlySiKRCatILv7f4+UYCFg7tk4KU7Ni0N
         yECXvGBr0dbeCD5B6eCxgQ3Zb462s71o6E2dtvIe1Iz/Wnf8RqDieZ8O8h5ooOgtgqOM
         hljQ==
X-Gm-Message-State: APjAAAXZOfD0hcwrYM3G+QPmH3WFqwBuhSSyasCjXYR/00JZoVfkQDbR
        qBeUFFpHgHLGQi0oD/g2c+IuJ6my
X-Google-Smtp-Source: APXvYqwC2/FVVBU3DBtjM/v1ZCTPNsNPjPON1itg8LiNtfYEaDHInwR/eUkhbXDMw2ECi6oheKwhbg==
X-Received: by 2002:aa7:8102:: with SMTP id b2mr23185220pfi.105.1564156403645;
        Fri, 26 Jul 2019 08:53:23 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:23 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 17/20] merge-recursive: alphabetize include list
Date:   Fri, 26 Jul 2019 08:52:55 -0700
Message-Id: <20190726155258.28561-18-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.550.g71c37a0928.dirty
In-Reply-To: <20190726155258.28561-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
 <20190726155258.28561-1-newren@gmail.com>
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
index ba635ed753..27e0bdf48c 100644
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
2.22.0.550.g71c37a0928.dirty

