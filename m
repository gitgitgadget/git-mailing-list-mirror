From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Alternate revno proposal (Was: Re: VCS comparison table)
Date: Fri, 20 Oct 2006 07:38:42 +0200
Message-ID: <20061020053842.GA28219@artax.karlin.mff.cuni.cz>
References: <20061018214623.GA32725@artax.karlin.mff.cuni.cz> <200610200209.k9K29ncC006935@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Collins <robertc@robertcollins.net>,
	Petr Baudis <pasky@suse.cz>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 07:38:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gan5d-0006RM-Ek
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 07:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992498AbWJTFii (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 01:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992500AbWJTFii
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 01:38:38 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:30438 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S2992498AbWJTFig (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 01:38:36 -0400
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196)
	id 8922A4A40; Fri, 20 Oct 2006 07:38:42 +0200 (CEST)
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200610200209.k9K29ncC006935@laptop13.inf.utfsm.cl>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29410>

On Thu, Oct 19, 2006 at 11:09:49PM -0300, Horst H. von Brand wrote:
> Jan Hudec <bulb@ucw.cz> wrote:
> 
> [...]
> 
> > Reading this thread I came to think, that the revnos should be assigned
> > to _all_ revisions _available_, in order of when they entered the
> > repository (there are some possible variations I will mention below)
> > 
> >  - Such revnos would be purely local, but:
> >    - Current revnos are not guaranteed to be the same in different
> >      branches either.
> >    - They could be done so that mirror has the same revnos as the
> >      master.
> 
> Then they are almost useless (except for people working alone). You need to
> be able to talk about a particular commit with others working independently.

As they currently are you can't either. Because currently it is
guaranteed that the revnos will be the same in two branches with the
same current revision. But when the current revisions differ, the
numbers may as well.

Moreover currently they can change for the same branch over time, while
with the alternate proposal they would not, so you could reliably say
revision 567 on foo.

> >  - They would be easier to use than the dotted ones. What (at least as
> >    far as I understand) makes revnos easier to use than revids is, that
> >    you can remember few of them for short time while composing some
> >    operation. Ie. look up 2 or 3 revisions in the log and than do some
> >    command on them. And a 4 to 5-digit number like 10532 is easier to
> >    remember than something like 3250.2.45.86.
> 
> Probably. In git you can (mostly) get away with partial SHA-1's, BTW.

1) Partial sha-1 is still longer (starts being useful at 6 digits,
   usually you need 8)
2) Decimal numbers are easier to remember than hexadecimal ones.
3) The hashes are not oredered.

> >  - Their ordering would be an (arbitrary) superset of the partial
> >    ordering by descendance, ie. if revision A is ancestor of B, it would
> >    always have lower revno.
> >    - The intuition that lower revno means older revision would be always
> >      valid for related revisions and approximately valid for unrelated
> >      ones.
> >  - They would be *localy stable*. That is once assigned the revno would
> >    always mean the same revision in given branch (as determined by
> >    location, not tip).
> 
> Tip-relative is extremely useful: I wouldn't normally remember the current
> revision, but I'll probably often be talking about "the change before this
> one" and so on.

That's however separate issue. Negative numbers are tip-relative and
there are various prefixes in bzr (like before:, ancestor: etc.) for
relative revision addressing.

> >      - This is more than the current scheme can give, since now pull can
> >        renumber revisions.
> 
> Urgh. Get an update, and all your bearings change?

Currently yes. Currently pull changes the branch to be a mirror of the
pulled-from branch, including the way they are numbered.

> >  - They wouldn't make any branch special, so the objections Linus raised
> >    does not apply.
> 
> But the original branch /is/ special?

Some branches are usually special, but which they are may not
necessarily coincide with the left-parent lineage.

> >  - They would be the same as subversion and svk, and IIRC mercurial as
> >    well, use, so:
> >    - They would already be familiar to users comming from those systems.
> >    - They are known to be useful that way. In fact for svk it's the only
> >      way to refer to revisions and seem to work satisfactorily (though
> >      note that svk is not really suitable to ad-hoc topologies).
> 
> SVN is /centralized/, there it does make sense talking about (the one and
> only) history. In a distributed system, potentially each has a different

Did you notice that I also said svk and mercurial? They both *ARE*
distributed (well, svk has it's limitations, but mercurial really very
similar to git).

> history, and they are intertwined.
> 
> Not at all useful.

There are no global persistent revision numbers in a distributed system.
There can't be. But numbers with limited scope can still be really
useful. The question is what that scope should be.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
