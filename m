From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Small regresson when series file is empty.
Date: Thu, 14 Jun 2007 15:20:23 +0200
Message-ID: <11818272231872-git-send-email-madcoder@debian.org>
References: <11818254621527-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Jun 14 15:20:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HypFS-0001y2-Uk
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 15:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbXFNNUZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 09:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbXFNNUZ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 09:20:25 -0400
Received: from pan.madism.org ([88.191.52.104]:53121 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345AbXFNNUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 09:20:25 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 43D20DA82;
	Thu, 14 Jun 2007 15:20:24 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 075129181D; Thu, 14 Jun 2007 15:20:24 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11818254621527-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50199>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 guilt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/guilt b/guilt
index f77c050..58df606 100755
--- a/guilt
+++ b/guilt
@@ -246,8 +246,9 @@ head_check()
 # usage: series_insert_patch <patchname>
 series_insert_patch()
 {
-	awk -v top="`get_top`" -v new="$1" '{
-			if (top == "" && NR == 1) print new;
+	awk -v top="`get_top`" -v new="$1" \
+		'BEGIN{if (top == "") print new;}
+		{
 			print $0;
 			if (top != "" && top == $0) print new;
 		}' "$series" > "$series.tmp"
-- 
1.5.2.1
