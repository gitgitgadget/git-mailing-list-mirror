From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 4/6] connect: move error check to caller of
 parse_connect_url
Date: Thu, 30 Jul 2015 14:19:36 +0200
Message-ID: <20150730121936.GB24635@pks-pc.localdomain>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438185076-28870-1-git-send-email-ps@pks.im>
 <1438185076-28870-5-git-send-email-ps@pks.im>
 <CAPig+cRGw6-QhYzxkqVE-psQLHORioGmNFbf3Q72nrsSiES5GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 14:19:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKmoJ-0006iq-O8
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 14:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbbG3MTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 08:19:39 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58595 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750977AbbG3MTi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jul 2015 08:19:38 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 532DD2097A
	for <git@vger.kernel.org>; Thu, 30 Jul 2015 08:19:38 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 30 Jul 2015 08:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=l4TZmIuZM5GLTsMyvhwfYXyhLJs=; b=cfoou
	6yRJKrplpQW+tPel+07vj/CgdU1IAt55Ueu3qPbek6SDiqwbhTWcxdItHiLZlNqB
	4JaFRO2a+zJTU7ErnZDHXyP807Cm8OUyDuZ65FAIIQTDsrQT7aBhP5DV68qlwRd8
	3vAMIQKS1bQv57HDcF84IB6nPxs7DKSOcuEhT8=
X-Sasl-enc: mEeZDq+VbAPGZ4pM4AsG1S34qvOmYcNQpgjoYPvodQnk 1438258777
Received: from localhost (x5ce10d7e.dyn.telefonica.de [92.225.13.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id DCE9AC00025;
	Thu, 30 Jul 2015 08:19:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cRGw6-QhYzxkqVE-psQLHORioGmNFbf3Q72nrsSiES5GA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274986>


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2015 at 04:32:13PM -0400, Eric Sunshine wrote:
> On Wed, Jul 29, 2015 at 11:51 AM, Patrick Steinhardt <ps@pks.im> wrote:
> > parse_connect_url() checks if the path component of the URL is
> > empty and if so causes the program to die. As the function is to
> > be used at other call sites which do not require this check, move
> > up the error checking to the existing caller.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/connect.c b/connect.c
> > index bdbcee4..e8b813d 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -613,9 +613,6 @@ enum protocol parse_connect_url(const char *url_ori=
g, char **ret_host,
> >         else
> >                 path =3D strchr(end, separator);
> >
> > -       if (!path || !*path)
> > -               die("No path specified. See 'man git-pull' for valid ur=
l syntax");
> > -
>=20
> Given that there are several dereferences of 'path' following this bit
> of code, won't this change lead to a crash when path=3D=3DNULL?

Correct, will fix, thanks.

Patrick

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVuhZYAAoJEBF8Z7aeq/Esd+IP/iGkLcK2HI+irbRkOgM0bINP
R/QybxMPf73Lz8wxCincJfBscplzb8uaJoo/4NX/+jH2CAS0Gheh/tDjIuqSA3Kq
RTiWmoXVytEZXARe3/SlPf5oJyoEtUha2G1EF2bOoJbSPHz+sh+4PrwvRLy2g10n
E/KU88uveQJQ7n9rFR1nqcf5miWSKo8UTZW2GxnOPvIDCAQyKDje6V8EGyzpaSGX
2UapAKmVwzU8YumaKgAvHblHmBjUKjjLLu9MKbDYKuuoopzZVfQKGAnCSiX5xa7I
hdhqqmNDiAe3Jf5HC8TMKgGVXDFKs08Y7GSmor9A4q5yl2fuzmpRMkRGn4tq2QmJ
yctywAi6JHrglBDXI4plmKSnPei3+0D9ZRXyzykpCm2HdroTGzqdpD+XpGDtJwVr
0A7+Evq8A02fl6289Ok+cdW73z2mq6OgDU2yM4Fmie5pT7nSnWUXlGr2XnpNdbM8
yDtK/bLZTkW1/NHTnlh6vkk8wGWzgdJ2pzDA39piDve7UkuD8/CjxFyncLL6oVgN
e908h5/cNFhr7IQfVCUruPP3v72rzmLR4vq0OU95+LRzY3EHtbK9Vt7Om8PCtKI1
gzqohpt1Gu1MZnVEllsoft8uv1ZQNbMoNwunKqE0vOC6Boq+lFveEyF+fdkjntuP
hOkzi7biAi8E7OESw5AL
=LmHc
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
