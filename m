From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cloning speed comparison, round II
Date: Sat, 12 Nov 2005 22:20:30 +0100
Message-ID: <20051112212030.GH30496@pasky.or.cz>
References: <20051112155302.GD30496@pasky.or.cz> <Pine.LNX.4.64.0511121134170.3263@g5.osdl.org> <20051112194646.GE30496@pasky.or.cz> <Pine.LNX.4.64.0511121159470.3263@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 22:22:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb2nb-0005za-WF
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 22:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbVKLVUd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 16:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbVKLVUd
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 16:20:33 -0500
Received: from w241.dkm.cz ([62.24.88.241]:56529 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964829AbVKLVUc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 16:20:32 -0500
Received: (qmail 17207 invoked by uid 2001); 12 Nov 2005 22:20:30 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511121159470.3263@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11708>

Dear diary, on Sat, Nov 12, 2005 at 09:13:20PM CET, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> On Sat, 12 Nov 2005, Petr Baudis wrote:
> 
> > Dear diary, on Sat, Nov 12, 2005 at 08:40:11PM CET, I got a letter
> > where Linus Torvalds <torvalds@osdl.org> said that...
> > > 
> > > 
> > > On Sat, 12 Nov 2005, Petr Baudis wrote:
> > > >
> > > >              rsync   git+ssh(*)   git(**)   http
> > > > 
> > > > git.git      0m45s   0m34s        5m30s     4m01s (++)
> > > > 
> > > > cogito.git   2m09s   1m54s (+)    4m30s     15m11s (only single run)
> > 
> > Well, at the time of fetching, master.kernel.org with git+ssh had load
> > about ~3.5 and some wild gzip was eating most of the CPU there. So if
> > the git protocol still manages to be TEN times slower while rsync goes
> > full speed from that machine, I would say that this means the git server
> > requires way too much CPU.
> 
> Look again.
> 
> master.kernel.org was _faster_ than rsync using the native git protocol, 
> despite being under a load of 3.5.
> 
> Look at the numbers: 45 secs for rsync, 34 secs for git protocol to 
> master.

That's git+ssh (not git transport protocol - this DID make a difference
at first, I know it's hard to believe) on machine A vs. rsync on
machine B.

> Now, I don't know which rsync machine you used (you can rsync both from 
> master and from rync.kernel.org), since you don't say. 

rsync.kernel.org ("... official kernel.org hostnames for each transport.")


So I had this length more detailed benchmark which re-examined git+ssh
vs. git on master.kernel.org (good that git-daemon binds to
non-priviledged port). However, an embarrassing thing turned out - this
seems to be a network problem, actually.

 From kernel.org to machine X, it takes 20s, and from machine X to my
home machine, it takes 20s. From kernel.org to my home machine, it takes
5 minutes. This concerns only the git protocols, HTTP and SSH from my
home machine to kernel.org is fast as usual.  Even stranger, this is the
same for both hera.kernel.org and zeus.kernel.org, while each is at
totally different network.  Tried many times.  Ugh.

Well, so sorry for false alarm.

Your totally puzzled,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
