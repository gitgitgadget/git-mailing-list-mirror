From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Mon, 12 May 2008 20:09:25 -0400
Message-ID: <20080513000925.GA29038@spearce.org>
References: <20080512122900.GA13050@mithlond.arda.local> <20080512155243.GA3592@mithlond.arda.local> <e1dab3980805121017u4c244d25s76b39cf015f6c5c5@mail.gmail.com> <20080512234906.GX29038@spearce.org> <7vod7bw03a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tweed <david.tweed@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 02:10:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvi60-00045p-ES
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 02:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069AbYEMAJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 20:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756068AbYEMAJb
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 20:09:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59604 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496AbYEMAJa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 20:09:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jvi4y-00060G-FM; Mon, 12 May 2008 20:09:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 940CE20FBAE; Mon, 12 May 2008 20:09:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vod7bw03a.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81972>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >
> > I think git-clone marking a 150M linux-2.6 pack with .keep is wrong;
> > most users working with the linux-2.6 sources have sufficient
> > hardware to deal with the disk IO required to copy that with 100%
> > delta reuse.  But I have a repository at day-job with a 600M pack,
> > that's starting to head into the realm where git-gc while running
> > on battery on a laptop would prefer to have that .keep.
> 
> Perhaps clone can decide to keep the .keep file depending on the size of
> the pack then?

Yea, I think that's the better thing to do here.  I'm not sure where
the cut-off is, maybe its <512M delete the .keep once the refs are
inplace and the objects are ensured to be reachable.

Of course this does not fix the issue Nico was looking at.
We shouldn't be seeing a 98M explosion with objects duplicated
from the .keep pack into the new pack.

-- 
Shawn.
