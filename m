Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ABD130A4C
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348930; cv=none; b=ReOkHjGxq3zX1LEqlUjErZTfU4LOzCi3VBIGhnga69RXCaTc7Fl9tNkeR218I1nshCnoCcNNgFb8Ff2EhhhMAqfBnaqTJFUT2zctE8vJwj0KvTcXvuguzIkfdE3YWx9YddeqltCkMlyVK5zmnaL+Vzs2CMq/S7TkJqlij2HlA/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348930; c=relaxed/simple;
	bh=lIpdmaAwcqUuzX4ATVIgwr09YMODj4sO40r8CLzcLvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m04VhGhHNn5yTCTncBpMSGjnmX2U3r/gjNq8FS+H0+uXOu8FrMu7quSpsz6dLymWJrwCUqP3ysisj9eYMbixTlprZM09z9c4+WDFogcj5hOrgbRlu4oke/sXFfKV+hIpj3ImJ3UUX7jw/CYe2fPbkbKnEOvTUGhp5H9TY08vomc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l1YqRzgU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=llYSnfP0; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l1YqRzgU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="llYSnfP0"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A3AEE11400A3;
	Mon, 25 Mar 2024 02:42:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 25 Mar 2024 02:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711348926; x=1711435326; bh=3qrLHAc9IH
	OJdH/lBoyPtEsn7VwzeG+wUg9JJQ8yE7I=; b=l1YqRzgUETRr0r12IT8c/mFLBE
	jasbMt73dQUlhA2rSyCvrI0wJNryP6OWND/BkGOkcI9eLbm7kYo4yejnSj7NgJuc
	xae81rXSWTgmBFnDRQRCNbHW3TiIWaMLXwC2tVMkC++agrUzn3DTDVEXlT7jnSD7
	JRlP8SFntm8KiQPRHHwhZRHgfS02AWwiWoorCkAAD/UBtMoywHpq/IfFmNjGqdv8
	Po3RFr8cEuNdDW68N/tIJRm2G+4O+fiv3nmWMtJ2a89/0YO4BhmVMvnXqxZiLocu
	O4Q314ux1ysVLGrg4L/aqyeEw5rvTsWG5rX0guTC96QrkyD+dQHmOTe//+Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711348926; x=1711435326; bh=3qrLHAc9IHOJdH/lBoyPtEsn7Vwz
	eG+wUg9JJQ8yE7I=; b=llYSnfP0Di1FdcKWAGZxxydWpWFlMmP6c8PQw7xipAFi
	KwEhFLeIVXRY5ofav12r6+OEbSBWMynXGQ3HUfbPdfL2ZfIwa4Y+09KW0XKSakGT
	f5lm/ohZLArzx1JDTIZxLikBNROPj2yJiwheR+ihIPfEVmGb5keKSMKTfm5twLkd
	exi5ZwCVtbLC46sRpTiqMrTReGhlem772FwKqJZ+ELvlBnPpS6o/TXAwvDG03H+a
	78pnvcTE6Bbi+J0J49n0y5a2qpCGsZ6bylSQGCpyapgGmkbhIwiG1P7Ac3b8ZKDa
	VKg5ZCmA4A2QQj7jUvh8LYpy9Z8rQnH3+Rx8G9dmlQ==
X-ME-Sender: <xms:vhwBZo0Jt-nDcI8LD3hA-hoZFcc14c5BHDz9XLudBTrDN9zi0u_UkQ>
    <xme:vhwBZjHbdVEv9UHneNW3Be_-rqoc7E-QOYYo2HrUBbZQ6U5IDy5b2hPk2RuUqLSSM
    cEDNX5jRIUTO_uAng>
X-ME-Received: <xmr:vhwBZg6yqBh3rsvArCFROKYABIGEw-4Vwu98l8AmKj5LmcuXmHzNSrXnYqUiU_Ftz_uEHJiwNYsClrECE7Zvw6QGZY6txpANKsy0whp-YPuztA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepieekjeekveefveefgeeuffehjeegfe
    ehtefgveehjeeuteffueelleeftdfgjeetnecuffhomhgrihhnpehpkhhsrdhimhdpkhgv
    rhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:vhwBZh3Ql50I0X-WkW3Lu6EXD224Oo1nRLy7wTnvwIbyTzb9jnwCfg>
    <xmx:vhwBZrFunbsEmWV-PWHSAheBMGAYu-g2Ul9Zi49KE_0pJZWe51f-qA>
    <xmx:vhwBZq_DjV0MWQ3pRcIRqOMgokdDpGnMy_28_GixPFICLassw4jTtg>
    <xmx:vhwBZgkdHc1--pD6Qz14mYCyLbnqewuJXZ9Oqf93Y9YbuF5g0oKuDA>
    <xmx:vhwBZjBQw_qdWMa-izHOGAIgre-6Yg-xXiPswpN8CSSw3RJOWpVspw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 02:42:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 727099a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 06:41:53 +0000 (UTC)
Date: Mon, 25 Mar 2024 07:42:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2024, #07; Fri, 22)
Message-ID: <ZgEcuDJfPoN-MYy5@tanuki>
References: <xmqqedc1zs1p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QKwkDZ7LNYKgUeP4"
Content-Disposition: inline
In-Reply-To: <xmqqedc1zs1p.fsf@gitster.g>


--QKwkDZ7LNYKgUeP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 05:54:26PM -0700, Junio C Hamano wrote:
> * ps/clone-with-includeif-onbranch (2024-03-12) 1 commit
>  - t5601: exercise clones with "includeIf.*.onbranch"
>=20
>  An additional test to demonstrate something I am not sure what.
>=20
>  Waiting for a review response.
>  cf. <xmqqo7bjjid9.fsf@gitster.g>
>  source: <0bede59a53862585c49bc635f82e44e983144a7f.1710246859.git.ps@pks.=
im>

Based on [1] I think this topic can move forward now, right? Or is the
intent to wait for another review response here?

Patrick

[1]: https://lore.kernel.org/git/xmqq34sj583m.fsf@gitster.g/

--QKwkDZ7LNYKgUeP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBHLMACgkQVbJhu7ck
PpSs0g//W75bzJnkW0+jboX8gt5Z3JjQynmg37oq7gSlg77nNyWKcozCBJJ9CuAL
ofP1fmoJ/T427y5p/1Aptbnkli8Xu+xqqaVn1BT4fNcr2RofBnRto3O9FIsb6dew
lMDCd8na+HUI0Zby3WvN0Egx7tl3+VpQCAd8vjgghFgYBQE6maew9I95plMt14Lk
eT1Re5VtgJf1ZC8UM2d3bzzB64/ZrY2fHocm+xaSgcZK+ZceGQ0cNr3DF9xHCeyh
4ebxJaIZSUe8ooCpWZoHjqisxJtIN4IvDRvDANTJbV2EcOHnvQNuM2d7j2xgcX2h
Ghpx82cB8rc2dg5stesu8e5s3QEA/gla2aKkRcWQCHXvO2eeZHtYcIf3nEjl2u+R
EP8rRiNQmAIFvGQQ0GgTBX4JA/dWVME6mY0tj1+SJIWSTd3xJ6uq3O/FDnpOn6Yk
OTpIxIxvBPZZu1d+ExNYk8mGeOOz9wJnYHUH63OAue7JMRy1v2WpJTFMvVkm08yF
Xzf6yVeXk+sok17Vz8qVYu0F4oASxMdZhsrBEspKYEYg+W4/yI5K07/1LlpGgLwX
DkOcGPgFgvaNbhV76/PaL6dCQ9x6v34M07KVt/Y7YE4ljGF+PBdXEvNlfZkq88e0
v6NneQ7PcW4XjAhY0d0j4A3tq2bQQvJnazkFmLz1vFycPFpdlag=
=dXbc
-----END PGP SIGNATURE-----

--QKwkDZ7LNYKgUeP4--
