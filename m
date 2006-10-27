X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fetching packs and storing them as packs
Date: Thu, 26 Oct 2006 21:42:29 -0400
Message-ID: <20061027014229.GA28407@spearce.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610261105200.12418@xanadu.home> <45413209.2000905@tromer.org> <Pine.LNX.4.64.0610262038320.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 02:00:35 +0000 (UTC)
Cc: Eran Tromer <git2eran@tromer.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610262038320.11384@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30273>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdGk6-0001Z1-E1 for gcvg-git@gmane.org; Fri, 27 Oct
 2006 03:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946098AbWJ0Bmj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 21:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946099AbWJ0Bmj
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 21:42:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:12942 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1946098AbWJ0Bmi
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 21:42:38 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GdGjl-0002Xp-5I; Thu, 26 Oct 2006 21:42:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 58D0320E45B; Thu, 26 Oct 2006 21:42:30 -0400 (EDT)
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 27 Oct 2006, Eran Tromer wrote:
> 
> > Hi,
> > 
> > On 2006-10-26 17:08, Nicolas Pitre wrote:
> > > On Thu, 26 Oct 2006, Eran Tromer wrote:
> > >> This creates a race condition w.r.t. "git repack -a -d", similar to the
> > >> existing race condition between "git fetch --keep" and
> > >> "git repack -a -d". There's a point in time where the new pack is stored
> > >> but not yet referenced, and if "git repack -a -d" runs at that point it
> > >> will eradicate the pack. When the heads are finally updated, you get a
> > >> corrupted repository.
> > > 
> > > And how is it different from receiving a pack through git-unpack-objects 
> > > where lots of loose objects are created, and git-repack -a -d removing 
> > > those unconnected loose objects before the heads are updated?
> > 
> > git-repack -a -d does not touch unconnected loose objects.
> > It removes only unconnected packed objects.
> 
> Right.
> 
> > Only git-prune removes unconnected loose objects, and that's documented
> > as unsafe.
> 
> Well, the race does exist.  Don't do repack -a -d at the same time then.

This is an issue for "central" repositories that people push into
and which might be getting repacked according to a cronjob.

Unfortunately I don't have a solution.  I tried to come up with
one but didn't.  :-)

-- 
