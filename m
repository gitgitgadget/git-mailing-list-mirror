From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 01:05:25 +0200
Message-ID: <20080909230525.GC10360@machine.or.cz>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Sep 10 01:06:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdCI6-0007RE-Gu
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 01:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184AbYIIXF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 19:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754143AbYIIXF2
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 19:05:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43788 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754088AbYIIXF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 19:05:27 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 72EEA393A2DF; Wed, 10 Sep 2008 01:05:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080909225603.GA7459@cuci.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95455>

On Wed, Sep 10, 2008 at 12:56:03AM +0200, Stephen R. van den Berg wrote:
> The only way to perform the backports is by using cherry-pick.
> The history of each backport *is* important though.
> Since all the developers who care about the multiple release branches
> have all the relevant branches in their repository, the presence of
> a origin object is by no means random, it's a certainty.

Recording cherry-picks in your workflow certainly makes sense, but I'm
not talking about workflow-level issues here. You are adding an extra
header to the commit object. I'm talking about the object database and
low-level Git model implications this has.

In other way, I think this is purely a porcelain matter and recording
this information in the free-form area is more than enough.

> >Why do you actually *follow* the origin link at all anyway? Without its
> >parents, the associated tree etc., the object is essentially useless for
> >you; the authorship information and commit message should've been
> >preserved by a proper cherry-pick anyway. You're cluttering the object
> >store with invalid objects, which also breaks quite some fundamental
> >logic within Git (which assumes that if an object exists, all its
> >references are valid - give or take few special cases like shallow
> >repositories, but this would have very different characteristics).
> 
> I'd prefer to formalise the (weak) relationship of an origin link, instead of
> relying on vague assumptions when parsing the free-form commit message
> and then guessing what the mentioned hash might mean.

Why?

> >Having history browsers draw fancy lines is fine but I see nothing wrong
> >with them extracting this from the free-form part of the commit message.
> >For informative purposes, we don't shy away from heuristics anyway, c.f.
> >our renames detection (heck, we are even brave enough to use that for
> >merges).
> 
> It's not just that.  If I make a change to an area that was cherrypicked
> from another branch, then I find it rather important to check if any
> changes to this area need to be backported/forwardported to the branches
> the origin links are pointing to.
> I.e. the origin link allows me to improve my efficiency as a programmer.

And why are the notes created by git cherry-pick -x insufficient for that?

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
