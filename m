From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 01/13] git-instaweb: Simplify build dependency on gitweb
Date: Thu, 28 Apr 2011 21:03:59 +0200
Message-ID: <1304017451-12283-2-git-send-email-jnareb@gmail.com>
References: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:04:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFWW9-00036F-BP
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 21:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933395Ab1D1TEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 15:04:40 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38748 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932917Ab1D1TEj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 15:04:39 -0400
Received: by wya21 with SMTP id 21so2330897wya.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 12:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=VcQpv9TOrY0tbf8zBbXlbpPv2CizOY0y0y93UuraVUE=;
        b=g1t+wUMuDazeKC8gVCFS5NPdcnIRPATJdlplaxTi4kErELhKIMLiMOQFZIAiyD/w4w
         2VIhuA2t2kJzkYX9S3ZC4ByzgKrsJVtrPspj31TAQjO/bNvrgHwkL5bGq4uF4z0bmgvD
         /rq0PzEBmXR7AxSGjK6Icmj/qNTZnz/+BJ4vg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=udES9B3uhQ8/gfLG8pVBGCuweWzUKg+aSqidQSqWIYMz5lv1/IGDk7SVTwXH8Tc9fH
         EN70Intc4Qw3Wljwv0y1rMOX3zttHlZGRTjsPqNw06YVj5BZMBp1lo9el7gdkMq/kN/C
         4XVy4KDJ0FhnPj5+4cF+Cly52R/5vH5bSnmJI=
Received: by 10.227.61.142 with SMTP id t14mr3819565wbh.84.1304017477913;
        Thu, 28 Apr 2011 12:04:37 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl [83.8.119.25])
        by mx.google.com with ESMTPS id w25sm1266549wbd.56.2011.04.28.12.04.36
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 12:04:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172382>

Since c0cb4ed (git-instaweb: Configure it to work with new gitweb
structure, 2010-05-28) git-instaweb does not re-create gitweb.cgi
etc., but makes use of installed gitweb.  Therefore simplify
git-instaweb dependency on gitweb subsystem in main Makefile from
'gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/static/gitweb.js'
to simply 'gitweb'.

This is preparation for splitting gitweb.perl script, and for
splitting gitweb.js (to be reassembled / combined on build).  This way
we don't have to duplicate parts of gitweb/Makefile in main
Makefile... it is also more correct description of git-instaweb
dependency.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is kind of new in this version of series.  The original
patch by J.H. didn't touch either Makefile or gitweb/Makefile at all...

This issue (breakage in git-instaweb generation) was reported in

  Re: [PATCHv2 00/11] gitweb: Change timezone in dates using JavaScript
  http://thread.gmane.org/gmane.comp.version-control.git/171600/focus=171769

This patch was sent to git mailing list as

  [PATCH -01/11] git-instaweb: Simplify build dependency on gitweb
  http://thread.gmane.org/gmane.comp.version-control.git/171600/focus=171792

and included in 'jn/gitweb-js' (a174d61).

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index cbc3fce..8960cee 100644
--- a/Makefile
+++ b/Makefile
@@ -1773,7 +1773,7 @@ gitweb/static/gitweb.min.css: gitweb/static/gitweb.css
 endif # CSSMIN
 
 
-git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/static/gitweb.js
+git-instaweb: git-instaweb.sh gitweb
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-- 
1.7.3
