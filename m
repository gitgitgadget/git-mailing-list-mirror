From: Tony Finch <dot@dotat.at>
Subject: [PATCH] git-prompt: preserve command exit status
Date: Mon, 22 Dec 2014 14:30:03 +0000
Message-ID: <alpine.LSU.2.00.1412221429490.28934@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 15:30:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y33zw-0007i5-9E
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 15:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074AbaLVOaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 09:30:07 -0500
Received: from ppsw-40.csi.cam.ac.uk ([131.111.8.140]:39115 "EHLO
	ppsw-40.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067AbaLVOaF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 09:30:05 -0500
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:43976)
	by ppsw-40.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:25)
	with esmtpa (EXTERNAL:fanf2) id 1Y33zn-000062-kU (Exim 4.82_3-c0e5623) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 22 Dec 2014 14:30:03 +0000
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1Y33zn-0004vd-BC (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 22 Dec 2014 14:30:03 +0000
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261645>

Signed-off-by: Tony Finch <dot@dotat.at>
---
 contrib/completion/git-prompt.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index c5473dc..5fe69d0 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -288,6 +288,7 @@ __git_eread ()
 # In this mode you can request colored hints using GIT_PS1_SHOWCOLORHINTS=true
 __git_ps1 ()
 {
+	local exit=$?
 	local pcmode=no
 	local detached=no
 	local ps1pc_start='\u@\h:\w '
@@ -511,4 +512,7 @@ __git_ps1 ()
 	else
 		printf -- "$printf_format" "$gitstring"
 	fi
+
+	# preserve exit status
+	return $exit
 }
-- 
2.1.0.rc1.12.g1e9b79d
