From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Wrong time in git-log when using right/ timezone
Date: Wed, 25 Jul 2007 22:03:44 +0200
Message-ID: <20070725200344.GA3808@efreet.light.src>
References: <20070718153614.GA28815@hartlich.com> <alpine.LFD.0.999.0707180948080.27353@woody.linux-foundation.org> <7vk5sx77me.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Hartlich <wwsgj@hartlich.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 22:04:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDn5Q-0007oH-8R
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 22:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbXGYUDw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 16:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbXGYUDw
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 16:03:52 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:38169 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbXGYUDv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 16:03:51 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 4A9875725A;
	Wed, 25 Jul 2007 22:03:50 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id YAHKaTsyi85Y; Wed, 25 Jul 2007 22:03:48 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 94BDA57355;
	Wed, 25 Jul 2007 22:03:46 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1IDn5E-0008Vx-Da; Wed, 25 Jul 2007 22:03:44 +0200
Content-Disposition: inline
In-Reply-To: <7vk5sx77me.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53710>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2007 at 13:57:13 -0700, Junio C Hamano wrote:
> No, I do not think the wackiness is from Germans.
>=20
> Using right/ perhaps without realizing the differences between
> TZ=3Dright/Europe/Berlin and TZ=3DEurope/Berlin is probably the
> source of confusion.
>=20
> I do not offhand know what role "leap second adjustment" should
> play in the context of converting from Unix time we store in git
> commit objects to human readable role.  As far as I understand,
> the returned timestamp from time(2), which we record in commit
> objects, is already "leap second adjusted".

I can attempt a brief explanation if anyone is (still) interested.

Leap seconds are added iregularly, because Earth rotation is slightly
irregular. Therefore some time calculations require lookup into a table of
leap seconds:
 - If you include leap seconds in the timer, converting to date+time does,
   while time difference does not. This is what the right/ timezones use.
 - If you exclude leap seconds from the timer, time difference does, but
   converting to date+time does not. This is what the normal timezones use.

Obviously, the two approaches don't play well together. POSIX chose the
later, likely because it's much more common to want to know date+time for
some moment, than to calculate several year long time interval with second
precision (because so far there have been at most 2 seconds difference per
year).

Note, that the former approach allows you to talk about time 65936023 secon=
ds
=66rom now, but not what date and time it will be, while the later allows y=
ou
to talk about 2437-11-05 16:12:05, but not how many seconds are left until
than.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGp6ygRel1vVwhjGURAs/aAJ0bcuy0HjifM16KDfFighvGh7CnJQCfeRAe
c39NDthBUUU4wvb96MJOO7w=
=ZTa8
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
