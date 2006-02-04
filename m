From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Two ideas for improving git's user interface
Date: Fri, 3 Feb 2006 18:08:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602031752160.3969@g5.osdl.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <20060130185822.GA24487@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601311750270.25300@iabervon.org> <7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601311623240.7301@g5.osdl.org> <7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602011125370.5397@localhost.localdomain>
 <7vhd7ibza2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602011307250.21884@g5.osdl.org>
 <7v8xsu91vf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602011433290.21884@g5.osdl.org>
 <87lkwupsbr.wl%cworth@cworth.org> <Pine.LNX.4.64.0602011656130.21884@g5.osdl.org>
 <87lkwsvusp.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 03:08:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5Cqt-000295-BR
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 03:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946164AbWBDCIg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 21:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946243AbWBDCIg
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 21:08:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61330 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946164AbWBDCIf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2006 21:08:35 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1428KDZ025286
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 3 Feb 2006 18:08:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1428JM9009204;
	Fri, 3 Feb 2006 18:08:19 -0800
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87lkwsvusp.wl%cworth@cworth.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15563>



On Fri, 3 Feb 2006, Carl Worth wrote:
> 
> > And in that case, I will actually re-apply my manual Makefile change, even 
> > if that file was part of the merge changes (in which case I had had to 
> > first un-apply the change in order to do the merge).
> 
> Are the un-apply and re-apply operations here primarily manual? or
> does git help you much with those (beyond alerting you that the merge
> cannot take place before you un-apply things)?

They're purely manual. If the changes are more extensive, I just create a 
temporary branch for them, which is easy enough:

	git checkout -b temp
	git commit
	git checkout master

before I do the real merge, but the fact is, most of the changes in my 
tree tend to be pretty un-interesting. Most of the time it's literally 
_just_ the Makefile change, sometimes it's a trial patch that I'm not 
ready commit and had just sent out to somebody for testing or similar.

> I believe that the staging operations you perform are quite desirable,
> but I wonder if existing primitives in git might not provide a more
> powerful basis for the kinds of operation you're performing.

No. The point is that they are trivial to do, and that they don't _need_ 
"powerful basis".

What they need is _usability_.

And the git index _is_ that usability. It is incredibly powerful, and 
incredibly easy to use.

When you argue against exposing the index, you argue against it from the 
"let's not give them rope" angle. You argue against power and flexibility. 

You argue for the clippy, the helper app that says

	Are you sure you want to do this?
		[Yes] [No] [Cancel]

while I'm trying to explain that it's actually part of the _power_ of git.

The fact, that I can keep dirty state in my tree and continue to work with 
it _without_ having to worry about it is a huge relief to me. 

> If so, could your not-ready changes be implemented as some branch that
> is automatically unmerged prior to commit and then re-merged
> afterwards? Or something like that?

Sure. They could. You could make things more complicated, and they would 
WORK. 

They'd be inconvenient and not offer any actual improvement.

The "index" file in git really is very important.

Staging into the index is _the_ most fundamental operation. You can't 
actually see it very well in the history of git (because the first commit 
exists only after git actually worked pretty fully), but the birth of git 
is really in the index file. That actually came _before_ the object store, 
as the way to quickly and efficiently track the notion of "changes".

So git itself started out very much with the index file being the staging 
area for tracking the state of a working tree efficiently.

No git operation actually ever lets the working tree interact directly 
with the object store. The notion of "diff this <tree> object against the 
current working tree" comes closest, but even that actually really goes 
through the index file: it's properly a "diff this <tree> object against 
the index file, and check at the same time the index entry against the 
working tree"

If you deny the index file, you really deny git itself.

Think of it this way: when you start a new process, in UNIX you do that in 
two stages: first you fork() to create a copy, then you do exec() to 
populate the copy with the new process. 

Your argument is akin to saying "That's horribly wasteful: wouldn't it be 
much more intuitive to just do 'spawn()' to do it all, and avoid the 
unnecessary middle step".

But that "unnecessary" middle step - whether it's "fork()" or the git 
"index" file - is actually the source of the flexibility. It's what allows 
you to do the "fixups" in the middle when you switch file descriptors 
around, or when you fix up merge conflicts.

And then occasionally, you do fork() _without_ doing an execve() at all. 
The same way that sometimes you do operations on the index without 
actually committing them to a tree.

That's flexibility. Revel in it, instead of trying to push it under the 
rug. 

			Linus
