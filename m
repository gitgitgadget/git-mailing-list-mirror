Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63CD01F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 07:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbeCZH3u (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 03:29:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:42896 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751074AbeCZH3u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 03:29:50 -0400
Received: (qmail 3516 invoked by uid 109); 26 Mar 2018 07:29:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Mar 2018 07:29:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17444 invoked by uid 111); 26 Mar 2018 07:30:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Mar 2018 03:30:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2018 03:29:48 -0400
Date:   Mon, 26 Mar 2018 03:29:48 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: [PATCH 5/5] branch: make "-l" a synonym for "--list"
Message-ID: <20180326072947.GE12530@sigill.intra.peff.net>
References: <20180326072505.GA12436@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180326072505.GA12436@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The other "mode" options of git-branch have short-option
aliases that are easy to type (e.g., "-d" and "-m"). Let's
give "--list" the same treatment.

This also makes it consistent with the similar "git tag -l"
option.

We didn't do this originally because "--create-reflog" was
squatting on the "-l" option. Now that sufficient time has
passed with that alias removed, we can finally repurpose it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index f7cd333587..fd55e9720e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -611,7 +611,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('M', NULL, &rename, N_("move/rename a branch, even if target exists"), 2),
 		OPT_BIT('c', "copy", &copy, N_("copy a branch and its reflog"), 1),
 		OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
-		OPT_BOOL(0, "list", &list, N_("list branch names")),
+		OPT_BOOL('l', "list", &list, N_("list branch names")),
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
-- 
2.17.0.rc1.509.g060626845b
