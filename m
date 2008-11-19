From: martin f krafft <madduck@debian.org>
Subject: Re: [TopGit PATCH] Check for help invocation before setup
Date: Wed, 19 Nov 2008 19:32:34 +0100
Organization: The Debian project
Message-ID: <20081119183234.GA19781@piper.oerlikon.madduck.net>
References: <1227110623-4474-1-git-send-email-madduck@debian.org> <1227110623-4474-2-git-send-email-madduck@debian.org> <20081119182436.GB10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Nov 19 19:34:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2rsR-0002mN-SZ
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 19:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbYKSScq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 13:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbYKSScq
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 13:32:46 -0500
Received: from clegg.madduck.net ([193.242.105.96]:35329 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbYKSScp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 13:32:45 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id BBB981D40A9;
	Wed, 19 Nov 2008 19:32:35 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 7B3889F1B2;
	Wed, 19 Nov 2008 19:32:34 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 11B5545F4; Wed, 19 Nov 2008 19:32:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081119182436.GB10544@machine.or.cz>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.26-1-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8650/Wed Nov 19 05:59:50 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101367>


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Petr Baudis <pasky@suse.cz> [2008.11.19.1924 +0100]:
> > +args_saved=3D"$@"
> > +while [ -n "$1" ]; do
> > +	case "$1" in
> > +	help|--help|-h)
> > +		shift
> > +		do_help "$1"
> > +		exit 1;;
> > +	esac
> > +	shift
> > +done
> > +set -- $args_saved
> > +unset args_saved
> > =20
> >  ## Initial setup
>=20
> Huh, why do you actually need $args_saved at all? :-) This is bound to
> do horrible things with space-containing arguments etc., I think. You
> don't need to do the outer shift and then drop $args_saved altogether,
> no?

I figured I need to restore $@ for others to consume, e.g. when you
check for -r later.

The challenge is to identify help|--help|-h anywhere on the command
line. Thus, you need to iterate, or do some weird matching against
$*.

When you iterate in a for loop, it's not easy to get at the next
argument, except if you use a state machine. I wanted to avoid that.

But you are right, I am wreaking havoc with space-containing
arguments. I will have to go back and rework this.

I take it you agree with the general principle though?

--=20
 .''`.   martin f. krafft <madduck@debian.org>
: :'  :  proud Debian developer, author, administrator, and user
`. `'`   http://people.debian.org/~madduck - http://debiansystem.info
  `-  Debian - when you have better things to do than fixing systems
=20
"it is easier to be a lover than a husband for the simple reason
 that it is more difficult to be witty every day
 than to say pretty things from time to time."
                                                   -- honor=E9 de balzac

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkkW8EACgkQIgvIgzMMSnXiKgCeJK07LJKnV5VPVrzAf++LEiHT
7lYAn1VWJixz6+WtsOeBA5Jol+SWTIK/
=Ikgo
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
