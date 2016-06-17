Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.4 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID,
	T_TVD_MIME_EPI shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5249620179
	for <e@80x24.org>; Fri, 17 Jun 2016 18:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933291AbcFQSHA (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 14:07:00 -0400
Received: from kitenet.net ([66.228.36.95]:53666 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933266AbcFQSHA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 14:07:00 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=EvWieMjB;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466186810; bh=b4j1R8Z6U2F+zYhetH6P8M1KaZ/OzzkcMG4cZ6Dn+GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EvWieMjBVZHjmIralFQiKu2bZyp+jGAIHX7I1GecN+Vo52EKMw94Sqxc76u/qUqj/
	 vkR1obCdiZ+MYuNUywdtYhPWn2DJRLytXvGoVtJjTHMznjUYREkcu65BSXeBXWfHKy
	 /YQDOeRlW7tlElWxEEPnnt0GlYl0QGWmCjPEJz6s=
Date:	Fri, 17 Jun 2016 14:06:50 -0400
From:	Joey Hess <id@joeyh.name>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] add smudge-to-file and clean-from-file filter
 configuration
Message-ID: <20160617180650.GA16404@kitenet.net>
References: <20160616203259.5886-1-joeyh@joeyh.name>
 <20160616203259.5886-3-joeyh@joeyh.name>
 <3c7349e7-34a1-ed7f-721e-e7a7b191bb3d@drmicha.warpmail.net>
 <20160617124707.GB24025@kitenet.net>
 <xmqq60t73igm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <xmqq60t73igm.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Would an interface that always appends the pathname at the end of
> the command line string work?

One problem with this is that "appends" is subtly unclear in this case.

With the example of smugeToFile =3D cmd --to-file
it seems that a space should be added by git before the filename.

On the other handle, consider smugeToFile =3D cmd --to-file=3D
here a space is not wanted before the filename.

So, either a space is automatically included before the filename
and the second example breaks, or no space is included, and
to make the first example work would need careful inclusion of the
trailing space with quoting to prevent it being elided
eg, smugeToFile =3D "cmd --to-file "

%p does avoid this ambiguity. But as Junio noted, %p is mandatory in the
command for it to possibly work. Git could refuse to use smugeToFile =3D cmd
as not containing a %p and so not possibly being able to work.

Or we could pick one of the two methods of appending the file
(I prefer not including a space before it as more flexible), and
anything using this interface would need to design its command line
parsing with this interface in mind, and would probably choose to use
--to-file=3Dfoo rather than --to-file foo.

--=20
see shy jo

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBV2Q8OskQ2SIlEuPHAQLrBg/5AemQkUPPXbb3nvRdU1dn6cch6D/NbyMN
TTPqNH40qy1m3VzV1y5qDNQv9S7pcXlavhHvXWwiL9HLqGOhfh22B30rsIBA/VZB
FEJ/oCTXYqh01UKmEfyzIGKOl07o+0Sw8kShiFvkuML+ED7pMQoUx5If/0sHj/7v
I7zbJTiGCuPb0WnO7M8bjWIyMbzSLodMDgGLd5OtDG/KT72z4W85mYZ50MC3qLoq
GdrTc6WRAeHCTBp3VIkZrRLlWbVoX+Ta/pLmzW1eWr02ZZu8ztg2ubgyxVlsMt5M
HT/iXfUWakFLMjs/VRGxMIE7rQBjPpCQjihAAPGdUpdi3KP8nlZCVnkxiLIr4jpb
vdV/2z/oEzFfGthapazPFqo8QLSnQafhiNyRaCnAmG93+3+xkKZRcM7kcGoy3TSO
jl80QKSo1r8/Q4+PFj/UXSWV9lO1lxW5BxF8kxrs2+N9geKLrudSjGNz3CYPz1O/
ZS1AgZMg1aUetV5XY8l6c99DIGYEhwcotEWsKoTtoX3ARYt/RnK66mjh8Nj1/2SR
N/YXzen2TmCoaYmeYLWRf6pCBtQt9BF5MCfXmi7IKonAZxuuM9vcSrRh9NlPEXSy
fuTehd48ZEfEAo2ByihYK2dxN0GqSj8M80HqVYbTrxo93VYGl7IWjcFUKodCSCjJ
TNaUMfg8Kfk=
=SDUe
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
