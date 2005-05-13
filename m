From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Sat, 14 May 2005 00:45:29 +0200
Message-ID: <20050513224529.GF32232@pasky.ji.cz>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 00:50:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWiyY-0004Ml-69
	for gcvg-git@gmane.org; Sat, 14 May 2005 00:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbVEMWtF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 18:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbVEMWrU
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 18:47:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22665 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262589AbVEMWpc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 18:45:32 -0400
Received: (qmail 7378 invoked by uid 2001); 13 May 2005 22:45:29 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 01, 2005 at 03:09:53AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
> On Sat, 30 Apr 2005, Junio C Hamano wrote:
> >
> > Diff-tree-helper take two patch inadvertently dropped the
> > support of -R option
> 
> Talking about the diffs, I'm beginning to hate those "mode" things.
> 
> Not only do they screw up diffstat (big deal), but they are pointless, 
> since 99.9% of the time the mode stays the same.
> 
> So it would be much nicer (I think) if mode changes are handled 
> separately, with a simple separate line before the diff saying
> 
> 	"Mode change: %o->%o %s", oldmode, newmode, path
> 
> and not mess up the diff header. That way, you only see it when it
> actually makes any difference, and it's more readable both for humans
> _and_ machines as a result.
> 
> Normal "patch" will just ignore the extra lines before the diff anyway, so 
> it won't matter there.
> 
> Comments?

Sorry for replying after so much time, it looks like I missed this and
got here only after checking what change removed the mode: bits...

I'd personally prefer something like

	@.Mode change:

that is, using a '@.' prefix for those. It seems to be unique enough and
'@' is one of the four magic characters prefixing diff lines. Just using
the plain string seems too volatile, and I need to grep all the
interesting bits out of the diff file. This is because patch can
otherwise complain "only garbage found in the patch" when processing the
diff, which confuses my users greatly.

What do you think?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
