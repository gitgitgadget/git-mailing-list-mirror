From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Make git-revert & git-cherry-pick a builtin
Date: Thu, 1 Mar 2007 16:51:23 -0500
Message-ID: <20070301215123.GB9254@spearce.org>
References: <Pine.LNX.4.63.0703010526080.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vzm6xqj0d.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703012230290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 01 22:51:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMtBX-0003VW-Nk
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 22:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbXCAVvc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 16:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbXCAVvc
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 16:51:32 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49772 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030342AbXCAVvc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 16:51:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HMtBF-0007mn-7Q; Thu, 01 Mar 2007 16:51:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E63ED20FBAE; Thu,  1 Mar 2007 16:51:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703012230290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41132>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > +static int merge_recursive(const char *base_sha1,
> > > +		const char *head_sha1, const char *head_name,
> > > +		const char *next_sha1, const char *next_name)
> > > +{
> > > + ...
> > > +}
> > 
> > Somehow I would have expected you to call merge-recursive not spawn, but 
> > this is saner ;-).
> 
> I briefly considered this, until I realized that merge-recursive is no 
> builtin yet!

Heh, I expected the same thing as Junio when I first read through
the patch.  But then I realized that doing so right now might not
be a great idea; normally if merge-recursive aborts we say "fix up
and commit" and do a few things still in cherry-pick/revert before
giving the shell back to the user.

But a quick pass through merge-recursive.c says this may actually
be possible...
 
> Speaking of this issue: Would it be conceivable to make the standalones 
> into builtins? (This adds a dependency on libcurl to core Git programs, 
> but I could live with that... It would make a builtin fetch easier, too.)

Please don't make libcurl required.  I don't build with it on
Solaris, because its not there, and I don't need it there.

-- 
Shawn.
