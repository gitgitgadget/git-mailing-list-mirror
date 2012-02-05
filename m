From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Change include order in two compat/ files to avoid compiler warning
Date: Sat,  4 Feb 2012 20:08:27 -0500
Message-ID: <1328404107-15757-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Feb 05 02:08:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtqb3-0002Kf-Kt
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 02:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048Ab2BEBIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 20:08:31 -0500
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:37209 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab2BEBIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 20:08:30 -0500
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:50788 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Rtqaj-0001nO-Lt; Sat, 04 Feb 2012 20:08:29 -0500
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Rtqaj-00046g-Kp; Sat, 04 Feb 2012 20:08:29 -0500
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189925>

The inet_ntop and inet_pton compatibility wrapper source files
included system headers before git-compat-utils.h.  This was causing a
warning on Solaris as _FILE_OFFSET_BITS was being redefined in
git-compat-utils.h.  Including git-compat-utils.h first avoids the
warnings.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---

I verified that this re-ordering doesn't affect either the build or the 
test suite completion on both i386 and sparc.  I think the ordering is
simply the result of placing the git-compat-utils.h include where some
others were removed in da523cc597b1.

 compat/inet_ntop.c |    4 +---
 compat/inet_pton.c |    4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
index 60b5a1d..f1bf81c 100644
--- a/compat/inet_ntop.c
+++ b/compat/inet_ntop.c
@@ -15,11 +15,9 @@
  * SOFTWARE.
  */
 
+#include "../git-compat-util.h"
 #include <errno.h>
 #include <sys/types.h>
-
-#include "../git-compat-util.h"
-
 #include <stdio.h>
 #include <string.h>
 
diff --git a/compat/inet_pton.c b/compat/inet_pton.c
index 2ec995e..1d44a5d 100644
--- a/compat/inet_pton.c
+++ b/compat/inet_pton.c
@@ -15,11 +15,9 @@
  * WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
+#include "../git-compat-util.h"
 #include <errno.h>
 #include <sys/types.h>
-
-#include "../git-compat-util.h"
-
 #include <stdio.h>
 #include <string.h>
 
-- 
1.7.8.3
