Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0106941C63
	for <git@vger.kernel.org>; Tue, 21 May 2024 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716273717; cv=none; b=pGGnpuWjyYZSRmtCY/YcdssK8peSf9ChwqeolmY7FrvjWd+HemQQOV6EA5WDd5qTvhMOo9wwL5hl50wkRgj1GyKlOT6wO17kZvVuXLc0v/yXeFqm6JWmYBT6cpgcLVIbfLTgSbq7X6xEPnpdefJXRmt0oeQTJbMQh2bIx9VPjt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716273717; c=relaxed/simple;
	bh=LAHA3dABArMd4b+xcwguYqVZBvO6+OUsD2motb2Im50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm2fb8AqW8PZz0p2xAypP8npULgIebDvUZ6yR17TeZ37NWSdvvieICtssvzVlLyEqNNCrpNo7OmRY02rZiCzlJaQ9dmCfTGk/C537sZvjogs3F32g0qBRmBS79aoE8zBhNQ4oe2siC6/Ad01MUS0V2jWIsmYv9QfjlddbcoCFV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KN13MOOw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GFiEY+d3; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KN13MOOw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GFiEY+d3"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id DCC31138157D;
	Tue, 21 May 2024 02:41:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 21 May 2024 02:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716273714; x=1716360114; bh=LAHA3dABAr
	Md4b+xcwguYqVZBvO6+OUsD2motb2Im50=; b=KN13MOOwZubF2s3/1VVTmk4KKG
	RzrD11Hk+xECwmLwSTrUBgNuy1XCbZVAcMKb6cJsa/AFkqpyjuop39EaGZEHGrTZ
	Tp5cNup9dWlob9N/ozL19++2D75zIi/k0ofdWPpknRLcn50j1YWXHYkgeQqnomXC
	4077jw33mxErga3RnCqfo1nkexw/oWJXyWgpTDqoxBq5bX8t1QOKEau8SiZrKdX8
	VD3c1qbmJBSZFdxfXSoSRbEh07i+4lWQiULuP5DWpIYCFjYJx+zonYi9dRytndio
	YDgKWbDMXrVQrEuqf4garV3ocL1nZZhO2E2oW9joUnl2QJcZ5y4yYOlw4fvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716273714; x=1716360114; bh=LAHA3dABArMd4b+xcwguYqVZBvO6
	+OUsD2motb2Im50=; b=GFiEY+d36YqA5J+SllIlEOZxKOlYX3B9MEHL18CfD9nW
	Nseuw+nIaZBiqAc7KRWsiHcXbS5GH/JaGPRQXpcjoroD0a4fuOXAfojx7JUlPURy
	vcJ9QeVrPUcKP2b29V50UJ2J88UhyJj3DrOiB9duc3JnA2jdTru74l1C8Zv6+dqt
	GcUYgcg5BTgie4SHGv0XG/M1TnqnWo9HxwGzZvfxopWZ152Mk8K52U4muWM8TRFS
	U6cICg4XdQCCpVDJO4jJ3vhbcvTjMLv5N8nFxF3wb8OYZ5rOlxDKDnjgo0ZDQXYp
	h9pjleUyx3l+jN1D5Ng8r8/N0RhevHXkOFOAyq2yRg==
X-ME-Sender: <xms:MkJMZtrm50az95zJKTf7cuMpAUKTlL7w_eYtR_xlj3pKqmSPVrdyfw>
    <xme:MkJMZvpCE680WsWgYpzoNHM81Pvc-x-YWmMJlmw9EwjWln_8ngwMoESjWHDSTNguF
    887iG3LAnu9fBZYCw>
X-ME-Received: <xmr:MkJMZqN4OFt0g6PmeqH74LFJoZr-1Q32aPVXDtsdnICWEBUu_uXyTF57rxeHwHHQ2Ag7ZXB3X8vIHJFogUdd2w0nl1Skd62HVjHU9mLmD1AHTQrH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiuddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:MkJMZo47lWiGSUrgAG9nBNfq8olyF3_oAa0H5KvfvhR9nJYSBzY9hg>
    <xmx:MkJMZs6zN-JA5VhQxiUlHKQIuPpfL-uU1EqVY5pwUb3iiLJzhlpaMQ>
    <xmx:MkJMZgg_EUTYc-VnMDtzXI5J7_CG_IYQhmBalZPl_djDGuQEbTaaTQ>
    <xmx:MkJMZu6X9vdukoLlmfz5nUj-feVswE2AOSNnd1LEmztv1sbjEnu3Zg>
    <xmx:MkJMZql9L3YoZqeksIPhyheDhkT2oy7-egb1SEo2ZkDyWvaL4ifxsfQY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 02:41:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 53d5dacb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 May 2024 06:41:50 +0000 (UTC)
Date: Tue, 21 May 2024 08:41:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/6] update-ref: add support for 'symref-verify' command
Message-ID: <ZkxCLeLlrzHYC5aW@tanuki>
References: <20240514124411.1037019-1-knayak@gitlab.com>
 <20240514124411.1037019-3-knayak@gitlab.com>
 <ZkXpYep2MKdsyNyV@tanuki>
 <CAOLa=ZSUV1X==x2CBivgu=L7SQryXNZZkLwxgyNth=a+bH9SQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OwUYNmVTdV1RaG2D"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSUV1X==x2CBivgu=L7SQryXNZZkLwxgyNth=a+bH9SQg@mail.gmail.com>


--OwUYNmVTdV1RaG2D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 06:21:53PM +0200, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Tue, May 14, 2024 at 02:44:07PM +0200, Karthik Nayak wrote:
> > So the reference-transaction hook executes even for "symref-verify"?
> > This feels quite unexpected to me. Do we do the same for "verify"?
>=20
> Yes this is the same for verify as well. I was surprised to find this
> too. It's just the way ref update code is written, all updates land
> trigger the hook. This means verify, which is also a form of update,
> with just the new value not set, also triggers the hook. I've kept the
> same behavior with symref-verify.

Weird. I wonder whether we should declare this a bug. In any case, that
can be handled in a separate patch series.

Patrick

--OwUYNmVTdV1RaG2D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZMQiwACgkQVbJhu7ck
PpRiARAAh0C+XjReFoMdvodcAt8Bd2Acbn23KH5GswqBchKvZYlZc1tzSvbBV7Mf
ULhQoObBvR9pSFGOesgMTvdxvx0gunjlL0w+HfcjqMw88eapm1SPjZaf+LEwWxnX
uJNhCSk5r+oeI5nATMp2PCliC5cZZVpKehVWHIivyID2RkLjF8JAXCXbqcq9rX2s
0Pl/HwAo7kIwapvstxgl/a/oo+cjweC8QRx8jDfgMOukpDW3AHYBFszRF0Uk6PAr
cYp4OqVTLMpuS30VdlgjlbqvxdkhQy9WYV8gyGNrhJFm1if1TrnDuzZN3WFQgJcg
SqS6jFWCfVO5HmyHuWWLyet3DjbuhT7mNpb7UY+wsWC4daf26zmSJJLHrKeSzh1E
OK0pyzS6Q6ENYvsrDMkd8qe/UHhI1oQkux+YhqdWyPutMOHWl06oD4UJJ/7ZR4Wg
1nuy7WI6MYsYb7UUTdWRgDn7gcmYxpvy6ssNafrusRQtlB2jIDuwwiVf3y/0+aYj
fah2aDiUHxvrGcnnUs9fVMpxZuhJhVwhDsgnnuOQn4NudUCn8Ix89Yi+k88P+/K+
Mq8T/CIKsrFskPjs6zo+cHcjQJNjBqAoUs/Xr56rktZLbHVS6saAgTw6fxrFKSOt
sloOJcTEO23xg9P/wX9pKOsiYYOECvnK9gqam2xJJTrSO4zC9CA=
=n6Vv
-----END PGP SIGNATURE-----

--OwUYNmVTdV1RaG2D--
