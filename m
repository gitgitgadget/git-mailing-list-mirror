From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] fix minor memory leak in get_tree_entry()
Date: Sun, 14 Feb 2010 10:56:46 +0100
Message-ID: <4B77C8DE.5070503@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 10:56:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgbDm-0001nz-Pf
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 10:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758230Ab0BNJ4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 04:56:53 -0500
Received: from india601.server4you.de ([85.25.151.105]:45331 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855Ab0BNJ4w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 04:56:52 -0500
Received: from [10.0.1.100] (p57B7B9D5.dip.t-dialin.net [87.183.185.213])
	by india601.server4you.de (Postfix) with ESMTPSA id B21252F80A3;
	Sun, 14 Feb 2010 10:56:50 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139892>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 tree-walk.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 08796c2..67a9a0c 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -441,6 +441,7 @@ int get_tree_entry(const unsigned char *tree_sha1, const char *name, unsigned ch
 
 	if (name[0] == '\0') {
 		hashcpy(sha1, root);
+		free(tree);
 		return 0;
 	}
 
-- 
1.7.0
