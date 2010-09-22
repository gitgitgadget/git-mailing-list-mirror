From: Thomas Hochstein <thh@inter.net>
Subject: Re: Really beginner on Version Control
Date: Wed, 22 Sep 2010 09:31:50 +0200
Message-ID: <gcvg.1009220931.2922@thorondor.akallabeth.de>
References: <1285080133451-5555023.post@n2.nabble.com> <m3mxrak937.fsf@localhost.localdomain> <1285114417273-5557145.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 22 09:35:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyJrH-0005Ho-2h
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 09:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169Ab0IVHfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 03:35:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:54307 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016Ab0IVHfG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 03:35:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OyJr5-0005FC-Gn
	for git@vger.kernel.org; Wed, 22 Sep 2010 09:35:03 +0200
Received: from p548b6296.dip.t-dialin.net ([84.139.98.150])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 09:35:03 +0200
Received: from thh by p548b6296.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 09:35:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p548b6296.dip.t-dialin.net
User-Agent: ForteAgent/2.0-32.652  Hamster/2.1.0.11
X-Uptime: 5 day(s), 13 hour(s), 2 minute(s), 24 second(s) [thorondor | 61386]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156788>

FernandoBasso schrieb:

> For instance, I have 'hello' in line 2 of site.php in the master branch. I
> go to the  testing branch, edit site.php, change 'hello' for 'world' at the
> same line, commit and got back to master. I merge testing into master and I
> get no conflicts. Shouldn't it conflict ? 

No.

You have changed "hello" to world in your testing branch. When you
merge your testing branch back to your master branch, git will apply
all changes you made in testing to master. That's not a problem in
that case, as master was not changed since testing was branched from
it.

Another example:

You create a testing branch from master. Now you'll go to your testing
branch, change "hello" to "world", commit, go back to your master
branch and change "hello" to "all" there (and commit). Now you'll get
a conflict when trying to merge your testing branch - git will try to
apply the change from testing (i.e. change "hello" to "world"), but
can't to that as "hello" was already changed to "all" in your master
branch. git doesn't know which of this conflicting [1] changes is the
right one you'll want to keep, so you have to tell it.

Merging a branch into master will make git try to apply all changes
that you made in this branch to the master branch. That's easy if
master didn't change since you created your testing branch from it.
It's also easy if master _did_ change, but never at the same places as
in testing. You'll only get a conflict if you change the same line(s)
in master _and_ in testing.

Regards,
-thh

[1] That's why it's called a conflict.
