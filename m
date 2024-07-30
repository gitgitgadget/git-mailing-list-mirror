Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337113B780
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 04:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722314958; cv=none; b=pYko512lV2778aRtwyPXPnDiNgI643TqBqq13q8AE2vnrChBO2OMIgIYrj9tIfibhYvsLvP27QZ/JqqNRP2PRqMNz466rftLDYJI5sAequG+QbywFcOB1eX7BVzuVOynr6ItV79GIKIty40Su47938VBKmdQ4f01PlD01+0GA94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722314958; c=relaxed/simple;
	bh=SCUMNPbhKxVWQd38WC9VShGG6uPcISNEAkYv8Nq28vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9l7xO929u0DnEvjYXzYS+sRcC+xktoM9Bx5xLHlWMOo9l2Ce+bEEZlKbX+pX34KHtBRCVlsatjNqrEX8C0HWuDhsmWcX/ScmC7TV769cQRbFA5vhbaBoyOrKUMRRCBoDkC9Sl0JtRd34Gz2JmidC2bSo+fbYKn913rN8bjlTZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jvLKBcIF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KjU/lhuz; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jvLKBcIF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KjU/lhuz"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F2C811140590;
	Tue, 30 Jul 2024 00:49:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 Jul 2024 00:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722314953; x=1722401353; bh=FIJAM3XBNP
	DfNzwyK7Wlx3MtZnDkGm44FW79hLB4iUE=; b=jvLKBcIF9ktFjthS889jb/CitF
	p0bSN2a28OhmypWrS3XBuseLHvpBh+icnRnKDzJV3hERysHBfQhtv1pcy+xrwGFy
	USwH57u3ft9AXv5aBCxr6/6lYtTpu46836ac8J3n8ML/94Qz55JxMebxe+iy4iGu
	IhZJkrge8vH5PRsR8vvBW7Koyy1Gv1TNMBhYdoPOx2f07gieMPMgUXyOJKtH0OIP
	i7qcH9a4iiQ35v7Y0/AdX495RhEVNNiX1T906iaou3ZiF5Q0L6Xq57MbFkNi5Mn/
	qCSDMC380o6WZfT2hLb0Pb1QOI6M/e9pBCPR5TtjbYBu/EDCHMYYZZex+ZOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722314953; x=1722401353; bh=FIJAM3XBNPDfNzwyK7Wlx3MtZnDk
	Gm44FW79hLB4iUE=; b=KjU/lhuzqw5Q64Olk+jrHiaRNjAsvihYVbamtoteQXIM
	vUmJ8C/tq/MVKQNkv5OPlGlpPXXqFlI8wa3nBrtmZxlZfHuxSEv6VknK0eIgQ9E9
	2hccA6VIeWs2mkWoHn5qW2sKkHyEAnrOGnabaV1Qmk+/YPEFkxeYXNAG7ggvnQYd
	8sx18SSLnTjWbiwmi4xyteypwJYWyao46lXUKAcrzWNIR1lPS0sqg8vZEj9BS5hF
	lopLZBNwTA+njzK6TYppcrjLeAOKJR4eSOVQ0U3Y5V+3WqRrSh0MWjMOAFWqdRUX
	jOtM9+6b2bRtKA0mAuEkZLKbalX6lssbyqIpOTJHtQ==
X-ME-Sender: <xms:yHCoZi5YjU1paj0gaX2upPmIB36gV-vrjRVuqrG5iD-YsWtAbALY9Q>
    <xme:yHCoZr77xXg6QOtZN_3wtnr1olLUN8a4nvaZVYvr1X8vtDmrci3jurID8OUogbv6c
    8cDunkiC65oilU3lw>
X-ME-Received: <xmr:yHCoZhc8ARs6SqPvW5xbvhfh5xYxMmYaRE3JMwjNlJ2KJ-6oQaIc3BaFXzz0F77LOooaAxuaBQQzRZ7_U2kiNaNQ8J1pEAlOccFtuLkhfLdiKxM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:yXCoZvKrmje4xbSxRTqwMfe_z7rmJCCXrvyy1ajqlhzFHIqzjiSWvQ>
    <xmx:yXCoZmJmsj4rg52rLrS4QTiE21MqPZ5drh19my1EgQLVFvgf9NSt2Q>
    <xmx:yXCoZgxAMNmd3XAyqjxna8OrSDQIXwZ2re9Y1YHtLZJ6Ro96Ct3bAg>
    <xmx:yXCoZqKew7haN-YvppWU6PBmwU1DovldcdN0GLrJwB1qE08NxnQwMw>
    <xmx:yXCoZu8k2av_2aonN0hwTISJxP9HcOgK4poMelNLjZhzUot8Uds_AE-6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 00:49:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 98d00620 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 04:47:41 +0000 (UTC)
Date: Tue, 30 Jul 2024 06:49:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kyle Lippincott <spectral@google.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 3/7] unit-tests: add for_test
Message-ID: <Zqhwwudf-yjvJ_By@tanuki>
References: <73465c3d-1be0-456b-9471-f875e819c566@web.de>
 <c51025cc-26e5-41e2-be56-94e141a64f5d@web.de>
 <CAO_smVi2rJd5SDMsbbxzFUj28a_1KTgdHMz4DTKMsii+Wt5H_Q@mail.gmail.com>
 <xmqqfrrxjw8f.fsf@gitster.g>
 <CAO_smVhq=MkQV3a6qJtDiFykvR4im7AX4hMfKMNcL5SegnOSLA@mail.gmail.com>
 <xmqqv80szxgw.fsf@gitster.g>
 <ZqOc9vxdD4qttkFs@tanuki>
 <xmqqed7gxhyz.fsf@gitster.g>
 <ZqdldZE2MV-Pkuu-@tanuki>
 <xmqq8qxkhvt3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CaEeEf/xvMzcv1UK"
Content-Disposition: inline
In-Reply-To: <xmqq8qxkhvt3.fsf@gitster.g>


--CaEeEf/xvMzcv1UK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 11:55:52AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > is standalone nowadays and called "clar" [1]. The biggest downside of it
> > is that it depends on Python to auto-generate the test "main" function,
> > which is not really a good fit for the Git project.
>=20
> Is that because Python is optional (like, we only use it for
> optional Perforce thing and import-zip in contrib), or are there
> other concerns?
>=20
> Unlike these components, unit tests are not even for the end-user
> consumers, so if it is Python that you find it a blocker, I do not
> see a reason to reject it.  The thing looked like a simple script
> that does not use any tricky language construct or modules.

No concerns other than adding another mandatory dependency for devs. We
already depend on Perl and Shell, so adding Python to the stack feels
suboptimal to me.

As you say though, the script isn't all that involved. So it would also
be possible to port it to Perl if we want to do that, I guess.

Patrick

--CaEeEf/xvMzcv1UK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaocL0ACgkQVbJhu7ck
PpTVZw/9F4m6d3wWNEQGijXU9L+5Km2wpQtHJYIuaNOTQr2NWbB6tEQ0kXjnd3cQ
DqfTKN/ocAXAd4mXfMh7UAEobF9zle40QjpqWiXY1qWBf3WDcJxePhtF5O0OtfWK
njHB1XOy+ZbSksvxxUKBie9ikL5RYAz5rOmu6i6oBnQenyVrd8QnEYNyb7/b151G
6obC7KFt2RjcpDaqdGiyPbZ2bV+/+Plzjv2sY+pu/03APAW+ublEYoZCP7TtE26X
Alg+z7X/5YdknoYlaqDam0Ds2eLSEcRwdgicasPvirtR/1+xmlLrVzkiR5/Z0nGI
5ZH3t2MS5fR30dTTe3nEXruTQvQH4UodPKXI7Sdk+srm6iNHi9QO43mcS31/Oh/Z
UDnrAGkh7+3QZh0m/Td7OQ4+uYu5/6jBopQeCurWott9VdKv1IYFpNcKEkKjgje9
Oqb2CW9dTvmRrlVWwpfIxLFQMVA7u9OA8H8ZVfshdZBguNUDCNtK0AHnMLsG3a0Q
4QrwRFXbwXOBM89wH/6KTfrtYIFt8iDSEaSDgpnOvsW49a94zIYs/i1bka6f3NOm
FcwA0Opw41kCPeroV0tud/2puiGkIzpVaARuWUGdFBqO1ownjxDXXWYjEp+dSKN6
2gzNSPN7ErtQYoKuzh1Qcu2QhU3xJuE63QFQBUDeEsoFvGVtpJA=
=pGU5
-----END PGP SIGNATURE-----

--CaEeEf/xvMzcv1UK--
