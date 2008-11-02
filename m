From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Sun, 2 Nov 2008 19:54:34 +0100
Message-ID: <20081102185434.GB21251@atjola.homenet>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com> <20081029164253.GA3172@sigill.intra.peff.net> <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com> <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081029171122.GA12167@sigill.intra.peff.net> <20081102123519.GA21251@atjola.homenet> <7vljw2yo93.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 19:56:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwi7p-0003zA-PN
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 19:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756320AbYKBSym convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Nov 2008 13:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757176AbYKBSyl
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 13:54:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:47578 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756472AbYKBSyk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 13:54:40 -0500
Received: (qmail invoked by alias); 02 Nov 2008 18:54:37 -0000
Received: from i577B8DDD.versanet.de (EHLO atjola.local) [87.123.141.221]
  by mail.gmx.net (mp023) with SMTP; 02 Nov 2008 19:54:37 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/Rozl68CPR3ydE+YtQDWYwRJxrRlTUDZyxUm43vl
	iWKXTriynUEXnp
Content-Disposition: inline
In-Reply-To: <7vljw2yo93.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99861>

On 2008.11.02 10:30:16 -0800, Junio C Hamano wrote:
> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>=20
> > Looking at --cached/--index we have basically three things:
> >
> >   --cached to refer to the state of the index (diff, grep, [stash],=
 ...)
> >   --cached to _work on_ the index only (rm, apply, ...)
> >   --index to _work on_ both the index and the working tree (apply, =
=2E..)
>=20
> I think the earlier two are the same thing.  The only difference betw=
een
> them is that in the first one, the definition of your "work on" happe=
ns to
> be a read-only operation.  Am I mistaken?

Yeah, I actually wanted to change that "work on" to a simple "change",
but forgot to do that before sending... :-(

The idea was that currently "--cached" can be "passive" (just look at
the index instead of the working tree) or "active" (change the index
instead of the working tree). Thus there could be three "flag words",
and their usage can be unified, including stash.

"git diff [my] --staged [changes]"
"git stash [but] --keep-staged [changes]"
"git apply [and] --stage my_patch"
"git rm [but] --stage-only some_file"

OK, the last one is still not even close to a proper sentence, and but =
I
guess you get the idea ;-)

> > A quick look through Documentation/ revealed only one problematic c=
ase,
> > which is ls-files that already has a --stage option. And that looks=
 like
> > a dealbreaker :-(
>=20
> 'ls-files' is primarily about the index contents and all else is a fl=
uff
> ;-)
>=20
> You could say --show-stage-too if you wanted to, but the command is a
> plumbing to begin with, so perhaps if we can identify the cases where
> people need to use the command and enhance some Porcelain (likely
> candidate is 'status' or perhaps 'status --short') to give the inform=
ation
> people use ls-files for, we hopefully wouldn't have to change ls-file=
s
> itself at all.
>=20
> The only case I use ls-files these days when I am _using_ git (as opp=
osed
> to developing/debugging git) is "git ls-files -u" to get the list of =
still
> unmerged paths during a conflicted merge.

Heh, that's probably the one thing for which I use "git status" the
most.

Bj=F6rn
