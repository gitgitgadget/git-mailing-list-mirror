From: Jeff Garzik <jeff@garzik.org>
Subject: Re: file rename causes history to disappear
Date: Wed, 06 Sep 2006 11:46:19 -0400
Message-ID: <44FEED4B.30909@garzik.org>
References: <44FEE0BB.2060601@garzik.org> <Pine.LNX.4.64.0609060834520.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 06 17:46:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKzbg-0001tO-IM
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 17:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWIFPqX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 11:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWIFPqX
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 11:46:23 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:19932 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751022AbWIFPqW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 11:46:22 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1GKzbY-00025b-Q3; Wed, 06 Sep 2006 15:46:21 +0000
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609060834520.27779@g5.osdl.org>
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26536>

Linus Torvalds wrote:
> 
> On Wed, 6 Sep 2006, Jeff Garzik wrote:
>> I moved a bunch of SATA drivers in the Linux kernel from drivers/scsi to
>> drivers/ata.
>>
>> When I tried to look at the past history of a file using git-whatchanged,
>> post-rename, it only shows the history from HEAD to the point of rename.
>> Everything prior to the rename is lost.
>>
>> I also tried git-whatchanged on the old path, but that produces an error.
> 
> For filenames that don't exist right now, you need to clearly separate the 
> revision name from the filename (ie you need to use "--").
> 
> There were patches to do "--follow-rename" which I don't think got applied 
> yet, but in the meantime, just do
> 
> 	git whatchanged -M -- drivers/ata/filename.c drivers/scsi/filename.c
> 
> where the "-M" means "show diffs as renames if possible" (which is 
> different from having the history actually _follow_ them), and the "--" is 
> the filename separator to tell git that the nonexistent 
> "drivers/ata/filename.c" file isn't a (currently) nonexistent revision 
> name, it's a (currently) nonexistent _filename_.

Since I'm just interested in the log (ATM), even the lack of "-M" seems 
to produce useful results.  Thanks.

IMO it is highly counter-intuitive that renames are -not- followed.  I 
don't see the point of a "--follow-rename", it should Just Work(tm).

	Jeff
