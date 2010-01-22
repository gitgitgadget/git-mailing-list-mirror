From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/3] rebase -i: Avoid non-portable "test X -a Y"
Date: Fri, 22 Jan 2010 10:22:29 +0100
Message-ID: <0c2c17066d3bc369e4fb8f96839f63b50606fd5f.1264151435.git.mhagger@alum.mit.edu>
References: <cover.1264151435.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	tarmigan+git@gmail.com, j.sixt@viscovery.net,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 10:23:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYFjl-0002zJ-5F
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 10:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074Ab0AVJX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 04:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753066Ab0AVJXY
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 04:23:24 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:53981 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab0AVJXX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 04:23:23 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1CC41.dip.t-dialin.net [79.193.204.65])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0M9Mb4O014743;
	Fri, 22 Jan 2010 10:22:44 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1264151435.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1264151435.git.mhagger@alum.mit.edu>
References: <cover.1264151435.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137752>

Reported by: Eric Blake <ebb9@byu.net>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e551906..c2f6089 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -235,7 +235,7 @@ pick_one () {
 	parent_sha1=$(git rev-parse --verify $sha1^) ||
 		die "Could not get the parent of $sha1"
 	current_sha1=$(git rev-parse --verify HEAD)
-	if test -z "$no_ff" -a "$current_sha1" = "$parent_sha1"
+	if test -z "$no_ff" && test "$current_sha1" = "$parent_sha1"
 	then
 		output git reset --hard $sha1
 		output warn Fast-forward to $(git rev-parse --short $sha1)
-- 
1.6.6
