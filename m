From: Marc Haber <mh+git@zugschlus.de>
Subject: Re: How to check repository/working tree status from a script
Date: Wed, 20 May 2009 16:27:42 +0200
Message-ID: <20090520142742.GB15453@torres.zugschlus.de>
References: <20090519143537.GA23505@torres.zugschlus.de> <alpine.LSU.2.00.0905191630120.23478@hermes-2.csi.cam.ac.uk> <20090519160031.GB23505@torres.zugschlus.de> <alpine.LFD.2.01.0905190915050.3301@localhost.localdomain> <alpine.LFD.2.01.0905190920051.3301@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 16:27:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6mlr-0005hm-QF
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 16:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbZETO1n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2009 10:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbZETO1m
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 10:27:42 -0400
Received: from torres.zugschlus.de ([85.214.68.41]:32824 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbZETO1m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 10:27:42 -0400
Received: from mh by torres.zugschlus.de with local (Exim 4.69)
	(envelope-from <mh+git@zugschlus.de>)
	id 1M6mli-0004rZ-NZ
	for git@vger.kernel.org; Wed, 20 May 2009 16:27:42 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0905190920051.3301@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119611>

On Tue, May 19, 2009 at 09:29:08AM -0700, Linus Torvalds wrote:
> IOW, something like this:
>=20
> 	# any staged changes (ready to commit)
> 	git diff --quiet --staged || echo Staged changes
>=20
> 	# any changes wrt the index (not staged)
> 	others=3D$(git ls-files --exclude-standard -o -d -m -u)
> 	[ -z "$others" ] || echo "Other changes"
>=20
> should do it.

This looks good.

> If you want more specificity wrt the "Other changes", you can add the=
 "-t"=20
> flag to git ls-files and parse the output to see whether the listed f=
iles=20
> were just unknown (ie new files): '?', changed: 'C', removed: 'R' or =
need=20
> to be merged: 'M'
>=20
> Of course, 'git diff [--staged]' is needed if you actually want to kn=
ow=20
> some "deeper" patterns about _how_ things were changed. IOW, if you w=
ant=20
> to know about renames/copies, you need to use 'git diff -M/C' to get =
that=20
> kind of information.

Thanks. It's ok to just barf if there are any changes.

Background info: the data being version controlled is not source, but
configuration for one system which is collaboratively maintained.
There is a script which takes the currently checked out working tree,
"compiles" it into the actual configuration and rsyncs/activates the ac=
tual
configuration to the (one) target system. I would like to make sure
that if one of the admins runs this script, she has (a) pulled  all
changes that others may have pushed to the central repository and (b)
all her local changes are actually committed to her local repository
and (c) pushed to the central repository.

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
