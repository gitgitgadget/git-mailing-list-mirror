From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: git-push of new, tiny branch doing more work than necessary?
Date: Fri, 22 Sep 2006 08:40:41 +0100
Message-ID: <45139379.4040602@shadowen.org>
References: <87fyekkg5r.wl%cworth@cworth.org> <Pine.LNX.4.63.0609220031570.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 22 09:41:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQfer-0003Nt-Gj
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 09:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWIVHlK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 03:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWIVHlK
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 03:41:10 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:24838 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750851AbWIVHlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 03:41:09 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GQfeI-0003og-So; Fri, 22 Sep 2006 08:40:39 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609220031570.19042@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27522>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 21 Sep 2006, Carl Worth wrote:
> 
>> I've run through something quite like the following scenario a few
>> times lately:
>>
>> 	git pull origin
>> 	git checkout -b experiment
>> 	# hack a file or two
>> 	git commit -a -m "new experiment"
>> 	git push origin experiment
>>
>> What I expect at this point is for git to push the few newly created
>> objects out to the repository. Instead it talks about generating,
>> deltifying, transferring, and unpacking thousands of objects (see
>> below).
> 
> I experienced something like this, too, but did not have the time to debug 
> it. But alas, some time (I think last week) it started working as expected 
> again.

I hope this started working again because we fixed it this time.  Two
bugs were fixed in this area.  First any branch names over about 40
characters in length were being ignored completely due to a validation
bug.  Second in an attempt to ensure we didn't bust the 900 entry
command line limit for rev-list we were restricting ourselves to 16
remote refs as possible bases.  master now has these changes in it and I
am no longer seeing this behavior.

> 
>> git version 1.4.2.rc2.gef1d9
> 
> Please try a more recent version (yours is from Jul 27).

-apw
