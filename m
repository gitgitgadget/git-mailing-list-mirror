From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Parent-less branches
Date: Sun, 4 May 2008 01:50:44 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805040139310.19665@iabervon.org>
References: <20080502232008.GA20092@ulrik-ibook>  <m38wys6y1q.fsf@localhost.localdomain> <bd6139dc0805021746q40b384c3nb36a8605d9475a7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Ulrik Sverdrup <ulrik.sverdrup@gmail.com>, git@vger.kernel.org,
	Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Pedro Melo <melo@simplicidade.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Sun May 04 07:51:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsX8a-0006rw-CA
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 07:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbYEDFuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 01:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbYEDFuq
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 01:50:46 -0400
Received: from iabervon.org ([66.92.72.58]:36986 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092AbYEDFuq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 01:50:46 -0400
Received: (qmail 15538 invoked by uid 1000); 4 May 2008 05:50:44 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 May 2008 05:50:44 -0000
In-Reply-To: <bd6139dc0805021746q40b384c3nb36a8605d9475a7f@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81146>

On Sat, 3 May 2008, Sverre Rabbelier wrote:

> On Sat, May 3, 2008 at 2:17 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> >  In short the solution is to create content-less branch using:
> >
> >   $ git symbolic-ref HEAD refs/heads/newbranch
> >   $ rm .git/index
> >
> >  then commit.
> 
> I guess what Pedro is asking is if there isn't a builtin way to do
> this. Which, if I understand correctly, there isn't. Perhaps though
> something like "git branch -N newbranchname" which then creates a new
> parentless branch. It could just be a shell script that does the
> above, but I wonder if there are no side-effects of the above? It
> sounds somewhat 'messy' to remove the index? Too 'low level' to do for
> a user I mean, what if sometime in the future we decide to store
> something in the index that -is- important? I reckon it would be
> cleaner to add an option for this.

If sometime in the future we decide to store something in the index that 
is important, we'll definitely want to remove the index, because whatever 
it is will be both important and -wrong- for a new parentless commit, 
since a new root should have all the default values, not values acquired 
during the other history in the repo.

On the other hand, a builtin command of that sort probably ought to make 
sure that there aren't any uncommitted changes before doing this. And it 
should probably be called "git checkout -b name -N", since it makes it 
your current branch, rather than creating it like "git branch ..." would 
suggest.

	-Daniel
*This .sig left intentionally blank*
