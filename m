From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 5/5] stash: change built-in ref to 'stash' instead of 'refs/stash'
Date: Mon, 12 Oct 2009 23:06:07 +0200
Message-ID: <548bc3a41c03a049e782d5d04a34c3b26c0897d2.1255380039.git.trast@student.ethz.ch>
References: <cover.1255380039.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>,
	<git@vger.kernel.org>
To: Jef Driesen <jefdriesen@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 23:14:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxSDk-0002of-4L
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 23:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933163AbZJLVIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 17:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933156AbZJLVIE
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:08:04 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:26795 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933144AbZJLVID (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:08:03 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 12 Oct
 2009 23:06:45 +0200
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 12 Oct
 2009 23:06:46 +0200
X-Mailer: git-send-email 1.6.5.64.g01287
In-Reply-To: <cover.1255380039.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130071>

'git stash list' now always shows 'refs/stash@{...}' instead of
'stash@{...}', because that's what we specify for the ref.

Since git checks .git/$ref, .git/refs/$ref and only then
.git/refs/{branches,tags,remotes}, we can drop the prefix.  This only
affects people who have .git/stash, who were never able to refer to
their stashes by stash@{...}.  (Sadly, now they won't be able to use
git-stash anymore at all.)

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 08a7669..8bf464b 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -19,7 +19,7 @@ cd_to_toplevel
 TMP="$GIT_DIR/.git-stash.$$"
 trap 'rm -f "$TMP-*"' 0
 
-ref_stash=refs/stash
+ref_stash=stash
 
 if git config --get-colorbool color.interactive; then
        help_color="$(git config --get-color color.interactive.help 'red bold')"
-- 
1.6.5.64.g01287
