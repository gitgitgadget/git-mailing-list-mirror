From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 01:08:00 +0200
Message-ID: <20080909230800.GB7459@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <200809092254.30668.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 01:09:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdCKg-00086j-Ui
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 01:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbYIIXIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 19:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754387AbYIIXIE
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 19:08:04 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:59084 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbYIIXID (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 19:08:03 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id E2D515465; Wed, 10 Sep 2008 01:08:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809092254.30668.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95457>

Jakub Narebski wrote:
>On Tue, 9 Sep 2008, Stephen R. van den Berg wrote:
>> On the contrary, my current proposal only needs to verify the validity
>> of a single commit, changing it like this will require the system to
>> verify the validity of two commits.  Given the rareness of the origin
>> links this will hardly present a problem, but it *does* increase
>> the overhead in checking a bit.

>Errr... wasn't you proposing to keep/protect against pruning <cousin>
>AND <cousin>^<mainline>? You want to have _diff_ (changeset) protected,
>not a single tree state.

Actually, making sure that the commit we reference in the origin link
exists, we implicitly prove that all the parents of that commit exist as
well.  Then again, this point is moot since I already conceded (in a
different thread) that storing two hashes is better.

>>>> - git rev-list --topo-order will take origin links into account to
>>>>   ensure proper ordering.

>Hmmm... while I think it might be a good idea, I'm not sure about its
>overhead. Should be much, I guess.

Actually, I have already programmed this part, and the overhead is close
to zero.

>>>> - git blame will follow and use the origin link if the object exists.

>>> Hmmmm... I'm not sure about that.

>> Care to explain your doubts?
>> The reason I want this behaviour, is because it's all about tracking
>> content, and that part of the content happens to come from somewhere
>> else, and therefore blame should look there to "dig deeper" into it.

>But blame is all about what commit brought some line to currents version.
>So the cherry-pick itself, or revert of a commit itself would be blamed,
>and should be blamed, not its parents, nor commit which got cherry-picked,
>or commit which got reversed.

Well, it depends, I guess.
If you'd go for a "committer" based display, then following origin links
is bad.
If you'd go for an "author" based display, then following origin links
should be the default (IMHO).
-- 
Sincerely,
           Stephen R. van den Berg.

"Be spontaneous!"
