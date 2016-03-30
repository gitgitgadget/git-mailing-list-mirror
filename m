From: Max Kirillov <max@max630.net>
Subject: Re: [ANNOUNCE] git-push-update, tool to push with "server-side"
 merge or rebase
Date: Wed, 30 Mar 2016 07:55:42 +0300
Message-ID: <20160330045542.GA7541@wheezy.local>
References: <20160328080841.GA12932@wheezy.local>
 <20160330012945.GA8888@ball>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Trevor Saunders <tbsaunde@tbsaunde.org>
X-From: git-owner@vger.kernel.org Wed Mar 30 07:03:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al8Hb-0003ve-OX
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 07:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbcC3FDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 01:03:01 -0400
Received: from p3plsmtpa11-01.prod.phx3.secureserver.net ([68.178.252.102]:43183
	"EHLO p3plsmtpa11-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751270AbcC3FDA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2016 01:03:00 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Mar 2016 01:03:00 EDT
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa11-01.prod.phx3.secureserver.net with 
	id c4vi1s00D5B68XE014voCn; Tue, 29 Mar 2016 21:55:50 -0700
Content-Disposition: inline
In-Reply-To: <20160330012945.GA8888@ball>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290269>

On Tue, Mar 29, 2016 at 09:29:45PM -0400, Trevor Saunders wrote:
> hm how? the workflow you use locally has basically nothingto do with how
> pushes work.  I work on several projects daily where everyone pushes to
> trunk, but locally I use branches.  You just need to fetch rebase then
> either merge your branch into master before pushing or explicitly tell
> git push what refs to update how.

If user is confident in manipulating with branches then
probably this does not provide much value. Though it also
to some extent prevents from pushing to wrong branch by
mistake.

>> * when the trunk goes forward, user have to run merge or
>>   rebase (further "update"), interrupting other work which
>>   might be in progress.
> 
> I don't really understand this either, if you develope everything on
> master then it would seem obvious if you want to update what version of
> trunk you are using you either need to rebase or merge the remote master
> with yours.

Updating your current working branch is not free, if you
have a long compilation. Also new changes can break
something. 

In CVCS (think subversion) nobody really updates after each
commit to server from anybody. You 'keep uptodate' by
updating something like once a day. Otherwise don't have to
update unless somebody touches same file as you. I tried to
restore this opportunity.

>> * while doing fetch, update and push back a concurrent push can happen,
>>   making user to have to repeat it all over.
> 
> I think this is more or less the reason for the hg extension, but I
> think the script to deal with this is basically
> 
> while true
> do
> 	git fetch origin
> 	git rebase origin/master
> 	git push origin HEAD:master && break
> done
> 
> obviously with a little more error checking thrown in if you care.

yes, basically push-update does not do much more than this.

>> This was discussed around some time ago, but I could not find anything
>> done about it. It might seem like nobody really interested much. But I
>> still can see discussions here and there. Also, some time ago extension
>> "pushrebase" for mercurial appeared, which indicates that there is
>> really a demand.
> 
> I think that was really for very heavily used repos where there was a
> ton of fetch rebase push repeating going on.

If does not have to be very heavy. Even small team (3-5
fulltime coders) can already feel a difference.

> I'm not really clear what this is helping for most of those use cases,
> but if you want to maintain it why not?

Let's see if anybody uses it. If somebody does then I can try.

-- 
Max
