Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 442 invoked by uid 111); 25 Sep 2008 16:56:02 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 25 Sep 2008 12:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383AbYIYQzz (ORCPT <rfc822;peff@peff.net>);
	Thu, 25 Sep 2008 12:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753848AbYIYQzz
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 12:55:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58688 "EHLO pixie.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753104AbYIYQzy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 12:55:54 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Sep 2008 12:55:54 EDT
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 3B2C72AC8A6; Thu, 25 Sep 2008 18:48:48 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Cc:	Petr Baudis <pasky@suse.cz>, Mike Ralphson <mike@abacus.co.uk>
Subject: [PATCH] gitweb: Sort the list of forks on the summary page by age
Date:	Thu, 25 Sep 2008 18:48:48 +0200
Message-Id: <1222361328-17368-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
In-Reply-To: <1222361317-17275-1-git-send-email-pasky@suse.cz>
References: <1222361317-17275-1-git-send-email-pasky@suse.cz>
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Petr Baudis <pasky@suse.cz>

From: Mike Ralphson <mike@abacus.co.uk>

The list of forks on the summary page was unsorted, this just makes
them sorted by age, which seems a fair way to decide which forks are
shown before the list size cut-off (15) kicks in.

s/noheader/no_header was just to make it obvious what the parameter
affects, so all the code can be found with one grep.

pb: As suggested by Mike, I have augmented this by an additional patch
that refactors the sorting logic so that it is not tied to printing
the headers.

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bd81e14..0f8a564 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4119,10 +4119,10 @@ sub git_summary {
 
 	if (@forklist) {
 		git_print_header_div('forks');
-		git_project_list_body(\@forklist, undef, 0, 15,
+		git_project_list_body(\@forklist, 'age', 0, 15,
 		                      $#forklist <= 15 ? undef :
 		                      $cgi->a({-href => href(action=>"forks")}, "..."),
-		                      'noheader');
+		                      'no_header');
 	}
 
 	git_footer_html();
-- 
tg: (513dad1..) t/forks/sort-by-age (depends on: t/forks/sort-refactor)
