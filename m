Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2925D724
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 07:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215949; cv=none; b=AGJF5m4DEDJyPRhSfN2R5DW9NgrcYM3+ynrc+VviRQHhPXeRpUJzi9lAmyU77CLv/B3KzUVzUh3REEtgoMQakl0V+Ylkgr/NDsCaennsjCAg8ZBTMRTvHoo5I2T3XlMqvppFp18iYpecBrLw1rs1yxk0ytl2y0Jcm+e5hmyglas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215949; c=relaxed/simple;
	bh=sA7JHwcN4P0GQBYMS/HK2dE/mALNwJLyECAlS/BePmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxHihMNXwRtB2FnMXlOvXUWAaWzGgPlza2xnuvcVGmhRHVy8FeiFvi602GajH4ONK+8ef/s0wKOR22BGDoHbQQoRtCnKs5k+Cwkwq4WKRRjEfgwL0dAeWfjEKTTefIM4HINP7o2qAVG+2mmZW1wNfQnuzAVPbVqB7Y9QqZSLQ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ozyLN9qA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hiQt2pi9; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ozyLN9qA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hiQt2pi9"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BCB6E11400DF;
	Thu,  4 Apr 2024 03:32:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 04 Apr 2024 03:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712215946; x=1712302346; bh=m3NmzXCpAO
	ZJ8ystAyYXH7ox8YPO7rDUHDCZyaqMga0=; b=ozyLN9qAu6/pZbI53aywmZG48U
	e52HLkd2Sdkc3plCPSOWqs+oGkVcAjMKkcVnbwPnHmy2OujuIw+tOOhEEG8TnBY/
	WyPhaplBiIMBo5g6cjbwZoNjyfL7V7/5ZNYdBmYUQbm9vBJFwwvGE5AFpJ4IqGBF
	0l7RTnF9iCZko6FKvsVoYGo/EinWePnTlIO8vIkEcr9o5pXtFLEz894CgAIfmv+6
	ucc+Hq6IpeZ4g3mNrfv/tbOPhkjoRYx4IXoLRQ7jkBMc7fgu/ZOnR5Kj6PzbL/cR
	Ww6nZCuhmckgATG7SXg2sRK3ZGT4+fDEspEd8+Zn7RGzxtZX2RDUAh9f1Tiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712215946; x=1712302346; bh=m3NmzXCpAOZJ8ystAyYXH7ox8YPO
	7rDUHDCZyaqMga0=; b=hiQt2pi9D8rPlv/n1kkbXWf7kvPlklH7u5YQ58ZnPdc3
	kbFGjm5nyZQzGITDXKjjVLm3nzjInQqQEyGu71JmqR1GSndGHNATzvbSK4WJaYHf
	X0GC59tnYxoghV3FJ5FwLEuYJhgbbB07BFbPNq0h093/MagbeOy0r8w9o3bZIUDC
	In3DcTRDM+Re4vgT31cPW0tO28ZOQ7MbqsXZ3X+lLFkeQtsuu/ca0oXf9E+26+eb
	2IkErQHL6JtBHeHz5YxAB/BnA1tzxU8815y4P1Mvl7XXR1xZpRcdgQFJL5BeVhZm
	Ezqo3MhvBY8NihIqric7WHEPgjnESMk91bXRDGtS1A==
X-ME-Sender: <xms:ilcOZo4wgnJ2vdIJkfu4GTLBF1BV4fGkPLoyJy7a2S5qQia1f5ksQQ>
    <xme:ilcOZp5c7OclkhJRpXTa_zicjiYjJHk2wJJlADHTJSu5u4UAz4pjibQ78TBMhuVcz
    FT-43FvVHrPo7gBvw>
X-ME-Received: <xmr:ilcOZne74XdN3m8_KshYBcFCwidPbj8iMZ3IbtzEaATnT_o-wqkt2h_7tFZR9H9QZaFtdZGTBbv-4VggMQBhxbzruX3mLXiKdXlelLR_HLY3JN9J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteeuvefhhfdufedvgeeiueeileegtd
    fhgeeftdeuveejjedtgfejhedujeeutddunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ilcOZtInISKL0VXvZxB3vTeIkwx7s57P6TY-UpklidpXmpaRwjj-sg>
    <xmx:ilcOZsJkwF_wTozLfz1hoLKL3b8aH71QRVE1BMEMrbOHpIZKcV3F2A>
    <xmx:ilcOZuzOLz8L5XbjwhAOsK-SgJouUL3wPBjQIBqb0ZE-bfzh0v0snQ>
    <xmx:ilcOZgK0cLc9Y0KVTKJLFJiFANXJCS7msBqRgz5pKY9RkGLS8Fyftg>
    <xmx:ilcOZhEBkDwWujSshhEZ29849FPMkm5HmTfytoG92BDe0UD4RBlbBNqo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 03:32:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 19f815f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 07:32:20 +0000 (UTC)
Date: Thu, 4 Apr 2024 09:32:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/11] reftable/writer: refactorings for
 `writer_add_record()`
Message-ID: <Zg5XhYq802lG4AgU@tanuki>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712209149.git.ps@pks.im>
 <4877ab39212867e91058c60f99fe0dc2a592d583.1712209149.git.ps@pks.im>
 <CAOw_e7YeqEK4O=KWowMYGtRVMLwL3y6bWw2LRfC9TqJz06Esyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bsrRYwkZm8WzcXdn"
Content-Disposition: inline
In-Reply-To: <CAOw_e7YeqEK4O=KWowMYGtRVMLwL3y6bWw2LRfC9TqJz06Esyg@mail.gmail.com>


--bsrRYwkZm8WzcXdn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 08:58:08AM +0200, Han-Wen Nienhuys wrote:
> On Thu, Apr 4, 2024 at 7:48=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> > +       /*
> > +        * Try to add the record to the writer again. If this still fai=
ls then
> > +        * the record does not fit into the block size.
> > +        *
> > +        * TODO: it would be great to have `block_writer_add()` return =
proper
> > +        *       error codes so that we don't have to second-guess the =
failure
> > +        *       mode here.
> > +        */
>=20
> The Go code returns a (size, boolean) tuple for the write routines
> here, but that does not really work in the Git C style.
>=20
> If you make the routines return error codes it suggests that the
> in-memory write can fail for other reasons beyond "does not fit". Not
> sure if that is really an improvement.

In reality, `block_writer_add()` already can fail because of different
reasons: it returns `REFTABLE_API_ERROR` if the passed-in record has an
empty key. This shouldn't ever happen, but it demonstrates that this is
certainly an area which needs some further cleanups.

Patrick

--bsrRYwkZm8WzcXdn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOV4QACgkQVbJhu7ck
PpQR5A/+ImxSbyv4hw2Xc9bKfd2UqY5nqdNkMBKlm2QK+ByueJCMcERPzGhuy2L4
bF8vPNsuW6joEbcGsMgmy15silZL6/RLPpWjjQF5Z6WLsbBxpCnJuS2bd/NtjX4G
gpo5YEYz4YcmNq7HnuANaD1yluE/aiyjfjA+dcA6Wtv7ZXyTjb7KOEdcNc7ZJJWS
S3KKaH+1sIi36mwB2Nf2ZGQyaJ/I2dR99s1BfLrpvEYOTmmPAX1eUG3CV6AbuN7S
n1BSTmHuzUn7EZ22B7S3KX41CcyFB9SSVBDb+9P1bZbvVkjw2HOs/UxTyFEaKir4
qtxcg26btDZ2SleYcJ2z8UgwbjVnd+Qfilm3t81u97foTfQn+JwwGvb8HQX2l1Ss
/UkyO2RXzCQbUPvhaiXqQ5KiZHiwC4y7ZPQJ06OW8wTexYHMthfvGdUG9FygtJzh
wge0/tl3S5D936+wzwyScOZWML5vn2IxY9xw6XsaYiA+5MjTG8H2QrqIC8PlC8GA
f69GQKICCHptg4mjB17HVJCeD7rSvdg/iuygRNZ2V59D03h+HL6UwuxTmtQuuIOB
fKy5CS6xIaAevbvtw9XN0FCRPX8Wnvyjkc2uZsjZlxaFDZbGXwMNmaRuG+dd2Dk5
d40EUiz8q9bY3OMtSjUjy24V/YJyPLzDDqqkY0JipQIh6jZH7MY=
=g6uE
-----END PGP SIGNATURE-----

--bsrRYwkZm8WzcXdn--
