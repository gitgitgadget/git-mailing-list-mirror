From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH 2/9] fetch: Properly initialize refspec on stack
Date: Fri, 12 Mar 2010 23:27:33 +0100
Message-ID: <f747d7538f2a2bbdb48c9902298fa87691097eba.1268913163.git.agruen@suse.de>
References: <cover.1268913163.git.agruen@suse.de>
	<f2bf11648d2cfb58e348d2c8caffa841012fd994.1268913163.git.agruen@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 18 12:56:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsEKe-0002C7-A9
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 12:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076Ab0CRLzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 07:55:43 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50443 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752816Ab0CRLz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 07:55:27 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 909F68980B
	for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:55:26 +0100 (CET)
In-Reply-To: <f2bf11648d2cfb58e348d2c8caffa841012fd994.1268913163.git.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142464>

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 builtin/fetch.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 77031e2..660af84 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -107,10 +107,8 @@ static void add_merge_config(struct ref **head,
 		 * there is no entry in the resulting FETCH_HEAD marked
 		 * for merging.
 		 */
+		memset(&refspec, 0, sizeof(refspec));
 		refspec.src = branch->merge[i]->src;
-		refspec.dst = NULL;
-		refspec.pattern = 0;
-		refspec.force = 0;
 		get_fetch_map(remote_refs, &refspec, tail, 1);
 		for (rm = *old_tail; rm; rm = rm->next)
 			rm->merge = 1;
-- 
1.7.0.2.273.gc2413
