From: Petr Baudis <pasky@suse.cz>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 20:46:50 +0100
Message-ID: <20060214194650.GD31278@pasky.or.cz>
References: <43F20532.5000609@iaglans.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 20:46:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F967w-0005hR-Sl
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 20:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422763AbWBNTqF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 14:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422765AbWBNTqE
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 14:46:04 -0500
Received: from w241.dkm.cz ([62.24.88.241]:27047 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422763AbWBNTqD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 14:46:03 -0500
Received: (qmail 27745 invoked by uid 2001); 14 Feb 2006 20:46:50 +0100
To: Nicolas Vilz 'niv' <niv@iaglans.de>
Content-Disposition: inline
In-Reply-To: <43F20532.5000609@iaglans.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16162>

  Hi,

  now from the simple Cogito's point of view. I will swap the two parts
of your mail.

Dear diary, on Tue, Feb 14, 2006 at 05:28:34PM CET, I got a letter
where Nicolas Vilz 'niv' <niv@iaglans.de> said that...
> And another thing, is there no posibility to get back to some commits or
> tags? I realized you can rebranch tags... what, if i want to switch back
> to git version 1.1.6 in the git repository? Or a certain commit?
> 
> do you have to make a new private branch out of the tag 1.1.6?
> 
> i used svn and there i could go back some revisions. I haven't found
> such a feature in git, yet... but i think i am blind all the time.

  The simple answer is cg-seek, which is meant for temporary ventures to
the commit history - e.g. you want to go back to git version 1.1.6, but
intend to do no development on top of it and to return back to the top
later. cg-seek will remember "where you came from" and by doing either
cg-reset or simply calling cg-seek without any parameters, it will
return back to the top.

  If you want to permanently change your branch to point to the 1.1.6
tag, the command to use is cg-switch -f. There is also a simpler but
less powerful variant of this command available as cg-admin-uncommit.

> i wonder, how i revoke a straight forward merge of two trees... I
> And another thing, is there no posibility to get back to some commits or
> tags? I realized you can rebranch tags... what, if i want to switch back
> to git version 1.1.6 in the git repository? Or a certain commit?
> 
> do you have to make a new private branch out of the tag 1.1.6?
> 
> i used svn and there i could go back some revisions. I haven't found
> such a feature in git, yet... but i think i am blind all the time.
> 
> I like git very much and every new day I like it more.
> actually wanted to be look like somewhere in the git-repository, where
> some branches are merged back with the master tree, but i think, that
> wasn't "cg-merge -c <tree to merge with the actual one>"...
> 
> my result was that my master tree has now the same sha1-sum as my
> development-tree and gitk visualisation differs from that what i saw in
> the git-repository. (Several Arrows headed into back into one line...)
> 
> maybe that was because i didn't do anything in my master tree in the
> meantime.

  So I assume that it made a fast-forward merge and you want to undo it.
Unfortunately, there is no facility to automatically remember what your
previous last commit was, so you either:

  * Remember the "fast-forwarding" message cg-merge gave you. ;-)
  * Fire up cg-log and find the commit you want to go back to.

  Now, when you have the commit id, this is the time for cg-switch -f -
what you want to do is to "repoint" your current branch (let's assume it
is master) to the commit id you've just found:

	cg-switch -f -r commit_id master

  (The same thing could be done using cg-admin-uncommit, but it is a
little confusing in this particular usage; you would have to rather
choose the commit id of the last commit to uncommit, and it does not
cope well with merges.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
