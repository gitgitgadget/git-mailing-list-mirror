From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/7] Ensure packed_git.next is initialized to NULL.
Date: Sun, 24 Dec 2006 00:46:04 -0500
Message-ID: <20061224054604.GC8146@spearce.org>
References: <487c7d0ea81f2f82f330e277e0aea38a66ca7cfe.1166939109.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 06:46:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyMBY-0001SE-Pt
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 06:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbWLXFqJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 00:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754115AbWLXFqI
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 00:46:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53736 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbWLXFqH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 00:46:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GyMBS-0008Ov-6r; Sun, 24 Dec 2006 00:46:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7607120FB65; Sun, 24 Dec 2006 00:46:04 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <487c7d0ea81f2f82f330e277e0aea38a66ca7cfe.1166939109.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35340>

Junio noticed while reviewing this patch series that I removed the
initialization of packed_git.next = NULL in 88078baa.  That removal
was not intended so I'm restoring the initialization where necessary.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 1a87f95..8de8ce0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -676,6 +676,7 @@ struct packed_git *add_packed_git(char *path, int path_len, int local)
 	p->index_size = idx_size;
 	p->pack_size = st.st_size;
 	p->index_base = idx_map;
+	p->next = NULL;
 	p->windows = NULL;
 	p->pack_fd = -1;
 	p->pack_local = local;
@@ -707,6 +708,7 @@ struct packed_git *parse_pack_index_file(const unsigned char *sha1, char *idx_pa
 	p->index_size = idx_size;
 	p->pack_size = 0;
 	p->index_base = idx_map;
+	p->next = NULL;
 	p->windows = NULL;
 	p->pack_fd = -1;
 	hashcpy(p->sha1, sha1);
-- 
1.4.4.3.g2e63
