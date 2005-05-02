From: tony.luck@intel.com
Subject: [patch-git] Fix warning in convert-cache
Date: Mon, 2 May 2005 10:57:02 -0700
Message-ID: <200505021757.j42Hv2S05725@unix-os.sc.intel.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 19:55:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSf6O-0008Gn-6J
	for gcvg-git@gmane.org; Mon, 02 May 2005 19:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVEBR6s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 13:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVEBR5x
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 13:57:53 -0400
Received: from fmr21.intel.com ([143.183.121.13]:32749 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261537AbVEBR5L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2005 13:57:11 -0400
Received: from scsfmr101.sc.intel.com (scsfmr101.sc.intel.com [10.3.253.10])
	by scsfmr001.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j42Hv2Aj015768;
	Mon, 2 May 2005 17:57:02 GMT
Received: from unix-os.sc.intel.com (unix-os.sc.intel.com [172.25.110.7])
	by scsfmr101.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j42Hpx9R010789;
	Mon, 2 May 2005 17:51:59 GMT
Received: from localhost (localhost [[UNIX: localhost]])
	by unix-os.sc.intel.com (8.11.6/8.11.2) id j42Hv2S05725;
	Mon, 2 May 2005 10:57:02 -0700
To: torvalds@osdl.org
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

gcc 3.4.3 kicks out this warning:
convert-cache.c: In function `write_subdirectory':
convert-cache.c:102: warning: field precision is not type int (arg 4)

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

--- k/convert-cache.c
+++ l/convert-cache.c
@@ -99,7 +99,7 @@ static int write_subdirectory(void *buff
 			continue;
 		}
 
-		newlen += sprintf(new + newlen, "%o %.*s", S_IFDIR, slash - path, path);
+		newlen += sprintf(new + newlen, "%o %.*s", S_IFDIR, (int)(slash - path), path);
 		new[newlen++] = 0;
 		sha1 = (unsigned char *)(new + newlen);
 		newlen += 20;
