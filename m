From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v3 3/8] Ensure tail pointer gets setup correctly when we fetch HEAD only
Date: Sun, 2 Mar 2008 21:34:51 -0500
Message-ID: <20080303023451.GC9966@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 03:35:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW0Wk-0001YM-3w
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 03:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266AbYCCCey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 21:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419AbYCCCey
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 21:34:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59277 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245AbYCCCex (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 21:34:53 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JW0Vk-0002Nd-UI; Sun, 02 Mar 2008 21:34:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 394E420FBAE; Sun,  2 Mar 2008 21:34:51 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75872>

If we ever decided to append onto the end of this list the tail
pointer must be looking at the right memory cell at the end of
the HEAD ref_map.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 1348a0e..5bce20f 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -157,6 +157,7 @@ static struct ref *get_ref_map(struct transport *transport,
 			if (!ref_map)
 				die("Couldn't find remote ref HEAD");
 			ref_map->merge = 1;
+			tail = &ref_map->next;
 		}
 	}
 	ref_remove_duplicates(ref_map);
-- 
1.5.4.3.468.g36990

