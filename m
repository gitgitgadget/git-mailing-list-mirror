From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 3/5] stash: Use new %g/%G formats instead of sed
Date: Mon, 12 Oct 2009 23:06:05 +0200
Message-ID: <77e591b80021efc265fea1a101ce6b7124ea832e.1255380039.git.trast@student.ethz.ch>
References: <cover.1255380039.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>,
	<git@vger.kernel.org>
To: Jef Driesen <jefdriesen@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 23:14:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxSDi-0002of-CF
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 23:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933109AbZJLVHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 17:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933103AbZJLVHr
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:07:47 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:26795 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933096AbZJLVHr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:07:47 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 12 Oct
 2009 23:06:45 +0200
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 12 Oct
 2009 23:06:45 +0200
X-Mailer: git-send-email 1.6.5.64.g01287
In-Reply-To: <cover.1255380039.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130076>

With the new formats, we can rewrite 'git stash list' in terms of an
appropriate pretty format, instead of hand-editing with sed.  This has
the advantage that it obeys the normal settings for git-log, notably
the pager.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-stash.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 4febbbf..8fbf10a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -205,8 +205,7 @@ have_stash () {
 
 list_stash () {
 	have_stash || return 0
-	git log --no-color --pretty=oneline -g "$@" $ref_stash -- |
-	sed -n -e 's/^[.0-9a-f]* refs\///p'
+	git log --format="%g: %G" -g "$@" $ref_stash
 }
 
 show_stash () {
-- 
1.6.5.64.g01287
