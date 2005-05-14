From: Petr Baudis <pasky@ucw.cz>
Subject: Re: speeding up cg-log -u
Date: Sat, 14 May 2005 12:39:37 +0200
Message-ID: <20050514103937.GA3905@pasky.ji.cz>
References: <20050514061914.GB14353@tumblerings.org> <7vu0l62l27.fsf@assigned-by-dhcp.cox.net> <20050514061914.GB14353@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat May 14 12:39:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWu3Z-0007nz-0k
	for gcvg-git@gmane.org; Sat, 14 May 2005 12:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbVENKjl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 06:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbVENKjl
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 06:39:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63636 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262618AbVENKjj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 06:39:39 -0400
Received: (qmail 5136 invoked by uid 2001); 14 May 2005 10:39:37 -0000
To: Zack Brown <zbrown@tumblerings.org>,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0l62l27.fsf@assigned-by-dhcp.cox.net> <20050514061914.GB14353@tumblerings.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 14, 2005 at 08:19:14AM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> Currently cg-log handles this by grabbing all the log data from git, and
> then grepping through it.

Which is clearly suboptimal since cg-log now does git-cat-file up to
_three_ times per commit. It should instead process the commit only
once.

Dear diary, on Sat, May 14, 2005 at 11:50:24AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> +	buffer = read_sha1_file(item->object.sha1, type, &size);

If it do that, I wonder how much speedup would be using this instead.
But probably still significant one.

What I don't like is that it searches only the author field. I find the
behaviour that it searches in the committer field as well very useful,
since I can easily check whose patches on a file I checked it - that's
useful when porting own stuff to another branch, or frequently it's the
only thing I actually remember. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
