From: Marc Haber <mh+git@zugschlus.de>
Subject: Re: How to check repository/working tree status from a script
Date: Sat, 23 May 2009 22:39:26 +0200
Message-ID: <20090523203926.GA24004@torres.zugschlus.de>
References: <20090519143537.GA23505@torres.zugschlus.de> <20090521132457.GB5625@torres.zugschlus.de> <20090521153745.GA23463@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 22:39:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7y0S-0001vR-PJ
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 22:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbZEWUj2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 May 2009 16:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752904AbZEWUj1
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 16:39:27 -0400
Received: from torres.zugschlus.de ([85.214.68.41]:34093 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbZEWUj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 16:39:26 -0400
Received: from mh by torres.zugschlus.de with local (Exim 4.69)
	(envelope-from <mh+git@zugschlus.de>)
	id 1M7y06-0006Hs-UA
	for git@vger.kernel.org; Sat, 23 May 2009 22:39:26 +0200
Content-Disposition: inline
In-Reply-To: <20090521153745.GA23463@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119801>

On Thu, May 21, 2009 at 11:37:45AM -0400, Jeff King wrote:
> On Thu, May 21, 2009 at 03:24:57PM +0200, Marc Haber wrote:
> > I am now looking for a solution for (b). I tried=20
> >=20
> > git log -n1 --pretty=3Doneline master..origin/master
> >=20
> > but that seems to always give empty output even if a later issued g=
it
> > pull will actually pull in changes.
>=20
> Try running "git fetch" beforehand, which will actually update
> origin/master with what is on the remote.

I slowly begin to grasp how git works. Thanks for enlightening.

> Also, if you are just checking to see whether there is any output, yo=
u
> can use the plumbing "git rev-list" instead of "git log". So somethin=
g
> like:
>=20
>   git fetch origin || { echo >&2 unable to fetch; exit 1; }
>   test -z "`git rev-list -1 master..origin/master`"

if ! git fetch origin; then
  echo >&2 "unable to fetch"
  exit 1
fi
if git rev-list -1 master..origin/master | grep -q . ; then
  echo >&2 "unmerged changes on remote repository"
  exit 1
fi

Works fine. Thanks.

Greetings
Marc

--=20
-----------------------------------------------------------------------=
------
Marc Haber         | "I don't trust Computers. They | Mailadresse im He=
ader
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 7273=
9834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 3221 232=
3190

Bitte beachten Sie, da=C3=9F dem [m.E. grundgesetzwidrigen] Gesetz zur
Vorratsdatenspeicherung zufolge, seit dem 1. Januar 2008 jeglicher
elektronische Kontakt (E-Mail, Telefongespr=C3=A4che, SMS, Internet-
Telefonie, Mobilfunk, Fax) mit mir oder anderen Nutzern verdachts-
unabh=C3=A4ngig f=C3=BCr den automatisierten geheimen Zugriff durch Str=
afver-
folgungs- u. Polizeivollzugsbeh=C3=B6rden, die Bundesanstalt f=C3=BCr F=
inanz-
dienstleistungsaufsicht, Zollkriminal- und Zollfahndungs=C3=A4mter,die
Zollverwaltung zur Schwarzarbeitsbek=C3=A4mpfung, Notrufabfragestellen,
Verfassungsschutzbeh=C3=B6rden, den Milit=C3=A4rischen Abschirmdienst, =
Bundes-
nachrichtendienst sowie 52 Staaten wie beispielsweise Aserbeidschan
oder die USA sechs Monate lang gespeichert wird, einschlie=C3=9Flich de=
r
Kommunikation mit Berufsgeheimnistr=C3=A4gern wie =C3=84rzten, Journali=
sten und
Anw=C3=A4lten. Mehr Infos zur totalen Protokollierung Ihrer Kommunikati=
ons-
daten auf www.vorratsdatenspeicherung.de. (leicht ver=C3=A4ndert =C3=BC=
bernommen
kopiert von www.lawblog.de)
