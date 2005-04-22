From: Dan Weber <dan@mirrorlynx.com>
Subject: git remote repositories
Date: Fri, 22 Apr 2005 19:38:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0504221929480.20133@mirrorlynx.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Sat Apr 23 01:33:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP7e2-0006c9-IE
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 01:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVDVXho (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 19:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVDVXho
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 19:37:44 -0400
Received: from outbound.mailhop.org ([63.208.196.171]:21521 "EHLO
	outbound.mailhop.org") by vger.kernel.org with ESMTP
	id S261322AbVDVXhg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 19:37:36 -0400
Received: from pool-68-238-240-238.phlapa.fios.verizon.net ([68.238.240.238] helo=mirrorlynx.com)
	by outbound.mailhop.org with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.44)
	id 1DP7iJ-0007I2-Oo
	for git@vger.kernel.org; Fri, 22 Apr 2005 19:37:35 -0400
Received: from dan (helo=localhost)
	by mirrorlynx.com with local-esmtp (Exim 4.34)
	id 1DP7jP-0005RJ-Nr
	for git@vger.kernel.org; Fri, 22 Apr 2005 19:38:44 -0400
To: Git Mailing List <git@vger.kernel.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: dan@mirrorlynx.com
X-Spam-Checker-Version: SpamAssassin 3.0.0 (2004-09-13) on mirrorlynx.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=unavailable version=3.0.0
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on mirrorlynx.com)
X-Mail-Handler: MailHop Outbound by DynDNS.org
X-Originating-IP: 68.238.240.238
X-Report-Abuse-To: abuse@dyndns.org (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: DanWeber1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Hi,

It wasn't that long ago that the pasky git tree was relocated.  This 
required a modification to the .git directory in a local pull.  A dns 
system could be built to ensure the following:

A) quick easy lookup of archive locations
B) handle changes of repository location
C) add mirror support

So heres the plan...
I do a lot of work in sip/voip field, and our approach to handling backup 
proxies and routers is to use a dns srv record.

Here's how it works for voip/sip.

_{protocol}._{transport}.{name}.hostname.org

A sample lookup:

dig SRV _sip._udp.proxy-dca.broadvoice.com


;; QUESTION SECTION:
;_sip._udp.proxy-dca.broadvoice.com. IN SRV

;; ANSWER SECTION:
_sip._udp.proxy-dca.broadvoice.com. 86400 IN SRV 1 0 5060 
proxy.mia.broadvoice.com.
_sip._udp.proxy-dca.broadvoice.com. 86400 IN SRV 0 0 5060 
proxy.dca.broadvoice.com.


Now of course we could null out some of those fields and swap sip for git 
and udp for rsync, then replace proxy.foo to rsync://host/path/to/git. 
Since we're using rsync, mirroring is simplified by just rsyncing the 
trees.

Dan
