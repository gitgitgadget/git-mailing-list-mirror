From: Jeff King <peff@peff.net>
Subject: [PATCH v3 18/22] git-compat-util: drop mempcpy compat code
Date: Mon, 22 Feb 2016 17:45:01 -0500
Message-ID: <20160222224501.GR10075@sigill.intra.peff.net>
References: <20160222224059.GA3857@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 23:45:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzE4-0005WQ-Pq
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756134AbcBVWpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:45:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:47125 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752980AbcBVWpE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:45:04 -0500
Received: (qmail 21788 invoked by uid 102); 22 Feb 2016 22:45:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:45:03 -0500
Received: (qmail 23214 invoked by uid 107); 22 Feb 2016 22:45:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 17:45:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 17:45:01 -0500
Content-Disposition: inline
In-Reply-To: <20160222224059.GA3857@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286987>

There are no callers of this left, as the last one was
dropped in the previous patch. And there are not likely to
be new ones, as the function has been around since 2010
without gaining any new callers.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 57ff9fb..1459f9b 100644
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
2.7.2.645.g4e1306c
