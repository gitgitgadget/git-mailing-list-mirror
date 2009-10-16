From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 5/5] stash list: drop the default limit of 10 stashes
Date: Fri, 16 Oct 2009 16:20:37 +0200
Message-ID: <df4f4840d182cec33c279ce4008d707521dd4c01.1255701207.git.trast@student.ethz.ch>
References: <cover.1255701207.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 16 16:25:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MynkR-0008Gh-7k
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 16:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760304AbZJPOX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 10:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760279AbZJPOX0
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 10:23:26 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:34132 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760159AbZJPOXX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 10:23:23 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 16:21:32 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 16:21:11 +0200
X-Mailer: git-send-email 1.6.5.116.g4aaa3
In-Reply-To: <cover.1255701207.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130494>

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
index f8847c1..f796c2f 100755
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
1.6.5.116.gfe4b9
