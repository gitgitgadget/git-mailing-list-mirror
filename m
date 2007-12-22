From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [FIXED PATCH] git-describe: Add a --match option to limit considered tags.
Date: Sat, 22 Dec 2007 19:02:44 +0100
Message-ID: <20071222180244.GD23262@artemis.madism.org>
References: <1198253900-31502-1-git-send-email-madcoder@debian.org> <7v7ij87x5u.fsf@gitster.siamese.dyndns.org> <20071221212212.GB10318@artemis.madism.org> <20071221214954.GA16481@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="LTeJQqWS0MN7I/qa";
	protocol="application/pgp-signature"; micalg=SHA1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 22 19:04:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J68hV-0003LX-H8
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 19:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbXLVSCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 13:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbXLVSCw
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 13:02:52 -0500
Received: from pan.madism.org ([88.191.52.104]:52389 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040AbXLVSCw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 13:02:52 -0500
Received: from madism.org (unknown [62.147.220.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id BF0C929469
	for <git@vger.kernel.org>; Sat, 22 Dec 2007 19:02:50 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 47ED31F012A; Sat, 22 Dec 2007 19:02:44 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071221214954.GA16481@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69151>


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Like I said on IRC, I saw that git describe --contains has a bad
behaviour:

    $ git describe --match=3D'asd*' HEAD; echo $?
    fatal: cannot describe 'e272415ab7da3bde51af2ce95c88d7be3abfba28'
    128
    $ git describe --contains HEAD; echo $?
    undefined
    0

THe "undefined" output is on stdout (not stderr), and returns 0.
The issue here is that it internally uses git-name-rev by exec-ing it, which
makes it hard to fix. Though I suppose that we could instead of fork-ing
share some logic with builtin-name-rev.c, but I'm not at home yet, so
won't likely have a patch for this issue.

Note that the use of the "new" --match here was just to be unable to
describe the HEAD to show the difference, the inconsistency has nothing
to do with the patch I propose, I just happen to noticed that.

AFAICT it's not a regression, it's just a misfeature :)
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHbVFEvGr7W6HudhwRAjxsAJ44dtb8DhxhBns4TbCXXA6/aesHCQCff7fu
ri8Bi75VuCTl+cuTUz5VoDQ=
=0IcB
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
