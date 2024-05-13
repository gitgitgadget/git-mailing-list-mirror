Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD681CD3D
	for <git@vger.kernel.org>; Mon, 13 May 2024 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715579392; cv=none; b=r+IwGXeSEujyqUcVXfaNyKH99gz+nhSQ+SqTecV5nZzHEGs0AgLvvtOc7B+MHTRDJ/KkDqcVYfDtsBPd2aw3fiq2q+v6OUqOV+a0euj04Q2Bsl1VJSTwNQNThvtHNzPZOD0xCcpKsUmJxi5WYI5C2taseY8o4GwIOat0uYp3zag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715579392; c=relaxed/simple;
	bh=MqtsU2Fnn8ubCs1PIotwWpTbNYgxFvFIphgrZnnAwM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzcGgc6oWC3UbtcClA0dXXpPnaWw4ac87zcumU4OAWTbwK+LsojTLsyDOsGVCx5zJVi9inSXfdFswDo186o7BoTPwfezX0FPwgV8xb3+H03BGkWySzU7pTM5AMWfHkeVL8VoJJBQhXHBTyiZEnbST1fMWzrGQO2fv0zzLKxQ/jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CuyvGfjr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CSrtVw4G; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CuyvGfjr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CSrtVw4G"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id E1B7B1C000E1;
	Mon, 13 May 2024 01:49:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 13 May 2024 01:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715579387; x=1715665787; bh=cJTl18Bhxy
	jzQWx2TttMtSYh4NKOXqKTO+R3DsRQsag=; b=CuyvGfjr5C06iZ8mUTrTp3R/7+
	jIjr2KcdVwsDyVvd33rU4LPnuWEHxIANOwjKCwTVm0XnymheYiIIe9xwn9hAcNT4
	07NCzgaSmOZzHVPm9cT4bgpi+FQmOs3hV3/O/Xs08IkWk9M8/PSoWd0t9M4JiyWg
	Rb87+FNLuDoRdn4QNfzbNaXlFpYcrslvwbJd6276y1zWlTa6X+uruqoyqmUd4R3m
	m4U2Csc/fksgVfmXG/xsxXJrlxHnQevYlzM9U1tWYPM4sY2mHP67yo2wJzoF51f6
	LIbarnZ0A48lc72yCgdNMXS1WSzf9gqIvuwX4nMSsEKagIJDCzGf4j1eLAjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715579387; x=1715665787; bh=cJTl18BhxyjzQWx2TttMtSYh4NKO
	XqKTO+R3DsRQsag=; b=CSrtVw4GIVTWGIJd/fRfa9VTTxxORQW7M0XjiAkIVrnu
	zlJILPyAaekfjTjnEQYkYFnCX8c+as5iCoGY2fesMIR6s4QswfcIO4Fxr3yUYmCr
	UkZlgUTGJ51QB4zwnFoQehKjdYaaaCD9kISIeovZgreNsYBOUgyQ/TpgDCoYSwHM
	gy2z/fq8gz+EOiOZhDw37JGlRmwkjCLHwv5s3ms5bfbbtSOqKfIe01NKA3jigYOJ
	AHR0Dti2kkXlLV4Fd2Ajjiixh2YoLMaWXcVTp2G2HCqvuSvOz38/H3XZSKJLYNNM
	tMRRD2d+KP+xLRrxywaXmXZZhfWFzv/A4NlFcjIgjg==
X-ME-Sender: <xms:-6lBZsuin6gckDR2T8iiQ6N9hZpwJWqVfBBP5uB0wLCkCW32MeUjnA>
    <xme:-6lBZpfOVJ2BbTm1S1JAiKGmQcxkPkXmmR7r6hMxyMz67sjo2W1Thyy2jcqXobkwW
    CGVfs8f8pNF83slkg>
X-ME-Received: <xmr:-6lBZnz4S4uNzqIwttjo9yO0uBjIEgk5GDaYyeiat-RDaBOgce5rBKeOK-Nt4ZklOpoR_4lbiSqjE73gwe-Zr-E_Yju2QKbQt1EZeXdxMq--z1E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegfedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeevgfdtveduudefveffteevudfgfedtve
    dtfffgheffudeitdefleetvefgffeigeenucffohhmrghinhepphhkshdrihhmpdhvihgv
    fidrphhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:-6lBZvOgy2-eQy1GYoaNIttEJh70IOZuh6XSS0RQ0fb1taMp7MXNNA>
    <xmx:-6lBZs-dleLQtxwKZGeSQIxF9SvisgtyVTo4hjaNSmS3C49lkUYElQ>
    <xmx:-6lBZnXHNmPuwBuqah4rdy1FNJOfHNAMhesNrMp7p0nd0xqMdeWJnQ>
    <xmx:-6lBZlec_z3Yq4rRRD-LxadApih1D1B9c7t9Er5Kbd4c5zXj3L50SQ>
    <xmx:-6lBZuL1Aj-qgTKT4JMJEJhI8HjcLQfQty7posiSim_pwTjs1HQaNVA4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 01:49:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 768fcbcf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 05:49:25 +0000 (UTC)
Date: Mon, 13 May 2024 07:49:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #05; Sat, 11)
Message-ID: <ZkGp9TqxO8Y5_kM_@tanuki>
References: <xmqqy18ghqqh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JN1UidEtNyF4urz0"
Content-Disposition: inline
In-Reply-To: <xmqqy18ghqqh.fsf@gitster.g>


--JN1UidEtNyF4urz0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 04:29:42PM -0700, Junio C Hamano wrote:
> * ps/builtin-config-cleanup (2024-05-10) 23 commits
>  - fixup! builtin/config: move location options into local variables
>  - builtin/config: pass data between callbacks via local variables
>  - builtin/config: convert flags to a local variable
>  - builtin/config: track "fixed value" option via flags only
>  - builtin/config: convert `key` to a local variable
>  - builtin/config: convert `key_regexp` to a local variable
>  - builtin/config: convert `regexp` to a local variable
>  - builtin/config: convert `value_pattern` to a local variable
>  - builtin/config: convert `do_not_match` to a local variable
>  - builtin/config: move `respect_includes_opt` into location options
>  - builtin/config: move default value into display options
>  - builtin/config: move type options into display options
>  - builtin/config: move display options into local variables
>  - builtin/config: move location options into local variables
>  - builtin/config: refactor functions to have common exit paths
>  - config: make the config source const
>  - builtin/config: check for writeability after source is set up
>  - builtin/config: move actions into `cmd_config_actions()`
>  - builtin/config: move legacy options into `cmd_config()`
>  - builtin/config: move subcommand options into `cmd_config()`
>  - builtin/config: move legacy mode into its own function
>  - builtin/config: stop printing full usage on misuse
>  - Merge branch 'ps/config-subcommands' into ps/builtin-config-cleanup
>  (this branch uses ps/config-subcommands.)
>=20
>  Code clean-up to reduce inter-function communication inside
>  builtin/config.c done via the use of global variables.
>=20
>  Will merge to 'next'?
>  source: <cover.1715339393.git.ps@pks.im>

There are a few smallish comments that I want to address, so I'll send a
v2 out today.

> * ps/reftable-write-options (2024-05-10) 11 commits
>  - refs/reftable: allow configuring geometric factor
>  - reftable: make the compaction factor configurable
>  - refs/reftable: allow disabling writing the object index
>  - refs/reftable: allow configuring restart interval
>  - reftable: use `uint16_t` to track restart interval
>  - refs/reftable: allow configuring block size
>  - reftable/dump: support dumping a table's block structure
>  - reftable/writer: improve error when passed an invalid block size
>  - reftable/writer: drop static variable used to initialize strbuf
>  - reftable: consistently pass write opts as value
>  - reftable: consistently refer to `reftable_write_options` as `opts`
>=20
>  The knobs to tweak how reftable files are written have been made
>  available as configuration variables.
>=20
>  Will merge to 'next'?
>  source: <cover.1715336797.git.ps@pks.im>

This one is ready from my point of view.

> * ps/pseudo-ref-terminology (2024-05-10) 10 commits
>  - refs: refuse to write pseudorefs
>  - ref-filter: properly distinuish pseudo and root refs
>  - refs: pseudorefs are no refs
>  - refs: classify HEAD as a root ref
>  - refs: root refs can be symbolic refs
>  - refs: refname `is_special_ref()` to `is_pseudo_ref()`
>  - refs: rename `is_pseudoref()` to `is_root_ref()`
>  - Documentation/glossary: define root refs as refs
>  - Documentation/glossary: clarify limitations of pseudorefs
>  - Documentation/glossary: redefine pseudorefs as special refs
>=20
>  Terminology to call various ref-like things are getting
>  straightened out.
>=20
>  Comments?
>  source: <cover.1715330206.git.ps@pks.im>

There have been a bunch of comments on these topics already, and overall
they have been positive. Is there something specific that you want to
see here?

Thanks!

Patrick

--JN1UidEtNyF4urz0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBqfAACgkQVbJhu7ck
PpQlvQ/+LWDxn3blNvpBPC/b5X0nc/IrKMkgVHTe3IXw76ffyIOq/MDB6sOyTrN5
7lbIIYmRgHJeeBY43y/qQpod5TdFupZEJ+YpK6TzoJa7OzItr/Hjc8+bDMDDykZe
dxSs9JMphaf6Q0SGf3CaEpIRFr6122yIQ7kpSIp4S0K3q9xCQEVeahjaoN0QH7ZU
s1JmVSxrLq0mO48+AxPd0i5PyErTGoZo0QBjJ26nzTKzm+TWlkRiUlbDigfjp1Ul
Mz5djcd8ThsyuvSJHpeKSDVkEX3lvm83BhKex0LnbIPqaCxSlme/3RyfiZ5EpFvS
WGWbQNFpoJzUcYd+TyPuFFQDxTgVeCF3VKC9PiMBfCqWDGzGEz4bLlEsjuH4oajr
IgH7+WEYorJlo/ubDUSuGMPjXOu3gZG8EUyXIFyH7I7b0wh6JwI9JnzWrR9YGMTh
3w18xv0pFdrPRl0Oeyp7ngdT+WCQuqTqbHdQMP7ztL//l0uSVdATlY4YTxz+ICEe
tP5IaWijT6CmXlrMfrKkit1iMyGPeiDX+Ct9VIkpckRwFygSRqVyA+7DZJaWWMSn
A1JH5TGY/xRiIwrG1qfc4xCF5+GXkpFuTFG784rmCjMG4fBwLR7FH9CDbZU1tIQs
+1tFWRO45Up47p0XrAzb+dIKXKBoBybVYnt/BjEwqwJNCJ7VnAQ=
=s61o
-----END PGP SIGNATURE-----

--JN1UidEtNyF4urz0--
