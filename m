From: Fraser Tweedale <frase@frase.id.au>
Subject: [PATCH] gitweb: supply '-n' to gzip for identical output
Date: Tue, 26 Apr 2011 11:32:00 +1000
Message-ID: <1303781520-95861-1-git-send-email-frase@frase.id.au>
Cc: Fraser Tweedale <frase@frase.id.au>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 26 03:33:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEX9J-0005e5-1S
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 03:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739Ab1DZBdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 21:33:03 -0400
Received: from 60-242-254-5.static.tpgi.com.au ([60.242.254.5]:52719 "EHLO
	bacardi.wooloowin.frase.id.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932724Ab1DZBdB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2011 21:33:01 -0400
Received: from bacardi.wooloowin.frase.id.au (localhost [127.0.0.1])
	by bacardi.wooloowin.frase.id.au (8.14.4/8.14.4) with ESMTP id p3Q1WoFL095908;
	Tue, 26 Apr 2011 11:32:50 +1000 (EST)
	(envelope-from Fraser@bacardi.wooloowin.frase.id.au)
Received: (from Fraser@localhost)
	by bacardi.wooloowin.frase.id.au (8.14.4/8.14.4/Submit) id p3Q1WmJZ095907;
	Tue, 26 Apr 2011 11:32:48 +1000 (EST)
	(envelope-from Fraser)
X-Mailer: git-send-email 1.7.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172062>

Without the '-n' ('--no-name') argument, gzip includes a timestamp in
output which results in different files.  Important systems like FreeBSD
ports and perhaps several others hash/checksum downloaded files to ensure
integrity.  For projects that do not release official archives, gitweb's
snapshot feature would be an excellent alternative, except that the files
it produces are not identical.

Whilst '--no-name' is more descriptive, the long version of the flag is
not supported on all systems.  In particular, OpenBSD does not appear to
support it.

Supply '-n' to gzip to exclude timestamp from output and produce idential
output every time.

Signed-off-by: Fraser Tweedale <frase@frase.id.au>
Acked-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ee69ea6..f8db40a 100755
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
1.7.4.5
