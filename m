From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 5/6] Change output "error: " to "Error: " etc
Date: Thu, 19 Feb 2009 09:14:57 +0100
Message-ID: <200902190915.15227.trast@student.ethz.ch>
References: <200902190736.49161.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1796916.Ly8Fp7Sjzi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 09:17:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La45a-0006fT-PG
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 09:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645AbZBSIP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 03:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753207AbZBSIP3
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 03:15:29 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:7062 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753118AbZBSIP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 03:15:28 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 09:15:26 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 19 Feb 2009 09:15:26 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <200902190736.49161.johnflux@gmail.com>
X-OriginalArrivalTime: 19 Feb 2009 08:15:26.0417 (UTC) FILETIME=[38384410:01C9926A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110643>

--nextPart1796916.Ly8Fp7Sjzi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

John Tapsell wrote:
> All the error messages starting "Error: " begin with a captial E, except
> in one place.  This commit fixes this, making the output look more
> consistent.  At the moment a failed push, say, looks like:
>=20
> Error: cannot lock existing info/refs
> error: failed to push some refs to 'some repository'
[...]
> -	report("fatal: ", err, params);
> +	report("Fatal: ", err, params);

A quick grep says this is going to break the tests:

  t/t1400-update-ref.sh:	 test "warning: Log for '\'master\'' only goes bac=
k to $ed." =3D "$(cat e)"'
  t/t1400-update-ref.sh:	 echo test "warning: Log for '\'master\'' only goe=
s back to $ed." =3D "$(cat e)"'
  t/t1400-update-ref.sh:	 test "warning: Log for '\''master'\'' only goes b=
ack to $ed." =3D "$(cat e)"'
  t/t1400-update-ref.sh:	 test "warning: Log .git/logs/'"$m has gap after $=
gd"'." =3D "$(cat e)"'
  t/t1400-update-ref.sh:	 test "warning: Log .git/logs/'"$m unexpectedly en=
ded on $ld"'." =3D "$(cat e)"'
  t/t4012-diff-binary.sh:	 detected=3D`expr "$detected" : "fatal.*at line \=
\([0-9]*\\)\$"` &&
  t/t4012-diff-binary.sh:	 detected=3D`expr "$detected" : "fatal.*at line \=
\([0-9]*\\)\$"` &&
  t/t4018-diff-funcname.sh:			grep "fatal" > /dev/null )
  t/t4018-diff-funcname.sh:	grep "fatal: Last expression must not be negate=
d:"
  t/t5400-send-pack.sh:	grep "warning: to refuse deleting" child/errs &&
  t/t5510-fetch.sh:	grep "fatal: '\''a\\\\!'\''b'\''" result
  t/t5516-fetch-push.sh:	grep "warning: updating the current branch" stderr
  t/t5516-fetch-push.sh:	! grep "warning: updating the current branch" stde=
rr
  t/t5516-fetch-push.sh:	! grep "warning: updating the current branch" stde=
rr
  t/t6300-for-each-ref.sh:		\"error: more than one quoting style\"*) : happ=
y;;
  t/test-lib.sh:	say_color error "error: $*"

That being said, I'm not sure we can change this at all since it's the
plumbing way of reporting errors/warnings.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1796916.Ly8Fp7Sjzi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmdFRMACgkQqUud07tmzP3GlwCfZM7GUKZEGy7pjU8p26ChbOna
ad4An3o8L+qX3X8OTw33b4DxC+Xewq/N
=YJLT
-----END PGP SIGNATURE-----

--nextPart1796916.Ly8Fp7Sjzi--
