Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34942036D
	for <e@80x24.org>; Tue, 21 Nov 2017 21:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbdKUV3X (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 16:29:23 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:40659 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdKUV3W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 16:29:22 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:38436 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eHG6b-00089Y-DJ
        for git@vger.kernel.org; Tue, 21 Nov 2017 16:29:21 -0500
Date:   Tue, 21 Nov 2017 16:27:59 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH v2] gitcli: tweak "man gitcli" for clarity
Message-ID: <alpine.LFD.2.21.1711211626460.26166@localhost.localdomain>
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
index 9f13266a6..d690d1ff0 100644
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
+ * Without a disambiguating `--`, Git makes a reasonable guess, but can
+   error out, asking you to disambiguate when ambiguous.  E.g. if you have a
    file called HEAD in your work tree, `git diff HEAD` is ambiguous, and
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
