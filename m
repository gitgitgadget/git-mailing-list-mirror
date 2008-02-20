From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] checkout: obey -q option
Date: Thu, 21 Feb 2008 00:08:59 +0100
Message-ID: <1203548939-17350-1-git-send-email-hendeby@isy.liu.se>
Cc: gitster@pobox.com, Gustaf Hendeby <hendeby@isy.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 00:09:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRy4M-00015s-9V
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 00:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbYBTXJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 18:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbYBTXJE
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 18:09:04 -0500
Received: from bogotron.isy.liu.se ([130.236.48.26]:53877 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbYBTXJD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 18:09:03 -0500
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id C833B25AA7;
	Thu, 21 Feb 2008 00:09:00 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 29967-02; Thu, 21 Feb 2008 00:09:00 +0100 (MET)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 20ED025A9F;
	Thu, 21 Feb 2008 00:09:00 +0100 (MET)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id 15477177A1; Thu, 21 Feb 2008 00:09:00 +0100 (CET)
X-Mailer: git-send-email 1.5.4.2.232.g08e5
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74565>

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---

This makes the new tracking output introduced by
79a1e6b432d7d7ffaf2079d4cf895583502ca923 (checkout: notice when the
switched branch is behind or forked) obey the silence option.  FWIW, I
would really prefer only to get the one line informing me that I could
do a fast-forward or will need a merge unless I specifically ask for
more.  Is that something worth exploring?  Right now checkout is a bit
too talkative for my taste.

/Gustaf

 builtin-checkout.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index b1820a4..104ce4f 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -402,7 +402,7 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 	}
 	remove_branch_state();
 	strbuf_release(&msg);
-	if (new->path || !strcmp(new->name, "HEAD"))
+	if (!opts->quiet && (new->path || !strcmp(new->name, "HEAD")))
 		adjust_to_tracking(new, opts);
 }
 
-- 
1.5.4.2.232.g08e5
