From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 16:29:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504231625470.2344@ppc970.osdl.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <42674724.90005@ppp0.net>
 <20050422002922.GB6829@kroah.com> <426A4669.7080500@ppp0.net>
 <1114266083.3419.40.camel@localhost.localdomain> <426A5BFC.1020507@ppp0.net>
 <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
 <20050423183406.GD20410@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0504231228480.2344@ppc970.osdl.org>
 <20050423204957.GA16751@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 01:23:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPTyH-0003ne-Es
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 01:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVDWX2O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 19:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVDWX2O
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 19:28:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:51659 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262173AbVDWX2H (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 19:28:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3NNRws4014332
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Apr 2005 16:27:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3NNRuxc021162;
	Sat, 23 Apr 2005 16:27:57 -0700
To: Jan Harkes <jaharkes@cs.cmu.edu>
In-Reply-To: <20050423204957.GA16751@delft.aura.cs.cmu.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Apr 2005, Jan Harkes wrote:
> 
> I respectfully disagree,
> 
> rsync works fine for now, but people are already looking at implementing
> smarter (more efficient) ways to synchronize git repositories by
> grabbing missing commits, and from there fetching any missing tree and
> file blobs.

Bit this is a _feature_.

Other people normally shouldn't be interested in your tags. I think it's a 
mistake to make everybody care.

So you normally would fetch only tags you _know_ about. For example, one 
of the reasons we've been _avoiding_ personal tags in teh BK trees is that 
it just gets really ugly really quickly because they get percolated up to 
everybody else. That means that in a BK tree, you can't sanely use tags 
for "private" stuff, like telling somebody else "please sync with this 
tag".

So having the tag in the object database means that fsck etc will notice 
these things, and can build up a list of tags you know about. It also 
means that you can have tag-aware synchronization tools, ie exactly the 
kind of tools that only grab missing commits can also then be used to 
select missing tags according to some _private_ understanding of what tags 
you might want to find..

		Linus
