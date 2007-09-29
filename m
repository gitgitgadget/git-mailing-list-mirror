From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/1] --color and --no-color git-log options don't need diffs to be computed.
Date: Sat, 29 Sep 2007 14:35:56 +0200
Message-ID: <20070929123724.01BB045EC@madism.org>
References: <e5bfff550709290429n291968f2md8068a945ff7a79e@mail.gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 14:37:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbbZg-0003FD-A8
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 14:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791AbXI2Mh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 08:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755262AbXI2Mh1
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 08:37:27 -0400
Received: from pan.madism.org ([88.191.52.104]:48828 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755523AbXI2Mh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 08:37:26 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 88441225F1;
	Sat, 29 Sep 2007 14:37:24 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 01BB045EC; Sat, 29 Sep 2007 14:37:23 +0200 (CEST)
In-Reply-To: <e5bfff550709290429n291968f2md8068a945ff7a79e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59462>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

 revision.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 33d092c..0dee835 100644
--- a/revision.c
+++ b/revision.c
@@ -1209,8 +1209,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 
 			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
 			if (opts > 0) {
-				if (strcmp(argv[i], "-z"))
-					revs->diff = 1;
+				revs->diff = strcmp(argv[i], "-z")
+					&& strcmp(argv[i], "--color")
+					&& strcmp(argv[i], "--no-color");
 				i += opts - 1;
 				continue;
 			}
-- 
1.5.3.2.1110.g61a7cd-dirty
