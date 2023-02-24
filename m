Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A897AC678D5
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjBXGk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBXGkB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:40:01 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D0460D7E
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:39:49 -0800 (PST)
Received: (qmail 3716 invoked by uid 109); 24 Feb 2023 06:39:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:39:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31140 invoked by uid 111); 24 Feb 2023 06:39:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:39:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:39:48 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 21/21] help: mark unused parameter in git_unknown_cmd_config()
Message-ID: <Y/hbtJOLWjgMnGD7@coredump.intra.peff.net>
References: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The extra callback parameter became unused in 0918d08887 (help.c: fix
autocorrect in work tree for bare repository, 2022-10-29), but we can't
get rid of it because we must conform to the config callback interface.

Signed-off-by: Jeff King <peff@peff.net>
---
 help.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/help.c b/help.c
index 812af4cdea..8393c25586 100644
--- a/help.c
+++ b/help.c
@@ -540,7 +540,8 @@ static struct cmdnames aliases;
 #define AUTOCORRECT_NEVER (-2)
 #define AUTOCORRECT_IMMEDIATELY (-1)
 
-static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
+static int git_unknown_cmd_config(const char *var, const char *value,
+				  void *cb UNUSED)
 {
 	const char *p;
 
-- 
2.39.2.981.g6157336f25
