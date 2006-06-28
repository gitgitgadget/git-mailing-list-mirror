From: Jeff King <peff@peff.net>
Subject: [PATCH] quote.c: silence compiler warnings from EMIT macro
Date: Wed, 28 Jun 2006 01:59:23 -0400
Message-ID: <20060628055923.GA6071@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 07:59:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvT5F-0006Ut-66
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 07:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWF1F70 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 01:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbWF1F70
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 01:59:26 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:64225 "HELO
	peff.net") by vger.kernel.org with SMTP id S932523AbWF1F7Z (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 01:59:25 -0400
Received: (qmail 22479 invoked from network); 28 Jun 2006 01:59:03 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 28 Jun 2006 01:59:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jun 2006 01:59:23 -0400
To: junkio@cox.net
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22773>

Signed-off-by: Jeff King <peff@peff.net>
---
This allows compiling with gcc -Wall -Werror, which makes finding useful
warnings easier. I also think the 'if' is easier to read than the
short-circuit.

 quote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/quote.c b/quote.c
index dcc2326..1910d00 100644
--- a/quote.c
+++ b/quote.c
@@ -13,7 +13,7 @@ #include "quote.h"
  *  a!b      ==> a'\!'b    ==> 'a'\!'b'
  */
 #undef EMIT
-#define EMIT(x) ( (++len < n) && (*bp++ = (x)) )
+#define EMIT(x) do { if (++len < n) *bp++ = (x); } while(0)
 
 static inline int need_bs_quote(char c)
 {
-- 
1.4.1.rc1.g29f4a-dirty
