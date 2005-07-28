From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Thu, 28 Jul 2005 17:52:10 +0200
Message-ID: <20050728155210.GA17952@pasky.ji.cz>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca> <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com> <20050722192424.GB8556@mars.ravnborg.org> <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net> <20050722205948.GE11916@pasky.ji.cz> <7vd5p73jlu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Thu Jul 28 17:57:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyAk0-0003Cn-Bn
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 17:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVG1Pzr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 11:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVG1Pxg
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 11:53:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:15631 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261555AbVG1PwN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 11:52:13 -0400
Received: (qmail 19227 invoked by uid 2001); 28 Jul 2005 15:52:11 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5p73jlu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  after skimming through it, I think I completely like what you have
shown here. I'm only concerned about this:

Dear diary, on Mon, Jul 25, 2005 at 12:49:33AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
>     $ cat Documentation/.gitignore
>     # ignore generated html files,
>     # except foo.html which is maintained by hand
>     !foo.html
>     *.html

  I think this is wrong, and my brief experiments confirm that. I think
that the actually useful semantics of exclusion would be for
_subsequent_ exclusions, not preliminary ones. You generally don't say
"I never want this ignored, but I want the rest of that ignored", but
"I want that ignored, except this". This also gives you more
flexibility:

	*.html
	!f*.html
	fo*.html

would ignore *.html and fo*.html, but not any other f*.html filenames.
But more importantly,

	.gitignore: *.txt
	Documentation/.gitignore: !*.txt

will not work, which was the whole _point_ of the exclusion.

Could we please have this semantics changed for those reasons?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
