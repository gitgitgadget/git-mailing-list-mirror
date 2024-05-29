Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E8C1C286
	for <git@vger.kernel.org>; Wed, 29 May 2024 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969435; cv=none; b=ewIoY3PE96ayWkLPyPfh+FEETcQeACxDUGx0YuQowLWk+QFq1YW3Zgolw87rC8AL4mFgMDByMrVcuQUok7dfRu3xOOmH/iJW4cHgQ83WHVypPDxxZzf2f2n3pPX9baOuaxGUnaEXAen9IB3OLGfypsmDSM53l7Kx9xoWZfKtJT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969435; c=relaxed/simple;
	bh=XrIy1DFFb+mXO/pcKR0/kEerJTVF4uIYoZA5bbo75O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azTEdt0QfFKGf6yP6epcwKyZKaj5TlK26Y/gi9UXv9/QJiW81hOcyWS0Dck9mLuIgYW9auoJMN+5t2YpAZMkKZknK1ePzi1RT1Lhfx7ECHGJor9SJtQ5iyuiaRxI63ShoLNsqgQYCStxz16bFwqlU1gGTPy6sY9+hMWTCkP6Q4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kJul0vDW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cz4W4PiG; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kJul0vDW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cz4W4PiG"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 08C6B1C0019B;
	Wed, 29 May 2024 03:57:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 29 May 2024 03:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716969432; x=1717055832; bh=SnIG3bVBZs
	JP7rYLwGf8LcI+9oD5AwgvG0B95RW7jeg=; b=kJul0vDWajEwyQP4juqrtd+R8c
	E8oAqcSwzVA89NFglNVN+8vVlofcPxfOwzTyxLY+nr0LD7V2F3EUJWTt4LgTgthZ
	hySnuXQw2napHQ9HUttSV/3JpHlGScBaENsHUefa0OVvhwkqTN7MfSNYI0CMx64j
	2EYCFLDmjfHZi87iKld+KrMIZCyoUyj7HLa/b11mlx673lm87oK/73Um+We6wd3i
	7BgXyFaNiq2eKRsSD3Q5gGF3tyDNK0Oy7MtsI7FgiZb3O+6GQ9pg3OWA6CT8f7xI
	i/62SIkgOc1Cius4M+QnEaazM8pYTOLEfuF9Sg8ghflK77ZLVj7Dfohh791A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716969432; x=1717055832; bh=SnIG3bVBZsJP7rYLwGf8LcI+9oD5
	AwgvG0B95RW7jeg=; b=Cz4W4PiGIWFiulO8KY1Vwk9nKT0sBISqX79vyAZ1Hiuh
	Z8zFbn2R6+l7RiVFFbTxW/N7v5y1gzLwuYdXQ3Kd0MdqulrcWf3hMmvHfW5W5xHB
	6RvFQNvvgrq9WUeoXv8rnM/TAuOe4k8iKXeckjkSyTYeFoKI0HPRiCj8JiRDDfiH
	yi0uqy+h5iErN0JvHSnS93DOWM+TZkMPCq6fVKZ6kht06SI1k5AZ8QgS0jz7l1Wj
	FJFA41GPRPdXav9rRItCblYQ6ciXhETsilcBW71L1T5JWWIQN5RHbZ2WugeENqiX
	QSYb7tThVyoeWFJAOL9B9J8P7sClGwLrdbu73vjgow==
X-ME-Sender: <xms:2N9WZp4PwbCYfp1Zn4l0jE8x8jGjVA_Lp0LEMIH8mV1zwkK3LsA-IA>
    <xme:2N9WZm622WfVJpsDL46SRI2Z0aj5tELhly7XhPxtD3ryW0ezbYJLRPpo612GbNoz8
    rI-Z76RGZpx27xGww>
X-ME-Received: <xmr:2N9WZgfZYVqRdzHMYuXza3b-UGA28mhRDNqKIpQvLUX91cXGFeQN60BwQ14nJMaNZGuz9KG6f-3OenPTBdusLQ8Vt9VeFjQDYSZdaYd0w0OVVnJf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdektddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetueevhffhudefvdegieeuieelgedthf
    egfedtueevjeejtdfgjeehudejuedtudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:2N9WZiIe_c0_oVsqqClnYFwZG2s4-GwoWHHWWyR50VX3hMD9oi4oTQ>
    <xmx:2N9WZtIkdJ02uyk1QNU8K3LrFdX2OhvQAGZPfNUg5FnvVEElOEd21g>
    <xmx:2N9WZrz1BvKk2cebMb1MzFC73_lYWxXGoU2sdXLKbh0iVPXyaG3WWA>
    <xmx:2N9WZpIaq1EqkwDx2adpyI6jn25SNLDPJMiCQ5GiopST8-XYhuQ4tA>
    <xmx:2N9WZkU6_OujexIDcQEA1-M501BA2hEu-0Zm13iuH216rXy3Y1FF2BoS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 03:57:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 75782b8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 07:56:56 +0000 (UTC)
Date: Wed, 29 May 2024 09:57:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] difftool: add env vars directly in run_file_diff()
Message-ID: <Zlbf1IY4jFlUPD7e@tanuki>
References: <c7c843b9-0ccf-4bcb-a036-d794729a99d6@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gDDEH14BGtODtFu7"
Content-Disposition: inline
In-Reply-To: <c7c843b9-0ccf-4bcb-a036-d794729a99d6@web.de>


--gDDEH14BGtODtFu7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2024 at 10:16:50PM +0200, Ren=C3=A9 Scharfe wrote:
> Add the environment variables of the child process directly using
> strvec_push() instead of building an array out of them and then adding
> that using strvec_pushv().  The new code is shorter and avoids magic
> array index values and fragile array padding.
>=20
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>

I don't know whether this may cause more allocations. But even if it
did, it would very much feel like a micro-optimization that is not worth
it in the end given that we're about to spawn a new process anyway,
which is way more expensive.

So favoring readability/maintainability very much feels like the right
thing to do here, and the result looks good to me. Thanks!

Patrick

--gDDEH14BGtODtFu7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZW39MACgkQVbJhu7ck
PpR4yxAApv+ItucMk0W7Be4ydQHvjzCTMvADJnr5wH9otvnHzARBs4qTg8CkyL1h
D3KhtcDncX8YE2TtEn3uslaAVWJ77uTv6kKLyaPZGUtP8ifHmmDoUaUnBE8SIyIl
j57eDto44XpAe047t8Yjm3rEpU3jD8xo7XJGzRZYVb/u83oveQ8RR2dX0OFvnRsS
O9XrW6ULskshOYrh4U0gtVGxwbKC+s2v9KsGQxMnVM+S9KCfMbusQY1I0ciJqa2B
mzjqnJpBAluZSnLGdoPdL08/GrCgQEa4BuXuyXAUgB6AqVrwDMlJKnAE/hBZg/3u
fCjVztOCLxSM6t6pM/hEHu5ARlqLcnAWSrmB6TrD3ooz+3TQvGK9YIeWPAvYBvVG
JK80EweRvXfga3djTRYipSL/UJNLECOxdkGScHvRxd0lajFGxolIvu3+i2e31og9
8trePdAnDU0UFxTn8h3kmMHRFx63jQv+5RJeA+zXW7fE0yEXT3lS5BQMFWaLaXo5
pd/0L+an3PQFnIDoivGaYKOIibqoUOgFtzdI10G3T5aSaJsW64+DVACmWoxQWDxd
uw12+znxcGyzt9Hh1a0Om/GMeW4Ipa2TlP6+5DoPH/saH68IkvMevaBODY5TfZx7
MQWQnkVhEGQ+qQFpBcGEPyNr2Rj9MuHBoyJ0HTmnmd4hCodYdfM=
=T1l+
-----END PGP SIGNATURE-----

--gDDEH14BGtODtFu7--
