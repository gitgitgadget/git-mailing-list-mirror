From: Jeff King <peff@peff.net>
Subject: [PATCH 01/13] Makefile: drop USE_GETTEXT_SCHEME from GIT-CFLAGS
Date: Wed, 5 Feb 2014 12:49:02 -0500
Message-ID: <20140205174901.GA15218@sigill.intra.peff.net>
References: <20140205174823.GA15070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 05 18:49:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB6b1-0006ON-Uc
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 18:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbaBERtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 12:49:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:45134 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752969AbaBERtF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 12:49:05 -0500
Received: (qmail 7484 invoked by uid 102); 5 Feb 2014 17:49:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 11:49:04 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 12:49:02 -0500
Content-Disposition: inline
In-Reply-To: <20140205174823.GA15070@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241619>

This variable is used only by shell scripts, not by C
programs. It was originally included in GIT-CFLAGS as part
of ad17ea7 (add a Makefile switch to avoid gettext
translation in shell scripts, 2012-01-23), in an attempt to
trigger rebuilding when the variable changed.

However, shell scripts do not respect GIT-CFLAGS. Later,
e4dd89a (Makefile: update scripts when build-time parameters
change, 2012-06-20) introduced a separate GIT-SCRIPT-DEFINES
to accomplish this, which also included USE_GETTEXT_SCHEME.
We can drop the redundant and useless mention in GIT-CFLAGS.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index dddaf4f..3cd4a92 100644
--- a/Makefile
+++ b/Makefile
@@ -2164,7 +2164,7 @@ GIT-PREFIX: FORCE
 		echo "$$FLAGS" >GIT-PREFIX; \
 	fi
 
-TRACK_CFLAGS = $(CC):$(subst ','\'',$(ALL_CFLAGS)):$(USE_GETTEXT_SCHEME)
+TRACK_CFLAGS = $(CC):$(subst ','\'',$(ALL_CFLAGS))
 
 GIT-CFLAGS: FORCE
 	@FLAGS='$(TRACK_CFLAGS)'; \
-- 
1.8.5.2.500.g8060133
