Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CED3D20D0A
	for <e@80x24.org>; Tue, 30 May 2017 05:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbdE3FQx (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 01:16:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:59622 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750988AbdE3FQw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 01:16:52 -0400
Received: (qmail 12936 invoked by uid 109); 30 May 2017 05:16:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 05:16:53 +0000
Received: (qmail 20867 invoked by uid 111); 30 May 2017 05:17:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 01:17:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 May 2017 01:16:50 -0400
Date:   Tue, 30 May 2017 01:16:50 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 5/8] submodule--helper: show usage for "-h"
Message-ID: <20170530051650.t2pa2fsvbb6qdut4@sigill.intra.peff.net>
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normal users shouldn't ever call submodule--helper, but it
doesn't hurt to give them a normal usage message if they try
"-h".

Signed-off-by: Jeff King <peff@peff.net>
---
The usage message isn't that helpful _either_, and I admit
my ulterior motive is just to make the test at the end of
this series pass. :)

I was tempted to actually dump the names from the commands
array to stdout, but this command really is an internal
helper. It's probably not worth spending time on such
niceties.

 builtin/submodule--helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 566a5b6a6..a78b003c2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1222,9 +1222,8 @@ static struct cmd_struct commands[] = {
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	if (argc < 2)
-		die(_("submodule--helper subcommand must be "
-		      "called with a subcommand"));
+	if (argc < 2 || !strcmp(argv[1], "-h"))
+		usage("git submodule--helper <command>");
 
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		if (!strcmp(argv[1], commands[i].cmd)) {
-- 
2.13.0.613.g11c956365

