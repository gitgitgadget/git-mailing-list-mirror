Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF631C83F14
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 21:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjH1Vs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjH1VsB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 17:48:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F680102
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 14:47:58 -0700 (PDT)
Received: (qmail 566 invoked by uid 109); 28 Aug 2023 21:47:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 21:47:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4547 invoked by uid 111); 28 Aug 2023 21:47:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 17:47:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 17:47:57 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 11/22] test-trace2: mark unused argv/argc parameters
Message-ID: <20230828214757.GK3831137@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The trace2 test helper uses function pointers to dispatch to individual
tests. Not all tests bother looking at their argv/argc parameters. We
could tighten this up (e.g., complaining when seeing unexpected
parameters), but for internal test code it's not worth worrying about.

This is similar in spirit to 126e3b3d2a (t/helper: mark unused argv/argc
arguments, 2023-03-28).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-trace2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index 20c7495f38..d5ca0046c8 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -45,7 +45,7 @@ static int get_i(int *p_value, const char *data)
  * [] "def_param" events for all of the "interesting" pre-defined
  * config settings.
  */
-static int ut_001return(int argc, const char **argv)
+static int ut_001return(int argc UNUSED, const char **argv)
 {
 	int rc;
 
@@ -65,7 +65,7 @@ static int ut_001return(int argc, const char **argv)
  * [] "def_param" events for all of the "interesting" pre-defined
  * config settings.
  */
-static int ut_002exit(int argc, const char **argv)
+static int ut_002exit(int argc UNUSED, const char **argv)
 {
 	int rc;
 
@@ -201,7 +201,7 @@ static int ut_006data(int argc, const char **argv)
 	return 0;
 }
 
-static int ut_007BUG(int argc, const char **argv)
+static int ut_007BUG(int argc UNUSED, const char **argv UNUSED)
 {
 	/*
 	 * Exercise BUG() to ensure that the message is printed to trace2.
-- 
2.42.0.505.g4c6fb48dec

