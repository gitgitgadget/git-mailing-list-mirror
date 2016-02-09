From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: Re: [PATCH] Documentation/git-clean.txt: don't mention deletion of
 .git/modules/*
Date: Tue, 9 Feb 2016 09:55:53 +0200
Message-ID: <20160209075553.GI6104@lakka.kapsi.fi>
References: <1454790889.23898.225.camel@mattmccutchen.net>
 <xmqqvb5y6dx2.fsf@gitster.mtv.corp.google.com>
 <1454971010.2511.89.camel@mattmccutchen.net>
 <20160208224739.GH6104@lakka.kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 08:56:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aT39b-0006WS-9j
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 08:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbcBIH4B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2016 02:56:01 -0500
Received: from mail.kapsi.fi ([217.30.184.167]:39118 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbcBIH4B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 02:56:01 -0500
Received: from lakka.kapsi.fi ([2001:1bc8:1004::1] ident=Debian-exim)
	by mail.kapsi.fi with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1aT39N-00027i-PW; Tue, 09 Feb 2016 09:55:53 +0200
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.80)
	(envelope-from <mikko.rapeli@iki.fi>)
	id 1aT39N-0005bb-Lu; Tue, 09 Feb 2016 09:55:53 +0200
Content-Disposition: inline
In-Reply-To: <20160208224739.GH6104@lakka.kapsi.fi>
X-SA-Exim-Connect-IP: 2001:1bc8:1004::1
X-SA-Exim-Mail-From: mikko.rapeli@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285830>

On Tue, Feb 09, 2016 at 12:47:39AM +0200, Mikko Rapeli wrote:
> On Mon, Feb 08, 2016 at 05:36:50PM -0500, Matt McCutchen wrote:
> > On Mon, 2016-02-08 at 14:22 -0800, Junio C Hamano wrote:
> > > Matt McCutchen <matt@mattmccutchen.net> writes:
> > >=20
> > > > I found no evidence of such behavior in the source code.
> > > >=20
> > > > Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
> > > > ---
> > >=20
> > > That was added last year at bcd57cb9 (Documentation/git-clean.txt=
:
> > > document that -f may need to be given twice, 2015-02-26).=A0=A0It=
 would
> > > be better to know what got changed since then--that is, was the
> > > additional text unnecessary even back then, or we made changes to
> > > the system since then and forgot to remove the added text.
> > >=20
> > > Mikko, is this need to give -f twice still the case?
> >=20
> > I know you probably want confirmation from Mikko, but I'll offer my
> > understanding. =A0There were two statements added in=A0bcd57cb9:
> >=20
> > 1. -f may need to be given twice to delete nested worktrees and
> > embedded repositories. =A0This is still true.
> >
> > 2. Deletion of submodule repositories under .git/modules is conditi=
onal
> > on -f being given twice. =A0AFAICT, this was wrong even back then: =
"git
> > clean" has never deleted such repositories under any conditions.
>=20
> This is the use case which I've used double -f at work with several b=
uild
> jobs but with older 1:1.7.9.5-1ubuntu0.2 (Ubuntu 12.04) and 1:1.9.1-1=
ubuntu0.2
> (Ubuntu 14.04) versions of git.

Sorry, can't reproduce the problem where submodules stayed in the tree =
until
git clean was called with two -f's.

You are right in removing the second part.

> But I can confirm that git version 1:2.7.0~rc3-1 (Debian unstable) is=
 no
> longer removing the git submodule trees from .git/modules with double=
 -f.
>=20
> At work, we really want to remove the .git/modules subtrees since we =
want to
> test changes to .git/modules structure via normal commits to the git =
trees.
> Thus we need a way removing all non-tracked files from the git tree
> which includes obsolete (or for test only) git submodule trees.

This usecase does not exists in git then. Using gerrit topics git branc=
hes
to test changes to submodule structure does not work since there is no =
way of
undoing these changes from the working tree.

I should not have started using submodules in the first place, sigh.

-Mikko
