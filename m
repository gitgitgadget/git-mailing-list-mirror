From: Jeff King <peff@peff.net>
Subject: [PATCH 17/21] git-compat-util: drop mempcpy compat code
Date: Fri, 19 Feb 2016 06:25:15 -0500
Message-ID: <20160219112514.GQ9319@sigill.intra.peff.net>
References: <20160219111941.GA31906@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 12:25:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWjBe-00061r-EJ
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 12:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427691AbcBSLZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 06:25:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:45299 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1427682AbcBSLZR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 06:25:17 -0500
Received: (qmail 20643 invoked by uid 102); 19 Feb 2016 11:25:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 06:25:17 -0500
Received: (qmail 26799 invoked by uid 107); 19 Feb 2016 11:25:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 06:25:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Feb 2016 06:25:15 -0500
Content-Disposition: inline
In-Reply-To: <20160219111941.GA31906@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286701>

There are no callers of this left, as the last one was
dropped in the previous patch. And there are not likely to
be new ones, as the function has been around since 2010
without gaining any new callers.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index e71e615..8f0e76b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -681,7 +681,6 @@ extern int git_vsnprintf(char *str, size_t maxsize,
 #ifdef __GLIBC_PREREQ
 #if __GLIBC_PREREQ(2, 1)
 #define HAVE_STRCHRNUL
-#define HAVE_MEMPCPY
 #endif
 #endif
 
@@ -695,14 +694,6 @@ static inline char *gitstrchrnul(const char *s, int c)
 }
 #endif
 
-#ifndef HAVE_MEMPCPY
-#define mempcpy gitmempcpy
-static inline void *gitmempcpy(void *dest, const void *src, size_t n)
-{
-	return (char *)memcpy(dest, src, n) + n;
-}
-#endif
-
 #ifdef NO_INET_PTON
 int inet_pton(int af, const char *src, void *dst);
 #endif
-- 
2.7.1.577.gfed91b8
