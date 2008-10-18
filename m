From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: Feedback outside of the user survey
Date: Sat, 18 Oct 2008 16:01:15 +0200
Message-ID: <48F9EC2B.2010200@jaeger.mine.nu>
References: <2d460de70810160319r4bed8643g884508cdeba772@mail.gmail.com> <20081016115628.GA24836@garry-x300.arpnetworks.com> <2d460de70810160618u1803375aj913145a5060e5308@mail.gmail.com> <48F7A4F8.2080600@jaeger.mine.nu> <20081018134906.GA13894@garry-thinkpad.arpnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	git@vger.kernel.org
To: Garry Dolley <gdolley@arpnetworks.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 16:02:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrCOL-0006uz-MW
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 16:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbYJROBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 10:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbYJROBW
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 10:01:22 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:41175 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750819AbYJROBW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 10:01:22 -0400
Received: (qmail 558 invoked from network); 18 Oct 2008 14:01:19 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 18 Oct 2008 14:01:19 -0000
Received: (qmail 27824 invoked from network); 18 Oct 2008 14:01:16 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 18 Oct 2008 14:01:16 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <20081018134906.GA13894@garry-thinkpad.arpnetworks.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98551>

Garry Dolley wrote:
> On Thu, Oct 16, 2008 at 10:32:56PM +0200, Christian Jaeger wrote:
>   
>> Hm, I don't see a fundamental technical problem which would prevent one 
>> from implementing the ability to checkout only a subdirectory into the 
>> working directory (i.e. to add options to Git to make it reflect the 
>> working directory as being a subdirectory of what is in Git's database). At 
>> this level I don't see anything inherently different from SVN--except maybe 
>> for directory renames: if someone else is renaming the directory you've 
>> checked out, what should happend with your checkout? Git's filebased rename 
>> tracking would just lead to everything vanishing from your checkout. I 
>> don't know what happens in SVN, maybe it keeps track of the directory 
>> rename and still sends you the changes of the directory you've checked out 
>> even if it has now a different name on the server?
>>
>> Anyway, an unavoidable difference is that you have to always clone the 
>> whole Git *database*. With SVN the database stays on the server, with Git 
>> it is being cloned. Just as I expect SVN to need the whole database to be 
>> [...]
>>     
>
> Right, but I think cloning the entire git database just to get a
> subdir is a fundamental technical problem.  It's no different than
> git-clone + checkout + rm -rf <what I don't want in working tree>
>   

We're in "violent agreement" here.

> In that sense, git already has support for cloning subdirectories,
> which is why I don't think this method applies to what the original
> post author meant when they referred to "support for cloning sub
> directories".
>   

I just think it's worth pointing out the difference between the working 
dir and the database. It should be as easy to implement checking out 
subdirectories in Git as it was in SVN (except, again, that, iff 
directory renames should be tracked, some code would have to be written 
to find out about directory renames, which SVN solves in a simpler way 
by just requiring that the user specifies renames explicitely). It's 
worth pointing out that working directory checkouts and database cloning 
are separate operatoins and it's only the database cloning which is, per 
definition (as it is a distributed VCS) different from SVN.

> :)
>   

If you really wanted, I suppose you could additionally look into 
implementing a kind of shallow cloning that only copies objects over the 
wire which are necessary for representing the subdirectory you're 
interested in.

Christian.
