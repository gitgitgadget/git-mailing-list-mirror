From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/6] git-show: When showing tag objects with no tag name,
 show tag object's SHA1 instead of an empty string
Date: Mon, 04 Jun 2007 02:53:26 +0200
Message-ID: <200706040253.26845.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706040251.52613.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 02:53:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv0pE-0001yw-02
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 02:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbXFDAxb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 20:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbXFDAxb
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 20:53:31 -0400
Received: from smtp.getmail.no ([84.208.20.33]:44640 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbXFDAxa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 20:53:30 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJ300K096H5QV00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:53:29 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300F1I6H31K30@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:53:27 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300JWB6H2FE20@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:53:27 +0200 (CEST)
In-reply-to: <200706040251.52613.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49055>

This is a consequence of making the "tag" header in tag objects optional.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-log.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 3744712..1a0f111 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -181,7 +181,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			printf("%stag %s%s\n\n",
 					diff_get_color(rev.diffopt.color_diff,
 						DIFF_COMMIT),
-					t->tag,
+					*(t->tag) ? t->tag : name,
 					diff_get_color(rev.diffopt.color_diff,
 						DIFF_RESET));
 			ret = show_object(o->sha1, 1);
-- 
1.5.2
