From: Len Brown <len.brown@intel.com>
Subject: Re: git-send-email w/ headers
Date: Sat, 7 Oct 2006 00:40:48 -0400
Organization: Intel Open Source Technology Center
Message-ID: <200610070040.48919.len.brown@intel.com>
References: <200610041250.50272.len.brown@intel.com> <200610060041.56807.len.brown@intel.com> <7v1wpm2cxd.fsf@assigned-by-dhcp.cox.net>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 06:39:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW3xj-0000jr-9b
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 06:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbWJGEis (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 00:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbWJGEis
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 00:38:48 -0400
Received: from hera.kernel.org ([140.211.167.34]:4744 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751683AbWJGEir (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 00:38:47 -0400
Received: from lenb-laptop (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.7/8.13.7) with ESMTP id k974cAK6013675
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sat, 7 Oct 2006 04:38:41 GMT
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8.2
In-Reply-To: <7v1wpm2cxd.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.4/2002/Fri Oct  6 22:58:03 2006 on hera.kernel.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.6 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL,URI_NOVOWEL autolearn=no version=3.1.3
X-Spam-Checker-Version: SpamAssassin 3.1.3 (2006-06-01) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28453>

On Friday 06 October 2006 02:09, Junio C Hamano wrote:
> Len Brown <len.brown@intel.com> writes:
> 
> > But the Signed-off-by: line from the original message body has
> > now been swallowed up into the message header -- so my mailer
> > doesn't display it.
> 
> Sorry, what I sent out has worse breakage than not having your
> custom header.  It would eat the first paragraph of your message
> X-<.
> 
> A replacement patch is attached. 

Latest patch seems to be doing the right thing (included below).

However, I've discovered another rough edge.
git-send-email offers to --compose an initial message, but it doesn't
pick up the .git/config header like git-format-patch does:

$ cat .git/config
[format]
        headers = Reply-To: Len Brown <lenb@kernel.org>\nOrganization: Intel Open Source Technology Center\n

thanks,
-Len

Return-Path: <len.brown@intel.com>
 Received: from sccrmhc13.comcast.net (sccrmhc13.comcast.net [63.240.77.83])
        by hera.kernel.org (8.13.7/8.13.7) with ESMTP id k974Of6m010205
        for <lenb@kernel.org>; Sat, 7 Oct 2006 04:25:09 GMT
 Received: from localhost.localdomain (c-65-96-213-102.hsd1.ma.comcast.net[65.96.213.102])
          by comcast.net (sccrmhc13) with SMTP
          id <2006100704243601300452mke>; Sat, 7 Oct 2006 04:24:36 +0000
 From: Len Brown <len.brown@intel.com>
 To: lenb@kernel.org
 Cc: Len Brown <len.brown@intel.com>
 Subject: [PATCH 1/14] test: create junk
 Date: Sat,  7 Oct 2006 00:27:35 -0400
 Message-Id: <11601952702774-git-send-email-len.brown@intel.com>
 X-Mailer: git-send-email 1.4.2.3.gabd6-dirty
 In-Reply-To: <11601952681813-git-send-email-len.brown@intel.com>
 References: <11601952681813-git-send-email-len.brown@intel.com>
 Message-Id: <7488d8f01c21a6411ad99c1d16e95ecd6e1542a6.1160195250.git.len.brown@intel.com>
 Date: Wed, 4 Oct 2006 01:11:12 -0400
 Reply-To: Len Brown <lenb@kernel.org>
 Organization: Intel Open Source Technology Center
 X-Virus-Scanned: ClamAV 0.88.4/2002/Fri Oct  6 22:58:03 2006 on hera.kernel.org
 X-Virus-Status: Clean
 X-Spam-Status: No, score=-1.0 required=5.0 tests=AWL,BAYES_00,
        FORGED_RCVD_HELO,INVALID_DATE autolearn=no version=3.1.3
 X-Spam-Checker-Version: SpamAssassin 3.1.3 (2006-06-01) on hera.kernel.org
 Status: R
 X-Status: NGC
 X-KMail-EncryptionState: 
 X-KMail-SignatureState: 
 X-KMail-MDN-Sent: 
 
Signed-off-by: Len Brown <len.brown@intel.com>
---
 junk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/junk b/junk
new file mode 100644
index 0000000..9ecf3cf
--- /dev/null
+++ b/junk
@@ -0,0 +1 @@
+this
-- 
1.4.2.3.gabd6-dirty
