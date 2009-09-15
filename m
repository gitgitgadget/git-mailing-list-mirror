From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Commited to wrong branch
Date: Wed, 16 Sep 2009 00:30:25 +0200
Message-ID: <20090915223025.GB14652@atjola.homenet>
References: <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
 <26ae428a0909150405v3087016fxee5ac98057868677@mail.gmail.com>
 <46a038f90909150416h60ea7d74xd2337fe50f603dcb@mail.gmail.com>
 <26ae428a0909150510n56b1d4eg6565a6cca8c9b46c@mail.gmail.com>
 <46a038f90909150546i508d3781id1dcd8e6c64942cf@mail.gmail.com>
 <26ae428a0909150558i508e5878q8a1ee7cb7311fc57@mail.gmail.com>
 <20090915130640.GC31846@atjola.homenet>
 <46a038f90909150654t73cab47ckfd02f8a2f4353722@mail.gmail.com>
 <20090915203948.GA14652@atjola.homenet>
 <46a038f90909151453u5ead2eb5nebb46930a8e7277@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Howard Miller <howard@e-learndesign.co.uk>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 00:30:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MngXp-0004l8-K3
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 00:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbZIOWa0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 18:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752453AbZIOWaZ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 18:30:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:38878 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752375AbZIOWaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 18:30:25 -0400
Received: (qmail invoked by alias); 15 Sep 2009 22:30:27 -0000
Received: from i59F56716.versanet.de (EHLO atjola.homenet) [89.245.103.22]
  by mail.gmx.net (mp043) with SMTP; 16 Sep 2009 00:30:27 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19GrpcdfpFGxuTN0a9iq3N7/Rv32q0upuUEEHmox2
	gVRJVJfN6mTcv4
Content-Disposition: inline
In-Reply-To: <46a038f90909151453u5ead2eb5nebb46930a8e7277@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128592>

On 2009.09.15 23:53:03 +0200, Martin Langhoff wrote:
> 2009/9/15 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> > Sooner or later you'll hit a merge conflict anyway, and conflict ma=
rkers
> > aren't that hard to understand, and IMHO are easier to handle than =
=2Erej
> > files, as you get to edit everything in-place.
>=20
> When git's diff3 gets confused trying to use ancestry, the conflict
> markers bring completely unrelated things that belong to the history
> of the file and not to the patch at hand.
>=20
> It's not about the conflict markers but somewhat nonsensical proposed
> "sides" to the resolution.

That's not git getting confused trying to use the ancestry, but git
being unable to make use of the history. It has to use a fake common
ancestor, as using the true common ancestor would obviously mean that
you do a real merge, not a cherry-pick. Under some circumstances that
can lead to quite "interesting" conflicts, yeah, but IMHO still better
to deal with than those .rej files, especially when you switch to diff3
conflict marker mode (git checkout --conflict=3Ddiff3 -- file), which a=
lso
contains the version of the code that the "common ancestor" has.

> > Well, you likely shouldn't be using git-apply, which is plumbing, a=
nd
> > can't easily make use of the "index" information in git patches to =
do a
> > three-way merge instead of a "stupid" patch application. Instead us=
e
> > git-am --3way to make git perform a three-way merge, leading to
> > conflicts instead of plain patch rejection.
>=20
> Um, you got your internals wrong. git-apply is what git-am uses.

No, you didn't understand what I said. I said that _you_ shouldn't be
using git-apply. That "git am" internally uses "git apply" is a totally
different story. And with --3way, it doesn't even run just "git apply <
patch", but uses "git apply" just to build a fake common ancestor and
does a 3-way merge with git-merge-recursive.

Bj=F6rn
