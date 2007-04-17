From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] send-email: do not leave an empty CC: line if no cc is present.
Date: Mon, 16 Apr 2007 21:43:21 -0700
Message-ID: <11767850012084-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 06:43:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdfXJ-0006I5-Au
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 06:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031069AbXDQEnW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 00:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031070AbXDQEnW
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 00:43:22 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59930 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031069AbXDQEnV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 00:43:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070417044322.QUOA1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Tue, 17 Apr 2007 00:43:22 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id o4jM1W0091kojtg0000000; Tue, 17 Apr 2007 00:43:21 -0400
X-Mailer: git-send-email 1.5.1.1.125.g402f-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44722>

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I've almost never used send-email myself, but I decided that
   I should eat somebody's dog food I inherited.  Once I got
   annoyed enough, I may end up rewriting large portions of it,
   perhaps.

 git-send-email.perl |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 1278fcb..d6b1548 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -446,9 +446,12 @@ sub send_message
 		my ($name, $addr) = ($from =~ /^(.*?)(\s+<.*)/);
 		$from = "\"$name\"$addr";
 	}
+	my $ccline = "";
+	if ($cc ne '') {
+		$ccline = "\nCc: $cc";
+	}
 	my $header = "From: $from
-To: $to
-Cc: $cc
+To: $to${ccline}
 Subject: $subject
 Date: $date
 Message-Id: $message_id
-- 
1.5.1.1.821.g88bdb
