From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-send-pack: don't consider branch lagging behind as  errors.
Date: Thu, 19 Jun 2008 15:52:00 +0200
Message-ID: <20080619135159.GA19560@artemis.madism.org>
References: <1213872715-11182-1-git-send-email-madcoder@debian.org> <20080619133747.GA31209@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="45Z9DzgjV8m4Oswq";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 19 15:53:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9KZe-0006X9-K8
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 15:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757601AbYFSNwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 09:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757337AbYFSNwG
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 09:52:06 -0400
Received: from pan.madism.org ([88.191.52.104]:50569 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755813AbYFSNwE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 09:52:04 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 9E74E3707F;
	Thu, 19 Jun 2008 15:52:01 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 44E035CA3; Thu, 19 Jun 2008 15:52:00 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <20080619133747.GA31209@sigill.intra.peff.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85474>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2008 at 01:37:48PM +0000, Jeff King wrote:
> On Thu, Jun 19, 2008 at 12:51:55PM +0200, Pierre Habouzit wrote:
>=20
> > It's really painful to have git push error out when it's just that one =
of
> > your tracking branches isn't up to date with respect to a remote branch.
> >=20
> > Let just add a new status: "lagging", always print it to screen when we=
're
> > lagging, but don't exit with a non 0 value, as it really alarms users.
>=20
> This has been discussed before, and the suggested term was "stale".
>=20
> Check out:
>=20
>   http://thread.gmane.org/gmane.comp.version-control.git/73038/focus=3D73=
186
>=20
> which is uncannily identical (the difference is the name, and that I
> don't show the lagged branches unless -v is given).
>=20
> Among the issues that were not sorted out last time:
>=20
>   - should stale branches be shown without -v?

  I believe so, it's valuable information. It's as valuable as what you
get after a git fetch nowadays (like branches have diverged n and m
commits each or similar) But oh well=E2=80=A6 I don't care that much.

>   - calling ref_newer here is inefficient, since we have already called
>     it in the other direction. We should probably do the traversal once
>     in such a way as to find out which ref is newer (or if it is
>     indeterminate).

  Well, true, though I don't expect people to have tons of local
branches that match a refspec _and_ lag behind. I suspect this is a very
minor performance loss.

>   - there is a possible danger with "git push -f", in that you force
>     both rejected branches as well as stale branches. Junio and I
>     discussed the possibility of disallowing "-f" unless the user
>     explicitly requested _what_ to push; i.e., --all, --matching,
>     --mirror, or a refspec. See:
>=20
>       http://thread.gmane.org/gmane.comp.version-control.git/74425/focus=
=3D74481

  Well afaict this is a separate issue, as we're (with such a patch)
only changing what gets printed on the console, not the internal
behavior. So solving this second issue should not really be a
precondition to the inclusion of such a patch.

> I was considering resurrecting my patch after working up that safety
> valve.

  Please please please do :)
  The exit 1 of git-push is really annoying me these days.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhaZH4ACgkQvGr7W6HudhyqtwCcCbSj4veQ0X9uYnnmqx5bD32k
/XQAnjtamNoIZFtzGwACPqGqIFa3kz7U
=sClD
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
