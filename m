From: Petr Baudis <pasky@suse.cz>
Subject: Re: On blame/pickaxe
Date: Mon, 16 Oct 2006 04:21:59 +0200
Message-ID: <20061016022159.GZ20017@pasky.or.cz>
References: <7vr6xddm7h.fsf@assigned-by-dhcp.cox.net> <7vwt739org.fsf@assigned-by-dhcp.cox.net> <7vfydq79ae.fsf@assigned-by-dhcp.cox.net> <7vr6xddm7h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 04:22:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZI7C-0002Cd-NQ
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 04:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWJPCWB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 22:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWJPCWB
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 22:22:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:65512 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932196AbWJPCWA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 22:22:00 -0400
Received: (qmail 29229 invoked by uid 2001); 16 Oct 2006 04:21:59 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfydq79ae.fsf@assigned-by-dhcp.cox.net> <7vr6xddm7h.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28945>

  Thanks for the nice writeup!

Dear diary, on Fri, Oct 13, 2006 at 03:43:46AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> When done with one parent, if you are a merge, you will then try
> to pass the blame on the remaining part that you are still
> suspected for to other parents.

  (This got me nervous but I guess it actually makes sense - if only one
parent modified a line, it's right to pass the blame up; else if you
took one parent's version verbatim, it's right to pass the blame up as
well (I think); else you've already got the blame assigned to the merge
commit and everything is all right.)

> To blame the implementation of foo() to the parent, we could do
> something like this:
> 
>         for each blame_entry that you are still suspected for,
>         diff those lines (and only those lines) with the parent,
>         to see if you find a copy.  If there is a copy, you can
>         pass the blame to the parent.

  Now, this is very nifty and so for moving functions around, but I
think it is very dangerous for anything where ordering matters - large
arrays definitions, patch series files, etc. In that case, you've
completely ommitted the fact that the movement occured, which can be
crucial and based on the current behaviour of the tools, I think people
expect this now. To put it shortly, "who wrote this line" vs "who put
this line here".

  I would prefer to stay more conservative here by default. Graphical
tools could solve this by some nice presentation like

	3fea1 int moved()                         -.
	3fea1 {                                    |
	28abc 	watch(more + anime);               | 17d50
	17d50 	return !hypno;                     |
	3fea1 }                                   -'
	

Dear diary, on Sun, Oct 15, 2006 at 01:43:53AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> I have to admit that I am becoming quite fond of the name
> "pickaxe", by the way.

  Gaah, please don't. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
