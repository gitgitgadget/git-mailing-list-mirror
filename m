From: Petr Baudis <pasky@ucw.cz>
Subject: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Wed, 20 Apr 2005 22:56:33 +0200
Message-ID: <20050420205633.GC19112@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 20 22:54:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOMBJ-0003V9-2V
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 22:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVDTU4k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 16:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVDTU4j
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 16:56:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49117 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261798AbVDTU4f (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 16:56:35 -0400
Received: (qmail 866 invoked by uid 2001); 20 Apr 2005 20:56:33 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  so I've "released" git-pasky-0.6.2 (my SCMish layer on top of Linus
Torvalds' git tree history storage system), find it at the usual

	http://pasky.or.cz/~pasky/dev/git/

  git-pasky-0.6 has couple of big changes; mainly enhanced git diff,
git patch (to be renamed to cg mkpatch), enhanced git pull and
completely reworked git merge - it now uses the git-core facilities for
merging, and does the merges in-tree. Plenty of smaller stuff, some
bugfixes and some new bugs, and of course regular merging with Linus.

  The most important change for current users is the objects database
SHA1 keys change and (comparatively minor) directory cache format
change. This makes "pulling up" from older revisions rather difficult.
Linus' instructions _should_ work for you too, basically (you should
replace cat .git/HEAD with cat .git/heads/* or equivalent - note that
convert-tree does not accept multiple arguments so you need to invoke it
multiple times), but I didn't test it well (I did it the lowlevel way
completely since I needed to simultaneously merge with Linus).

  But if you can't be bothered by this or fear touching stuff like that,
and you do not have any local commits in your tree (it would be pretty
strange if you had and still fear), just fetch the tarball (which is
preferrable than git init for me since it eats up _significantly_
smaller portion of my bandwidth).

  I had to release git-pasky-0.6.1 since Linus changed the directory
cache format during me releasing git-pasky-0.6. And git-pasky-0.6.2
fixes gitmerge-file.sh script missing in the list of scripts for
install.


  So, now for the heads-up part. We will undergo at least two major
changes now. First, I'll probably make git-pasky to use the directory
cache for the add/rm queues now that we have diff-cache.

  Second, I've decided to straighten up the naming now that we still
have a chance. There will be no git-pasky-0.7, sorry. You'll get
cogito-0.7 instead. I've decided for it since after some consideration
having it named differently is the right thing (tm).

  The short command version will change from 'git' to 'cg', which should
be shorter to type and free the 'git' command for possible eventual
entry gate for the git commands (so that they are more
namespace-friendly, and it might make most sense anyway if we get fully
libgitized; but this is more of long-term ideas).

  The usage changes:

  cg patch -> cg mkpatch	('patch' is the program which _applies_ it)
  cg apply -> cg patch		(analogically to diff | patch)

  cg pull will now always only pull, never merge.

  cg update will do pull + merge.

  cg track will either just set the default for cg update if you pass it
no parameters, or disappear altogether; I think it could default to the
'origin' branch (or 'master' branch for non-master branches if no 'origin'
branch is around), and I'd rather set up some "cg admin" where you could
set all this stuff - from this to e.g. the committer details [*1*]. You
likely don't need to change the default every day.

  I must say that I'm pretty happy with the Cogito's command set
otherwise, though. I actually think it has now (almost?) all commands
it needs, and it is not too likely that (many) more will be added -
simple means easy to use, which is Cogito's goal. Compare with
the command set of GNU arch clones. ;-)


  [*1*] The committer details in .git would override the environemnt
variables to discourage people of trying to alter them based on
whatever, since that's not what they are supposed to do. They can always
just change the .git stuff if they _really_ need to.


  Comments welcomed, as well as new ideas. Persuading me to change what
I sketched here will need some good arguments, though. ;-)

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
