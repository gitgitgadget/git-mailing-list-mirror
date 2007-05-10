From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Using StGIT for tweaking already-committed stuff
Date: Fri, 11 May 2007 00:23:47 +0200
Message-ID: <20070510222347.GB12366@diana.vm.bytemark.co.uk>
References: <1178794261.5806.98.camel@murta.transitives.com> <4643049C.3D5F30D8@eudaptics.com> <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070510171457.GK13719@fieldses.org> <87vef0350y.wl%cworth@cworth.org> <20070510192106.GB4489@pasky.or.cz> <87tzuk31fu.wl%cworth@cworth.org> <20070510200253.GD4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carl Worth <cworth@cworth.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>,
	catalin.marinas@gmail.com, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 11 00:24:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmH3R-0008CZ-Bt
	for gcvg-git@gmane.org; Fri, 11 May 2007 00:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110AbXEJWYF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 10 May 2007 18:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758356AbXEJWYF
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 18:24:05 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1614 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110AbXEJWYE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 18:24:04 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HmH35-0003bE-00; Thu, 10 May 2007 23:23:47 +0100
Mail-Followup-To: Petr Baudis <pasky@suse.cz>,
	Carl Worth <cworth@cworth.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, catalin.marinas@gmail.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070510200253.GD4489@pasky.or.cz>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46913>

On 2007-05-10 22:02:53 +0200, Petr Baudis wrote:

> On Thu, May 10, 2007 at 09:48:05PM CEST, Carl Worth wrote:
>
> > The -n option is something I hadn't noticed, and that helps,
> > (except that what I've got to start with is a git revision name,
> > not a number).
>
> Hmm, yes, I've been thinking myself that it would be quite nice if I
> could just tell uncommit git revname right away.

It shouldn't be hard to do. Instead of uncommitting a fixed number of
commits, loop until you reach a specified commit.

> > But there are still some places where an experienced git user runs
> > into some awkward situations trying to use stg. For example, "stg
> > refresh" is basically always doing the equivalent of "commit -a"
> > so there's annoyingly no way to refresh only some of the modified
> > state into the commit.
>
> Yes, I fear that StGIT hides the index in a similar way that Cogito
> does. It seems like user index usage is undergoing kind of
> renaissance these days in Git community (at least it seems to me
> this way, maybe it's always been this way), it would probably make
> sense to allow making use of index in StGIT as well.

I agree. It's bad UI for StGIT to behave different from git, given
that easy interoperation is a goal.

> > Also, if I want to edit a commit message while under the influence
> > of stg, how do I do that? If I do "git commit --amend" will I
> > seriously confuse stg, (I'm guessing I would, but I don't know).
>
> I have no idea, but there's stg refresh -e.

Yes, you would confuse it; the patch ref would still point to the old
commit object, but that would no longer be an ancestor of HEAD. StGIT
doesn't know how to recover from this, so you'd have to do it by hand,
which is annoying.

I'm working on making StGIT more robust against this kind of damage,
but I'm not quite done yet.

> And yes, it would be cool if stg new could guess patch name from the
> subject line in a similar manner that stg uncommit does.

Good idea. This would be embarrassingly easy to do.

But you can kind of do it today. Just commit with git (my favorite
here is the emacs modes) and "stg assimilate"!

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
