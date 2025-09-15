Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568A3002C3
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933459; cv=none; b=CK77EYSCiDCpNtjcihLByzQmmjRkmv4sLfSxykKt82kA3ZiyjGQvBTi7NtIZw6DU74FChASA5ikxlEySSE/10Ec0c1OmovG/qHXn6O2j1ePbfaXPFaDhfAWDULkFDQ6HgOF6vrpjGuZVQ9KtQEC+y1Mq4KMbIlfjSEMrrT1xYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933459; c=relaxed/simple;
	bh=9WGwq+mHXA/gEqNgX+O6AQwPb+GHI0yDJtJ4NOBgTRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVnATzkga/F4owkMQS8w4wlbsLGYiuVQaWtpqAGnO0iprybs68Jzk7qjy1QBhC5O/jinVPojOz7SjsiI7I0mkbWiTlfUg5pyGTkd48G26MFeQWKSFk5W2+pgv6M6TNOHuLrqJuJSiNcf3FgrngKoWyeR58QDXaTWhN1Anxi8lIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yuqfcqxi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NTCj+2yE; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yuqfcqxi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NTCj+2yE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AA31BEC02AB;
	Mon, 15 Sep 2025 06:50:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 15 Sep 2025 06:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757933456;
	 x=1758019856; bh=81A7EXgBOly0+5H1res/0SV3Cj7eGzhK/3Z29QkNCY4=; b=
	YuqfcqxizZz4rD/OSZwj52B47O2JBCOX2V97D8Nu02F2SybSOlSCBtubDyeQMgJM
	BvZs0oEqSa0y+UGwSTZBQP7J2nmBTg/4auizS3yP8TURLl4aefwWadywiz//SR7C
	HSTOWcbVDMZFtMWGWzgBNENMNm/elQ8Yd230PNfViuWr6ti32u/4Ez4k+nxp6pQe
	NsUtFZ+uwhw092Jfy2lTOle91t9JP+jroZhW8z0P1zHFSmujRV0cdjqr4Ej6dsoN
	Zf7YUUi220uXEnpASbPJC5vRKtmq5Efy03PiTomPjGmLwNxRHCCCE49FKUVmob5L
	lgFGfElgsaLGNYOFS34NUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757933456; x=
	1758019856; bh=81A7EXgBOly0+5H1res/0SV3Cj7eGzhK/3Z29QkNCY4=; b=N
	TCj+2yEeX67MHZ6Gvkjbkq54IvzN/1p0dT8hncqhW38yUz1FDw58byEqmbaMAw1Y
	S7Qfi3SFSFSoDYCxuKrNmUzKV3E0q7KekxoTo5LtbwYnJWZsklTgdq0Y62ZXRazl
	SCR66bbjZYuvNKsIqkLtIB2MORMAkdcnFoMutqyyZ5nnXPxl+kwo65UvnYVakzn1
	JURtf/k6LEgEXZBUWT4xE2y9H8QSbQ2o2sbCP7PkrmXz/ysPb4jQzJpy0zsGP1jx
	g+Tj0/MyWzZKEZnynuw+ibJDgr+qf1FLTOn9rAXGPBDyJcYe2wLHZpgysJwp410Z
	sStkZjVKrbxKuWvSOnDyA==
X-ME-Sender: <xms:j-_HaLWH76rS9sp4pbm6xlPELelwO7CggxRMiMDhQ5jiyB9w9Hn_qA>
    <xme:j-_HaEPWqG3HYjN0mkLla5sPaC61o9vP3ns_EGU-vjsVxiEkDqfCrA6X3r2vdihZT
    X3-nuZFjx0gh0SrkQ>
X-ME-Received: <xmr:j-_HaCg8uVfwg7H0DDeK8lahCuVLY5bBffw-m1dScU-rFwL4giGYnCxmTukNjS-vSgA84ls5WIiallifzx4kI8nYAliuce4aOmZo4Hic62-3AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggv
    vhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
    dprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhopegtohhnthgrtghtsehhrg
    gtkhhtihhvihhsrdhmvg
X-ME-Proxy: <xmx:j-_HaK6XdQW2J24EJ_71CdVbUTCtpa52kL8Noybpw3v-Mi2CDmw4KA>
    <xmx:j-_HaJdIc2V5oxf9ZYtPdNwhYYZWpKvXmUrT8MtlpuojONQrUbbPJg>
    <xmx:j-_HaDAa07aKUWwde-XaF2M79rtV2zDVRqQamtUltmqezfhkl_aqog>
    <xmx:j-_HaICELyWHtT5Xk2OPkPRqsYevJK3cMF10pbsqbdNO3fmRl3nBbQ>
    <xmx:kO_HaAGc4NPJihTfNHAMwbWbkOARZYIXoFBfglROf9M5xzPEjMqKDPY0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 06:50:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6aa13342 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 10:50:51 +0000 (UTC)
Date: Mon, 15 Sep 2025 12:50:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v4 0/9] Introduce Rust and announce that it will
 become mandatory
Message-ID: <aMfvgxm_aIaf8vxG@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
 <aMRADFAoh68aWkdD@szeder.dev>
 <xmqqplbvmy11.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqplbvmy11.fsf@gitster.g>

On Fri, Sep 12, 2025 at 09:32:58AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >>  3:  ccac54a247 !  3:  873f9d82f5 Makefile: introduce infrastructure to build internal Rust library
> >>     @@ .gitignore
> >>      @@
> >>       /fuzz_corpora
> >>      +/target/
> >>     ++/Cargo.lock
> >
> > The Cargo.lock build artifact is back in .gitignore in this version of
> > the patch series, but the 'clean' target is not updated accordingly to
> > remove it.
> 
> I too noticed a leftover Cargo.lock file but was a bit too
> distracted to report it (and instead kept going with "git clean -f"
> X-<); my bad.
> 
> Thanks for being extra careful.

Ah, good catch indeed! Will fix, thanks.

Patrick
