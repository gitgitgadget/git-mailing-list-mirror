From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 0/3] the return of the strbuf
Date: Mon, 17 Sep 2007 14:52:11 +0200
Message-ID: <20070917125211.GA18176@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="x+6KMIRAuhnl3hBn";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 14:52:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXG5L-0004Kb-5j
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 14:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbXIQMwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 08:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbXIQMwO
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 08:52:14 -0400
Received: from pan.madism.org ([88.191.52.104]:43264 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752914AbXIQMwO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 08:52:14 -0400
Received: from madism.org (beacon-free2.intersec.com [82.236.12.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id AD9FE6AB
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 14:52:12 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B7696344A49; Mon, 17 Sep 2007 14:52:11 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58433>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  While getting rid of ->eof in strbuf (as it was somehow tasteless). It
made me aware of the fact that fast-import.c was using a custom buffer
implementation (I think that was the fourth if not the fifth). So here
is the series that eradicates it.

  Trying to understand fast-import.c code, I happened to remark that it
was possible to avoid many reallocations, just by reusing old buffers
rather than dropping them (this was not possible in a readable way
before, but it is now, and uses the same mechanisms that was garbage
collecting buffers, to swap them instead).

  I've not enough stuff to do real-life tests of the old fast-import and
the new one, but I wouldn't be surprised that it gives a quite nice
speed improvements for tools that use long fast-import batches. If not,
well, the code is shorter and more readable, hence it's still a gain.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG7nh7vGr7W6HudhwRAoHsAJ98nLlmNEIr2ZSdjBFzgNj2Gvc2kgCfUx4j
mANudawoEmNwK0FDxnW4o10=
=m+nj
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
