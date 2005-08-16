From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: Making note, in the repository, of push/pull relationships
Date: Tue, 16 Aug 2005 17:01:27 -0600
Organization: Hewlett Packard
Message-ID: <20050816230127.GA23831@hpsvcnb.fc.hp.com>
References: <20050815162519.GB9719@hpsvcnb.fc.hp.com> <7vzmrispi4.fsf@assigned-by-dhcp.cox.net> <20050816171142.GB20016@hpsvcnb.fc.hp.com> <7vll318u8b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 01:02:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5ARE-0007aa-Rp
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 01:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVHPXBi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 19:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVHPXBi
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 19:01:38 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:6273 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1750704AbVHPXBh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 19:01:37 -0400
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.15.136.253])
	by atlrel7.hp.com (Postfix) with ESMTP id 6708316D5;
	Tue, 16 Aug 2005 19:01:31 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP
	id 1192F41FF74; Tue, 16 Aug 2005 23:01:31 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 9C5903F35; Tue, 16 Aug 2005 17:01:27 -0600 (MDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vll318u8b.fsf@assigned-by-dhcp.cox.net>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 16, 2005 at 02:09:08PM -0700, Junio C Hamano wrote:
> And presumably you have .git/branches/myremotebranch file that
> says something like "master.kernel.org:/pub/scm/git/git.git".
> Or should the last line of relationships file be spelled just
> push:master:ko-master?

Oops, I did intend to add just that to .git/branches/myremotebranch.

> > % cat .git/remotes/ko
> > push: master:ko-master pu:ko-pu rc:ko-rc
> > pull: ko-master:master ko-pu:pu ko-rc:rc
> >
> > I might argue that this is now a job for a porcelain script or
> > something.
> 
> Probably.
> 
> My primary interest in discussing this is to see Porcelain folks
> agree on what notation and semantics to use, and probably set an
> example by having the minimum base in the barebone Porcelain.

This sounds good.

> Personally I think there are two kinds of patch-flow: one that
> is pretty much static that can easily be described with
> something like your relationships notation, and ad-hoc one that
> I think should not automatically contaminate the established
> static flow your relationships notation nicely describes.  The
> corporate world may put disproportional stress on the importance
> of the former, but my feeling is that ad-hoc patch-flow that is
> outside your usual static patch-flow is just as important; see
> Documentation/howto/using-topic-branches.txt for why.

I don't doubt the utility of these topic branches.  In fact, I think it
what he's doing with this is great.  This is exactly the kind of thing
the 'relationships' could help out with.

As he creates branches from existing branches, pushes, pulls and merges
between them the relationships files would maintain a record of this.
Let's say, for example, he made a change on speed-up-spinlocks and
merged it to test.  Later, a bug is found and he fixes the bug on the
speed-up-spinlocks branch.  Now, a script could run using the
relationships files that could immediately tell that the test branch is
behind the speed-up-spinlocks branch and that they should be merged.
For someone who has a lot of different things to do this will be
valuable.

I would leave maintenance of any static work flows up to the porcelains.
If a project chose to use some sort of static flow then it can simply
populate the relationships files to help drive pushing and pulling if
some rogue developer were to use git alone or some other porcelain (thus
maintaining compatibility between porcelains).  If a porcelain wanted to
be very strict about adherance to a static flow then checking the
relationships could tell if something 'bad' has been done outside of
that porcelain.

I hope I'm being clear.  Please let me know if something is not clear.

Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
