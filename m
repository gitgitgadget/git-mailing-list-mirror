Received: from smtp-good-out-3.t-2.net (smtp-good-out-3.t-2.net [93.103.246.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51688C8F0
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 04:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.103.246.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769574641; cv=none; b=mxvOWT8myEP9079JZnQxfVvj+09rY5d7LE6zBlqhUFUDzu7oUyf3RQwzCRkqX2eX1i3wsH13JkSN0r8o9HIalv5ZJQcCTNdgjty1sQnCtElnSHbEhPpLAIDizCvxtxBOoTbR08vBdL3SY0ciycC7FXlGDbMdKvKoaHVwSgy77B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769574641; c=relaxed/simple;
	bh=uqqqV+IK2Hyr1ShajsmLCKqWsLih1lpA9IVLXrDyW+w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IoJUa43a+ALPEaXK6jGjK5YpYOFHWmCITlAzC49dqMGxBI3Z4tgx6vTIHnnwx7A6N1vNHtAIwNOUtpiD2X+UMTIBWpKkotqOjDRoPz82aoZKjxGGRQccoYMvZ2+OBTsMcA0B1IzI2n8kNXK7Tw8dX/5kAf9YfeqdPc76kkC9Uow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net; spf=pass smtp.mailfrom=t-2.net; dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b=XAU6YKMd; arc=none smtp.client-ip=93.103.246.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-2.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b="XAU6YKMd"
Received: from smtp-2.t-2.si (smtp-2.t-2.si [IPv6:2a01:260:1:4::1f])
	by smtp-good-out-3.t-2.net (Postfix) with ESMTP id 4f18L758yzz9vDSS;
	Wed, 28 Jan 2026 05:24:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
	s=smtp-out-2; t=1769574255;
	bh=uqqqV+IK2Hyr1ShajsmLCKqWsLih1lpA9IVLXrDyW+w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XAU6YKMd522zG8xO6siMi5M1XvPjx94fwZNIxFZDcqSw892B2wR0Hv3R12P2CIYh7
	 HprCtUZG6AlIqB2ENv1jwlrF+UPYHo1M3v40aKXDRn3iVVNYdKIIORsfdnepDpxCWV
	 HZ7DvqozudYMn++BZldlCFPfVRMBz6GeoTY14Ms0=
X-Virus-Scanned: amavis at mail.t-2.net
Received: from hpfur15.u2up.net (89-212-91-172.static.t-2.net [89.212.91.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: samo_pogacnik@t-2.net)
	by smtp-2.t-2.si (Postfix) with ESMTPSA id 4f18Kr7339zMrTrZ;
	Wed, 28 Jan 2026 05:24:00 +0100 (CET)
Message-ID: <3253600a3c96144744d3371a7ec2a66cb87d4b60.camel@t-2.net>
Subject: Re: [PATCH v2] shallow: set borders which are all reachable after
 clone shallow since
From: Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Date: Wed, 28 Jan 2026 05:23:53 +0100
In-Reply-To: <xmqqfr80xanx.fsf@gitster.g>
References: <pull.2107.git.git.1763807914242.gitgitgadget@gmail.com>
	 <pull.2107.v2.git.git.1763926552033.gitgitgadget@gmail.com>
	 <xmqqh5ujuekq.fsf@gitster.g> <xmqqfr80xanx.fsf@gitster.g>
Autocrypt: addr=samo_pogacnik@t-2.net; prefer-encrypt=mutual;
 keydata=mQINBFwCXogBEAC4B5dfY/m82d0d5VBtFeVAjtUrOOdrLgbYJZFUXsX9pya5x0QdYeTP4
 afUZ73e7zMe0ozH8UMz6iv1niPfPkMorUzNcALDcotZ8Vvf3bMdndV7lHk8jScAMoW2L7VHGn1N+H
 8yJ5WufqF/yNBLqmVqaLqNjHejZN+Ld+/4AaJ/gQzWVqYH6EaJZd/LSqppJWGOHGGURFakFSDp3Bi
 6n8SOQmarOt6mGX5wsiHNwa8NtNX1cEJPT8YCQUR7o5fTHb3AEemLRFJoGjeH2RjzPloyTlwSjLXd
 Egph2uUGqiBKD1dREfIuIWtFAJF+iMRHhIEJSF4hvUYrYAV+7ZTlIo3NnDLIeNn40Qmn++9Uh8FbL
 YdFb14dyBkw8MBBQPQNCCpBflK7aaSFWpHv6nk/Z7fGrkwrD51CHsDut8PGQMtmSYMoSCWRI1wChn
 peoZn4Cq3yG1rj90IVv/rxmvL3oMQfE2oSMAhpyRPi0vK68cG4ILpO65Aulr0wr4JFdZBNmpf8BCF
 4jqpN1HsQJCYUYBMeMeOMkH9Gz3DBWuszvjjs7wmesMkEz5C92UlK6FWGUz6Ioi2bfRGOzx0+AjpZ
 rUaSIQ+5MCPxjWkxl3EQQFL2U3ItxxpaDO46AoRFj4oKKeHoteiwpziY8whIFmDXWfy7nDfp76RiS
 riLtyZiFEuzLwARAQABtCZTYW1vIFBvZ2HEjW5payA8c2Ftb19wb2dhY25pa0B0LTIubmV0PokCTg
 QTAQoAOBYhBNCCwgeDpWpcp2HPBvAkWUZaOuMIBQJcAl6IAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4
 BAheAAAoJEPAkWUZaOuMIKE8QAJ04bxv8nXpY3Tp5nWOIOsBmEHWvVEIdD2kxjC9YCQeKx4gJLADa
 RcuXhFbwi0NQtuSRf1G11ZGqxBM/YHvSd4Rtqbag4P9UY/ZdvMAe1zW4HTO9c2mtoWN3WYxS/gkX+
 wBLVIy+eqrsG5peJmRlq3fTbCxLprgqp6B2IUcTEBa8Iynv7B/1qsG2rd0y8pY+ZHIUtz2ZJHoYz2
 Lx091uYwy9aozibWRot+vZNx4QipOmsoZOm+e5FvTf4yvmFYJ3iR8fUfq9gpCokRNtPG5NvqNLApk
 EwEAlaXH7flAUwF/uRBUASZeyEeKGRtXOUYeGXFyOgykbmIs9IXDms8OLj/TZlSzECeoSX25I0P8M
 QrMb7GChMME4W9i9+ZZc8VWPyYW8W6dyNfBb05lu0XMB62oiYim7cOXiDV49EBYtiXIwUnbfQYVSA
 U8MTvZKS4ek2KGc9OJNLnm8dP2u31jvMUts7AEoU3vxwv8tUBEm4Zpzv8+HvzpAGAnbGc/kiLClaH
 j8E5d/3XIyq0TXlZf7B5Fq+lwa3gXMiLWko7m3PfOFtvbsSWPxplka6r2T2GMt9e51sctckfd7V/F
 unQvSwML0gpE6YicA/OcoFFOwoipilJ4D0YcqLgO8FNQdXukJciq0xeeBWY4t8Oo5M88J4YzAKMr9
 PU/BhjCBDTyCb2b1
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-UnAnBvpD/itFhqQ4VyTN"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-UnAnBvpD/itFhqQ4VyTN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-01-20 at 12:59 -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > > ...
> > > The modified implementation of a generic shallow boundary finder
> > > based on rev-list ensures that all shallow border commits are reachab=
le
> > > also after being grafted. This is achieved by inspecting all parents
> > > of each initial border commit candidate. The border commit candidate
> > > is set border only when all its parents wern't on the initial list of
> > > candidates. Otherwise the border commit candidate is not set as borde=
r
> > > however its parents that weren't on the list of candidates are set as
> > > borders.
> >=20
> > It is a minor point, but there are "boundary" and "border" used more
> > or less interchangeably in the proposed commit log message, and
> > would make the readers wonder if there are differences (I do not
> > think we use the word "border" anywhere in our documentation).=C2=A0 It
> > is minor as we do not have such mixture in the end-user facing part
> > of the documentation with this patch.
> >=20
> > I'll let those (cc'ed) who may be more familiar with, or, at least
> > have more code than I have in, the shallow infrastructure to comment
> > on the way the updated code uses the revision machinery.
>=20
> After this exchange, the topic has been dormant for almost full two
> months.=C2=A0 As I do not deal with shallow clones myself, even though I
> understand that some folks rely on it working, I'd really prefer to
> see somebody who are familiar with the underlying logic to review
> this patch if we were to move forward with it.
>=20

I=E2=80=99m currently rewriting the patch and the commit message trying to
address the boundary/border dilemma. I hope to be able to send a new
version by the end of this week.

Best regards,
Samo

--=-UnAnBvpD/itFhqQ4VyTN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE0ILCB4OlalynYc8G8CRZRlo64wgFAml5j1kACgkQ8CRZRlo6
4wjwGQ//SII7IqFzACnqKSiPKA+iv4Fg3tkIiDN52qIX/lOlfx6J13w3VjHlM4T/
yEL9uaFdyNr/88bX0+6RnS8VZrwU0npHCxBcPulKSnu46HHn5XaruR74V2Uy+vuU
iDbCHZhYg4jis0MFrPag6aXEVoSqNceBlN1hA98MW8JM3QJaHQJsSYkUi2vICMUL
Hri2XLh9ehqScuWgcXTTwjjy/rIMX8Ig3glD1b2IUCHtiwMvewESG6CP+s/9Telj
xauvji6ULS3GuhoOyD2IyaJanHlx86hEcgd1pLp0Lt+KjB+mKbLeiLCpdOffn920
Eq+i7lHn3Ree7oA+jSQ1a3r0NYWTZDX3NOXcYHQIQ9+BUXkmnvfP7UTw4pPzoFHH
+Q95Ttxz203KpMDTz1hi9i90fIXppjVMDvBNdoV8z9Opf8aF1Y0vLB6ozRkekno2
zgTLnYMxXTpW2lYhLsIYTOtXf/eOVLzvONEiQkayJ6aoEgJYXK6nsLCgKx5C4Foc
uk62vUqsiracV/9Rv79aPnHhk1iTe6G9LSzz7k8+1C9oYEEuB38KPG4z0vPDWuHR
tW4neRNUnNoBDoUltWM7YxgDSxK8guttWizTbe0wPC3dqg0kwxQVPEjVFBcxA3M2
qNg5K8oi9dvQ2+9+MK4zYNfne9mMfo2bx5jOPxSXG4N3GO/yLMQ=
=0k0z
-----END PGP SIGNATURE-----

--=-UnAnBvpD/itFhqQ4VyTN--
