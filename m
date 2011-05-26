From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-submodule.sh: separate parens by a space to avoid confusing some shells
Date: Thu, 26 May 2011 13:52:04 -0700
Message-ID: <vWPtQ6mu-P8TxddTGAsNGMxxRy-vaOeaUiF8WZQpA2J8HcdAc02vCzYpygwdejLhR6OIWYLtPtK7E4oxXk50vg@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 26 23:21:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPi07-0004Kr-C4
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 23:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757300Ab1EZVVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 17:21:46 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55546 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779Ab1EZVVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 17:21:45 -0400
X-Greylist: delayed 1438 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 May 2011 17:21:45 EDT
Received: by mail.nrlssc.navy.mil id p4QKup07027553; Thu, 26 May 2011 15:57:40 -0500
X-OriginalArrivalTime: 26 May 2011 20:52:17.0522 (UTC) FILETIME=[CC8E7D20:01CC1BE6]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174575>

From: Brandon Casey <drafnel@gmail.com>

Some shells interpret '(( ))' according to the rules for arithmetic
expansion.  This may not follow POSIX, but is prevalent in commonly used
shells.  Bash does not have a problem with this particular instance of
'((', likely because it is not followed by a '))', but the public domain
ksh does, and so does ksh on IRIX 6.5.

So, add a space between the parenthesis to avoid confusing these shells.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bf110e9..d189a24 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -495,7 +495,7 @@ cmd_update()
 				# Run fetch only if $sha1 isn't present or it
 				# is not reachable from a ref.
 				(clear_local_git_env; cd "$path" &&
-					((rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
+					( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
 					 test -z "$rev") || git-fetch)) ||
 				die "Unable to fetch in submodule path '$path'"
 			fi
-- 
1.7.4.4
