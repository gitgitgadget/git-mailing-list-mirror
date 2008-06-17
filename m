From: Alejandro Mery <amery@geeks.cl>
Subject: [PATCH] git-am: head -1 is obsolete and doesn't work on some new
 systems
Date: Tue, 17 Jun 2008 13:43:57 +0200
Message-ID: <4857A37D.8040004@geeks.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 13:45:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8ZcV-0003cp-Nt
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 13:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353AbYFQLoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 07:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755348AbYFQLoE
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 07:44:04 -0400
Received: from qb-out-0506.google.com ([72.14.204.231]:57080 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272AbYFQLoC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 07:44:02 -0400
Received: by qb-out-0506.google.com with SMTP id p36so2229623qba.17
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 04:44:01 -0700 (PDT)
Received: by 10.86.99.9 with SMTP id w9mr8966797fgb.70.1213703040371;
        Tue, 17 Jun 2008 04:44:00 -0700 (PDT)
Received: from ?192.168.6.57? ( [85.57.66.0])
        by mx.google.com with ESMTPS id e20sm13311497fga.1.2008.06.17.04.43.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 04:43:59 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85292>

head -<n> was deprecated by POSIX, and as modern versions of coreutils
package don't support it at least one exports _POSIX2_VERSION=199209
it's fails on some systems.

head -n<n> is portable, but sed <n>q is even more.

Signed-off-by: Alejandro Mery <amery@geeks.cl>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index b48096e..2c517ed 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -421,7 +421,7 @@ do
 	else
 	    action=yes
 	fi
-	FIRSTLINE=$(head -1 "$dotest/final-commit")
+	FIRSTLINE=$(sed 1q "$dotest/final-commit")
 
 	if test $action = skip
 	then
--
1.5.4.3 
