From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: always initialize state in argsplit()
Date: Sun, 17 Jun 2007 10:31:02 +0200
Message-ID: <11820690621003-git-send-email-frank@lichtenheld.de>
References: <11820198064114-git-send-email-djk@tobit.co.uk>
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Dirk Koopman <djk@tobit.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 17 13:18:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzslc-0006b5-Da
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 13:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758802AbXFQLR7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 07:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758419AbXFQLR7
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 07:17:59 -0400
Received: from cmburns.debconf.org ([80.68.86.241]:42341 "EHLO
	cmburns.debconf.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758769AbXFQLR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 07:17:58 -0400
X-Greylist: delayed 1575 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jun 2007 07:17:58 EDT
Received: from homer.dc7.debconf.org (unknown [129.215.255.137])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client CN "homer.dc7.debconf.org", Issuer "Certificate Authority - Email" (verified OK))
	by cmburns.debconf.org (Postfix) with ESMTP id A048145C002;
	Sun, 17 Jun 2007 10:51:41 +0000 (UTC)
Received: from [10.8.243.250] (helo=goedel.djpig.de ident=Debian-exim)
	by homer.dc7.debconf.org with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HzsM9-0000zl-5y; Sun, 17 Jun 2007 11:51:41 +0100
Received: from djpig by goedel.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HzqA2-0007lK-K2; Sun, 17 Jun 2007 10:31:02 +0200
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11820198064114-git-send-email-djk@tobit.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50349>

Other code assumes that this is initialized, so do it
even if there were no arguments given.

Signed-off-by: Dirk Koopman <djk@tobit.co.uk>
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

 Hrm, sorry to Dirk for the double mail. This time actually
 send to the list and not to git@localhost ...

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 5cbf27e..10aba50 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1813,14 +1813,14 @@ sub req_annotate
 # the second is $state->{files} which is everything after it.
 sub argsplit
 {
-    return unless( defined($state->{arguments}) and ref $state->{arguments} eq "ARRAY" );
-
-    my $type = shift;
-
     $state->{args} = [];
     $state->{files} = [];
     $state->{opt} = {};
 
+    return unless( defined($state->{arguments}) and ref $state->{arguments} eq "ARRAY" );
+
+    my $type = shift;
+
     if ( defined($type) )
     {
         my $opt = {};
-- 
1.5.2.1
