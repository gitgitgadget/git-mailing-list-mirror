Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9C1183CA5
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504709; cv=none; b=eL5cqAHlal0gwBafk2Hy4OJuf+v5LwpyBZ13FhNHEORM7x9a1h3GGGAuQ+z4nUaqE/7Ng394XPmw+J/dSFhv4ny0x2YBDtUu2ASp29UELMfk0UP/FQyWQiqFlWgaORMAySxIXChn7zw55fl2vzdieTZQX1Y+b02ByzmwLJEmMM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504709; c=relaxed/simple;
	bh=qOnrX6Ls910Vo6kt9BSH/dH/AAihIs04lUYHJE0HCxU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0DTooM3whjnZ33cECBejrJuqeTg6zk5oUBsuYZubUQV4iZ4I9MKXvET0NtjpIUbB4ejBWMkTWSPCzKPRgEf1Fw0yu/t7sAA93/IWwPY9DgoiBYeoR+RBdJfwWul6G3ArKfRR8lDtoCGdPtXwbaAD+J2/B9Bmgdl7tXSib/bTs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qLsUU56W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sCUyLByF; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qLsUU56W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sCUyLByF"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CC350114AB86;
	Thu,  1 Aug 2024 05:31:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 01 Aug 2024 05:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722504705; x=1722591105; bh=uPHlir1mLf
	Cwo2AqZv+HzHIdjbryzkSJSZBYoJRku7o=; b=qLsUU56WqqS5uwyH9JiTivlmcM
	qgqmZhtb96e5HILqsp9HrGvvXtIv81/K5U9/nSFIpczBXI/BTdlv4BqFBdmy0VD8
	nik+KY2lMKQr1kBw5u4ByUUVCDRzDE5JF9YcT42LuYQLARWGsgXxOir1UtrnBQU0
	MS5nqouoH7TYmrn2z+Em9OzNJ41++2ZO11OXvo1USWO467GB/x3ZjL3KSTC5gCKK
	WKb8t1L3tnNumZwwPn7zv03f9JDPN9hv3NrJcyn3IuoJ3QViMbLVbW0IE6YexazP
	/JYVUZYsx+RH70F17carKr5KiQXDHQPTzcCVWC9NGLtbkwTPBTT/99Q6N/1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722504705; x=1722591105; bh=uPHlir1mLfCwo2AqZv+HzHIdjbry
	zkSJSZBYoJRku7o=; b=sCUyLByFGHTQmP2WvjlvsRD4XPcY9xdDIQRDP/HKb5M1
	1uY9Yn1I6S/+8Rg/LOxfDmcMjbsK2yrGbCqhAt9Z1TOo3/wDsrdxOYlCRGmBtmCn
	GJqMFqon3FpIiZMSpUO6il/xzNa3CXUSMPUrC1jFhOJ2jZMwJP/5S9JgbZoi030K
	o8BTazy5+G7dHi42mBp9VAfRaOp7qmUsknkBr5IpAWju2MHnBNfRG1Q35Rj2QjEw
	a6wjihN+dYq9D7g9YdPFKUIe9yLRX3z+nIyV2QTQLh7FOsfX4OqIdisD9iqQbal/
	jPuc89uDvVRSwqa1L1Wg5aH9UYExLll1yUYuPBiorg==
X-ME-Sender: <xms:AVarZtmZMBq_tMQ8ahO_uANFD4LhXP_LzNYQHx6XdmrQc_bxj1TKNA>
    <xme:AVarZo2T7BqIEc9he_L3RVTyU0-csD-QfN_IZtD9PF1nfN11fg-yIMJDP4KlAlVPN
    TpGNHz7dPjUvu3WOQ>
X-ME-Received: <xmr:AVarZjrZp0YECmKMJ0cC9ideYeToNV1YIkT_a1wrVotIs3UYmn1M4XTJHtLmiiJQuFa66RpV7hjFNmAWECElX9yt8sqvZ37v-GERMzfwwBNtGO4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epgefffedvudehjeekledvffekfefftdefudehtdegffejvdelfeevfffhffekveefnecu
    ffhomhgrihhnpehgihhtqdhstghmrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    td
X-ME-Proxy: <xmx:AVarZtkF_bQ7BLQ3JtKRWZvJ5CLa5rrTt-9P4etMBIU1cGJA__bCnA>
    <xmx:AVarZr03TDFGU8j9JRr6TIqEY4-COoNJVggyYRz_X1O9riMKR1AsPQ>
    <xmx:AVarZsslqkD1SDaTpjWlCilIfUmLnRoylZmqWllw4vY_dBuBXLogLg>
    <xmx:AVarZvUKKLr8aO_weQEw6217uJdfqt0MN3aZ3oyDat6F1f_ivn1T8g>
    <xmx:AVarZlonTMl-vMH38qch13_W8HKTimww_OcOgjRVnBEqs_SZUy-1Je8I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 05:31:43 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 848fb4a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 09:30:10 +0000 (UTC)
Date: Thu, 1 Aug 2024 11:31:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 0/3] Introduce clar testing framework
Message-ID: <ZqtV_G3ZNNFR5dDf@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <avbtyqklmtwmz63vbpevkz4xyv3dboyghwhkodxjlb3ur6zt36@afi5ptrsvpz2>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GzVJu5ELyuAZwt/G"
Content-Disposition: inline
In-Reply-To: <avbtyqklmtwmz63vbpevkz4xyv3dboyghwhkodxjlb3ur6zt36@afi5ptrsvpz2>


--GzVJu5ELyuAZwt/G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:33:55AM -0700, Josh Steadmon wrote:
> On 2024.07.31 11:04, Patrick Steinhardt wrote:
> >   - I prefer that the proposed solution results in a single binary as
> >     compared to one binary per test system.
>=20
> Does clar allow running test functions in parallel? With multiple
> binaries, we can at least run independent tests in parallel (although
> right now the unit tests are fewer and so much faster than the shell
> tests that it's hardly noticeable).

Ah, that's something I didn't think of. clar does not support running
tests in parallel.

As you say, I guess for now that is fine and I'd claim that it likely is
faster to just run all tests sequentially with a single binary if you
also include build times. If that claim isn't true, or if we eventually
grow a huge body of tests, then we should likely revert to having
separate binaries.

> As part of the original unit-test series, I wrote a comparison between
> different frameworks: Documentation/technical/unit-tests.txt, poorly
> rendered at [1]. Could you add a row to the table evaluating clar on the
> individual points there?
>=20
> [1] https://git-scm.com/docs/unit-tests#framework-selection

Ah, I wasn't aware of this document. I can update it depending on how
the discussion goes overall :)

Patrick

--GzVJu5ELyuAZwt/G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarVfsACgkQVbJhu7ck
PpRUzA//ceb3hMJ1Y1/Lf3r16MiSNk96C8FBjcFmdgMAl6IMXTU24DpiHipe9Nn1
Jx0WinJGEV+mwltZg/MlvejURfxNXHocNLgkQP0ftgov8uon5OM96nCI98t2jdUR
n/RXUU5+tE4d15q4aCXb5Dz03buJGEEj7iK3kUhlIQoBXRxnVYMn+c15AZ0dAFbi
/xuufl2coCoSJR75jhm+Oxb7K26HgSCgfKnZgvCfM/b7mAZEc3Z2UrefEahegHvt
7M0kbiNFroAUqKfrMEBEHHET56B7zSlaSMvdcsJF8c9IzaIjhmRDss6Ny5Hk6bLQ
Ub5oi6tJ/BhNQAKhNLJ3pTqhn96SG34NY7amcjOdlcubnCQIMDvzijCP3u1LBO5+
HR+uVbWSsFiwycOolTBi+wqYTYbiDYaHMdYbFsfueNb4EsjffGzmFtwll/GOP338
jxZpEotPSYjkK3zE0dOs5arkbcrGUsWt2hCidDT+0cuUBzYak/sONfjYUoEmZFNW
bVydMIJ6+DjU8dxlWHac3mGU2nJxUS/70oay7gh56xmF3Kas3oMHVkcPTXt5dd75
m0R5icKn/5W6kyPoOVq6Iya7OIcbbRD8/fSYq5zV0gSzj2O7sgOP+65L1L0sMYOX
PhYV+OpCUKtnpUhs8gW8/FRcCHd3HIRbD6EC6rYGAxLyyUhMihE=
=XPJe
-----END PGP SIGNATURE-----

--GzVJu5ELyuAZwt/G--
