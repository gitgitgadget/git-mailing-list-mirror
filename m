From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Introduce Git.pm (v3)
Date: Fri, 23 Jun 2006 14:39:04 +0200
Message-ID: <20060623123904.GL21864@pasky.or.cz>
References: <7v1wtghga6.fsf@assigned-by-dhcp.cox.net> <20060623011205.GJ21864@pasky.or.cz> <7vejxgckq9.fsf@assigned-by-dhcp.cox.net> <m1k678yt6m.fsf@ebiederm.dsl.xmission.com> <20060622220201.19132.67536.stgit@machine.or.cz> <7vlkrohj9p.fsf@assigned-by-dhcp.cox.net> <20060622235017.GH21864@pasky.or.cz> <7v1wtghga6.fsf@assigned-by-dhcp.cox.net> <20060623011205.GJ21864@pasky.or.cz> <7vejxgckq9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 14:39:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtkwJ-00015N-0j
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 14:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWFWMjI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 08:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWFWMjI
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 08:39:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52706 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750731AbWFWMjH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 08:39:07 -0400
Received: (qmail 24418 invoked by uid 2001); 23 Jun 2006 14:39:04 +0200
To: Junio C Hamano <junkio@cox.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Content-Disposition: inline
In-Reply-To: <m1k678yt6m.fsf@ebiederm.dsl.xmission.com> <7vejxgckq9.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22416>

Dear diary, on Fri, Jun 23, 2006 at 10:57:50AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Also, is there any real problem with just using -fPIC?
> 
> Personally, not really, but I consider it a workaround having to
> compile with -fPIC (being able to compile with -fPIC is a
> feature).

Well, for the .xs you do need an .so and for that you apparently need
-fPIC on most architectures, so there's no way around it.

There's a patch to build libgit.so, would you take it as an excuse to
always compile with -fPIC? ;-)

> Doesn't it have performance implications to use -fPIC when you
> do not have to?

No idea here.

> By the way, you also need to adjust the testsuite so that it
> finds the Perl modules from freshly built tree before
> installing.  I think (but haven't checked yet) the stuff written
> in Python does that already, so you might want to mimic it.

It should be enough to -I../perl/blib/lib -I../perl/blib/arch/auto/Git.


Dear diary, on Fri, Jun 23, 2006 at 02:04:17PM CEST, I got a letter
where "Eric W. Biederman" <ebiederm@xmission.com> said that...
> The question is why are we building with a .so?

To make use of it in Git.pm - it can call libgit routines directly from
inside of Perl, but for that it needs to dynamically link libgit to the
Perl process on the fly (using dlopen()).

We _can_ avoid the .so, but that involved producing a new perl
executable with libgit statically linked to it, which is quite
impractical, so to say.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
