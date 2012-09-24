From: Tobias Ulmer <tobiasu@tmux.org>
Subject: [PATCH] silence git gc --auto --quiet output
Date: Mon, 24 Sep 2012 04:40:24 +0200
Message-ID: <20120924024024.GA12700@tin.tmux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 04:48:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFyii-0006I8-Fr
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 04:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829Ab2IXCsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2012 22:48:19 -0400
Received: from tin.tmux.org ([64.85.165.147]:22384 "EHLO tin.tmux.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754728Ab2IXCsT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2012 22:48:19 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Sep 2012 22:48:19 EDT
Received: by tin.tmux.org (Postfix, from userid 1000)
	id 9604B1FDD7; Mon, 24 Sep 2012 04:40:24 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206252>

When --quiet is requested, gc --auto should not display messages unless
there is an error.

Signed-off-by: Tobias Ulmer <tobiasu@tmux.org>
---
 builtin/gc.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 6d46608..6be6c8d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -217,9 +217,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		 */
 		if (!need_to_gc())
 			return 0;
-		if (quiet)
-			fprintf(stderr, _("Auto packing the repository for optimum performance.\n"));
-		else
+		if (!quiet)
 			fprintf(stderr,
 					_("Auto packing the repository for optimum performance. You may also\n"
 					"run \"git gc\" manually. See "
-- 
1.7.6
