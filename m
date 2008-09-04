From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] Avoid warning when bisecting a merge
Date: Thu,  4 Sep 2008 23:02:30 +0200
Message-ID: <1220562150-19962-1-git-send-email-hendeby@isy.liu.se>
Cc: chriscool@tuxfamily.org, gitster@pobox.com,
	Gustaf Hendeby <hendeby@isy.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 23:03:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbLzf-0007W6-Rt
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 23:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbYIDVCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 17:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbYIDVCd
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 17:02:33 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:54983 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbYIDVCc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 17:02:32 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 0441F25A44;
	Thu,  4 Sep 2008 23:02:31 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 21585-07; Fri,  4 Jul 2008 02:08:56 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 5172625A49;
	Thu,  4 Sep 2008 23:02:30 +0200 (MEST)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id 2EA732ED78; Thu,  4 Sep 2008 23:02:30 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.320.ga0f13.dirty
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94958>

Trying to compare an empty string as a number results in an error,
hence make sure checkout_done is set before using it.

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---

This one should go on top of cc/bisect.

/Gustaf

 git-bisect.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 69a9a56..05d14b3 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -437,6 +437,7 @@ bisect_next() {
 		"refs/bisect/skip-*" | tr '\012' ' ') &&
 
 	# Maybe some merge bases must be tested first
+	checkout_done=0
 	check_good_are_ancestors_of_bad "$bad" "$good" "$skip" || exit
 	test "$checkout_done" -eq "1" && checkout_done='' && return
 
-- 
1.6.0.1.320.ga0f13.dirty
