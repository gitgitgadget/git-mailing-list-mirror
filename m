From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] fix compare symlink against readlink not data
Date: Fri, 6 May 2005 09:36:04 -0700
Message-ID: <20050506163603.GA17766@kroah.com>
References: <20050506134501.GA11430@vrfy.org> <20050506160359.GB6904@kroah.com> <1115396614.32065.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 18:33:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU5kh-0005dd-Kv
	for gcvg-git@gmane.org; Fri, 06 May 2005 18:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVEFQh7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 12:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVEFQh7
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 12:37:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:12678 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261222AbVEFQgF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 12:36:05 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j46Ga1i03939;
	Fri, 6 May 2005 09:36:01 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DU5o4-54R-00; Fri, 06 May 2005 09:36:04 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Disposition: inline
In-Reply-To: <1115396614.32065.23.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, May 06, 2005 at 06:23:34PM +0200, Kay Sievers wrote:
> On Fri, 2005-05-06 at 09:03 -0700, Greg KH wrote:
> > On Fri, May 06, 2005 at 03:45:01PM +0200, Kay Sievers wrote:
> > > Fix update-cache to compare the blob of a symlink against the link-target
> > > and not the file it points to. Also ignore all permissions applied to
> > > links.
> > > Thanks to Greg for recognizing this while he added our list of symlinks
> > > back to the udev repository.
> > 
> > Hm, even with this patch applied (it's in Linus's tree right now), I
> > still get the following with a clean checked out udev tree:
> >  $ cg-diff
> >  Index: test/sys/block/cciss!c0d0/device
> >  ===================================================================
> 
> I can't reproduce this. Are you sure, that the git-core binaries are
> called and not the cogito ones?
> 
>   git-update-cache --refresh
>   git-diff-cache -r HEAD
> from the core-git should print nothing.

Odd.  If I reclone the whole tree from the udev kernel.org tree, then it
works just fine.  If I create a new copy of my local tree, I still have
the same problem.  Diffing the trees shows no difference in the objects
at all...

Can you add a symlink to a local tree and see if you can duplicate this?

thanks,

greg k-h
