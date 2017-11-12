Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A941F42B
	for <e@80x24.org>; Sun, 12 Nov 2017 09:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbdKLJbI (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 04:31:08 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:48038 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752082AbdKLJbE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 04:31:04 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:55282 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eDobX-0004m4-Qg
        for git@vger.kernel.org; Sun, 12 Nov 2017 04:31:03 -0500
Date:   Sun, 12 Nov 2017 04:30:38 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH v4] bisect: mention "view" as an alternative to "visualize"
Message-ID: <alpine.LFD.2.21.1711120426540.29973@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tweak a small number of files to mention "view" as an alternative to
"visualize".

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  ok, let's see if this one is getting close ...

 Documentation/git-bisect.txt | 13 ++++++-------
 builtin/bisect--helper.c     |  2 +-
 git-bisect.sh                |  4 ++--
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 6c42abf07..4a1417bdc 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -23,7 +23,7 @@ on the subcommand:
  git bisect terms [--term-good | --term-bad]
  git bisect skip [(<rev>|<range>)...]
  git bisect reset [<commit>]
- git bisect visualize
+ git bisect (visualize|view)
  git bisect replay <logfile>
  git bisect log
  git bisect run <cmd>...
@@ -193,24 +193,23 @@ git bisect start --term-new fixed --term-old broken
 Then, use `git bisect <term-old>` and `git bisect <term-new>` instead
 of `git bisect good` and `git bisect bad` to mark commits.

-Bisect visualize
-~~~~~~~~~~~~~~~~
+Bisect visualize/view
+~~~~~~~~~~~~~~~~~~~~~

 To see the currently remaining suspects in 'gitk', issue the following
-command during the bisection process:
+command during the bisection process (the subcommand `view` can be used
+as an alternative to `visualize`):

 ------------
 $ git bisect visualize
 ------------

-`view` may also be used as a synonym for `visualize`.
-
 If the `DISPLAY` environment variable is not set, 'git log' is used
 instead.  You can also give command-line options such as `-p` and
 `--stat`.

 ------------
-$ git bisect view --stat
+$ git bisect visualize --stat
 ------------

 Bisect log and bisect replay
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 35d2105f9..4b5fadcbe 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -46,7 +46,7 @@ static int check_term_format(const char *term, const char *orig_term)
 		return error(_("'%s' is not a valid term"), term);

 	if (one_of(term, "help", "start", "skip", "next", "reset",
-			"visualize", "replay", "log", "run", "terms", NULL))
+			"visualize", "view", "replay", "log", "run", "terms", NULL))
 		return error(_("can't use the builtin command '%s' as a term"), term);

 	/*
diff --git a/git-bisect.sh b/git-bisect.sh
index 0138a8860..a82256e34 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,6 +1,6 @@
 #!/bin/sh

-USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|replay|log|run]'
+USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|view|replay|log|run]'
 LONG_USAGE='git bisect help
 	print this long help message.
 git bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]
@@ -20,7 +20,7 @@ git bisect next
 	find next bisection to test and check it out.
 git bisect reset [<commit>]
 	finish bisection search and go back to commit.
-git bisect visualize
+git bisect (visualize|view)
 	show bisect status in gitk.
 git bisect replay <logfile>
 	replay bisection log.


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
