From: Mike McCormack <mike@codeweavers.com>
Subject: [PATCH] Avoid a crash if realloc returns a different pointer.
Date: Wed, 05 Apr 2006 23:22:19 +0900
Organization: CodeWeavers
Message-ID: <4433D29B.1080802@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020405090009020301000909"
X-From: git-owner@vger.kernel.org Wed Apr 05 16:44:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR9E0-0003ma-NY
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 16:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWDEOm4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 10:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWDEOm4
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 10:42:56 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:34249 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1750776AbWDEOm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 10:42:56 -0400
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1FR8yX-0000iv-Qq
	for git@vger.kernel.org; Wed, 05 Apr 2006 09:27:16 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923
X-Accept-Language: en, en-us, ko-kr
To: git@vger.kernel.org
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: mike@codeweavers.com
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18436>

This is a multi-part message in MIME format.
--------------020405090009020301000909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

---

  imap-send.c |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)


--------------020405090009020301000909
Content-Type: text/x-patch;
 name="235cf581a853777fdb6886806ddbfcd9f782eb98.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="235cf581a853777fdb6886806ddbfcd9f782eb98.diff"

235cf581a853777fdb6886806ddbfcd9f782eb98
diff --git a/imap-send.c b/imap-send.c
index f3cb79b..d04259a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1202,6 +1202,7 @@ read_message( FILE *f, msg_data_t *msg )
 			p = xrealloc(msg->data, len+1);
 			if (!p)
 				break;
+			msg->data = p;
 		}
 		r = fread( &msg->data[msg->len], 1, len - msg->len, f );
 		if (r <= 0)


--------------020405090009020301000909--
