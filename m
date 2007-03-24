From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] update-hook: remove all functionality that should be in hooks/post-receive
Date: Sat, 24 Mar 2007 03:41:30 -0700
Message-ID: <7vodmikjol.fsf@assigned-by-dhcp.cox.net>
References: <200703231022.00189.andyparkins@gmail.com>
	<7v648ro3a3.fsf@assigned-by-dhcp.cox.net>
	<200703240814.35525.andyparkins@gmail.com>
	<20070324102652.GA15474@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Mar 24 11:41:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV3gz-0005qo-24
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 11:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbXCXKlc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 06:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbXCXKlc
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 06:41:32 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:40194 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbXCXKlb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 06:41:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070324104131.RYBV748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 24 Mar 2007 06:41:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id eahW1W0011kojtg0000000; Sat, 24 Mar 2007 06:41:30 -0400
In-Reply-To: <20070324102652.GA15474@thunk.org> (Theodore Tso's message of
	"Sat, 24 Mar 2007 06:26:52 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42993>

Theodore Tso <tytso@mit.edu> writes:

> On Sat, Mar 24, 2007 at 08:14:31AM +0000, Andy Parkins wrote:
>> So: ideally, what /I/ would like is that git distributes the script in a 
>> standard location like /usr/share/doc/git/contrib/post-receive-emailer 
>> with the execute bit already set; that can be easily linked to or 
>> called from the actual post-receive hook.
>
> I wonder if this is a good idea to do for all or most of the template
> scripts, so that they can get automatically updated when git is
> updated, instead of having the problem we had before where the hook
> script got updated to match changes in git, but ancient repositories
> would still have the old script.

I do agree that dealing with ancient scripts that casually used
implementation details that later versions broke is a problem.

But the recent updates to the mail-hook are backward compatible
only in the sense that as long as the user configures it, the
new script can mimic old version's behaviour (in other words, it
was not backward compatible at all).  I think forcing updates to
the hooks automatically is worse.  I'd rather keep hooks private
to repository owner's concern.

While I think it would be great to have a central clearinghouse
for people to share and enjoy useful hook collections for
various workflows and use cases, I do not necessarily think
inside git.git project itself is the best place to do so.
