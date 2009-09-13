From: Nelson Elhage <nelhage@MIT.EDU>
Subject: [PATCH] reflog: Usage documentation cleanup
Date: Sun, 13 Sep 2009 13:23:52 -0400
Message-ID: <1252862632-17581-1-git-send-email-nelhage@mit.edu>
Cc: Nelson Elhage <nelhage@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 19:28:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmssP-0001Ns-6B
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 19:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560AbZIMRZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 13:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754441AbZIMRZU
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 13:25:20 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:32865 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751050AbZIMRZU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2009 13:25:20 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n8DHPKu5019977;
	Sun, 13 Sep 2009 13:25:21 -0400 (EDT)
Received: from PHANATIQUE.MIT.EDU (c-71-192-160-118.hsd1.nh.comcast.net [71.192.160.118])
	(authenticated bits=0)
        (User authenticated as nelhage@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n8DHPJhE018838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 13 Sep 2009 13:25:20 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.1.499.ge7b8da
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128375>

* Make git-reflog.txt and the builtin usage text consistent.
* Make 'git reflog expire' not claim that 'show' takes the same
  arguments as 'expire'.
* Document -n as an alias for --dry-run for the expire and delete
  subcommands.
---

 Documentation/git-reflog.txt |    5 +++--
 builtin-reflog.c             |    4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

Thanks to Jeff King and Erik Faye-Lund for both pointing out that 'git
reflog expire' is probably wrong to be documenting the 'show' command
in the first place, which makes this cleanup much saner.

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 7f7a544..2c90c2c 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -16,10 +16,11 @@ The command takes various subcommands, and different options
 depending on the subcommand:
 
 [verse]
-'git reflog expire' [--dry-run] [--stale-fix] [--verbose]
+'git reflog expire' [-n | --dry-run] [--stale-fix] [--verbose]
 	[--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...
 +
-'git reflog delete' ref@\{specifier\}...
+'git reflog delete [--verbose] [-n | --dry-run] [--rewrite]
+	[--updateref] ref@\{specifier}\...'
 +
 'git reflog' ['show'] [log-options] [<ref>]
 
diff --git a/builtin-reflog.c b/builtin-reflog.c
index 95198c5..4da5c6b 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -13,9 +13,9 @@
  */
 
 static const char reflog_expire_usage[] =
-"git reflog (show|expire) [--verbose] [--dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
+"git reflog expire [--verbose] [-n | --dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
 static const char reflog_delete_usage[] =
-"git reflog delete [--verbose] [--dry-run] [--rewrite] [--updateref] <refs>...";
+"git reflog delete [--verbose] [-n | --dry-run] [--rewrite] [--updateref] ref@{specifier}...";
 
 static unsigned long default_reflog_expire;
 static unsigned long default_reflog_expire_unreachable;
-- 
1.6.3.1.499.ge7b8da
