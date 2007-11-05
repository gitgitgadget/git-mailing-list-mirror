From: Pierre Habouzit <madcoder@debian.org>
Subject: [bug in next ?] git-fetch/git-push issue
Date: Mon, 05 Nov 2007 18:56:54 +0100
Message-ID: <20071105175654.GD6205@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="76DTJ5CE0DCVQemd";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 05 18:57:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip6CO-0001PX-Fw
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 18:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbXKER47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 12:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754705AbXKER47
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 12:56:59 -0500
Received: from pan.madism.org ([88.191.52.104]:34725 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754593AbXKER45 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 12:56:57 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id C05812894C;
	Mon,  5 Nov 2007 18:56:55 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 90A9920E79A; Mon,  5 Nov 2007 18:56:54 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Nicolas Pitre <nico@cam.org>,
	Daniel Barkalow <barkalow@iabervon.org>, Jeff King <peff@peff.net>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63531>


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With the current tip of next[0], I have this bizare issue:

  * I have two branches say master, and next, I'm on next.

  * my master lags behind origin/master, but next is a fast-forward wrt
    origin/next.

Now I git push:

    =E2=94=8C=E2=94=80(18:16)=E2=94=80=E2=94=80<~/some/repo next>=E2=94=80=
=E2=94=80
    =E2=94=94[artemis] git push
    error: remote 'refs/heads/master' is not an ancestor of
     local  'refs/heads/master'.
     Maybe you are not up-to-date and need to pull first?
    updating 'refs/heads/next'
      from xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
      to   yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
    Counting objects: 24, done.
    Compressing objects: 100% (14/14), done.
    Writing objects: 100% (14/14), done.
    Total 14 (delta 12), reused 0 (delta 0)
    refs/heads/next: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -> yyyyyyyyyy=
yyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
    updating local tracking ref 'refs/remotes/origin/master'
    updating local tracking ref 'refs/remotes/origin/next'

And then I fetch, and here happens something really awkward:

    =E2=94=8C=E2=94=80(18:17)=E2=94=80=E2=94=80<~/some/repo next>=E2=94=80=
=E2=94=80
    =E2=94=94[artemis] git fetch
    From ssh://some.host/some/repo.git
     * [new branch]      master -> origin/master

I believe there is something rotten in the kingdom of Denmark=E2=80=A6 thou=
gh
my heads seems to always be OK, I think it's just an output issue.

The fun part is that if next has nothing to push, nothing happens:

    =E2=94=8C=E2=94=80(18:55)=E2=94=80=E2=94=80<~/dev/mmsx next>=E2=94=80=
=E2=94=80
    =E2=94=94[artemis] git push
    error: remote 'refs/heads/master' is not an ancestor of
     local  'refs/heads/master'.
     Maybe you are not up-to-date and need to pull first?
    error: failed to push to 'ssh://some.host/some/repo.git'
    =E2=94=8C=E2=94=80(18:55)=E2=94=80=E2=94=80<~/dev/mmsx next>=E2=94=80=
=E2=94=80
    =E2=94=94[artemis] git fetch && echo $?
    0


  [0] actually it's a bit farther than the current next, but for
      parseopt thingies that are irrelevant here. My current origin/next
      is 76374a65c41b80fa83f27b4dd924bd3967a07d69
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHL1lmvGr7W6HudhwRAiktAJ9+PsG5ZaJ/i40KqZu1v0gZ4xMvsgCeL4ZK
R93PksZE8y8vTxAjZlGIDbs=
=pOem
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
