From: =?ISO-8859-1?Q?R=FCdiger?= Sonderfeld <ruediger@c-plusplus.de>
Subject: [PATCH] web--browse: Add support for xdg-open.
Date: Sat, 26 Oct 2013 19:43:54 +0200
Message-ID: <4642757.rY5h83ya4f@descartes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 26 19:54:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Va83w-0003El-0z
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 19:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab3JZRyF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Oct 2013 13:54:05 -0400
Received: from ptmx.org ([178.63.28.110]:44836 "EHLO ptmx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753284Ab3JZRyD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Oct 2013 13:54:03 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Oct 2013 13:54:03 EDT
Received: from localhost (localhost [127.0.0.1])
	by ptmx.org (Postfix) with ESMTP id 5C7B52B1B6;
	Sat, 26 Oct 2013 19:44:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at ptmx.org
Received: from ptmx.org ([127.0.0.1])
	by localhost (ptmx.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3UXpLcgJvvgw; Sat, 26 Oct 2013 19:44:03 +0200 (CEST)
Received: from descartes.localnet (chello080108246092.7.14.vie.surfer.at [80.108.246.92])
	by ptmx.org (Postfix) with ESMTPSA id 427E126A52;
	Sat, 26 Oct 2013 19:44:03 +0200 (CEST)
User-Agent: KMail/4.11.2 (Linux/3.11.0-12-generic; KDE/4.11.2; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236760>

xdg-open is a tool similar to git-web--browse.  It opens a file or URL =
in the
user's preferred application.  It could probably be made default at lea=
st on
Linux with a graphical environment.

Signed-off-by: R=C3=BCdiger Sonderfeld <ruediger@c-plusplus.de>
---
 Documentation/git-web--browse.txt | 1 +
 git-web--browse.sh                | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web-=
-browse.txt
index 5aec4ec..2de575f 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -35,6 +35,7 @@ The following browsers (or commands) are currently su=
pported:
 * open (this is the default under Mac OS X GUI)
 * start (this is the default under MinGW)
 * cygstart (this is the default under Cygwin)
+* xdg-open
=20
 Custom commands may also be specified.
=20
diff --git a/git-web--browse.sh b/git-web--browse.sh
index 1d72ec7..ebdfba6 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -34,7 +34,7 @@ valid_tool() {
 	firefox | iceweasel | seamonkey | iceape | \
 	chrome | google-chrome | chromium | chromium-browser | \
 	konqueror | opera | w3m | elinks | links | lynx | dillo | open | \
-	start | cygstart)
+	start | cygstart | xdg-open)
 		;; # happy
 	*)
 		valid_custom_tool "$1" || return 1
@@ -112,7 +112,7 @@ fi
=20
 if test -z "$browser" ; then
 	if test -n "$DISPLAY"; then
-		browser_candidates=3D"firefox iceweasel google-chrome chrome chromiu=
m chromium-browser konqueror opera seamonkey iceape w3m elinks links ly=
nx dillo"
+		browser_candidates=3D"firefox iceweasel google-chrome chrome chromiu=
m chromium-browser konqueror opera seamonkey iceape w3m elinks links ly=
nx dillo xdg-open"
 		if test "$KDE_FULL_SESSION" =3D "true"; then
 			browser_candidates=3D"konqueror $browser_candidates"
 		fi
@@ -179,7 +179,7 @@ konqueror)
 		;;
 	esac
 	;;
-w3m|elinks|links|lynx|open|cygstart)
+w3m|elinks|links|lynx|open|cygstart|xdg-open)
 	"$browser_path" "$@"
 	;;
 start)
--=20
1.8.4.1
