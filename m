From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Storing permissions
Date: Sun, 17 Apr 2005 10:51:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171045150.30848-100000@iabervon.org>
References: <42620092.9040402@dwheeler.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Jackson <pj@sgi.com>,
	Morten Welinder <mwelinder@gmail.com>, mj@ucw.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 16:48:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNB42-0000QR-Dg
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 16:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVDQOvk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 10:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVDQOvk
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 10:51:40 -0400
Received: from iabervon.org ([66.92.72.58]:42759 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261321AbVDQOvi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 10:51:38 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNB7l-0004yb-00; Sun, 17 Apr 2005 10:51:49 -0400
To: "David A. Wheeler" <dwheeler@dwheeler.com>
In-Reply-To: <42620092.9040402@dwheeler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, David A. Wheeler wrote:

> There's a minor reason to write out ALL the perm bit data, but
> only care about a few bits coming back in: Some people use
> SCM systems as a generalized backup system, so you can back up
> your system to an arbitrary known state in the past
> (e.g., "Change my /etc files to the state I was at
> just before I installed that &*#@ program!").
> For more on this, see:
>   http://www.onlamp.com/pub/a/onlamp/2005/01/06/svn_homedir.html
> 
> If you store all the bits, then you CAN restore things
> more exactly the way they were.  This is imperfect, since
> it doesn't cover more exotic permission
> values from SELinux, xattrs, whatever.  For some, that's enough.

I think this should be possible with a different tag than "tree". All the
bits aren't sufficient, anyway; the unincluded values include the user and
group, which are likely to matter for some things in /etc. But there's no
reason that the core can't support both a system-local complete
representation of the dentry and a user-relative representation of a
source distribution with different tags.

For that matter, it could accept "dir" objects in commits as well, and use
version-control-type logic on history while refusing to do non-sensical
things with them.

	-Daniel
*This .sig left intentionally blank*

