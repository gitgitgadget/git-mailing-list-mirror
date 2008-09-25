From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] git-gui: Help identify aspell version on Windows too
Date: Thu, 25 Sep 2008 23:31:22 +0200
Message-ID: <1222378282-21757-1-git-send-email-hendeby@isy.liu.se>
Cc: spearce@spearce.org, Gustaf Hendeby <hendeby@isy.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 23:32:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiyRu-0007YK-Cc
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 23:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997AbYIYVbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 17:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753602AbYIYVbZ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 17:31:25 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:59838 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbYIYVbY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 17:31:24 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 19AF225947;
	Thu, 25 Sep 2008 23:31:23 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 16109-08; Fri,  4 Jul 2008 02:08:54 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 6D32C2591C;
	Thu, 25 Sep 2008 23:31:22 +0200 (MEST)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id 48FF22ED78; Thu, 25 Sep 2008 23:31:22 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.509.g4def
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96805>

On windows, git gui fails to correctly extract the aspell version
(experienced with aspell version 0.50.3) due to scilent white space at
the end of the version string.  Trim the obtained version string to
work around this.

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---
 lib/spellcheck.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/spellcheck.tcl b/lib/spellcheck.tcl
index 78f344f..c8cc030 100644
--- a/lib/spellcheck.tcl
+++ b/lib/spellcheck.tcl
@@ -80,7 +80,7 @@ method _connect {pipe_fd} {
 		error_popup [strcat [mc "Unrecognized spell checker"] ":\n\n$s_version"]
 		return
 	}
-	set s_version [string range $s_version 5 end]
+			set s_version [string range [string trim $s_version] 5 end]
 	regexp \
 		{International Ispell Version .* \(but really (Aspell .*?)\)$} \
 		$s_version _junk s_version
-- 
1.6.0.2.509.g4def
