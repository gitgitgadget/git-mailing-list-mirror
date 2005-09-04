From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] Make sure the diff machinery outputs "\ No newline ..." in english
Date: Sun, 4 Sep 2005 20:17:24 +0200
Message-ID: <20050904181724.GA23525@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Sep 04 20:19:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBz3p-0000zA-4P
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 20:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVIDSRe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 14:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVIDSRe
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 14:17:34 -0400
Received: from [85.8.31.11] ([85.8.31.11]:8396 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932066AbVIDSRd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Sep 2005 14:17:33 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 5DE3A411C; Sun,  4 Sep 2005 20:22:01 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EBz3U-0006BS-00; Sun, 04 Sep 2005 20:17:24 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8064>

In non-english locales diff(1) do sometimes output "\ No newline at end of
file" in some other language. Set LC_ALL to C before execing diff to avoid
this behaviour.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 diff.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

eb6261334d65c3134d9dd822fd64e33ed8ad2dfc
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -207,6 +207,7 @@ static void builtin_diff(const char *nam
 		}
 	}
 	fflush(NULL);
+	putenv("LC_ALL=C");
 	execlp("/bin/sh","sh", "-c", cmd, NULL);
 }
 
