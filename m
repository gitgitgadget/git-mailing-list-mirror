From: Mathias Lafeldt <misfire@debugon.org>
Subject: [PATCH 2/3] GIT-VERSION-GEN: tweak processing of version file
Date: Fri, 22 Oct 2010 13:24:21 +0200
Message-ID: <4CC17465.9040100@debugon.org>
References: <cover.1287746107.git.misfire@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 13:24:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Fje-0003pR-DK
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 13:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880Ab0JVLYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 07:24:25 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:51078 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755751Ab0JVLYY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 07:24:24 -0400
Received: from [192.168.2.102] (dslb-088-071-188-252.pools.arcor-ip.net [88.71.188.252])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0M0MwL-1OLYUd25W9-00uZvo; Fri, 22 Oct 2010 13:24:23 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100915 Thunderbird/3.0.8
In-Reply-To: <cover.1287746107.git.misfire@debugon.org>
X-Provags-ID: V02:K0:WbmVaQU1Kh1YnaWYrlimFl3RLhUvozA4jgxl3CwgxkB
 KbY+S2pzyA0l2he2OHKz8S7bDKoVoHGnTR2mkLvVppG62P1CC8
 yzLhSowPpiaRg9E0aW2oEfyDW2zOYzREh9+6QN9VP18DQBygPf
 0VKWbszaoPKzsdEVQ/tnd04861/REstxNfPJXwUL7ldWL1v9VN
 UNt36zqV4YsDePH3z0y5u/FsRa9WqXiUvEFgSFArkc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159679>

- check for version file with "test -r"
- read version file using shell builtin "read" rather than "cat"

Signed-off-by: Mathias Lafeldt <misfire@debugon.org>
---
 GIT-VERSION-GEN |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 73d5cf9..427d5d6 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -8,9 +8,9 @@ LF='
 
 # First see if there is a version file (included in release tarballs),
 # then try git-describe, then default.
-if test -f version
+if test -r version
 then
-	VN=$(cat version) || VN="$DEF_VER"
+	read VN 2>/dev/null < version || VN="$DEF_VER"
 elif test -d .git -o -f .git &&
 	VN=$(git describe --match "v[0-9]*" --abbrev=4 --dirty 2>/dev/null) &&
 	case "$VN" in
-- 
1.7.3.2
