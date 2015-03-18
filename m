From: Jeff King <peff@peff.net>
Subject: [PATCH] clone: drop period from end of die_errno message
Date: Wed, 18 Mar 2015 15:02:01 -0400
Message-ID: <20150318190200.GC650@peff.net>
References: <etPan.5509bdf2.7a1ae87d.1766@ttvadmins-MacBook-Pro.local>
 <20150318185531.GA650@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Spencer Nelson <s@spenczar.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 20:02:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYJEH-0004T9-24
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 20:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933619AbbCRTCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 15:02:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:34780 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933614AbbCRTCD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 15:02:03 -0400
Received: (qmail 24447 invoked by uid 102); 18 Mar 2015 19:02:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 14:02:03 -0500
Received: (qmail 5826 invoked by uid 107); 18 Mar 2015 19:02:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 15:02:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Mar 2015 15:02:01 -0400
Content-Disposition: inline
In-Reply-To: <20150318185531.GA650@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265749>

We do not usually end our errors with a full stop, but it
looks especially bad when you use die_errno, which adds a
colon, like:

  fatal: could not create work tree dir 'foo'.: No such file or directory

Signed-off-by: Jeff King <peff@peff.net>
---
Not strictly related to the other patch, but I noticed it while playing
around.

 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9572467..aa01437 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -848,7 +848,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			die_errno(_("could not create leading directories of '%s'"),
 				  work_tree);
 		if (!dest_exists && mkdir(work_tree, 0777))
-			die_errno(_("could not create work tree dir '%s'."),
+			die_errno(_("could not create work tree dir '%s'"),
 				  work_tree);
 		set_git_work_tree(work_tree);
 	}
-- 
2.3.3.520.g3cfbb5d
