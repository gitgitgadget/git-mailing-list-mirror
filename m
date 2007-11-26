From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 11:40:08 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711261111260.32410@iabervon.org>
References: <200711252248.27904.jnareb@gmail.com>  <20071125222314.GC21121@artemis.corp>
  <20071126012837.GA5402@dervierte>  <7vejedh6xl.fsf@gitster.siamese.dyndns.org>
 <474A698A.70100@apple.com> <1b46aba20711260732v297c5c35kbd007b9f13f351ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Adam Roben <aroben@apple.com>, Junio C Hamano <gitster@pobox.com>,
	Steven Walter <stevenrwalter@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 17:40:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwh0c-0001ru-71
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 17:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbXKZQkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 11:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbXKZQkM
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 11:40:12 -0500
Received: from iabervon.org ([66.92.72.58]:53323 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429AbXKZQkL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 11:40:11 -0500
Received: (qmail 20102 invoked by uid 1000); 26 Nov 2007 16:40:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Nov 2007 16:40:08 -0000
In-Reply-To: <1b46aba20711260732v297c5c35kbd007b9f13f351ff@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66079>

On Mon, 26 Nov 2007, Carlos Rica wrote:

> On Nov 26, 2007 7:36 AM, Adam Roben <aroben@apple.com> wrote:
> > Junio C Hamano wrote:
> > > Steven Walter <stevenrwalter@gmail.com> writes:
> > > Let's clear the confusion.  Although it is not bad like the above
> > > "random 5 different operations", checkout does serve 2 quite different
> > > purposes:
> > >
> > >  (1) checkout a revision.
> > >  (2) checkout selected paths out of a commit (or the index).
> > >
> >
> > Given the above, I'd argue that it serves 3 purposes:
> >
> >    (1) check out a revision
> >    (2) check out selected paths out of a commit (or the index)
> >    (3) start working on a new branch
> >
> > It's true that (1) and (3) are very closely related, but I think in the
> > minds of many git users (particularly new ones) they are distinct.
> 
> I think this is mostly due to the idea of a branch as a separated box
> (like a directory) instead of a line of development like the notion which
> comes from thinking in a branch as the place where HEAD is pointing to.
> 
> Personally, it is always difficult for me to understand git as a whole,
> because I'm not sure what is the common use case for each command in
> the most-usual-way-of-doing-the-things when using git, despite of having
> long and complete documentation for each individual command. The question
> is if we can give the power of git to their users in the same way they think,
> or how git could be able to teach their users to think in the way it works.
> 
> An idea would be to study (and document) the most successful
> use cases that git supports and check if it is already providing
> unique and/or clear commands for them.

I think that part of git's oddity comes from the fact that the UI is 
organized around use cases rather than commands. That is, for each thing 
that people commonly do, the sequence of commands is as short as possible 
and each of the names makes sense in the context of this sequence. But 
then the commands and options, in the list of commands and options outside 
of the context of a use case, don't make any sense as a whole.

It's like trying to document the "take" command in a text adventure, where 
"take [noun]" means to pick it up, "take off [noun]" means to remove it as 
clothing, and "take off" means to leave.

There's a set of primitive git operations, but the git commands aren't 
those; the git command schemas (not just the "command" part, but the type 
of arguments following it) are semi-natural-language interfaces to 
collections of primitive operations, and are set up to have a core "what 
the user is saying to do" and all of the reasonable analogous extensions 
to that. This means that the very same result can often be reached with 
multiple entirely different commands, because there are different ways of 
conceptualizing what you're doing that overlap. (E.g., "git checkout HEAD 
." will check out the current directory from the current branch, 
discarding local changes; "git reset --hard HEAD" will move the current 
branch to its current state, bringing the working copy in line with it as 
well; both of these have the effect of discarding all local changes while 
keeping the branch state the same, but that's just because the aspects of 
the two operations which are different don't matter with those particular 
arguments)

I think git's UI design is, by and large, very good, but I'm not sure how 
to document it so as to make it easy to learn, aside from giving a quick 
explanation of how to use reflogs to recover from mistakes and telling 
users to just try stuff in their local repository.

	-Daniel
*This .sig left intentionally blank*
