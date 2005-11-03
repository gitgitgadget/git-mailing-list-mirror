From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Now What?
Date: Thu, 3 Nov 2005 09:25:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511030921111.27915@g5.osdl.org>
References: <E1EXTw5-00063o-Gt@jdl.com> <20051103083840.GA28300@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 18:28:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXiqS-0000gA-AA
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 18:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVKCRZp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 12:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVKCRZp
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 12:25:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48865 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751151AbVKCRZo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 12:25:44 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA3HPcW6003049
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 3 Nov 2005 09:25:38 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA3HPbTc018448;
	Thu, 3 Nov 2005 09:25:37 -0800
To: Peter Eriksen <s022018@student.dtu.dk>
In-Reply-To: <20051103083840.GA28300@ebar091.ebar.dtu.dk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11076>



On Thu, 3 Nov 2005, Peter Eriksen wrote:
> 
> Here's one I've done too many times:
> 
> ~/git/git-core]cat .git/remotes/origin
> URL: git://git.kernel.org/pub/scm/git/git.git
> Pull: master:origin
> 
> ~/git/git-core]git-checkout maint
> ~/git/git-core]git pull
> Unpacking 222 objects
>  100% (222/222) done
> * committish: 9534f40bc42dd826cc26c8c8c84f6a8a5fc569f6
>   branch 'master' of git://git.kernel.org/pub/scm/git/git
> * refs/heads/origin: storing branch 'master' of
> * git://git.kernel.org/pub/scm/git/git
> Trying really trivial in-index merge...
> fatal: Merge requires file-level merging
> Nope.
> Trying simple merge.
> Simple merge failed, trying Automatic merge.
> Auto-merging Documentation/tutorial.txt.
> Auto-merging Makefile.
> merge: warning: conflicts during merge
> ERROR: Merge conflict in Makefile.
> Auto-merging apply.c.
> Auto-merging cache.h.
> merge: warning: conflicts during merge
> ERROR: Merge conflict in cache.h.
> Auto-merging clone-pack.c.
> Auto-merging connect.c.
> merge: warning: conflicts during merge
> ERROR: Merge conflict in connect.c.
> Auto-merging daemon.c.
> merge: warning: conflicts during merge
> ERROR: Merge conflict in daemon.c.
> Auto-merging debian/changelog.
> merge: warning: conflicts during merge
> ERROR: Merge conflict in debian/changelog.
> Auto-merging fetch-pack.c.
> merge: warning: conflicts during merge
> ERROR: Merge conflict in fetch-pack.c.
> Auto-merging git-branch.sh.
> Auto-merging git-checkout.sh.
> Auto-merging git-clone.sh.
> Auto-merging git-cvsimport.perl.
> merge: warning: conflicts during merge
> ERROR: Merge conflict in git-cvsimport.perl.
> Auto-merging git-fetch.sh.
> Auto-merging git-parse-remote.sh.
> Auto-merging git-tag.sh.
> Auto-merging quote.c.
> merge: warning: conflicts during merge
> ERROR: Merge conflict in quote.c.
> Auto-merging quote.h.
> merge: warning: conflicts during merge
> ERROR: Merge conflict in quote.h.
> Auto-merging refs.c.
> Auto-merging rev-list.c.
> Auto-merging send-pack.c.
> Auto-merging sha1_name.c.
> merge: warning: conflicts during merge
> ERROR: Merge conflict in sha1_name.c.
> Auto-merging upload-pack.c.
> merge: warning: conflicts during merge
> ERROR: Merge conflict in upload-pack.c.
> fatal: merge program failed
> Automatic merge failed; fix up by hand
> 
> Indeed, what now?

You can do two things:

 a) decide not to merge at all:

	git reset --hard

    and you're done. This is what you want to do when you just pulled the 
    wrong branch, for example.

IF you pulled the right branch, and you knew you had other changes through 
other pulls or because you just had done your own development, you want to 
look at:

 b) Try to resolve the merge. Do a "git diff" and look what was unresolved 
    (by looking for those bog-standard resolve conflict markers like 
    "<<<<< old ===== new >>>>>".

    Edit the conflicts by hand to what you want them to be, and do

	git commit --all

    to commit your manual merge.

Note that if you start doing (b) and you decide it's too much for you, you 
can always go back to (a) in the end and ask for help from the people 
involved.

			Linus
