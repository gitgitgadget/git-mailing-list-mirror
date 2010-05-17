From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Has anyone looked at Gettext support for Git itself?
Date: Mon, 17 May 2010 19:59:40 +0200
Message-ID: <20100517175939.GA3575@efreet.light.src>
References: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
 <201005171632.48253.trast@student.ethz.ch>
 <AANLkTil0iESsCpHm-X3iiMZC3sEzCqYvXjsZiIHvFz3n@mail.gmail.com>
 <201005171712.22763.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 17 19:59:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE4bV-0005S3-Ow
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 19:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666Ab0EQR7o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 May 2010 13:59:44 -0400
Received: from cuda1.bluetone.cz ([212.158.128.5]:55515 "EHLO
	cuda1.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653Ab0EQR7n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 13:59:43 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by cuda1.bluetone.cz (Spam & Virus Firewall) with ESMTP
	id 63CB916AF575; Mon, 17 May 2010 19:59:40 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145]) by cuda1.bluetone.cz with ESMTP id qqF7Q3milp9SDFFS; Mon, 17 May 2010 19:59:40 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.71)
	(envelope-from <bulb@ucw.cz>)
	id 1OE4bM-0002WJ-5c; Mon, 17 May 2010 19:59:40 +0200
Content-Disposition: inline
In-Reply-To: <201005171712.22763.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147248>

On Mon, May 17, 2010 at 17:12:22 +0200, Thomas Rast wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > On Mon, May 17, 2010 at 14:32, Thomas Rast <trast@student.ethz.ch> =
wrote:
> > > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > >>
> > >> just prefix the calls to git with LC_ALL=3DC.
> > >
> > > And how exactly do you expect us to go back in history and prefix=
 all
> > > invocations of git in all scripts with LC_ALL=3DC?
> >=20
> > I don't expect you to. I just don't think it's unreasonable that if
> > Git were to be internationalized that it behave like every other *n=
ix
> > program. If you have a Chinese locale and rely on the output of som=
e
> > program being in English your scripts will break if the OS
> > subsequently upgrades to a new version of the program that has been
> > translated to Chinese.
>=20
> I've bumped against these hysterical raisins in the past too, so you
> have my sympathy.  But git's API is the set of its plumbing commands,
> I/O, arguments and all.

The plumbing commands' output, obviously, may not become locale depende=
nt
since it is indeed part of the API. It may sometimes print localized er=
ror
messages though where one can't really do anything besides relying them=
 to
the user anyway.

There are cases though, where somebody calls *porcelain* commands in th=
eir
scripts and there they occasionally may need this LC_ALL=3DC thing. I s=
uppose
having a global option to turn off localization might be useful for suc=
h
users.

> We do not give a similar promise for porcelain commands, which
> includes most of the frequently used commands that also have a bunch
> of translatable output like status, clone, fetch, branch, etc.  You
> could start by translating the helpful comments in status, commit and
> rebase -i.
>=20
> However, I'm just trying to point out that your suggested solution
>=20
> > The right way to handle that is to call programs like that with
> > LC_ALL=3DC.
>=20
> will never fly, and that git will, e.g., never be able to consistentl=
y
> call a commit a "Version" [de] because for-each-ref must forever fill
> the %(type) field with "commit".

I would personally consider it too obvious that "programs like that" me=
ans
porcelain to mention it.

Most error messages may be translated even in plumbing though, just lik=
e they
are translated in standard unix commands.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
