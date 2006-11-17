X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 12:44:46 -0500
Message-ID: <20061117174446.GB11882@fieldses.org>
References: <20061116221701.4499.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 17:45:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061116221701.4499.qmail@science.horizon.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31718>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl7lk-0001U6-Ga for gcvg-git@gmane.org; Fri, 17 Nov
 2006 18:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933029AbWKQRot (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 12:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933597AbWKQRot
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 12:44:49 -0500
Received: from mail.fieldses.org ([66.93.2.214]:46740 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S933029AbWKQRos (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 12:44:48 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1Gl7lf-0004km-0z; Fri, 17 Nov 2006
 12:44:47 -0500
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

This has some useful material that fills gaps in the existing
documentation.  We need to think a little more about the intended
audience, and about how to fit it in with existing documentation.

On Thu, Nov 16, 2006 at 05:17:01PM -0500, linux@horizon.com wrote:
> * A brief digression on command names.
> 
> Originally, all git commands were named "git-foo".  When there got to
> be over a hundred, people started complaining about the clutter in
> /usr/bin.  After some discussion, the following solution was reached:
> 
> - It's now possible to place all of the git-foo commands into a separate
>   directory.  (Despite the complaints, not too many people are doing it
>   yet.)
> - One option for git users is to add that directory to their $PATH.
> - Another is provided by a wrapper called just "git".  It's intended to
>   live in a public directory like /usr/bin, and knows the location of
>   the separate directory.  When you type "git foo", it finds and executes
>   "git-foo".
> - Some simple commands are built into the git wrapper.  When you type
>   "git add", it just does it internally.  (On the git mailing list,
>   you will see patches like "make git diff a builtin"; this is what
>   they're talking about.)
> - For compatibility, for each builtin, there is a "git-add" file,
>   which is just a link to the "git" wrapper.  It looks at the name it
>   was invoked as to figure out what it should do.
> 
> The one confusing thing is that, although people usually type "git foo"
> in examples, they're interchangeable in practice.  I go back and forth
> for no good reason.  The main caveat is that to get the man page, you
> still need to type "man git-foo".  Fortunately, there are two other ways
> to get the man page:
> 
> 	1) "git help foo"
> 	2) "git foo --help"
> 
> Git doesn't have a specialized built-in help system; it just shows you
> the man pages.

Who's the audience for the above?  I can see that it's useful for
administrators, who may need help deciding how to install stuff, and for
developers, who need to know where the heck the code for "git-add" came
from.  But the case I'm most interested in is the user whose
distribution installs git for them, in which case I think the above
could be distilled down to:

	- "git-foo" and "git foo" can be used interchangeably.
	- Documentation for the command foo is available from any of
		- man git-foo
		- git help foo
		- git foo --help

Then the additional details above could be postponed to a later part of
the documentation.

> One outstanding problem with git's man pages is that often the most detail
> is in the command page that was written first, not the user-friendly
> one that you should use.  For example, there are a number of special
> cases of the "git diff" command that were written first, and the man
> pages for these commands (git-diff-index, git-diff-files, git-diff-tree,
> and git-diff-stages) are considerably more informative than the page for
> plain git-diff, even though that's the command that you should use 99%
> of the time.

I agree that that's helpful.  Though we should probably also be working
on the man pages to make this organization clearer.

> As you recall from Git 101

Obviously a more specific reference would be more useful here--if
there's nothing useful to point to among the existing documentation, we
should figure out how to fix that problem.

That might also remove the need for some of the recap that follows.

> there are exactly four kinds of objects in
> Git's object database.  All of them have globally unique 40-character hex
....


> Finally, there are references, stored in the .git/refs directory.
> These are the human-readable names associated with commits, and the
> "root set" from which all other commits should be reachable.

This is good; a comprehensive discussion of references will fill a gap
in the current documentation.

....

> * Naming revisions
> 
> CVS encourages you to tag like crazy, because the only other way to
> find a given revision is by date.  Git makes it a lot easier, so most
> revisions don't need names.
> 
> You can find a full description in the git-rev-parse man page, but here's
> a summary.

This has a lot more overlap with existing documentation.  The extra
detail is useful, but we need to decide what our audience and goal is
here, to decide exactly what niche we're trying to fill between the
brief stuff that's in the tutorial part I and the details in
"man git-rev-parse".

> * Converting between names
> 
> Git has two helpers (programs designed mainly for use in shell scripts)
> to convert between global object IDs and human-readable names.
> 
> The first is git-rev-parse.  This is a general git shell script helper,
> which validates the command line and converts object names to absolute
> object IDs.  Its man page has a detailed description of the object
> name syntax.
> 
> The second is git-name-rev, which converts the other way around.  It's
> particularly useful for seeing which tags a given commit falls between.

Also discuss git-describe?

> * The three uses of "git checkout"

Obviously there's a lot of overlap here with "man git-checkout".  What's
the goal here?  Maybe this should just be worked in to a revision of
that man page?

> * Deleting branches
> 
> "git branch -d <head>" is safe.  It deletes the given <head>, but first
> it checks that the commit is reachable some other way.  That is, you
> merged the branch in somewhere, or you never did any edits on that branch.

It only checks whether the head of the branch to delete is reachable
from the *current* branch.  The man page could be clearer here.

....

> * Examining history: git-log and git-rev-list

Yep, we should definitely have a good long chapter just devoted to
history examination.  Most of it could be just cool examples, so it
would be fun.

Note some of this is done in the last half of cvs-migration.txt; we
should mine that section for whatever's useful and then replace by a
reference to the new chapter.

> * History diagrams
...

> * Trivial merges: fast-forward and already up-to-date.

These two sections are useful, yep.

> * Exchanging work with other repositories, part II: git-push

There's a lot of overlap here with cvs-migration.txt.  Maybe some better
organization is needed to make that more prominent.

> The details are too advanced for this discussion, but the default
> "recursive" merge strategy that git uses solves the answer by merging
> a and b into a temporary commit and using *that* as the merge base.

I'm tempted to ignore any description of the merge strategy, or postpone
it till later; as a first pass I think it's better just to say "obvious
cases will be handled automatically, and you'll be prompted for
comments."  Only other SCM developers are going to wonder how you handle
the corner cases.

> * When merging goes wrong

But yes, I think people could use more help on how to resolve merges.

> * Test merging
...
> * Cherry picking
...
> * Rebasing

Yup, I agree that that's good material to cover together.

