From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Has anyone looked at Gettext support for Git itself?
Date: Mon, 17 May 2010 17:12:22 +0200
Message-ID: <201005171712.22763.trast@student.ethz.ch>
References: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com> <201005171632.48253.trast@student.ethz.ch> <AANLkTil0iESsCpHm-X3iiMZC3sEzCqYvXjsZiIHvFz3n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Hudec <bulb@ucw.cz>, Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 17 17:12:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE1za-0008AX-Et
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 17:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779Ab0EQPMZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 May 2010 11:12:25 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:28816 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810Ab0EQPMY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 11:12:24 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 17 May
 2010 17:12:23 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 17 May
 2010 17:12:23 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <AANLkTil0iESsCpHm-X3iiMZC3sEzCqYvXjsZiIHvFz3n@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147244>

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Mon, May 17, 2010 at 14:32, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> > =C6var Arnfj=F6r=F0 Bjarmason wrote:
> >>
> >> just prefix the calls to git with LC_ALL=3DC.
> >
> > And how exactly do you expect us to go back in history and prefix a=
ll
> > invocations of git in all scripts with LC_ALL=3DC?
>=20
> I don't expect you to. I just don't think it's unreasonable that if
> Git were to be internationalized that it behave like every other *nix
> program. If you have a Chinese locale and rely on the output of some
> program being in English your scripts will break if the OS
> subsequently upgrades to a new version of the program that has been
> translated to Chinese.

I've bumped against these hysterical raisins in the past too, so you
have my sympathy.  But git's API is the set of its plumbing commands,
I/O, arguments and all.

We do not give a similar promise for porcelain commands, which
includes most of the frequently used commands that also have a bunch
of translatable output like status, clone, fetch, branch, etc.  You
could start by translating the helpful comments in status, commit and
rebase -i.

However, I'm just trying to point out that your suggested solution

> The right way to handle that is to call programs like that with
> LC_ALL=3DC.

will never fly, and that git will, e.g., never be able to consistently
call a commit a "Version" [de] because for-each-ref must forever fill
the %(type) field with "commit".

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
