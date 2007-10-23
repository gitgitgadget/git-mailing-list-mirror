From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Tue, 23 Oct 2007 00:05:22 -0400
Message-ID: <20071023040522.GX14735@spearce.org>
References: <20071016060456.GC13801@spearce.org> <Pine.LNX.4.64.0710161209480.25221@racer.site> <20071016195744.GB32132@closure.lan> <7v3aw2aaxu.fsf@gitster.siamese.dyndns.org> <20071023012140.GC22997@thunk.org> <7vtzoi8voo.fsf@gitster.siamese.dyndns.org> <20071023020044.GA27132@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 23 06:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkB1O-0003U8-Ld
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 06:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbXJWEF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 00:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbXJWEF2
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 00:05:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38589 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbXJWEF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 00:05:27 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IkB0x-0000Aq-E9; Tue, 23 Oct 2007 00:05:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1A61A20FBAE; Tue, 23 Oct 2007 00:05:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071023020044.GA27132@thunk.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62079>

Theodore Tso <tytso@mit.edu> wrote:
> On Mon, Oct 22, 2007 at 06:29:59PM -0700, Junio C Hamano wrote:
> > Well, the policy is never to commit directly on top of next
> > (iow, only merge other topics and nothing else).  Otherwise it
> > becomes hard to allow individual topics graduate to 'master'
> > independently.
> 
> I see.  So if it's non-trivial enough that you want it to "cook" in
> next for a cycle, you'll create a topic branch for it (based off of
> 'master'), and then force a merge into 'next'?

Yes.  Because 'next' always has commits in it that never appear in
'master'.  So any topic forked from master must merge into next.
It can't be a fast-forward.  No forced merging required.

Of course this isn't true for a new project.  That first topic
that forked from master to *create* next will be a fast-forward
as it creates next.  But that's no big deal.  The second topic will
merge into next, and that first topic can still be merged back into
master without merging next (or the second topic).

I was also doing the same thing Junio already explained to manage
next and pu while he was away.  Except I shortcut his:

	git checkout pu
	git reset --hard next

as:

	git branch -f pu next
	git checkout pu

as I'm was usually already sitting on next.  This saved my poor
little laptop from a second of IO chugging as it slewed around
between the two versions.  There were no files to update as it
switched from next to pu, and pu was already setup for merging
the proposed topics.  :-)

-- 
Shawn.
