From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: merge summaries
Date: Sun, 20 May 2007 10:17:01 +0200
Message-ID: <0E590255-A3F4-4D36-B798-80364ACD0D06@zib.de>
References: <25A3C618-8D12-42A8-9478-D3A4E7633CE7@zib.de> <alpine.LFD.0.98.0705181130580.3890@woody.linux-foundation.org> <7vodki55px.fsf@assigned-by-dhcp.cox.net> <73A1C4C5-50E9-4844-85F8-00D99682B6D4@zib.de> <7vy7jkwr96.fsf@assigned-by-dhcp.cox.net> <7vy7jkva41.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 10:21:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpgf0-0006dQ-2p
	for gcvg-git@gmane.org; Sun, 20 May 2007 10:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757779AbXETIU4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 04:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757895AbXETIU4
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 04:20:56 -0400
Received: from mailer.zib.de ([130.73.108.11]:34841 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757779AbXETIUy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 04:20:54 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l4K8GrS1016281;
	Sun, 20 May 2007 10:19:43 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1bb27.pool.einsundeins.de [77.177.187.39])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l4K8GppT003934
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 20 May 2007 10:16:52 +0200 (MEST)
In-Reply-To: <7vy7jkva41.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47797>


On May 19, 2007, at 10:20 PM, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
>
>> As long as you stay as a "pull-only" person, and will never ask
>> the upstream to pull back from you, what first parent log would
>> show would make perfectly good sense.  However, once a pull from
>> you by the upstream happens, the resulting history would get the
>> summary in the merge you did, which is totally unwanted --- the
>> upstream already had those summarized commits long time ago in
>> its history.

Why would the summary of the upstream-to-topic-merge be so harmful?
It would not change the summary message of a pull from topic back to
the upstream. Af far as I can see, merge commits do not contribute
to a summary message. However, when browsing the full log the summary
might be distracting because a single commit may be listed at
various places, although it was already in the upstream. This is
kind of ugly. ...


> The criteria to decide "wanted vs unwanted" all boil down to
> essentially the question of who "owns" the history.  Although
> Linus often says that the point of distributed development is
> that nobody is special, at the end of day, once you asked the
> "upstream" to pull from you, your history becomes part of HIS
> history, and at that point, when HE browses the history (which
> he now thinks as HIS history), the summary shows the summary the
> wrong way.  So in that sense, merge.summary is going against the
> philosophy of distributedness.

... I'd say you only "own" the history of a branch along its
first-parent-path to the initial commit. This is what you control
either by directly committing to the branch or by pulling other
branches.

Isn't the history along the first parents especially important because
it documents the functionality of the project? If I want to say  
something
about git at a certain point in time, I'd talk about master of the  
official
git repository. "git log --first-parent" in some sense completely
describes the history of git. At merges at least a summary of features
pulled from topic branches is given.

But this is true not only for the upstream master but for every branch.
The first-parent-path of any commit documents (at least in summaries)
which features were introduced to the branch at which place. If a
topic pulls from upstream, features already available in the upstream
are introduced to the topic at this time. Why not summarize this?


> The summary message is useful in a very short term (i.e. while
> it is still near the tip of the branch and running "git log"),
> but I think JBF is correct to point out that it is showing a
> shortcoming of our history browsing tools.  The information
> recorded there can easily be reproduced on the fly.  Whenever
> you see a merge commit, you can choose one parent to base your
> view of the history upon (typically the first parent), and
> summarize commits that are reachable from other parents but not
> from that parent (e.g. for a typical two-parent merge, you would
> run "git short-log $commit^1..$commit^2").

I find the summary messages quite useful when browsing merges. The  
summary
allows to quickly locate the branch that was merged at that point.  
You just
look at the list of summaries and locate the mentioned commits in gitk.

Minimal merge messages like "Merge branch 'maint' of URL into maint" are
much harder to understand. The branches mentioned in the message do  
no longer
have any meaning. They either ceased to exist or advanced to  
somewhere else.
The URL typically means nothing to me, although it may have meant a  
lot to
the one who pulled at the time of the pull. Such minimal messages do
not help browsing history.

It would probably be more useful to name the merged branch by the  
summary
of its head at the time of the merge. For example
"Merge branch 'user-manual: reorganize public git repo discussion'"
would give more hints where to continue browsing than
"Merge branch 'maint' of URL into maint".

- Steffen
