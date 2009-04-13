From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] docs/checkout: clarify what "non-branch" means
Date: Mon, 13 Apr 2009 07:21:04 -0400
Message-ID: <20090413112104.GE15982@coredump.intra.peff.net>
References: <20090413110947.GA15647@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 13:22:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtKFP-0001je-Jb
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 13:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbZDMLVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 07:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753687AbZDMLVH
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 07:21:07 -0400
Received: from peff.net ([208.65.91.99]:43511 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbZDMLVG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 07:21:06 -0400
Received: (qmail 31851 invoked by uid 107); 13 Apr 2009 11:21:08 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 13 Apr 2009 07:21:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Apr 2009 07:21:04 -0400
Content-Disposition: inline
In-Reply-To: <20090413110947.GA15647@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116432>

In the code we literally stick "refs/heads/" on the front
and see if it resolves, so that is probably the best
explanation.

Signed-off-by: Jeff King <peff@peff.net>
---
I hope this helps a little bit with Mark's confusion. But while writing
it, I really think it would be a simpler rule to say "if it's in
refs/heads/, then it's a branch" (which is similar to what Mark
suggested earlier).

So "git checkout refs/heads/master" would be identical to "git checkout
master". That would require a code change, though.

 Documentation/git-checkout.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 4a1fb53..ad4b31e 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -114,11 +114,11 @@ the conflicted merge in the specified paths.
 	"merge" style, shows the original contents).
 
 <branch>::
-	Branch to checkout (when no paths are given); may be any object
-	ID that resolves to a commit.  Defaults to HEAD.
-+
-When this parameter names a non-branch (but still a valid commit object),
-your HEAD becomes 'detached'.
+	Branch to checkout; if it refers to a branch (i.e., a name that,
+	when prepended with "refs/heads/", is a valid ref), then that
+	branch is checked out. Otherwise, if it refers to a valid
+	commit, your HEAD becomes "detached" and you are no longer on
+	any branch (see below for details).
 +
 As a special case, the `"@\{-N\}"` syntax for the N-th last branch
 checks out the branch (instead of detaching).  You may also specify
-- 
1.6.3.rc0.148.g141203.dirty
