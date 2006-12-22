From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 2/4] gitweb: optimize git_get_last_activity.
Date: Fri, 22 Dec 2006 19:38:13 +0000
Message-ID: <11668162963671-git-send-email-robfitz@273k.net>
References: 200612191214.58474.jnareb@gmail.com <11668162952375-git-send-email-robfitz@273k.net> <11668162961084-git-send-email-robfitz@273k.net>
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Fri Dec 22 20:39:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxqEX-0003L4-5E
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 20:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbWLVTi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 14:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752405AbWLVTi6
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 14:38:58 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:35571 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbWLVTi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 14:38:57 -0500
Received: from [194.125.117.173] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GxqDH-0005n0-5K; Fri, 22 Dec 2006 19:37:51 +0000
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3.g8aca-dirty
In-Reply-To: <11668162961084-git-send-email-robfitz@273k.net>
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-2, required 7, autolearn=disabled,
	RCVD_IN_NERDS_IE -2.00)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35201>

Only return one line of output and we don't need the refname value.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---
 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 80c04b8..01e3a8a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1139,8 +1139,9 @@ sub git_get_last_activity {
 
 	$git_dir = "$projectroot/$path";
 	open($fd, "-|", git_cmd(), 'for-each-ref',
-	     '--format=%(refname) %(committer)',
+	     '--format=%(committer)',
 	     '--sort=-committerdate',
+	     '--count=1',
 	     'refs/heads') or return;
 	my $most_recent = <$fd>;
 	close $fd or return;
-- 
1.4.4.3.gc902c
