Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947D1137929
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574545; cv=none; b=QACIsJlmZTDBYlPXE++reRDkXvF/umhCWi6uLGrNfBRTAL+3j98ggP3oYbBhYtDsOT4SiKBuFcGYi1zj3BDotS7xq0fy7pd/shp6IlzG6L9d8iJLms0S9NF66ZOK3j72GInoPupKlPFVEYDyhfDRIV3B+IN+SPzVVKOPJfRwHSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574545; c=relaxed/simple;
	bh=9pfDB76lq4DVAjgMH8ka7e9bC+yiDZSEnA45UayP0Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhNUSgA2dOV0a1P9WsVxTkHI5qeqysndG4oJ/6tnuaddV+k/01dNB+omk3uhdDsjxJhGQ0xbk6z5YBvns4ON7PnQuNF6urgcuXgVFuJm6UU3iCziaxeB3HlCBEJUFF6EUj2Z8YABC1FkOK3+4KWS6KLUWItjzl4I4iVB3CjKex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WKLSjPPE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XFkbGpcs; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WKLSjPPE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFkbGpcs"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id BE2B31380178;
	Wed,  5 Jun 2024 04:02:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 05 Jun 2024 04:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717574542; x=1717660942; bh=9pfDB76lq4
	DVAjgMH8ka7e9bC+yiDZSEnA45UayP0Cs=; b=WKLSjPPEn9iW8X3K/y/ZEsUOS6
	d56CFlqZGMC1Y/jlONpDZ/BJWgwGaC2j6EW6Xi6sd6UO1Yd/SeYkMzPhv68ymqYc
	0Vkc8hhDpH80DcY3BJGdY4G/xQ2xcOOpmvQraFlqQH3YDU79pRS8yRAnYyEK2XR4
	n3TAHhGl0YQl0gP2CU4/9YRqmcC5o6wp49LUSSpdWdE3p0NRvlQOOG75wX4YIepf
	RdHkQBDXPuOaV7x9xreFEQwGBtm43ZhSLNEAU+q8akMNNVkm3HSaqWgyUx32pBuC
	k15owNDNocScZz4LdBote4nfxo7uCXJTE2l62r0VTrn8YugNIYB+YitlBflA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717574542; x=1717660942; bh=9pfDB76lq4DVAjgMH8ka7e9bC+yi
	DZSEnA45UayP0Cs=; b=XFkbGpcsKkSo78+31t18SXL5pfje2hZuKHT4Neq7ZKzS
	HbjBLGBBfpV28vxxVy6L9Wq3PzZtlHmeRzr52DtgeQxbEZ//y2IVP9H+UrjJp3Gj
	97gwMUaMBj270FXCj/fplANstCaOEFpsWSnXnATAPMefTzHrSqFz+eXXhA9GHLzO
	BTd/1rYFhEZMcktBcVQTeL5cTOoVD54U2HvAm1qDvlV+gGe73E6bvv1r4dJVTbNv
	lPuWzFUtGUlPDt++gR+0obsp8EyFiTaIdJM3VcbH5LN8Hbb4bpC6XjoiAh7dEQMA
	c6wkZJdI1A7kPGOFwiLpDO+qMKNY5/3uXM6al2N65Q==
X-ME-Sender: <xms:jhtgZvLxFmGowP-mkZR2fMNaeOzZnJ2CdVT_FWupJ_fxuooraPI8OA>
    <xme:jhtgZjKMMiPVB8xo1M8UpoYBcsFKn7EGJ2j137NIzEZMmeh5gO2ane-ey97gDeGNa
    Q_ukVBxGjBX94ctQQ>
X-ME-Received: <xmr:jhtgZnv18vc6M5AKx9zMm0G-T99fdgO2w-7SpmSdhE60zwzfVgceoYKG1mieQ3tv5TNmxahId8y-0rgto1kPsmunTyvmaffPaTK1mgMtHHKQbII4r6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:jhtgZoZzRheEkPDbL4qyd1sAcG2za7yZriTHiOldXVaz0cni6FSyag>
    <xmx:jhtgZmZYlSQaUNFjg6icIQFm4HoymqLiIST4o2msZbrbCG2SceC8bg>
    <xmx:jhtgZsDj8DP_Uy94Tcb2BVOAgGjykPuN011_93z4vo03MexFP_NGvg>
    <xmx:jhtgZkYKzXHtz_FUPo1Wd9xNVvM4i4Xnl09Vnvgy03-_fDP5Nc9wFg>
    <xmx:jhtgZmEB6l8QwtX67SYaNO1v44dwjbNtCC7rwQA25mCKkqhjKuCiPjiy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 04:02:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9c48ca2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Jun 2024 08:01:53 +0000 (UTC)
Date: Wed, 5 Jun 2024 10:02:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 6/6] update-ref: add support for 'symref-update'
 command
Message-ID: <ZmAbi6RtD7EFkKJm@tanuki>
References: <20240514124411.1037019-1-knayak@gitlab.com>
 <20240530120940.456817-7-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EHyo30sT4pUlJsWx"
Content-Disposition: inline
In-Reply-To: <20240530120940.456817-7-knayak@gitlab.com>


--EHyo30sT4pUlJsWx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 03:09:40PM +0300, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> Add 'symref-update' command to the '--stdin' mode of 'git-update-ref' to
> allow updates of symbolic refs. The 'symref-update' command takes in a
> <new-target>, which the <ref> will be updated to. If the <ref> doesn't
> exist it will be created.
>=20
> It also optionally takes either an `ref <old-target>` or `oid
> <old-oid>`. If the <old-target> is provided, it checks to see if the
> <ref> targets the <old-target> before the update. If <old-oid> is provided
> it checks <ref> to ensure that it is a regular ref and <old-oid> is the
> OID before the update. This by extension also means that this when a
> zero <old-oid> is provided, it ensures that the ref didn't exist before.
>=20
> The divergence in syntax from the regular `update` command is because if
> we don't use a `(ref | oid)` prefix for the old_value, then there is
> ambiguity around if the value provided should be treated as an oid or a
> reference. This is more so the reason, because we allow anything
> committish to be provided as an oid.

It would be nice to explain why this isn't needed for symref-delete and
symref-create, which also both have an old value.

Patrick

--EHyo30sT4pUlJsWx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZgG4oACgkQVbJhu7ck
PpQw+g/+OTetaO/AXlkfunjTkO4cMehHnqsLHUDBBIV2mBZhF/9lKCIFXknjH9aG
7mWvuXRL5Aiadyd5le7nkaXBGmL73QqlWMPdEzVIrKyAMiqByF2gn+16wQ1OLULX
SxF5FloNfYCbO7o6lK04270/qtQFzbGW9zP6Eus2l2SI4eD/llfgvA0xfvgP6waW
/av6ZawjvPz/Biew/dfusg6tPkTCyqBP1509osElMArrMlvp+TnBmq8upyOboz6p
bPLUfsQNXPDtu2yYiSkpWDpqeh06gK7zfXceNmIOBKxYLEF4Coh8ed1eH4NaYPv/
MmDDPq3Tu6pNVe+LhIEUvcfP9wrQfSxPnqS92jjT7JaZuSP3lpoY/TAUISe8sl7X
F0Leah12ntU5hwB8r/tUT3HXTf90t4M5GSN2qg1ul31tDvRvqWXLzXhvfkx2QvET
dZ17boREEMpHT1WikGJUjFFqVGdX62UqpfvVanEgije+MwGHbUVR+cm4+tPVnx2k
FP5ry3j/TAOdoj3vGNqafdEjuNXz+IuBpFY/TaIlPEkCGmeQ0JP0qkgVTYV8l1Kr
ZC6E+30AYq4Pdwq9yvGuh4sqGX838dVOwL+NyQxj/I2C4ab9GlYPXgEucp6s1gX3
5dMTQDie5dX6cEuODY8ejZttl1F+9hzmZVOMV5nRp5oMXqeRB3w=
=XuY6
-----END PGP SIGNATURE-----

--EHyo30sT4pUlJsWx--
