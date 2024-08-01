Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8950613E02D
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512736; cv=none; b=c3e2IxrCBpczokaoJdO9+sLvzLouwwQl4q0BJTW/UytpfWbwxt1FNT/vqtWG4yomoQ5z1njpGCVXKhwLKhNPyV+OITYTpN6CnJlZfsiuiThPexdHCXKp5JEoCwujOq2NDkV9uP9hPrU0UHOBXaRtXk4l5uBf0tGHaZnGCyCFWlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512736; c=relaxed/simple;
	bh=Ja/l1l9HN9V+56XTgnW6Ciy6u9V1y5l+1MWunPLawEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/QjUYLsHWV0k0Gc8hrIcba10JmOyxns6Z3War4HP/oeRnyGbVNajlxoi//IwRzWgLvCj2yO36yA6VvjUmSTyDhLB9YsM3282bnBJ7Z3RKqu8Ys6TSFh+gf0Qm4JQgpTmXVJhe/okVgUF80jkrS8Fx4GU5kwoOXThkDFR3EjYLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZMtaE/89; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ukwSuAqe; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZMtaE/89";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ukwSuAqe"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9489F11483F1;
	Thu,  1 Aug 2024 07:45:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 01 Aug 2024 07:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722512733; x=1722599133; bh=Ja/l1l9HN9
	V+56XTgnW6Ciy6u9V1y5l+1MWunPLawEo=; b=ZMtaE/894M7DKteVF4EOooa0NI
	poljI6IeJtMK2vs0o00WCQBTEGvYJ0nnSAZbb0JhY/6XO+K3ulHt2IxvLU2LwoTY
	wG2T747va8Qk5LaGorSJfBm5Yfpw0PvmhhZzUf/iIivllqF0vsvKvb30ssR5sHOc
	dhUyw5QY2TXAFCiJTae/oBZM6zgn6Jih5adXa9EhJkxpJiLPdBGm7dUXYYyyJtaI
	HqWBcTPUXe/dpGGh9EPeMJSavW1G4CI1sgLP/gSnfbImkkmqFLpb8Hz73mgatF/7
	34UAE+TJna26BLIbkKndUFaGKBAVX//1VuMlQCiQ6HdqPZHfhPn6IKWSavYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722512733; x=1722599133; bh=Ja/l1l9HN9V+56XTgnW6Ciy6u9V1
	y5l+1MWunPLawEo=; b=ukwSuAqe7dyhkJxqfDayIxl71WPOxgv2l1q/qXDTyiqp
	2er+vI9InPi7cwoTmt2tfnjyxX0879nTlS9Cfh6sWJUSzgMKRGSFJM1Lscva/vcy
	oTiuHO6daBpbxicUMiy5mhXb5bdgFgpRBt+nBwGc2C9nuvYTZlPT26HmAmvlGVXp
	U3g2ofrfb/yNo+nmRPyXW2q4ytQvBakxl2OfLu9/Y0QNW9qRgLZPvW+SXFV/9oQH
	CCGjklquOKSLPawRV3hrz0olJcnomA9QNZtJvSKkJZ8uf1rm8ZLOcHcg0i599V+m
	3trrJg/yl3GQmGAg7tRK6txUIXZxPWZMYJVxT3V9RQ==
X-ME-Sender: <xms:XXWrZuYFCpYlIUhlq5o6cSZC3XIsY_ZfntyKHTsFpFhqAXX6Pl_tWA>
    <xme:XXWrZhZDjw_FaufXgJOEkFKWVvmLRWHkkQL_LBvBaqc3a4K-Q-G9HAOHsC9Y7FNyj
    7CUXJZAyVxfTjIzdg>
X-ME-Received: <xmr:XXWrZo-s7Tni94FIfi-Zc7VqbHJjoDRWM6mBIS9u8AsapyLwzr1ux4RapkJt34FMUki15wd2Z0iCVqN9w6C-ds922PcKmtbfxrYa8XlV6sFWDOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:XXWrZgpf8o1FEDRv4N4E3sD44jfDk2v5MUQTMIYqVZOLxwb3t9Sfqg>
    <xmx:XXWrZpo3EbdaP_aZHZqgArrc9EJTlofLjGQqHnW7JCRYD5UbvaCE-g>
    <xmx:XXWrZuSkJ7kyY_YoD28_EuWDuW169R98WiPk7INH0K2K8GRaNedVFQ>
    <xmx:XXWrZpqe06Cb2B5dR6Y5r-_NgGCLBi8nwiX3pyV0INibkxDN-RlBcA>
    <xmx:XXWrZqmm_BHNFI5v0g9KIbeQrOxpuDcUCCLwsafLYodET_3aB9Gbyy-v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 07:45:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id eb016fd5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 11:44:00 +0000 (UTC)
Date: Thu, 1 Aug 2024 13:45:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, karthik188@gmail.com, chriscool@tuxfamily.org
Subject: Re: [GSoC][PATCH v5 0/5] t: port reftable/tree_test.c to the unit
 testing framework
Message-ID: <Zqt1WTT_eJKEuO1z@tanuki>
References: <20240716075641.4264-1-chandrapratap3519@gmail.com>
 <20240722061836.4176-1-chandrapratap3519@gmail.com>
 <CA+J6zkT55DVh28w2Pb=PVs3cBAeoQw4eYc2QbD7Bn0BvPjjH1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9edD4ukHSAaKY25w"
Content-Disposition: inline
In-Reply-To: <CA+J6zkT55DVh28w2Pb=PVs3cBAeoQw4eYc2QbD7Bn0BvPjjH1Q@mail.gmail.com>


--9edD4ukHSAaKY25w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2024 at 04:51:44PM +0530, Chandra Pratap wrote:
> A reminder for reviews/acks.

There was one style nit from Junio already that you should probably
address. Other than that I didn't really have anything else to add to
this series.

Patrick

--9edD4ukHSAaKY25w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmardVgACgkQVbJhu7ck
PpSUhQ/+PmheuKOnZkVefycYqOmKPj27S0Zw7NBwFQrcvYqtVcJY0q8J7Dyby0fy
NbMXs5Bh63RBZis+AfG5HtPShSVcvUQrgg+Abhuka2ugUdEjDOgpa7uuJe1U1CY0
YL43Ra6LFTKnc8IY3oHUq7zwQkUeJesoIsQmvTy05w+r3R9l3BwUwqluY0ZuYZOg
dqStQxf6TtVoj+rbdDmZKJqFkc4tfq4L6Acy4EhU4DWqCqdKmxbYohLyfJvMlt2R
yTf+BmM3y5+V0AzuFydCTG2BuFCLJzmtNc+X4occrBiXNAEvhLA3IeudCSBFRQjy
IN2UEh2MIwWflsoYIpGwOBQWXZV8C23o+2xPqhWj/qXtjbnPKIjFBNoy9HBjtDvB
YNwpxcZQlanDA05WI+96sPYPrlI1TYzs6e5hirM7pPyW29cVHNiL1lLmVOAO1a1Z
RvjxQmT0KQsvWHh5BunUjxIh2slvvG4EI1VLOhIq5UjV4qC5NbPjWdtSiVt4h2I9
FLrzr6663YB6/FWSTE2blMAc3srtiGPaeUtfl/7H9WGjnPEE7RTbdsKg+e9lAFz9
KUWavgmM1NvuSmJJ9uiAOkJFJQCP2p+Oeox13dxHxLqaWThTbNNiUjoQE5stzyjG
kR9/sWgg3ukXuziex7b7uur2FfKUM7b9Lp8HDKVRK6//Zbf92cU=
=EWr8
-----END PGP SIGNATURE-----

--9edD4ukHSAaKY25w--
