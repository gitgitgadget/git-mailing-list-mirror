From: John Lumby <johnlumby@hotmail.com>
Subject: Re: git  --  how to revert build to as-originally-cloned?
Date: Thu, 19 May 2011 11:27:40 -0400
Message-ID: <4DD536EC.3060308@hotmail.com>
References: <4DD44DCD.7010508@hotmail.com> <SNT124-W3827431D13C320A4C9BF9DC48F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Thu May 19 17:27:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN58Z-0000Hy-I8
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 17:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387Ab1ESP1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 11:27:38 -0400
Received: from toip3.srvr.bell.ca ([209.226.175.86]:54338 "EHLO
	toip3.srvr.bell.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab1ESP1h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 11:27:37 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao0RAM8z1U2uWXUG/2dsb2JhbACCJoMqkhGOLXiIcLA8hz+JHoYZBJRAhByGRg
Received: from bas3-toronto06-2925098246.dsl.bell.ca (HELO lumbywnt.localdomain) ([174.89.117.6])
  by toip3.srvr.bell.ca with ESMTP; 19 May 2011 11:27:36 -0400
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by lumbywnt.localdomain (8.14.4/8.14.1) with ESMTP id p4JFRegE007365;
	Thu, 19 May 2011 11:27:41 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <SNT124-W3827431D13C320A4C9BF9DC48F0@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173962>

On 05/18/11 19:26, Tim Mazid wrote:
>> Date: Wed, 18 May 2011 18:53:01 -0400
>> From: johnlumby@hotmail.com
>> To: git@vger.kernel.org
>> Subject: git -- how to revert build to as-originally-cloned?
>>
>> I am stuck trying to revert a private kernel build back to the state in
>> which I originally cloned it,
>
>
> Normally in order to undo a merge, you would simply do a "git reset
>
> --hard HEAD^". Take note of the carat(is that correct?) character; that
>
> means the commit BEFORE head.
>
>
>
> Can you please post the commit message that you see in the first commit
>
> when doing a git log?

Here are the first three.   I assume (not sure) they are what was merged 
into the newer clone,  /b,   just before I cloned it

------------------------------------------------------------------------------
commit 89c64d755fbf04d7541d526931dc4b38301946d1
Merge: 4dc6ec2 4f6290c
Author: David S. Miller <davem@davemloft.net>
Date:   Sun May 15 01:08:23 2011 -0400

     Merge branch 'master' of 
master.kernel.org:/pub/scm/linux/kernel/git/jkirsher/net-next-2.6

commit 4dc6ec26fe7d9f89349d4c0c654e2f07420f4b27
Merge: 7be799a ca06c6e
Author: David S. Miller <davem@conan.davemloft.net>
Date:   Sat May 14 22:47:51 2011 -0400

     Merge branch 'batman-adv/next' of 
git://git.open-mesh.org/ecsv/linux-merge

commit 5c5095494fb545f53b80cbb7539679a10a3472a6
Merge: 4d586b8 def5768
Author: David S. Miller <davem@davemloft.net>
Date:   Thu May 12 23:01:55 2011 -0400
------------------------------------------------------------------------------

So I now think I see the problem with using a reset based on something 
relating to commits  -
apparently (??) there is nothing in the git log to distinguish commits 
done by my last merge versus commits prior to that.     I.e. the "merge" 
does not appear to be logged as an event in its own right,   only as the 
commits inside it??
> Also, if you just want to go back to a particular branch, you can
> specify it to git reset, in the form of "git reset --hard
> origin/master". This will reset (discarding any changes) YOUR branch to
> wherever origin/master happens to be, which, from reading your message
> seems to be where you want to go?

Ah -  that did it,   thanks Tim.      I had seen that one but wasn't 
sure whether it would reset me back to what I cloned or the master of 
that clone i.e. way back to the "original" origin of this build.

It seems if I had not created a separate branch  --   I would now be 
completely sunk?

It would be nice if there was a "git undo" which undid whatever changes 
to files+index were made by the immediately preceding git command,  
whatever it was and whatever it did.


> Be careful if you have made changes you want to keep, though.


No worries there although thanks for the warning.
