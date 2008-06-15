From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Make git reflog expire honour core.sharedRepository.
Date: Mon, 16 Jun 2008 00:55:00 +0200
Message-ID: <20080615225459.GA13472@artemis.madism.org>
References: <1213565862-23247-1-git-send-email-madcoder@debian.org> <7vhcbuco2w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="17pEHd4RhPHOinZp";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, gitster@pobox.com, joerg@debian.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 00:55:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K818g-0006is-Pd
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 00:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbYFOWzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 18:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbYFOWzE
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 18:55:04 -0400
Received: from pan.madism.org ([88.191.52.104]:40895 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbYFOWzD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 18:55:03 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id BD0A281;
	Mon, 16 Jun 2008 00:55:01 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 38A0833C2; Mon, 16 Jun 2008 00:55:00 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <junio@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, joerg@debian.org
Content-Disposition: inline
In-Reply-To: <7vhcbuco2w.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85150>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2008 at 10:47:51PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >  builtin-reflog.c       |    1 +
> >  t/t1301-shared-repo.sh |   15 +++++++++++++++
> >  2 files changed, 16 insertions(+), 0 deletions(-)
> >
> >  Some people like to have logAllRefUpdates even for bare repositories, =
and if
> >  shared, git-gc breaks them.
> >
> > diff --git a/builtin-reflog.c b/builtin-reflog.c
> > index 897d1dc..430929f 100644
> > --- a/builtin-reflog.c
> > +++ b/builtin-reflog.c
> > @@ -308,6 +308,7 @@ static int expire_reflog(const char *ref, const uns=
igned char *sha1, int unused,
> >  		} else if (cmd->updateref && commit_ref(lock)) {
> >  			status |=3D error("Couldn't set %s", lock->ref_name);
> >  		}
> > +		adjust_shared_perm(log_file);
>=20
> Why is it sane to do this unconditionally, instead of putting in another
> else or something?

  Huh indeed, the proper patch should have been:

-		}
+		} else {
+			adjust_shared_perm(log_file);
+		}

  It was inattention on my end, I focused more on writing a test case
than on the one liner fix. Sorry.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhVncMACgkQvGr7W6HudhykCwCfXU53fLRcrZZVl2hZrrjt+JVr
bFoAn115/TJO/noUiKX5ii7icIHdAC8j
=dDdY
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
