Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A88201A7
	for <e@80x24.org>; Fri, 12 May 2017 13:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932304AbdELND3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 09:03:29 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:63378 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932207AbdELND0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 09:03:26 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 8E17E2003FA;
        Fri, 12 May 2017 15:03:23 +0200 (CEST)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH v4 3/3] git-filter-branch: be more direct in an error message
Date:   Fri, 12 May 2017 15:03:17 +0200
Message-Id: <20170512130317.25832-3-jn.avila@free.fr>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170512130317.25832-1-jn.avila@free.fr>
References: <20170503162931.30721-1-jn.avila@free.fr>
 <20170512130317.25832-1-jn.avila@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-filter-branch requires the specification of a branch by one way or
another. If no branch appears to have been specified, we know the user
got the usage wrong but we don't know what they were trying to do ---
e.g. maybe they specified the ref to rewrite but in the wrong place.

In this case, just state that the branch specification is missing.

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 git-filter-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 2b8cdba15..aafaf708d 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -239,7 +239,7 @@ git rev-parse --no-flags --revs-only --symbolic-full-name \
 sed -e '/^^/d' "$tempdir"/raw-heads >"$tempdir"/heads
 
 test -s "$tempdir"/heads ||
-	die "Which ref do you want to rewrite?"
+	die "You must specify a ref to rewrite."
 
 GIT_INDEX_FILE="$(pwd)/../index"
 export GIT_INDEX_FILE
-- 
2.13.0

