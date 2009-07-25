From: Pierre Habouzit <madcoder@madism.org>
Subject: Re: [PATCH] git-add -p: be able to undo a given hunk
Date: Sat, 25 Jul 2009 16:52:37 +0200
Message-ID: <20090725145237.GB18545@artemis.corp>
References: <20090723074104.GI4750@laphroaig.corp>
 <7veis7yxwx.fsf@alter.siamese.dyndns.org>
 <20090724193207.6117@nanako3.lavabit.com>
 <7v8wienk07.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 16:52:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUicF-0006ra-TL
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 16:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbZGYOwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 10:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbZGYOwo
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 10:52:44 -0400
Received: from pan.madism.org ([88.191.52.104]:40576 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565AbZGYOwo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 10:52:44 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 0418240804;
	Sat, 25 Jul 2009 16:52:44 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B12E22AEA0; Sat, 25 Jul 2009 16:52:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8wienk07.fsf@alter.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124017>


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2009 at 09:06:16AM -0700, Junio C Hamano wrote:
> Even though you could add good bits interactively, making multiple
> commits, and remove the remaining debugging cruft at the very end with
> "git checkout $files" or "git reset --hard", if there are debugging crufts
> for two or more phases of development,

FWIW it's what I was doing so far, and it's not very efficient for many
patterns, you talked about the bit where you want to keep some of the
debug, for this one I used to do that:

while I have meaning full commits to do:
    git add -p; commit;
git add -p the things I want to trash and commit
git stash
git reset --hard HEAD~1
git stash apply

That sucks.

Another thing is that: if you have _many_ commits to do, you have to
refuse the same hunks (or worse edit) all over the place. That's awful.
With an "undo", you look at them once only. That's a lot of thinking
saved, and when you have a lot of hunks, less chances to mess an answer
(who here hasn't typed 'y' where he meant 'n' at least once ...)


For all those reasons I believe it's a good thing to be able to have
something to remove hunks from the working-directory. Jeff's suggestions
to move them to some stash is the best suggestion so far, and is safe.

--=20
Intersec <http://www.intersec.com>
Pierre Habouzit <pierre.habouzit@intersec.com>
T=C3=A9l : +33 (0)1 5570 3346
Mob : +33 (0)6 1636 8131
Fax : +33 (0)1 5570 3332
37 Rue Pierre Lhomme
92400 Courbevoie

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkprHDUACgkQvGr7W6Hudhx8dwCglpI8pBFVO9XgldQtbll9pVlE
H1QAn2MfUhp+qgKSYz/swgjVpSl2Kv/p
=8CwU
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
