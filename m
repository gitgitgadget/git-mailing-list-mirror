From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/18] rebase -i: Inline expression
Date: Thu, 14 Jan 2010 06:54:42 +0100
Message-ID: <487578e19c491360d2a957603db778faa4e3188d.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 06:56:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIga-0002Vo-Gl
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524Ab0ANFzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755481Ab0ANFzU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:55:20 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58587 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469Ab0ANFzS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:55:18 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1EBF4.dip.t-dialin.net [79.193.235.244])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E5t4bI001912;
	Thu, 14 Jan 2010 06:55:14 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136935>

Inline expression when generating output rather than overwriting the
"sha1" local variable with a short SHA1.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-rebase--interactive.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c6174bb..3b65cdf 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -169,8 +169,7 @@ pick_one () {
 	if test -z "$no_ff" -a "$current_sha1" = "$parent_sha1"
 	then
 		output git reset --hard $sha1
-		sha1=$(git rev-parse --short $sha1)
-		output warn Fast-forward to $sha1
+		output warn Fast-forward to $(git rev-parse --short $sha1)
 	else
 		output git cherry-pick "$@"
 	fi
-- 
1.6.6
