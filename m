From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: git-format-patch-script bug?
Date: Sun, 07 Aug 2005 12:54:43 -0600
Message-ID: <m1y87dwpak.fsf@ebiederm.dsl.xmission.com>
References: <m1d5oqxkqm.fsf@ebiederm.dsl.xmission.com>
	<7vhde1y85y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 20:56:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1qJZ-0002Hw-2T
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 20:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563AbVHGSzQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 14:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbVHGSzP
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 14:55:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8602 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1752558AbVHGSzI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2005 14:55:08 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j77IshW2022541;
	Sun, 7 Aug 2005 12:54:43 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j77IshfE022540;
	Sun, 7 Aug 2005 12:54:43 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhde1y85y.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 07 Aug 2005 10:21:45 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> I was trying to help someone track down a bug that
>> occurred between linux-2.6.12 and linux-2.6.13-rc1.
>> Since it was very much an unknown where the problem
>> was introduced I decided to run git format-patch
>> so I could see what all of the differences were.
>> Then to be certain the patch series worked I started
>> applying them in order.  
>
> Sorry, I offhand do not have a good re-design of what
> format-patch should do for this purpose; the current design does
> not try to deal with anything but a linear sequence of commits,
> primarily because the command was done for preparing individual
> developer's patch submission.

What format-patch does is currently is fine.  If format-patch would
simply notice the case and fail gracefully that would be sufficient to
avoid giving false impressions.

Depending on the quality of the list from git-rev-list --merge-order
I should even be able to achieve what I was attempting, by
running git-diff-tree with an ordered list of revisions and 
two parents on the tree.

Essentially I was attempting an export to quilt operation, which
implies a linearization of the changes.  As I recall a linearization
of the changes is what BK export to CVS was built on.  So that
case may be worth returning to as there are a lot of interesting
cases out there for it.

The other interest tid bit about my experiment was that
git-format-patch-script on 2000 diffs was sluggish, certainly slower
that the time to perform the write operations.  Why it was slow
I don't know but it may be worth looking into.

> I find your trying to find where the problem was introduced by
> reading every single change very laudable.  However, for the
> purpose of "this one was good but somewhere before this one the
> things got broken, where is it?", I suspect that bisect would be
> a better fit.

If you can teach the user how to use bisect, and git.  

If we could get gitweb to perform the bisect it would be helpful,
or possibly when git settles down and everyone can be counted on
to have git on their machine already, bisect would be a help.

Had I been thinking a little more clearly I would have suggested
walking through the daily git snapshots as those are at least
fairly big steps.

For the moment I think the unexpected behavior I found in git 
is more interesting then the problem I was actually trying to solve.

Eric
