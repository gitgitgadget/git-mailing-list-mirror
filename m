From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch
 when appropriate to do so
Date: Wed, 14 Oct 2009 00:38:21 +0200
Message-ID: <20091013223821.GA15814@atjola.homenet>
References: <0016e68fd0123a175304754694b4@google.com>
 <200910122340.13366.trast@student.ethz.ch>
 <7vr5t89qiw.fsf@alter.siamese.dyndns.org>
 <200910130836.57011.trast@student.ethz.ch>
 <7vljjf226t.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0910131358000.32515@iabervon.org>
 <7vljjfuibr.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0910131654270.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Euguess@gmail.com, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Oct 14 00:40:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxq2E-0003bs-FI
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 00:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760872AbZJMWjU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Oct 2009 18:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760833AbZJMWjT
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 18:39:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:32827 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760808AbZJMWjS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 18:39:18 -0400
Received: (qmail invoked by alias); 13 Oct 2009 22:38:31 -0000
Received: from i59F57E86.versanet.de (EHLO atjola.homenet) [89.245.126.134]
  by mail.gmx.net (mp008) with SMTP; 14 Oct 2009 00:38:31 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/w/5R8ssnwK4jjHXxMG0zgo22q+UenIbGOuFiS+3
	P0z43LqO3zxBh4
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910131654270.32515@iabervon.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130226>

On 2009.10.13 17:31:46 -0400, Daniel Barkalow wrote:
> The other thing that I think would be nice is:
>=20
> $ git checkout origin/next
> $ git fetch origin
> $ git checkout !! (probably not a good syntax)
>=20
> That is, expand "!!" to the string used to detach HEAD, and expand it=
=20
> again now. (Of course, something would have to be done if you did "gi=
t=20
> checkout HEAD^1" before, or "git checkout !!^1".) This is related in =
that=20
> I think the scary message should happen when "git commit" sees this s=
tored=20
> string and clears it.

That sounds somewhat like the "git up" hack I've shown here:
http://article.gmane.org/gmane.comp.version-control.git/130050

In #git, Dscho even suggested that "git pull" could do that kind of
DWIMmery while on a detached HEAD that waas reached by checking out a r=
emote
tracking branch. I'm undecided about that, because real merges/rebases
could make it easier to lose work, as opposed to the "fast-forward only=
"
behaviour I had in mind for that "git up" thing. Though of course, the
"git pull" DWIMmery for a detached HEAD could simply refuse to do
anything but a fast-forward.

Overall, I'm starting to think that improving the "work with a detached
HEAD" area might be more worthwhile than adding DWIMmery that tries to
completely avoid a detached HEAD.

This could include DWIMmery like the "git up"/"git pull" stuff, and
improved security checks, like checking that leaving a detached HEAD
doesn't "lose" any commits to the reflog.  So checkout could do
something like "git rev-list HEAD --not --all" (or does --all include
HEAD?) and complain if there's something to be "lost".

Bj=F6rn
