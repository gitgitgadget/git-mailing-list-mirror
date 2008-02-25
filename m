From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Correct fast-export file mode strings to match fast-import standard
Date: Sun, 24 Feb 2008 22:57:29 -0500
Message-ID: <20080225035728.GA26302@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ian Clatworthy <ian.clatworthy@internode.on.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 04:58:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTUUC-0005SH-HV
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 04:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbYBYD5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 22:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753307AbYBYD5i
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 22:57:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50382 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbYBYD5h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 22:57:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JTUSt-0003RA-53; Sun, 24 Feb 2008 22:57:19 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8C7E920FBAE; Sun, 24 Feb 2008 22:57:29 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74989>

The fast-import file format does not expect leading '0' in front
of a file mode; that is we want '100644' and '0100644'.

Thanks to Ian Clatworthy of the Bazaar project for noticing the
difference in output/input.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fast-export.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 49b54de..e1c5630 100755
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -123,7 +123,7 @@ static void show_filemodify(struct diff_queue_struct *q,
 			printf("D %s\n", spec->path);
 		else {
 			struct object *object = lookup_object(spec->sha1);
-			printf("M 0%06o :%d %s\n", spec->mode,
+			printf("M %06o :%d %s\n", spec->mode,
 			       get_object_mark(object), spec->path);
 		}
 	}
-- 
1.5.4.3.295.g6b554
