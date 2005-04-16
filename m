From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Merge with git-pasky II.
Date: Sat, 16 Apr 2005 05:19:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0504160518310.21837@qynat.qvtvafvgr.pbz>
References: <7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
 <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org> <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org>
 <1113559330.12012.292.camel@baythorne.infradead.org>
 <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org> <20050416014442.GW4488@himi.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 14:18:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMmEs-0008Sf-1p
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 14:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVDPMUx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 08:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVDPMUx
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 08:20:53 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:43203 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S261473AbVDPMUq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 08:20:46 -0400
Received: from wlvims01.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Sat, 16 Apr 2005 05:20:45 -0700
Received: by calexc01.diginsite.com with Internet Mail Service (5.5.2657.72)
	id <24Z9DJC9>; Sat, 16 Apr 2005 05:19:32 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 29YX1LJF; Sat, 16 Apr 2005 05:19:24 -0700
To: simon@himi.org
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <20050416014442.GW4488@himi.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 15, 2005 at 08:32:46AM -0700, Linus Torvalds wrote:
> In other words, I'm right. I'm always right, but sometimes I'm more 
right
> than other times. And dammit, when I say "files don't matter", I'm 
really
> really Right(tm).
>
You're right, of course (All Hail Linus!), if you can make it work
efficiently enough.

Just to put something else on the table, here's how I'd go about
tracking renames and the like, in another world where Linus /does/
make the odd mistake - it's basically a unique id for files in the
repository, added when the file is first recognised and updated when
update-cache adds a new version to the cache. Renames copy the id
across to the new name, and add it into the cache.

This gives you an O(n) way to tell what file was what across
renames, and it might even be useful in Linus' world, or if someone
wanted to build a traditional SCM on top of a git-a-like.

Attached is a patch, and a rename-file.c to use it.

Simon

given that you have multiple machines creating files, how do you deal with 
the idea of the same 'unique id' being assigned to different files by 
different machines?

David Lang



-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
