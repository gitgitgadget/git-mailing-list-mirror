From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 5/10] Move printing of the commit info line inside the loop
Date: Sat, 4 Jun 2005 16:41:05 +0200
Message-ID: <20050604144105.GI12615@diku.dk>
References: <20050604143831.GD12615@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 16:38:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeZme-0005Wt-Fq
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 16:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVFDOlM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 10:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVFDOlM
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 10:41:12 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:17407 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261358AbVFDOlG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 10:41:06 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 4D1C56E2477; Sat,  4 Jun 2005 16:40:25 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 15FAD6E2448; Sat,  4 Jun 2005 16:40:25 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 3258E61FE0; Sat,  4 Jun 2005 16:41:05 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050604143831.GD12615@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Printing of all the log headers are now handled the same place.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 cg-log |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -176,7 +176,6 @@ $revls | $revsort | while read time comm
 	if [ "$user" ]; then
 		git-cat-file commit $commit | grep -e '^author ' -e '^committer ' | grep -qi "$user" || continue
 	fi
-	echo $colheader""commit ${commit%:*} $coldefault;
 	git-cat-file commit $commit | \
 		while read key rest; do
 			trap exit SIGPIPE
@@ -194,6 +193,7 @@ $revls | $revsort | while read time comm
 				parents[${#parents[@]}]="$rest"
 				;;
 			"")
+				echo ${colheader}commit ${commit%:*} $coldefault
 				echo ${colheader}tree $tree $coldefault
 
 				for parent in "${parents[@]}"; do
-- 
Jonas Fonseca
