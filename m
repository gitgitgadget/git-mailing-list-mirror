From: David Symonds <dsymonds@gmail.com>
Subject: [PATCH] git-checkout: Support relative paths containing "..".
Date: Fri,  9 Nov 2007 11:36:06 +1100
Message-ID: <11945685673280-git-send-email-dsymonds@gmail.com>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	David Symonds <dsymonds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:01:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIFP-00047A-Oz
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbXKIBAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 20:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563AbXKIBAt
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:00:49 -0500
Received: from ipmail02.adl2.internode.on.net ([203.16.214.141]:28568 "EHLO
	ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753226AbXKIBAs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2007 20:00:48 -0500
X-IronPort-AV: E=Sophos;i="4.21,392,1188743400"; 
   d="scan'208";a="224084280"
Received: from ppp121-44-17-138.lns10.syd7.internode.on.net (HELO localhost.localdomain) ([121.44.17.138])
  by ipmail02.adl2.internode.on.net with ESMTP; 09 Nov 2007 11:06:12 +1030
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64094>

Signed-off-by: David Symonds <dsymonds@gmail.com>
---
 git-checkout.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index c00cedd..aa724ac 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -133,9 +133,9 @@ Did you intend to checkout '$@' which can not be resolved as commit?"
 	fi
 
 	# Make sure the request is about existing paths.
-	git ls-files --error-unmatch -- "$@" >/dev/null || exit
-	git ls-files -- "$@" |
-	git checkout-index -f -u --stdin
+	git ls-files --full-name --error-unmatch -- "$@" >/dev/null || exit
+	git ls-files --full-name -- "$@" |
+		(cd_to_toplevel && git checkout-index -f -u --stdin)
 
 	# Run a post-checkout hook -- the HEAD does not change so the
 	# current HEAD is passed in for both args
-- 
1.5.3.1
