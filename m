Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71C51741F0
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357851; cv=none; b=mOhYhhUp42MwRElTjSvF6jRbKQHu6o4aBateuIls5XE4QhSrSSx/+XvG/2gW8aB9MZ6kTcUMeQRvJzDkFaR1ksmlPaZ5b6pnezpMQG0l+kZ4LCGT3u3oiSDtgXDLtjVg1eXi1hSScqezV2FUsCkBTBtN0mWcKG/CBbKSAvzbjlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357851; c=relaxed/simple;
	bh=r5H3FFCjBzefsvY55SC0e+1sUMKb9dlBNjSHO5iIOEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZ6jVWVSNPRlJnx/EeJ6An+HVECJXhExoBbleRmMerrZoptUjDGGWfWSuqiehQsuBd2JuqZY2HVjmGilv8mErlHqQzD+migg4rbmRG++LNglb7ya9cSCeFrGYys80IrvurBAGW1na6NkQwgbteN5V18ZwpHzqEvtKJaL6dvj6lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gw7cerGE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AumFwmMZ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gw7cerGE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AumFwmMZ"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id A246D1380117;
	Mon, 25 Mar 2024 05:10:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 25 Mar 2024 05:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711357848; x=1711444248; bh=r5H3FFCjBz
	efsvY55SC0e+1sUMKb9dlBNjSHO5iIOEE=; b=gw7cerGEUOSkNBnk4g4eYnUGYx
	rvKAs0f7k5NWH1jf/waI3+3P7go3KGlDbMQUoAa1MnMqIjswk6go6Jhi/b8Lev95
	0sxqkP8N8s1VFAM/GVLfu9fq14KL2EG4CATfY2rZ9SGa0Y0rHRqUMUvzUjo13L6a
	aFF5Ma3F5YYEHaFW8u1NyhKLgd72OkPjMac3wWjhb7oVZZPtKklnef6lSt5ICNCK
	UJ5QGv12RPL0SXTnRRilIouvgFWNWaMGYzbmnt3jtyINFnX1tsMBZy/8ZWAh3Hgd
	ML5rGeICtuYZo00bBKRSmqfuD14oQIT0ONO5XniX33I/zZACvy0lZuwzbHog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711357848; x=1711444248; bh=r5H3FFCjBzefsvY55SC0e+1sUMKb
	9dlBNjSHO5iIOEE=; b=AumFwmMZ0/kuRnv8LSL+QbITlWokdvaVDqZei1RE19Ou
	o3idaE9pw2BslgVfyXbLSUrmE4XPTrp3K7Pw/MFzxySiDg+cvMMFEHxt7iDpGSQM
	MdOkO/QP3V5fT9EAy7/L02Sc0CgcvugaWwliNJYFPBAKO7BQKviqzv/WgwLW/mmB
	x9v/qT5w/JQuAsj7G9inq6cUNtOuvi0Ar/O0tBN3nVxWvn5xQWc2tscerRvGzFOA
	PmSAzbaPH+91C6kPfLS5AeW3QI9fU9xhyljLQMN52O5WomaMMZcftiMv1kWr8Wya
	77+kpYXXrzNjft2W6S0z0Ejj7/Gm6F4fwPOJ+Z/YiA==
X-ME-Sender: <xms:mD8BZuiohK7NDHs3MZHkwOzHHA7TChA86uFnuIMVsWsIftt4IFRFaA>
    <xme:mD8BZvB2EqwWwjJ1Q9zCon6Hoc4UY9JbJqeoa6ZZ0Niu0ULp9GL6ZvSowlfGaz0Z1
    qDSMiTYXoXQE6mqpQ>
X-ME-Received: <xmr:mD8BZmGcWJeFv-emGHvRK78VQ-jYY8XGE5EWygj0211QvqAXgB7vdEP-zPeNbzpAkS51y6IC3HN8tqJqPpaoTPff9eoU4PWQSpulYPDLXdw4gA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtlecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteenucev
    lhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:mD8BZnQniZmBtwIizH8gHfCdj4Ft8lHuVc6FqrVCQA9kN0MQmR39XA>
    <xmx:mD8BZrzIC8zJ95TrdxUZ8H-fLCm83ht03pSwXc3bjmtEB9NdO89Pjg>
    <xmx:mD8BZl78kw1Pnw-73RgiHj_mhka4q2hGqxyFcjL1SJucTjzuKzWaLg>
    <xmx:mD8BZox5BFqKh-F_8XJziN6q9ceq4GBkYuC76Q91e84SVuYNjnOykg>
    <xmx:mD8BZtstPzyKgmQFYAGuMReNvhOvIn-eGYU-FfzeHlDH02Ck-HylDQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 05:10:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 99e4ca39 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 09:10:38 +0000 (UTC)
Date: Mon, 25 Mar 2024 10:10:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 10/15] builtin/pack-refs: release allocated memory
Message-ID: <ZgE_lSXhGlHNiaCM@tanuki>
References: <cover.1710706118.git.ps@pks.im>
 <ff163a621d3b55924882cea1d1c51c074ce2cae9.1710706118.git.ps@pks.im>
 <CAOLa=ZQbkW1_X3oaipbTNMTy3z5jvbFoFp4W9wPSh8gHSAFYzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2/R5KDyoclGOpjFv"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQbkW1_X3oaipbTNMTy3z5jvbFoFp4W9wPSh8gHSAFYzg@mail.gmail.com>


--2/R5KDyoclGOpjFv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 04:23:54PM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Some of the command line options in `cmd_pack_refs()` require us to
> > allocate memory. This memory is never released and thus leaking, but we
> > paper over this leak by declaring the respective variables as `static`
> > function-level variables, which is somewhat awkward.
> >
> > Refactor the code to release the allocated memory and drop the `static`
> > declaration. While at it, remove the useless `flags` variable.
> >
>=20
> Tangent: I was looking at `files_pack_refs` and it seems like there are
> a bunch of `die(...)` calls there. I wonder if it would be nicer to use
> `error()` instead so we could do a better job at cleanup.

I agree that this would be a nice refactoring.

Patrick

--2/R5KDyoclGOpjFv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBP5QACgkQVbJhu7ck
PpQ24Q//S4SpbaPpTg4ZIkPUWATSbZlcmeM++p9Iz++qt4HSbfJ0HK/R8lwhcsxp
nmOVR+FZDENTHT9M/XiV2cTLUhZKy27tE8Ug+HhxOpRY8k6tZnMRixhds/B843PC
iwpp7LxegJdlzv5dV2FeR2Zu0PHiAxJYgOmMKgwdCeQCG4GGanbbreArazpoW0/k
z79IDcoOeQFV4BVAJgQOupEoIgDeawOqqmGmFDquBsPGa/1XbKIh0VA6NrAvG+SF
jmfqEQXbHZoPsTCuhgRVTXmr5nxKYidz5Qj6wwvfDuiHKGr5SIh0o/fVh05H+RgM
9eu1cISnhWNxp6IbMAP/oDt3fs0G15FNzl+ICDoMKl9sbtxGfLa/NCrixyQStVBZ
k4vWkaMIWERGZMT/bVX3wFQ17KrvqlCtVPTBsW8EZffRwQSaru4OxOl/OZA1qYx3
NcjQb8UqOYlNosfi8sN64PxInMgSiFhT2UQ7FGY7mlEAJ3kHjWnObrpYLUVtcxkU
Wx7dHw+Va2AgrfvD+u/K6EcwHouVaUDznH15qeSCj2+Vk+x3BTWzG+FVZozvHl7I
5FguQ+DuQM7Z9Pv+Wix/NvszMEChUaGE2E7uVER7nFeqknj+D5XvZWLJVGl1QwCQ
CvNaOHreqqd4X54QJNJNDBa+t5kOJ+zitHle3izP0HqURdev6JM=
=0Dml
-----END PGP SIGNATURE-----

--2/R5KDyoclGOpjFv--
