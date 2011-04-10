From: Fraser Tweedale <frase@frase.id.au>
Subject: [PATCH] supply '-n' to gzip to produce identical tarballs
Date: Sun, 10 Apr 2011 16:12:16 +1000
Message-ID: <1302415936-7362-1-git-send-email-frase@frase.id.au>
Cc: Fraser Tweedale <frase@frase.id.au>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 08:31:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8oBC-0002Xx-Tu
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 08:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab1DJGbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 02:31:10 -0400
Received: from 60-242-254-5.static.tpgi.com.au ([60.242.254.5]:50738 "EHLO
	bacardi.wooloowin.frase.id.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751260Ab1DJGbI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Apr 2011 02:31:08 -0400
X-Greylist: delayed 1103 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Apr 2011 02:31:07 EDT
Received: from bacardi.wooloowin.frase.id.au (localhost [127.0.0.1])
	by bacardi.wooloowin.frase.id.au (8.14.4/8.14.4) with ESMTP id p3A6CbRK007397;
	Sun, 10 Apr 2011 16:12:37 +1000 (EST)
	(envelope-from Fraser@bacardi.wooloowin.frase.id.au)
Received: (from Fraser@localhost)
	by bacardi.wooloowin.frase.id.au (8.14.4/8.14.4/Submit) id p3A6Caqg007396;
	Sun, 10 Apr 2011 16:12:36 +1000 (EST)
	(envelope-from Fraser)
X-Mailer: git-send-email 1.7.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171238>

Without the '-n' ('--no-name') argument, gzip includes timestamp in
output which results in different files.  Important systems like FreeBSD
ports and perhaps many others hash/checksum downloaded files to ensure
integrity.  For projects that do not release official archives, gitweb's
snapshot feature would be an excellent stand-in but for the fact that the
files it produces are not identical.

Supply '-n' to gzip to exclude timestamp from output and produce idential
output every time.

Signed-off-by: Fraser Tweedale <frase@frase.id.au>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 46186ab..2ab08da 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -186,7 +186,7 @@ our %known_snapshot_formats = (
 		'type' => 'application/x-gzip',
 		'suffix' => '.tar.gz',
 		'format' => 'tar',
-		'compressor' => ['gzip']},
+		'compressor' => ['gzip', '-n']},
 
 	'tbz2' => {
 		'display' => 'tar.bz2',
-- 
1.7.4.3
