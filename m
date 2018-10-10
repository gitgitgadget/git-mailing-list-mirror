Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20A8F1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 15:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJJWnG (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 18:43:06 -0400
Received: from newman.cs.utexas.edu ([128.83.139.110]:43428 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeJJWnG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 18:43:06 -0400
Received: from vyasa.cs.utexas.edu (vyasa.cs.utexas.edu [128.83.130.99])
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id w9AFKNDv032990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Oct 2018 10:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.utexas.edu;
        s=default; t=1539184823;
        bh=jZ/N8qshNh/wG7uvt5qVvQPYst4K1ut5VZrheFFKVlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7lvQaae5k+MY7GIdpoHtwdGBZPpwDNVIYRh0NekJBssl1c8jZpnS3X3Dt37eSMl/
         PLTcoJw2wuJ/BOQOvcmhlrbYsmEVlCGJntLRRycfafsSHjNfQv13J+C8UHB3E7Nvft
         86T77MMefJq1ej5io1l3V8cdvbfFNe2nLjDgOqsY=
Received: (from mihir@localhost)
        by vyasa.cs.utexas.edu (8.15.2/8.15.2/Submit) id w9AFKN1v014677;
        Wed, 10 Oct 2018 10:20:23 -0500
From:   Mihir Mehta <mihir@cs.utexas.edu>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Mihir Mehta <mihir@cs.utexas.edu>
Subject: [PATCH] doc: fix a typo and clarify a sentence
Date:   Wed, 10 Oct 2018 10:20:07 -0500
Message-Id: <20181010152007.14441-2-mihir@cs.utexas.edu>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181010152007.14441-1-mihir@cs.utexas.edu>
References: <xmqqwoqw29uw.fsf@gitster-ct.c.googlers.com>
 <20181010152007.14441-1-mihir@cs.utexas.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.9 (newman.cs.utexas.edu [128.83.139.110]); Wed, 10 Oct 2018 10:20:23 -0500 (CDT)
X-Virus-Scanned: clamav-milter 0.98.7 at newman
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed that git-merge-base was unlikely to actually be a git command,
and tried it in my shell. Seeing that it doesn't work, I cleaned up two
places in the docs where it appears.

Signed-off-by: Mihir Mehta <mihir@cs.utexas.edu>
---
 Documentation/git-diff.txt                  | 7 ++++---
 Documentation/howto/update-hook-example.txt | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index b180f1fa5..a122f9ded 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -72,10 +72,11 @@ two blob objects, or changes between two files on disk.
 	This form is to view the changes on the branch containing
 	and up to the second <commit>, starting at a common ancestor
 	of both <commit>.  "git diff A\...B" is equivalent to
-	"git diff $(git-merge-base A B) B".  You can omit any one
-	of <commit>, which has the same effect as using HEAD instead.
+	"git diff $(git merge-base A B) B".  You can omit any one
+	of the two instances of <commit>, which has the same effect as
+	using HEAD in its place; omitting both results in an empty diff.
 
-Just in case if you are doing something exotic, it should be
+Just in case you are doing something exotic, it should be
 noted that all of the <commit> in the above description, except
 in the last two forms that use ".." notations, can be any
 <tree>.
diff --git a/Documentation/howto/update-hook-example.txt b/Documentation/howto/update-hook-example.txt
index a5193b1e5..89821ec74 100644
--- a/Documentation/howto/update-hook-example.txt
+++ b/Documentation/howto/update-hook-example.txt
@@ -80,7 +80,7 @@ case "$1" in
       info "The branch '$1' is new..."
     else
       # updating -- make sure it is a fast-forward
-      mb=$(git-merge-base "$2" "$3")
+      mb=$(git merge-base "$2" "$3")
       case "$mb,$2" in
         "$2,$mb") info "Update is fast-forward" ;;
 	*)	  noff=y; info "This is not a fast-forward update.";;
-- 
2.19.0

