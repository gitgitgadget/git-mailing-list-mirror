From: Yann Dirson <ydirson@altern.org>
Subject: Improving git-svn documentation
Date: Wed, 17 Jun 2009 22:18:51 +0200
Message-ID: <20090617201851.GA6123@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 17 22:19:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH1bB-0007RX-24
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 22:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168AbZFQUS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 16:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756024AbZFQUS6
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 16:18:58 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:37326 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754996AbZFQUS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 16:18:58 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 440E0E0816B
	for <git@vger.kernel.org>; Wed, 17 Jun 2009 22:18:53 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 1EBD4E08175
	for <git@vger.kernel.org>; Wed, 17 Jun 2009 22:18:50 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id D4CD41F0FB; Wed, 17 Jun 2009 22:18:51 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121769>

While diving into the git-svn code, I realized that many things could
be done to make it more documented/understundable.  I need to get more
understanding of it, so I'd like to improve this state of things.  But
first, I'd like to be sure there is a consensus on what is a good idea
to do, since that could easily turn up into a lot of textual change.

- (on the user doc side of things) some options appear not to be
  documented (I spotted --parent for 'clone' and --revision for
  'dcommit').  But looking at where to document them, I found it not
  always easy, since some options are documented together with the
  command they modify, some others in the "options" section (even when
  they are documented as applying to a single command, like --shared
  or --stdin).  This IMHO leads to confusion for the user looking for
  information, as well as to the reviewer trying to check that nothing
  was forgotten.  I would rather make that only very commons are
  described in a common "options" section, and that all commands using
  them explicitely say so in their descriptions (with xref).

- (on the code side of things) git-svn.perl weights more than 5500
  lines, most classes functions and methods severely lack
  documentation, and some extensively-used variable names are so short
  they make the code harder to grasp

  Eg. $gs to refer to an instance of the Git::SVN class, which I would
  suggest to change to something like $gsrepo, while at the same time
  renaming Git::SVN to eg. Git::SVN::Repository - which would make it
  much easier for a newcomer to grasp what this is supposed to
  represent - supposing, that is, that my understunding of this part
  is accurate enough, which it is probably not after spending many
  hours in there :)

  As to the size of the file, it seems natural to me to split the
  classes into their own files.  That would still let git-svn.perl and
  the Git::SVN class to be 1500-lines tall, the largest others
  achieving around 500 lines.  That should be much more manageable
  pieces, and would require some refactoring wrt a couple of global
  variables used throughout the script; which, incidentally, could
  make it much easier to simultanously look at several git-svn
  repositories (for my work on mapping externals to submodules), and
  to allow reusing the existing code, eg. as a git-vcs backend.

How are you people feeling about this rough plans ?

-- 
Yann
