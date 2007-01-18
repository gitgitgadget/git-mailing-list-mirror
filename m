From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] prune-packed: new option --min-age=N
Date: Thu, 18 Jan 2007 12:51:34 -0500
Message-ID: <20070118175134.GH15428@spearce.org>
References: <20070118171830.GA13521@moooo.ath.cx> <20070118172408.GG15428@spearce.org> <20070118174244.GA14287@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 18:51:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7bQJ-0007mp-L0
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 18:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbXARRvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 12:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbXARRvi
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 12:51:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59046 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbXARRvh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 12:51:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H7bQ9-0005M9-Lb; Thu, 18 Jan 2007 12:51:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4816020FBAE; Thu, 18 Jan 2007 12:51:34 -0500 (EST)
To: Matthias Lederhofer <matled@gmx.net>
Content-Disposition: inline
In-Reply-To: <20070118174244.GA14287@moooo.ath.cx>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37128>

Matthias Lederhofer <matled@gmx.net> wrote:
> I just remembered people were warning about automatic prune-packed
> (e.g. cron), so this patch does not make much sense anymore.

I think we've resolved it.  There may be some hole we aren't aware
of, but I doubt one exists.  The last hole was packs could be
removed by repack while they were still being brought in during
push or 'fetch -k', but that was fixed with the .keep file.
 
> Any comments about adding such an option to git prune for unpacked
> objects?  This would allow to run git prune automatically on
> repositories while new objects are created.

An age makes sense on just plain prune.  If the loose object was
last modified several hours ago and its not being referenced by
anything currently, its probably safe to remove.

If you are going to implement this I would suggest making the default
age 2 hours and allow the user to configure it from a gc.pruneexpire
configuration option, much like gc.reflogexpire.

-- 
Shawn.
