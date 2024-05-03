Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618D1F951
	for <git@vger.kernel.org>; Fri,  3 May 2024 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714719415; cv=none; b=Z9bR3rgSJNPZtFwG586lawSF0cdPonOLEPdjBqfIW1p2gZu9+N3pnS/HSHQzJLbBvDrGAi0ptQlZ7ogfbzr3Gs5GWl7M8HciWnhFYSpZPuf5WlJvy9WZ9FVuJi0TpY7+RyTqq3QHr6TZ27M1N5bO9wBQr/z1EnBwqbggvOTZL9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714719415; c=relaxed/simple;
	bh=OG4q3Jr4UNdAgKsard/dsE1DKOTRWYb6eowg+E0xg2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMtujVDvdQ9HwHSUuaKUUFK6AB20W80+SJgbbIefUpW+VBzIqTNgB1R3FK5yXAVJO5wBM76sNyBoGL01YJlB/TjOhsQxWRyWLnBjh0QqmHjs+NnDeMqlRyaPweSgtkNWfnqbtIW8JMVHDD/1vSZ9VgC9GMBi3aQyODE5YNXmvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lRfGeON5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kzLIo+K6; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lRfGeON5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kzLIo+K6"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 44D491C00149;
	Fri,  3 May 2024 02:56:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 03 May 2024 02:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714719412; x=1714805812; bh=yIj8xR1YYp
	wqf46KghtX68IWXrPnD97KBumWYRHL1c8=; b=lRfGeON5ywDXXHhRMx6+ff15oO
	kujHAOLnvcDusy+/FzpC2N13LYLqRA7pOxWFl0FDLnDcVHgEQFywzLqAYTvBoGKV
	+qijSwK/KH1Ax1tgaCORETfsab9VFVHctmSC1y1PB/fkxMDg5Xu+mAOKnwAQI1RB
	2SjVD+POkpbfuGecMpCAWT6SJ95J+qHtAAFyqGTRkE/PEeSvRmEaZMSuqwYPK6nt
	jTleaYPIglLoLgmYtemrK3mDjzaMxtw2iPRBWso4WqySeh2NyKZZfYNPg03ik6ww
	M70JOeVJMVihEhNjKM6VfwoblWwHMxOYMZUpljGz+d/r5IP7/pKD9koa8QQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714719412; x=1714805812; bh=yIj8xR1YYpwqf46KghtX68IWXrPn
	D97KBumWYRHL1c8=; b=kzLIo+K6o03SwcCOquZWvU0piIcJtdEYUm2zqcSL1g8l
	3OPtkW6rF408pN6LJZifr4+1YzhIGDHL2YI4JvQVYP3VVtwnFGYVbDNxkKQuhugk
	m41xhJKsST6gg4Z34HV26xtDDu/dWrDDQrs90umbY3i9PM2RPHXZ4vQIRwOAhtcJ
	Du4uVs6JGnMxDbiZNOhIrVwasStouq9LVobatVESgUQY1SS2Ax/E9ENyV1VH2oyM
	yIwJmOmP6nKJqEoCNRyjmf2FlP/jXEscmPGXFCQVVM/FMx+V11eKhploUKkl58Rk
	YAyFJDjkR0Rgzvl3Yo0gyipruUBFsAGIstxYL1V/Uw==
X-ME-Sender: <xms:tIo0ZkqruDDoauq-NhmVqMJ5kGlYCIAVNgjO0psk53_ZlY8P71epmw>
    <xme:tIo0ZqqGswSvAtCtneIOCY6hqDQs2V5mCFGtJelTEjpEGjZNsu5FiE3WxDeI0rPr5
    OyHzqqzsK7C8Syo2A>
X-ME-Received: <xmr:tIo0ZpNqhdNTQPTPBQELvWZqa06Qo9COhZr3f3UhQX7kgMT0NfjU3g_fdBXsKpaYW0yW6oRcTyR6DZPAmLmTxiXya_V_WK_lNtEU3hgWHmYdfaW9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduledguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:tIo0Zr7e9euYSLFFXC5uvfWWDUKeglmDwVyVggK5-0_FkmaI_Xn53Q>
    <xmx:tIo0Zj5POrWPgY5uWsO20IG_1lcG9gprvnJqN7HopQhmrYW-uYK9QA>
    <xmx:tIo0ZrgNFN_4pWYK5mdlubgPfnP9CZtMBQmaeLJBzUlWUD57gEZuXQ>
    <xmx:tIo0Zt64Gqjvdk7mDtZCNehvT8DBgwSlR0RgJIIUPN3FR1Yoeavz5A>
    <xmx:tIo0ZjHGfEa2JiNgxynidWoaAqpSzijKTBIgzsB9f5E79XewBmV6Q2yX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 02:56:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8d867d59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 06:56:23 +0000 (UTC)
Date: Fri, 3 May 2024 08:56:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/5] ci: make the whitespace report optional
Message-ID: <ZjSKsGooraoQDU2I@tanuki>
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240502193840.105355-1-jltobler@gmail.com>
 <20240502193840.105355-5-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MxCn6eBeRYpRsA9q"
Content-Disposition: inline
In-Reply-To: <20240502193840.105355-5-jltobler@gmail.com>


--MxCn6eBeRYpRsA9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 02:38:38PM -0500, Justin Tobler wrote:
> The `check-whitespace` CI job generates a formatted output file
> containing whitespace error information. As not all CI providers support
> rendering a formatted summary, make its generation optional.
>=20
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  ci/check-whitespace.sh | 45 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 12 deletions(-)
>=20
> diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
> index f57d1ff5f0..fabd6ecde5 100755
> --- a/ci/check-whitespace.sh
> +++ b/ci/check-whitespace.sh
> @@ -1,9 +1,20 @@
>  #!/bin/bash
> +#
> +# Check that commits after a specified point do not contain new or modif=
ied
> +# lines with whitespace errors. An optional formatted summary can be gen=
erated
> +# by providing an output file path and url as additional arguments.
> +#
> =20
>  baseCommit=3D$1
>  outputFile=3D$2
>  url=3D$3
> =20
> +if test "$#" -eq 0 || test "$#" -gt 3

That check is wrong, isn't it? Based on the usage below you either
accept exactly 1 or exactly 3 arguments. But the condition here also
accepts 2 arguments just fine. The following may be a bit easier to
follow as it is more explicit:

    if test "$#" -ne 2 && test "$#" -ne 3
    then
        ...
    fi

> +then
> +	echo "USAGE: $0 <BASE_COMMIT> [<OUTPUT_FILE> <URL>]"
> +	exit 1
> +fi

Ah, you make the output file optional here. Fair enough, then you can
scratch that comment from my preceding mail as it did serve a purpose.

Patrick

--MxCn6eBeRYpRsA9q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0iq8ACgkQVbJhu7ck
PpQ5jQ/9FWLEaBdMabtgNGtAr39IlFFh5emTo1Nz6A0zzW0HAkpcQ7wwOKA4ngql
l82AeKed7uHdUH7PM9fkxmBgVGuCfqXsrXV726AiPSAR31UMC64vh33xhTNnqR4Z
a7cwJhK65W0szwxbidYCRD9AZ/ki2aw8pYfjt+2VC5S6MkMj0iwiWqBOMu0kfZN4
jefDS/yG8IYSw66GQr1IVGXQ25C0Q+YdoKsGeJPm9yMk0qegFX3s5Rml4rA1sPf4
DU01RrMx9EmKZqztFwFuyoW4C7bfAyYjkCuydQLBxtR+7arxOqAl5/fDqZGb9630
rCNnOtxE8NtrSA3ULtwuAP5D8B5G+hljFXFQAsugcSC2jXYAuiaYRY6ZwU1lkv9q
eJAOuKUKUgxJnBO9wrRSIUanx1dB2M4FxVjPlW3G7hPSJ6Mpl69km8FHzj6y/6YJ
+4piZ1LA8ueLg04M6usi6rInJU0wPVHwPINYOfAqtejAXff5eLZgDsERkCaPoJra
6W4D5B36YSBIjL9XpbwBiIcMQbIyFZFT05AAjvgMyEO7m9p4Kbg5Y6T9XTraYQ3d
cmsuyWw0sC42RbsmeZ2Ysh4HddQhwsBC2ZnzZ/3VxjBx4j0kim4r4juesIsLSHo2
/wF/dNnb+YvcoNysTOLuvVi09Yc+W6J9OM3cKRITD7HnvRHnA5g=
=PFWx
-----END PGP SIGNATURE-----

--MxCn6eBeRYpRsA9q--
