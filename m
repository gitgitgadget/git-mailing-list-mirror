From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 04:10:45 -0500
Message-ID: <20061019091045.GV75501@over-yonder.net>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <871wp6e7o9.wl%cworth@cworth.org> <45359B2A.1070102@utoronto.ca> <87y7rdd47j.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 19 11:11:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaTvc-0002w7-7X
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 11:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbWJSJKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 05:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWJSJKs
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 05:10:48 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:6357 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S1030353AbWJSJKr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 05:10:47 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id 4F36A2842A;
	Thu, 19 Oct 2006 04:10:46 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id CBE8061C52; Thu, 19 Oct 2006 04:10:45 -0500 (CDT)
To: Carl Worth <cworth@cworth.org>
Content-Disposition: inline
In-Reply-To: <87y7rdd47j.wl%cworth@cworth.org>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29334>

On Wed, Oct 18, 2006 at 08:38:24AM -0700 I heard the voice of
Carl Worth, and lo! it spake thus:
> 
> But as you already said, it's often avoided specifically because it
> destroys locally-created revision numbers.

I think this has the causality backward.  It's avoided because it
changes the ancestry of the branch in question, by rearranging the
left parents; this ties into Linus' assertion that all parents ought
to be treated equally, which I'm beginning to think is the base
lynchpin of this whole dissension.


Without a differentiation of the parents, there's no such creature as
a "mainline" on a branch, so it's hard to find anything to base revnos
on from the get-go; the whole discussion becomes meaningless and
incomprehensible then.

With the differentiation, numbering along the leftmost 'mainline'
makes sense, and fits the way people tend to work.  "I did this, then
I did this, then I merged in Joe's stuff, then I did this", and the
numbering follows along that.  And as long as it's the same branch,
those revnos will always be the same; I can't go back and add
something in between my first and second commits.  THAT'S where revnos
are useful; referring to a point on given branch.


Certainly, they're of no (or extremely limited) use when referring to
_different_ branches.  And when you change the arrangement of parents
on a branch, you create a different branch.  That's why bzr (the
project, not the program) tends toward trunks that are merged into,
rather than ephemeral trunks that are merged from and then replaced
with the new trunk, and has its UI optimized by default for that case;
because the ordering of the parents IS considered important and to be
preserved.  Ancestry changes aren't avoided because it would screw up
the revnos; the revnos don't get screwed up because the ancestry
changes are avoided for their OWN sake, and it's BECAUSE of that
pre-existing tendancy that the revnos could come into being in the
first place.


If you need to refer to a specific revision in a vacuum, a revno is
the *WRONG* tool for the job.  Revnos exist to refer to points along a
branch.  And in cases where there's a meaningful persistent branch, as
happens in most projects which have a trunk in some sense or another,
they can be the right tool for referring to points along that.


> So there are some aspects of the bzr design that rob from its
> ability to function as a distributed version control system. It
> really does bias itself toward centralization, (the so called "star
> topoloogy" as opposed to something "fully" distributed).

That depends on what you mean by 'bias' (and for that matter, what you
mean by 'centralization'; I think that's being used in very different
ways here).  If you don't care about the ancestry changes, you can go
ahead and change it around by merging and pushing like there's no
tomorrow, and it'll keep up just fine.  Some attributes of it like the
revnos which assume you do care about the ancestry simply cease to be
of any applicability.  That doesn't make it a useless feature, any
more than diff being inapplicable in a branch I'm using to store
binary files makes diff useless; it's just not one that's meaningful
in a given case.

bzr (the project) does care about the ordering of the parents, so it
doesn't do that.  bzr (the tool) assumes that the majority of its
users will care, which is why it has revnos; because in the case where
you don't disturb the ancestry of given branches, revnos are very
useful in reference to that branch.


> So even a project that's very oriented around a single, central tree
> can get a lot of benefit from being able to share things arbitrarily
> between any two given repositories.

I agree wholeheartedly.  That's one of the reasons I'm using bzr, even
though 95% or better of what I do is very oriented around single,
central trees, after all    8-}


-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.
