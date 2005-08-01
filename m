From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Do not rely on a sane wc
Date: Mon, 1 Aug 2005 16:32:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.20050801163156.12985@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 01 16:34:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzbMD-0000Nh-H7
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 16:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVHAOdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Aug 2005 10:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVHAOdY
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Aug 2005 10:33:24 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:41404 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261694AbVHAOci (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2005 10:32:38 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 7D27EE23D6
	for <git@vger.kernel.org>; Mon,  1 Aug 2005 16:32:37 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 62E86B182C
	for <git@vger.kernel.org>; Mon,  1 Aug 2005 16:32:37 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 404E2B2FDC
	for <git@vger.kernel.org>; Mon,  1 Aug 2005 16:32:37 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 289DDE23D7
	for <git@vger.kernel.org>; Mon,  1 Aug 2005 16:32:37 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Some implementations of wc pad the line number with white space, which
expr does not grok as a number.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

 git-format-patch-script |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

da0488e94f7f949cbfce7422980eb2fe38166b9a
diff --git a/git-format-patch-script b/git-format-patch-script
--- a/git-format-patch-script
+++ b/git-format-patch-script
@@ -109,7 +109,7 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x4
 stripCommitHead='/^'"$_x40"' (from '"$_x40"')$/d'

 git-rev-list --merge-order "$junio" "^$linus" >$series
-total=`wc -l <$series`
+total=`wc -l <$series | tr -dc "[0-9]"`
 i=$total
 while read commit
 do
