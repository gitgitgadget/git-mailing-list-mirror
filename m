From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Commited to wrong branch
Date: Tue, 15 Sep 2009 22:39:48 +0200
Message-ID: <20090915203948.GA14652@atjola.homenet>
References: <26ae428a0909150331q391ed39ak622902d175b46d84@mail.gmail.com>
 <46a038f90909150355h20b39c71w4af7e2be2920fdbb@mail.gmail.com>
 <26ae428a0909150405v3087016fxee5ac98057868677@mail.gmail.com>
 <46a038f90909150416h60ea7d74xd2337fe50f603dcb@mail.gmail.com>
 <26ae428a0909150510n56b1d4eg6565a6cca8c9b46c@mail.gmail.com>
 <46a038f90909150546i508d3781id1dcd8e6c64942cf@mail.gmail.com>
 <26ae428a0909150558i508e5878q8a1ee7cb7311fc57@mail.gmail.com>
 <20090915130640.GC31846@atjola.homenet>
 <46a038f90909150654t73cab47ckfd02f8a2f4353722@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Howard Miller <howard@e-learndesign.co.uk>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 22:40:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mneov-0007t6-8O
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 22:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758444AbZIOUjx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 16:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755797AbZIOUjw
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 16:39:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:47345 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758548AbZIOUju (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 16:39:50 -0400
Received: (qmail invoked by alias); 15 Sep 2009 20:39:51 -0000
Received: from i59F56716.versanet.de (EHLO atjola.homenet) [89.245.103.22]
  by mail.gmx.net (mp049) with SMTP; 15 Sep 2009 22:39:51 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/uxgsWou3uCrUQhFIenAyepQ9QYB76ILz7+L1F/q
	wyAi3UAaqyr9As
Content-Disposition: inline
In-Reply-To: <46a038f90909150654t73cab47ckfd02f8a2f4353722@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128588>

On 2009.09.15 15:54:58 +0200, Martin Langhoff wrote:
> 2009/9/15 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> > Just don't use patch(1), there's no sane reason to do that, you're
> > sacrificing all of what git can offer there.
>=20
> Oh, yes there is, specially for newcomers used to patch, and how it
> handles conflicts.

Sooner or later you'll hit a merge conflict anyway, and conflict marker=
s
aren't that hard to understand, and IMHO are easier to handle than .rej
files, as you get to edit everything in-place.

> In this case, I happen to know that Howard is a refugee from CVS land
> (the moodle project in this case), and he is familiar with the output
> of patch if things go wrong.

Uhm, CVS uses the same conflict markers that git uses.

> It's not what I'd recommend to someone that is deep in git-land. But
> even myself (with a bit of code in git) sometimes use patch when
> git-apply tries to be too clever and I just want a damn .rej file to
> review and edit with emacs.

Well, you likely shouldn't be using git-apply, which is plumbing, and
can't easily make use of the "index" information in git patches to do a
three-way merge instead of a "stupid" patch application. Instead use
git-am --3way to make git perform a three-way merge, leading to
conflicts instead of plain patch rejection.

And in a case like Howard's, in which nothing is coming from outside th=
e
repo, there's not even any reason to use am. It's already all in there,
so "checkout -m", "stash/stash apply" (uncommitted changes) and
"cherry-pick", "rebase [-i]" are way better than manually dealing with
format-patch + am or even apply.

Bj=F6rn
