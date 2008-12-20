From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge commit.
Date: Sat, 20 Dec 2008 16:54:19 -0600
Message-ID: <200812201654.23110.bss@iguanasuicide.net>
References: <200812182039.15169.bss@iguanasuicide.net> <200812200808.02011.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1928902.SKiRPElBL4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 20 23:56:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEAkX-0003k0-2w
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 23:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbYLTWyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 17:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbYLTWyL
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 17:54:11 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:35903 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbYLTWyK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 17:54:10 -0500
Received: from ip72-204-50-125.fv.ks.cox.net ([72.204.50.125] helo=[10.0.0.123])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LEAi0-00009h-UV; Sat, 20 Dec 2008 22:54:09 +0000
User-Agent: KMail/1.9.9
In-Reply-To: <200812200808.02011.robin.rosenberg.lists@dewire.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103671>

--nextPart1928902.SKiRPElBL4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 2008 December 20 01:08:01 Robin Rosenberg wrote:
> fredag 19 december 2008 03:39:15 skrev Boyd Stephen Smith Jr.:
> > On Thursday 2008 December 18 18:21:25 Linus Torvalds wrote:
> > > I suspect we should warn about reverting merges.
>
> Or mention the reverted parent in the commit message since it is not
> obvious.
>
> ---
>  builtin-revert.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-revert.c b/builtin-revert.c
> index 4038b41..fc59229 100644
> --- a/builtin-revert.c
> +++ b/builtin-revert.c
> @@ -352,6 +352,10 @@ static int revert_or_cherry_pick(int argc, const char
> **argv) add_to_msg(oneline_body + 1);
>  		add_to_msg("\"\n\nThis reverts commit ");
>  		add_to_msg(sha1_to_hex(commit->object.sha1));
> +		if (commit->parents->next) {
> +			add_to_msg(" removing\ncontributions from ");
> +			add_to_msg(sha1_to_hex(parent->object.sha1));
> +		}
>  		add_to_msg(".\n");
>  	} else {
>  		base =3D parent;

I'm still new to the code, but parent is the "mainline" specified on the=20
command-line, which (I think) is actually the parent to be reverted to, so =
we=20
are actually removing contributions from all the *other* parents.  So, the=
=20
message may be backward.  Because of that, I'd say the patch doesn't handle=
=20
octopus merges well, either.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1928902.SKiRPElBL4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklNd58ACgkQdNbfk+86fC24mACfa/DzrbBl8i8Y7wPPfa+6c64c
D5IAn3o3a+WvG153BQFF0RCbmlDKXNUl
=q9d4
-----END PGP SIGNATURE-----

--nextPart1928902.SKiRPElBL4--
