From: Chris Frey <cdfrey@foursquare.net>
Subject: [PATCH] Documentation/git-repack.txt: document new -A behaviour
Date: Thu, 15 May 2008 22:37:31 -0400
Message-ID: <20080516023731.GA30796@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 16 04:38:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwpq6-0008GU-Ku
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 04:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbYEPCho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 22:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbYEPCho
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 22:37:44 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:43671 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbYEPChn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 22:37:43 -0400
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id m4G2bVjF031932;
	Thu, 15 May 2008 22:37:31 -0400
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82252>

Add paragraph for the -A option, and describe the new behaviour
that makes unreachable objects loose.

Signed-off-by: Chris Frey <cdfrey@foursquare.net>
---

	This is the second half of the split-up prune/repack
	documentation patch, as I see the prune patch was accepted.

	Thanks,
	- Chris

 Documentation/git-repack.txt |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 3d95749..906d3c7 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -8,7 +8,7 @@ git-repack - Pack unpacked objects in a repository
 
 SYNOPSIS
 --------
-'git-repack' [-a] [-d] [-f] [-l] [-n] [-q] [--window=N] [--depth=N]
+'git-repack' [-a] [-A] [-d] [-f] [-l] [-n] [-q] [--window=N] [--depth=N]
 
 DESCRIPTION
 -----------
@@ -37,6 +37,18 @@ OPTIONS
 	leaves behind, but `git fsck --full` shows as
 	dangling.
 
+-A::
+	Same as `-a`, but any unreachable objects in a previous
+	pack become loose, unpacked objects, instead of being
+	left in the old pack.  Unreachable objects are never
+	intentionally added to a pack, even when repacking.
+	When used with '-d', this option
+	prevents unreachable objects from being immediately
+	deleted by way of being left in the old pack and then
+	removed.  Instead, the loose unreachable objects
+	will be pruned according to normal expiry rules
+	with the next linkgit:git-gc[1].
+
 -d::
 	After packing, if the newly created packs make some
 	existing packs redundant, remove the redundant packs.
-- 
1.5.4.4
