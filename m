From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] strbuf_readlink semantics update.
Date: Sun, 04 Jan 2009 13:21:08 +0100
Message-ID: <20090104122108.GC29325@artemis.corp>
References: <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain> <1230026749-25360-1-git-send-email-madcoder@debian.org> <20081223102127.GA21485@artemis.corp> <alpine.LFD.2.00.0812231009220.3535@localhost.localdomain> <20081224101146.GA10008@artemis.corp> <4952532F.5050704@lsrfire.ath.cx> <7viqp8afap.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Md/poaVZ8hnGTzuv";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 13:22:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJS03-00056g-NC
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 13:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbZADMVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 07:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbZADMVO
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 07:21:14 -0500
Received: from pan.madism.org ([88.191.52.104]:60694 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696AbZADMVN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 07:21:13 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 2C40A3234D;
	Sun,  4 Jan 2009 13:21:09 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 5980F9B8F49; Sun,  4 Jan 2009 13:21:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7viqp8afap.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104509>


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 25, 2008 at 07:23:58AM +0000, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
> > Pierre Habouzit schrieb:
> >> On Tue, Dec 23, 2008 at 06:16:01PM +0000, Linus Torvalds wrote:
> >>>
> >>> On Tue, 23 Dec 2008, Pierre Habouzit wrote:
> >>>> when readlink fails, the strbuf shall not be destroyed. It's not how
> >>>> read_file_or_gitlink works for example.
> >>> I disagree.
> >>>
> >>> This patch just makes things worse. Just leave the "strbuf_release()"=
 in=20
> >>> _one_ place.
> > ...
> > The "append or do nothing" rule is broken by strbuf_getline(), but I ag=
ree
> > to your reasoning.  How about refining this rule a bit to "do your thing
> > and roll back changes if an error occurs"?  I think it's not worth to u=
ndo
> > allocation extensions, but making reverting first time allocations seems
> > like a good idea.  Something like this?
>=20
> I think this is much better than Pierre's.

I agree it's a fine semantics.

> Pierre's "if it is called strbuf_*, it should always append" is a good
> uniformity to have in an API, but making the caller suffer for
> clean-up is going backwards.  The reason we use strbuf when we can is
> so that the callers do not have to worry about memory allocation
> issues too much.

Ack.

Sorry for the delay I was on vacation.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklgqbQACgkQvGr7W6HudhxQvQCghWnMhOYTF/ieikNI6lBW7YcF
tnoAmwdqc2MR+w/Ka7zEMKQI/l3TAUIl
=5+S3
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
