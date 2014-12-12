From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] strbuf.h: reorganize api function grouping headers
Date: Fri, 12 Dec 2014 16:32:36 -0500
Message-ID: <20141212213235.GD27451@peff.net>
References: <20141212212726.GA26284@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 22:32:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzXpK-0003UL-0h
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 22:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbaLLVci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 16:32:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:52328 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750774AbaLLVch (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 16:32:37 -0500
Received: (qmail 20122 invoked by uid 102); 12 Dec 2014 21:32:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Dec 2014 15:32:37 -0600
Received: (qmail 14331 invoked by uid 107); 12 Dec 2014 21:32:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Dec 2014 16:32:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Dec 2014 16:32:36 -0500
Content-Disposition: inline
In-Reply-To: <20141212212726.GA26284@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261378>

The original API doc had something like:

    Functions
    ---------

    * Life cycle

      ... some life-cycle functions ...

    * Related to the contents of the buffer

      ... functions related to contents ....

    etc

This grouping can be hard to read in the comment sources,
given the "*" in the comment lines, and the amount of text
between each section.

Instead, let's make a flat list of groupings, and underline
each as a section header. That makes them standout, and
eliminates the weird half-phrase of "Related to...". Like:

    Functions related to the contents of the buffer
    -----------------------------------------------

Signed-off-by: Jeff King <peff@peff.net>
---

If you look at the original header file, these groupings actually did
exist (though we did not remotely follow them as functions were added),
and looked like:

  /* ---- content related ---- */

I'd be happy with something like that, too, but went with the style that
matched the "Data Structures" header.

 strbuf.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index 078b805..8649a0a 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -71,12 +71,8 @@ extern char strbuf_slopbuf[];
 #define STRBUF_INIT  { 0, 0, strbuf_slopbuf }
 
 /**
- * Functions
- * ---------
- */
-
-/**
- * * Life Cycle
+ * Life Cycle Functions
+ * --------------------
  */
 
 /**
@@ -120,7 +116,8 @@ static inline void strbuf_swap(struct strbuf *a, struct strbuf *b)
 
 
 /**
- * * Related to the size of the buffer
+ * Functions related to the size of the buffer
+ * -------------------------------------------
  */
 
 /**
@@ -162,7 +159,8 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len)
 
 
 /**
- * * Related to the contents of the buffer
+ * Functions related to the contents of the buffer
+ * -----------------------------------------------
  */
 
 /**
-- 
2.2.0.454.g7eca6b7
