Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE0716DEDD
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185251; cv=none; b=Je7zjKqDxKOa5JDWueI5a4UBdviRq8ecps1c7SSSeXVXOHWv9Pf8a845jNUvHDna/jsIsrAhA1NsgDO5VJGcnIy0vzoUNWvzVfJbXIOFrLU1OvjVoX8H9WKJkilquvHjR4NlH3QV9ZYopQcxXWUI1pyqOzDaN5lIdH6V2trlGWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185251; c=relaxed/simple;
	bh=NwCV6mcQy6oot7yHuYdxAArPVx0QsoX5dCkcDAoo9h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bobB3kuuLgei5NiLgKUdE7a4rd++GrD7DhCFLTdRKpfHtx5PTE5uqktQQSAWVI4KKe8wGAvr2qQQTtIy970tu8jKdXmpMB2sbJ1Lzc+1iUbNEoN92pIBYn1lNkakPlyFkIsTYL5ZihrEAiRZL0Lv1SFZ/BbGv4YfjeuMDYIcjFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U+HgS69Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ia4tLqck; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U+HgS69Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ia4tLqck"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id CED74138014B;
	Wed, 12 Jun 2024 05:40:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 12 Jun 2024 05:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718185248; x=1718271648; bh=dHkz5iDLrW
	4Zn4GHCpQMZUjnuVlLVQeo1Q9O6jarAZk=; b=U+HgS69ZUFD8BNLbI763sJzJrh
	r3b+PxHH6ikipb61I9gYZvazNt+BhRn3aubzOXQgr88j7d6Fo5pjZniJFPNjAIID
	i7oyZqg00/YStcSNyBh3CC9RLsI5DiN6qvLiLkOuKaHu7UK5YvtrIVZDze1abBK9
	4rT8k41CDLUUpz9Z7tPpW4RO2MXs5v1HEsgRcUljzkvyhQNVhj9YcY6o/omZeM4K
	JGNkjjoTVtf8SCW7EAB1yfWf6LOGsl1nSb3IDQvfu6wiA0i5KKkhiDEXOy02Yxgd
	HuOJ1AG1y/1+XwzcQbir9Fu6yqdJjPyHUymQcTq73Brp5fJtu3n3vxbu5sGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718185248; x=1718271648; bh=dHkz5iDLrW4Zn4GHCpQMZUjnuVlL
	VQeo1Q9O6jarAZk=; b=ia4tLqckzWQY2LXhys2Epoi0VjIi8Whz9Q1o/OnxSu3n
	Ucxg9VAxKAb/gFJcQDIH9wAho8IK9v1tzuyhx5RGIIeDV1+uvW/1uw0ZB1lxCAqj
	TxRdGb7xtLqBMIhE9HbhO2kF8TTTo9iaEkbtQFJaMvjbXs1tmpRllYaXle3dQzQ4
	faexSC1tepdWb+t01oELGSzeF2qLPPlUIOq18FH3bE5T1+D1uCaqlBuScl1hLu73
	Qwa5+1d5mabAz4renHZ+prP1Sl5qvjGNsGP2vBhckYfl8jj60sspi5Xf8FAy3/3v
	VEjxkp2uZTWzr9spSo8kE1+Luo2jBpkZRln3dOeQeA==
X-ME-Sender: <xms:IG1pZgCEYuJOUrxp1EoivK8BzkskabS7zSvrJwJHeE3q7d9FX_AbLQ>
    <xme:IG1pZihQgN5aVnRq26RUjlBYHen2wc2Hghb5AHfxiHFOOoGx0nsykiImhRqL-nbyj
    nlWi6jYINnDefH62Q>
X-ME-Received: <xmr:IG1pZjlp5pBl1q7g3GGWocI_hvxv2sOvwrHebLXix2gnr85JRQ7DEPljATgSBy0vl9ZrSLSlggCJYY_2qS4WwFP_7ml-q-7PlR221uvd40OSzk5MffA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:IG1pZmxvE2illOaUI9Wo29RUY4mWTwFQ5PZuiuWl7vm85E4EcJUhZg>
    <xmx:IG1pZlQ9NWL5rwaQGz5h2zf3fZKFehvTbYRyUc58tsLiaKocFso9Gg>
    <xmx:IG1pZhYxG4i4L9CIjJsDjglLNTsmaExS0n-SXAApIi_lxGO7ne3O6g>
    <xmx:IG1pZuQ7kyg9TCWptPV_J9PmbSz_HJeBEiJeggsDcvOYLRB4mW0_xg>
    <xmx:IG1pZndj1Bao4UnMgsGHMgDSFpfdzMa76Exxd8vl_dvjwcwX_ObuPLTG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 05:40:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 259b0c6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 09:40:37 +0000 (UTC)
Date: Wed, 12 Jun 2024 11:40:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 11/16] mktree: create tree using an in-core index
Message-ID: <ZmltHUeuCum4daB2@tanuki>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
 <130413f2404bb27a2ede4fb00041227c90587e8e.1718130288.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LAF6rvpn6MePzu1U"
Content-Disposition: inline
In-Reply-To: <130413f2404bb27a2ede4fb00041227c90587e8e.1718130288.git.gitgitgadget@gmail.com>


--LAF6rvpn6MePzu1U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 06:24:43PM +0000, Victoria Dye via GitGitGadget wro=
te:
> From: Victoria Dye <vdye@github.com>
> diff --git a/builtin/mktree.c b/builtin/mktree.c
> index e9e2134136f..12f68187221 100644
> --- a/builtin/mktree.c
> +++ b/builtin/mktree.c
> @@ -24,6 +25,11 @@ struct tree_entry {
>  	char name[FLEX_ARRAY];
>  };
> =20
> +static inline size_t df_path_len(size_t pathlen, unsigned int mode)
> +{
> +	return S_ISDIR(mode) ? pathlen - 1 : pathlen;

I wonder whether we want to have a sanity check that ensures that the
path really does have a trailing slash.

> @@ -120,24 +137,43 @@ static void sort_and_dedup_tree_entry_array(struct =
tree_entry_array *arr)
>  	QSORT_S(arr->entries, arr->nr, ent_compare, &ignore_mode);
>  }
> =20
> +static int add_tree_entry_to_index(struct index_state *istate,
> +				   struct tree_entry *ent)
> +{
> +	struct cache_entry *ce;
> +	struct strbuf ce_name =3D STRBUF_INIT;
> +	strbuf_add(&ce_name, ent->name, ent->len);
> +
> +	ce =3D make_cache_entry(istate, ent->mode, &ent->oid, ent->name, 0, 0);
> +	if (!ce)
> +		return error(_("make_cache_entry failed for path '%s'"), ent->name);

I noticed that `make_cache_entry()` will skip over index entries which
are up-to-date, and it will replace entries which are part of the index
but with different information. Is this the motivator for the preceding
commit where we start to overwrite duplicate entries?

Patrick

--LAF6rvpn6MePzu1U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpbRwACgkQVbJhu7ck
PpR/xg//UFLMgI+fOuXpMOZ/udisX1Tay47EUIlUi3BBtNUlDBxsm62hFxklrvP8
Sc+TFE50Wz9xmLUSy/m+UcvgJ0MEWFFgSzKjNhZnRvNCJbbKgH5Ede9lKDZQQ3pH
Vijyr3BUSovdl1cPvZD96Hq27ujKAGOScAhBeh5BTmCJ/28Zf2c0GPyeXeaMxP16
NjBJTQFjC/Q6/FRvK2yT63GKeGBlTmgwZI7NoAOYi5S4/8j7fnVM8/am9hdq2z6+
jDhrDeCIz6ODsJ2lHB1mbsX/ooBERWq42wouyOzs2Nj6iX+DG24A6H4aJwbftgw0
9u9MW73tHibZUPi5IEI6qsOC4E0zFxLzReVIbRclAhvVFlVHXlDPmuEPKuEaIwiB
ilOd+bQR3Y2Y1L5PH40N4+BcYzGNa0w5J9OpAOrCsqoYWUxHLbORVXYKjlKJnXgD
6Ny1M2gbMsEoTxWy7/lbk8q6i0CokWyAEmOt920PT58LYr03KJnMM+VYOsmkVwL1
glDIujhnYSL8H9Kz3t3xc5JX5jYYI+YPK5l75wQkTt4o9mS9Iih/8paG5gNJfh2c
6HHlVc7B2J5cO5pgT3P+F06RU91FMhlOoheJfLCD7FIOCLfMpDKiqdsGCwughPZe
e7a9MkW16hod9PpbKKqcc2VY7cH57PLNVnB5XaBLHrVyow1cAeQ=
=rlJ7
-----END PGP SIGNATURE-----

--LAF6rvpn6MePzu1U--
