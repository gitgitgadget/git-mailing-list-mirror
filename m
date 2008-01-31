From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] git-filter-branch.sh: don't use --default when calling
 rev-list
Date: Wed, 30 Jan 2008 18:15:19 -0600
Message-ID: <47A11317.2010409@nrlssc.navy.mil>
References: <47A109A7.1070502@nrlssc.navy.mil> <1201738186-28132-1-git-send-email-casey@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 01:16:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKN6X-0007Wx-Si
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 01:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576AbYAaAQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 19:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755439AbYAaAQB
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 19:16:01 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37638 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755317AbYAaAQA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 19:16:00 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0V0FKwU012154;
	Wed, 30 Jan 2008 18:15:20 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 30 Jan 2008 18:15:20 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <1201738186-28132-1-git-send-email-casey@nrlssc.navy.mil>
X-OriginalArrivalTime: 31 Jan 2008 00:15:20.0433 (UTC) FILETIME=[5D7A2E10:01C8639E]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15694001
X-TM-AS-Result: : Yes--4.797900-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTE1MDY2OC0xNTA1?=
	=?us-ascii?B?NDEtNzA3NDUxLTcwMjAzNy03MDI5MDAtMTA2NDIwLTcwMjYwOS03?=
	=?us-ascii?B?MDAxNTEtNzAwMTYwLTE4ODAxOS03MTA3MzktNzAzNzEyLTcwMjU1?=
	=?us-ascii?B?MS0xNDgwMzktMTQ4MDUx?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72079>

This command requires a revision to be specified on the command line,
so remove '--default HEAD' from the arguments to git rev-list. They
are unnecessary.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 git-filter-branch.sh |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 5e3fe70..25f18f8 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -228,11 +228,10 @@ mkdir ../map || die "Could not create map/ directory"
 
 case "$filter_subdir" in
 "")
-	git rev-list --reverse --topo-order --default HEAD \
-		--parents "$@"
+	git rev-list --reverse --topo-order --parents "$@"
 	;;
 *)
-	git rev-list --reverse --topo-order --default HEAD \
+	git rev-list --reverse --topo-order \
 		--parents --full-history "$@" -- "$filter_subdir"
 esac > ../revs || die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")
-- 
1.5.4.rc5.14.gaa8fc
