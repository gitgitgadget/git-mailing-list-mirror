From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
	state
Date: Fri, 16 Jan 2009 01:11:39 +0100
Message-ID: <20090116001139.GA26357@atjola.homenet>
References: <87ab9th0rh.fsf@cup.kalibalik.dk> <7vfxjlxuu5.fsf@gitster.siamese.dyndns.org> <20090115153529.GA13961@neumann> <7vvdsgql17.fsf@gitster.siamese.dyndns.org> <bd6139dc0901151420j4ae62433uc0cc70d86dc45cfa@mail.gmail.com> <20090115225912.GL9794@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 01:14:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNcKh-0001DA-Dd
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 01:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbZAPALn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 19:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754197AbZAPALn
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 19:11:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:55149 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750942AbZAPALm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 19:11:42 -0500
Received: (qmail invoked by alias); 16 Jan 2009 00:11:39 -0000
Received: from i577B90FF.versanet.de (EHLO atjola.local) [87.123.144.255]
  by mail.gmx.net (mp047) with SMTP; 16 Jan 2009 01:11:39 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+rf3odFhCrG9iairi6n7I8Ni+LwtiSjlCFbrolub
	S4ybVJ10TvgTsE
Content-Disposition: inline
In-Reply-To: <20090115225912.GL9794@neumann>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105897>

On 2009.01.15 23:59:12 +0100, SZEDER G=E1bor wrote:
> On Thu, Jan 15, 2009 at 11:20:08PM +0100, Sverre Rabbelier wrote:
> > On Thu, Jan 15, 2009 at 23:09, Junio C Hamano <gitster@pobox.com> w=
rote:
> > > I agree that is a true disadvantage that shows "reset --soft HEAD=
^" is a
> > > bad idea (you could still say commit -c @{1}, though).
> >=20
> > But it's not:
> > "It also makes sure that a pre-filled editor is fired up when doing
> > "git rebase --continue", in case the user just wanted to fix the
> > commit message."
>=20
> Indeed, but in this case the rebase process will continue after
> finishing the commit message.  OTOH, with the current behaviour, you
> must do a 'git commit --amend && git rebase --continue', which might
> seem more complicated at first sight, but...

No, you don't have to do that. As long as you only want to "edit" the
commit you marked as "edit", you only need to use "git add" and "git
rebase --continue". rebase -i checks whether HEAD still resolves to the
same commit and if so, it automatically does the soft reset for you.

Maybe we should just advertise that in the message provided by rebase
after it stops? I'm afraid I can't come up with a sane wording though,
as there are still cases when you need to commit yourself, eg. when you
use reset. And getting that into one simple sentence seems a bit hard
(for me).

A bit off-topic: The "auto-amend" code path passes --no-verify to git
commit. What's the reason for doing that? I actually always expected
that to use my pre-commit hook to stop me from committing crap. :-/

Bj=F6rn
