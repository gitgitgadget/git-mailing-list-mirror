Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B10BF9E9
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712556753; cv=none; b=NKyj0R8dY250xU9cMa1YRKrDPIK/OdyXdhQYecK+AIY2zoS/ZCC5jsSG+q+Te+aSHsxoyBOj5YWcYaMBl4EGJJSPeSflCtTn48xuwgV2xfXkPkT5bZ76HxcaDDMLv1O8FL6xytWewFTIDQl6zdHXX0sN15EcSIDkq2xcilOL0Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712556753; c=relaxed/simple;
	bh=IufhnfHtQvw0aB72T7DMtpTCZ48Jq6NlRR4n/QUrlfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1xDobwYnyBn2yb+vU4d9dKI6Cm9BSi6YkjYJkJP12WOJlL5a2AD8Cy3dbiLWFCtbB9zYcaTTRf90h88XbKH7N4EEVEOitTmpfKZWbOZI1bzFsR16ryN8Dj8u9LxEy9qHdDkADWPYeMrZz4kyFeQ71zV8t/NTtEIVOQ0caKykCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iHs6sk1I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cu9jp3VB; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iHs6sk1I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cu9jp3VB"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 565EC13800A9;
	Mon,  8 Apr 2024 02:12:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 02:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712556751; x=1712643151; bh=SNu/+5+YNy
	5dX/kfuKhYNDYla5nlos323F+ag+v8qnM=; b=iHs6sk1IDFxOr5kggHptdUcK9X
	0hgWS6QGQuRFC1uutdiFwJeCCTowH3NmrddB/Hj5cmnnjguJvw7qLZaUSUTcjBx7
	HCW3NYmlSzJvl+1k8j5MQCC0+oKGlrSt0npzTRMO+l4Yv48sMiTpA0AIr2+SHRtS
	spDU86dlRgnvbu2VlsJiqZz48jam+s95hvAnR4Vqe30JmZvBWSI4jVzvndLk4lpn
	4Ef3CA/YW2DGtZ6KMcPMl7IoxC2JVwbFL8di93IRzl565GRCUnvGW3uX27hq/tsS
	Bj9i4Z+mfgWuQxT30DISuLAChmr/TyDsfgP+tdjAY9wkaaLAfI1wiEn3sV2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712556751; x=1712643151; bh=SNu/+5+YNy5dX/kfuKhYNDYla5nl
	os323F+ag+v8qnM=; b=Cu9jp3VB2/QPxmmoAVEykITWe+xzcIu7zAPG6LMM0K81
	AXn5CdNreB4M4AwR49f/EWpDYncdzdjizd/+UzAm/XHBB7S7IdVy9a8eRChmjlIU
	X9I90p7/aJ6rJMY1U5Le63nOILgrLg6q2TcnsjoRWcHdzqSsb8pIL55GDmL0kXNT
	7eXoJ1b83IszFkH6TKp64odawoB30DENEK+x0M1ecnqyIy/QV0m5vT/d5Ilzuh2e
	umRnCH/nFRqNmLu5CdJ2MMXrq+TXimKjS4g0KlqGXHmQqFO1KdMXE7Xhflc9wKZA
	PVo55OzNTtx3rxztfQ6xdglavxRmGEZxAagVYAn0uw==
X-ME-Sender: <xms:z4oTZsWhlpWwacOuRiARvvESSRZea-4MStysY7CXqrvaxN13xu2Fsg>
    <xme:z4oTZgn7C0ZPLMR47hN-nozpzKyXINljhMyBs8e-bKXUBNIGYNa88KqQ9fPh1liLK
    pG8VFK7Z0k_iNhfDA>
X-ME-Received: <xmr:z4oTZgZRUMgMw1iV-iank1K9wpH4WE5fjrdBnIQtYnHRLBvHLdYF_901J3B1OcUWXj9z6jK_2XGh60qVRH7VzrDYvPFu-Xnoft5wk48471d39h3tQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:z4oTZrVPaZ0QOJeDnIjJWZKLtR0f87inX7omB8kOhAPdy0u0hfaK_g>
    <xmx:z4oTZmlSk1CgMzmlvHxWcEg9HPlMJt_Gij4KCrG8FEw-1txzrqLnsg>
    <xmx:z4oTZgcJdzLwgPbxqmGsXdMcTS3dKqAR_H_OGQCRLKS5zqyKej---A>
    <xmx:z4oTZoGz3EXkJGgDSnjO2Hv_7-uLLb_idkwss23EoILxRv1x6r2_Ng>
    <xmx:z4oTZtvCGrNKhR4EuBRPOomSjauYaANJr-mwsD5U_9LE4BI5hJOj3u5v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 02:12:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 639404dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 06:12:24 +0000 (UTC)
Date: Mon, 8 Apr 2024 08:12:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v5 1/3] reftable/stack: allow disabling of auto-compaction
Message-ID: <ZhOKy5W5e11ce2Rd@tanuki>
References: <pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>
 <pull.1683.v5.git.1712255369.gitgitgadget@gmail.com>
 <a7011dbc6aa5cb256957bda5456ca989ce75e4a5.1712255369.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M6MWGD9YTBsFdFQg"
Content-Disposition: inline
In-Reply-To: <a7011dbc6aa5cb256957bda5456ca989ce75e4a5.1712255369.git.gitgitgadget@gmail.com>


--M6MWGD9YTBsFdFQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 06:29:27PM +0000, Justin Tobler via GitGitGadget wr=
ote:
> From: Justin Tobler <jltobler@gmail.com>
>=20
> Move the `disable_auto_compact` option into `reftable_write_options` to
> allow a stack to be configured with auto-compaction disabled. In a
> subsequent commit, this is used to disable auto-compaction when a
> specific environment variable is set.

This patch looks good to me. I think the commit subject and message
could use a bit of polishing though: we do not add a new way to disable
auto-compaction as that already exists. The important bit though is that
this toggle is purely internal right now and thus cannot be accessed by
library users.

I'd thus propose something along the following lines:

    ```
    reftable/stack: expose option to disable auto-compaction

    While the reftable stack already has a bit controls whether or not
    to run auto-compation, this bit is not accessible to users of the
    library. There are usecases though where a caller may want to have
    more control over auto-compaction.

    Move the `disable_auto_compact` option into `reftable_write_options`
    to allow external callers to disable auto-compaction. This will be
    used in a subsequent commit.
    ```

Patrick

> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  reftable/reftable-writer.h |  3 +++
>  reftable/stack.c           |  2 +-
>  reftable/stack.h           |  1 -
>  reftable/stack_test.c      | 11 ++++++-----
>  4 files changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
> index 7c7cae5f99b..155bf0bbe2a 100644
> --- a/reftable/reftable-writer.h
> +++ b/reftable/reftable-writer.h
> @@ -46,6 +46,9 @@ struct reftable_write_options {
>  	 *   is a single line, and add '\n' if missing.
>  	 */
>  	unsigned exact_log_message : 1;
> +
> +	/* boolean: Prevent auto-compaction of tables. */
> +	unsigned disable_auto_compact : 1;
>  };
> =20
>  /* reftable_block_stats holds statistics for a single block type */
> diff --git a/reftable/stack.c b/reftable/stack.c
> index dde50b61d69..1a7cdad12c9 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -680,7 +680,7 @@ int reftable_addition_commit(struct reftable_addition=
 *add)
>  	if (err)
>  		goto done;
> =20
> -	if (!add->stack->disable_auto_compact) {
> +	if (!add->stack->config.disable_auto_compact) {
>  		/*
>  		 * Auto-compact the stack to keep the number of tables in
>  		 * control. It is possible that a concurrent writer is already
> diff --git a/reftable/stack.h b/reftable/stack.h
> index d919455669e..c862053025f 100644
> --- a/reftable/stack.h
> +++ b/reftable/stack.h
> @@ -19,7 +19,6 @@ struct reftable_stack {
>  	int list_fd;
> =20
>  	char *reftable_dir;
> -	int disable_auto_compact;
> =20
>  	struct reftable_write_options config;
> =20
> diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> index 351e35bd86d..4fec823f14f 100644
> --- a/reftable/stack_test.c
> +++ b/reftable/stack_test.c
> @@ -325,7 +325,7 @@ static void test_reftable_stack_transaction_api_perfo=
rms_auto_compaction(void)
>  		 * we can ensure that we indeed honor this setting and have
>  		 * better control over when exactly auto compaction runs.
>  		 */
> -		st->disable_auto_compact =3D i !=3D n;
> +		st->config.disable_auto_compact =3D i !=3D n;
> =20
>  		err =3D reftable_stack_new_addition(&add, st);
>  		EXPECT_ERR(err);
> @@ -497,6 +497,7 @@ static void test_reftable_stack_add(void)
>  	struct reftable_write_options cfg =3D {
>  		.exact_log_message =3D 1,
>  		.default_permissions =3D 0660,
> +		.disable_auto_compact =3D 1,
>  	};
>  	struct reftable_stack *st =3D NULL;
>  	char *dir =3D get_tmp_dir(__LINE__);
> @@ -508,7 +509,6 @@ static void test_reftable_stack_add(void)
> =20
>  	err =3D reftable_new_stack(&st, dir, cfg);
>  	EXPECT_ERR(err);
> -	st->disable_auto_compact =3D 1;
> =20
>  	for (i =3D 0; i < N; i++) {
>  		char buf[256];
> @@ -935,7 +935,9 @@ static void test_empty_add(void)
> =20
>  static void test_reftable_stack_auto_compaction(void)
>  {
> -	struct reftable_write_options cfg =3D { 0 };
> +	struct reftable_write_options cfg =3D {
> +		.disable_auto_compact =3D 1,
> +	};
>  	struct reftable_stack *st =3D NULL;
>  	char *dir =3D get_tmp_dir(__LINE__);
> =20
> @@ -945,7 +947,6 @@ static void test_reftable_stack_auto_compaction(void)
>  	err =3D reftable_new_stack(&st, dir, cfg);
>  	EXPECT_ERR(err);
> =20
> -	st->disable_auto_compact =3D 1; /* call manually below for coverage. */
>  	for (i =3D 0; i < N; i++) {
>  		char name[100];
>  		struct reftable_ref_record ref =3D {
> @@ -994,7 +995,7 @@ static void test_reftable_stack_add_performs_auto_com=
paction(void)
>  		 * we can ensure that we indeed honor this setting and have
>  		 * better control over when exactly auto compaction runs.
>  		 */
> -		st->disable_auto_compact =3D i !=3D n;
> +		st->config.disable_auto_compact =3D i !=3D n;
> =20
>  		strbuf_reset(&refname);
>  		strbuf_addf(&refname, "branch-%04d", i);
> --=20
> gitgitgadget
>=20

--M6MWGD9YTBsFdFQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTisoACgkQVbJhu7ck
PpS9xBAAmoVo8IGtdCoR/7W6xr5Mh9ezyALW0aiNNWANludC6erUhhG9qmnrcFO1
qAitN33Z22mZ6H6AB9uxggffbzI8A/5ylu3Mfxp9n+owYqD9zp9B1bWFGu19gr+H
qiy3kbyTTEjoaqrkAtvpcB3KiGSjD7NTo5ycnlxJlj+BHfthRIESJhd6U0RcL7My
ocIdEuusqpZgmXBa8oBmeyg7ifKzjhDol2lnGAyvsOGSQeR5ftfsDyadL1rJyh2+
e44eF6SEviYBBIYCylSs73wKFMvb2rH1mjbiv8ikRYTcuP4sv8Cc9hyVNntBD3j9
xUMDf4ttaJpB3pMi8SX49saJPBHaCprw75X5htzAT6eNmmIPEPgqdH3ZmTknNS/k
hYFSIi/emELwAA5o064wNXabXVQOGj/tw/xHFU4YpAzkqktIThccXGHkAYYSotWT
pNZP85gUL116x4Rlb9NzQSoNkRq/K4UoAG1MCF/lPSng5JDXDwKl0xaBp4UEYAYZ
dKqQWeRBsnuND1+HVSt8yUTG/l885cpK4up6EltLkggPRsj11gVuwBlhDcRfX7nF
04LI/aRkfsei3nEKRTe7U+uX3mdJZgix1chNuXKIQ7JShRd7xHO5QkwyTED+bZsZ
V7TTR1gDoTSQx8EWK7JHkTV4f2uspPDpXG0TJavrn6+ylD/4PpM=
=rs3j
-----END PGP SIGNATURE-----

--M6MWGD9YTBsFdFQg--
