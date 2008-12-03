From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 3/5] pull: use git rev-parse -q
Date: Wed,  3 Dec 2008 14:26:50 +0100
Message-ID: <8c4e8eda234e8e37d4a7a3ac43ffc7738e6fac4b.1228310570.git.vmiklos@frugalware.org>
References: <cover.1228310570.git.vmiklos@frugalware.org>
 <4858dc4d5d92276fa96a8fb45b02adaae57dcf26.1228310570.git.vmiklos@frugalware.org>
 <73193271279140eda04ec46097936e64f3c526d6.1228310570.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 14:28:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7rm1-0000KC-R8
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 14:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbYLCN05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 08:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbYLCN04
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 08:26:56 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46168 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbYLCN0y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 08:26:54 -0500
Received: from vmobile.example.net (dsl5401C5DE.pool.t-online.hu [84.1.197.222])
	by yugo.frugalware.org (Postfix) with ESMTPA id B8621446CDC;
	Wed,  3 Dec 2008 14:26:52 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 6609619D92A; Wed,  3 Dec 2008 14:26:53 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <73193271279140eda04ec46097936e64f3c526d6.1228310570.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1228310570.git.vmiklos@frugalware.org>
References: <cover.1228310570.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102254>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 git-pull.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 1cac898..2c7f432 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -121,13 +121,13 @@ test true = "$rebase" && {
 	test -z "$origin" && origin=$(get_default_remote)
 	reflist="$(get_remote_refs_for_fetch "$@" 2>/dev/null |
 		sed "s|refs/heads/\(.*\):|\1|")" &&
-	oldremoteref="$(git rev-parse --verify \
-		"refs/remotes/$origin/$reflist" 2>/dev/null)"
+	oldremoteref="$(git rev-parse -q --verify \
+		"refs/remotes/$origin/$reflist")"
 }
-orig_head=$(git rev-parse --verify HEAD 2>/dev/null)
+orig_head=$(git rev-parse -q --verify HEAD)
 git fetch $verbosity --update-head-ok "$@" || exit 1
 
-curr_head=$(git rev-parse --verify HEAD 2>/dev/null)
+curr_head=$(git rev-parse -q --verify HEAD)
 if test -n "$orig_head" && test "$curr_head" != "$orig_head"
 then
 	# The fetch involved updating the current branch.
-- 
1.6.0.4
