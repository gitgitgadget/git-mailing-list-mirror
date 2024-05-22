Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D372233A
	for <git@vger.kernel.org>; Wed, 22 May 2024 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362619; cv=none; b=eCfBvvSiL2/0XlHD2NXoLJ1kq+SuedmDzDF/ei6JurOCQXa+8v6wfGAr5eyPqlo/brc2xfidGHdM/U+wpIW2pOrDRjIbLOVLw2tZJhjYuIQ6RHHpu2ckGOmqbQ9lROkXGJ0xNZMW7+2vQ9kvNZgerr3RYkn4uhvtvY0NWvaMOcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362619; c=relaxed/simple;
	bh=IXS0DzhFl9ZToMaORp/A+LD45fJe1aHp94Y5C/d5ins=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaZNrYQ3yWt947vaGsXxyspibsBDFz9rtAF31FngQglnrb64FKYKFKywEaWZ9T1NCXBLGZ0pRLig2hST+m4hjBFHV1e+fIBlzB/tQLSzGK6WzdVc9DFLS9ph5jplKeFU/OM/WSJ9Z8TRKsQVbJZZN9Ps1AR8si6y/dTN/EgpCqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K/iyM19p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CFjnfyy2; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K/iyM19p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CFjnfyy2"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6EA9B1140085;
	Wed, 22 May 2024 03:23:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 22 May 2024 03:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716362617; x=1716449017; bh=IXS0DzhFl9
	ZToMaORp/A+LD45fJe1aHp94Y5C/d5ins=; b=K/iyM19pbSYH4KhBwlqE2KDntQ
	U3pg4asqdgXEL0Sbj1dysWU86DrowKISFCxNQ89NPfH7F+MJFcCp3WZ269/yULEu
	okZP8vk5QlfGS1qxhTgHJd2RdngjPHHkacl+XnZsIMr+T8lGoG1Juo7JQXmJLMA5
	PvHVR+SG3VtH03nl6XenkJJ7UE5AEweeXIdpBkLHGo2EjRtraYhj3/DSvBai78D7
	vPROJKhLbsJBxkd8zhprDmL/fC1ZewkpdyKvTj7I84okHqU6rrh+YaCaL6FUpYIP
	tEGYiZFJ2OUu12BPuA3zOGcD5xjc0rIefOd1hjdUZNlcQ9jct2D1yStfYi4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716362617; x=1716449017; bh=IXS0DzhFl9ZToMaORp/A+LD45fJe
	1aHp94Y5C/d5ins=; b=CFjnfyy2UyZkfxNTbVlWOoSe4A5X2OjUcysHVUGZLmxP
	0uNYTetBTdApQAXNBBrvw29P2myw+CRolxBEbToAk5SeCruKzD1EbSQZi9lA14gH
	6kkYbYEd473b9neFbqIxwsLsBj6VQBmnt+LwZLCX0cNsAYcY3P0uWmOU5bmST+DU
	DXZ6HEcCDi73XL9AgztWKWj7aRvMvQzBxBurDXqBTkD6b1BYZouaAKKTGEqalMuZ
	DTnMhtF43gbvMbCAAM7gk3s74TWW4ggegWEKfcCOhP+DKvaplIrAHVipTGcLU7hB
	eTXcsdXYwEdJK64J/gbqIdznj3GLpIWjM2BkDWHieg==
X-ME-Sender: <xms:eZ1NZii2o9ybizRxBG7GMa8tN9xe7hSf7ew7GMtAI3lOTEQ9lwrX9A>
    <xme:eZ1NZjCbMuySb_WdGb3VFwOa59YTlYHlawHa9SPsYakEfQAURpQiNM25suXI1yPbN
    V_Bx9a8Dq1fUL6o8w>
X-ME-Received: <xmr:eZ1NZqGLmbA0k_KaoTycdmduT7hVtzC35YuFxx8oTIjZ9VM7VIXU6xib6yFTV10M3Jxee7XDeY-igVTDiAeMb-f9vVvb5fB5jByPfYP2KQsB6vPc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeifedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:eZ1NZrSFIsA89jiRRKK1a75g9KQPNGfyLzKRC97tEnOhOGpo1NkgWQ>
    <xmx:eZ1NZvxpBmkiCbnEg6tJkNG1pyjruSvVG5AZRVJL_TZSzG26dqvY5A>
    <xmx:eZ1NZp4kKjjLn4oHNwJI7BM9TyS6xRd-Engu0G92Bd7kjP68y-7Cjg>
    <xmx:eZ1NZswcHf-2BD71HpRA5Lrs8r3ASEZ4Ozn5jRFpztly361AEy8P8A>
    <xmx:eZ1NZhv5ECrA1tWeKkCZ2TydqLQUwNT376Qg8d9H2XdgQ8ncLtDYmH_L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 03:23:36 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b6f4e43a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 May 2024 07:23:31 +0000 (UTC)
Date: Wed, 22 May 2024 09:23:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 01/13] reftable/block: use `size_t` to track restart
 point index
Message-ID: <Zk2ddTsVLXbjDmmh@tanuki>
References: <cover.1715166175.git.ps@pks.im>
 <cover.1715589670.git.ps@pks.im>
 <ca86a8b58dd074287dd2dd352610ffe46e1605b9.1715589670.git.ps@pks.im>
 <CAOLa=ZQb3if7vcvRcOm8qHSMGo=dSv0nsjCk0R_hhRWU_d7wfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lXvKOxEKR6XtUl68"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQb3if7vcvRcOm8qHSMGo=dSv0nsjCk0R_hhRWU_d7wfw@mail.gmail.com>


--lXvKOxEKR6XtUl68
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 01:34:48PM +0000, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > The function `block_reader_restart_offset()` gets the offset of the
> > `i`th restart point. `i` is a signed integer though, which is certainly
> > not the correct type to track indices like this. Furthermore, both
> > callers end up passing a `size_t`.
> >
> > Refactor the code to use a `size_t` instead.
>=20
> More of a question for my understanding: Why use `size_t` vs `uint16_t`
> here? I'm asking since the restart count is defined as `uint16_t
> restart_count` in `struct block_reader`.

Mostly because all callers already use `size_t`, and it's customary to
use them when talking about indices. We could use `uint16_t`, too, but
it didn't really feel worth it to adjust all callers.

Patrick

--lXvKOxEKR6XtUl68
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZNnXQACgkQVbJhu7ck
PpTFgQ/9EiWl/RXlSXMvDKj+NYfNsv1j0ZpEzK3xuhNY9dd+SmZHl5vnsAULRZfD
npuVJBpteCBK/MVo5hjDNX0QUktm/JAVSsM4e8+QIi6pxgvg6E/N339qETZNxNgW
1SavNRXpnkZBTLfW4WRgbJg8vkI2uEeMX9vIZpaIHjEKl1r1Oe05gJyictVxCtmR
WNehJQ/1z3ircgMZEtjI+BJhyIBidb1MQys+ERZ69HmVBaAH9o61LfyZ+v1fCnTi
DOWcYWxROKAYwTNwlwhFoy8e/91pfD7Hzstp4xo53GqPmTJMIB2fPxI1yoB6LT8d
LtW74zIj0UGAn8rl+cEtpvHWVbU3YakTWIUOE0BigAU59wyWu8he+7keflBHusQC
YUYk+/PHuOaOpOxS2D19pxxNeEwaNChPAQnmfihA45t6A3yY3bY3bBjCM7jiI+em
/Zb+UhFdtIjIJ1adnbOoxkIdpi0aV1klUMJd9bM71jFMvF8lQvLT38t/QI5mPBMn
xvftWk7EblmQ9NccnUniiGvdZumaUnB203nb/ouVCfkCKHm0HdgS7nGZeD16y7kr
YbV+mG7uG2VkSeqL8LuDUWnwC4lEwdhFU3ix9t0QBPiWL/iMcKGNSWdWvbdNAX21
PL/fb4kYjUUxZC48n1gqMbMIHyzKrhvoIFKPaia4rwZK52rALwQ=
=FySc
-----END PGP SIGNATURE-----

--lXvKOxEKR6XtUl68--
