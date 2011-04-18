From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git-p4 issue
Date: Mon, 18 Apr 2011 12:59:17 +0000 (UTC)
Message-ID: <loom.20110418T145406-908@post.gmane.org>
References: <BANLkTikeQSqAhm2CwCYBkE74OxPUnA0cOg@mail.gmail.com> <BANLkTimmVQAcx7hiQFUBcoAGdvPhktPuMg@mail.gmail.com> <BANLkTikDDDtyJB992DFNtvgMrGvbWf=rMw@mail.gmail.com> <20110416160109.GA19557@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 14:59:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBo3J-0003t9-Rh
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 14:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab1DRM7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 08:59:37 -0400
Received: from lo.gmane.org ([80.91.229.12]:42478 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290Ab1DRM7g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 08:59:36 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QBo3A-0003or-GY
	for git@vger.kernel.org; Mon, 18 Apr 2011 14:59:34 +0200
Received: from 57.79.130.188 ([57.79.130.188])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Apr 2011 14:59:32 +0200
Received: from vitor.hda by 57.79.130.188 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Apr 2011 14:59:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 57.79.130.188 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:2.0) Gecko/20100101 Firefox/4.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171742>

Hi Pete and Michael,

Pete Wyckoff <pw <at> padd.com> writes:

> 
> michael.horowitz <at> ieee.org wrote on Fri, 15 Apr 2011 16:39 -0400:
> > I am sure that is a common mistake people make, but not in this case.
> > I have been using it successfully for a while now, it just suddenly
> > stopped working, not sure what changed.  I am not seeing anything on
> > remotes/p4/master either, and I was originally doing rebase and went
> > back to sync so I could run "--verbose" and see if it was even
> > downloading those changes.  I can clearly see it says it is
> > downloading them, but then they just don't end up in git.

I've seen similar behavior when branch detection is enabled. Could it be that
the new changelists are not being imported because they are under a folder that
is not part of the path provided to git-p4 sync (or automatically detected by
it) during the original import? That would explain why --verbose shows the
changelists being downloaded but then they are not imported.

You said that if you clone the depot again you see the new changes. Could you
please confirm if "depot_paths" value is the same in git-log of both git repos?

> > Since I don't see an error message about it failing to sync, I am at a
> > loss to figure out why it says it succeeded, but it didn't.  Could
> > there be one step in the code that is not catching an error condition?
> >  I am not all that familiar with Python, but if someone could point me
> > where to put some debug messages, I can do some testing.
> 
> It would say something if it failed.  If git-p4 says it brought
> in changes, they would appear at the top of p4/master, or another
> branch in remotes/p4 if you use git-p4's auto-branch feature.
> 
> Do "git branch -av".  You should see remotes/p4/master with the
> latest p4 change.
> 
> It is possible to create a branch "p4/master" that is not
> remotes/p4/master and possibly cause confusion.  "tree -a
> .git/refs" to see all your branches.
> 
> You can try "git fsck" to see if something is terribly wrong.
> Or nose around .git, see if there are some recently-created
> objects and use "git cat-file -p" to look at them.
> 
> If you are willing to tar up your .git and leave it somewhere,
> I can take a look too.
> 
> 		-- Pete


Vitor
