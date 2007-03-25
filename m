From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: .gitlink for Summer of Code
Date: Sun, 25 Mar 2007 17:03:22 -0400
Message-ID: <20070325210322.GF12376@spearce.org>
References: <1174825838.12540.5.camel@localhost> <vpqvegpe4e1.fsf@olympe.imag.fr> <20070325203901.GB12376@spearce.org> <Pine.LNX.4.63.0703252252500.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Eric Lesh <eclesh@ucla.edu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 25 23:03:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVZsC-00019b-Lu
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 23:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbXCYVDa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 17:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbXCYVD3
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 17:03:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60454 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932359AbXCYVD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 17:03:29 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HVZrw-0001Ob-0p; Sun, 25 Mar 2007 17:03:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EFF3320FBAE; Sun, 25 Mar 2007 17:03:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703252252500.4045@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43076>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 25 Mar 2007, Shawn O. Pearce wrote:
> > Yes.  But there's another project on the ideas list that addresses
> > that (``Lazy Clone'').  It is quite a bit more difficult than the
> > .gitlink idea as the implementation requires a network protocol
> > client implemented somewhere near the read_sha1_file interface.
> 
> Not only that. You'd have to change the way read_sha1_file() is called to 
> allow fetching more than one object at a time. Otherwise this will be so 
> slow as to be unusable.

Yes, and no. ;-)

Lets say we put a repository on an NFS share, and clone it using
--shared.  So it's now an alternate ODB.  And read_sha1_file()
is now doing synchronous reads, unless the client has something
cached.  Which we could just as easily cache ourselves in the
loose object directory

We could make it faster by batching up requests.  But batching
requests may be difficult in some contexts, as we don't know what
else we need until we get back that commit or tree we are trying
to read.  ;-)
 
-- 
Shawn.
