Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 258EA20968
	for <e@80x24.org>; Fri, 23 Dec 2016 01:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941394AbcLWBmE (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 20:42:04 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:33616 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759494AbcLWBmD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 20:42:03 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C2BF81FCC7;
        Fri, 23 Dec 2016 01:42:02 +0000 (UTC)
Date:   Fri, 23 Dec 2016 01:42:02 +0000
From:   Eric Wong <e@80x24.org>
To:     Michael Fladischer <michael@fladi.at>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-svn: escape backslashes in refnames
Message-ID: <20161223014202.GA8327@starla>
References: <cb8cd9b1-9882-64d2-435d-40d0b2b82d59@fladi.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb8cd9b1-9882-64d2-435d-40d0b2b82d59@fladi.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael, the patch below should fix things up.

Junio: this should go to 'maint', pull request below.

----------------8<---------------
Subject: [PATCH] git-svn: escape backslashes in refnames

This brings git-svn refname escaping up-to-date with
commit a4c2e69936df8dd0b071b85664c6cc6a4870dd84
("Disallow '\' in ref names") from May 2009.

Reported-by: Michael Fladischer <michael@fladi.at>
Message-ID: <cb8cd9b1-9882-64d2-435d-40d0b2b82d59@fladi.at>
Signed-off-by: Eric Wong <e@80x24.org>
---
  The following changes since commit a274e0a036ea886a31f8b216564ab1b4a3142f6c:

    Sync with maint-2.10 (2016-12-05 11:25:47 -0800)

  are available in the git repository at:

    git://bogomips.org/git-svn.git svn-escape-backslash

  for you to fetch changes up to 22af6fef9b6538c9e87e147a920be9509acf1ddd:

    git-svn: escape backslashes in refnames (2016-12-23 01:37:36 +0000)

  ----------------------------------------------------------------
  Eric Wong (1):
        git-svn: escape backslashes in refnames

   perl/Git/SVN.pm | 2 +-
   1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 711d2687a3..98518f4ddb 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -490,7 +490,7 @@ sub refname {
 	#
 	# Additionally, % must be escaped because it is used for escaping
 	# and we want our escaped refname to be reversible
-	$refname =~ s{([ \%~\^:\?\*\[\t])}{sprintf('%%%02X',ord($1))}eg;
+	$refname =~ s{([ \%~\^:\?\*\[\t\\])}{sprintf('%%%02X',ord($1))}eg;
 
 	# no slash-separated component can begin with a dot .
 	# /.* becomes /%2E*
-- 
EW
