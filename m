From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Calculating tree nodes
Date: Mon, 3 Sep 2007 22:51:54 -0400
Message-ID: <20070904025153.GS18160@spearce.org>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 04:52:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISOWJ-0006E2-Tc
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 04:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbXIDCv6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 22:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbXIDCv6
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 22:51:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55628 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbXIDCv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 22:51:57 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ISOVx-00045O-M3; Mon, 03 Sep 2007 22:51:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 38CD220FBAE; Mon,  3 Sep 2007 22:51:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57513>

Jon Smirl <jonsmirl@gmail.com> wrote:
> When I change a file it creates a new object with a new SHA. This new
> SHA causes the tree node pointing to it to change. Changing the tree
> node forces its parent to change and so on. Of course git batches all
> of the changes together into a commit so that this ripple effect
> doesn't happen for every file. But every commit causes a new root tree
> node to be created, right?

Only if at least one file (or tree) differed.  This may not be the
case if you do a merge with the ours merge strategy, but these are
very rare.  So you can pretty much just say that yes, every commit
causes a new root tree to be created.

Usually the smallest number of objects created per commit is 3:

  - the new commit
  - the new root tree
  - the new blob for a file in the root directory

The number increases as more files are modified or if they are in
subdirectories of the root.

-- 
Shawn.
