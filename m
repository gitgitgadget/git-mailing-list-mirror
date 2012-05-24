From: Jeff King <peff@peff.net>
Subject: [PATCH 7/7] format-patch: do not use bogus email addresses in
 message ids
Date: Thu, 24 May 2012 19:32:52 -0400
Message-ID: <20120524233251.GG11084@sigill.intra.peff.net>
References: <20120524232515.GA11054@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <haggerty@jpk.com>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 01:33:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXhWd-0006pW-8R
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 01:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787Ab2EXXcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 19:32:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54613
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395Ab2EXXcy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 19:32:54 -0400
Received: (qmail 2298 invoked by uid 107); 24 May 2012 23:33:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 19:33:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 19:32:52 -0400
Content-Disposition: inline
In-Reply-To: <20120524232515.GA11054@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198450>

We can ask git_committer_info to be strict about coming up
with an email, which will die automatically on a poorly
configured machine. This is better than letting invalid
message-ids into the wild.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index d86bca3..906dca4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -741,7 +741,7 @@ static void gen_message_id(struct rev_info *info, char *base)
 	struct strbuf buf = STRBUF_INIT;
 	strbuf_addf(&buf, "%s.%lu.git.%s", base,
 		    (unsigned long) time(NULL),
-		    git_committer_info(IDENT_NO_NAME|IDENT_NO_DATE));
+		    git_committer_info(IDENT_NO_NAME|IDENT_NO_DATE|IDENT_STRICT));
 	info->message_id = strbuf_detach(&buf, NULL);
 }
 
-- 
1.7.10.1.25.g7031a0f
