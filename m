From: Jeff Garzik <jeff@garzik.org>
Subject: Starting to think about sha-256?
Date: Sun, 27 Aug 2006 13:56:07 -0400
Message-ID: <44F1DCB7.6020804@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 27 19:56:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHOro-0006ZW-NK
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 19:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWH0R4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 13:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWH0R4L
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 13:56:11 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:25237 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932212AbWH0R4K (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Aug 2006 13:56:10 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1GHOrg-0006dp-ME
	for git@vger.kernel.org; Sun, 27 Aug 2006 17:56:09 +0000
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26106>


Recent press[1] is talking about sha-1 collisions again.  Even though 
the reported attack was against a weakened variant of sha-1 (64, not 80, 
passes), it serves as a useful point to start talking about the future.

I argue that sha-256 is better suited to git's purposes, and to modern 
machines, than sha-1.

Upsides to sha-256:
* not just a bit increase, but a stronger algorithm.  there is more 
mixing, doing a more-than-incrementally better job at avoiding collisions.
* the bit increase itself provides more hash space, theoretically 
reducing collisions.
* properly aligned, a set of 32-byte hashes won't straddle CPU cachelines.

Downsides to sha-256:
* git protocol/storage format change implications.
* increase in storage size (20 to 32 bytes per hash).
* fewer hand-optimized algorithm variants have been implemented.
* likely more CPU cycles per hash, though I haven't measured.

Wikimedia page has lotsa info: 
http://en.wikipedia.org/wiki/Secure_Hash_Algorithm

Maybe sha-256 could be considered for the next major-rev of git?

	Jeff


[1] http://www.heise-security.co.uk/news/77244
