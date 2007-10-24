From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git-remote: Use of uninitialized value in string ne, line 248
Date: Wed, 24 Oct 2007 22:39:11 +0200
Message-ID: <20071024203911.GC10900@artemis.corp>
References: <20071024110807.GA12501@piper.oerlikon.madduck.net> <7vwstc68bk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="PuGuTyElPB9bOcsM";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 22:39:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikn0l-0007pd-DT
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 22:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442AbXJXUjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 16:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbXJXUjS
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 16:39:18 -0400
Received: from pan.madism.org ([88.191.52.104]:55963 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753393AbXJXUjR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 16:39:17 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9024A2653A;
	Wed, 24 Oct 2007 22:39:11 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 3402B32034C; Wed, 24 Oct 2007 22:39:11 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vwstc68bk.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62237>


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24, 2007 at 11:49:51AM +0000, Junio C Hamano wrote:
> martin f krafft <madduck@madduck.net> writes:
>=20
> > piper:~> git remote show origin
> > * remote origin
> >   URL: ssh://git.madduck.net/~/git/etc/mailplate.git
> > Use of uninitialized value in string ne at /usr/local/stow/git/bin/git-=
remote line 248.
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^
>=20
> Perhaps....
>=20
>  git-remote.perl |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/git-remote.perl b/git-remote.perl
> index 9ca3e7e..4cee044 100755
> --- a/git-remote.perl
> +++ b/git-remote.perl
> @@ -244,7 +244,8 @@ sub show_remote {
>  	print "* remote $name\n";
>  	print "  URL: $info->{'URL'}\n";
>  	for my $branchname (sort keys %$branch) {
> -		next if ($branch->{$branchname}{'REMOTE'} ne $name);
> +		next if (!$branch->{$branchname}{'REMOTE'} ||
> +			 $branch->{$branchname}{'REMOTE'} ne $name);

  This looks better (wrt the "0" issue raised earlier):

+		next unless (defined($branch->{$branchname}{'REMOTE'}) &&
+			 $branch->{$branchname}{'REMOTE'} eq $name);

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHH61vvGr7W6HudhwRAs/0AJ9bzW8scmkBxYP6Jnn26D7PGns8nwCdHJya
qdYfoBXoSQMGDntX9vSKkrU=
=8aGX
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
