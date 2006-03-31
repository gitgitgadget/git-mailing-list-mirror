From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH] cg-log: Remove unpleasant DEL characters.
Date: Fri, 31 Mar 2006 01:08:13 +0100
Message-ID: <20060331000813.18895.46855.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Fri Mar 31 02:08:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FP7Ba-0003nq-0h
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 02:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWCaAIP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 19:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWCaAIP
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 19:08:15 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:18547 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751037AbWCaAIP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Mar 2006 19:08:15 -0500
Received: (qmail 18910 invoked from network); 31 Mar 2006 00:08:13 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (127.0.0.1)
  by localhost with SMTP; 31 Mar 2006 00:08:13 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18211>

From: Mark Wooding <mdw@distorted.org.uk>

There's a Bash bug (I'm running 3.1.5(1)-release from Debian testing) as
follows:

  $ foo=@; echo "<${foo:1}>" | cat -v
  <^?>

Without this fix, less gives me ugly standout `^?' markers for every
blank line in a commit message.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 cg-log |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-log b/cg-log
index 5d5407b..b3374e4 100755
--- a/cg-log
+++ b/cg-log
@@ -181,7 +181,7 @@ process_commit_line()
 {
 	if [ "$key" = "%" ] || [ "$key" = "%$colsignoff" ]; then
 		# The fast common case
-		[ "$state" = silent ] || msg="$msg    ${rest:1}
+		[ "$state" = silent ] || msg="$msg    ${rest#?}
 "
 		return
 	fi
