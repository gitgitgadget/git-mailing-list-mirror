From: Pierre Habouzit <madcoder@madism.org>
Subject: [wishlist] git-archive -L
Date: Mon, 02 Feb 2009 15:34:25 +0100
Message-ID: <20090202143425.GA30667@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="GvXjxJ+pjyke8COw";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: rene.scharfe@lsrfire.ath.cx
X-From: git-owner@vger.kernel.org Mon Feb 02 15:36:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTzu0-0007a4-Hi
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 15:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbZBBOec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 09:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbZBBOeb
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 09:34:31 -0500
Received: from pan.madism.org ([88.191.52.104]:55976 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685AbZBBOea (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 09:34:30 -0500
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 9068D3FEE7;
	Mon,  2 Feb 2009 15:34:27 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 6FA917DA76B; Mon,  2 Feb 2009 15:34:25 +0100 (CET)
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108094>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rene,

I wanted to do that myself, but I sadly miss the time right now, so I
wonder if you'd know how to do the following.

We have in our repository a kind of modular system (for a family of web
sites) where each web-site uses a (versionned) symlink farm. IOW it
works basically that way:

    www/module1
    www/module2
    product_A/www/module1 -> ../../www/module1
    product_A/www/module_A
    product_B/www/module1 -> ../../www/module1
    product_B/www/module2 -> ../../www/module2
    product_B/www/module_B

Though product_A and _B even if they share a fair amount of code, are
separate products and when we release, we'd like to be able to perform
=66rom inside:

    git archive --format=3Dtar -L product_$A

where -L basically does what it does in cp: dereference symlinks.  To
make the thing hairier, we also have symlinks _inside_ www/ (pointing
into the same subtree) that we'd like to keep if possible (even if it's
not a big deal).

So I'd suggest something where -L only dereferences the symlink if it
goes outside of the list of paths passed to git-archive, and -LL (or -L
-L) dereferences anything. Of course this would only make sense if the
symlinks resolve to something that is tracked :)

For now we git archive the whole repository, use tar xh; rm what we
don't like, reset the symlinks we want to keep, and retar, which is kind
of counterproductive :)


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmHBG8ACgkQvGr7W6HudhyRpQCgkgbYNmbXrHvjkEAOBpSTfwhs
dT0AoI+YVoHnT+MFZsDM/CEhSjhRU3R1
=2RQd
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
