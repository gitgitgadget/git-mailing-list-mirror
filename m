From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 2/5] Add git-sequencer documentation
Date: Wed, 30 Jul 2008 14:14:54 +0200
Message-ID: <20080730121454.GA8767@leksak.fem-net>
References: <1217049644-8874-1-git-send-email-s-beyer@gmx.net> <1217049644-8874-2-git-send-email-s-beyer@gmx.net> <1217049644-8874-3-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807261623530.26810@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 14:16:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOAbC-0007Vv-Br
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 14:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365AbYG3MO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 08:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755291AbYG3MO7
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 08:14:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:52421 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755204AbYG3MO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 08:14:58 -0400
Received: (qmail invoked by alias); 30 Jul 2008 12:14:56 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp011) with SMTP; 30 Jul 2008 14:14:56 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19X2kFMH6xXhllYVp4SL7RX4oD4nshp2+PuX0TlRy
	G1LkfEtN1sF5nO
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KOAZz-0002Yu-07; Wed, 30 Jul 2008 14:14:55 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807261623530.26810@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90770>

Hi,

Johannes Schindelin wrote:
> > +-B::
> > +--batch::
> > +	Run in batch mode. If unexpected user intervention is needed
> > +	(e.g. a conflict or the need to run an editor), 'git-sequencer' fails.
> 
> Does it abort, or leave a dirty tree?

It aborts.
Perhaps I should make this clear in the docs.

> > +--onto=<base>::
> > +	Checkout given commit or branch before sequencing.
> > +	If you provide a branch, sequencer will make the provided
> > +	changes on the branch, i.e. the branch will be changed.
> 
> Whoa, does that mean that
> 
> 	$ git checkout my-private-branch
> 	$ git sequencer --onto=master
> 
> will change _master_?

Exactly.

> > +--continue::
> > +	Restart the sequencing process after having resolved a merge conflict.
> 
> What about 'edit'?  Does it restart the sequencing process after editing a 
> file or commit message, too?

Yes. Thanks.

> > +If you nonetheless noticed that you made a mistake, you can
> > +overwrite `.git/sequencer/todo` with `.git/sequencer/todo.old` and
> > +rerun `git sequencer --edit`.
> 
> Speaking of "todo": there was an explicit request to change that to 
> "git-rebase-todo" for rebase -i, so that syntax highlighting could be 
> switched on.

I'd not have a problem with that, though the name "rebase" is not
necessarily correct and the syntax files had to be extended
nevertheless.

> > +-v::
> > +--verbose::
> > +	Be more verbose.
> 
> More?

Hehe, the note that "more" has to be defined more accurately, has been
removed. But it is still true. ;)

> > +a branch in a way that can cause problems for anyone who already has
> > +a copy of the branch in their repository and tries to pull updates from
> > +you.  You should understand the implications of using 'git-sequencer' on
> > +a repository that you share.
> 
> How about this instead?
> 
> 	Note that sequencing will rewrite the history of the branch.  

It will not necessarily rewrite history of a branch. In case of the
rebase user command, it does, of course.

> 	This will cause problems if you published the branch prior to
> 	rewriting the history, as the former tip is no longer an 
> 	ancestor of the new tip.
> 
> 	In other words, if you rewrite an already published branch, users 
> 	that pull from you _will_ get a bogus merge.

Yes, I can take that.

Well, I wanted only a short note and the user command that really
rewrites branches could have a more detailed warning.

> > +'git-sequencer' will usually be called by another git porcelain, like
> 
> s/another git procelain/other git programs/

Ok, I use "other git commands", since this wording seems to be the leading
one in other documentation.

> > +TODO FILE FORMAT
> > +----------------
> > +
> > +The TODO file contains basically one instruction per line.
> 
> s/basically //

Oh, this is from the times where we included some possible extensions,
like a trailing backslash.

> > +edit <commit>::
> > +	Pick a commit and pause the sequencer process to let you
> > +	make changes.
> > ++
> > +This is a short form for `pick <commit> and `pause` on separate lines.
> 
> It might make sense to explain 'pick' before 'edit', then.

This is kept alphabetically.

When first writing that, I wondered if this makes sense:
a reference-like list should be sorted alphabetically, a tutorial-like
list should have some kind of logical structure.
I do not really care if we prefer this or that one. So I take your
reordering suggestion until somebody complains again :)

> > +	--mainline=<n>;;
> > +		Allow you to pick merge commits by specifying the
> > +		parent number (beginning from 1) to let sequencer
> > +		replay the changes relative to the specified parent.
> 
> Why is this called "mainline", and not "parent"?

Because git-cherry-pick/git-revert has "--mainline" and I did not want
to rename this.

> > [talking about 'squash']
> >
> > +	--collect-signoffs;;
> > +		Collect the Signed-off-by: lines of each commit and
> > +		add them to the squashed commit message.
> > +		(Not yet implemented.)
> 
> I really have to wonder how useful that is.  Or how correct, for that 
> matter.

This is just some kind of squashing Signed-off-by: lines.
It was requested by someone (Paolo?) in the RFC git-sequencer.txt thread.

The behavior is planned like this:

Instead of...

	Message of commit 1
	
	Signed-off-by: A
	
	Message of commit 2
	
	Signed-off-by: B
	
	Message of commit 3
	
	Signed-off-by: A
	Signed-off-by: C

...the user gets...

	Message of commit 1
	
	Message of commit 2
	
	Message of commit 3
	
	Signed-off-by: A
	Signed-off-by: B
	Signed-off-by: C

using --collect-signoffs and no commit-message-changing options.

With --message="Foo" this will be:

	Foo
	
	Signed-off-by: A
	Signed-off-by: B
	Signed-off-by: C

For me this sounds like making sense and being useful, but I have not yet
digged so deep into the rules of signing off :)

> > +	--include-merges;;
> > +		Sanity check does not fail if you have merges
> > +		between HEAD and <mark>.
> 
> It may be a commit, too, right?  And why does it make sense to check that 
> there are no merges?  I mean, it is just as if I did two cherry-picks, the 
> second with -n, and then commit --amend it.  Can make tons of sense...

I think I mean something different. With "merges" I am talking about
commits having more than one parent.
By this check I want to make sure, that the user really knows what he
does when he wants to squash the ones marked with ~ into one commit.

         ~~~~~~~~~~~~~
  ..-A---B---C---D---E---F
            /
  ..-X---Y--

Yet I didn't really care what happens then and perhaps it should be:

 ..--A---S--F
        /
 ..-X-Y-

In the prototype the squashing is done by soft-resetting to the
squash base and then commit. As I said, I did not really care if
my painted result really happens.  In the builtin it will happen :)

> > +Here are some examples that shall ease the start with the TODO
> > +file format.
> > +Make sure you have understood the `pick` and perhaps the `patch` command.
> > +Those will not be explained further.
> 
> This sentence is insulting.  Strike it.

The "Make sure ..." sentence?  It really is insulting?
Do you think it implies the assumption that the user will not grasp
patch/pick easily?


Thanks for your reply and your other notes. (The ones I didn't comment
are just ACKed.)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
