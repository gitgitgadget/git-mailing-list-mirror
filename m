From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Tue, 23 Oct 2007 01:07:26 -0400
Message-ID: <20071023050726.GD14735@spearce.org>
References: <Pine.LNX.4.64.0710161209480.25221@racer.site> <20071016195744.GB32132@closure.lan> <7v3aw2aaxu.fsf@gitster.siamese.dyndns.org> <20071023012140.GC22997@thunk.org> <7vtzoi8voo.fsf@gitster.siamese.dyndns.org> <20071023020044.GA27132@thunk.org> <20071023040522.GX14735@spearce.org> <20071023043321.GC27132@thunk.org> <20071023044657.GC14735@spearce.org> <20071023045632.GD27132@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 23 07:07:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkBzW-00083m-Er
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 07:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbXJWFHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 01:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbXJWFHd
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 01:07:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40461 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbXJWFHc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 01:07:32 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IkBzE-0003Qx-9m; Tue, 23 Oct 2007 01:07:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C89DF20FBAE; Tue, 23 Oct 2007 01:07:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071023045632.GD27132@thunk.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62091>

Theodore Tso <tytso@mit.edu> wrote:
> On Tue, Oct 23, 2007 at 12:46:57AM -0400, Shawn O. Pearce wrote:
> > By merging only individual topics forked from master into next you
> > can merge those individual topics into master at different points
> > in time.  For example db/fetch-pack has been in next for many weeks
> > and hasn't yet merged into master, yet jc/am-quiet was forked after
> > db/fetch-pack started and has already merged into master.
> > 
> > Your way would make jc/am-quiet wait until db/fetch-pack was ready.
> > That's a big risk in the sense that your tree is "blocked" and even
> > simple changes are held up by ones that suddenly became a lot more
> > complex then you originally thought they were going to be.
> 
> Yes, true.  Alternatively, what I've been doing is that if I wasn't
> sure that a particular topic was ready to go to 'master' very shortly
> after it went into 'next', I would never let it go into 'next', but
> rather keep it in 'pu' (which is OK, because pu is constantly getting
> rewound).  But I guess the downside of that is you might get fewer
> testers for the code, because fewer people are probably tracking and
> testing 'pu' as compared to 'next'.
> 
> Right?

Yes, that's a good point.

I think in Git part of the reason less people track pu is because
its very volatile.  Not because of the rewind policy, but becuase
sometimes the code there doesn't work properly so using it for real
"production" work is pretty risky.  On the other hand most of the
code that merges into next has been reasonbly well reviewed and
tested, so following it for "production" work is not as risky.

Junio has in the past proposed rewinding next, especially after a
significant release (e.g. 1.5.3).  A bunch of folks (myself included
if I recall correctly) didn't want to do this, as we create topic
branches locally from things in next and sometimes make commits
over them to improve the topic further.  But I also make topic
branches for things in pu, so I might as well just shut up and
not complain.  :-)

Of course another thought that just came to mind is it is very easy
for me to review next with a

	git log -p --reverse origin/next..build-next

just before merging it into my build branch and compiling it locally.
If next rewound frequently (as pu does) this would be more difficult.

-- 
Shawn.
