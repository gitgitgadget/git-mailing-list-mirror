From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git-pasky file mode handling
Date: Sat, 16 Apr 2005 16:56:50 +0200
Message-ID: <20050416145650.GB19099@pasky.ji.cz>
References: <20050416104559.A12943@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat Apr 16 16:53:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMofk-0002me-0e
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 16:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbVDPO47 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 10:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbVDPO47
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 10:56:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:1774 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262675AbVDPO44 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 10:56:56 -0400
Received: (qmail 25244 invoked by uid 2001); 16 Apr 2005 14:56:50 -0000
To: Russell King <rmk@arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20050416104559.A12943@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 16, 2005 at 11:45:59AM CEST, I got a letter
where Russell King <rmk@arm.linux.org.uk> told me that...
> Hi,

Hello,

> It seems that there's something weird going on with the file mode
> handling.  Firstly, some files in the git-pasky repository have mode
> 0664 while others have 0644.
> 
> Having pulled from git-pasky a number of times, with Petr's being the
> "tracked" repository, I now find that when I do an update-cache --refresh,
> it complains that the files need updating, despite show-diff showing no
> differences.  Investigating, this appears to be because the file modes
> are wrong for a number of the files.  All my files do not have group
> write.

this is was a problem with git apply, which did not apply mode changes
correctly until recently. If you have no local changes,

	checkout-cache -f -a

should fix this. Hopefully.

> I notice in the changelog what appears to be a dependence on the umask.
> If this is so, please note that git appears to track the file modes,
> and any dependence upon the umask is likely to screw with this tracking.

I personally don't think I like the mode tracking at all. Some people
(Linus?) may want to have group +w. Other people (me) have their default
group as 'users', and I definitively don't want everyone to be able to
write to the files. :-)

I think we should track only whether the file is executable or not.
Linus?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
