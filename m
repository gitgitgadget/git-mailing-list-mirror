From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] checkout --track: make up a sensible branch name if '-b'
 was omitted
Date: Sat, 9 Aug 2008 23:08:04 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808092302520.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808091559460.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vtzdu6nb7.fsf@gitster.siamese.dyndns.org> <7vvdya55ur.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 09 23:04:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRvc6-0004W4-Nb
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 23:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbYHIVD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 17:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752670AbYHIVD3
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 17:03:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:38069 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752576AbYHIVD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 17:03:28 -0400
Received: (qmail invoked by alias); 09 Aug 2008 21:03:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp051) with SMTP; 09 Aug 2008 23:03:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/iW50lFYPiB39jc7WMpx53b7TkaXQizVhHRVgKHB
	vgtr61SH4QyR7q
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7vvdya55ur.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91781>

Hi,

On Sat, 9 Aug 2008, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> What does the user most likely want with this command?
> >>
> >> 	$ git checkout --track origin/next
> >>
> >> Exactly.  A branch called 'next', that tracks origin's branch 'next'.
> >
> > I like this.
> >
> > An explicit --track request from the command line (as opposed to 
> > happening to have "branch.autosetupmerge" configuration) is a very 
> > good cue that what the user wants to do is not to take a peek on a 
> > detached HEAD but a more permanent playpen created.
> 
> A couple more thoughts.

At first, I liked the thoughts, but...

> (1) You may not necessarily are used to --track, but may still want this
>     done.  It might not be a bad idea to associate this "local dwimming"
>     to creation of a new branch.  In other words, all of these:
> 
>     $ git checkout -b origin/next

This cannot be dwimmed, as it literally means "start a new branch called 
'origin/next' from HEAD".

So it would change the current behavior would, breaking people's habits (I 
do "git checkout -b bla" a lot when I realize that I want to have the 
current changes on a new branch).

>     $ git checkout -b --track origin/next

This is a clear syntax error.  By the same reasoning, we would have to 
allow "git add remote origin git://..."

I think allowing this would confuse the syntax, and foster unreasonable 
expectations.

>     $ git checkout --track origin/next

That is what my patch does.

> (2) If you work with somebody else, you might not want to have the name
>     mapping to be "s|^[^/]*/||" (i.e. drop "origin/"):
> 
>     $ git remote add -f jeff $url_to_his_repository
>     $ git checkout -b [--track] jeff-next jeff/next
>     $ git checkout -b [--track] origin-next origin/next

As I said, I think you must not allow switching around the options -b and 
--track.

And the rest of what you describe is already supported.

Ciao,
Dscho
