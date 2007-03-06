From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Fix bash completion to not garble the screen with an error
	message.
Date: Tue, 06 Mar 2007 21:18:44 +0100
Message-ID: <20070306201726.15059.68223.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 21:19:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOg7c-0002az-Vz
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 21:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbXCFUSx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 15:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbXCFUSx
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 15:18:53 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:47066 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbXCFUSw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 15:18:52 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 6BA1A81CA;
	Tue,  6 Mar 2007 21:18:51 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id EA4B11F095;
	Tue,  6 Mar 2007 21:18:44 +0100 (CET)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41591>


Maybe we could refuse to complete further when the command was not
recognized, but at least this fix avoids the annoying behaviour.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stgit-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/stgit-completion.bash b/contrib/stgit-completion.bash
index 8a027bf..18645dc 100644
--- a/contrib/stgit-completion.bash
+++ b/contrib/stgit-completion.bash
@@ -99,7 +99,7 @@ _all_other_patches ()
 # List the command options
 _cmd_options ()
 {
-    stg $1 --help | grep -e " --[A-Za-z]" | sed -e "s/.*\(--[^ =]\+\).*/\1/"
+    stg $1 --help 2>/dev/null | grep -e " --[A-Za-z]" | sed -e "s/.*\(--[^ =]\+\).*/\1/"
 }
 
 # Generate completions for patches and patch ranges from the given
