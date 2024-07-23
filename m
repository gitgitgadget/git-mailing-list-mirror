Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E8413B2AF
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721725333; cv=none; b=oz9bUItfxA84H1zwcdDCwtP7nW35Jg0AXhQX0Yva5GWPbmyksCGc3WhIYUTLVwSuHtdX1hm6rQFIai0Hx7RBJuwwH/+2rU5gBiTDqouQqPECz87/mc4oh52o2yomVuCXOixUegURQIAvPCqUpRUb+1ecGQD4uQP5W9JKOyia/E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721725333; c=relaxed/simple;
	bh=P4F/MgcKXCIzh1tBXBMZOQScZ3lYOym7luUmC5sOAG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWXMkyJ19d8NQtchHedJ5bKwPeo8SHQ2WC13XJQbdcGu0SakR3V40DIEUNJY2msz6RahXVT5l07GL69kaqtP1P0UGd4EBlhMVBU+b6p2V5z/ScMFWnDoyqhp0YRDGMrlC5XW5b6obfWXUIxtn4qlBirZvuynOABM160uJIwKHyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a48sfQhp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SEW1+4Dv; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a48sfQhp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SEW1+4Dv"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 345F613806EE;
	Tue, 23 Jul 2024 05:02:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 23 Jul 2024 05:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721725328; x=1721811728; bh=VCFNnzfWkZ
	D7JDdXnal5PwmsycJBTW/1vGkCGMf5BcA=; b=a48sfQhpeSDoSzFdGgjUGJV2Kf
	eEaR8rg697sO6RcUIVwniRX4VqO/uXXE0QEiYZlKMPLahvKvB5KvD2kw1rwpEkdl
	IZoiBqiESdX7XMQPWvGc48ZOsZ/xDXgFt3AxEWdN+PA7rXIzoLjstS0LXumCYRCs
	IEyWiKdrCx1MBkpAqOF6HubN5/UQfvRc5H5DCSLX9iQgKOj2WjvNDJuh+lfqu448
	cOSJhDu0326nDmOQlFpZOBQYoFVJRy75kRA8b+9IcgF0PW+Uii+VDrI+lY0GOP8G
	xBdNY0g0GKcQ3jGU9VZ1DV+rA+RZM6jQLjKH9+ES3gGlSCuGkmBO6me/OEYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721725328; x=1721811728; bh=VCFNnzfWkZD7JDdXnal5PwmsycJB
	TW/1vGkCGMf5BcA=; b=SEW1+4Dv91wL26NV3nsphb7HOCYNKNUYzWqivmtw75fx
	9sBjUgqqw8k7tjw34i1POS1Y2as8RH7o010RxW7bsYw7EGiLrMlujRCHOK2ipAbp
	+k+LO2uIZmLSQ2SVZH3LgUkYrfBLBMnEwOHtm9cO13BhT1tQyOxkj77FRL9fnrJx
	TBBLT7GWTqNbWcHBbPRu798a/hD6Rv5/i8lBiaX53ImMTWGdO/L38GHBPO/V0Fr1
	CRej4pEt33hO6neYe8GAmmnSwwbK4CGodxef+apzaxNk9rsBO0Oh3FCV0j9Ot6O2
	qpnGUQXYk3nB5t4kEUd3cY9uTmOPD/89FKbqA/E76Q==
X-ME-Sender: <xms:kHGfZuQE_CndyL89BEFVY6YvsESKTxxBPC77FuSSGMzUcW8eRbRHJw>
    <xme:kHGfZjwJ2c700rdFBAhSTe9NbX4yxABtOPGUPXAd5xd4TTPJCCbT2WzAjfi11MR3s
    SxDIJUX2iNkQWzttA>
X-ME-Received: <xmr:kHGfZr0uZZMM-iRJDLIrEifPgsLkUBHFBnXqkPKmcHrM4Xy0x78bjZBaV-C-wVfbVUO5aKyOkqKyzfi1r9xDYiEDdbbHU0vffxeCDufmjl-AelN3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:kHGfZqAgMuuKP1Y8ypXHAImV4STTv8C-ioN4LRK3X8qnIKs34xbfiQ>
    <xmx:kHGfZnhoaz2tHtZlHe-c_sxu3SKZiLN6JS-Gm2Epjfe1QB9k7db9xA>
    <xmx:kHGfZmrnHYZLkJeymq5t1zEh2MaWANNFXUflCCvsnvipWQ9QnNJc1Q>
    <xmx:kHGfZqhV-qwqfAdi7Bm6_E8kVAGF4155qDnKzoASYa8p-Fumh93-Gg>
    <xmx:kHGfZnhax9jyjktDBvOmIH7rCv7C_1b8iBNxGr-umT7BjWYugbHci2-g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 05:02:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 85ebe205 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Jul 2024 09:00:49 +0000 (UTC)
Date: Tue, 23 Jul 2024 11:02:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Emily Shaffer <emilyshaffer@google.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3] Documentation: add platform support policy
Message-ID: <Zp9xiYVh11KurICO@tanuki>
References: <20240711232413.693444-1-emilyshaffer@google.com>
 <20240718173843.2411415-1-emilyshaffer@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="axgLBM84AgSZaVPB"
Content-Disposition: inline
In-Reply-To: <20240718173843.2411415-1-emilyshaffer@google.com>


--axgLBM84AgSZaVPB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 18, 2024 at 10:38:43AM -0700, Emily Shaffer wrote:
> +* If you rely on Git avoiding a specific pattern that doesn't work well with
> +  your platform (like a certain malloc pattern), raise it on the mailing list.
> +  There are a few ways to avoid these breakages, so we'll work case-by-case to
> +  find a solution that doesn't unnecessarily constrain other platforms to keep
> +  compatibility with yours.

I found the latter part of this bullet point a bit weird. We don't yet
know about the specific pattern that may fail on any future supported
platform, so claiming that there are ways to avoid them goes a bit too
far, no?

> +** Include a comment with an expiration date for these tests no more than 1 year
> +   from now. You can update the expiration date if your platform still needs
> +   that assurance down the road, but we need to know you still care about that
> +   compatibility case and are working to make it unnecessary.

Do we maybe want to replace "from now" with "from when you add them"?

Other than that this document looks great to me, thanks!

Patrick

--axgLBM84AgSZaVPB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmafcYgACgkQVbJhu7ck
PpSzfA//fh+bq1tzGn+ya90kTCorYNN8Tvgieq9KVnqP4blB3owrPrWVj0Tr3Lm4
Q8xnvOn8AWeOm2IGalK3kKdeNib4gRUAO5FclRHhCvcgTdXKoJ4gPBGUn5j8jPTO
YZV/VvzkDbe8UmluPD0SwIB/ULsqsYBOU3702EPomIwxiiNdzuKiXx9pNbbQeMbx
rY3TG9vL099wELW3P+41UjgxAazHWNel4fiU8j4ZX2vJvti2wS3rfFreLUgQQYZ1
Fqxs12RmXyOnrHhEEl+u+6k6g+hDFlPzt+iGWYTGM+79QyEEzj+7rDPOT4vSCbLD
Ul2IcTMxnB1bVFJQtIG0vgURyOgiKNngTCbR2ilpPXeiNnvCU57n+zhFhbcm9bNq
YT+JC9TrpUV/NS1HF/HYdhgyQLd0kkqDlGseF02ftvSaI56BBbCciN2u0+b+UhI8
wbgbQhidqoNnVRhDXnlSuWHbiQr2tA0kxLdT6AzQqbenade5tO+Bbk4gn9SXiX62
2N314xrl/hk9hkxULZOVdPlJk8nOIW4WtgOP4BShNRnjiF3Y/EQf4I+KJelfrFtS
yNSn7M+B/jDBaNQNr7JF/IA5+oDU0XpOfGRlVM/jFStmjS25oL0I47zu8I5l6hcS
zaYw6regqY16JPGbQVjj0GJ5SdV7s6ShIGkYPJJJfowDWGuVNy0=
=KLo4
-----END PGP SIGNATURE-----

--axgLBM84AgSZaVPB--
