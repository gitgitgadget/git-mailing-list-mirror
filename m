From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH 1/1] Fix recipient santitization
Date: Fri, 28 Mar 2008 11:09:04 -0300
Message-ID: <1206713344-11244-1-git-send-email-vonbrand@inf.utfsm.cl>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 16:31:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfGXr-0005EO-U5
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 16:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbYC1PaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 11:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbYC1PaH
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 11:30:07 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45455 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbYC1PaF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 11:30:05 -0400
X-Greylist: delayed 2004 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Mar 2008 11:30:05 EDT
Received: from quelen.inf.utfsm.cl (quelen.inf.utfsm.cl [200.1.19.194])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id m2SEuYRs032700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 28 Mar 2008 11:56:34 -0300
Received: from laptop13.inf.utfsm.cl (wlan.inf.utfsm.cl [200.1.19.90])
	by quelen.inf.utfsm.cl (8.14.2/8.14.2) with ESMTP id m2SEuX0r009375
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 28 Mar 2008 11:56:34 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.14.2/8.14.2) with ESMTP id m2SE979O011277
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 28 Mar 2008 11:09:07 -0300
Received: (from vonbrand@localhost)
	by laptop13.inf.utfsm.cl (8.14.2/8.14.2/Submit) id m2SE94xw011270;
	Fri, 28 Mar 2008 11:09:04 -0300
X-Mailer: git-send-email 1.5.5.rc2
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0rc6 (inti.inf.utfsm.cl [0.0.0.0]); Fri, 28 Mar 2008 11:56:34 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.92.1/6438/Fri Mar 28 08:40:31 2008 on inti.inf.utfsm.cl
X-Virus-Status: Clean
X-Spam-Status: No, score=-102.6 required=5.0 tests=AWL,BAYES_00,
	UNPARSEABLE_RELAY,USER_IN_WHITELIST autolearn=ham version=3.1.9
X-Spam-Checker-Version: SpamAssassin 3.1.9 (2007-02-13) on inti.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78419>

Need to quote all special characters, not just the first one

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f62f119..3bdd225 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -635,7 +635,7 @@ sub sanitize_address
 
 	# double quotes are needed if specials or CTLs are included
 	elsif ($recipient_name =~ /[][()<>@,;:\\".\000-\037\177]/) {
-		$recipient_name =~ s/(["\\\r])/\\$1/;
+		$recipient_name =~ s/(["\\\r])/\\$1/g;
 		$recipient_name = "\"$recipient_name\"";
 	}
 
-- 
1.5.5.rc2
