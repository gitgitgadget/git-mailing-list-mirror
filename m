From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 0/4] Pulling refs files
Date: Tue, 17 May 2005 22:14:36 +0200
Message-ID: <20050517201436.GC7136@pasky.ji.cz>
References: <20050513233738.GL32232@pasky.ji.cz> <Pine.LNX.4.21.0505142306021.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 17 22:19:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY8Sq-0007fe-4R
	for gcvg-git@gmane.org; Tue, 17 May 2005 22:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVEQUO6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 16:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVEQUO6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 16:14:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:12259 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261724AbVEQUOp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 16:14:45 -0400
Received: (qmail 18775 invoked by uid 2001); 17 May 2005 20:14:36 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0505142306021.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 15, 2005 at 05:23:18AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> On Sat, 14 May 2005, Petr Baudis wrote:
> 
> > So what about just something like
> > 
> > 	git-wormhole-pull remote:refs/head/master wormhole://localhost/
> > 
> > That is, you could just specify remote:path_relative_to_url instead of
> > SHA1 id as the commit.
> 
> Do you have any sensible alternatives to "remote:refs/<something>" in
> mind? I suppose that "remote:HEAD" would also work. How are you thinking
> of having the value get written locally?

Anything that gets eventually wound up in the info/ directory. (The name
of the ignore file saved in info/ignore is the current hit.)

> Do you also have some idea for user-invoked rpush? It has to call
> something that writes the value on the other side (and I'd ideally like it
> to do the update atomically and locked against other clients). This series
> uses the same mechanism to write it that it uses to write hashes fetched
> from remote machines.

Well, it'd be again nice to have some generic mechanism for this so that
the user could theoretically push over rsync too or something (although
that'll be even more racy, it is fine for single-user repository).

I think the remote file to write the value inside should be porcelain
business. What you should always check though is that before the pull
(and after the locking) the value in that file is the same as the "push
base". This way you make sure that you are still following a single
branch and in case of multiuser repositories that you were fully merged
before pushing.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
