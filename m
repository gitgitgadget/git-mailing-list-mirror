From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] core-tutorial: git-merge uses -m for commit messages
Date: Mon, 05 Feb 2007 18:04:04 -0800
Message-ID: <7v7iuwm48b.fsf@assigned-by-dhcp.cox.net>
References: <20070205113439.GA27077@moooo.ath.cx>
	<7vejp4mqad.fsf@assigned-by-dhcp.cox.net>
	<20070205183232.GA9183@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Tue Feb 06 03:04:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEFgq-0000Mt-RD
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 03:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965395AbXBFCEI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 21:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965396AbXBFCEI
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 21:04:08 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:45241 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965395AbXBFCEG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 21:04:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070206020405.ZUJ1343.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 5 Feb 2007 21:04:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id L2441W00T1kojtg0000000; Mon, 05 Feb 2007 21:04:04 -0500
In-Reply-To: <20070205183232.GA9183@moooo.ath.cx> (Matthias Lederhofer's
	message of "Mon, 5 Feb 2007 19:32:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38801>

Matthias Lederhofer <matled@gmx.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> The original examples work perfectly Ok, [..]
> Ah, so the man page is incomplete?

Perhaps, but the older format is not something we would want to
recommend to humans, so...

> But without HEAD (git merge -m
> "message" mybranch) the command is ok?

Yes, but ;-).

Humans are encouraged to say "git merge <that-branch>" and let
fmt-merge-msg to figure out what message to use.

If I were updating the end-user tutorial, I would probably
recommend people to use the newer format that does not force you
to say HEAD.  core-tutorial however is meant to talk about how
Porcelain scripts do things, and in that sense it makes some
sense to demonstrate the use of funny "<msg> HEAD <commit>"
order, only because it is how git-pull invokes "git merge".

> It seems to work anyway
> because merging HEAD just prints "Already up-to-date with <commit>".

Invoking with -m <msg>, like this:

	git merge -m "$msg" HEAD $commit

it would try to make an octopus that has the current HEAD (this
is given always when you are merging), the HEAD you gave from
the command line, and the other $commit.  The octopus merge
strategy is intelligent enough to notice that the second HEAD is
the same as the current HEAD so resulting commit would only have
two parents.  So it may happen to work, but it is never a good
practice.
