From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] pager_in_use: use git_env_bool
Date: Mon, 10 Aug 2015 01:19:34 -0400
Message-ID: <20150810051933.GA15441@sigill.intra.peff.net>
References: <20150810051901.GA9262@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 07:19:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOfUt-0005IE-TO
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 07:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbbHJFTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 01:19:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:42772 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751005AbbHJFTj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 01:19:39 -0400
Received: (qmail 14614 invoked by uid 102); 10 Aug 2015 05:19:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 00:19:39 -0500
Received: (qmail 2101 invoked by uid 107); 10 Aug 2015 05:19:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 01:19:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 01:19:34 -0400
Content-Disposition: inline
In-Reply-To: <20150810051901.GA9262@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275563>

This function basically reimplements git_env_bool (because
it predates it). Let's reuse that helper, which is shorter
and avoids repeating a string literal.

Signed-off-by: Jeff King <peff@peff.net>
---
 pager.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/pager.c b/pager.c
index 070dc11..e3ad465 100644
--- a/pager.c
+++ b/pager.c
@@ -95,9 +95,7 @@ void setup_pager(void)
 
 int pager_in_use(void)
 {
-	const char *env;
-	env = getenv("GIT_PAGER_IN_USE");
-	return env ? git_config_bool("GIT_PAGER_IN_USE", env) : 0;
+	return git_env_bool("GIT_PAGER_IN_USE", 0);
 }
 
 /*
-- 
2.5.0.414.g670f2a4
