From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Sun, 10 Jul 2005 09:51:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507100942020.17536@g5.osdl.org>
References: <Pine.LNX.4.58.0507071658460.25104@g5.osdl.org>
 <12c511ca050707170964a2cc92@mail.gmail.com> <Pine.LNX.4.58.0507071720330.25104@g5.osdl.org>
 <20050709225818.A31045@flint.arm.linux.org.uk> <20050709232955.B31045@flint.arm.linux.org.uk>
 <7vpstrv8z6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507092158290.17536@g5.osdl.org>
 <Pine.LNX.4.58.0507092211470.17536@g5.osdl.org> <20050710075548.A11765@flint.arm.linux.org.uk>
 <7v4qb3uo63.fsf@assigned-by-dhcp.cox.net> <20050710134624.B3279@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Tony Luck <tony.luck@gmail.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 18:52:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Drf1s-0007Qm-Rs
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 18:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVGJQve (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 12:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVGJQve
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 12:51:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25541 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261972AbVGJQvd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 12:51:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6AGpHjA029449
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 10 Jul 2005 09:51:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6AGpG1N022972;
	Sun, 10 Jul 2005 09:51:16 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050710134624.B3279@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 10 Jul 2005, Russell King wrote:
> 
> It means that rsync --delete-after can (in theory) be used when
> making changes available to the upstream maintainer.

I'd suggest against that from a safety standpoint (no backups), but what 
you _can_ do is to upload only the objects I don't have. 

This actually works - I already synced several weeks ago with Paul 
Mackerras, who had made his ppc64 git thing contain only the objects that 
I didn't have.

In other words, if you have my tree pointed to by
GIT_ALTERNATE_OBJECT_DIRECTORIES, and you populate your tree only with new
files, you can actually upload that small "sparsely populated" tree as-is
(without any of the objects that came from my tree), and I should be able
to pull it as-is.

Well, at least with rsync. I think my git "pack" send/receive thing might
be unhappy about a partial tree, but that's something I can fix, so if
this makes it easier for people (you can create a totally new tre _really_ 
cheaply and also upload it and move it around very cheaply), then I'm ok 
with pulling from partial repositories, and I have indeed already done so 
in the past.

Btw, if people start doing this, then I really think we want a 
".git/config" file, so that you can have different alternate object 
directories for different git directories without having to remember to 
set the environment variables all the time.

		Linus
	
