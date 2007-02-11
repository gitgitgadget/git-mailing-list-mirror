From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Efficiency of initial clone from server
Date: Sun, 11 Feb 2007 17:53:26 -0500
Message-ID: <20070211225326.GC31488@spearce.org>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 11 23:53:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGNZh-000786-Tz
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 23:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932822AbXBKWxd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 17:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932826AbXBKWxc
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 17:53:32 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51798 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932816AbXBKWxa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 17:53:30 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGNZP-0003AC-3L; Sun, 11 Feb 2007 17:53:19 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0AE4520FBAE; Sun, 11 Feb 2007 17:53:27 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39320>

Jon Smirl <jonsmirl@gmail.com> wrote:
> Is this happening because the repository on the server is not
> completely packed? It is basically building a pack of the whole thing
> and shipping it to me, right?

Correct.  The wire protocol only allows us to send one pack.
So we have to pack everything and transmit it as a single unit.
 
> If that is the case, why not first pack the whole repository and then
> copy it down the wire? Now the next clone that comes along doesn't
> have to do so much work. Would this help to eliminate some of the load
> at kernel.org?

Probably, but then the daemon needs write access to the repository.
This isn't required right now; it can be strictly read-only and
still serve the contents.
 
> remote: Total 63, written 63 (delta 0), reused 63 (delta 0)
> 100% (63/63) done
> fatal: pack: not a valid SHA1
> New branch: 0953670fbcb75e26fb93340bddae934e85618f2e

What version of git is this?  That looks like we're assuming the word
pack was an object, but I'm not sure why we would do such a thing...

-- 
Shawn.
