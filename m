From: Ben Lau <benlau@ust.hk>
Subject: Re: How to create a new branch based on a tag?
Date: Sat, 22 Oct 2005 03:14:16 +0800
Message-ID: <43593E08.1060208@ust.hk>
References: <435901F7.9020509@ust.hk> <7vsluv5y0p.fsf@assigned-by-dhcp.cox.net> <4359161B.5000808@ust.hk> <7vzmp3319v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 09:14:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESr6B-00010f-Ik
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 09:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVJUHNw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 03:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbVJUHNw
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 03:13:52 -0400
Received: from mx4.ust.hk ([143.89.13.26]:25870 "EHLO mx4.ust.hk")
	by vger.kernel.org with ESMTP id S964891AbVJUHNv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 03:13:51 -0400
Received: from [143.89.135.159] (atz113.rd.ust.hk [143.89.135.159])
	by mx4.ust.hk (8.12.11/8.12.11) with ESMTP id j9L7DdwK029839;
	Fri, 21 Oct 2005 15:13:40 +0800 (HKT)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmp3319v.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10425>

Junio C Hamano wrote:

>Ben Lau <benlau@ust.hk> writes:
>
>  
>
>>>The way you know is as good as it gets.  v2.6.11-tree case is
>>>really an unfortunate special case.
>>>
>>>      
>>>
>>What is wrong with the v2.6.11-tree? I just thought it is a duplicate tag
>>of v2.6.11.
>>    
>>
>
>They are not *wrong* per-se.  They are tags to tree objects
>without any associated commit history -- that makes them
>inappropriate to be used as branch heads.
>
>Linus or somebody authoritative could do:
>
>    $ commit=$(echo v2.6.11 | \
>      git-commit-tree c39ae07f393806ccf406ef966e9a15afc43cc36a)
>    $ git-tag -s -m 'v2.6.11 canonical "fake" commit' v2.6.11fake $commit
>
>and tell everybody interested to have:
>
>1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 xxxxxxxxxx
>
>(where xxxxx... is the value of $commit above) in their
>info/grafts file.  Then we *could* pretend that v2.6.12-rc2's
>parent is v2.6.11.  You could branch off from v2.6.11fake commit
>and base your development, and later you could merge that into
>later development history (say, v2.6.14-rc5) if you wanted to.
>
>If Linus does something like the above, the graft probably be
>better done between the current v2.6.12-rc2 based commit history
>and the corresponding commit in the history resurrected from
>BKCVS (torvalds/old-2.6-bkcvs.git).  Then you could even base
>your development on top of v2.4.0 ;-).
>
>Funnily, v2.6.12-rc2 commit in the current history and BKCVS
>v2.6.12-rc2 commit in the resurrected history have different
>tree IDs.
>
>I am however not quite sure how useful the above would be,
>though.  EVen between 2.6.11 and 2.6.12-rc2 much have happened,
>so unless the changes you are making apply to the part that did
>not change between those two, merge conflict resolution might be
>quite a chore.
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe git" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  
>
Thanks for detail explanation.

It is a little bit difficult for me. The result of `git log`
shows that the eldest commit is 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
which is linux-2.6.12-rc2. Is that means the git repository do not
store the history before this tag? Then how can `git-read-tree
v2.6.11`  fetchs the content of v2.6.11?

By the way, How could you find the 
c39ae07f393806ccf406ef966e9a15afc43cc36a out?

I have followed your instuctions and now have my own 2.6.11 
branch(my2.6.11). Should be fine
now. Many thanks to all you guys.
