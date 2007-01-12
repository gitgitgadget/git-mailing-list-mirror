From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Make git-repack explain what it's doing during prune
Date: Thu, 11 Jan 2007 18:46:23 -0800
Message-ID: <20070112024623.GA9787@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 12 03:46:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5CR1-0002uj-9G
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 03:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbXALCqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 21:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbXALCqY
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 21:46:24 -0500
Received: from tater.midwinter.com ([216.32.86.90]:55669 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030364AbXALCqY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 21:46:24 -0500
Received: (qmail 9871 invoked by uid 1001); 12 Jan 2007 02:46:23 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36655>

git-pack-objects reports its progress as it runs, but as soon as it
finishes and git-repack (with -d option) runs git-prune-packed, the
user is left in the dark about what's going on. That makes git-repack
feel inconsistent: it starts off with a bunch of progress reports then
appears to just sit there for a while before finishing.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
 git-repack.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 375434b..a69d915 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -110,6 +110,9 @@ then
 		  done
 		)
 	fi
+	if test "$quiet" != '-q'; then
+	    echo "Removing unused objects..."
+	fi
 	git-prune-packed
 fi
 
-- 
1.4.4.4.g1295-dirty
