From: Bryan Larsen <bryan@larsen.st>
Subject: [PATCH] Allow PERL_PATH="/usr/bin/env perl"
Date: Thu, 03 May 2007 16:33:49 -0400
Message-ID: <463A472D.5000007@larsen.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 03 22:32:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjhyh-0003Zk-PT
	for gcvg-git@gmane.org; Thu, 03 May 2007 22:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945996AbXECUcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 16:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946111AbXECUcI
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 16:32:08 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:62999 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945996AbXECUcG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 16:32:06 -0400
Received: by nz-out-0506.google.com with SMTP id o1so650479nzf
        for <git@vger.kernel.org>; Thu, 03 May 2007 13:32:05 -0700 (PDT)
Received: by 10.65.235.7 with SMTP id m7mr4219960qbr.1178224325246;
        Thu, 03 May 2007 13:32:05 -0700 (PDT)
Received: from ?192.168.1.91? ( [206.248.190.98])
        by mx.google.com with ESMTP id f14sm1851976qba.2007.05.03.13.32.02;
        Thu, 03 May 2007 13:32:04 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46104>

The perl scripts start with "#!/usr/bin/perl".  There is a mechanism 
PERL_PATH in the Makefile to change this, but it currently doesn't work 
with PERL_PATH="/usr/bin/env perl".  This is causing problems in 
MacPorts, where we wish to work with the MacPorts perl if it is 
installed, but fall back to the system perl if it isn't.

Signed-off-by: Bryan Larsen <bryan@larsen.st>
---
  perl/Makefile |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/perl/Makefile b/perl/Makefile
index 17d004e..2832cb4 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -33,7 +33,7 @@ $(makfile): ../GIT-CFLAGS Makefile
         echo '  echo $(instdir_SQ)' >> $@
  else
  $(makfile): Makefile.PL ../GIT-CFLAGS
-       '$(PERL_PATH_SQ)' $< PREFIX='$(prefix_SQ)'
+       $(PERL_PATH_SQ) $< PREFIX='$(prefix_SQ)'
  endif

  # this is just added comfort for calling make directly in perl dir
-- 
1.5.1.3
