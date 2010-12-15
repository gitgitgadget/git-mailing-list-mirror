From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v3 3/8] mingw: make failures to unlink or move
	raise a question
Date: Wed, 15 Dec 2010 08:36:40 +0100
Message-ID: <20101215073639.GB14646@book.hvoigt.net>
References: <20101214220604.GA4084@sandbox> <20101214222122.GD4084@sandbox> <AANLkTi=cHb2kV2MaYu72nXVOksO7O9HhJLEo-fU0sV5N@mail.gmail.com> <alpine.DEB.1.00.1012150109340.1461@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Albert Dvornik <dvornik+git@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 15 08:36:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSlur-0001Bv-B2
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 08:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780Ab0LOHgm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 02:36:42 -0500
Received: from darksea.de ([83.133.111.250]:60735 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753602Ab0LOHgl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 02:36:41 -0500
Received: (qmail 25993 invoked from network); 15 Dec 2010 08:36:39 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 15 Dec 2010 08:36:39 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1012150109340.1461@bonsai2>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163738>

Hi,

On Wed, Dec 15, 2010 at 01:11:03AM +0100, Johannes Schindelin wrote:
> On Tue, 14 Dec 2010, Erik Faye-Lund wrote:
>=20
> > On Tue, Dec 14, 2010 at 11:21 PM, Heiko Voigt <hvoigt@hvoigt.net> w=
rote:
[...]
> > > + =A0 =A0 =A0 if (answer[0] =3D=3D 'y' && strlen(answer) =3D=3D 1=
)
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> > > + =A0 =A0 =A0 if (!strncasecmp(answer, "yes", sizeof(answer)))
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> > > + =A0 =A0 =A0 if (answer[0] =3D=3D 'n' && strlen(answer) =3D=3D 1=
)
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> > > + =A0 =A0 =A0 if (!strncasecmp(answer, "no", sizeof(answer)))
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> >=20
> > Since you're doing case insensitive checks for "yes" and "no", perh=
aps
> > it'd make sense to allow upper case 'Y' and 'N' also? Something lik=
e:
> >=20
> > - =A0 =A0 =A0 if (answer[0] =3D=3D 'n' && strlen(answer) =3D=3D 1)
> > + =A0 =A0 =A0 if (tolower(answer[0]) =3D=3D 'n' && strlen(answer) =3D=
=3D 1)
> >=20
> > hm?
>=20
> Makes sense to me.

Will do in the next iteration.

> > > +static int ask_user_yes_no(const char *format, ...)
[...]
> >=20
> > I'm wondering, doesn't this make the semantics a bit wrong? The
> > function is called "ask_user_yes_no", but it might end up not askin=
g
> > after all. Perhaps it should be called something that reflects this=
?
> > "maybe_ask_yes_no", "ask_yes_no_if_tty", "should_retry"? I don't ha=
ve
> > a non-ugly suggestion, but I suspect something like that might leav=
e
> > other people less puzzled when reading the code.
>=20
> I like ask_yes_no_if_tty.

How about ask_yes_no_if_possible() ? Since we do not just rely on tty
but still have GIT_ASK_YESNO to get to the user I think this would be
a closer description of what happens.

Cheers Heiko
