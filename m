Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4516220954
	for <e@80x24.org>; Wed, 22 Nov 2017 12:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbdKVMEg (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 07:04:36 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:44021 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbdKVMEf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 07:04:35 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:36434 helo=DESKTOP-1GPMCEJ)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eHTla-0008Il-Ni
        for git@vger.kernel.org; Wed, 22 Nov 2017 07:04:34 -0500
Date:   Wed, 22 Nov 2017 07:03:09 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@DESKTOP-1GPMCEJ
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH v3] doc: tweak "man gitcli" for clarity
Message-ID: <alpine.LFD.2.21.1711220701070.12544@DESKTOP-1GPMCEJ>
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

No major changes, just some rewording and showing some variations of
general Git commands.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 9f13266a6..b7f40bf78 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -13,7 +13,7 @@ gitcli
 DESCRIPTION
 -----------

-This manual describes the convention used throughout Git CLI.
+This manual describes the conventions used throughout Git CLI.

 Many commands take revisions (most often "commits", but sometimes
 "tree-ish", depending on the context and command) and paths as their
@@ -32,32 +32,35 @@ arguments.  Here are the rules:
    between the HEAD commit and the work tree as a whole".  You can say
    `git diff HEAD --` to ask for the latter.

- * Without disambiguating `--`, Git makes a reasonable guess, but errors
-   out and asking you to disambiguate when ambiguous.  E.g. if you have a
-   file called HEAD in your work tree, `git diff HEAD` is ambiguous, and
+ * In cases where a Git command is truly ambiguous, Git will error out
+   and ask you to disambiguate the command.  E.g. if you have a file
+   called HEAD in your work tree, `git diff HEAD` is ambiguous, and
    you have to say either `git diff HEAD --` or `git diff -- HEAD` to
    disambiguate.
 +
 When writing a script that is expected to handle random user-input, it is
 a good practice to make it explicit which arguments are which by placing
-disambiguating `--` at appropriate places.
+a disambiguating `--` at appropriate places.

  * Many commands allow wildcards in paths, but you need to protect
-   them from getting globbed by the shell.  These two mean different
-   things:
+   them from getting globbed by the shell.  The following commands have
+   two different meanings:
 +
 --------------------------------
 $ git checkout -- *.c
+
 $ git checkout -- \*.c
+$ git checkout -- "*.c"
+$ git checkout -- '*.c'
 --------------------------------
 +
-The former lets your shell expand the fileglob, and you are asking
-the dot-C files in your working tree to be overwritten with the version
-in the index.  The latter passes the `*.c` to Git, and you are asking
-the paths in the index that match the pattern to be checked out to your
-working tree.  After running `git add hello.c; rm hello.c`, you will _not_
-see `hello.c` in your working tree with the former, but with the latter
-you will.
+The first command lets your shell expand the fileglob, and you are asking
+the dot-C files in your working tree to be overwritten with the version in
+the index.  The latter three variations pass the `*.c` to Git, and you are
+asking the paths in the index that match the pattern to be checked out to
+your working tree.  After running `git add hello.c; rm hello.c`, you will
+_not_ see `hello.c` in your working tree with the first command, but with
+the latter three variations, you will.

  * Just as the filesystem '.' (period) refers to the current directory,
    using a '.' as a repository name in Git (a dot-repository) is a relative

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
