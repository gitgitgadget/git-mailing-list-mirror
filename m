Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 12268 invoked by uid 111); 21 Feb 2008 11:21:27 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 21 Feb 2008 06:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757940AbYBULVW (ORCPT <rfc822;peff@peff.net>);
	Thu, 21 Feb 2008 06:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757859AbYBULVW
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 06:21:22 -0500
Received: from zlonk.bruhat.net ([91.121.102.217]:52179 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761AbYBULVV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 06:21:21 -0500
X-Greylist: delayed 1919 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Feb 2008 06:21:21 EST
Received: from localhost ([127.0.0.1] helo=plop.home.bruhat.net)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JS8uQ-0002fP-46; Thu, 21 Feb 2008 11:44:10 +0100
Received: from book by plop.home.bruhat.net with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JS8z7-0006j0-5t; Thu, 21 Feb 2008 11:49:01 +0100
From:	"Philippe Bruhat (BooK)" <book@cpan.org>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: [PATCH] cvsimport: have default merge regex allow for dashes in the branch name
Date:	Thu, 21 Feb 2008 11:48:56 +0100
Message-Id: <1203590936-25827-1-git-send-email-book@cpan.org>
X-Mailer: git-send-email 1.5.4.1
To:	philippe.bruhat@free.fr
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The default value of @mergerx uses \w, which matches word
character; a branch name like policy-20050608-br will not be
matched.

Signed-off-by: Philippe Bruhat (BooK) <book@cpan.org>
---
 git-cvsimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 9516242..3d013a7 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -164,7 +164,7 @@ if ($#ARGV == 0) {
 
 our @mergerx = ();
 if ($opt_m) {
-	@mergerx = ( qr/\b(?:from|of|merge|merging|merged) (\w+)/i );
+	@mergerx = ( qr/\b(?:from|of|merge|merging|merged) ([-\w]+)/i );
 }
 if ($opt_M) {
 	push (@mergerx, qr/$opt_M/);
-- 
1.5.3.8

