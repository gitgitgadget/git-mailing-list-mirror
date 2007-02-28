From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 12:58:24 -0500
Message-ID: <20070228175824.GF5924@spearce.org>
References: <17893.43522.511785.121778@lisa.zopyra.com> <17893.44181.129918.669187@lisa.zopyra.com> <20070228163256.GD5479@spearce.org> <118833cc0702280842g3e121fg601d7e102956ba93@mail.gmail.com> <20070228164922.GB5924@spearce.org> <17893.46083.869042.467318@lisa.zopyra.com> <20070228170641.GC5924@spearce.org> <17893.47007.136145.112498@lisa.zopyra.com> <20070228174339.GE5924@spearce.org> <alpine.LRH.0.82.0702281249430.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 18:58:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMT4S-0000vm-1o
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 18:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbXB1R6a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 12:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbXB1R6a
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 12:58:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58110 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbXB1R63 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 12:58:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HMT4G-0002Fj-Cx; Wed, 28 Feb 2007 12:58:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E5C1220FBAE; Wed, 28 Feb 2007 12:58:24 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LRH.0.82.0702281249430.29426@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40978>

Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 28 Feb 2007, Shawn O. Pearce wrote:
> > Bill Lear <rael@zopyra.com> wrote:
> > > Yes: 1.4.x worked fine.  This was actually my attempt to re-do the 1.4
> > > clone I had laying around, as I wanted my backup done with 1.5.  I
> > > still have the 1.4 cloned repo, just moved it out of the way...
> > 
> > But I fail to see anything in index-pack that would cause this,
> > and its the only program that knows about this file at this stage
> > of the clone.
> 
> ... and Bill already said that the same clone operation, when not 
> performed on top of NFS, works fine.

Gah.  You're right.  And Bill also said the same clone works fine
on NFS, just so long as it is the Git 1.4.x series.  Which means
no pread/delta-resolving based index-pack.

Which leads me to believe something really horrible is happening in
the NFS server, like when we append to the packfile it truncates it.
Except during a clone we shouldn't append anything during the
delta resolution phase, as all delta bases should appear in that
one packfile.

Bill, are you sure someone isn't truncating your files on your NFS
server behind your back?  Is it an early April fool's joke from
a coworker?

-- 
Shawn.
