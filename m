Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB1F7581A
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519641; cv=none; b=W9j4sESNIZgEyVkfj8/MvQ0SBsS8VSbi+VWXmEkaG/CtIHZt0NsSDbaIaJoF+RZx1gY48SbauzQIuRbJzXAsHucaQydU10lVWNpM90BQHq8OdYWgbZ394y6ydgIuMrv0rUFovBBMEpX+0WBlU7v6svFkZVD8Q/IsLapLADClXrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519641; c=relaxed/simple;
	bh=QkkYpSg4Msx/o8wXQC3Q+iPiRAOt2jEpmNEt+5327ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKxO5VMHMq5hFoRDu8EHGE1but9xkWYNJpOs37JVrYwyNRhmxP3Q0ZY3b3HhnPg1MxOoEdFF9Lmkr/qXJ2xuk9p1tQa4Xf7xhjUpr2NUHodXVU0E6g9sCaQ/mQ03ga5bEuSbvkHmQK9WQonHmRpSBcfyDhxVs6a3QyKFLFmjEy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DIFWGON3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DPSx9wGQ; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DIFWGON3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DPSx9wGQ"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 21F9D1C00123;
	Fri, 19 Apr 2024 05:40:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 19 Apr 2024 05:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713519638; x=1713606038; bh=/hY+7lEMMx
	vl8uwsF8JmV+2BWyc8Zew3r1yHQ0l82lk=; b=DIFWGON3obvHbr6kesxLow8UQz
	QrM6RlOqCqIA5UKLm2/QeI1lOeki2EuLFhgU34IMxmfojEOkrJJxJYUVj56a8qHY
	gZbPSARPRsBox1tnjTBoiVRKu7fByTh/vM9XykTh5L4oFf1xuU2S/2Z1tHKw6j3D
	bMqT9lpcvXH2SBEWL4VcOYkWjaNvwk4YhMai9BW0DhsFZW+E3VX1IrC+5v5huOBh
	rq/Y/uYa3yO1yjF8iKo6bz3Yo7Ryh0Qu0Gmt7qjb16r4VtY7895TBxHCzGTyl0jB
	0wEXTaapTDC/zH8GKqcafbEjTyVxRqZeLXA8+mrxNHKD8ohR1WY/9XecUTLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713519638; x=1713606038; bh=/hY+7lEMMxvl8uwsF8JmV+2BWyc8
	Zew3r1yHQ0l82lk=; b=DPSx9wGQgTm7bzjMeFdxcK4eIH11PQ0kFBDfnK4YsTQq
	1+jZeRtb4snABEFgi8y9WtNK10S9fXBcEpLywcJICvUfWyiWDk7PCvYQCgsumzFL
	myWVe6WCEdCU5E1jEVEuDkmDSnII5moVnc4yPlJj02L7GEvWuYo9D2EX5wA9jGlF
	4/NoeVPrgUQQZBztF8kE4jdmt0VUEjY5mIZdtlw1amlJ2XM2BZ6uRVEr7OOPTZTj
	6Zg4PovfYO8ggKhq74bhVZizYKzcM7nHYtDeV8WF3IID5x+7vGNEZH8U3IR4MSgU
	vV4LDrrAaVqGjQPuJT9/PrOiOOcRp4ZnUKpDilNy4g==
X-ME-Sender: <xms:FjwiZjEBqFxuFpWEEodtkqlZp8iYkUwyprv9AeT4KNGlYBB0vliJog>
    <xme:FjwiZgWkvEPsWGr7OEOEJtM-YLLvz5k1FcUvyasXUX5vuOrK6ywKUQ1gDZD6VUGNO
    _kCV-9TxaONnrDqXg>
X-ME-Received: <xmr:FjwiZlKsqtRvKSF_1wkPm96Aw41KB3OP0hoCyiJE3EG5zUYDTO_hAPWYtLU5MjhNPiDRUg-xEG9ypwhs4gRC5ezn1jLzLkzjpTFHQ_HYA0IybxGoaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:FjwiZhF3-B9M2PmSK-NwsxEqGXCahsPHUFP11jIOhKlclJfXYVfG4g>
    <xmx:FjwiZpW8s5Wv_kHDLL456wgE-f1Go0ZwWGx1Mk-srKFg-V_5dgYgOw>
    <xmx:FjwiZsPFN8mx4CzrbWeGV8kjb6D460OKLKdxwL-hTtBDD5ukCQ-ndA>
    <xmx:FjwiZo33zaSiVk0775WyWkiqEcoRGlGPUnIR8HNfmK1Xulmev-xCAA>
    <xmx:FjwiZvwKoNpQH6tmebC1DLgT2ZX0g-GkbMz8nxKeFYEdMHjY1iRf4IrD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Apr 2024 05:40:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c8266c4a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Apr 2024 09:40:10 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:40:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 3/7] update-ref: add support for symref-delete
Message-ID: <ZiI8E2ZJT51akoAk@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-4-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="orAGAOG21y/Ysow6"
Content-Disposition: inline
In-Reply-To: <20240412095908.1134387-4-knayak@gitlab.com>


--orAGAOG21y/Ysow6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 11:59:04AM +0200, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
[snip]
> @@ -302,6 +302,37 @@ static void parse_cmd_delete(struct ref_transaction =
*transaction,
>  	strbuf_release(&err);
>  }
> =20
> +static void parse_cmd_symref_delete(struct ref_transaction *transaction,
> +				    const char *next, const char *end)
> +{
> +	struct strbuf err =3D STRBUF_INIT;
> +	char *refname, *old_ref;
> +
> +	if (!(update_flags & REF_NO_DEREF))
> +                die("symref-delete: cannot operate with deref mode");

Again, I'm a bit on the fence regarding this restriction. I feel like it
ought to be possible to delete both plain and symbolic refs in a single
git-update-ref(1) command.

> +	refname =3D parse_refname(&next);
> +	if (!refname)
> +		die("symref-delete: missing <ref>");
> +
> +        old_ref =3D parse_next_refname(&next);

This line is indented with spaces and not tabs.

[snip]
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -1715,6 +1715,45 @@ test_expect_success "stdin ${type} symref-verify f=
ails for mistaken null value"
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success "stdin ${type} symref-delete fails without --no-dere=
f" '
> +	git symbolic-ref refs/heads/symref $a &&
> +	create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" &&
> +	test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
> +	grep "fatal: symref-delete: cannot operate with deref mode" err
> +'
> +
> +test_expect_success "stdin ${type} fails symref-delete with no ref" '
> +	create_stdin_buf ${type} "symref-delete " &&
> +	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
> +	grep "fatal: symref-delete: missing <ref>" err
> +'
> +
> +test_expect_success "stdin ${type} fails symref-delete with too many arg=
uments" '
> +	create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" "$a" &&
> +	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
> +	if test "$type" =3D "-z"
> +	then
> +		grep "fatal: unknown command: $a" err
> +	else
> +		grep "fatal: symref-delete refs/heads/symref: extra input:  $a" err
> +	fi
> +'
> +
> +test_expect_success "stdin ${type} symref-delete ref fails with wrong ol=
d value" '
> +	create_stdin_buf ${type} "symref-delete refs/heads/symref" "$m" &&
> +	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
> +	grep "fatal: cannot lock ref '"'"'refs/heads/symref'"'"'" err &&

You can use "${SQ}" to insert single quotes.

Patrick

> +	git symbolic-ref refs/heads/symref >expect &&
> +	echo $a >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success "stdin ${type} symref-delete ref works with right ol=
d value" '
> +	create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" &&
> +	git update-ref --stdin ${type} --no-deref <stdin &&
> +	test_must_fail git rev-parse --verify -q $b
> +'
> +
>  done
> =20
>  test_done
> --=20
> 2.43.GIT
>=20

--orAGAOG21y/Ysow6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYiPBIACgkQVbJhu7ck
PpTcTQ/9Go+U4mojEuw/l0/DXFdmG13m/hxMJUal6vUrSFixuE+lMcZEicHqC78b
ZCHaF9j6O5QpQ800sm7luBcCVSHW2XPCrvlu0xB4V1kldEjnioTZQmHiEe5pZsvO
5Ynvc1x7eRwOS8TrT6EZnFy2ZyzUwRPqgfUxCpGh49oOul8gyCb2QazCOiMo8ZSJ
ohM16NKJ2uGnZQ63JFRUU8ZbUeGpM3h2dH3XZeFNT1rIXA85D0O7sOn5XsFgLmM5
gNGJ8xU5cJljE6oYgzzFfcuQ2/pdcppqV6osfxTDtAQngKNfGw2YeLCCWAfNjYpb
Bg2py5U8z9I3hLU+PyKZolQIQ0NOQf/QqemPbsTTsIUzcuzUqlQKaV2dvMHrZliA
OYlg13MlPFWbUO+72Gl+7B47t/yXUNlP4ZBe17Hzb8lDK09AHwtEt5KH1KO8NdVn
4KIdcmMdkugUmKT6ucujeqgBG5bRmnZkz5Zre0B5K/VTqsAKVq3URqjEXZO6PrYz
CjBGS1WjYYRunF5Av4agi0Cps29zjstxh+wP7g6sy5pYBXx0S1RTVOdcA53VkgoE
b4an+QtZ0/4zxnZGeCi8qJOBIhOMkQF2fFRIGZIQFr1w4LB11WZxLNKQ8u5UZKes
WXunFuvJKs2Wt+lZg6n9XqxMFLEZ0rDvecgMkGl9x+STRVvlQ9M=
=ZDtw
-----END PGP SIGNATURE-----

--orAGAOG21y/Ysow6--
