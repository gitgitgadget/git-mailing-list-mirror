X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 5/5] rerere: add the diff command
Date: Fri,  8 Dec 2006 02:49:30 -0800
Message-ID: <1165574977365-git-send-email-normalperson@yhbt.net>
References: <20061205092126.GE27236@soma>
NNTP-Posting-Date: Fri, 8 Dec 2006 10:49:57 +0000 (UTC)
Cc: Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.2.g860f4
In-Reply-To: <20061205092126.GE27236@soma>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33684>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsdIf-0003Cg-4S for gcvg-git@gmane.org; Fri, 08 Dec
 2006 11:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425354AbWLHKtm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 05:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425350AbWLHKtm
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 05:49:42 -0500
Received: from hand.yhbt.net ([66.150.188.102]:47170 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1425355AbWLHKtj
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 05:49:39 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 8147D2DC08B; Fri,  8 Dec 2006 02:49:37 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri,  8 Dec 2006
 02:49:37 -0800
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Sometimes I like to see what I'm recording resolutions for and
what's changed during a resolution.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-rerere.perl |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git-rerere.perl b/git-rerere.perl
index b78194a..7a3ae84 100755
--- a/git-rerere.perl
+++ b/git-rerere.perl
@@ -186,6 +186,13 @@ if (my $arg = shift @ARGV) {
 		for my $path (keys %merge_rr) {
 			print $path, "\n";
 		}
+	} elsif ($arg eq 'diff') {
+		for my $path (keys %merge_rr) {
+			my $name = $merge_rr{$path};
+			system(qw/diff/, @ARGV,
+				'-L', "a/$path", '-L', "b/$path",
+				"$rr_dir/$name/preimage", $path);
+		}
 	}
 	exit 0;
 }
-- 
1.4.4.2.g860f4
