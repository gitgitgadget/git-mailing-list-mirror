Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F64D201C8
	for <e@80x24.org>; Sat, 11 Nov 2017 10:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbdKKKbh (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 05:31:37 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:59194 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbdKKKbg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 05:31:36 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:47462 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eDT4Z-0007A4-8u
        for git@vger.kernel.org; Sat, 11 Nov 2017 05:31:35 -0500
Date:   Sat, 11 Nov 2017 05:31:10 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH v2] bisect: mention "view" as an alternative to "visualize"
Message-ID: <alpine.LFD.2.21.1711110528410.4314@localhost.localdomain>
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

Tweak a number of files to mention "view" as an alternative to
"visualize".

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

 Documentation/git-bisect.txt           | 9 ++++-----
 Documentation/user-manual.txt          | 3 ++-
 builtin/bisect--helper.c               | 2 +-
 contrib/completion/git-completion.bash | 2 +-
 git-bisect.sh                          | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 6c42abf07..3d333b9a7 100644
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
@@ -196,15 +196,14 @@ of `git bisect good` and `git bisect bad` to mark commits.
 Bisect visualize
 ~~~~~~~~~~~~~~~~

-To see the currently remaining suspects in 'gitk', issue the following
-command during the bisection process:
+To see the currently remaining suspects in 'gitk', issue either of the
+following equivalent commands during the bisection process:

 ------------
 $ git bisect visualize
+$ git bisect view
 ------------

-`view` may also be used as a synonym for `visualize`.
-
 If the `DISPLAY` environment variable is not set, 'git log' is used
 instead.  You can also give command-line options such as `-p` and
 `--stat`.
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 3a03e63eb..55ec58986 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -538,10 +538,11 @@ Note that the version which `git bisect` checks out for you at each
 point is just a suggestion, and you're free to try a different
 version if you think it would be a good idea.  For example,
 occasionally you may land on a commit that broke something unrelated;
-run
+run either of the equivalent commands

 -------------------------------------------------
 $ git bisect visualize
+$ git bisect view
 -------------------------------------------------

 which will run gitk and label the commit it chose with a marker that
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
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fdd984d34..52f68c922 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1162,7 +1162,7 @@ _git_bisect ()
 {
 	__git_has_doubledash && return

-	local subcommands="start bad good skip reset visualize replay log run"
+	local subcommands="start bad good skip reset visualize view replay log run"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		__git_find_repo_path
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
