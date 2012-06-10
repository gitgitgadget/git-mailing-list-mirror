From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] lessen the impression of unexpectedness on remote hangup
Date: Sun, 10 Jun 2012 20:23:10 +0200
Message-ID: <20120610182310.GB2427@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 20:23:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdmnH-0002bX-N2
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 20:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083Ab2FJSXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 14:23:15 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:49010 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887Ab2FJSXP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 14:23:15 -0400
Received: from [77.20.33.80] (helo=localhost)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Sdmn9-0004Zk-AT; Sun, 10 Jun 2012 20:23:11 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199617>

If a server accessed through ssh is denying access git will currently
issue the message

	"fatal: The remote end hung up unexpectedly"

as the last line. This sounds as if something really ugly just happened.
Since this is a quite typical situation in which users regularly get
lets just say:

	"fatal: The remote end hung up"

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
We just got this bug report in msysgit

https://github.com/msysgit/msysgit/issues/28

and IIRC there have been more people questioning that line.

 pkt-line.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index 5a04984..d2b8267 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -141,7 +141,7 @@ static void safe_read(int fd, void *buffer, unsigned size)
 	if (ret < 0)
 		die_errno("read error");
 	else if (ret < size)
-		die("The remote end hung up unexpectedly");
+		die("The remote end hung up");
 }
 
 static int packet_length(const char *linelen)
-- 
1.7.11.rc2.3.g15e800d
