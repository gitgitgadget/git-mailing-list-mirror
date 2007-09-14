From: "Bryan Larsen" <bryan@larsen.st>
Subject: [PATCH] Remove non-POSIX 'expr index' from instaweb.
Date: Fri, 14 Sep 2007 18:01:04 -0400
Message-ID: <ef57d1660709141501m332b31a5yc5f3644c1edbdd0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 00:01:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWJDu-0002Yr-Lk
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757429AbXINWBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 18:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757517AbXINWBI
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:01:08 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:31462 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757492AbXINWBH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:01:07 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1543486mue
        for <git@vger.kernel.org>; Fri, 14 Sep 2007 15:01:05 -0700 (PDT)
Received: by 10.82.154.12 with SMTP id b12mr3138773bue.1189807264799;
        Fri, 14 Sep 2007 15:01:04 -0700 (PDT)
Received: by 10.82.122.14 with HTTP; Fri, 14 Sep 2007 15:01:04 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58188>

git-instaweb.sh uses the non-POSIX 'expr index' command, which
is not present on some BSD's.  This patch replaces this usage
with a simple grep expression.

Signed-off-by: Bryan Larsen < bryan@larsen.st>
---
 git-instaweb.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index ce631a0..ef1a4bf 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -30,8 +30,7 @@ test -z "$port" && port=1234

 start_httpd () {
        httpd_only="`echo $httpd | cut -f1 -d' '`"
-       if test "`expr index $httpd_only /`" -eq '1' || \
-                               which $httpd_only >/dev/null
+       if test echo $http_only | grep ^/ || which $httpd_only >/dev/null
        then
                $httpd $fqgitdir/gitweb/httpd.conf
        else
-- 
1.5.3.1
