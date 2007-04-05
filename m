From: Junio C Hamano <junkio@cox.net>
Subject: Re: How can I easily verify my diffs are in parent branch?
Date: Wed, 04 Apr 2007 22:25:05 -0700
Message-ID: <7vircbwfym.fsf@assigned-by-dhcp.cox.net>
References: <1175686583.19898.68.camel@okra.transitives.com>
	<Pine.LNX.4.64.0704040744160.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 07:25:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZKTE-0003fm-HN
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 07:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161202AbXDEFZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 01:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161204AbXDEFZI
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 01:25:08 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:62862 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161202AbXDEFZG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 01:25:06 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405052505.CRMK24385.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 01:25:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jHR51W00Q1kojtg0000000; Thu, 05 Apr 2007 01:25:05 -0400
In-Reply-To: <Pine.LNX.4.64.0704040744160.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 4 Apr 2007 08:12:20 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43796>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So to compare all patch-ID's, you can do
>
> 	git cherry cvs-upstream my-branch
>
> adn it should look at all the commits that are in *your* branch but not 
> upstream, and report their ID's preceded by a "-" if they are upstream, 
> and a "+" if they are not.
>
> You can then look at the "+" commits more closely, to see whether maybe 
> they actually did get merged, but got changed/fixed in the process, or 
> whether they really are missing.

Funny.

Last night I was thinking about git-cherry, as it is one of the
few commands that have "funny parameter semantics that do not
mesh well with git-log family" (others are format-patch and
rebase).

I think we should be able to use --left-right and ... operator
to express what the above cherry does with something like:

    $ git log --left-right --ignore-common-patch cvs-upstream...my-branch

The --ignore-common-patch option does not exist yet, but the
basic code to implement it should already be accessible from the
log family, as that is what format-patch needs to do.
