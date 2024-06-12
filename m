Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B0716DEC9
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185235; cv=none; b=QFpwRrGKtSsaLM7yT+UDsnieMheM65iycGFM5PtpaYLLj3EEAPr+WmMKQHu1DyJYJRG0WN+cPddNWWZIyWH5N3D/7i/3OL0z8ufLKWowgLYSYh7/1kPBGcmG0hvX+0F85XSmVi60BbMsjRzl7MxkJk+E2ZSqB46sPhg2fCIZ/MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185235; c=relaxed/simple;
	bh=42bDV0JWUYbE0z7/TPnxTzBXuwEpzVCBo0FQpTd/GtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS77kdGD/sUqLmJrasyMvdy/7+M6/W0inHSmF3JvMR/yVYO48M29YQ2R+FjGQaeWsZ426LnhoCHOiO2ZJGzDqi9lQW2az0fyxLonPZzYfHCojP8euuGurZ2x+pUHCcJlUtLk8/DVP+Th0WZ4L4GrsfogLMjvRb7q8AL+3JBLYZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B2HiGWjU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ezHpoqDJ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B2HiGWjU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ezHpoqDJ"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 435191380156;
	Wed, 12 Jun 2024 05:40:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 12 Jun 2024 05:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718185233; x=1718271633; bh=QZpO6BCmyc
	kLge2gEOtprYyOCPRtkEaf/vChx7/ceLs=; b=B2HiGWjUK9w1/lnO6mohXFFBKZ
	pevMZWFszeSPvgDkQ05VncpytJFHU87t01Pe6X5pta4+VrmKPyTeL75F7iVqRarK
	O65T7PsNZGDFs0/fXkAZe+q+SyQfP9qndAju7kDkLTeTKBvoOhXSQpU6LYxs6kPP
	LK3E21Xn+hbIhZ91BHACHbITRU3r1EJWG0DosQXncexqyyDM4K6GMXcRJ1yaMyS3
	D7MTWCl15C/RkoS6St4KtACHiE/ITCzP5Wfk5nXCSp8miIcHomU7dIrGvB1yZBYY
	KKwtmQ0lV2M8bbNktH+Lu+WwPqLCX4EvmcqyPo2m3y37SSYnuV1h88ygqNQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718185233; x=1718271633; bh=QZpO6BCmyckLge2gEOtprYyOCPRt
	kEaf/vChx7/ceLs=; b=ezHpoqDJzkYiTNKJdGKvtX08WNL2UJIKB6WwBqfczXjw
	PlhKjKLsB2YBCEUsk2Xbwsr5jL78mFoAb1BTubjpmg7IrvpS9PBSvslrLYHCeawa
	7End3GrBtOkB3w9yJB6K0JDQEaZqhOxlBfBUQw5ptbFStPVKDJ04Nn8v39AJ1dwW
	epdX6imD17y+vfEYcP/nRWkfw37OHmHjeXj19WlBekL360r7U9vCQ4usGFy35v22
	kVJ3SUDJ8rkdCva9oYycPteHrXFECpyUP6o+eGP0zYVKiZfTl0g36biBgiAo02xJ
	VKEcjn8sS/djuRsNwMMkVWRyPQINJuiSyE3D1hRdqg==
X-ME-Sender: <xms:EW1pZrSBJXaKyF7gDy_FpxWpeCgNH3QRPQ8eN3vfj94sfxzHBXVDvw>
    <xme:EW1pZswNZvKjSFT91TfH4dRTEPBG61MEce9TT1_EvcLJ23e1QGoxuz9HFUWbzIs3i
    AkWPVdkOXgweIjvUQ>
X-ME-Received: <xmr:EW1pZg2ASX2zQVpIeFYx3I7id9JYiUyow4PyGw2m3bPWiGXx0hiChiVLADBT1pil_CBQ9TCslIwSVSbpUUV-RWE645vgfBekMslIoTjHfW1cBFh4Ihk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:EW1pZrCfNvhwH4umeYl-pSD-UbpibqRsm4jsqLrGvzE_9RdP0Ai1Jw>
    <xmx:EW1pZkjiPdV_JaKX0ycpNXlj_7XwaA2g-F99VzxyuKFz02ea7Os_7Q>
    <xmx:EW1pZvqk7O-qXJQFOu2EiPcwhQ-yIjvjyp0MoqoeieDbxh3FvPSm2w>
    <xmx:EW1pZvhrEBn_G0pWs5wZYaCI0JKhE2HjxOWNE53MYqeoIPNa23WtJw>
    <xmx:EW1pZtvvwuvcUM1uYFhPUchFlmJZG5vgd-CoBZkt9MIG11JVOclZS5N2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 05:40:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 117e20d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 09:40:21 +0000 (UTC)
Date: Wed, 12 Jun 2024 11:40:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 03/16] mktree: use non-static tree_entry array
Message-ID: <ZmltDQ5SlVvrEDGP@tanuki>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
 <5ade145352f44b431c16a2ec29cd87de489e8032.1718130288.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a5qR/x4xMReum/P0"
Content-Disposition: inline
In-Reply-To: <5ade145352f44b431c16a2ec29cd87de489e8032.1718130288.git.gitgitgadget@gmail.com>


--a5qR/x4xMReum/P0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 06:24:35PM +0000, Victoria Dye via GitGitGadget wro=
te:
> From: Victoria Dye <vdye@github.com>
>=20
> Replace the static 'struct tree_entry **entries' with a non-static 'struct
> tree_entry_array' instance. In later commits, we'll want to be able to
> create additional 'struct tree_entry_array' instances utilizing common
> functionality (create, push, clear, free). To avoid code duplication, cre=
ate
> the 'struct tree_entry_array' type and add functions that perform those
> basic operations.

Thanks for getting rid of more global state, I really appreciate this.

> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/mktree.c | 67 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 47 insertions(+), 20 deletions(-)
>=20
> diff --git a/builtin/mktree.c b/builtin/mktree.c
> index c02feb06aff..15bd908702a 100644
> --- a/builtin/mktree.c
> +++ b/builtin/mktree.c
> @@ -12,15 +12,39 @@
>  #include "parse-options.h"
>  #include "object-store-ll.h"
> =20
> -static struct tree_entry {
> +struct tree_entry {
>  	unsigned mode;
>  	struct object_id oid;
>  	int len;
>  	char name[FLEX_ARRAY];
> -} **entries;
> -static int alloc, used;
> +};
> +
> +struct tree_entry_array {
> +	size_t nr, alloc;
> +	struct tree_entry **entries;
> +};
> =20
> -static void append_to_tree(unsigned mode, struct object_id *oid, char *p=
ath)
> +static void tree_entry_array_push(struct tree_entry_array *arr, struct t=
ree_entry *ent)
> +{
> +	ALLOC_GROW(arr->entries, arr->nr + 1, arr->alloc);
> +	arr->entries[arr->nr++] =3D ent;
> +}
> +
> +static void clear_tree_entry_array(struct tree_entry_array *arr)
> +{
> +	for (size_t i =3D 0; i < arr->nr; i++)
> +		FREE_AND_NULL(arr->entries[i]);
> +	arr->nr =3D 0;
> +}
> +
> +static void release_tree_entry_array(struct tree_entry_array *arr)
> +{
> +	FREE_AND_NULL(arr->entries);
> +	arr->nr =3D arr->alloc =3D 0;
> +}

Nit: should these be called `tree_entry_array_clear()` and
`tree_entry_array_release()`? This is one of the areas where our coding
guidelines aren't sufficiently clear in my opinion. I personally
strongly prefer `<noun>_<action>` syntax because it groups together
related functionality much better. And while I personally do not use
code completion, it does help others that do because they can simply
type in the noun as prefix and then, via completion, learn about all
related functions.

Most of our general-purpose interfaces follow this naming schema
(strbuf, string_list, strvec, oidset, ...). I think we should document
this accordingly.

Patrick

--a5qR/x4xMReum/P0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpbQwACgkQVbJhu7ck
PpRKVQ//TVHhCoH9JRjGuJLg+cDnOPLHBZ0hz39gbuqlT3fUkGG/J1V9tguLOQXq
Yw/bm2Wt/AvH7xpCAu4iDxBBeKDBZ0Y0eQUP+YrpikBjFbDPFebEdn2jkJD/wonP
qaB7r4ZBbTNDug4uI3HCflEeVELdS+DUy7m8i8Wdm0bS2/47Dn4Qq/lz2vXMrBmI
hjr/9qVzCk3LpmCV9ZMjyWunDd4VIGCZ+qks6xX2RYBTO3FtWcQwgV1Kj3TObiCI
jUoX4q8sySUzprgBb5bCCR7iE3LNT5Dw2ra98szOPfLKRW12fARwKjeNisywMO7n
oXXTW/zmk1kdoeRU6tKkEDapcrRM9pS64nTHLNNhClb7TdE90eExOJlfio40Q3Ea
rWemdTjoFupdw6Rj3vrrkfAFI+c62mh16DKvjNja9jp6pacNJRCYRfz3rPSMTn2M
76Wx85Pd1aZtXTSsbZ8+vLNOaM4cmAvoXBiP8Tk+5E0OygcnpEd8H9+HCLOPS0LB
evosS9AAv+QmxJ6PsGptY24z1JO5gDDoom72ZrUWV8HSM6vnZr9kVC+TzQOzSK4C
n+/7z/we3jAmd0xOXckDTUWZJg+Yt6Bgrg7cuo/eD/nqfmDCtGRzIHCFqr+kEDcA
Hiy2auRDl+MQwuxWDDOq95lFP+B5pl1ovRvX4zIjOzAqo6P8UCc=
=b0TK
-----END PGP SIGNATURE-----

--a5qR/x4xMReum/P0--
