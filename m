From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/5] Add --remote option to send-pack
Date: Sun, 29 Apr 2007 02:10:06 -0400
Message-ID: <20070429061006.GU5942@spearce.org>
References: <Pine.LNX.4.64.0704281304360.28708@iabervon.org> <7vtzuzg26l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704290152410.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Apr 29 08:10:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hi2c2-000881-9a
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 08:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756241AbXD2GKT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 02:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756235AbXD2GKS
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 02:10:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52493 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756241AbXD2GKN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 02:10:13 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hi2bn-00009J-W7; Sun, 29 Apr 2007 02:10:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 15E9320FBAE; Sun, 29 Apr 2007 02:10:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704290152410.28708@iabervon.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45815>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> We're not pretending anything; remote has confirmed that the head that the 
> ref tracks has a particular new value (which we provided), so we should be 
> able to update the tracking ref to that value. I don't think it's 
> particularly important that we came by this information in the course of 
> an exchange that wasn't a fetch.

s/remote has confirmed/remote has claimed/

The only way to know the remote really did remember that
refs/heads/foo is now at 3c1718... is to perform some sort of
operation against it that makes it dump its refs back.  Trying to
push again, or trying to fetch does that.

There is also the possibility that a post-update or post-receive
hook will actually modify the ref *after* the push is "complete".
But that's like so crazy that I really don't think anyone has a
workflow that does that.  They might have such a hook that creates
a new ref however, or updates a totally unrelated ref (e.g. compile
the code and then update a "last-built" ref).

So in this particular case I have to agree with Daniel, its probably
OK to do what Cogito does and update the tracking branch after the
push was claimed to be successful by the remote.

-- 
Shawn.
