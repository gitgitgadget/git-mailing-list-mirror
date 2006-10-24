From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] repo.or.cz now supports "project forks"
Date: Tue, 24 Oct 2006 19:39:43 +0200
Message-ID: <20061024173943.GF20017@pasky.or.cz>
References: <20061024045201.GX20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 24 19:40:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcQFi-0003pj-Vs
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 19:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbWJXRjq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 13:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161112AbWJXRjq
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 13:39:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19678 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161114AbWJXRjp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 13:39:45 -0400
Received: (qmail 17932 invoked by uid 2001); 24 Oct 2006 19:39:43 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20061024045201.GX20017@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29995>

Dear diary, on Tue, Oct 24, 2006 at 06:52:01AM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
>   FYI, the http://repo.or.cz/ public Git hosting now supports project
> forking, which basically means that if you've done something cool to an
> existing project and want to publish your work, you can create a "fork"
> of the project on repo.or.cz and it will group nicely together in gitweb
> and users will be hinted about the possibility to use --reference when
> cloning your changes; also, repo.or.cz disk space will be conserved
> thanks to the alternates mechanism. ;-)
> 
>   The other main goal aside gitweb grouping wasn't achieved yet though -
> greatly reduced push times. Hey, pushing Git to a new repository takes
> inordinate amount of time (actually also mostly because all the objects are
> unpacked on the remote side, which is silly as well), I didn't try pushing
> Linux kernel to a fresh repository but it'll likely take ages. The idea
> would be to make git-receive-pack take alternates into account when
> announcing what commits does the server side have, but someone will need
> to code up a patch for that...

  BTW, someone asked me why not stuff it in branches in the same
directory, and it's a valid question. It's been my original plan (and I
might still implement it sometimes since it makes sense in some
situations) but after I formulated it at #git I realized that it's
really a no-go for the general case.

  The plan was to have "personal mob-branches", mob/$login/*. Anyone can
make any branch in the mob/$login namespace in any project. But I didn't
feel like implementing it for now, because:

	* git-clone / cg-clone -a would clone even the potential gazillion
	  of mob/$login branches any weirdo can create

	* You get own heads namespace but own tags namespace would be
	  I think more inconvenient since you tend to refere to tags
	  much more often than to branches (if you even have one than
	  one branch) and having to write mob/mynameisverylong/xyzzy-1.2.3.4
	  is, er...

	* One of the big points of forks is that you can fork even
	  mirrored projects. If you start to create branches in mirrored
	  projects, you can get into very ugly problems when by a chance
	  the mirrored project gets such a branch as well

  One sad consequence is that graphiclog does not include the forked
projects, OTOH perhaps its view would be way too cluttered if it did,
and I want to optimize for a large number of forks. So it would be more
sensible if someone (hint, hint) patched git-browser in a way so that
forked projects include the "forkee"'s refs in the view as well, in
addition to own refs. And perhaps a more general notion for this in the
Git world would be interesting.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
