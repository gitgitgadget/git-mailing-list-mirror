Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACD0146D6A
	for <git@vger.kernel.org>; Mon, 13 May 2024 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586834; cv=none; b=Y3uW+Wj6qgj5rDSov6uNbxEWVYDfM52cqchjPLpA5jeIzoUFfW2NcI9n0EdwBRbkH2GsSuY36uBrYUrfy8WwJ9G3G13Tj8DnSySSfNu8UNLXU7Xi/OF4nsTBEpfEj4icjMdxZF0XxorecOIzsQisoc87xpH/r0kPfHY3VHlwmbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586834; c=relaxed/simple;
	bh=NMKoTv7sFWCVlUdl2Sn47fQnYYaNdi5ac72QrGR+9SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtynOEeUWQr3dKa9BZts66G3YrRMFrhvQ2LgdwsllaWjeh309/X8Ks+xyO9rGe1mq/UlYfa7G/s4N+CNbSSw0azm2cgaIgDG6nqoclCnAVT34ATRxrSoAfffR7loHzuecP/A7X/aD/wukxa3wh29FWynOS7iBId5G7lHnRVK+4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RUO1O+Y2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hf1jqh0Q; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RUO1O+Y2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hf1jqh0Q"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 85584180013E;
	Mon, 13 May 2024 03:53:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 13 May 2024 03:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715586831; x=1715673231; bh=zL1zGwbYgr
	u3UVMpdK+XqNuJmfBnbMZSIoji7486UB4=; b=RUO1O+Y21ppJ1d5Bu4jGMUz9sX
	4RDGuH60WOTPNf5OAzp1iBEkBQF/no3bX+I5yQ9brCc6gKCGkjN/jjKOGYsdlPKb
	Uq58OUDb8++xo0y5zwqWFDcxz66/IR4D81jSkZmhD2K2k0uz+Ln3cBfvRrz8Vbr6
	vWXd+sXQyP8N+p6RyJiNSNCBsQq/RujPDRMEEizLaYt+n0iKStKR93AB26xnJ4+D
	O1DDARH8Kjmf/E5LvD1cqiltw6cZjLUSsaAVh3eBMMUnb+TVm5xkwwjjjmgoPlDd
	xX/BucPVrMTnHLUNlUSMb2zjQDTpbg9HAbt1mp64jnqtMirbvPTWzQ39tY1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715586831; x=1715673231; bh=zL1zGwbYgru3UVMpdK+XqNuJmfBn
	bMZSIoji7486UB4=; b=Hf1jqh0QlRfyHrVjrvagu0jTsHxVxzg7dmz1ydPNRosl
	IOYHqTvP6/THxPYsN0sJYVPBDD/Kw+7OvSMhkA4x1SNz3YNXOedYCniEpWxQ3izD
	rQRIq6P2+5nZR7DxMCTpiK1+/wO5uSKZfg+5p/tP6W9TCVHHgxQ88A6+EIe+tx5t
	2vJcyzVxeoGhzzQtiUSvI+p+VFaHmf+817Vukx7Go4tW8n00n8MnitpYr0e124qc
	p/et4c495R5B5R1swYhkMXgOuwn38UFxETvNwK8x479qDZpbFrQoFae7aAXmygSW
	qkKc56RGrgISWRXqhdBjlYCoFz5LHyYhwBn95WTPWg==
X-ME-Sender: <xms:DsdBZs5GVlE6p5d9AJmOdXcHggbgbuQxX1xHnLdFY1_bLdSGW0l8dg>
    <xme:DsdBZt5VN1eMht1XEo-V5x-Usktr8SsbJAeB4-PzTT1MQearzZgRUN4iC3zu57vyI
    KyiINjAC_cWGLlAjg>
X-ME-Received: <xmr:DsdBZrdbvX0vRV58kimFL4AqJfyPjjni2Jvc0rgJOVE95iWnbsDzL3Ukz1R-zOTtr2BNCFkTBEbP0v9OJciIOqA_HZEVlSIkqYrejPpa8XxrLpY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegfedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeehfefhuedtvedtfeeiteeugefgfeelgeelveehffeukeelfefhieekteevudfh
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:D8dBZhLjnS0H0kJynE7OrWHLt28DEwbPMN-3LmZduh6jjGv9_QlkFA>
    <xmx:D8dBZgKfF3McMheiOdo7Zqc37onJXVd0DRMhpC0MQKcKINiXRiw3RA>
    <xmx:D8dBZiwcqQwh-LF89dMkd9vfhOOJHImkueCaWmBbuPNs184yJpw-ag>
    <xmx:D8dBZkIYfua1YYXW9yFyWqTor_cXg9ziMFAsmlz6Z8uSlteNKiPd-w>
    <xmx:D8dBZlGtzdumtgmXnuNTd9bQ8o6sXSxGF-1d4k029PBhslaMQneU4eSE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 03:53:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 708b168d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 07:53:28 +0000 (UTC)
Date: Mon, 13 May 2024 09:53:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 02/11] reftable: consistently pass write opts as value
Message-ID: <ZkHHCInClkoNBgVt@tanuki>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715336797.git.ps@pks.im>
 <e6f8fc09c282e620a331a737c30a190107c76996.1715336798.git.ps@pks.im>
 <xmqqy18h2wys.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wAUb8O3EqJuQSXcR"
Content-Disposition: inline
In-Reply-To: <xmqqy18h2wys.fsf@gitster.g>


--wAUb8O3EqJuQSXcR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 02:11:55PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > We sometimes pass the refatble write options as value and sometimes as a
> > pointer. This is quite confusing and makes the reader wonder whether the
> > options get modified sometimes.
> >
> > In fact, `reftable_new_writer()` does cause the caller-provided options
> > to get updated when some values aren't set up. This is quite unexpected,
> > but didn't cause any harm until now.
> >
> > Refactor the code to consistently pass the options as a value so that
> > they are local to the subsystem they are being passed into so that we
> > can avoid weirdness like this.
>=20
> Turning pass-by-reference to pass-by-value of a large structure is a
> rather huge hammer to ensure that the structure is not modified
> (qualifying the pointer with "const" is).  Consistency is good, but
> I am not sure offhand if this is making things consistent in a good
> way.

Yeah, I've also been a bit "meh" about this. I'm happy to convert this
to all be const pointers instead.

Patrick

--wAUb8O3EqJuQSXcR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBxwgACgkQVbJhu7ck
PpRSpw/9FZhXaQATniwVNdVMakRVwEaWtw3XPX6AKamMi/aftfOOj0Z7a2aUrCPN
4alRnsKhoaXvc/5wtxc8q/2wWwcCzVgks4cxETtD/XbvQkOtNKnIXFalivgSZ9gf
SHX9e5cGP40FrVMvS0DZ6BVFDdJz1QoIpKYJFZ6PK6L6HUDzfTtZt/rdP0EORznn
4rB/+Y1B909me+faqz0vHwOzp4XY+Zf32OjrTs3yYduiLFmozajDdInGgIsl26VB
+GO8/isgKlO+Ooh8H2QkA9zdV7Riaz7R2ETPuI8FtyVPzba9MJVhDwAzCoExhegb
K47H2lQLdTHB5ETEbNRWWMuc/EXX0m4mT275tzGUyMtyzHhe7sEtlmo7AyodeNQP
jYVE/nYRoLxCCGXglwpleoLjY08R7D5xMbnonIAbTjnndudP/MjzOgl7SqU0EMIC
Yk0qLlu+Q540taWyqvECH7EItOr6Ums34CqxaCv7+pmlalT7xwtUi/SxjXqnyk+v
CscgT0G5KCwx5+cLwVU2+fjoTRfNbSPwKu8F0NYdfb+fYzLFBl5VTfH8YIBxBQF4
MHUDKukCJTehSSvJeAw4ysziURG1z1qnHDhNYKRNov0cftxgDiS8+LF12xh1S//2
WWXv8+e4hcRFeK0VqrrdG2yft+oXGFJBbN+JaZpIyFWxkd6urdU=
=NlE6
-----END PGP SIGNATURE-----

--wAUb8O3EqJuQSXcR--
