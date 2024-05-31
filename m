Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47B015746D
	for <git@vger.kernel.org>; Fri, 31 May 2024 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154811; cv=none; b=IrXKuH2a3pqg9prZXFDYVyGFSJRWeTRQdf95oGiCHBYipuN3oHonhcy7elVAxXT/B8+X3m9wjJD5IA2HOeJvqfkXXmYxAB2hgw31OFOkds5zmvyzvAZV+nhBF/LbrA3+TIDIAJQ/Rwxm7Zok2yNGBUM2y6PYPKYq3DLpIE/0N+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154811; c=relaxed/simple;
	bh=tyf5UcRvL+LB5cW34Vgq2CCyETEG9qqxYP7MluKxhHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GD57Jvb7+0OVY+qEfKW5ObqXBFEuLlRxREHnfus2G6OsymYrpeUp19acz0IZEHnJTAoV1FHzw8HTxFUjSUMRI6VK97MEACh/Fw7CoqGrETYFo4z/nM1o/zyMQry3zUr8upvQHkQcBW7UXdccSdqiregepO6NxqKjBshXR1HuotY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y2BoFtr+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qupK74jz; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y2BoFtr+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qupK74jz"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id C14BE138008B;
	Fri, 31 May 2024 07:26:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 31 May 2024 07:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717154808; x=1717241208; bh=78w2rqw/Yb
	+M5ZhEFnsKX9O7WaZPt6SMDjLZxFxRobs=; b=Y2BoFtr+olShBJlUnQHyA0hNS5
	Oqpjqc6z9H6tMUubMI4gav9TptZay0gQ3w9MGzq1Vtg40WdHLeGwiFEVGVoSD49c
	7zhhCf5bVvC4r2mJBIwtOkVYAlcq6BOi8ed1X0pdeSdSaWzYXpTEecKkzWp1judO
	c52utFqxNxA5gfcJ2qQsREkns1y6D1Fhg2X3fvxz3shAdPNCr/yjGl8vSjvlxxvf
	m9VI9lcAidjA3pfMVwJkd54JW+0dndDom8prHKja1e/M8A3pXOQQZUgAIb84mdT/
	kZqiAvaA4+NBnMSSVuRq0Ue21yYwoQpCvzI3gGaIOkDayeqG6jt6PIDpgu9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717154808; x=1717241208; bh=78w2rqw/Yb+M5ZhEFnsKX9O7WaZP
	t6SMDjLZxFxRobs=; b=qupK74jzF12Z1uwG+UHi7k41ZrQH1iNf2BWSr4ofbcwz
	+1xqtdPqin1xCQLIXJPMrUVabjAfS01Go8jYHCTnezonZAbRVD2c9QA6PES/aKOk
	d4EZiMHMO2AYxHZ8lOmzW4KVpSuejavhoHYhC5Gy3VoxthJaGMvPjcx1Df1U3y2U
	0GhgkLJswL5Zjj+4FCORS88uhCts7PTVY2BPCjtVwElpizV5Sq9CKaZIfrRZ3f6Z
	ipL9qeCzxwObnide6FAuuMBGxn5R0FI34K94YVjUJ1zb4ybVCG8UHadOQzvXdjrB
	H2vEgs8eekvKelYeNM+vYs7GuwNPUW0kajiU8I2VuQ==
X-ME-Sender: <xms:-LNZZmluf6UoueJjEV7RZ-MI5t_fmqTuepQEY1YO_lOTFWJvjfinFA>
    <xme:-LNZZt10NhMWSOEVtcEGMuUX1Z290CdyuUFU0YQzv_FoTbwDmiNwejpr-aKOwdznO
    MhbxqTsxbVicTn9Jg>
X-ME-Received: <xmr:-LNZZkqoSnRvMF2A4Z-f88yUvMLsXJ-0_76okkNdB7znNCfh6Im-gm50m5Qpz3qpFaG5swDC5g6t-hDFp_4hfb6mCTbG3E5bickK6zOKnusYOvo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekiedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:-LNZZqmPFyzD5Ide7y9IS4DRMeXf-hFlrF4nXJo-HDFxvADC9rHZoA>
    <xmx:-LNZZk3FKStZC81kxkhAks4CH-YIwXfLbD9l6bIcJYL3zW8U8BK1Rw>
    <xmx:-LNZZhvM7hHC_escV3Cxk8M735POpi-IMPsqrKW8SdimcKN3FlHSZA>
    <xmx:-LNZZgW7jjM_PGGOQzZZ2ogZJzVz5nGyROl5pLRDGycPVr1mTaZfPg>
    <xmx:-LNZZiBP2ZXvqTSh7IqSOGVaxV32qjUTnZQr2ckYUTujwOTjvT3UKPQ0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 May 2024 07:26:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b0825609 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 May 2024 11:26:28 +0000 (UTC)
Date: Fri, 31 May 2024 13:26:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t1517: more coverage for commands that work without
 repository
Message-ID: <Zlmz9Edyv_gehMVr@tanuki>
References: <xmqqbk4np77d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qi3Uyi5YrD8Zd5fB"
Content-Disposition: inline
In-Reply-To: <xmqqbk4np77d.fsf@gitster.g>


--Qi3Uyi5YrD8Zd5fB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2024 at 09:58:46AM -0700, Junio C Hamano wrote:
[snip]
> +test_expect_success 'stripspace outside repository' '
> +	nongit git stripspace -s </dev/null
> +'

I was wondering whether we also want to verify that it does the correct
thing here as it's comparatively easy:

	test_expect_success 'stripspace outside repository' '
		cat >input <<-EOF &&
		# foo
		bar
		EOF
		cat >expect <<-EOF &&
		bar
		EOF

		git stripspace -s <input >actual &&
		test_cmp expect actual &&
		nongit git stripspace -s <input >actual &&
		test_cmp expect actual
	'

For the other tests it's a bit more involved. And given that these are
all designed as smoke tests, I think it's fine overall.

Thanks!

Patrick

--Qi3Uyi5YrD8Zd5fB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZZs/MACgkQVbJhu7ck
PpRtNQ/+LkI06k/0d6BvPXZSMGx/J5lVm0wzIxjiv/YRxi2bMjPgK0uKGzmPP49V
PyKbQbWqtQFJXFbCzxt80xgNEzxWoec1zjz65E4x0Ub6oqtOp4JfuGOfVk522Ju2
hfeGGnAdEvDBQeK2DBhKGWR1Mow9WrrtIuqN2sc7TV+AYFlktAwbDOSOUK6hLA12
o+S7sf4Wr5JILYmRlISTZs+sjX/HrKQ3kzyQnzVY2nVfvqmxtOWKFCjJHkzwAjBl
HOzaHEKZdvk5r6hwlS/bH0MGMTa8n9FjLAfXx/QRkkfD47lC/y6sZl6wp03ddg5h
eNrTXzI4tbV87j4nkSGX1Ab0hPZ/1uG6ozvqBZSZ+f4Q67kd6OcCCkef+sX+wavm
G3QlUNaxp5EKZ9CYtjnuW9MFkCKxjzUWp9MnV0VjIjVJql/zJN1weXmSk9m7V1Z8
wpFSJOM8fixxx6Evd1zi5FqN8Q2tbIW8GB7foJ3s1XVgFBYJO7JWGH0rzLbZ3/qJ
bImmFWZyYrE/VihUymboj3Ei65Rpoj27BrSOfohil6RPBVESEH/eMQksYcgB6sCH
SWdDBeIFcDBtuQHhP3U4eAHv7TB0VVNF4DEySoeqQb0TWSMRK2DgPrfeCyBNLi9a
BgYZ4g4+hIy3sqx+/DebMN5oSiAiitYjW91NwIBpiIn/oCsE628=
=UBlm
-----END PGP SIGNATURE-----

--Qi3Uyi5YrD8Zd5fB--
