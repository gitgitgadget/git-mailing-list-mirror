From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: The state and future of the git/mingw** reposiories?
Date: Wed, 20 Aug 2008 23:22:15 +0200
Message-ID: <1CB66104-4E38-4402-BF9F-2AB1284D76D6@zib.de>
References: <20080820112309.GH10544@machine.or.cz> <200808202218.35626.johannes.sixt@telecom.at>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 20 23:24:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVv9N-0001JM-6F
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 23:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbYHTVWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 17:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753369AbYHTVWW
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 17:22:22 -0400
Received: from mailer.zib.de ([130.73.108.11]:46482 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960AbYHTVWV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 17:22:21 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m7KLM4YX023732;
	Wed, 20 Aug 2008 23:22:09 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db97403.pool.einsundeins.de [77.185.116.3])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m7KLM3SO001224
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 20 Aug 2008 23:22:03 +0200 (MEST)
In-Reply-To: <200808202218.35626.johannes.sixt@telecom.at>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93052>


On Aug 20, 2008, at 10:18 PM, Johannes Sixt wrote:

> On Mittwoch, 20. August 2008, Petr Baudis wrote:
>>
>>
>>  I'm currently doing some MSysGit hacking (mostly git-gui-related)  
>> and
>> I'm wondering what should I actually base my work on, considering the
>> statement of 1.6.0 release notes:
>>
>> 	Source changes needed for porting to MinGW environment are now
>> 	all in the main git.git codebase.
>
> If all you need is a mostly working git, you can build off of git.git
> (assuming you have the build environment that msysgit provides).

I agree.  I suggest that you start branches from Junio's master, unless
this is not possible.

Unfortunately, I am not convinced of our current solution for handling
the installation prefix on Windows.  Hence, I won't create a 1.6.0
installer.  I have recently proposed a patch series that addresses the
issues I see:

   http://article.gmane.org/gmane.comp.version-control.git/92605

But this patch series is not yet ready for Junio's master.

Note also that I'll be completely offline for the next three weeks,
so you won't see any progress from my side.


>> However, git diff junio/master...mingw/master shows quite a few
>> differences - is there any plan to merge these?
>
> You see three kinds of differences:
>
> - Changes in the test suite.
> - Perl related changes (most notably, git-add--interactive in  
> git.git does not
> work on MinGW without these changes).
> - One or two gitk related fixes.

In 4msysgit.git we have, in addition, the Putty related change that
was not accepted by Junio.  I haven't decided what to do with
this change.  See

   http://article.gmane.org/gmane.comp.version-control.msysgit/2560

and replies.


> All of them will be sent upstream some day.
>
> If you need one of the areas that these changes touche, then you can  
> work off
> of mingw.git.
>
>> If so, do you plan to
>> maintain the mingw fork indefinitely anyway as a staging area for  
>> your
>> patches that you plan to push upstream, or is it going to be phased  
>> out
>> eventually?
>
> I hope I can reset mingw.git to git.git some day. But I plan to keep  
> it as
> staging area for patches.
>
>
>> I'm even more confused about the git/mingw/4msysgit.git repository,
>> though. The branches here seem to be ... *insert 10 minutes of  
>> clicking
>> through dense gitk graphs* ... random mix of git.git and git/ 
>> mingw.git
>> merges, but git diff mingw/master...origin/devel turns out to be  
>> fairly
>> minimal - still, some of the changes look quite generic. Again, is  
>> there
>> any upstream merge plan?

I merge from Hannes if he has already merged from Junio.  If Hannes'
master is not up-to-date I merge directly from Junio.  I even merged
a few times directly from Shawn's git-gui master if I needed fixes from
there to create a release.



>> What is the branch structure of git/mingw/4msysgit.git? The 'master'
>> branch still points to 1.5.6, the 'next' branch points to  
>> something...
>> I can't quite pinpoint and the 'devel' branch seems to be 1.6.0 +
>> mingw/master. Who is supposed to use which one?

I plan to stop supporting 4msysgit asap and replace it with Junio's
git.git.  Until then:

  - 'master' points to the last stable version (typically the last
    release).  The reason is that msysGit will checkout and compile
    master, so it is required to work.

  - 'devel' is the branch that has all changes planned for the next
    release.

  - 'next' contains Junio's next + 'devel', so that people could test
    Junio's next branch.

In addition to these toplevel branches we have a couple of topic  
branches.
 From time to time someone cleans up topic branches; but for some of the
topic branches I do not remember (if I ever knew) what they are about.

	Steffen
