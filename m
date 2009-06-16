From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] Makefile: use compat regex on Solaris
Date: Tue, 16 Jun 2009 08:14:40 -0400
Message-ID: <20090616121440.GB11918@coredump.intra.peff.net>
References: <20090616120737.GA5227@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>, git <git@vger.kernel.org>
To: John Bito <jwbito@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 14:14:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGXYv-0005Vh-LM
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 14:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756939AbZFPMOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 08:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754957AbZFPMOk
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 08:14:40 -0400
Received: from peff.net ([208.65.91.99]:36000 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622AbZFPMOk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 08:14:40 -0400
Received: (qmail 4155 invoked by uid 107); 16 Jun 2009 12:16:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Jun 2009 08:16:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2009 08:14:40 -0400
Content-Disposition: inline
In-Reply-To: <20090616120737.GA5227@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121678>

The system regex is either slow or buggy for complex
patterns, like the built-in xfuncname pattern for java
files.

Signed-off-by: Jeff King <peff@peff.net>
---
If people want to see the speed difference, try:

  $ git clone git://repo.or.cz/egit.git
  $ cd egit
  $ time git diff v0.4.0 >/dev/null

before and after.

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index a1e4e45..0e09ec8 100644
--- a/Makefile
+++ b/Makefile
@@ -713,6 +713,7 @@ ifeq ($(uname_S),SunOS)
 	NO_HSTRERROR = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_MKSTEMPS = YesPlease
+	NO_REGEX = YesPlease
 	ifneq ($(uname_R),5.11)
 		OLD_ICONV = UnfortunatelyYes
 	endif
-- 
1.6.3.2.225.gb8364.dirty
