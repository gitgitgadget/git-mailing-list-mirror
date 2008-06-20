From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] t/README: Add 'Skipping Tests' section below 'Running Tests'
Date: Fri, 20 Jun 2008 23:10:50 +0200
Message-ID: <1213996250-10406-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 23:11:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9nth-0000sX-Dc
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 23:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbYFTVK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 17:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754283AbYFTVK4
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 17:10:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:12105 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734AbYFTVKz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 17:10:55 -0400
Received: by ug-out-1314.google.com with SMTP id h2so66848ugf.16
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 14:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer;
        bh=yNLAvzZs+g2WwFZuUeCaCTt0CaHKGtU//6gQfQx1cdA=;
        b=CtE2nO5LF9s59jLkfLRMdcBRwVqTqCuPDHVdah6LU2wrHi7biLDAz/2aC5dMT9Zlff
         oSHdO6ibHcx22gI5J1H8VGUs451VqPBQ1iMVwf8rRTCa0mqFD+t5rgVBSKtgr54mrRPp
         WS6MZn0A2n2nixpkJrfPCqQjM3cR9RC7Am1Jg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Zewmr9E67U/qGdFg/ntQ9fSlNmHr9TbLduQY3Xhhfn2kytl9g2WJ85WZILHqM+eL0i
         o4umvXeWbULuDdtDMjGKgRr1KO3Sw4Tm9aYGzc4T+gKp+JvLV+13v3Q9RY63BCVkjp7K
         0BcvRdlMdaiiEB2zQeXuEHtZ3I9jIDgWNbVnQ=
Received: by 10.210.76.12 with SMTP id y12mr3537996eba.151.1213996254200;
        Fri, 20 Jun 2008 14:10:54 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.208.51])
        by mx.google.com with ESMTPS id z33sm3500219ikz.0.2008.06.20.14.10.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Jun 2008 14:10:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5KLAqeV010430;
	Fri, 20 Jun 2008 23:10:52 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5KLApFN010429;
	Fri, 20 Jun 2008 23:10:51 +0200
X-Mailer: git-send-email 1.5.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85677>

Add description of GIT_SKIP_TESTS variable, taken almost verbatim
(adjusting for conventions in t/README) from the commit message in

   04ece59 (GIT_SKIP_TESTS: allow users to omit tests that are known to break)

Signed-off-by: Junio C Hamano <junkio@cox.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
So I don't have to look it up every time I want to use it...

 t/README |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index dc89263..8f12d48 100644
--- a/t/README
+++ b/t/README
@@ -59,6 +59,34 @@ Running Tests
 	available), for more exhaustive testing.
 
 
+Skipping Tests
+--------------
+
+In some environments, certain tests have no way of succeeding
+due to platform limitation, such as lack of 'unzip' program, or
+filesystem that do not allow arbitrary sequence of non-NUL bytes
+as pathnames.
+
+You should be able to say something like
+
+    $ GIT_SKIP_TESTS=t9200.8 sh ./t9200-git-cvsexport-commit.sh
+
+and even:
+
+    $ GIT_SKIP_TESTS='t[0-4]??? t91?? t9200.8' make
+
+to omit such tests.  The value of the environment variable is a
+SP separated list of patterns that tells which tests to skip,
+and either can match the "t[0-9]{4}" part to skip the whole
+test, or t[0-9]{4} followed by ".$number" to say which
+particular test to skip.
+
+Note that some tests in the existing test suite rely on previous
+test item, so you cannot arbitrarily disable one and expect the
+remainder of test to check what the test originally was intended
+to check.
+
+
 Naming Tests
 ------------
 
-- 
1.5.6
