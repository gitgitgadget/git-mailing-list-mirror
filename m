From: Jeff King <peff@peff.net>
Subject: [PATCH 1/7] ident: refactor empty ident error message
Date: Thu, 24 May 2012 19:26:32 -0400
Message-ID: <20120524232632.GA11084@sigill.intra.peff.net>
References: <20120524232515.GA11054@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <haggerty@jpk.com>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 01:26:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXhQW-0006G9-6X
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 01:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965437Ab2EXX0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 19:26:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54574
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932290Ab2EXX0f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 19:26:35 -0400
Received: (qmail 2096 invoked by uid 107); 24 May 2012 23:27:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 19:27:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 19:26:32 -0400
Content-Disposition: inline
In-Reply-To: <20120524232515.GA11054@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198444>

There's on point in printing the name, since it is by
definition the empty string if we have reached this code
path. Instead, let's be more clear that we are complaining
about the empty name, but still show the email address that
it is attached to (since that may provide some context to
the user).

Signed-off-by: Jeff King <peff@peff.net>
---
As I mentioned in the cover letter, this one is optional. But I think it
makes sense.

 ident.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ident.c b/ident.c
index e279039..f5160e1 100644
--- a/ident.c
+++ b/ident.c
@@ -281,7 +281,7 @@ const char *fmt_ident(const char *name, const char *email,
 		if (error_on_no_name) {
 			if (name == git_default_name.buf)
 				fputs(env_hint, stderr);
-			die("empty ident %s <%s> not allowed", name, email);
+			die("empty ident name (for <%s>) not allowed", email);
 		}
 		pw = xgetpwuid_self();
 		name = pw->pw_name;
-- 
1.7.10.1.25.g7031a0f
