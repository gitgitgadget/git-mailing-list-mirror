From: Bryan Larsen <bryan@larsen.st>
Subject: [PATCH] Try 2: Allow PERL_PATH="/usr/bin/env perl"
Date: Thu, 03 May 2007 19:00:01 -0400
Message-ID: <463A6971.6010307@larsen.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 04 00:58:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjkFU-0000EN-5W
	for gcvg-git@gmane.org; Fri, 04 May 2007 00:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbXECW6F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 18:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754448AbXECW6F
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 18:58:05 -0400
Received: from nz-out-0506.google.com ([64.233.162.239]:33849 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345AbXECW6D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 18:58:03 -0400
Received: by nz-out-0506.google.com with SMTP id o1so689905nzf
        for <git@vger.kernel.org>; Thu, 03 May 2007 15:58:03 -0700 (PDT)
Received: by 10.64.199.8 with SMTP id w8mr4560055qbf.1178233082895;
        Thu, 03 May 2007 15:58:02 -0700 (PDT)
Received: from ?192.168.1.91? ( [206.248.190.98])
        by mx.google.com with ESMTP id e11sm1964419qbc.2007.05.03.15.57.59;
        Thu, 03 May 2007 15:58:00 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46115>

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
+       $(PERL_PATH) $< PREFIX='$(prefix_SQ)'
  endif

  # this is just added comfort for calling make directly in perl dir
