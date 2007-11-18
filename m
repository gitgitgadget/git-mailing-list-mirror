From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Fix warning about bitfield in struct ref
Date: Sun, 18 Nov 2007 04:31:37 -0500
Message-ID: <20071118093137.GA2196@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 10:32:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItgVU-0006Du-Mt
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 10:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbXKRJbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 04:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbXKRJbm
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 04:31:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55125 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbXKRJbl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 04:31:41 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1ItgVA-00075s-Ga; Sun, 18 Nov 2007 04:31:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A2ECF20FBAE; Sun, 18 Nov 2007 04:31:37 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65351>

cache.h:503: warning: type of bit-field 'force' is a GCC extension
cache.h:504: warning: type of bit-field 'merge' is a GCC extension
cache.h:505: warning: type of bit-field 'nonfastforward' is a GCC extension
cache.h:506: warning: type of bit-field 'deletion' is a GCC extension

So we change it to an 'unsigned int' which is not a GCC extension.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 cache.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index ba9178f..65e019e 100644
--- a/cache.h
+++ b/cache.h
@@ -500,10 +500,10 @@ struct ref {
 	struct ref *next;
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
-	unsigned char force : 1;
-	unsigned char merge : 1;
-	unsigned char nonfastforward : 1;
-	unsigned char deletion : 1;
+	unsigned int force:1,
+		merge:1,
+		nonfastforward:1,
+		deletion:1;
 	enum {
 		REF_STATUS_NONE = 0,
 		REF_STATUS_OK,
-- 
1.5.3.5.1794.g083e
