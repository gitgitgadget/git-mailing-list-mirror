From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: lost all my patches again
Date: Wed, 28 Nov 2007 18:19:17 +0100
Message-ID: <20071128171917.GA21310@diana.vm.bytemark.co.uk>
References: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com> <9e4733910711271512g790364e0ka4839b2be9fd4935@mail.gmail.com> <20071128093403.GB12977@diana.vm.bytemark.co.uk> <9e4733910711280706j45fe9c17t928396eb8e1de8bf@mail.gmail.com> <20071128160410.GB19302@diana.vm.bytemark.co.uk> <9e4733910711280821s3872eff5m95073ca6b1b8a689@mail.gmail.com> <20071128164113.GA20749@diana.vm.bytemark.co.uk> <9e4733910711280858j5d03b3acleac0ece7b0a67f66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 18:20:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxQZf-0001iT-Dd
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 18:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761074AbXK1RTX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 12:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760733AbXK1RTX
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 12:19:23 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1520 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760074AbXK1RTX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 12:19:23 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IxQZB-0005e5-00; Wed, 28 Nov 2007 17:19:17 +0000
Content-Disposition: inline
In-Reply-To: <9e4733910711280858j5d03b3acleac0ece7b0a67f66@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66390>

On 2007-11-28 11:58:14 -0500, Jon Smirl wrote:

> After someone runs the wrong command their first instinct will be to
> run stg repair. Can stg repair be made smart enough to not attempt a
> repair if it is unable to do so and print a message referring people
> back to the manual on how to move the head back?

Well, the thing is, it's never unable to repair.

However, I could add another repair mode: reset the branch head to the
latest point in the reflog where it was consistent with StGit's
metadata.

repair would have two flags to select the original or this new repair
mode, and if the user doesn't give either flag, repair points out that
she has two choices, and what they mean:

  "If you want to undo the last 3 git commands

     pull : Fast forward
     commit (amend): fix
     reset --hard kha/experimental: updating HEAD

   call stg repair --undo. If you want StGit to adjust to the new
   situation, call stg repair --assimilate."

> When I ran stg repair after the wrong git rebase command, I
> compounded the problem further.

Not that much. It was the push following the repair that killed you.
The repair alone is totally benign; doing

  $ stg repair && git reset --hard foobar && stg repair

gives the same result as just

  $ git reset --hard foobar && stg repair

except for creating a few new patches that you can safely delete.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
