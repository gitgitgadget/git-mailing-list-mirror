From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Fix default pull not to do an unintended Octopus.
Date: Tue, 27 Sep 2005 14:54:34 +0200
Message-ID: <20050927125434.GF30889@pasky.or.cz>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net> <7vr7bba3lo.fsf@assigned-by-dhcp.cox.net> <7vu0g72c4y.fsf_-_@assigned-by-dhcp.cox.net> <200509271152.42963.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 14:57:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKEym-0003PL-Dc
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 14:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbVI0Myh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 08:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbVI0Myh
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 08:54:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:30938 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964918AbVI0Myh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 08:54:37 -0400
Received: (qmail 16853 invoked by uid 2001); 27 Sep 2005 14:54:34 +0200
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
In-Reply-To: <200509271152.42963.Josef.Weidendorfer@gmx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9394>

Dear diary, on Tue, Sep 27, 2005 at 11:52:42AM CEST, I got a letter
where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> told me that...
> As Cogito does, I expect the porcelain to store the mapping of a
> local head to a remote head, automatically using the right remote
> repository.

Yes. I'm actually inclined to keep this setup, simply because it is

  * easy
  * simple
  * sufficient in most of the cases

Cogito's fetch/update should certainly support the remotes stuff, since
they are obviously much more useful and practical for more complicated
setup, but I think I will keep the branches/ setup (the name of the
directory is the only thing I don't like on it ;) as the primary mean of
configuring remote branches.  I will only have to add possibility to
cg-fetch multiple branches at once, which could also make branches/
significantly more practical.

> Perhaps we should have extended the branches file to allow different
> remote reps and heads depending on the command (fetch/pull/merge/push).
> A "URL:" is not needed, as you probably like to have different repos for pull 
> and push. And in contrast to the remotes stuff above, a "Merge:" line makes 
> quite sense here: When on "mybranch", a merge should default to merging
> the heads specified on the Merge line in branches/mybranch.

No. If you are in the branches/ playground, please keep it strictly
one-to-one mapping. That's what makes it easy and simple and that's what
makes it good.

> When cloning a remote head, Cogito creates a local "origin" head and
> corresponding mapping in branches/origin. Afterwards, it automatically
> generates a new local branch "master", which branches of at the
> origin. Further "cg-updates" (=git fetch+merge) fetch origin, and merge
> origin into master.
> I assume that this currently is hardcoded in scripts?

Yes.

> Shouldn't there be created a branches/master, specifying that a default
> merge should happen with "origin"? This way, an "cg-update" would look
> into "branches/master" on the "Merge:" line. It sees that "origin" is
> bound to a remote head, and thus, does a fetch before merging.

If ever doing that, this should be done at some other place than
branches/. And I'm sceptical about it anyway. Really, introducing some
new configuration mechanism just to tell Cogito what default branch name
should it pick up when you call fetch/update/merge without a parameter?
I don't know if that wouldn't make more evil than good.

Well, if you _really_ _really_ badly want it, we can make
.git/default-origin/ or something... duh, what a stupid name. :)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
