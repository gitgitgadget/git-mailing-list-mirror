From: Petr Baudis <pasky@suse.cz>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Sun, 27 Nov 2005 00:50:11 +0100
Message-ID: <20051126235011.GA22159@pasky.or.cz>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org> <Pine.LNX.4.63.0511202039340.23586@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 00:50:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eg9nr-0005oV-So
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 00:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVKZXt5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 18:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVKZXt5
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 18:49:57 -0500
Received: from w241.dkm.cz ([62.24.88.241]:26285 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750788AbVKZXt4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Nov 2005 18:49:56 -0500
Received: (qmail 19470 invoked by uid 2001); 27 Nov 2005 00:50:11 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511202039340.23586@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12792>

Dear diary, on Sun, Nov 20, 2005 at 08:50:41PM CET, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> > And I'm not 100% convinced that putting these branches in the config file 
> > has any real advantages over keeping them as separate files. Having 
> > everything in one place is nice, of course, and being able to copy just 
> > one file around might be convenient, but it _does_ make the config file 
> > more complicated.
> 
> And it _does_ make finding the information for less savvy git users more 
> easy.

Is that so?

I'm not 50% convinced, but if people are excited about it, I can live
with it; in that case I would like appropriately powerful
git-repo-config, though - so that I can say "list me all branch.*
section names". Surely I could play some ugly grep games, but ideally,
I would like to avoid peeking into the .git/config file directly
altogether in Cogito - call that proper layering. ;-)

> I'm not 100% convinced, either, but it could be a better concept than 
> different files in different places and different formats basically doing 
> the same.
> 
> But my thinking went like this: if Pasky and Junio can not agree on one 
> location and format, and therefore none of the two is deprecated, how 
> about giving them a way out they both might be able to agree to?

Now, those are just different concepts. Cogito's "branch" concept maps
single local head to a single remote head, 1:1. GIT's "remote" concept
maps (possibly not well-defined) bunch of local heads to a remote
repository (where they have same or different name) or a piece of it; to
accomplish this, it introduces a whole new rather complicated concept,
which nevertheless in part shares the namespace with heads (branches).

Surely, remotes are more flexible, but from the end-user perspective
they really act just as kind of "macros" compared to branches, except
that it's faster when you fetch multiple branches at once than when you
do it in sequence. I might add support for multibranch fetches to
Cogito, and I still intend to implement "readonly" remotes support for
the sake of compatibility with GIT, but I plan to stick to branches
otherwise. It's confusing enough to have remote and local heads, and
actually remotes make it even more confusing since you direct your
"direct touch" with the remote heads, now covered in some more abstract
entity.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
