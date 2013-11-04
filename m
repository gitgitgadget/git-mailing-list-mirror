From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] strbuf: make it clear that suffixcmp() should not be used
 for sorting
Date: Mon, 04 Nov 2013 21:42:50 +0100
Message-ID: <20131104204251.16987.42654.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 04 21:44:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdR0j-0000JI-38
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 21:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab3KDUoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 15:44:22 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:32988 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752598Ab3KDUoV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 15:44:21 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 2F74560;
	Mon,  4 Nov 2013 21:44:19 +0100 (CET)
X-git-sha1: 186b3da385fbf9fbbd76bce11f5c87e1c50c3125 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237302>

Nobody sane uses suffixcmp() for anything but checking with zero,
but it is not very clear from the implementation that it should
not be used for any sorting.

So let's make it clear that the callers should not expect anything
but "does str have sfx as its suffix, yes or no?".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 1170d01..9ba50de 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -16,7 +16,7 @@ int suffixcmp(const char *str, const char *suffix)
 	if (len < suflen)
 		return -1;
 	else
-		return strcmp(str + len - suflen, suffix);
+		return !!strcmp(str + len - suflen, suffix);
 }
 
 /*
-- 
1.8.4.1.576.g36ba827.dirty
