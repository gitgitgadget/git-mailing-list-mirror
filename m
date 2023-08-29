Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB846C83F18
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 23:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241293AbjH2XqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 19:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241291AbjH2Xpc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 19:45:32 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C36BCC5
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 16:45:26 -0700 (PDT)
Received: (qmail 14878 invoked by uid 109); 29 Aug 2023 23:45:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Aug 2023 23:45:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19880 invoked by uid 111); 29 Aug 2023 23:45:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Aug 2023 19:45:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Aug 2023 19:45:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 11/22] test-trace2: mark unused argv/argc parameters
Message-ID: <20230829234525.GI227214@coredump.intra.peff.net>
References: <20230829234305.GA226944@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829234305.GA226944@coredump.intra.peff.net>
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
2.42.0.528.g7950723a09

