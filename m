From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Add a 1-second sleep to git-cvsexportcommit test
Date: Tue, 24 Jul 2007 10:33:35 +0200
Message-ID: <200707241033.36509.robin.rosenberg.lists@dewire.com>
References: <7vk5ssqdy0.fsf@assigned-by-dhcp.cox.net> <200707240223.54228.robin.rosenberg.lists@dewire.com> <46A5B43E.3030700@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jason Sewall <jasonsewall@gmail.com>, git@vger.kernel.org,
	raa.lkml@gmail.com
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 10:32:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDFos-0002t8-O7
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 10:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbXGXIc1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 04:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbXGXIc1
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 04:32:27 -0400
Received: from [83.140.172.130] ([83.140.172.130]:7590 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbXGXIc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 04:32:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 623C08026EE;
	Tue, 24 Jul 2007 10:25:09 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24910-10; Tue, 24 Jul 2007 10:25:09 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id ECEAA8026C7;
	Tue, 24 Jul 2007 10:25:08 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <46A5B43E.3030700@fs.ei.tum.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53534>

tisdag 24 juli 2007 skrev Simon 'corecode' Schubert:
> Robin Rosenberg wrote:
> >>> It may be that we may want to fix this inside cvsexportcommit
> >>> itself, instead of working it around in the tests.  If somebody
> >>> tries to push more than one commit from git using two
> >>> cvsexportcommit in a row, he would need to make sure that the
> >>> second run happens one or more seconds after the first run,
> >>> otherwise he will see the exact corruption in real life.
> >> Ah, now I see the problem.  The timestamp in the CVS/Entries is the same (because it only has second granularity), 
> >> so cvs commit won't consider it as changed. 
> >>
> >> That's the reason why CVS usually waits until the second turns after a "update" (obviously not after a "commit"). 
> >> So we could either turn back the timestamp in the Entries file (ugly) or simply wait until the second turns.  Given 
> >> the overall cvs performance, this won't be a big issue, I guess. 
> > 
> > CVS sleeps after commit here. Can we bisect it? I have 1.12.3
> > (mandriva). The patch below I think would work around the problem,
> > rather than trying to fix the test. but I'd like to have the last CVS
> >  revision where it does not work for the patch comment
> 
> This is a strange thing.  CVS has this in their commit code since 1996.  So I wonder why this is getting triggered.
> 
> > Since the sleep is per invocation of cvsexportcommit it won't hurt
> > too much since it is rarely invoked on a huge number of git commits.
> 
> The question also is, why does this happen on two sequential invocations of cvsexportcommit, but not on two cvs commits done by cvsexportcommit?  This should look the same to cvs, no?

I reread my post here...  My last sentence was a comment to the patch and not the sleep in CVS.

-- robin
