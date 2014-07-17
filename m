From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Syncing Git Repositories
Date: Thu, 17 Jul 2014 08:53:11 +0200
Message-ID: <vpqwqbcv5m0.fsf@anie.imag.fr>
References: <53C7343F.4090806@parikh.io>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sajan Parikh <sajan@parikh.io>
X-From: git-owner@vger.kernel.org Thu Jul 17 08:53:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7fZK-00042t-J8
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 08:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbaGQGx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 02:53:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37700 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752990AbaGQGx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 02:53:26 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6H6rAJl003484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jul 2014 08:53:10 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6H6rBPR001801;
	Thu, 17 Jul 2014 08:53:11 +0200
In-Reply-To: <53C7343F.4090806@parikh.io> (Sajan Parikh's message of "Wed, 16
	Jul 2014 21:26:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 17 Jul 2014 08:53:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6H6rAJl003484
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406184791.95753@f/p0OALZGOz2TFik/HZMdA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253723>

Sajan Parikh <sajan@parikh.io> writes:

> By syncing my code folder and git repositories in this way, do I risk
> borking any repositories?  I'm 99% confident I'm not, since everything
> is in .git/, and there are not external databases or log files that
> need to be updated.  Just making sure though.

You're right that there are no external database, hence if you actually
sync the whole worktree+.git/, you won't have any problem.

I synchonize a bunch of Git repositories between machines with Unison
(file transfer utility), it works great.

One issue you may encounter is if you have either partial
synchronization (e.g. network loss in the middle of a synchronization, I
don't know how owncloud deals with it), or two way synchronization
(there's a synchronization between your laptop and owncloud ongoing, and
you start working on your desktop and trigger a synchronization.

I sometimes encounter this situation with unison. The good news is that
in 99,999% of cases where I'd encounter a problem, Unison shows a
conflict on the index file (modified on both sides). So, in these cases,
I just use Git normally to synchronize, decide that one side becomes the
reference, and rsync to the other to resolve the Unison conflict.

Also, you have to ensure that you synchronize both file
additions/modifications, and file deletions. I often make the mistake of
using rsync without --delete, and it confuses the branch storage format
(I keep my local unpacked branch, and the packed branch is hidden by
it).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
