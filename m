From: Stefan Haller <lists@haller-berlin.de>
Subject: [PATCH] gitk: Prevent the text pane from becoming editable
Date: Sun, 14 Nov 2010 13:21:50 +0100
Message-ID: <1289737310-33265-1-git-send-email-lists@haller-berlin.de>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 14 13:22:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHbb1-0005Kq-9H
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 13:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394Ab0KNMWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 07:22:06 -0500
Received: from mail.ableton.net ([62.96.12.117]:55780 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755332Ab0KNMWE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 07:22:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-Id:Date:Subject:Cc:To:From; bh=SIa/lF0sSw7WTuCQwbiPywLudHNY3c0cXZNANCOjQGY=;
	b=Q28eB8D9NVinpj4cJmiAAgjzhfZLI9sw7i0gkjFokadxrc1k3QkMOGLN1zTpN3r8MSv8GAg5kxcfM2NNt3s+LBCrfTJHNFD3N9rQDdxWF5Si+0kQ9Y7TqdDdYlVuHdDigmbpPl1ZOSIEnJlqEA9eLhSzq0oYG6vattpZ6MDZnTA=;
Received: from dslb-088-074-017-003.pools.arcor-ip.net ([88.74.17.3] helo=localhost.localdomain)
	by mail.ableton.net with esmtpa (Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1PHbQf-0002en-3K; Sun, 14 Nov 2010 13:11:29 +0100
X-Mailer: git-send-email 1.7.3.2.154.gcfae0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161406>

From: Stefan Haller <stefan@haller-berlin.de>

When setting the "Patch/Tree" radio buttons to "Tree" and
clicking on a file to display it, the text pane would
accidentally become editable (because of the early return
in getblobline).

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
 gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 45e3380..260be1b 100755
--- a/gitk
+++ b/gitk
@@ -7303,6 +7303,7 @@ proc getblobline {bf id} {
 			    [lindex [split $commentend .] 0]}]
 	    mark_ctext_line $lnum
 	}
+	$ctext config -state disabled
 	return 0
     }
     $ctext config -state disabled
-- 
1.7.3.2.154.gcfae0
