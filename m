From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Sat, 1 Dec 2007 21:37:59 +0100
Message-ID: <20071201203759.GA11710@atjola.homenet>
References: <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org> <Pine.LNX.4.64.0710260007450.4362@racer.site> <7v3avy21il.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0710261047450.4362@racer.site> <7v3aurcjpq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711281307420.27959@racer.site> <27E5EF3C-19EF-441C-BB12-0F5B29BEAEDB@midwinter.com> <Pine.LNX.4.64.0711282039430.27959@racer.site> <8c5c35580711281310h8764a33pba48e65010abf859@mail.gmail.com> <7vhcj63uhw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 21:39:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyZ7p-0008Th-Sd
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 21:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbXLAUiF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Dec 2007 15:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbXLAUiE
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 15:38:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:43343 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751400AbXLAUiD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 15:38:03 -0500
Received: (qmail invoked by alias); 01 Dec 2007 20:38:00 -0000
Received: from i577AFD11.versanet.de (EHLO localhost) [87.122.253.17]
  by mail.gmx.net (mp043) with SMTP; 01 Dec 2007 21:38:00 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/iqhsyJ6Li4m8rGYO6gHvsR8UhHtNLI5YNewj4ZA
	kdLqjRQqCIqMWh
Content-Disposition: inline
In-Reply-To: <7vhcj63uhw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66737>

On 2007.11.28 13:55:39 -0800, Junio C Hamano wrote:
> "Lars Hjemli" <hjemli@gmail.com> writes:
>=20
> > On 11/28/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote=
:
> >> On Wed, 28 Nov 2007, Steven Grimm wrote:
> >> > I wonder if this shouldn't be branch.<name>.pulltype or somethin=
g like
> >> > that, so we can represent more than just "rebase or not." Values=
 could
> >> > be "rebase", "merge" (the default) and maybe even "manual" to sp=
ecify
> >> > that git-pull should neither merge nor rebase a particular branc=
h even
> >> > if it matches a wildcard refspec.
> >>
> >> I am not convinced that this is a good thing... We already have
> >> branch.<name>.mergeOptions for proper merges, and I want to make c=
lear
> >> that this is about rebase, and not about merge.
> >
> > Maybe branch.<name>.pullOptions ?
>=20
> Maybe not make this part of git-pull at all?  merge and rebase have
> totally different impact on the resulting history, so perhaps a separ=
ate
> command that is a shorthand for "git fetch && git rebase" may help
> unconfuse the users.

Hm, why not tackle the whole thing the other way around? IMHO the
primary action is the merge/rebase, not the fetch. So choosing which
action you want in addition to the fetch seems a bit backwards. git-svn
already includes a fetch from svn in its rebase operation, which is
really handy, because you rebase quite often with that beast.

And it's likely that you want to merge with/rebase against the latest a=
vailable
remote commit all the time anyway and on the few(?) occassions
where you have no connectivity, but already fetched some remote stuff
which you want to incorporate into your local branches now, it's
hopefully bearable to pass --no-fetch.

So how about adding --fetch/--no-fetch (maybe with a configurable
default?) to git-merge/git-rebase and deprecate git-pull over time?

Bj=F6rn
