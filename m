From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Trying to Update All Heads of a Repository
Date: Fri, 04 Nov 2005 08:49:40 -0600
Message-ID: <E1EY2su-0006LW-IN@jdl.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 15:51:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY2tA-0001QM-K7
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 15:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVKDOtr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 09:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVKDOtq
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 09:49:46 -0500
Received: from www.jdl.com ([66.118.10.122]:44976 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1750720AbVKDOtp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2005 09:49:45 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EY2su-0006LW-IN
	for git@vger.kernel.org; Fri, 04 Nov 2005 08:49:41 -0600
To: git@vger.kernel.org
In-Reply-To: 7vy8453zhu.fsf@assigned-by-dhcp.cox.net
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11130>


Junio says:
    My "pu" is somewhat special; it is rewound and rebased all the time,
    so merging with its older self would conflict with it.  That's why
    my example remotes/origin file has '+' in front of it.  It tells
    git-fetch that the other side _might_ rebase and fetch would not
    result in a fast-forward merge when that happens.

So, from the git-pull man page:

    For "git push", the local ref that matches <src> is used to fast
    forward the remote ref that matches <dst>. If the optional plus + is
    used, the remote ref is updated even if it does not result in a fast
    forward update.

Ah-ha!  Wait.  But here's the conceptual missing piece: When might I
_know_ I have the situation where a fast-forward update might not
happen?  And as a remote puller, that would be "never" -- unless I know
something about the nature of the remote end.  That is, like you said,
"pu" is subject to wild fluctuation and non-linear behavior.  But any
random puller can't know that a priori.  So far, that is out-of-band
information about a branch that needs to be "available".

I think my previous "Ah ha!" paragraph should be massaged and added to
the git-pull man page as part of the above (man page) quoted material.
That's one.


Junio explained:
>  Alternatively, with your original remotes/origin
> file, you should be able to do:
> 
>	$ git checkout master
>	$ git fetch origin master:origin +pu:pu maint:maint
>       $ git pull . origin

What an excellent example for the git-pull man page!  That's two.



Junio also exampled:

    My "guinea pig" repository has this in $GIT_DIR/remotes/origin:

	    URL: git://git.kernel.org/pub/scm/git/git.git
	    Pull: master:origin
	    Pull: +pu:pu
	    Pull: maint:maint

    This means that my "master" is copied to the "origin" branch of
    the guinea pig repository and "pu" and "maint" are copies of my
    "pu" and "maint" branches.  You never do your own development on
    branches that appear on the right hand side of colon on "Pull"
    lines (i.e. origin, pu and maint) in this repository.  They are
    to be updated by git-fetch.

The notion that multiple pull lines can be placed in the .git/remotes
file should be added to the git-pull man page.  That's three.

Furthermore, there is one very important guideline you just
stated in that paragraph:

    You never do your own development on branches that appear on the
    right hand side of colon on "Pull" lines in a repository.  They are
    to be updated by git-fetch.

And it might bear stating the corollary:

    The reason for a "Pull: master:origin" line is to side-step
    the above maxim and provide a unique place where the local
    developer can do her own work.

I'll consider that concept item four for the git-pull man page . :-)


> Sorry, my "pu" does not fast forward.  The branch is to showcase what
> I've received or picked up from the list, and what changes are under
> consideration for inclusion.

Heh.  I understand it now! :-)  No problem.


And finally:

> The "hold/draw" topic branch (thanks for your ASCII art) is fully
> merged into my "master"; in fact it's head is the master branch head.

That's five-ish.  I'm on deck for some git-pull man page and
drawing documentation patches.  Coming up Real Soon Now.

Thanks for the explanations!

jdl
