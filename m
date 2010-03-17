From: Ian Ward Comfort <icomfort@stanford.edu>
Subject: [PATCH] bash: complete *_HEAD refs if present
Date: Wed, 17 Mar 2010 02:20:35 -0700
Message-ID: <1268817635-7946-1-git-send-email-icomfort@stanford.edu>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 17 10:28:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrpXl-00070U-4k
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 10:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab0CQJ14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 05:27:56 -0400
Received: from smtp5.Stanford.EDU ([171.67.219.85]:39477 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753679Ab0CQJ1z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 05:27:55 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Mar 2010 05:27:55 EDT
Received: from smtp.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 2E05218FA77;
	Wed, 17 Mar 2010 02:20:37 -0700 (PDT)
Received: from ashbury.stanford.edu (ashbury.Stanford.EDU [171.67.43.200])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.stanford.edu (Postfix) with ESMTPS id 8DF5018F6CF;
	Wed, 17 Mar 2010 02:20:35 -0700 (PDT)
Received: by ashbury.stanford.edu (Postfix, from userid 26037)
	id 6D7C31D0054; Wed, 17 Mar 2010 02:20:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142371>

We already complete HEAD, of course, and might as well complete the other
common refs mentioned in the rev-parse man page: FETCH_HEAD, ORIG_HEAD, and
MERGE_HEAD.

Signed-off-by: Ian Ward Comfort <icomfort@stanford.edu>
---
 contrib/completion/git-completion.bash |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fe93747..733ac39 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -250,7 +250,9 @@ __git_refs ()
 			refs="${cur%/*}"
 			;;
 		*)
-			if [ -e "$dir/HEAD" ]; then echo HEAD; fi
+			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD; do
+				if [ -e "$dir/$i" ]; then echo $i; fi
+			done
 			format="refname:short"
 			refs="refs/tags refs/heads refs/remotes"
 			;;
-- 
1.7.0.2
