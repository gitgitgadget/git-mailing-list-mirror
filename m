Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424CE176ABB
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097078; cv=none; b=GgjH4ZcJ3PHYisT0yPBOIxTMiclRH74VmRRCSEMOvziuJlAT+mBKt61XqtlJT4aWRsf8c3h7stXYNj+rRNf9H+mC6O6npQFw58eexeK1c9cIblKvwOvBpDDmC7fGTAiLEmys1RywN1U1vaksKIqxwxqg25qMBT1Qj1yDFVFfgpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097078; c=relaxed/simple;
	bh=CjeZ2ou3FaBakv+VnVw7okm9pkGZFHcpetKzdl4O9OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvSXoBuwqo40VrLKLWj+/Nz/3AVxKdxI5ZuP0FuMhfSTKmgPO+1sU2N/9bqIFyz5IhdpUHl66opoqDWGwUvoH/pQYzd33RakttrmLHuKh0JQO/oEgYP2lwAlrJ4pAh57yfXaocs/5YdCciWNjlsS3YCb/HgBggrJzNNJcBhLon0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OCxjTDyo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l3VYdmY5; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OCxjTDyo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l3VYdmY5"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 29DCB1C000BB;
	Tue, 11 Jun 2024 05:11:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 11 Jun 2024 05:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097074; x=1718183474; bh=EG8EmdohGt
	piAQ3dC5/sQaJDPOEx800NWa6I4WHyyok=; b=OCxjTDyoe91lI3uuG1wxNwKmWI
	qfSGBf6lbpYWdjQ8pPl3htkbohxWRwGkTIdg3TnYYfGPGM7Wqv1CbJoGh2UGd8VS
	6FR+jn4Dr0yTicTWszchrcISJ6PqxWXZrAOhIwWpym0Qb2wQnyjTG/cyw923JMJb
	05FpcOx0ZtY0Oi/T81/IhynKFFwbfSAOQdUk3ZUSxrw/DEgeff/PNSDfnr8R0Awk
	3IYUuZvBFzEL3zmZA4qlcMxhPQvTTCVypFrPxwzMilg7qEjOt88o5N5KM/w40hqX
	O/IPGvPsGDab0o4Lf1zYaubVjGJVBfQTHgy4N3WiciWkxv4AqHG957HzofRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097074; x=1718183474; bh=EG8EmdohGtpiAQ3dC5/sQaJDPOEx
	800NWa6I4WHyyok=; b=l3VYdmY5kcMdR9ZAAgzW8hnTTxFbBqwea9/ZjdaSDrZj
	cs+SSqh08f02dp8gtqCXZGvV0GYNHgiS0nXi/UqvR97bHRCFNE066tTMjJCN/Pnw
	wXUImWYkMEJRVuKJ8nzcsM4pBGLPUyUFfdcrgfzrA5L6VEC+YQfF3p7u8XBUXmx+
	HR8xTFmGtIOvfLqSPp1Avk8I/LAKysr6LAXIOhmjoyagxhdjaJSLthMBguY3jJ3J
	v0h1iFVN3jkt8t0R2WXaACYDvAc/jQ6ht8D42KwnBf+dBpYt855S1kqHbvzlK7NX
	2OyhDZANcxNulizNQ+KPzwc2fJb/M2rJqZMdFDeE1w==
X-ME-Sender: <xms:shRoZuCd0cwA8Ya7W_wzFVsHUItVjpzYY-YJGrr78SnAwD47ndYj1w>
    <xme:shRoZoiUjZtraL0DedrJgzOsJDDJE2E7cbsK3N00sPwErfXMATkxVwuXnSRNTslre
    l9S17JAZDmUjGGZVQ>
X-ME-Received: <xmr:shRoZhnGekPn-p8CuGuR1wiXc01B0PvQCJ8LAY_iQdyhomIAI8r-Y509AiXCE_oUFTx4J-l_kh6BXcLbuyjXPV5trVuD6ACB21G_1b3pNrfN8StNv26Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:shRoZsw6MJvGhcZU2v3hfDsHEf9RQBOkeFfQn7NPD0uxCfZ_ImEpww>
    <xmx:shRoZjQVsMBUITeFjpKBm6WwCFPLNMHHC8ACV55ULzCW9_9VJL349w>
    <xmx:shRoZnZb3GIUNFT75JL3tdE7Toouv0StREln_UOScLlS5Aj-9i6tnA>
    <xmx:shRoZsSGZClixq_hSbFDETchvvgbc-wKQbJZPYZFtpXwR5w3g76VpA>
    <xmx:shRoZkJyOFpVFMtieKoiENhdvvKjZQ8NGppxJ9Il8y5m4sGrEDLCH-zg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:11:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7ab61377 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:11:02 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:11:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	blanet <bupt_xingxin@163.com>, Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v5 3/4] unbundle: extend options to support object
 verification
Message-ID: <ZmgUrQ6D1xtQghPy@tanuki>
References: <pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
 <pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
 <0a18d7839be67d6c0be137c7e15dff9663a161a8.1718088127.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P3/h/apMqnYNsong"
Content-Disposition: inline
In-Reply-To: <0a18d7839be67d6c0be137c7e15dff9663a161a8.1718088127.git.gitgitgadget@gmail.com>


--P3/h/apMqnYNsong
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 06:42:05AM +0000, Xing Xin via GitGitGadget wrote:
> From: Xing Xin <xingxin.xx@bytedance.com>
>=20
> This commit extends object verification support in `bundle.c:unbundle`
> by adding two new options to `verify_bundle_flags`:
>=20
> - `VERIFY_BUNDLE_FSCK_ALWAYS` explicitly enables checks for broken
>   objects. It will be used to add "--fsck-objects" support for "git
>   bundle unbundle" in a separate series.
> - `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH` is designed to be used during fetch
>   operations, specifically for direct bundle fetches and _bundle-uri_
>   enabled fetches. When enabled, `bundle.c:unbundle` invokes
>   `fetch-pack.c:fetch_pack_fsck_objects` to determine whether to enable
>   checks for broken objects. Passing this flag during fetching will be
>   implemented in a subsequent commit.
>=20
> Note that the option `VERIFY_BUNDLE_FSCK_ALWAYS` takes precedence over
> `VERIFY_BUNDLE_FSCK_FOLLOW_FETCH`.

Thanks, the new sequence of commits is much easier to follow. It also
shows that there is no user of `VERIFY_BUNDLE_FSCK_ALWAYS` at the end of
this series. So maybe we should drop that flag?

If you do that, then I'd also propose to merge patches 2 and 3 into one
given that both are quite trivial and related to each other.

Other than that this series looks good to me.

Patrick

> Reviewed-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
> ---
>  bundle.c | 10 ++++++++++
>  bundle.h |  2 ++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/bundle.c b/bundle.c
> index 95367c2d0a0..53ac73834ea 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -17,6 +17,7 @@
>  #include "list-objects-filter-options.h"
>  #include "connected.h"
>  #include "write-or-die.h"
> +#include "fetch-pack.h"
> =20
>  static const char v2_bundle_signature[] =3D "# v2 git bundle\n";
>  static const char v3_bundle_signature[] =3D "# v3 git bundle\n";
> @@ -615,6 +616,7 @@ int unbundle(struct repository *r, struct bundle_head=
er *header,
>  	     enum verify_bundle_flags flags)
>  {
>  	struct child_process ip =3D CHILD_PROCESS_INIT;
> +	int fsck_objects =3D 0;
> =20
>  	if (verify_bundle(r, header, flags))
>  		return -1;
> @@ -625,6 +627,14 @@ int unbundle(struct repository *r, struct bundle_hea=
der *header,
>  	if (header->filter.choice)
>  		strvec_push(&ip.args, "--promisor=3Dfrom-bundle");
> =20
> +	if (flags & VERIFY_BUNDLE_FSCK_ALWAYS)
> +		fsck_objects =3D 1;
> +	else if (flags & VERIFY_BUNDLE_FSCK_FOLLOW_FETCH)
> +		fsck_objects =3D fetch_pack_fsck_objects();
> +
> +	if (fsck_objects)
> +		strvec_push(&ip.args, "--fsck-objects");
> +
>  	if (extra_index_pack_args) {
>  		strvec_pushv(&ip.args, extra_index_pack_args->v);
>  		strvec_clear(extra_index_pack_args);
> diff --git a/bundle.h b/bundle.h
> index 021adbdcbb3..a39d8ea1a7e 100644
> --- a/bundle.h
> +++ b/bundle.h
> @@ -33,6 +33,8 @@ int create_bundle(struct repository *r, const char *pat=
h,
>  enum verify_bundle_flags {
>  	VERIFY_BUNDLE_VERBOSE =3D (1 << 0),
>  	VERIFY_BUNDLE_QUIET =3D (1 << 1),
> +	VERIFY_BUNDLE_FSCK_ALWAYS =3D (1 << 2),
> +	VERIFY_BUNDLE_FSCK_FOLLOW_FETCH =3D (1 << 3),
>  };
> =20
>  int verify_bundle(struct repository *r, struct bundle_header *header,
> --=20
> gitgitgadget
>=20

--P3/h/apMqnYNsong
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFKwACgkQVbJhu7ck
PpQRdw//UmKycynSY01FnFBfcakpdm+xGu5tKBWPWO29yJcrlJBsjYYnwwTw0QNS
8J3B1yfzNxGy6DvzpqbvxAYaBhhuOwKbWjBIJa7WvqoHhzNw/NclFusH42r4Jfmt
xXhdpLD48pYmnuwJzTnZokxhCiwt58T1QEOixx+6mTmaUMR0Qp3Nt2hxKBzVcJBE
O6i/h/31A+G8KOa4lruCzcTXathnLTIKQlbFOFIZpMt7k13BDQd2lUamf9RbjrF+
cXr80FZAy9ULYFts5Jd5E3a9788Y4QXtgvhPkvB7240eOXuEO7xHrmnRaT1RsgBS
YhCVJMspYm/7zX6Hxjn9LLdg9j40tlZnbdqw2ezJczWW/VJBCPR3+tbptZccD7cS
pne0i7TVjDAp1ZUgFVmxQFTkPf0BO19D0bnbYReYKKq3F15N5K7zsbWIXid8nmbj
nO/LB5HuggG2BsIgkz93wGGW6p3rd2QS6U8Z1ZOsvfOIEraBZZzMr5YcbLyqHJX+
+iSvtM4K381YfQb3yNKkEo2/YN20an/yJjzeRx4E94GEYXb2QWtTP1tkF+ytnGd3
TSrDUr2/jiJ/i40/XAx+8gXBPoeWKBDqVaFYSzo3NWSemvnznidAlt4BADk1TfKr
KJ9g6dLcoSpVdikiXPJAZsqJh5gtiZn0LWo0VUNl2QB5ppRICag=
=u6gR
-----END PGP SIGNATURE-----

--P3/h/apMqnYNsong--
