From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Tue, 13 May 2008 01:22:32 -0400
Message-ID: <20080513052232.GH29038@spearce.org>
References: <20080512122900.GA13050@mithlond.arda.local> <20080512155243.GA3592@mithlond.arda.local> <e1dab3980805121017u4c244d25s76b39cf015f6c5c5@mail.gmail.com> <20080512234906.GX29038@spearce.org> <7vod7bw03a.fsf@gitster.siamese.dyndns.org> <20080513000925.GA29038@spearce.org> <48292243.3050307@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Tweed <david.tweed@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue May 13 07:23:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvmz4-0006AT-Bv
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 07:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755759AbYEMFWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 01:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755401AbYEMFWk
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 01:22:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56100 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451AbYEMFWj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 01:22:39 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JvmyA-00081w-BG; Tue, 13 May 2008 01:22:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0E38020FBAE; Tue, 13 May 2008 01:22:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <48292243.3050307@gnu.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81988>

Paolo Bonzini <bonzini@gnu.org> wrote:
> Shawn O. Pearce wrote:
> >Junio C Hamano <gitster@pobox.com> wrote:
> >>Perhaps clone can decide to keep the .keep file depending on the size of
> >>the pack then?
> >
> >Yea, I think that's the better thing to do here.  I'm not sure where
> >the cut-off is, maybe its <512M delete the .keep once the refs are
> >inplace and the objects are ensured to be reachable.
> 
> I think separate cutoffs should be in place for file size and number of 
> objects.  Very tight packs probably require hours to repack as efficiently.

So long as you don't use `gc --aggressive` or `repack -f` the
tightness of a pack doesn't matter; delta reuse means we copy the
tight delta from the source pack to the new destination pack.

However, you are correct that the more objects in the source pack
the longer it will take to compute what is reachable, which does
extend the time needed for even a simple git-gc.
 
-- 
Shawn.
