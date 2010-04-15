From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Lost a week?
Date: Thu, 15 Apr 2010 16:16:49 +0200
Message-ID: <vpqtyrc6bse.fsf@bauges.imag.fr>
References: <t2s62a3a9cb1004150657g5baabb42o512e0e103d1e9596@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Grace <negativeview@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 16:17:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Psb-0000SB-F3
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 16:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271Ab0DOOQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 10:16:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60189 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754147Ab0DOOQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 10:16:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o3FEBrwC014697
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 15 Apr 2010 16:11:53 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O2PsA-0006Ve-2N; Thu, 15 Apr 2010 16:16:50 +0200
In-Reply-To: <t2s62a3a9cb1004150657g5baabb42o512e0e103d1e9596@mail.gmail.com> (Daniel Grace's message of "Thu\, 15 Apr 2010 08\:57\:50 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 15 Apr 2010 16:11:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o3FEBrwC014697
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1271945514.64115@5U7tLqF6G2LcDBVCYbykVA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144990>

Daniel Grace <negativeview@gmail.com> writes:

> github shows the same. I KNOW that there were commits (representing a
> good bit of work) in that time. I'm sure that it's *somewhere* but I'm
> at a complete loss as to where it is. gitk shows no side branches (nor
> does git branch). I don't use branches really, as much as I know that
> I should.

I guess you've been on a detached HEAD for some time. Recent version
of Git warn you this way when you enter in this state:

,----
| Note: checking out 'HEAD^'.
| 
| You are in 'detached HEAD' state. You can look around, make experimental
| changes and commit them, and you can discard any commits you make in this
| state without impacting any branches by performing another checkout.
| 
| If you want to create a new branch to retain commits you create, you may
| do so (now or later) by using -b with the checkout command again. Example:
| 
|   git checkout -b new_branch_name
| 
| HEAD is now at a8e7ba9... foo
`----

Now, your changes are probably not lost forever: they're not reachable
from a branch, but still there (but don't play with "git gc" until
you're sure you've recovered all of it...). "git reflog" should give
you the sha1 of the commit you're looking for (if you didn't really
mess up everything, you really look for just one commit, which is the
tip of the sequence of commits you did while on a detached HEAD, that
is, the one just before you did "git checkout master".

Then, do

git branch tmp <the-sha1-you-found>
(possibly run "gitk --all" to understand, here)
git merge tmp

to create a branch named tmp containing your commits, and merge it
into your current branch. Naming the branch isn't strictly necessary,
but will help in case you do anything wrong trying to merge.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
