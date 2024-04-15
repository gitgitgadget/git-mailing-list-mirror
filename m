Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEED3AC1F
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171074; cv=none; b=I1JzCJGaZBHME42T10RNUQAS6swzX5DICjsegfg16fMn31tGQi4GMQ7HbZk8cN232ty5FDTJxnJ2l22z3RNg+Tx0CoDCl6PSgSdDrhaOHl00baYrddwTg/0uFRkC1UzfxBBHv5h/n70+qcYQFvnI3X7lP0FM0ffk17sqBeyO9Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171074; c=relaxed/simple;
	bh=yGUs4to3L5TYtgLNpxBb9h72dj8X/FMNS2LA33qYHuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gr4LgzGzyEJyzi/eYgWTYUXyV9k5t7MeVmdy6W/3Ptek66FqOKT2txoLhmrgafIEvRvx9JyLLBj+pD+ZIMPC+t+lR5Gq/B2fZbt4sWwD6ewuVbrds6H3mAFa9vE/d7+q7oZJtzGmEJ/JKX+ywPVHxX230uMxpBw8HF505tWtt5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ipfWjMyu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=doIGtJZM; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ipfWjMyu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="doIGtJZM"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 611BE13804EF;
	Mon, 15 Apr 2024 04:51:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Apr 2024 04:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713171071; x=1713257471; bh=yGUs4to3L5
	TYtgLNpxBb9h72dj8X/FMNS2LA33qYHuQ=; b=ipfWjMyu8PliEDbV6lgEWxIxYH
	/PqZ7JgonvXpJ2etEI/o1/YMGMIxIZaw5VO0IYml3Gexhihb8HzTxFmmbrUmEAvb
	7fC+pAO8APvaCmXHOYIomQPO6r+DEbOBEJo8phijN0JP2vOv+5dnEgecybmVn5fZ
	Jt9YSVO1eBOIO3kZoVFhNuaM9h2EW/5M5P1FauZmbOGOBAg/TrNnMgsuIRrdOpG+
	AZ5mhVA3roolPHbZFRQAJrm0l4G+oxmezftQiCR2eMQlKK70Kf4YaiOI/0lG4bEQ
	gF3uP6xx1mkw50VBwvRmeXzD7e/cW920/sh2yJUofyifqP1NplnHxN8iVxdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713171071; x=1713257471; bh=yGUs4to3L5TYtgLNpxBb9h72dj8X
	/FMNS2LA33qYHuQ=; b=doIGtJZMteX32fIavYTyeStFpCTXJDf87gAc4+3ageGK
	xv8cSSUJ6PFgjsmgjH3tgG8YmoHJmF4OHbKzlGEFLcoNMk1uNNFUVJ0/HK2vuCaj
	SEcPIFLg4iZ9zl5WY97cjyzCNi7N55rHEI4mX7WWaJQK8i00BT+3aZCXmhf8HYs9
	NW/SZnQAC70dIiM35piXTQs+zaX9WEkV7ebIuj+jdgWdluUCyL16I6GVbe43ldVN
	Im0sswk0MR9nfscnlTxheeaDYOJ6eJYlhIHo7+02O5HLl4yuqjYZs06PBRVMWvXC
	sjag28tqqYD+X3OOTif+w/GDW1tBoXpDnOd8HmsHbg==
X-ME-Sender: <xms:f-ocZjZJIm6r5KUuA46HJsmQeBRXoOz5yd1VDqe-X3srsvNFVLT5jw>
    <xme:f-ocZibMHUxb_Wxp6jWAQfd4-rzeOFPOI1h2TjemWazmvzJz_x-exV6L0CsPXezet
    tCNiSRtgbfvVew72A>
X-ME-Received: <xmr:f-ocZl9ogky4rBrSDcXeJqfEHVnCNOInF20qkj-aoaIpd95MlXE9fz5WqeRiZWQ_KPLSwqxUW0qxwLttP5JaLWxmgOEnEwKq9mCBhxO3tpLm1n6zUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:f-ocZpo2w5tKK8u2iHOWP4RU9H8jBL_z00PQ-5XvGYP2y0Iau2Z7xg>
    <xmx:f-ocZupfaNPoBKp1hgsxXN9a8LcWINWk_PKWQZk3ooLkmw4nKlNtSw>
    <xmx:f-ocZvSuO6LFyoEQQKz9qlPImabd43z7k8PpydoQqLQLXT59J58kcA>
    <xmx:f-ocZmpHJgYVEZbGGqxmRqjUbv0c4JrPYRkdEd5lXHUBQG3fQ9bZxQ>
    <xmx:f-ocZhV_R7Yc3uzVwMIIjW6yvr08bkI4uipSQyiXZSK18zKQJ5nTDF0e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 04:51:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 788c1fc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Apr 2024 08:50:47 +0000 (UTC)
Date: Mon, 15 Apr 2024 10:51:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pack-bitmap: gracefully handle missing BTMP chunks
Message-ID: <ZhzqeRIcyR3lmBme@tanuki>
References: <5933a302b581670183a6f3c881f62e96f61ff192.1712642313.git.ps@pks.im>
 <a8251f8278ba9a3b41a8e299cb4918a62df6d1c7.1713163238.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yxe6sn7L8KGmRctk"
Content-Disposition: inline
In-Reply-To: <a8251f8278ba9a3b41a8e299cb4918a62df6d1c7.1713163238.git.ps@pks.im>


--Yxe6sn7L8KGmRctk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 08:41:25AM +0200, Patrick Steinhardt wrote:
> In 0fea6b73f1 (Merge branch 'tb/multi-pack-verbatim-reuse', 2024-01-12)
> we have introduced multi-pack verbatim reuse of objects. This series has
> introduced a new BTMP chunk, which encodes information about bitmapped
> objects in the multi-pack index. Starting with dab60934e3 (pack-bitmap:
> pass `bitmapped_pack` struct to pack-reuse functions, 2023-12-14) we use
> this information to figure out objects which we can reuse from each of
> the packfiles.
>=20
> One thing that we glossed over though is backwards compatibility with
> repositories that do not yet have BTMP chunks in their multi-pack index.
> In that case, `nth_bitmapped_pack()` would return an error, which causes
> us to emit a warning followed by another error message. These warnings
> are visible to users that fetch from a repository:
>=20
> ```
> $ git fetch
> ...
> remote: error: MIDX does not contain the BTMP chunk
> remote: warning: unable to load pack: 'pack-f6bb7bd71d345ea9fe604b60cab9b=
a9ece54ffbe.idx', disabling pack-reuse
> remote: Enumerating objects: 40, done.
> remote: Counting objects: 100% (40/40), done.
> remote: Compressing objects: 100% (39/39), done.
> remote: Total 40 (delta 5), reused 0 (delta 0), pack-reused 0 (from 0)
> ...
> ```
>=20
> While the fetch succeeds the user is left wondering what they did wrong.
> Furthermore, as visible both from the warning and from the reuse stats,
> pack-reuse is completely disabled in such repositories.
>=20
> What is quite interesting is that this issue can even be triggered in
> case `pack.allowPackReuse=3Dsingle` is set, which is the default value.
> One could have expected that in this case we fall back to the old logic,
> which is to use the preferred packfile without consulting BTMP chunks at
> all. But either we fail with the above error in case they are missing,
> or we use the first pack in the multi-pack-index. The former case
> disables pack-reuse altogether, whereas the latter case may result in
> reusing objects from a suboptimal packfile.
>=20
> Fix this issue by partially reverting the logic back to what we had
> before this patch series landed. Namely, in the case where we have no
> BTMP chunks or when `pack.allowPackReuse=3Dsingle` are set, we use the
> preferred pack instead of consulting the BTMP chunks.
>=20
> Helped-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

Junio, it would be great if we could still land this fix in Git v2.45
given that it is addressing a regression in Git v2.44. This of course
assumes that the current version of this patch looks good to Taylor.

Patrick

--Yxe6sn7L8KGmRctk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYc6ngACgkQVbJhu7ck
PpQJpA//Zfdz+C5+6+wdswcDlRAjoPf4Szk+hXhfv9nDKSqshw29Ul597OBDKABM
NBawJuEZQYA3hTcIct2hHcvhjJmBjVhfgpdGeRUQRAi4yTDt+E/C0nIZ94wjJRcf
Dc4D7tcIWXnIIiEEKoQVECBGFg5GvU49+2cuMvtmRgjuYpOyggVmyoGWiuUW+LMN
1ibb3PlQ47XtVes5yk1BVx8aEGhQwf8RpD6dYN0yvSOlRWewu6zW1cPjKBjcfTY3
XtVY4H1AVSu4BE9gj29vkAjkkFmkboOXStXZOn8EspUgKkXav50SqAw7OFfPiXsr
zTNIDSonwmEvnRIAfNJQqKco7IdoLj8c7nfbuVMtKVOTbx5jGXwkRP85LEfM9+ea
F9WFeTxuQngQ32lQn7R/LSmPDqgM5BeXgZ+DMLMVlt/LHpxDfiVQ71DYcCVw9Va8
N/LHTsiODYWRyGz4eZnBI+VKEjObmGzR0UcWhYTpbiuZpCz781bWLFxuerDRLws4
CFnZQn+r/nGN2yQ6opCaH7PiaNt4++51tLe09ZRONfo8zfKX31u2y9cfbDeBmqH0
fRV2bL0QTTcRTSLRK6Oir4Oky0XH3uL/rlft2TZcrj8XLsR7s6TSAuy/a9JuD/ew
YDFKymJEjvoIYMDHZkTKy1B0Nf/vWboFvc52DecrfEr+WXT16j8=
=1/gP
-----END PGP SIGNATURE-----

--Yxe6sn7L8KGmRctk--
