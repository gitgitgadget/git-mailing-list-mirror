Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE81138E
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 02:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073753; cv=none; b=B2m5GzYT3mJoE/YdJNflN/SDcRaAy9kA85X1Jp2vpahtyrqXL8GiwlEkfvVA4PHTVPZvUKu2b3ROEAQua0fXhFXJqkeFwb7b45kkn3Ci/oYmzwKCtCBooztpla+3nYdVJmlQRkT8u9oO9/1m2B4o9dTcHf6NmB/k5jfxXhv1AZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073753; c=relaxed/simple;
	bh=8CkLXRLIdG9lshlbwEC7EzIFbimtaw+Vb8iXzUHYSYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aio+Pa3i7Tny/zYnrJ4UZEXIF3kiJQd+8t/nWP4W4GcawRU9LIPj0Xn7s/1+IJ86oEgcqJ5QMQSwD9Y9MqYW6EHTVnyl4/LDscIOnX8pXrksNza+/fCF+x/E+zaM+mU9BpveBL9KF+zKxobsl3UKMtwoiWqtOBGlPu6ImLN9vd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PepmYl2s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sgtx76ys; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PepmYl2s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sgtx76ys"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id BFFE81380155;
	Thu, 21 Mar 2024 22:15:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 21 Mar 2024 22:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711073750; x=1711160150; bh=8CkLXRLIdG
	9lshlbwEC7EzIFbimtaw+Vb8iXzUHYSYA=; b=PepmYl2slDq8fKzsLjY4pKYcbQ
	TBQm56tzpj/rgyKXAIPBgLG/UEAy+ifOb8s/wN9KDcIaaNh89OR1cwYXtlJ0k9uV
	eIU2dlN+nM5Ajn4/YuztA71D4XOvpL2l/RzNOQVnwEBeukzza0LJiNnNL6ZTBm68
	ZEs5OCVkdvRdMrQdhx4/TU52fXai85HkWN7B82k0v61I3IZ5OdZpiwyfXEy/OSt9
	Ujykh5Pvw0K4sHJ+Y2ful9NgqDstYrssv52sbd8oyX9pCogmPfr4tQW6RfF1Lp6w
	2y9T+sAGXyGCrfWj9d9t5fKiIU93i4VcadeqnLhAd1veLmDMipMHNiNw1+2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711073750; x=1711160150; bh=8CkLXRLIdG9lshlbwEC7EzIFbimt
	aw+Vb8iXzUHYSYA=; b=sgtx76yssjQSlA8APsbTzl9hwmvABA0Z1IDr/RRKQWGn
	Jt2uZzcHapa/Al/x6njmSPii+sVI5aVOrnY3GvBPyw0YpbrHZ59eDBxEidMQ8jTf
	f4mCeBGI6c1Zyr9Po/oHvth4Iyv8ullC+Tuxn63oe0dLXguTNwZND3IHnNEr+Dax
	PHGhqfkFKCtXm8jOWsRkIB7uK7jXCXiIcH5OfR5ecNUCsAndoMN3RC8tDioDpEnQ
	ptKjn9aF0btA5mKzlTGHZ8Ohle6z2g09vzlbbzJac0+UjTbRQJ1gUZ6RsV+HTVvG
	M1UjrFBZKrmdc74bUDF69UqwboEmn0HQpn0zIiUCyw==
X-ME-Sender: <xms:1un8ZfIgugTgwx8F5NU2uwywkZzBdupQzTiLSsu8a4FiPx8wuPeenw>
    <xme:1un8ZTKP57_HzwAbcoZ-iTOk611V4RbYQ0bYGH3xwjuiiza_EsjlLP6dSDhq9WmIF
    UFwFCup4KTZgn0P6Q>
X-ME-Received: <xmr:1un8ZXs8txWI-hC1BYQoymFS3Ku_Bu-CNstWvFDnNblRvKp3G9FzpzhXomQzoRVd2c-qwZjV1tTqUg30g0cLw2kfHQCAZlBDDDwnc7PGpUB3KQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleelgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:1un8ZYauoo_3zYkes8JThf4-7kY1GsE2XUVqQvfQQ1YuzUwOERFJQQ>
    <xmx:1un8ZWZ33KTEOlofYufVn1ioe6cwYuNlcd5oXdMTRT8UpyrU113wow>
    <xmx:1un8ZcAWE0zp7kWwWNL4dpbQqwID9ZRTbvQCWtGZXRvkvGOQ4lZYMg>
    <xmx:1un8ZUbBLna3LS0SuPVGh9dZTI1b6_qZ9vCNE_DV5-BQ8ni1_cbEWQ>
    <xmx:1un8ZbOmmQCFz1ALMop6JIzpK3Sv6FxV1LZYzoML56J_ew8qP0v8Pg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 22:15:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 68ec09fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 22 Mar 2024 02:15:42 +0000 (UTC)
Date: Fri, 22 Mar 2024 03:15:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	rsbecker@nexbridge.com, Angelo Dureghello <angelo@kernel-space.org>
Subject: Re: [PATCH] t5601: exercise clones with "includeIf.*.onbranch"
Message-ID: <Zfzp0cxe68My35gW@tanuki>
References: <72771da0-a0ef-4fd9-8071-6467cd7b6a6b@kernel-space.org>
 <0bede59a53862585c49bc635f82e44e983144a7f.1710246859.git.ps@pks.im>
 <xmqqo7bjjid9.fsf@gitster.g>
 <ZfzmdcBT5MUqoxrk@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a2EdeWKKT1tn9PS1"
Content-Disposition: inline
In-Reply-To: <ZfzmdcBT5MUqoxrk@tanuki>


--a2EdeWKKT1tn9PS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 22, 2024 at 03:01:25AM +0100, Patrick Steinhardt wrote:
> On Tue, Mar 12, 2024 at 01:38:26PM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
[snip]
> With Git v2.44 this behaviour did indeed change, and arguably for the
> better. This is because we now pre-init "HEAD" to "refs/heads/.invalid"
> instead of using the default branch name. Thus, we do not match "master"
> anymore, which is likely the correct thing to do.

This is wrong by the way. I didn't mean to say Git v2.44, but the
upcoming Git v2.45 starting with 199f44cb2e (builtin/clone: allow remote
helpers to detect repo, 2024-02-27).

Patrick

--a2EdeWKKT1tn9PS1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX86dAACgkQVbJhu7ck
PpRxLQ//btjbc7DLiQrif0JQVn9EC0Ugfp9aE0h7tHJymaHpcZydUFEzjcdzkX3q
JnI+F6XUDjJViygv6E5Uw3Ol96+DfaxUCa8EAQZwZmq+Nj1Dj6gsYcvPZMFZDr49
+JaQP31twijo3O2hNP37QEwuwgqbYiefT2PuibPp6NWzbKr89fewV0VhQSQ7BYlT
lEZK9qPMwdLAZAAyQ9aMDX2M/M1pZSNsCH1P+qKT6w4qAB7CznRb3n7yhcH2V3X1
p4FchbOfc8ONOwgsWbMQGPJZ0kUXbyZD6SxX1Ze6pMcLWbQ5/kCLCv1W8M41gf58
3C1sGNHF45O3OWcI8gHkD4FS60U3sGh92HOYyRFX+OwDCAiFYTk/281iJoso6H7z
/IPEehXp0Y9adEHZWeoIYMN0zlUsJnWAdJkfxRy4GiYsH9N7qolyLlV9cNzrQNNP
iYo6pHPOmycURNcsWEtbUVHgC+E3ft3JDawmiypfP8/53VaxH8zgW/1cdgLpv9Ql
rhI9xaWcRkGtYnCYyZwsdGBB6xJvjDWcOyNWqv8PHbyvHEK7WaFkH56FJqZHZLFa
+9CdWHGGXPsajkD5oZW1nL0DCuddzads/OKWqLf7vGYypyQYTrbB11kKmqqg8lpv
3733cLH/+EY0ZWGI0lXUnOZY/IP4VWer1ZaE07EA4ghASKYz0lU=
=7KNY
-----END PGP SIGNATURE-----

--a2EdeWKKT1tn9PS1--
