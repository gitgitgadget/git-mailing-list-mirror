From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-clone.txt: Adjust note to --shared for new pruning behavior
 of git-gc
Date: Thu, 03 Apr 2008 13:26:13 -0500
Message-ID: <47F52145.306@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 20:30:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhUCg-0001bB-Qr
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 20:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbYDCS3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 14:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754168AbYDCS3o
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 14:29:44 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49899 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320AbYDCS3n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 14:29:43 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m33IQEl0028953;
	Thu, 3 Apr 2008 13:26:14 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 3 Apr 2008 13:26:14 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-OriginalArrivalTime: 03 Apr 2008 18:26:14.0044 (UTC) FILETIME=[32E4DDC0:01C895B8]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15820001
X-TM-AS-Result: : Yes--9.829000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTE1MDY2OC03MDQ5?=
	=?us-ascii?B?MjctMTA2NDIwLTcwNjQ1NC03MDE3MTktNzAwMTYwLTcwNDQxMC03?=
	=?us-ascii?B?MDcxMTktMTg4MDE5LTE4ODE5OC03MDA4NDktNzAyMzU4LTcwMTQ1?=
	=?us-ascii?B?NS03MTE0MzItNzAyMDIwLTcxMTk1My03MDUxMDItNzA0NDk2LTcw?=
	=?us-ascii?B?NjI0OS03MDYxNTAtNzA4MzI4LTcwMDY5My03MDczMjUtNzEwNDQy?=
	=?us-ascii?B?LTcwMjEzMS03MDIxNTAtNzA5MDUwLTE0ODAzOS0xNDgwNTE=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78768>

Since git-gc now always calls prune, even with --auto, unreferenced objects
may be removed by more operations than just git-gc. This is important for
clones created using --shared or --reference.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Documentation/git-clone.txt |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 9758243..d3ab00b 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -65,10 +65,12 @@ OPTIONS
 +
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand what it does. If you clone your
-repository using this option, then delete branches in the
-source repository and then run linkgit:git-gc[1] using the
-'--prune' option in the source repository, it may remove
-objects which are referenced by the cloned repository.
+repository using this option and then delete branches in the
+source repository, some objects may become unreferenced (or dangling).
+These objects may be removed by normal git operations (such as git-commit[1])
+which automatically call git-gc[1]. If these objects are removed and
+were referenced by the cloned repository, then the cloned repository
+will become corrupt.
 
 
 
@@ -79,6 +81,8 @@ objects which are referenced by the cloned repository.
 	an already existing repository as an alternate will
 	require fewer objects to be copied from the repository
 	being cloned, reducing network and local storage costs.
++
+*NOTE*: see NOTE to --shared option.
 
 --quiet::
 -q::
-- 
1.5.5.rc3
