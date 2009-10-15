From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 5/5] stash list: drop the default limit of 10 stashes
Date: Fri, 16 Oct 2009 00:41:48 +0200
Message-ID: <08377f64e00bec26e69f88c4c1d6769b9f366935.1255645570.git.trast@student.ethz.ch>
References: <cover.1255645570.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 00:47:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyZ4t-0006Yh-FS
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 00:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763144AbZJOWne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 18:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758987AbZJOWne
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 18:43:34 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:58969 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757571AbZJOWnd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 18:43:33 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 00:42:45 +0200
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 00:42:24 +0200
X-Mailer: git-send-email 1.6.5.116.gfe4b9
In-Reply-To: <cover.1255645570.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130436>

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
1.6.5.18.g9f87a.dirty
