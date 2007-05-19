From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge summaries
Date: Sat, 19 May 2007 13:20:30 -0700
Message-ID: <7vy7jkva41.fsf@assigned-by-dhcp.cox.net>
References: <25A3C618-8D12-42A8-9478-D3A4E7633CE7@zib.de>
	<alpine.LFD.0.98.0705181130580.3890@woody.linux-foundation.org>
	<7vodki55px.fsf@assigned-by-dhcp.cox.net>
	<73A1C4C5-50E9-4844-85F8-00D99682B6D4@zib.de>
	<7vy7jkwr96.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat May 19 22:20:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpVPu-0002e0-Sj
	for gcvg-git@gmane.org; Sat, 19 May 2007 22:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758358AbXESUUe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 16:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758536AbXESUUe
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 16:20:34 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43685 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758358AbXESUUe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 16:20:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519202031.NMUI12190.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 16:20:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 18LW1X00F1kojtg0000000; Sat, 19 May 2007 16:20:31 -0400
In-Reply-To: <7vy7jkwr96.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 19 May 2007 12:24:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47770>

Junio C Hamano <junkio@cox.net> writes:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> What is so wrong if merge summaries of pulls from you were committed
>> to topic branches. Later when you pull such branches the summaries
>> shouldn't be a problem. A short-log of the topic branch wouldn't
>> contain the summaries.
>>
>> Probably I do not fully understand what "the wrong way around" means.
>
> I think you understand it very well.
>
> As long as you stay as a "pull-only" person, and will never ask
> the upstream to pull back from you, what first parent log would
> show would make perfectly good sense.  However, once a pull from
> you by the upstream happens, the resulting history would get the
> summary in the merge you did, which is totally unwanted --- the
> upstream already had those summarized commits long time ago in
> its history.

Having said that.

The criteria to decide "wanted vs unwanted" all boil down to
essentially the question of who "owns" the history.  Although
Linus often says that the point of distributed development is
that nobody is special, at the end of day, once you asked the
"upstream" to pull from you, your history becomes part of HIS
history, and at that point, when HE browses the history (which
he now thinks as HIS history), the summary shows the summary the
wrong way.  So in that sense, merge.summary is going against the
philosophy of distributedness.

The summary message is useful in a very short term (i.e. while
it is still near the tip of the branch and running "git log"),
but I think JBF is correct to point out that it is showing a
shortcoming of our history browsing tools.  The information
recorded there can easily be reproduced on the fly.  Whenever
you see a merge commit, you can choose one parent to base your
view of the history upon (typically the first parent), and
summarize commits that are reachable from other parents but not
from that parent (e.g. for a typical two-parent merge, you would
run "git short-log $commit^1..$commit^2").
