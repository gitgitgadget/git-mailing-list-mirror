From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Grammar and wording fixes in gitrepository-layout
Date: Mon, 22 Aug 2011 20:43:13 -0400
Message-ID: <1314057078-sup-8464@pinkfloyd.chass.utoronto.ca>
References: <1313808187-1666-1-git-send-email-bwalton@artsci.utoronto.ca> <7vk4a5wc67.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 02:43:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvf5T-00015H-P7
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 02:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558Ab1HWAnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 20:43:23 -0400
Received: from jerry.cquest.utoronto.ca ([192.82.128.5]:36126 "EHLO
	jerry.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957Ab1HWAnW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 20:43:22 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:51677 ident=93)
	by jerry.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Qvf5F-0005a6-Ce; Mon, 22 Aug 2011 20:43:13 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Qvf5F-0006F9-Bo; Mon, 22 Aug 2011 20:43:13 -0400
In-reply-to: <7vk4a5wc67.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179905>

Excerpts from Junio C Hamano's message of Mon Aug 22 14:09:36 -0400 2011:

Hi Junio,

> Perhaps we should deprecate http-fetch without -a and drop this item
> from the list?

I don't know much about http-fetch as I've never touched it directly.
It doesn't sound like a good idea to allow creating a broken object
store though.  I'll send a patch shortly that adds the deprecation
warning if -a isn't given.

> > +. You could be using the `objects/info/alternates` or
> > +`$GIT_ALTERNATE_OBJECT_DIRECTORIES` mechanisms to 'borrow'
> >  objects from other object stores.  A repository with this kind
> >  of incomplete object store is not suitable to be published for
> > -use with dumb transports but otherwise is OK as long as
> > -`objects/info/alternates` points at the right object stores
> > -it borrows from.
> > +use with dumb transports but is otherwise OK as long as
> > +`objects/info/alternates` points at the right object stores.
> 
> The last three words in the original are meant to clarify and define
> what "the right object stores" are. Was there a compelling reason to
> drop them?

The only reason I dropped them is that I didn't feel they were helping
to clarify the meaning.  The wording was a bit awkward and I thought
'it borrows from' was part the problem.  I see what you're saying
though and think that the following wording is better:

use with dumb transports but is otherwise OK as long as
`objects/info/alternates` points to object stores containing the
missing objects.

> >  objects/[0-9a-f][0-9a-f]::
> >      Traditionally, each object is stored in its own file.
> 
> I would suggest further rewording this to something like:
> 
>     A newly created object is stored in its own file.

Agreed.  This is much better.

> > @@ -120,15 +118,15 @@ HEAD::
> >  HEAD can also record a specific commit directly, instead of
> >  being a symref to point at the current branch.  Such a state
> >  is often called 'detached HEAD', and almost all commands work
> > -identically as normal.  See linkgit:git-checkout[1] for
> > +as they normally would.  See linkgit:git-checkout[1] for
> >  details.
> 
> We may want to reword the sentence that begins with "almost all commands"
> further. In the early days after detached HEAD support was introduced, we
> may have left cases where the result was _undefined_ for commands that
> would not make sense unless you are on a branch, but by now what we have
> should behave sensibly by either erroring out when the operation does not
> make sense unless you are on a real branch, or doing something
> useful.

Ok, how about a full stop after 'detached HEAD' and then the link to
git-checkout?

> >  branches::
> >      A slightly deprecated way to store shorthands to be used
> > -    to specify URL to 'git fetch', 'git pull' and 'git push'
> > -    commands is to store a file in `branches/<name>` and
> > -    give 'name' to these commands in place of 'repository'
> > -    argument.
> > +    to specify a URL to 'git fetch', 'git pull' and 'git push'.
> > +    A file can be stored as `branches/<name>` and then
> > +    'name' can be givent to these commands in place of
> 
> s/givent to/given to/
> 
> > +    'repository' argument.
> 
> We would at least need "See linkgit:..." to say what is expected in this
> file and how it is used (the information is in urls-remotes.txt but that
> is not a top-level file, so it needs to refer to git-fetch and git-push
> instead).

Noted.  The updated patch will address this.

> > @@ -173,9 +171,9 @@ info/exclude::
> >      at it.  See also: linkgit:gitignore[5].
> >  
> >  remotes::
> > -    Stores shorthands to be used to give URL and default
> > -    refnames to interact with remote repository to
> > -    'git fetch', 'git pull' and 'git push' commands.
> > +    Stores shorthands for URL and default refnames for use
> > +    when interacting with remote repositories via 'git fetch',
> > +    'git pull' and 'git push' commands.
> 
> Likewise.
> 
> Also I would personally consider "branches" and "remotes" both "slightly
> deprecated". "git init", "git clone", and "git remote" stopped populating
> these long time ago.

Ok, I've added the note about this being legacy to both of the
sections in question.

Updated patch to follow shortly.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
