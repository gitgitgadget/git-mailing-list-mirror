From: =?gb2312?B?wO666A==?= <leehong@pku.edu.cn>
Subject: [PATCH] Fix a memory leak
Date: Sun, 16 Dec 2007 12:53:26 +0800
Message-ID: <3b74913b3f92.3b3f923b7491@pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 16 06:00:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3lcF-0007MR-BN
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 06:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbXLPFAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 00:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbXLPFAO
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 00:00:14 -0500
Received: from sunrise.PKU.EDU.CN ([162.105.129.21]:55610 "HELO
	sunrise.pku.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750791AbXLPFAM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 00:00:12 -0500
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Dec 2007 00:00:11 EST
X-scanvirus: By EQAVSE AntiVirus Engine
X-scanresult: CLEAN
X-MAILFROM: <leehong@pku.edu.cn>
X-RCPTTO: <git@vger.kernel.org>
X-FROMIP: 162.105.129.4
X-EQManager-Scaned: 1
X-Received: unknown,162.105.129.4,20071216125326
Received: from unknown (HELO pku.edu.cn) (162.105.129.4)
  by localhost with SMTP; 16 Dec 2007 04:53:26 -0000
Received: from [222.29.22.140] by water.pku.edu.cn (mshttpd); Sun, 16
 Dec 2007 12:53:26 +0800
X-Mailer: iPlanet Messenger Express 5.2 Patch 2 (built Jul 14 2004)
Content-Language: zh-CN
X-Accept-Language: zh-CN
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68439>



Signed-off-by: Li Hong <leehong@pku.edu.cn>
---
 dir.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index 6b3273d..3e345c2 100644
--- a/dir.c
+++ b/dir.c
@@ -169,7 +169,10 @@ static int add_excludes_from_file_1(const char *fname,
 	}
 	buf = xmalloc(size+1);
 	if (read_in_full(fd, buf, size) != size)
+	{
+		free(buf);
 		goto err;
+	}
 	close(fd);
 
 	if (buf_p)
-- 
1.5.4.rc0.8.gaba5e
