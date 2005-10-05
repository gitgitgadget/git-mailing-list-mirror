From: Junio C Hamano <junkio@cox.net>
Subject: Re: Notes and questions while reading the documentation
Date: Wed, 05 Oct 2005 16:30:01 -0700
Message-ID: <7v1x2zfsp2.fsf@assigned-by-dhcp.cox.net>
References: <1128549966.11363.29.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 01:31:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENIiQ-0002Yl-7Y
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 01:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbVJEXaX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 19:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbVJEXaX
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 19:30:23 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:52891 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030423AbVJEXaX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 19:30:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051005232957.XSKM16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Oct 2005 19:29:57 -0400
To: Christian Meder <chris@absolutegiganten.org>
In-Reply-To: <1128549966.11363.29.camel@localhost> (Christian Meder's message
	of "Thu, 06 Oct 2005 00:06:06 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9746>

Christian Meder <chris@absolutegiganten.org> writes:

> * a lot of the manpages include something like "v0.1, June 2005" in the
> header; these versions tags are pretty obscure to interpret, timestamp
> when last edited ? version of the manpage ? version of git when the
> manpage was included ? maturity the author assigned to the content ?
> If these tags don't follow some sane schema they should be removed.

I think the original intent was the last modification datestamp
and the version of the documentation, but I agree it should be
removed.  I do not think they show on the HTML version, nor man
pages, although I have to admit that I haven't looked at
generated manpages for some time.

> * git-applymbox: -q for interactivity seems like a strange choice, ok I
> knew -i for interactive and -q for quiet but -q for interactive editing
> is _not_ really intuitive

Last night I felt the same way, and an rewrite [*1*] of
applymbox I am working on uses '-i' instead.  If users do not
object, I would vote for changing applymbox to use '-i' as well.

The user community consensus does not have to be unanimous, but
anybody who has linux kernel tree on kernel.org servers has a
veto on this, I should say.  It's the tool they use every day.

> * the usage of git, Git and GIT isn't consistent in the documentation.
> I'd vote for only using git.

Sounds sane.  What would we do if we need to start sentences with it?

> * git-clone says that http transport is not supported yet I used it to
> clone the git repo from kernel.org yesterday. Should the documentation
> get updated ?

Thanks for noticing.  Yes, now HTTP can handle both of the
trickier setups (packed, and alternates); credit goes to Daniel.

> * the manpage synopsises aren't consistent wrt command naming; it's "git
> commit" but "git-branch"; I guess all the manpages should reference
> their commands as "git-x" and not "git x"

Agreed.

Again, thanks for taking the time to do this.

[Footnote]

*1* Why rewrite?  One reason was I was afraid to break things
for Linus ;-).  And I wanted to add a bit more interactivity and
restartability.  The ultimate goal is to make 'git-rebase' and
'git-cherry-pick' faster and easier to use.  The idea is not to
always do 3-way merge, but essentailly feed format-patch output
(now it can do --stdout) into the new applymbox, and when patch
applies cleanly things will go faster, otherwise it will fall
back to 3-way merge behaviour.
