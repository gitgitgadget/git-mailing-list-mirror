From: "Fernando J. Pereda" <ferdy@gentoo.org>
Subject: [PATCH] Makefile: Add '+' to QUIET_SUBDIR0 to fix parallel make.
Date: Wed, 4 Apr 2007 22:42:33 +0200
Message-ID: <20070404204233.GA14252@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 23:15:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZCpP-000672-Dv
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 23:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbXDDVPg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 17:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbXDDVPg
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 17:15:36 -0400
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:56168
	"EHLO smtp.ferdyx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbXDDVPf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 17:15:35 -0400
X-Greylist: delayed 1974 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Apr 2007 17:15:34 EDT
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id A7AD68D316
	for <git@vger.kernel.org>; Wed,  4 Apr 2007 13:29:46 +0200 (CEST)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 26934-09 for <git@vger.kernel.org>;
	Wed, 4 Apr 2007 13:29:42 +0200 (CEST)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id 80E9F8D304
	for <git@vger.kernel.org>; Wed,  4 Apr 2007 13:29:41 +0200 (CEST)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Wed,  4 Apr 2007 22:42:34 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@gentoo.org>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43779>

Signed-off-by: Fernando J. Pereda <ferdy@gentoo.org>
---

  I don't know if this breaks non-gnu make, and don't have an easy way
  to test it right now. So someone should do that before it is applied.

  This is needed for GNU make to let sub-makes connect to the jobserver
  when multiple jobs are specified (-j option to make). It was not
  needed before 74f2b2a8d006a49e1be7e30731c2f7365d2741d1 because of how
  GNU make works.

  - ferdy

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index ad321b3..090ea98 100644
--- a/Makefile
+++ b/Makefile
@@ -657,7 +657,7 @@ ifndef V
 	QUIET_LINK     = @echo '   ' LINK $@;
 	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
 	QUIET_GEN      = @echo '   ' GEN $@;
-	QUIET_SUBDIR0  = @subdir=
+	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
 	export V
-- 
1.5.1
