From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 16:49:57 -0400
Message-ID: <20050423204957.GA16751@delft.aura.cs.cmu.edu>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com> <426A4669.7080500@ppp0.net> <1114266083.3419.40.camel@localhost.localdomain> <426A5BFC.1020507@ppp0.net> <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org> <20050423183406.GD20410@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0504231228480.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 22:46:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPRVe-0007cm-0g
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 22:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVDWUuM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 16:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVDWUuM
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 16:50:12 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:24982 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261784AbVDWUuE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 16:50:04 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DPRZd-0004S8-00; Sat, 23 Apr 2005 16:49:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504231228480.2344@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 23, 2005 at 12:30:38PM -0700, Linus Torvalds wrote:
> On Sat, 23 Apr 2005, Jan Harkes wrote:
> > 
> > Why not keep the tags object outside of the tree in the tags/ directory.
> 
> Because then you have all those special cases with fetching them and with 
> fsck, and with shared object directories. In other words: no. 

I respectfully disagree,

rsync works fine for now, but people are already looking at implementing
smarter (more efficient) ways to synchronize git repositories by
grabbing missing commits, and from there fetching any missing tree and
file blobs. However there is no such linkage to discover missing tag
objects, only a full rsync would be able to get them and for that it has
to send the name of every object in the repository to the other side to
check for any missing ones.

So fetching tags is already going to be a special case.

And any form of validation of a tag is a special operation. In fact tags
could be as simple as a the sha of an (like pasky's tags) followed by
the detached pgp signature of the tagged object instead of trying to
signing the tag itself. That also avoids having to strip the signature
part from the tag when we want to validate it.

Jan
