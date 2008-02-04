From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 4/4] git-submodule: prepare for the .git-file
Date: Mon,  4 Feb 2008 21:59:21 +0100
Message-ID: <1202158761-31211-5-git-send-email-hjemli@gmail.com>
References: <1202158761-31211-1-git-send-email-hjemli@gmail.com>
 <1202158761-31211-2-git-send-email-hjemli@gmail.com>
 <1202158761-31211-3-git-send-email-hjemli@gmail.com>
 <1202158761-31211-4-git-send-email-hjemli@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 22:02:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM8S1-0008Ne-0X
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 22:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbYBDVA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 16:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752418AbYBDVA6
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 16:00:58 -0500
Received: from mail42.e.nsc.no ([193.213.115.42]:46870 "EHLO mail42.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305AbYBDVA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 16:00:57 -0500
Received: from localhost.localdomain (ti231210a341-0149.bb.online.no [88.88.168.149])
	by mail42.nsc.no (8.13.8/8.13.5) with ESMTP id m14L0REg021902;
	Mon, 4 Feb 2008 22:00:31 +0100 (MET)
X-Mailer: git-send-email 1.5.4.5.g25d066
In-Reply-To: <1202158761-31211-4-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72565>

When git-submodule tried to detect 'active' submodules, it checked for the
existence of a directory named '.git'. This isn't good enough now that .git
can be a file pointing to the real $GIT_DIR so the tests are changed to
reflect this.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git-submodule.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index a6aaf40..220d64c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -288,7 +288,7 @@ cmd_update()
 			continue
 		fi
 
-		if ! test -d "$path"/.git
+		if ! test -e "$path"/.git
 		then
 			module_clone "$path" "$url" || exit
 			subsha1=
@@ -362,7 +362,7 @@ cmd_status()
 	do
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
-		if test -z "url" || ! test -d "$path"/.git
+		if test -z "url" || ! test -e "$path"/.git
 		then
 			say "-$sha1 $path"
 			continue;
-- 
1.5.4.5.g25d066
