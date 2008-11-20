From: Jonas Fonseca <fonseca@diku.dk>
Subject: [TopGit PATCH] tg patch: disable pager and colors for git-diff
Date: Thu, 20 Nov 2008 14:57:10 +0100
Message-ID: <20081120135710.GA16303@diku.dk>
References: <1227189062-11951-1-git-send-email-fonseca@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: madduck@debian.org
X-From: git-owner@vger.kernel.org Thu Nov 20 14:58:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3A3A-0000zq-Md
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 14:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730AbYKTN5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 08:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752981AbYKTN5N
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 08:57:13 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:55682 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832AbYKTN5M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Nov 2008 08:57:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 6E1D252C40A;
	Thu, 20 Nov 2008 14:57:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gf2DemVjFrPR; Thu, 20 Nov 2008 14:57:10 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 4800B52C3E9;
	Thu, 20 Nov 2008 14:57:10 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 172386DFB46; Thu, 20 Nov 2008 14:55:11 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 2FB9839A513; Thu, 20 Nov 2008 14:57:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227189062-11951-1-git-send-email-fonseca@diku.dk>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101433>

When output is not redirected to a file, git brings up the pager for
only the diff, which can be confusing, so disable with --no-pager.
git-diff is a porcelain command and thus subject to color options. Use
--no-color, to avoid the patch being corrupted with terminal escape
characters when color.diff=always.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 tg-patch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

 Jonas Fonseca <fonseca@diku.dk> wrote Thu, Nov 20, 2008:
 > Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
 > 
 > ---
 >  README[m |   11 [32m+++++[m[31m------[m
 >  1 files changed, 5 insertions(+), 6 deletions(-)[m
 > 
 > [1mdiff --git a/README b/README[m
 > [1mindex 5bfe3ee..9e291da 100644[m
 > [1m--- a/README[m
 > [1m+++ b/README[m

 I hope this demonstrates the point of this patch. ;)

diff --git a/tg-patch.sh b/tg-patch.sh
index 97338ab..c2f1b56 100644
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -34,7 +34,7 @@ git diff-tree --name-only "$base_rev" "$name" |
 	fgrep -vx ".topdeps" |
 	fgrep -vx ".topmsg" >"$git_is_stupid" || : # fgrep likes to fail randomly?
 if [ -s "$git_is_stupid" ]; then
-	cat "$git_is_stupid" | xargs git diff --patch-with-stat "$base_rev" "$name" --
+	cat "$git_is_stupid" | xargs git --no-pager diff --no-color --patch-with-stat "$base_rev" "$name" --
 else
 	echo "No changes."
 fi
-- 
tg: (f17218e..) jf/patch-no-pager-and-color (depends on: master)

-- 
Jonas Fonseca
