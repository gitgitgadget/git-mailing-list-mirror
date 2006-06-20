From: Jeff Garzik <jeff@garzik.org>
Subject: Re: git 1.4.0 usability problem
Date: Tue, 20 Jun 2006 04:36:46 -0400
Message-ID: <4497B39E.2050205@garzik.org>
References: <449557B6.1080907@garzik.org>	<7vbqsqdru0.fsf@assigned-by-dhcp.cox.net> <4495DB3B.10403@garzik.org> <7v4pyhdel5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 10:37:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsbjA-00036w-MM
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 10:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbWFTIgt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 04:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbWFTIgt
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 04:36:49 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:21703 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965044AbWFTIgs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 04:36:48 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1Fsbj5-0003a7-Ns; Tue, 20 Jun 2006 08:36:48 +0000
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pyhdel5.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22181>

Here's a real world example of the 1.4.0 change breaking a merge:

("netdev-2.6" == local clone of kernel.org/...jgarzik/netdev-2.6.git)
[jgarzik@pretzel netdev-2.6]$ git branch
   ALL
   e100-sbit
* master
   upstream
   upstream-linus

[jgarzik@pretzel netdev-2.6]$ git pull /spare/repo/linux-2.6
Generating pack...
Done counting 3427 objects.
Result has 2510 objects.
Deltifying 2510 objects.
  100% (2510/2510) done
Unpacking 2510 objects
Total 2510, written 2510 (delta 2024), reused 0 (delta 0)
  100% (2510/2510) done
Updating from 427abfa28afedffadfca9dd8b067eb6d36bac53f to 
25f42b6af09e34c3f92107b36b5aa6edc2fdba2f
fatal: Untracked working tree file 'drivers/net/myri10ge/Makefile' would 
be overwritten by merge.

EXPLANATION:

* drivers/net/myri10ge/Makefile exists in latest Linus kernel tree, 
stored locally in /spare/repo/linux-2.6.
* drivers/net/myri10ge/Makefile exists in netdev-2.6#upstream and 
netdev-2.6#upstream-linus branches.
* drivers/net/myri10ge/Makefile does not exist in current branch, 
netdev-2.6#master.
