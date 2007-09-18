From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/5] Use 'unsigned:1' when we mean boolean options
Date: Tue, 18 Sep 2007 04:55:00 -0400
Message-ID: <20070918085500.GE5390@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:55:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXYry-0001jx-Mo
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 10:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbXIRIzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 04:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753324AbXIRIzJ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 04:55:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52382 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317AbXIRIzG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 04:55:06 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IXYrB-00068B-BW; Tue, 18 Sep 2007 04:54:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7D21F20FBAE; Tue, 18 Sep 2007 04:55:00 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58550>

These options are all strictly boolean (true/false).  Its easier to
document this implicitly by making their storage type a single bit.
There is no compelling memory space reduction reason for this change,
it just makes the structure definition slightly more readable.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 fetch-pack.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.h b/fetch-pack.h
index cdcd84f..ad13076 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -4,14 +4,14 @@
 struct fetch_pack_args
 {
 	const char *uploadpack;
-	int quiet;
-	int keep_pack;
 	int unpacklimit;
-	int use_thin_pack;
-	int fetch_all;
-	int verbose;
 	int depth;
-	int no_progress;
+	unsigned quiet:1,
+		keep_pack:1,
+		use_thin_pack:1,
+		fetch_all:1,
+		verbose:1,
+		no_progress:1;
 };
 
 void setup_fetch_pack(struct fetch_pack_args *args);
-- 
1.5.3.1.1000.g7319b
