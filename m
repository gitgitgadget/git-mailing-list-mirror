From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 4/5] stash list: drop the default limit of 10 stashes
Date: Mon, 12 Oct 2009 23:06:06 +0200
Message-ID: <137df1f7295576345f5aefe46c882399e107c321.1255380039.git.trast@student.ethz.ch>
References: <cover.1255380039.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>,
	<git@vger.kernel.org>
To: Jef Driesen <jefdriesen@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 23:14:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxSDk-0002of-LG
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 23:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933156AbZJLVIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 17:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933162AbZJLVIF
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:08:05 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:56482 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933148AbZJLVID (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:08:03 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 12 Oct
 2009 23:06:44 +0200
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 12 Oct
 2009 23:06:45 +0200
X-Mailer: git-send-email 1.6.5.64.g01287
In-Reply-To: <cover.1255380039.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130068>

'git stash list' had an undocumented limit of 10 stashes, unless other
git-log arguments were specified.  This surprised at least one user,
but possibly served to cut the output below a screenful without using
a pager.

Since the last commit, 'git stash list' will fire up a pager according
to the same rules as the 'git log' it calls, so we can drop the limit.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-stash.sh |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 8fbf10a..08a7669 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -382,11 +382,6 @@ test -n "$seen_non_option" || set "save" "$@"
 case "$1" in
 list)
 	shift
-	if test $# = 0
-	then
-		set x -n 10
-		shift
-	fi
 	list_stash "$@"
 	;;
 show)
-- 
1.6.5.64.g01287
