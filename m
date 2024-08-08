Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF82F50
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 05:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723093511; cv=none; b=Y9iVPAhU1NWlUlRwcLJ/rbd96lOy47rAyTWD0Z0hUFPs+Klzn0V1tTLu0fntBw/Pf1LtZ9SMuK+tDr+o1qAQLzATl/yjiMulRZPMDUt31D3iN+RX95uyAAPhh3ZEu1rC07wztU0VO5gfKPFYbBtoN6Ox3QfN72DCEz/SMsO8gK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723093511; c=relaxed/simple;
	bh=DFhmP/xzZY/U0SOjG1tt9Q6uiS8JM7DONo8Q4KOt0nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Flxx5SolZiFfvqQqHbiR17Q0GcSC4wIRO5sBgZOWV2YoN3JMyjEZeT+C8zZdiD24HSuKEvNRATs/w9h622CeOIUvyoKI0qXs5iyikPuasfh25X9p0GaQ7XTBynacQDuizfLmTNa67zo3M75IzkRXspsqdwMUXCvu7MhokGWhnXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QlN8V35L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sdjnvzzV; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QlN8V35L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sdjnvzzV"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 88E261151C47;
	Thu,  8 Aug 2024 01:05:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 08 Aug 2024 01:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723093509; x=1723179909; bh=DFhmP/xzZY
	/U0SOjG1tt9Q6uiS8JM7DONo8Q4KOt0nA=; b=QlN8V35LrJ7Sxa5k1amNx2m9Cj
	j1NjEYQnFV2kLMZBmpwdwK+1QHSMEr5N7Pd+GxFk/lnFIjNzYnluAuwdeht81LdU
	XQ6Mt07D9IyGVKUC9HCsSPeiWIHj8avRaQiYNggDmm2pDedz1dVY34EsS9/PRvQq
	KdhKA/OACgtn2vHNzpePYo7PU/WjlRuUTLvkiQTkYaKNM6TYM9jrzeDZHl+NeLsV
	L/nTVa4M8g1vblEEhhpwhPDuVrjSvxXj8uA0Bx6ZkwQi0rqZkhKJ2xE3VQFrw+Lz
	2TdA5jKgt+NYoaJD4Zu8Bolhy7hxtmXjOfw9zLisl7sfJN0tbPIRiG8oNwqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723093509; x=1723179909; bh=DFhmP/xzZY/U0SOjG1tt9Q6uiS8J
	M7DONo8Q4KOt0nA=; b=sdjnvzzVbhlWpwonJGhd0HT/smQyOZpGmMlT7E7gBmf/
	eUxzaC6x/ZXxgkpqmYkZjM+bUUhjVuXjZ9t8oXBuoU1+sAf7Isqjcpp1406G09uU
	9wLsK/NOxmrxLbmCMRJN2AcWzs+xwmerNsX5TIfdu4l+d+wibBnR/fzAAymAIeNr
	v3EB7zGT/nR10pT65RBOyyjyDzq1wjYU2ASAoBnb1hWT2g40c5NC9vP8aFwnuuwJ
	uBmjMyEYG5/5z5cn5cClTZV0CR5UCWcFxTjX9A6j/+cw0ql+vUqMTfFiWS8bmA3D
	L/odlCzpZEMpeBqfvuf7Q/uZ4VikZJGDDTVMq0wqFg==
X-ME-Sender: <xms:BVK0Znhvo6nY0mP4NQfvi6JXUbdGmBY9cQrGY551DOIRu70lfCwhXA>
    <xme:BVK0ZkBiUiv3yA-fuU-qfTLo6x35_rVYVNXzdSJgwliTkeVh4Tv56Iv-1LUy9flXM
    tdbxB2djXZf612kFQ>
X-ME-Received: <xmr:BVK0ZnGtuYCozmolnuhzJNwZQpxWMwcrzQiciORaP-PszqbeOGTvb9mC6jeueVjZ7GvJo146aHlkpNbOuqImrVglVRbJsSI-u9nuZs0aomZCMrv6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:BVK0ZkTL8ceE_DVAESTG9PijLuT1fjkgVlm_qZyIJskQ4KTiqgdPdQ>
    <xmx:BVK0ZkxohvX0FsPpWXrSNKolGEiMiUleX8hfAmOuJM3kryD5g_kz1A>
    <xmx:BVK0Zq5M5dokYG_m02F-bMm7YO5oGyhWBz8rSiyO-4Msk5LCSWLINg>
    <xmx:BVK0ZpyLiz1Z3-qvJgvWEpXF6v2Kvn4AqEPr8jlrJPhM9OnMNR9umg>
    <xmx:BVK0Zv-y4SQ3PLqVZshXoEIILXwoFU-SyS8rHpd6SG1t9cppY0763N61>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 01:05:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 69dc56f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 05:05:02 +0000 (UTC)
Date: Thu, 8 Aug 2024 07:05:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 13/22] builtin/fast-export: plug leaking tag names
Message-ID: <ZrRSAgWe-GWe_uaO@tanuki>
References: <cover.1722933642.git.ps@pks.im>
 <64366155dee25209ab9c434016c5918d47d7e1d5.1722933642.git.ps@pks.im>
 <D39JFO40F1FC.2Q22EY440N67N@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZGlygk8RZNs7k/UZ"
Content-Disposition: inline
In-Reply-To: <D39JFO40F1FC.2Q22EY440N67N@jamesliu.io>


--ZGlygk8RZNs7k/UZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 06:31:33PM +1000, James Liu wrote:
> On Tue Aug 6, 2024 at 7:00 PM AEST, Patrick Steinhardt wrote:
> > Refactor the code to make the lists we put those names into duplicate
> > the memory. This allows us to properly free the string as required and
> > thus plugs the memory leak.
> >
> > While this requires us to allocate more data overall, it shouldn't be
> > all that bad given that the number of allocations corresponds with the
> > number of command line parameters, which typically aren't all that many.
>=20
> Ahh so using the `STRING_LIST_INIT_DUP` initialiser means that every
> time we call `string_list_append()` on the list, we retain ownership of
> the string and the list gets its own copy.
>=20
> That means we're able to free our own copy later on.

Yes, exactly. I think that we really should change the naming though.
I've repeatedly seen the pattern that people think initializing the list
wtih `_NODUP` would transfer ownership of inserted strings. It does not
though, it simply assumes that the strings will be kept alive by the
caller.

This is made worse by the fact that we have `strvec_insert_nodup()`,
which _does_ transfer ownership. So we're using two different meanings
for "nodup", so I totally get why people are confused by this interface.

I'll leave that for a separate series though.

Patrick

--ZGlygk8RZNs7k/UZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0UgEACgkQVbJhu7ck
PpQh1Q/9FIedAQNc++0YPqbI+JmKpqsNLPeMBgy8FwOAM9K0FQYuGYUnMUb0ut1a
qPkwr0DXltUuFerbEZ1stSgBVZ8ps1+6HrWG7EEjR2XkDwOC3aenRuuTBPTU+Iw7
U6VjwLLGb+x+q0Bm49OSRKl+0hqahpGtaJ8sPX/WCaxAOzqbAOBJkfs8XNw+US7M
4UkUB5g/QlMOju5XPq3GNRFbvED4mbVUzmXh54JvHuRk5KiGgOowPh+NwwBeJL3j
1D9yTHhjfnUS2OnDMfqAeKEYt1LeZiRU/p/RpyhNeFguQFoHlxFEHPZSnfHulF+R
qA2+6sue7Z6qz2odN5N12S+BjePmWDR8SJ5u6ePinYJtwZfM83oECu1YFG58LkAx
q7gHdL4ySIXCzG//tmAucKaGurm1GXu8SqUcY9mjWs7tTaX/bEBMf5fREZBZZSey
mGTxJAjiTI/zeQ9FybpORtTsq4I7rkIjpBhg7YElqqGL0su9mrokgehi9bMh7EF9
aGE9Dl7UP1vrAfp+y86yoSFWZsh0gI6i5YMNZ7WxR/Wl7DGhQXeM6S5iWk1LMOYE
pATFGfy6vkr25yqEp1qlN/jCHwvF18XwsOWgpGuVKpGtZ20StXtOG/wzaT3CiZqn
9sSLeeHcu83ync4Euiw/x+itXZtBgBd10a0ogr257aDueKEgAf8=
=GCkO
-----END PGP SIGNATURE-----

--ZGlygk8RZNs7k/UZ--
