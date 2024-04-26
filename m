Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A403A1B7
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714131804; cv=none; b=DF0asbOWSesfWF/vUXeWGp719TDT+hDrGYvw5LhdvyLfVQVLkc9hS0WEoRhMcIG3GXfLDfBcIkOsGqgSkgWD7kCyEUBAzuvsywMTl0e/iesJj74tHukrefk/bttrLfEEzUi2bezlEW2MJNCtItJmbqI7EOYohr8rdA99SQ/nS3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714131804; c=relaxed/simple;
	bh=3ylchWyU0AcskBHPPfkXnEy6kVBUPk0a07G+60r9MC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnDFW0sP7STSJKqO7DmFCcqx8gx3iK3/wHxd0I/hxxGV7cfFx6Ld1SfsuCIpTiGHI/bWeTHEOPECp1jt0EDBg6ei/w+eHim7lBF8kFB4xCrRrl10DPYTG0DW1xF3VTLOmdDjNmv04kG4IxMcH0t4UH4iSp16qGCaz2ToZ2FMIKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cLkUzU9S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h4Qkj4BN; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cLkUzU9S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h4Qkj4BN"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id C5F391381C29;
	Fri, 26 Apr 2024 07:43:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 26 Apr 2024 07:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714131799; x=1714218199; bh=3ylchWyU0A
	cskBHPPfkXnEy6kVBUPk0a07G+60r9MC4=; b=cLkUzU9SrUIHP6a7THGsgMgt6W
	n656iQdVVJ0eUENFx+K0qbFw8DPh/z72C5QGhwJ0qDa5e7oYR88EwedLMkWo8RSJ
	1xMdSrfiD/VK31md7PP3SLl+Z/g2PzygQvQQHBFBmOHEK3qWT7HTlM2K+tMJmPfD
	klE7qYsplVs5VUnSrEyq9NLJvpZHQ50/cOc3fySE6Dse+S5lo7LsumYemth/CiUR
	fjWQgDUOj1wS68hczlKyPO1sy9OK3CAzqqpv7XjXVegYy1uDTrl3a62Yqz93847U
	RfbeMtBnIYRNdPvpYr0rR83yZPwyfsaI3xuYUpYbjBWBX8BNXnjARWrgKvjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714131799; x=1714218199; bh=3ylchWyU0AcskBHPPfkXnEy6kVBU
	Pk0a07G+60r9MC4=; b=h4Qkj4BNnGR+RTILNvmA/uh3H9GdCsm1Srs6XQ6ABzWT
	vqdwMoicg/t+yhuL0LVj1tFyOkRcAIFfKvlyB70c/Z8df6HcbpA1mUYFYtWdii4J
	pjsJWOqD2ZHzZTkE3SDBfO9XTVXxcV+yYVnr48tEOq9MpojuZamRFZGQml8yi3Ek
	iDf4UZQGS7haONM5RSigoIYfGsZG35mNktp4aw2cRNtROooRBpmeqi5add8xTiv5
	4ANAlnuJ4dCquwHI4FjPgy6JK2trtF7uMJGw09m5GBCNWDtmD6SrMCp+lELRlrXS
	xOCOnLZZvhaMEXRLDKYPNYxblgT9qpVdiFfiAXOtgg==
X-ME-Sender: <xms:V5MrZmSCvgrBcLDXyWspmZZH07_FeUIorCiFMH6Z-c_5FWm56hgnMQ>
    <xme:V5MrZrx4afAqYkaY8g_pcwDwlDt9sEoSyExh6jxw7KQ8BfIV1WvjX0ar2IwVgAwvc
    tGWVVKit4YRrTg9eQ>
X-ME-Received: <xmr:V5MrZj2oEWw62MCLM0sayZI0rdGSrFAwTKlv-wyYnVtqfG3ndTSgcnFJakPcHdX92VovfVe5JTCP_aNqnXB3_mdOmoUEfsSPfKpUeyHVDIQ6SwM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelledggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:V5MrZiDcyiMSiMrpzv-kkHCTskV3BaSB0Ud-uYde0A0yglKCUTXmNQ>
    <xmx:V5MrZvg96GiCw94pXFt9RjDmR-rP2UTerlSMjp7tBWRBDEbtKNog7Q>
    <xmx:V5MrZurOFQQpYJdG5-qpgR2JNevdVnS82h1O9SjHoaHTHw-fUA5OUg>
    <xmx:V5MrZijnhHNT0eEQ21XYW3cIlKiJ7UBOJsOJVf5t-a756l7JwvaRMg>
    <xmx:V5MrZvcybQWd9JtQCOJpDKr4U_vepsG0YrXmw1Ww4wF_TkneEtctm9nd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Apr 2024 07:43:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6db70135 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 26 Apr 2024 11:43:00 +0000 (UTC)
Date: Fri, 26 Apr 2024 13:43:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Roland Hieber <rhi@pengutronix.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 1/3] completion: add 'symbolic-ref'
Message-ID: <ZiuTUFtZxBBehVVs@tanuki>
References: <20240425101845.708554-1-rhi@pengutronix.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0Zzp336ZphnBRq3K"
Content-Disposition: inline
In-Reply-To: <20240425101845.708554-1-rhi@pengutronix.de>


--0Zzp336ZphnBRq3K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 12:18:42PM +0200, Roland Hieber wrote:
> Even 'symbolic-ref' is only completed when
> GIT_COMPLETION_SHOW_ALL_COMMANDS=3D1 is set, it currently defaults to
> completing file names, which is not very helpful. Add a simple
> completion function which completes options and refs.
>=20
> Signed-off-by: Roland Hieber <rhi@pengutronix.de>

Thanks, this version looks good to me.

Patrick

--0Zzp336ZphnBRq3K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYrk0sACgkQVbJhu7ck
PpT/zQ//fMcvBX9t7dqlfkKCSOn9V0lqyp5/nAp5z22gM8CpeklInCC18eWW+DfK
me6CmaW/asVsHtvRnR0GUUVc+vhurALuwH3FevxokG4jA76gYw4OD88v/xt6Xasq
E7xP/TCtxOWWJAuJmJGAAU4rGmehhEksHnD2yrgIK9iiyHowguy7E1yu8DVA3Hvn
EOdmQxt3nQ7KTvdY+958OQmJ+b+trbgsZq2ISnOJJy9uJ3YszfDDHlnCLRBHE55h
v666pa54o+zGMfgw0bMG5Vnf5RwBSjx/iKLOiMlNB7nYi88mZrPbRxuwlpSI33SP
+kY7VBV5jmzetZVUJo5l6cX+IxIXZrSEXIdPmSmq2zGTrle9fHqMi+zmTbRn2Nrm
x3pKJax4rM9w10R4tKb3ydfqo4HIhOOdTSakGPL4JWlB4Tc51tOz5Mp8mUECTUxJ
Esx7Z0gT1KK8dkHY8NE/M3+MYQQSx9IiEs/PGWbRvrfRMfpBR6Pz9yYSRB9FrgmX
SQDAj/PeUYqS2n607A0z9pIG4jmSCMgQXKYWdhJZMmNt0PGRDNOM88D1bS30B24K
vVpOqW9Uh1VEfbNTNE7cX3BG5T7udwmW+W7a5cSV7pUrqL15Dq8uqcYLp5YX9QBt
uemWsphIGv2Cc6zfdieTNnpCkKcv5vz19KwF0zXqde/+fhOWkVo=
=j1wh
-----END PGP SIGNATURE-----

--0Zzp336ZphnBRq3K--
