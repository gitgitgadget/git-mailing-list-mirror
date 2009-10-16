From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 4/5] stash list: use new %g formats instead of sed
Date: Fri, 16 Oct 2009 16:20:36 +0200
Message-ID: <1d2a75bdb94691839f4a8ce0d1712d2bac6e405d.1255701207.git.trast@student.ethz.ch>
References: <cover.1255701207.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 16 16:25:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MynkP-0008Gh-IM
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 16:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760197AbZJPOXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 10:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760159AbZJPOXI
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 10:23:08 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:34132 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760144AbZJPOXI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 10:23:08 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 16:21:31 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 16:21:10 +0200
X-Mailer: git-send-email 1.6.5.116.g4aaa3
In-Reply-To: <cover.1255701207.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130497>

With the new formats, we can rewrite 'git stash list' in terms of an
appropriate pretty format, instead of hand-editing with sed.  This has
the advantage that it obeys the normal settings for git-log, notably
the pager.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-stash.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 4febbbf..f8847c1 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -205,8 +205,7 @@ have_stash () {
 
 list_stash () {
 	have_stash || return 0
-	git log --no-color --pretty=oneline -g "$@" $ref_stash -- |
-	sed -n -e 's/^[.0-9a-f]* refs\///p'
+	git log --format="%gd: %gs" -g "$@" $ref_stash --
 }
 
 show_stash () {
-- 
1.6.5.116.gfe4b9
