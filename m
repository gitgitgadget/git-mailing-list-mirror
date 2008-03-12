From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gc: call "prune --expire 2.weeks.ago"
Date: Wed, 12 Mar 2008 11:57:39 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803121153160.1656@racer.site>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <7vbq5k77z0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 11:58:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZOf5-0005uu-Di
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 11:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbYCLK5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 06:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbYCLK5k
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 06:57:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:35955 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750992AbYCLK5j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 06:57:39 -0400
Received: (qmail invoked by alias); 12 Mar 2008 10:57:37 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp008) with SMTP; 12 Mar 2008 11:57:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hiLFSNN4hyLM8cagqI/S7jcpiyOdTNmRe1vppKa
	zlk+sqYRcYXQGV
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbq5k77z0.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76943>

Hi,

On Tue, 11 Mar 2008, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> >> Can we also have "why this is a good idea", "what problem this 
> >> solves"?
> >
> > FWIW, my agreeing with the "why this is a good idea" can be translated 
> > into:
> >
> > Acked-by: Nicolas Pitre <nico@cam.org>
> 
> Hmmm.  Is it _that_ obvious?
> 
> At least it would be easier to readers if we had something like this in 
> the documentation (and/or the commit message):
> 
>     "git gc" used to never prune unreachable objects without being
>     explicitly told to, with its --prune option.  This left cruft to
>     accumulate; the user eventually has to run "git prune" manually.
> 
>     It is safe to prune old objects that are unreachable from refs nor
>     reflogs.  "git gc" is updated to run "git prune --expire 2.weeks.ago"
>     so that users has to run "git prune" by hand much less often.
> 
> Is it too much to ask for regulars to set the example of justifying why 
> each of the change is a good idea?

I would have written something like

	Earlier, git-gc would not prune loose objects without being called 
	with --prune.  However, users were actively warned that it is not 
	a safe operation, so most users never called it.

	This makes the operation reasonably safe (unless you have critical 
	git operations running for over two weeks), by pruning only those 
	objects that are old (in the sense of git operations, which 
	typically take no more than a few seconds).

However, I think that it should have been obvious to those who know the 
internals of git-gc, and it is completely uninteresting to those that are 
just users.  All they will realise (or not) is that "git gc --auto" now 
less often complains about too many loose objects (hopefully).

The real question I asked was: is 2 weeks a sensible default?  As I said, 
I was almost tempted to reduce it to 3 days.

Hmm?

Ciao,
Dscho
