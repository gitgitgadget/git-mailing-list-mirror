From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/9] Handle errors when setting configs
Date: Sat, 30 Jan 2016 17:03:42 +0100
Message-ID: <20160130160342.GA790@pks-xps>
References: <1453971637-22273-1-git-send-email-ps@pks.im>
 <20160129082036.GA8591@sigill.intra.peff.net>
 <xmqqsi1gi5af.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 17:04:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPY0X-0007on-B1
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 17:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754413AbcA3QDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 11:03:46 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54427 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752754AbcA3QDp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2016 11:03:45 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id D784629273
	for <git@vger.kernel.org>; Sat, 30 Jan 2016 11:03:44 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Sat, 30 Jan 2016 11:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=SJfvOgJLUviake2t5qnWFEGdCdw=; b=L8Ek/
	j0PqsDfna5gML4LEzSttCOqHweebZEksuh68kRHLwEIS4kxSHUv0ihYHjl5j9e3c
	XbLu5PDR7Zcjyoc7ekVVSfqn475JS/L/nXiOGBIQUQbFCqj2JjFszCr61fjKN32O
	b3lZIJEkK8+spwi+EENQSuEhN4WhCtCaSWFmUA=
X-Sasl-enc: z5A+YiveAggiBcmg0PeAZq4rCxoSic/8nIs6CnFxe11T 1454169824
Received: from localhost (p5088a564.dip0.t-ipconnect.de [80.136.165.100])
	by mail.messagingengine.com (Postfix) with ESMTPA id 48140C00012;
	Sat, 30 Jan 2016 11:03:44 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <xmqqsi1gi5af.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285117>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 29, 2016 at 10:55:52AM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > The end result is roughly the same, but it's a lot less churn, and it's
> > more likely for new callers to get it right, because they have to go the
> > extra mile to ignore the error. I say "roughly" because it treats cases
> > we missed as "die", whereas yours leaves them as "ignore". I find it
> > highly unlikely that any of them actually _want_ the ignore behavior,
> > though.
>=20
> Yes, I like this approach better.  It admittedly is more risky in
> that it would die if the conversion missed a case that should
> ignore, but I suspect that such a breakage would be found rather
> quickly (and the one that goes latent are the ones that do not
> matter in practice because people would not encounter them).
>=20
> > I'm just pondering, though. I don't find the "or_die" variant bad at
> > all, so if you really prefer it, I don't mind.
> >
> > Just to get a sense of what the reverse would look like, I worked up the
> > patch below (which compiles but does not link, as I did not actually
> > implement the "gently" form). Some error-checking call-sites are
> > converted to the "die" form, because that's essentially what happens
> > anyway (and I'd venture to say that the config code can provide a much
> > better error message).
>=20
> This variant certainly looks nicer to me, for the reasons give above.

Okay, thanks for your feedback. I'll create a new version next
week, then.

Patrick

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWrN7eAAoJEBF8Z7aeq/EsAw4P/3DGn2rHDxrRx2DrPGL4oSEf
m18Dn+HXjrtTDVFcNaQP3qPh+ozHHZD/gG6oyC9/6Gb/ZbdJ6HtCpGxCXYLK7QA5
K6cy9sEenJpJclplKZKOZo9TPACrmjIOnbzIsWwk33eYxuLzCWu+nDsM/MHsxgTj
QPtnRD8HwUmHarB8IaUS0+M5MvSebr8omlOsfWY+RS4fAegW6PY7BubJEHAjRxB5
qsLvILRPnvmhcNm1p9OsibcqwAUDy2atu2g4vX5MQEPsw5MxbkJ8ZxzCGwSwTDsJ
6QL5xeopC8OrpXaJY1qe3LYpmFoT7yTPa4ND5CgH5OHH4v7xtV+oP/Nu3RzrBJ9I
bB+wvfQSbbcWh2mAAuSNBn82HZcDLIC8mZJuSPT4oNrsiwdrYv+AKNeOsTEZU+2b
PtmOBcEdAQU8jn5ZwZRVh1KKopjcsgQlvzAeGZZsdYYr/l8FqvtvJ8GkBUgdYQbI
TP6jZxhnmDw61lKKoCjrGUy0G/LI6w++LsAO8yw1OiZ5vpvYtoWtwDZnb4LmZbqr
lmSA9TAKFcAjvIU6IAQAbu46KE9fNR1UxyBwBJBm7pfOcopU5TntBPFNFYi2rDa8
vGp5ug6oSg8H0ZIyAeZWbsggn6dPg5mrfqQ82EucswoqfvTJd6EEVWCjdqCPMXc8
Izg9sJylnxxi/hMTwUWE
=zFLz
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
