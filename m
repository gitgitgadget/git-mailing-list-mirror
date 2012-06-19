From: Jeff King <peff@peff.net>
Subject: [PATCHv2 2/8] Makefile: do not replace @@GIT_USER_AGENT@@ in scripts
Date: Tue, 19 Jun 2012 19:24:53 -0400
Message-ID: <20120619232453.GB6496@sigill.intra.peff.net>
References: <20120619232231.GA6328@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 01:25:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh7n9-0008CF-5l
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 01:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464Ab2FSXY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 19:24:56 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33138
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491Ab2FSXYz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 19:24:55 -0400
Received: (qmail 15752 invoked by uid 107); 19 Jun 2012 23:24:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jun 2012 19:24:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2012 19:24:53 -0400
Content-Disposition: inline
In-Reply-To: <20120619232231.GA6328@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200267>

No scripts actually care about this replacement. This was
erroneously added by d937411.

Signed-off-by: Jeff King <peff@peff.net>
---
I think I started that series by just replacing GIT_USER_AGENT
everywhere that GIT_VERSION was before realizing that I didn't need to
do that at all, and this was leftover cruft.

Technically I could re-roll jk/version-string with this squashed in,
since you are probably about to do the post-release rewind of next, but
I don't know that it's worth the trouble unless we are re-rolling the
whole thing (to put the Makefile fixups first, and then build
version-string stuff on top).

 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 537d2ea..23c289d 100644
--- a/Makefile
+++ b/Makefile
@@ -2010,7 +2010,6 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
     -e 's|@@DIFF@@|$(DIFF_SQ)|' \
     -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-    -e 's|@@GIT_USER_AGENT@@|$(GIT_USER_AGENT_SQ)|g' \
     -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
     -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
     -e 's/@@USE_GETTEXT_SCHEME@@/$(USE_GETTEXT_SCHEME)/g' \
-- 
1.7.11.rc3.5.g201460b
