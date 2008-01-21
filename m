From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] send-email, fix breakage in combination with --compose
Date: Mon, 21 Jan 2008 20:57:46 +0100
Message-ID: <1200945466-21154-2-git-send-email-hendeby@isy.liu.se>
References: <m2y7aj9glo.fsf@userprimary.net>
 <1200945466-21154-1-git-send-email-hendeby@isy.liu.se>
Cc: git@vger.kernel.org, Gustaf Hendeby <hendeby@isy.liu.se>
To: Seth Falcon <seth@userprimary.net>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 21 20:58:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH2mj-0003Re-FL
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 20:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbYAUT5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 14:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbYAUT5v
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 14:57:51 -0500
Received: from bogotron.isy.liu.se ([130.236.48.26]:53278 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbYAUT5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 14:57:49 -0500
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 781A925AA1;
	Mon, 21 Jan 2008 20:57:48 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 04762-01; Thu,  3 Jan 2008 00:53:55 +0100 (MET)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id EB68325A9F;
	Mon, 21 Jan 2008 20:57:46 +0100 (MET)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id B3F1E1779B; Mon, 21 Jan 2008 20:57:46 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc4.1.gbdcdb
In-Reply-To: <1200945466-21154-1-git-send-email-hendeby@isy.liu.se>
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71321>

This fixes the subtile bug in git send-email that was introduced into
git send-email with

commit aa54892f5ada8282643dc7387b33261c7135d784
send-email: detect invocation errors earlier

causing no patches to be sent out if the --compose flag was used.

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6c72952..a1a9d14 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -462,7 +462,7 @@ EOT
 		exit(0);
 	}
 
-	@files = ($compose_filename . ".final");
+	@files = ($compose_filename . ".final", @files);
 }
 
 # Variables we set as part of the loop over files
-- 
1.5.4.rc4.1.gbdcdb
