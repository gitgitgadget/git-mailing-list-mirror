From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Wed, 07 Jan 2009 15:39:26 +0100
Message-ID: <20090107143926.GB831@artemis.corp>
References: <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <20090106111712.GB30766@artemis.corp> <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ZmUaFz6apKcXQszQ";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	davidel@xmailserver.org, Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 07 15:41:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKZac-0003pP-28
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 15:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbZAGOjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 09:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbZAGOjb
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 09:39:31 -0500
Received: from pan.madism.org ([88.191.52.104]:60563 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572AbZAGOja (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 09:39:30 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 44B2D3BEF9;
	Wed,  7 Jan 2009 15:39:27 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id DF8AB2B1DB; Wed,  7 Jan 2009 15:39:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104798>


--ZmUaFz6apKcXQszQ
Content-Type: multipart/mixed; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2009 at 07:40:02PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 6 Jan 2009, Pierre Habouzit wrote:
>=20
> > On jeu, jan 01, 2009 at 04:38:09 +0000, Johannes Schindelin wrote:
> > >=20
> > > Nothing fancy, really, just a straight-forward implementation of the
> > > heavily under-documented and under-analyzed paience diff algorithm.
> >=20
> > Btw, what is the status of this series ? I see it neither in pu nor in=
=20
> > next. And I would gladly see it included in git.
>=20
> AFAICT people wanted to be reasonably sure that it is worth the effort.

Fair enough.

> Although I would like to see it in once it is fleshed out -- even if it=
=20
> does not meet our usefulness standard -- because people said Git is=20
> inferior for not providing a patience diff.  If we have --patience, we ca=
n=20
> say "but we have it, it's just not useful, check for yourself".

Well I believe it's useful, but maybe the standard algorithm could be
tweaked the way Linus proposes to make the "long" lines weight louder or
so.

> Due to the lines being much longer than 80 characters, this example was=
=20
> not useful to me.

I hope the other one was ;)

WRT the leaks, you want to squash the attached patch on the proper
patches of your series (maybe the xdl_free on map.entries could be put
in a hasmap_destroy or similar btw, but valgrind reports no more leaks
in xdiff now). As of timings, with the current implementation, patience
diff is around 30% slower than the default implementation, which is a
bit worse than what I would expect, probably due to the fact that you
had to work around the libxdiff interface I guess.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="memory-leaks.diff"
Content-Transfer-Encoding: quoted-printable

diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index d01cbdd..c2ffb03 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -203,8 +203,10 @@ static struct entry *find_longest_common_sequence(stru=
ct hashmap *map)
 	}
=20
 	/* No common unique lines were found */
-	if (!longest)
+	if (!longest) {
+		xdl_free(sequence);
 		return NULL;
+	}
=20
 	/* Iterate starting at the last element, adjusting the "next" members */
 	entry =3D sequence[longest - 1];
@@ -213,6 +215,7 @@ static struct entry *find_longest_common_sequence(struc=
t hashmap *map)
 		entry->previous->next =3D entry;
 		entry =3D entry->previous;
 	}
+	xdl_free(sequence);
 	return entry;
 }
=20
@@ -350,6 +353,7 @@ static int patience_diff(mmfile_t *file1, mmfile_t *fil=
e2,
 			env->xdf1.rchg[line1++ - 1] =3D 1;
 		while(count2--)
 			env->xdf2.rchg[line2++ - 1] =3D 1;
+		xdl_free(map.entries);
 		return 0;
 	}
=20
@@ -361,6 +365,7 @@ static int patience_diff(mmfile_t *file1, mmfile_t *fil=
e2,
 		result =3D fall_back_to_classic_diff(&map,
 			line1, count1, line2, count2);
=20
+	xdl_free(map.entries);
 	return result;
 }
=20

--hHWLQfXTYDoKhP50--

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklkvp4ACgkQvGr7W6Hudhx8PACghxCe4rfCW2S5lHCDR8dFe//b
+NoAn0w3zKRVhmy+cXJxppCzEUTOAuLQ
=ORmJ
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
