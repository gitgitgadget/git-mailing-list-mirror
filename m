From: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] git-pasky-0.7
Date: Sat, 23 Apr 2005 22:11:30 -0700
Message-ID: <20050424051130.GA25332@kroah.com>
References: <20050423205847.7758bfaa.pj@sgi.com> <Pine.LNX.4.21.0504240018350.30848-100000@iabervon.org> <20050423220236.26f834ee.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, pasky@ucw.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 07:07:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPZL1-0008IN-GB
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 07:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVDXFMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 01:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVDXFMJ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 01:12:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:29091 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262260AbVDXFMC (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 01:12:02 -0400
Received: from [192.168.0.10] (c-24-22-118-199.hsd1.or.comcast.net [24.22.118.199])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j3O5Bvi31880;
	Sat, 23 Apr 2005 22:11:57 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DPZP1-6bP-00; Sat, 23 Apr 2005 22:11:31 -0700
To: Paul Jackson <pj@sgi.com>
Content-Disposition: inline
In-Reply-To: <20050423220236.26f834ee.pj@sgi.com>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 23, 2005 at 10:02:36PM -0700, Paul Jackson wrote:
> The winning solution via private email:
> 
> 	mkdir linux
> 	cd linux
> 	git init rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> Another email was missing the 'scm' term.
> 
> I still don't see how to get to the official 2.6.12-rc3:
> 
> 	a2755a80f40e5794ddc20e00f781af9d6320fafb

 From your "linux" directory do:
 	cd ..
	mkdir 2.6.12-rc3
	cd 2.6.12-rc3
	mkdir .git
	cp -rl ../linux/.git/object .git/objects
	TREE_HEAD=`cat-file commit a2755a80f40e5794ddc20e00f781af9d6320fafb | head -n 1 | cut -f 2 -d " "`
	echo "$TREE_HEAD" > .git/HEAD
	read-tree $TREE_HEAD
	checkout-cache -a
	update-cache --refresh

And you should have a 2.6.12-rc3 tree, all ready to commit new changes
into.

Or at least that's how my wrapper scripts do it, I haven't converted
them over to the "easier" git-pasky commands yet :)

thanks,

greg k-h
