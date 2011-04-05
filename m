From: Eric Blake <eblake@redhat.com>
Subject: [PATCHv3 1/2] Documentation: clarify fnmatch behavior in gitignore
Date: Tue,  5 Apr 2011 16:17:57 -0600
Message-ID: <1302041878-24426-1-git-send-email-eblake@redhat.com>
Cc: eblake@redhat.com, j6t@kdbg.org, jrnieder@gmail.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 00:23:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Ef7-0006Xs-LM
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 00:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264Ab1DEWXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 18:23:45 -0400
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:53004
	"EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752770Ab1DEWXo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 18:23:44 -0400
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Apr 2011 18:23:44 EDT
Received: from omta06.westchester.pa.mail.comcast.net ([76.96.62.51])
	by QMTA11.westchester.pa.mail.comcast.net with comcast
	id TyGK1g00616LCl05ByJ5tQ; Tue, 05 Apr 2011 22:18:05 +0000
Received: from office.redhat.com ([24.10.251.25])
	by omta06.westchester.pa.mail.comcast.net with comcast
	id TyJ01g00n0ZdyUg3SyJ4TY; Tue, 05 Apr 2011 22:18:05 +0000
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170930>

Make it clear that in a .gitignore file,

  *ignore

matches (and therefore excludes) `.gitignore', even though the
same glob does not match in the shell.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v3: separate fnmatch wording cleanup into its own patch

 Documentation/gitignore.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 2e7328b..9b1e5e1 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -86,9 +86,10 @@ PATTERN FORMAT
    `.gitignore` file).

  - Otherwise, git treats the pattern as a shell glob suitable
-   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
-   wildcards in the pattern will not match a / in the pathname.
-   For example, "Documentation/{asterisk}.html" matches
+   for consumption by fnmatch(3) with the FNM_PATHNAME but not
+   FNM_PERIOD flags: wildcards in the pattern will match leading
+   . but not / in pathnames.  For example,
+   "Documentation/{asterisk}.html" matches "Documentation/.html" and
    "Documentation/git.html" but not "Documentation/ppc/ppc.html"
    or "tools/perf/Documentation/perf.html".

-- 
1.7.4
