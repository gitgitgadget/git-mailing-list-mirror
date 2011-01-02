From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: Re: how to update a submodule?
Date: Sun, 2 Jan 2011 15:55:14 +0000
Message-ID: <20110102155514.GB32745@cs-wsok.swansea.ac.uk>
References: <20101231222438.GA28199@cs-wsok.swansea.ac.uk> <201012312342.oBVNg1lx021930@no.baka.org> <20110101203957.GC26920@cs-wsok.swansea.ac.uk> <4D2061C7.5050405@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Robertson <in-gitvger@baka.org>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 02 16:55:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZQHI-0000ig-E3
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 16:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578Ab1ABPzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 10:55:18 -0500
Received: from laurel.swan.ac.uk ([137.44.1.237]:59656 "EHLO laurel.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339Ab1ABPzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 10:55:16 -0500
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by laurel.swan.ac.uk with esmtp (Exim 4.72)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1PZQH4-0006fQ-VE; Sun, 02 Jan 2011 15:55:15 +0000
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id 9E2AF1C1EA3;
	Sun,  2 Jan 2011 15:55:14 +0000 (GMT)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id 89FAC741EB; Sun,  2 Jan 2011 15:55:14 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <4D2061C7.5050405@web.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164418>

On Sun, Jan 02, 2011 at 12:30:15PM +0100, Jens Lehmann wrote:
> Am 01.01.2011 21:39, schrieb Oliver Kullmann:
> > On Fri, Dec 31, 2010 at 06:42:01PM -0500, Seth Robertson wrote:
> > As far as I see that, this doesn't concern the problem how to I update
> > one repository with submodules from another repository with "these" submodules
> > (as the same paths)?
> 
> I'm not sure I completely understand your use case, but submodules are
> repositories of their own, so they don't get updated by just pulling
> a superproject into another containing the same submodule. The submodule
> changes have to be pushed to its own parent repository and can then be
> fetched from there into another superproject's submodule.
>

I know that --- but if there wouldn't be any savings possible (in terms of using it),
then submodules would be pointless, and so the question is *how* to use them.

I see that my use-case is not understood so I try it:

The good thing with Git is that there are no central repositories.
That's exactly what I want to use, but again and again the automatic
assumptions of "central repositories" are made, which should be actually alien to Git.

More concretely: For a collaboration on a scientific paper (where more and more
people have never seen each other, and this is also the case here) one doesn't
use version-control yet because of all this server-nonsense. Now with Git we can
just toss tarballs of git-archives around! Sent via e-mail (please note that zero
knowledge of git-remotes or whatever is required for that --- that's very important),
these archives float around, without any URL or central repository, but they
are locally merged and whatever. I think that's exactly exploiting the Git philosophy.

So I have a couple of those. Then I have modules to teach, where I organise also various
forms of collaborations with colleagues and students (various networks, various levels
of security).

Then there are software projects. Some private, some not.

All of that happens independently. I have at this time around 15 of such active projects
(some smaller, some rather big).

Now it happens that things are forgotten, updates aren't done, I just forget to copy
a repository from one place to another, etc.
Important that from my main working place at home to the main university working place
there is no network connection, but memory sticks do the job (which is fine and safe).

Sure, I can (and perhaps have to) start writing scripts, which just exploit basic git,
and add some form of super-organisation on top of it.

However I still hope that the task is so common that I can use tools.

To summarise: At some point in time on some machine, a super-repository A is updated,
from various (permanently changing) places etc. No problem with pull itself.
The submodules each needs to be taken care of individually.

Okay, but then I want to take that whole thing, the supermodule with the 15 (or more)
submodules, copy it to the memory stick, and on my workplace untar it (decrypt it ...),
and update a super-repository B *over there*, just from A, which has nothing to
do how I created A (on a different machine, completely different circumstances).

It seems to fully comply with the original Git philosophy, that I can make some
form of "super-pull" from B, getting everything from A --- without the assumption
of some central URL (repository), neither for the supermodule nor for the submodules.
Just pulling everything over, as it happens with ordinary "git pull".

 
> > Actually, even the simplest case of just cloning a repository with submodules
> > doesn't work:
> > After cloning, "git submodule status" shows "-", okay so I do "git submodule init",
> > which already shows a false understanding --- it shows the URL of the old repository,
> > from which the original submodule originated, which is long gone and no longer relevant.
> > Then of course "git submodule update" fails, and in the submodule there is just nothing.
> 
> Then the URL of the submodule in the .gitmodules file is not up to
> date. You can either fix it there or - if you only want to change it
> locally - edit the .git/config after the "git submodule init" copied
> it there.
>

That file .gitmodule seems to enforce the central structure, contradicting the original
(and great!) Git insight of fully distributed version control.
 
> > The problem seems to be that the information about the place where to update a
> > submodule is in .gitmodules, which git actually has under version control (different
> > from other configuration information), and thus copies it verbatimly.
> > Okay, then apparently after a clone .gitmodules has to be updated (by hand).
> 
> No, the problem seems to be that the remote URL in the submodule has
> been changed directly without updating it in the .gitmodules of the
> superproject (the recommended way to do that is to change it in the
> .gitmodules file and then use "git submodule sync" to activate it).
>

Again, I hope by now it is clear that in my cases it makes no sense
to attribute an URL to the submodule.
 
> > So .gitmodules concerns only "git submodule update", not "git pull" from within
> > the submodules? This would be good to know, to understand the role of the information
> > in .gitmodules (where the task of "git submodule init" is apparently just to
> > transport this information to .git/configure ?).
> > 
> > This has the disadvantage, that one has to publish this private
> > information about the places where by chance one is pulling from?
> 
> Yes, the submodules URL must be available - at least for fetching -
> to everyone who wants to clone your superproject (and all changes
> made in the submodule which are committed in the superproject must
> have been pushed there to be able to check them out in the clone).
>

Then submodules would be a wrong concept, as it seems to me, contradicting
decentralised version control. Still I have the hope that actually
submodule can be used, but apparently that file .gitmodules is in the way
(false information is much worse than no information!).
 
> > Perhaps I should then put .gitmodules into .gitignore? Or would that have
> > bad consequences??
> 
> Yes, because then git won't know where the it can clone the submodules
> from when you clone your superproject somewhere else.

But that would be what is needed --- there is no "somewhere else", but
just the given repository.

Puuuh, I really really tried hard now to make my use-case clear :-|. Hopefully
now the picture emerges.

Thanks for your considerations! And I hope you don't mind me speaking of
"contradictions" etc., but I feel there are fundamental misunderstandings.

Thanks!

Oliver
