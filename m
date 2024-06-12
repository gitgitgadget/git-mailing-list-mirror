Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A9D16DEDD
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185257; cv=none; b=CSAz7Udae+WS2LBpb27VlB5CMomeJCAO/fVWGUYRCd9PrvyuWWZU3opHQkSYaAeLr1NC87IXRlm6PmVy3VBDlgABwJFA0Dhhpueu7Zu/hQs+5UJowVnNtk0R93JjByn13uuzLjrBnhXi5hUJmnupupFlnZSagcVSW5raFIpzTRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185257; c=relaxed/simple;
	bh=Q45btjMjm5/Xjf60GmK9cCI0r1nssFTJEpgkyl3T4qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ox+JoDZvE5Ua4HrZKAqTGmieeCu4uhdWCh39srmr1Mo2hJRg6Xd4iFgVbBzPIjTkfItC61RMRfLgw9ZGuA5Z+DeSsk2fcBoO5ghome4arHvMyfb+Azoi0dpzdCVow39+ExkRM+FywouQb7c595fSOpx0uHpy3UV9xU4MoakiFB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kmn3dgXA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UQKaSzRl; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kmn3dgXA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UQKaSzRl"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id EA532138008C;
	Wed, 12 Jun 2024 05:40:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 12 Jun 2024 05:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718185254; x=1718271654; bh=lkR0/B3vRa
	rzPk1V0aTb7KfgnamZYJhfPFR0Y5bUv+g=; b=kmn3dgXAjq4ujb+5xXivdnLI8r
	LbuczdV7I1qDRoups01r9+l8hkzizS5FffpCdbNxHLK3RkpDIergJa1pU1ciUGdY
	BeOpg5KpSCu7L3G+0yOuzaI2GDUEGJoD2htkDJbMSHgHD8FG+gdSImVXHvHRTta4
	kUtMlEwRORSXNvkmuOxVGj0xwil6RHzB0GLDP6dn1EHzrdTuPb0nkIbqnterS8/V
	aLgXNBStJyNxq5X0gHPohGAt2thEmVQsDDYC3pwkOzn3WEni0nF9/jPzj07YC9rm
	7Wd6ZswDLWvFPVuUmtpncmyXvWMSLuF8P8WPdAX/sUjl3641rMpUBU1y4/9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718185254; x=1718271654; bh=lkR0/B3vRarzPk1V0aTb7KfgnamZ
	YJhfPFR0Y5bUv+g=; b=UQKaSzRltnT7wn3paQAMYCDNCiT3BD74zeUVRuMdrUEd
	1XbdphuU93kevxbD41H3jdjLQmn5wrLtPDzh9A18SAPSJlf9Onyo85bnL2f7kf6m
	jzIP7cMw9Zo+eAM9918PBPln8ILyXyheSZeJSek0+J/9RRCJa9aG4pARKj/Hw5uV
	/LCX1zG8/KA/opZplZUCP/5UFvGBxDNXsp9cJhVtWBviEr57hKeITXYO41AF4BSJ
	E9rOC0dzKdhmWpFIC0fZ+GpYNWBrTrLLt7m9Bz2b+w78ZhTFeQLymeWDCDYEprST
	UzVY2SbwdDX+l8BrVxiszS4XDEaUCHex1XR2pQw53Q==
X-ME-Sender: <xms:Jm1pZvZK8f5UBNDFbEds-CQjCF6FhKbJm9TUiwrbVEZYZdFjJVj26A>
    <xme:Jm1pZuYK1Aw9huzTsKd1y4DxW0KDgLbCZJh1ljkJTrH1P3W-nRIOs3cFRgKGk8EQ7
    wNqeFwJz-4T3GBUdg>
X-ME-Received: <xmr:Jm1pZh-ge2_NCsgv2P_xDeIHFduHu1uNUUBXrKcQEuKnnYzKxLYZMnrkCVlzopsIXR7l_0mymkt_tOOD5yQ5PEweQxsVl62u9sUCwc4Sm-hZZXTt0pY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Jm1pZlpz9kzdQmIj5K8VjUti4duqUmUM7aJL_SQoBYTackBKj8PLXA>
    <xmx:Jm1pZqq9zc8xZOS9OVu7fonomEg2dnHIaPuy_w3OfBCUqPbccp5gIQ>
    <xmx:Jm1pZrQZnxiT6Kk4q77HGuKaBqK50iQDo-kt1oJNni2LRjQZo56nhQ>
    <xmx:Jm1pZio7Y6mQT0DBpohf-_aeK6fv5ESc9ZEQ9273fhf0rVYOcBgxxw>
    <xmx:Jm1pZtWBJWakwOJZ-w-zbpFgm1yleyQ93-A7m4sdCYlVtBOh3hEy46hk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 05:40:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id abbf9351 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 09:40:42 +0000 (UTC)
Date: Wed, 12 Jun 2024 11:40:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 12/16] mktree: use iterator struct to add tree entries to
 index
Message-ID: <ZmltI7HA7O4w2E-6@tanuki>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
 <94d6615d634c4f78c88d3e01abbb27f13f85828c.1718130288.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PwnTo26SdXqDeNJn"
Content-Disposition: inline
In-Reply-To: <94d6615d634c4f78c88d3e01abbb27f13f85828c.1718130288.git.gitgitgadget@gmail.com>


--PwnTo26SdXqDeNJn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 06:24:44PM +0000, Victoria Dye via GitGitGadget wro=
te:
> From: Victoria Dye <vdye@github.com>
>=20
> Create 'struct tree_entry_iterator' to manage iteration through a 'struct
> tree_entry_array'. Using an iterator allows for conditional iteration; th=
is
> functionality will be necessary in later commits when performing parallel
> iteration through multiple sets of tree entries.
>=20
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/mktree.c | 40 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
>=20
> diff --git a/builtin/mktree.c b/builtin/mktree.c
> index 12f68187221..bee359e9978 100644
> --- a/builtin/mktree.c
> +++ b/builtin/mktree.c
> @@ -137,6 +137,38 @@ static void sort_and_dedup_tree_entry_array(struct t=
ree_entry_array *arr)
>  	QSORT_S(arr->entries, arr->nr, ent_compare, &ignore_mode);
>  }
> =20
> +struct tree_entry_iterator {
> +	struct tree_entry *current;
> +
> +	/* private */
> +	struct {
> +		struct tree_entry_array *arr;
> +		size_t idx;
> +	} priv;
> +};
> +
> +static void init_tree_entry_iterator(struct tree_entry_iterator *iter,
> +				     struct tree_entry_array *arr)
> +{
> +	iter->priv.arr =3D arr;
> +	iter->priv.idx =3D 0;
> +	iter->current =3D 0 < arr->nr ? arr->entries[0] : NULL;
> +}

Nit: Same comment as before, I think these should rather be named
`tree_entry_iterator_init()` and `tree_entry_iterator_advance()`.

> +/*
> + * Advance the tree entry iterator to the next entry in the array. If no=
 entries
> + * remain, 'current' is set to NULL. Returns the previous 'current' valu=
e of the
> + * iterator.
> + */
> +static struct tree_entry *advance_tree_entry_iterator(struct tree_entry_=
iterator *iter)
> +{
> +	struct tree_entry *prev =3D iter->current;
> +	iter->current =3D (iter->priv.idx + 1) < iter->priv.arr->nr
> +			? iter->priv.arr->entries[++iter->priv.idx]
> +			: NULL;
> +	return prev;
> +}

I think it's somewhat confusing to have this return a different value
than `current`. When I call `next()`, then I expect the iterator to
return the next item. And after having called `next()`, I expect that
the current value is the one that the previous call to `next()` has
returned.

To avoid confusion, I'd propose to get rid of the `current` member
altogether. It's not needed as we already save the current index and
avoids the confusion.

Patrick

--PwnTo26SdXqDeNJn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpbSIACgkQVbJhu7ck
PpQ2MA/9G8Dq3Y7+kHBGb9a/FJc2g7+TZQkTGQ3g0S2BxU1tabaP56yIFeXi8DA0
Tkrh4Eeagx1eJKczQ4QZfJ8x9nrFREk/eiNSfVtITWDjBdQSFfppqTL6+NhsIuPH
+hFfQgJZynkOkVyiWVYSV3daCYcTN9bJHMnB8e397hyG3o1ND3RAyFlSTQlJ9v06
tkpeZtTO6g3dYZnGGvM3oCnpDcitw+uKaJOTTPtzY7XZ++KGDvCwR4lVtfH1jb+l
7Zw2Va4gH8D/UUX8azZ7oxYq9BC6sRDdThCf1iywutk3hcu/59BFQgZ/orrYaUQW
RRf7jqBKkKEtrrMMTRVHmxX/kyzCklJmv1B0xPYf8dDE4tT90sT1JnP7By8ZyOCO
JmB4wHSWkLSrogKvZ87Lz/iRhfXc8YVHX/d1EPPibD6rGB8zJbiCQ/Nhhyuhctnz
i/P0UR1I4LfX1UFO1QnhEk49pgtAxRgR3EU23LaRYRXPCNfUBmkdsUvkJ5n5+ETt
Tc72O20CPKmFr4WfvKcwwLvKj/UfZWedOaH0Oa1QXTvjcO19gj52Vt2TRJaeGbNk
dm1oi7bx0xeYuIGjLYTfQEeV9l51XLs0rjVx9d+OovW4ZLtwxTYZXM38UeVe85zq
7tjTLg0/PDWwCIop16L3zN5HkQ2bC/iphMw8yj0qUcSVfM24rxU=
=L2xt
-----END PGP SIGNATURE-----

--PwnTo26SdXqDeNJn--
